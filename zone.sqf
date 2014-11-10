// название триггер маркер стороны время  ... сторона значение
private ["_west","_east","_domside"];

zlt_trigger = tzone1;
zlt_curSide = sideUnknown;
zlt_curPts = 0;
zlt_maxPts = 1200;
zlt_cycletime = 3.2;


zlt_timeMax = 60 *3;
zlt_timeCur = 0;


zlt_mktext1  = "До начала захвата зоны %1 мин";
zlt_mktext = "%1 контролирует зону на %2";
zlt_mname = "zone1mk";
// создание маркеров

if (!isServer) exitwith {};

createMarker [zlt_mname, (getPos tzone1)]; zlt_mname setMarkerShape "ICON"; zlt_mname setMarkerType "mil_dot";  zlt_mname setMarkerText format [zlt_mktext1, ceil ((zlt_timeMax - zlt_timeCur)/60) ];
zlt_mname setMarkerColor "ColorOrange"; zlt_mname setMarkerDir 0; zlt_mname setMarkerBrush "Solid"; zlt_mname setMarkerSize [1,1]; zlt_mname setMarkerPos (getPos tzone1);

waitUntil {!isnil "WMT_pub_frzState" && { WMT_pub_frzState >= 3}};

while {zlt_timeCur < zlt_timeMax} do {
	sleep 15;
	zlt_timeCur = zlt_timeCur + 15;
	zlt_mname setMarkerText format [zlt_mktext1, ceil ((zlt_timeMax - zlt_timeCur)/60) ];
};

zlt_mname setMarkerText format [zlt_mktext, str sideUnknown, "0 %"];

while {zlt_curPts < zlt_maxPts} do {
	sleep zlt_cycletime;
	_west = west countside list zlt_trigger;
	_east = east countside list zlt_trigger;
	//подсчитать
	_domside = sideUnknown;
	
	if (_east > _west * 3) then {
		_domside = east;
	};
	
	if (_west > _east * 3) then {
		_domside = west;
	};
	
	if (_domside != sideUnknown) then {
		if (zlt_curSide == _domside) then {
			zlt_curPts = zlt_curPts + zlt_cycletime;
		} else {
			if (zlt_curPts > 0 ) then {zlt_curPts = zlt_curPts - zlt_cycletime;} else {
				zlt_curPts = abs zlt_curPts; zlt_curSide = _domside;};
		};
		zlt_mname setMarkerColorLocal ([zlt_curSide, true] call bis_fnc_sidecolor);
		zlt_mname setMarkerText ( format [zlt_mktext, str zlt_curSide, str (round (zlt_curPts / zlt_maxPts * 100)) + " %" ] );
		
			
	};
	
};

[[[zlt_curSide, format ["%1 захватили город!", str zlt_curSide ]], {_this call WMT_fnc_EndMission;}], "bis_fnc_spawn"] call bis_fnc_mp;			

