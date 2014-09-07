
/*
в init.sqf:

if (not isDedicated) then {
	waitUntil {not isNull player};
	if (playerSide == west) then {
		[trigger1] execVM "rearea.sqf";
	};
};*/


#define MAX_TIME_OUT 30

_trigger1 = _this select 0;



if (isDedicated) exitWith {};


zlt_fnc_notify3 = {
	 [ format["<t size='0.75' color='#ffff00'>%1</t>",_this], 0,1,5,0,0,301] spawn bis_fnc_dynamicText;
};


_timeOutZone = 0;

waitUntil {sleep 0.34; time > 0};

while {alive player} do {
	if (player in list _trigger1) then {
		if (_timeOutZone != 0) then {
			_timeOutZone = 0;
			("Вы вернулись в разрешенную зону.") call zlt_fnc_notify3;

		};

	} else {
		_timeOutZone = _timeOutZone + 1;
		format ["У вас %1 сек на возвращение назад в разрешенную зону!", MAX_TIME_OUT - _timeOutZone] call zlt_fnc_notify3;
		if (_timeOutZone > MAX_TIME_OUT) then {
			hint "Вы будете расстреляны за дезертирство!";
			sleep 1.;
			player setDamage 1;

		};

	};


	sleep 1.04;

};


