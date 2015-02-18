//by [STELS]Zealot


// [hunter, ["point1","point2"], "car1"] execVM "selpoints2.sqf";


// 1 параметр - объект который устанавливается
zlt_sp_obj = _this select 0;
// 2 параметр - маркера на точки установки
zlt_sp_allowedmrkrs = _this select 1;
// 3 параметр - маркер на технику
zlt_sp_mrkend = _this select 2;


// справка, которая покажется перед выбором точки нахождения техники
zlt_sp_msghelp = "Кликните на карте в один из маркеров расположения объекта";

// сообщение для того, кто установит технику
zlt_sp_msgall = "Объект установлен";

zlt_spFormat = "<t color='#ff0000' size='2' shadow='1' shadowColor='#000000' align='center'>%1</t>";


zlt_spActionId = player addAction ["Переместить объект", {call zlt_sp_placeObj}];
zlt_sp_mrkend setMarkerAlpha 0; 

[] spawn {
	waitUntil { ((( missionNamespace getVariable ["WMT_pub_frzState",0] ) >= 3) && time > 90 ) || time > 900};
	player removeAction zlt_spActionId;
	zlt_spActionId = nil; zlt_sp_obj = nil; zlt_sp_allowedmrkrs = nil; zlt_sp_mrkend = nil; zlt_sp_msghelp = nil; zlt_sp_msgall = nil; zlt_spFormat = nil;

};


zlt_sp_placeObj = {
	sleep 0.5;
	zlt_mutexAction = true;
	hintSilent "";
	sleep 0.05;
	hint parseText format [zlt_spFormat,zlt_sp_msghelp];
	sleep 0.05;
	openMap true;
	onMapSingleClick {
		private ["_closestPoints", "_point"];
		_closestPoints = [zlt_sp_allowedmrkrs,[_pos],{_input0 distance (getMarkerPos _x)},"ASCEND"] call BIS_fnc_sortBy;
		_point = _closestPoints select 0;
		onMapSingleClick {};
		_point spawn {
			sleep 0.1;
			zlt_sp_obj setPos (getMarkerPos _this);
			zlt_sp_obj setDir (markerDir _this);
			zlt_sp_mrkend setMarkerPos (getMarkerPos _this);
		};
		
		hint parseText format [zlt_spFormat,zlt_sp_msgall];

		[
			[
				[  zlt_sp_mrkend, getMarkerPos _point],
				{
					(_this select 0) setMarkerPosLocal (_this select 1); (_this select 0) setMarkerAlphaLocal 1;
				} 
			],"bis_fnc_spawn", playerSide
		] call bis_fnc_mp;
		openMap false;
		zlt_mutexAction = false;
		true
	};

	waitUntil {not visibleMap};
	if (zlt_mutexAction) then {
		hintSilent "";
		sleep 0.05;
		hint parseText format [zlt_spFormat,"Установка отменена!"];
		onMapSingleClick {};
	};

};