
/*
запускать из init.sqf:

if (not isDedicated) then {
	waitUntil {not isNull player};
	if (playerSide == west) then {
		[[trigger1],[trigger2,trigger3], true] execVM "rearea.sqf";
	};
};*/


#define MAX_TIME_OUT 15
if (isDedicated) exitWith {};

// триггеры в которых должен находиться человек

// 1 - триггеры разрешенной зоны
zlt_ra_allowed =  _this select 0;
// 2 - триггеры запрещенной зоны
zlt_ra_restricted =  _this select 1;
// 3 - true если разрешенные зоны имеют больший приоритет
zlt_ra_priority =  _this select 2;


zlt_fnc_notify3 = {
	 [ format["<t size='0.75' color='#ffff00'>%1</t>",_this], 0,1,5,0,0,301] spawn bis_fnc_dynamicText;
};

// возвращает True в безопасной зоне
zlt_check_cond = {
	_ret = true;
	private ["_zones","_return"];
	if (zlt_ra_priority) then {_zones = [zlt_ra_restricted,zlt_ra_allowed]; _return = [false,true]; } else {_zones = [zlt_ra_allowed, zlt_ra_restricted]; _return = [true, false];};
	{
		if ((vehicle player) in list _x) then {_ret = (_return select 0)};
	} foreach (_zones select 0);
	{
		if ((vehicle player) in list _x) then {_ret = (_return select 1)};
	} foreach (_zones select 1);
	_ret
};


_timeOutZone = 0;

waitUntil {sleep 0.34; time > 0};

while {alive player} do {
	if ([] call zlt_check_cond) then {
		if (_timeOutZone != 0) then {
			_timeOutZone = 0;
			("Вы вернулись в безопасную зону.") call zlt_fnc_notify3;

		};

	} else {
		_timeOutZone = _timeOutZone + 1;
		format ["У вас %1 сек на возвращение назад в безопасную зону!", 0 max (MAX_TIME_OUT - _timeOutZone)] call zlt_fnc_notify3;
		if (_timeOutZone > MAX_TIME_OUT) then {
			hint "Вас расстрелял боевой вертолет врага!";
			sleep 1.;
			player setDamage 1;

		};

	};


	sleep 0.64;

};


