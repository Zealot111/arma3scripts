
/*
запускать из init.sqf:

if (not isDedicated) then {
	waitUntil {not isNull player};
	if (playerSide == west) then {
		[[trigger1],[trigger2,trigger3], true, false] execVM "rearea.sqf";
	};
};*/


#define MAX_TIME_OUT 20
#define CYCLE_TIME 1.24
if (isDedicated) exitWith {};

// триггеры в которых должен находиться человек

private ["_zlt_ra_allowed","_zlt_ra_restricted","_zlt_ra_priority","_zlt_ra_air","_zlt_check_cond"];

// 1 - триггеры разрешенной зоны
_zlt_ra_allowed =  [_this,0,true,[],[[]]] call bis_fnc_param;
// 2 - триггеры запрещенной зоны
_zlt_ra_restricted =  [_this,1,true,[],[[]]] call bis_fnc_param;
// 3 - true если разрешенные зоны имеют больший приоритет
_zlt_ra_priority =  [_this,2,true,[false]] call bis_fnc_param;
// 4 - true если нужно проверять для воздушной техники тоже
_zlt_ra_air = [_this,3,false,[false]] call bis_fnc_param;



_zlt_fnc_notify3 = {
	 [ format["<t size='0.75' color='#ffff00'>%1</t>",_this], 0,1,5,0,0,301] spawn bis_fnc_dynamicText;
};

// возвращает True в безопасной зоне
_zlt_check_cond = {
    private ["_zlt_ra_allowed","_zlt_ra_restricted","_zlt_ra_priority","_zlt_ra_air"];
	_ret = true;
    _zlt_ra_allowed=_this select 0; _zlt_ra_restricted=_this select 1; _zlt_ra_priority = _this select 2; _zlt_ra_air = _this select 3;
	if (!_zlt_ra_air && {!(isTouchingGround (vehicle player))}) exitWith {_ret};
	private ["_zones","_return"];
	if (_zlt_ra_priority) then {_zones = [_zlt_ra_restricted,_zlt_ra_allowed]; _return = [false,true]; } else {_zones = [_zlt_ra_allowed, _zlt_ra_restricted]; _return = [true, false];};
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
	if ([_zlt_ra_allowed,_zlt_ra_restricted,_zlt_ra_priority,_zlt_ra_air] call _zlt_check_cond) then {
		if (_timeOutZone != 0) then {
			_timeOutZone = 0;
			("Вы вернулись в безопасную зону.") call _zlt_fnc_notify3;

		};

	} else {
		_timeOutZone = _timeOutZone + CYCLE_TIME;
		format ["У вас %1 сек на возвращение назад в безопасную зону!",[0 max (MAX_TIME_OUT - _timeOutZone),"MM:SS"] call BIS_fnc_secondsToString] call _zlt_fnc_notify3;
		if (_timeOutZone > MAX_TIME_OUT) then {
			hint "Вас расстрелял боевой вертолет врага!";
			sleep 1.;
			player setDamage 1;

		};

	};


	sleep CYCLE_TIME;

};


