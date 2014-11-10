// by [STELS]Zealot

#define TIME_INTERVAL 60
#define MSG_OBJECT "Объекты обнаружены!"


zlt_mrk_objs = _this;


zlt_fnc_createMrkr = { private ["_mrkr","_txt"]; _mrkr = _this select 0;_txt = _this select 1;createMarkerLocal [_mrkr, [0,0]]; /*zlt_marker setMarkerPosLocal (getPos zlt_mrk_obj);*/ _mrkr setMarkerShapeLocal "ICON";_mrkr setMarkerTypeLocal 	"mil_dot";_mrkr setMarkerTextLocal 	_txt;_mrkr setMarkerColorLocal "ColorOrange";_mrkr setMarkerDirLocal 0; /*(getDir _x);*/	_mrkr setMarkerBrushlocal "Solid";_mrkr setMarkerSizelocal[1,1];_mrkr setMarkerAlphaLocal 0;	_mrkr};

{
	_mn = "zlt_mrkr!" + str(_foreachindex);
	[_mn, "Объект "+str(_foreachindex+1)] call zlt_fnc_createMrkr;
} foreach zlt_mrk_objs;

zlt_fnc_drawMapMarker = {
	if (not hasInterface) exitWith {};

	hintSilent MSG_OBJECT;
	{
		_mn = "zlt_mrkr!" + str(_foreachindex);
		_mn setMarkerPosLocal (getPos _x);
		_mn setMarkerAlphaLocal 1;
	} foreach zlt_mrk_objs;
};


if (isServer) then {

	waitUntil {sleep 0.43; time > 0};
	while {true} do {
		sleep TIME_INTERVAL;
		[ [ [], {_this call zlt_fnc_drawMapMarker;}], "bis_fnc_spawn"] call bis_fnc_mp;			

	  
	};
};