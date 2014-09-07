// by [STELS]Zealot

#define MIN_ASL_HEIGHT_RADAR 50

if (not hasInterface) exitWith {};


zlt_radarObjects = [];
zlt_radarMarkers = [];

waitUntil {sleep 0.78; time > 1};

{
	if (_x isKindOf "Air") then { 
		zlt_radarObjects pushback _x;
	};
} foreach vehicles;


while {alive player} do {
	while {visibleMap} do {
		_objsToDelete = [];
		{
			_vehNetId = netId _x;
			_mname = "zlt_rdr"+ "!" +_vehNetId;
			if ( not alive _x ) then {
				_objsToDelete pushback _x;
				if (_mname in zlt_radarMarkers) then {
					zlt_radarMarkers = zlt_radarMarkers - [_mname];
					deleteMarkerLocal _mname;
				};
			} else {
				if (not (_mname in zlt_radarMarkers)) then {
					zlt_radarMarkers pushback _mname;

					createMarkerLocal [_mname, getPos _x];
					_mname setMarkerPosLocal (getPos _x);
					_mname setMarkerShapeLocal "ICON";
					_mname setMarkerTypeLocal 	"b_air";
					_mname setMarkerTextLocal 	getText (configFile >> "CfgVehicles" >> typeOf _x >> "Displayname");
					_mname setMarkerColorLocal "ColorOrange";
					_mname setMarkerDirLocal 0; // 	(getDir _x);
					_mname setMarkerBrushlocal "Solid";
					_mname setMarkerSizelocal 	[1,1];
				};
				if ( (getPosASL _x) select 2 > MIN_ASL_HEIGHT_RADAR) then {
//					_mname setMarkerDirLocal (getDir _x);
					_mname setMarkerAlphaLocal 1;
					_mname setMarkerPosLocal (getPos _x);
				} else {
					_mname setMarkerAlphaLocal 0;

				};

			};

		} foreach zlt_radarObjects;
		zlt_radarObjects = zlt_radarObjects - _objsToDelete; 
		sleep 0.71;
	};

	sleep 0.76;

};
