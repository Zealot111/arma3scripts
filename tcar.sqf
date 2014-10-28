zlt_fnc_notify3 = { [ format["<t size='0.75' color='#ffff00'>%1</t>",_this], 0,1,0.5,0,0,301] spawn bis_fnc_dynamicText;};

#define CHECK_TIME 0.1

tbox_alive = true;

car1alive = true;
car2alive = true;

car1outofzone = 0;
car2outofzone = 0;

sleep 5;

while {tbox_alive || car1alive || car2alive} do {
	sleep CHECK_TIME;

	if (tbox_alive) then {
		if (!alive tbox) then {
			tbox_alive = false;
			[west, "Ящики уничтожены!",["box"]] call wmt_fnc_ZoneCaptured;
		};

	};
		
	if (car1alive) then {
		if ( !(mrap1 in list tzone1)) then {
			if (car1outofzone == 0) then {
				hintSilent "MRAP1 вышел за зону! У него есть 30сек на возвращение.";
			};

			car1outofzone = car1outofzone + CHECK_TIME;
			if (hasInterface) then {
				if (player == driver mrap1) then {
					format ["У вас есть %1 сек на возвращение в зону!",0 max round (30 - car1outofzone) ] call zlt_fnc_notify3;
				};
			};

			if (car1outofzone > 30) then {
				car1alive = false;
			};

		} else {
			if (car1outofzone != 0) then {
				hintSilent "MRAP1 вернулся в зону!";
				car1outofzone = 0;
			};
		};
		if (!alive mrap1 || !car1alive) then {
			car1alive = false;
			[west, "MRAP 1 уничтожен или вышел за зону!",["mrap1"]] call wmt_fnc_ZoneCaptured;
		};
	};
	if (car2alive) then {
		if ( !(mrap2 in list tzone1)) then {
			if (car2outofzone == 0) then {
				hintSilent "MRAP2 вышел за зону! У него есть 30сек на возвращение.";
			};

			car2outofzone = car2outofzone + CHECK_TIME;
			if (hasInterface) then {
				if (player == driver mrap2) then {
					format ["У вас есть %1 сек на возвращение в зону!",0 max round (30 - car2outofzone) ] call zlt_fnc_notify3;
				};
			};

			if (car2outofzone > 30) then {
				car2alive = false;
			};
		} else {
			if (car2outofzone != 0) then {
				hintSilent "MRAP2 вернулся в зону!";
				car2outofzone = 0;
			};
		};
		if (!alive mrap2 || !car2alive) then {
			car2alive = false;
			[west, "MRAP 2 уничтожен или вышел за зону!",["mrap2"]] call wmt_fnc_ZoneCaptured;
		};
	};
};

[west, "Украденное у НАТО обороудование было уничтожено!"] call wmt_fnc_endmission;