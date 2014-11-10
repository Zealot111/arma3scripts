//by [STELS]Zealot
zlt_telemarkers = [_this, 0, [] ] call bis_fnc_param;
zlt_uarray = [_this, 1, [units group player] ] call bis_fnc_param;

zlt_tlFormat = "<t color='#ff0000' size='2' shadow='1' shadowColor='#000000' align='center'>%1</t>";
// время после начала игры, по истечении которого нельзя будет ничего установить
zlt_tlMaxTime = 300;


if (time > zlt_tlMaxTime ) exitWith {
	hint parseText format [zlt_tlFormat,"Время перемещений прошло!"];
};

zlt_fnc_findposRoad = {
	private['_pos','_size','_res','_roads','_next','_nearStuff','_road'];
	_pos = _this select 0;
	_size = _this select 1;
	_res = _pos;
	diag_log ["zlt_fnc_findposRoad", _this];
	_roads = _pos nearRoads 100;
	_roads = [_roads,[_pos],{_input0 distanceSqr _x},"ASCEND"] call BIS_fnc_sortBy;	
	_next = 0;
	_nearStuff = ['dummy'];
	while {count _nearStuff !=0 && _next < count _roads} do {
		_road = _roads select _next;
		_nearStuff = nearestObjects [getpos _road, ["LandVehicle","Air","Ship","Man"], _size+1];
		if (count _nearStuff == 0) then {_res = getpos _road;};
		_next = _next + 1;
	};
	diag_log ["zlt_fnc_findposRoad3", _res, _next, _nearStuff];
	_res
};

zlt_mutexAction = false;

// массив [юниты, техника, [массив техники]]
zlt_fnc_teleport = {
	private ["_pos","_objs","_dir","_posx","_marker","_txt"];
	_pos = _this select 0;
	_dir = _this select 1;
	_objs = _this select 2;
	_marker = _this select 3;
	{
		_pos = [_pos, 5] call zlt_fnc_findposRoad;
		switch true do {
			case (typeName _x == typeName []) : {
				_posx = _pos;
				_txt = format [zlt_tlFormat, format ["Вы были перенесены на точку %1 командиром отряда!", markerText _marker]];
				{
					if (_x isKindOf "Quadbike_01_base_F") then {
						_posx = [ (_pos select 0) +  round (_foreachindex / 2) * 3, (_pos select 1) + (_foreachindex % 2)*3, _pos select 2];
					} else {
						_posx = [ (_pos select 0) +  round (_foreachindex / 3) * 1.5, (_pos select 1) + (_foreachindex % 3)*1.5, _pos select 2];
					};
					[[ [_x,_posx,_dir, _txt] ,{
						if (!isDedicated) then {wmt_freeze_startpos = (_this select 1);
						"PlayerFreeze" setMarkerPosLocal (_this select 1); hint parseText (_this select 3);};
						(_this select 0) setpos (_this select 1);
						(_this select 0) setDir (_this select 2);
					}],"bis_fnc_spawn",_x] call bis_fnc_mp;
					//"Sign_Sphere100cm_F" createVehicle _posx;
					diag_log ['zlt_fnc_teleport',_pos, _posx];
				} foreach _x;
			};
			case (typename _x == typename objNull) : {
				diag_log ['zlt_fnc_teleport2',_pos];
				[[ [_x,_pos,_dir] ,{(_this select 0) setpos (_this select 1); (_this select 0) setDir (_this select 2);}],"bis_fnc_spawn",_x] call bis_fnc_mp;
			};
		};
		_pos = [_pos, 25, _dir] call BIS_fnc_relPos;
		sleep 0.3;
	} foreach _objs;
};

zlt_fnc_tel = {
	zlt_mutexAction = true;
	sleep 0.5;
	hint parseText format [zlt_tlFormat,"Выберите позицию:"];
	sleep 0.05;
	openMap true;
	sleep 0.05;
	onMapSingleClick {
		private ["_closestPoints", "_point","_dir","_pos"];
		_closestPoints = [zlt_telemarkers,[_pos],{_input0 distanceSqr (getMarkerPos _x)},"ASCEND"] call BIS_fnc_sortBy;
		_point = _closestPoints select 0;

		_pos = markerPos _point;
		_dir = markerDir _point;
		onMapSingleClick {};
//		hint parseText format [zlt_tlFormat,"Позиция выбрана"];
		[_pos, _dir, zlt_uarray, _point] call zlt_fnc_teleport;
		zlt_mutexAction = false;	
		openMap false;
		true
	};
	waitUntil {not visibleMap};
	if (zlt_mutexAction) then {
		hintSilent "";
		sleep 0.05;
		hint parseText format [zlt_tlFormat,"Установка отменена!"];
		onMapSingleClick {};
		zlt_mutexAction = false;

	};
};

zlt_teleMenuId = player addAction ["ВЫБРАТЬ ТОЧКУ СТАРТА", {[] spawn zlt_fnc_tel}, [], -1, false, true, "", '!zlt_mutexAction'];
waitUntil {time > zlt_tlMaxTime && WMT_pub_frzState >=3};
player removeAction zlt_teleMenuId;
zlt_teleMenuId = nil;
zlt_telemarkers = nil;
zlt_uarray = nil;
zlt_tlFormat = nil;
zlt_tlMaxTime = nil;
zlt_fnc_findposRoad = nil;
zlt_fnc_teleport = nil;
zlt_fnc_tel = nil;