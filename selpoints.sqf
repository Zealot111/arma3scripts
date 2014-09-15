//by [STELS]Zealot



// настройки

// объект который собственно перемещаем
zlt_sp_obj = arta1;

// справка, которая покажется перед выбором точки нахождения техники
zlt_sp_msghelp = "Кликните на карте точку установки техники:";

// маркера, на которых можно установить технику
zlt_sp_allowedmrkrs = ["mrk1","mrk2","mrk3","mrk4","mrk5"];

// сообщение для всех после установки объекта
zlt_sp_msgall = "Артиллерия установлена на точке: %1";

// уже существующий глобальный маркер на объект, который установится на точное его положение у всех
zlt_sp_mrkend = "mrk_arta";

// максимальное кол-во попыток установки (для каждого игрока)
zlt_sp_maxtries = 500;

// время после начала игры, по истечении которого нельзя будет ничего установить
zlt_spMaxTime = 9000;


zlt_spFormat = "<t color='#ff0000' size='2' shadow='1' shadowColor='#000000' align='center'>%1</t>";



/////////       КОД /////////////////////////////
if (isNil "zlt_spTries") then {zlt_spTries = 0;};

if (zlt_spTries >= zlt_sp_maxtries) exitWith {
	hint parseText format [zlt_spFormat,"Достигнуто максимальное число попыток установки!"];
};

if (time > zlt_spMaxTime) exitWith {
	hint parseText format [zlt_spFormat,"Время перемещений прошло!"];
};

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

	zlt_spTries = zlt_spTries + 1;

	_point spawn {
		sleep 0.1;
		zlt_sp_obj setPos (getMarkerPos _this);
		zlt_sp_obj setDir (markerDir _this);
		zlt_sp_mrkend setMarkerPos (getMarkerPos _this);
	};
	
	[
		[
			[ format [zlt_spFormat,format [zlt_sp_msgall, markerText _point]]],
			{
				hint parseText (_this select 0);
			} 
		],"bis_fnc_spawn"
	] call bis_fnc_mp;

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

