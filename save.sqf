txt = "";
_br = tostring [13,10];
txt = txt + "_unit = _this select 0;" + _br;
txt = txt + "_side = _this select 1;" + _br;
txt = txt + "_set = _this select 2;" + _br;
txt = txt + "if (!local _unit) exitwith {};" + _br;
txt = txt + "switch true do {" + _br;


loads = [];
{

	_ld = _x getvariable ["LD", ""];
	_fa = _x getvariable ["FA", ""];
	if (_fa != "" ) then {
		ld = [_fa, _ld];
		diag_log [ld, loads, str _x];
		if !(ld in loads) then {
		loads pushback ld;

		txt = txt + ( "case ( _set == """ +  _ld + """ && ");
		txt = txt + ( " _side== """ + _fa + """):{") + _br;
		txt = txt + ([_x,"script",false] call bis_fnc_exportInventory);
		txt = txt + "};" + _br;
		};
	};
} foreach (allunits);

txt = txt + "};" + _br;

copytoclipboard txt;