if (isDedicated) exitWith {};
waitUntil {player == player};

if (isNil "zlt_playersbags") then {
	zlt_playersbags = [];
};
if (isNil "zlt_mutex_action") then {
	zlt_mutex_action = false;
};

zlt_fnc_notifytxt = {
	[format["<t size='0.75' color='#0353f5'>%1</t>", _this], 0, 0.75*safezoneH + safezoneY, 5, 0, 0, 301] spawn bis_fnc_dynamicText;
};

zlt_fnc_doit = {
	diag_log "doit";
	zlt_mutex_action	= true;
	_length 			= 0;
	_startPos			= getPos player;
	_action 			= false;
	
	while {(alive player) and ((player distance _startPos) < 0.4) and (vehicle player == player) and (not _action) and zlt_mutex_action} do {
		if (180 <= _length) exitWith {_action = true;};
		_length = _length + 0.5;
		player playMove "AinvPknlMstpSlayWrflDnon_medic";
		( format ["До конца постройки %1 сек.",round (180 - _length)] ) call zlt_fnc_notifytxt;
		sleep 0.5;
	};
	zlt_mutex_action = false;
	if (_action) then {
		"Постройка завершена!" call zlt_fnc_notifytxt;
		call zlt_fnc_makebag;
		
	} else {
		"Постройка отменена" call zlt_fnc_notifytxt;
	};
}; 


zlt_fnc_makebag = {
//	deleteVehicle zlt_curr_bag ;
	cpos = [getposatl player, 1, getdir player ] call BIS_fnc_relPos;
	zlt_curr_bag = "Land_BagFence_Round_F" createVehicle (  cpos );
	zlt_curr_Bag setdir (getdir player-180);
	zlt_curr_Bag setposatl [ cpos select 0, cpos select 1, -0.1];
	zlt_curr_bag setVectorUp (surfaceNormal cpos);
	zlt_playersbags pushback zlt_curr_bag;
};


player addAction ["Построить укрепление", {[] spawn zlt_fnc_doit}, [], -1, false, true, "", '!zlt_mutex_action && count zlt_playersbags < 3'];
player addAction ["Отменить действие", {zlt_mutex_action = false}, [], 15, false, true, "", 'zlt_mutex_action'];