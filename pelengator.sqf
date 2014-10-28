
// by [STELS]Zealot
if (isDedicated) exitWith {};

zlt_filter = {
	private ["_res","_txt"]; _res = []; _code = _this select 1;
	{if (call _code) then { _res pushBack _x}; } foreach (_this select 0);
	_res
};

zlt_inpeleng = false;

zlt_peleng = {
	private ["_arr","_obj","_dir","_dirText","_dist"];
	hint "Сканирование частот. Ожидайте.";
	zlt_inpeleng = true;

	sleep 30;
	_arr = [mrap1, mrap2, tbox];
	_arr = [_arr, {alive _x and ((player distance _x) < 500)}] call zlt_filter;
	_arr = [_arr,[player],{_input0 distanceSqr _x},"ASCEND"] call BIS_fnc_sortBy;	
	if (count _arr > 0) then {
		_obj = _arr select 0;
		_dir = [player,_obj] call BIS_fnc_dirTo;
		_dirText = ["С","СВ","В","ЮВ","Ю","ЮЗ", "З","СЗ"] select round (_dir / 45);
		_dist = 5 - round ((_obj distance player) / 100);

		hint parseText format ["<t color='#ff0000' size='1,5' shadow='1' shadowColor='#000000' align='center'>Направление: %1<br/>Сигнал: %2/5</t>",_dirText,_dist];
		_soundPath = [(str missionConfigFile), 0, -15] call BIS_fnc_trimString;
		_soundToPlay = _soundPath + "blip.ogg";
		playSound3D [_soundToPlay, player, false, getPosASL player, 10, 1, 5]; 


	} else {
		hint "Нет сигнала!";
	};
	zlt_inpeleng = false;
};

while {alive player} do {
	sleep 1.5;
	


	if (isNil "zlt_pelengMenuId") then {
		if ((vehicle player == player) && ((backpack player) in ['tf_rt1523g', 'tf_rt1523g_big', 'tf_rt1523g_sage', 'tf_rt1523g_green', 'tf_rt1523g_fabric', 'tf_rt1523g_black']) ) then {
			zlt_pelengMenuId = player addAction ["Запустить пеленгатор", {[] spawn zlt_peleng}, [], -1, false, true, "", '!zlt_inpeleng'];
		};
	} else {
		if (vehicle player != player || !((backpack player) in ['tf_rt1523g', 'tf_rt1523g_big', 'tf_rt1523g_sage', 'tf_rt1523g_green', 'tf_rt1523g_fabric', 'tf_rt1523g_black'])) then {
			player removeaction zlt_pelengMenuId;
			zlt_pelengMenuId = nil;
		};
	};
};