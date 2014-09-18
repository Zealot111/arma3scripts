// v.1.0 by [STELS]Zealot

#define PR(x) private ['x']; x
#define PARAM(X,Y,Z) private ['X']; X=[_this, Y, Z] call BIS_fnc_param;

_filenames = _this;

zlt_fnc_interpretatePseudoCode1 = {
	PARAM(_array, 0, [])
	PARAM(_parentObj, 1, objNull)
	PARAM(_parentdir, 2, 0)
	PARAM(_parentpitch, 3, 0)
	PARAM(_parentbank, 4, 0)
	private ["_obj","_pos","_dir","_pitch","_bank"];
	if (isNil "zlt_new_blocks") then {zlt_new_blocks=[];};
	{
//		diag_log _x;
		if (typeName _x == typeName 1 and {_x - 1 > 0.5}) exitWith {diag_log "Версия файла построек не поддерживается"};
		if (typeName _x == typeName [] and {(not isDedicated) or (_x select 5)}) then {
			if (isNull _parentObj) then {
				_pos = (_x select 1);
				_dir = (_x select 2);
				_pitch = (_x select 3);
				_bank = (_x select 4);
			} else {
				_pos = _parentObj modelToWorld (_x select 1);
				_dir = (_x select 2) + _parentdir;
				_pitch = (_x select 3) + _parentpitch;
				_bank = (_x select 4) + _parentbank;
			};

			if (_x select 5) then {
				_obj =  createVehicle [(_x select 0), _pos, [], 0, "CAN_COLLIDE"];
			} else {
				_obj = (_x select 0) createVehicleLocal _pos;
			};
			if (not isNull _parentObj) then {
				_obj setVariable ["zlt_new_masterblock", _parentObj];
				_childblocks = _parentObj getVariable ["zlt_new_childblocks",[]];
				_childblocks pushback _obj;
				_parentObj setVariable ["zlt_new_childblocks", _childblocks];
			};
			_obj setDir _dir;
			_obj setPosATL _pos;
			[_obj, _pitch, _bank] call BIS_fnc_setPitchBank;

			if (_x select 7) then {	_obj allowdamage false; };
			if (_x select 6) then { _obj enableSimulation false; };
			zlt_new_blocks pushback _obj;
			zlt_new_lastblock = _obj;
			if (count _x > 9 and {count (_x select 9) > 0}) then {
				_obj setVariable ["zlt_new_decl", (_x select 9)];
				_obj setVariable ["zlt_new_childblocks", []];
				[_x select 9, _obj, _dir, _pitch, _bank] call zlt_fnc_interpretatePseudoCode1;
			};
		};
	} foreach _array;
};

zlt_fnc_boundingbox = { 
	private ["_dir","_pos","_color","_alpha","_bbox","_b1","_b2","_bbx","_bby","_marker"];
	if(!hasInterface)exitWith{};
	_bbox = [_this, 0] call BIS_fnc_param;
	_dir = [_this, 1] call BIS_fnc_param;
	_pos = [_this, 2] call BIS_fnc_param;
	_color = [_this, 3, "ColorBlack"] call BIS_fnc_param;
	_alpha = [_this, 4, 1.0] call BIS_fnc_param;
	if (isnil "zlt_bb_id") then { zlt_bb_id = 0; };
	_b1 = _bbox select 0;
	_b2 = _bbox select 1;
	_bbx = (abs(_b1 select 0) + abs(_b2 select 0));
	_bby= (abs(_b1 select 1) + abs(_b2 select 1));
	_marker = createmarkerlocal [ format [ "WMT_BundingBoxMarker_%1",zlt_bb_id ], _pos ];
	zlt_bb_id = zlt_bb_id + 1;
	_marker setmarkerdir _dir;
	_marker setmarkershapelocal "rectangle";
	_marker setmarkersizelocal 	[_bbx/2,_bby/2];
	_marker setmarkercolor	_color;
	_marker setmarkeralphalocal _alpha;	_marker ;
};


if (typename _this != typename []) exitwith {};

PR(_arraysWithData) = [];

// чтение файлов

{
	_arraysWithData pushback (call compile loadFile _x);
} foreach _filenames;

//diag_log _filenames;

// брифинг 
if (not isDedicated) then {
	PR(_currentArray) = [];
	{
		_currentArray = _x;
		{
			if ( typeName _x == typeName [] and {count (_x select 8) != 0} ) then {
				(_x select 8) call zlt_fnc_boundingbox;
			};
		} foreach _currentArray;
	} foreach _arraysWithData;
};



// после старта игры1111
waituntil {sleep 0.35; time > 0};

PR(_currentArray) = [];
{
	[_x] call zlt_fnc_interpretatePseudoCode1;
} foreach _arraysWithData;

