// FIX над водой камера поднимается

zlt_units = {
	private "_res"; _res = [];
	if (typeName _this == typeName "") then {_res = getArray (configfile >> "cfgPatches" >> _this >> "Units")} else {
		{_res=_res +  getArray (configfile >> "cfgPatches" >> _x >> "Units")} foreach _this;
	};
	_res;
};

zlt_filter = {
	private ["_res","_txt"]; _res = []; _code = _this select 1;
	{if (call _code) then { _res pushBack _x}; } foreach (_this select 0);
	_res
};

// https://community.bistudio.com/wiki/Arma_3_CfgPatches_CfgVehicles

zlt_obj_list_index = 0;
zlt_obj_list_all = [
	['A3_Structures_F_Mil_Fortification','A3_Structures_F_Mil_BagBunker','A3_Structures_F_Mil_BagFence',"A3_Structures_F_Mil_Shelters"] call zlt_units
	,[["A3_Structures_F_Mil_Cargo","A3_Structures_F_Mil_Radar","A3_Structures_F_Mil_Offices","A3_Structures_F_Mil_Barracks","A3_Structures_F_Mil_Bunker","A3_Structures_F_Mil_TentHangar","A3_Structures_F_Research"] call zlt_units, { not (["ruins", _x] call bis_fnc_instring) }] call zlt_filter
	,["A3_Structures_F_Walls"] call zlt_units
	,["A3_Structures_F_Training" call zlt_units, { (["shoot_house", _x] call bis_fnc_instring) or (["obstacle", _x] call bis_fnc_instring) or (["concrete", _x] call bis_fnc_instring) }] call zlt_filter
	,["A3_Structures_F_Civ_Constructions","A3_Structures_F_EPA_Civ_Constructions","A3_Structures_F_Civ_Camping"] call zlt_units
	,(["A3_Structures_F_Items_Documents","A3_Structures_F_Items_Electronics","A3_Structures_F_Items_Cans","A3_Structures_F_Items_Gadgets","A3_Structures_F_Items_Luggage","A3_Structures_F_Items_Stationery","A3_Structures_F_Items_Tools","A3_Structures_F_Items_Valuables","A3_Structures_F_EPA_Items_Electronics","A3_Structures_F_EPA_Items_Food","A3_Structures_F_EPA_Items_Medical","A3_Structures_F_EPA_Items_Tools","A3_Structures_F_EPA_Items_Vessels","A3_Structures_F_EPC_Items_Documents","A3_Structures_F_EPC_Items_Electronics"] call zlt_units)
	,[["A3_Structures_F_Households_Addons","A3_Structures_F_Households_House_Big01",'A3_Structures_F_Households_House_Big02','A3_Structures_F_Households_House_Shop01','A3_Structures_F_Households_House_Shop02', 'A3_Structures_F_Households_House_Small01', 'A3_Structures_F_Households_House_Small02', 'A3_Structures_F_Households_House_Small03', 'A3_Structures_F_Households_Slum', 'A3_Structures_F_Households_Stone_Big', 'A3_Structures_F_Households_Stone_Shed', 'A3_Structures_F_Households_Stone_Small', 'A3_Structures_F_Households_WIP','A3_Structures_F_Ind_AirPort' ] call zlt_units,{ not (["ruins", _x] call bis_fnc_instring)  and not (["_dam_", _x] call bis_fnc_instring) and not (["_d_", _x] call bis_fnc_instring) } ] call zlt_filter
	,(["A3_Structures_F_Naval_Piers","A3_Structures_F_Naval_RowBoats"] call zlt_units)
	,["Land_Bench_F","Land_CashDesk_F","Land_HeatPump_F","Land_ChairPlastic_F","Land_ChairWood_F","Land_Icebox_F","Land_Metal_rack_F","Land_Metal_rack_Tall_F","Land_Metal_wooden_rack_F","Land_Rack_F","Land_ShelvesMetal_F","Land_ShelvesWooden_F","Land_TableDesk_F"]
	,["A3_Structures_F_EPB_Furniture","A3_Structures_F_Furniture","A3_Structures_F_Items_Vessels", "A3_Structures_F_EPA_Civ_Camping","A3_Structures_F_EPB_Items_Vessels"] call zlt_units
	,["A3_Structures_F_Civ_InfoBoards","A3_Structures_F_EPC_Civ_InfoBoards","A3_Signs_F","A3_Signs_F_AD","A3_Structures_F_EPB_Civ_Accessories","A3_Structures_F_EPC_Civ_Accessories"] call zlt_units
	,["Land_fort_rampart_EP1","Land_fort_rampart","Hedgehog","Misc_cargo_cont_small","TK_GUE_WarfareBUAVterminal_Base_EP1","TK_GUE_WarfareBArtilleryRadar_Base_EP1","TK_GUE_WarfareBAntiAirRadar_Base_EP1","Fort_Barricade","Land_fort_artillery_nest_EP1","Land_fort_artillery_nest","Hhedgehog_concrete","Hhedgehog_concreteBig","Barrack2","PowGen_Big","Land_Misc_Cargo1E_EP1","Land_BarGate2","Land_tent_east","CampEast_EP1","Land_GuardShed","Land_Antenna","Land_A_Villa_EP1","Land_Mil_Barracks_i_EP1"]
	,["A3_Structures_F_Dominants_Hospital", "A3_Structures_F_EPC_Dominants_GhostHotel"] call zlt_units
	,(["A3_Structures_F_Civ_Garbage","A3_Structures_F_EPA_Mil_Scrapyard","A3_Structures_F_Wrecks","A3_Structures_F_EPB_Civ_Garbage"] call zlt_units)+["Submarine_01_F"]
];

zlt_obj_list = zlt_obj_list_all select zlt_obj_list_index;
zlt_cur_class = zlt_obj_list select 0;	


zlt_new_10cmfix = ["Land_BagBunker_Large_F", "Land_BagBunker_Small_F", "Land_BagBunker_Tower_F","Land_BagFence_Corner_F", "Land_BagFence_End_F", "Land_BagFence_Long_F", "Land_BagFence_Round_F","Land_BagFence_Short_F","Land_HBarrier_1_F", "Land_HBarrier_3_F", "Land_HBarrier_5_F",  "Land_HBarrierTower_F","Land_HBarrierWall_corner_F", "Land_HBarrierWall_corridor_F", "Land_HBarrierWall4_F", "Land_HBarrierWall6_F",
"Land_CncWall1_F","Land_CncBarrierMedium4_F", "Land_CncWall4_F", "Land_Mil_WallBig_4m_F"
];

zlt_new_5cmfix = ["Land_CncShelter_F"];
zlt_new_15cmfix = ["Land_CncBarrierMedium4_F"];

// -------------------------------------------------- НОВОЕ -----------------------------------------------------------------------------------
// лок объекты + отключены повреждения
zlt_localObjectsClasses = 
	([['A3_Structures_F_Mil_Fortification','A3_Structures_F_Mil_BagBunker','A3_Structures_F_Mil_BagFence'] call zlt_units, { not (["razor", _x] call bis_fnc_instring) }] call zlt_filter)
	+(["A3_Structures_F_Civ_Garbage","A3_Structures_F_EPA_Mil_Scrapyard","A3_Structures_F_Wrecks"] call zlt_units)
	+(['A3_Structures_F_Mil_Fortification','A3_Structures_F_Mil_BagBunker','A3_Structures_F_Mil_BagFence'] call zlt_units)
	+(["A3_Structures_F_Training" call zlt_units, { (["shoot_house", _x] call bis_fnc_instring) or (["obstacle", _x] call bis_fnc_instring) or (["concrete", _x] call bis_fnc_instring) }] call zlt_filter)
	+(["A3_Structures_F_Civ_Constructions","A3_Structures_F_EPA_Civ_Constructions"] call zlt_units)
	+['Land_CncWall1_F','Land_CncWall4_F',"Land_CncShelter_F"]
;

// лок. объекты + отключены повр., выключена симуляция
zlt_disableSimClasses = 
	(["A3_Structures_F_Civ_Camping" call zlt_units, { not (["toilet", _x] call bis_fnc_instring) }] call zlt_filter)
	+(["A3_Structures_F_Items_Documents","A3_Structures_F_Items_Electronics","A3_Structures_F_Items_Cans","A3_Structures_F_Items_Gadgets","A3_Structures_F_Items_Luggage","A3_Structures_F_Items_Stationery","A3_Structures_F_Items_Tools","A3_Structures_F_Items_Valuables","A3_Structures_F_EPA_Items_Electronics","A3_Structures_F_EPA_Items_Food","A3_Structures_F_EPA_Items_Medical","A3_Structures_F_EPA_Items_Tools","A3_Structures_F_EPA_Items_Vessels","A3_Structures_F_EPC_Items_Documents","A3_Structures_F_EPC_Items_Electronics"] call zlt_units)
	+(["A3_Structures_F_EPB_Furniture","A3_Structures_F_Furniture","A3_Structures_F_Items_Vessels", "A3_Structures_F_EPA_Civ_Camping","A3_Structures_F_EPB_Items_Vessels"] call zlt_units)
	-["Land_MetalBarrel_empty_F","MetalBarrel_burning_F"]
	+["Land_Pallet_F", "Land_Pallet_vertical_F","Land_Obstacle_Ramp_F"]
;

// нужны маркера для объекта
zlt_objectsWithMarkers = 
	("A3_Structures_F_Mil_BagBunker" call zlt_units) + ["Land_CncWall4_F","Land_CncWall4_F","Land_HBarrierBig_F", "Land_HBarrier_Big_F", "Land_HBarrierTower_F",
"Land_HBarrierWall_corner_F", "Land_HBarrierWall_corridor_F", "Land_HBarrierWall4_F", "Land_HBarrierWall6_F", "House_F"]
;

// игнорировать этот тип объекта
zlt_objectsIgnorePlacement = [
"Helper_Base_F"
];


zlt_new_specialFixObjs = ["Land_Pallet_F","Land_HBarrierBig_F", "Land_HBarrier_Big_F"];

// Local, disablesim, left/right, up/down, forw/backw fix
zlt_new_specialFixObjsData = [[ 0.72, 0, 0.61],[0.5,0.5,0.5],[0.5,0.5,0.5]];

// ----------------------------------------------        КОМПОЗИЦИИ -----------------------------------------------------------------------------

zlt_comp_names = ["Тест", "Fortify Cargo Patrol","Мешки сверху HBarrier"];
zlt_comp_data = [
["Land_HBarrier_5_F","Land_HBarrier_5_F",[0,0,0.495338],0,0,0,"Land_HBarrier_5_F",[0,0,1.73119],0,0,0],
["Land_Cargo_Patrol_V3_F","Land_BagFence_Long_F",[3.20605,-1.4707,-0.377037],90.0121,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[3.20703,1.55273,-0.370216],90.0121,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[3.20703,1.55273,-1.18711],90.0121,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[3.20605,-1.4707,-1.19393],90.0121,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[-1.47852,-2.71094,-0.406494],1.01228,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[1.54297,-2.76367,-0.400536],1.01228,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[1.54297,-2.76563,-1.21743],1.01227,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[-1.47852,-2.71094,-1.22339],1.01225,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[-3.13867,1.50195,-1.26421],90.0121,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[-3.14063,-1.51953,-1.26498],90.0121,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[-3.14063,-1.51758,-0.44809],90.0121,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[-3.13867,1.50391,-0.447319],90.0121,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[-1.5498,2.71094,-1.21457],-180.988,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[1.47266,2.76367,-1.20409],-180.988,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[1.47266,2.76563,-0.387199],-180.988,-0.0226288,-0.0164335,"Land_BagFence_Long_F",[-1.5498,2.71289,-0.397675],-180.988,-0.0226288,-0.0164335],
["Land_HBarrier_Big_F","Land_BagFence_Long_F",[-0.00488281,0.0859375,0.981003],-2.99998,0,0,"Land_BagFence_End_F",[-1.9082,-0.015625,0.981003],182,0,0,"Land_BagFence_End_F",[1.89746,0.183594,0.981003],-2.99998,0,0]
];

zlt_curr_comp = 0;



#define DIK_UP 				200
#define DIK_DOWN 			208
#define DIK_LEFT 			203
#define DIK_RIGHT 			205
#define DIK_HOME 			199
#define DIK_END				207
#define DIK_INSERT          0xD2    /* Insert on arrow keypad */
#define DIK_PGUP            0xC9    /* PgUp on arrow keypad */
#define DIK_PGDN            0xD1    /* PgDn on arrow keypad */
#define DIK_END             0xCF    /* End on arrow keypad */
#define DIK_HOME            0xC7    /* Home on arrow keypad */
#define DIK_DELETE          0xD3    /* Delete on arrow keypad */
#define DIK_DIVIDE          0xB5
#define DIK_NUM8			0x48
#define DIK_NUM2			0x50

#define DIK_W               0x11
#define DIK_S				0x1F
#define DIK_A				0x1E
#define DIK_D				0x20
#define DIK_Q				0x10
#define DIK_Z				0x2C

#define DIK_F1              0x3B
#define DIK_F2              0x3C
#define DIK_F3              0x3D
#define DIK_F4              0x3E
#define DIK_F5              0x3F
#define DIK_F6              0x40
#define DIK_F7              0x41
#define DIK_F8              0x42
#define DIK_F9              0x43
#define DIK_F10             0x44

#define DIK_RSHIFT          0x36
#define DIK_MULTIPLY        0x37    /* * on numeric keypad */
#define DIK_LSHIFT          0x2A
#define DIK_LCONTROL        0x1D
#define DIK_RCONTROL        0x9D
#define DIK_LMENU           0x38    /* left Alt */
#define DIK_RMENU           0xB8    /* right Alt */
#define DIK_RALT            DIK_RMENU           /* right Alt */
#define DIK_LALT            DIK_LMENU
#define DIK_SPACE           0x39
#define DIK_MULTIPLY        0x37    /* * on numeric keypad */
#define DIK_NUMPADSTAR      DIK_MULTIPLY 
#define DIK_SUBTRACT        0x4A    /* - on numeric keypad */
#define DIK_SPACE           0x39
#define DIK_ADD             0x4E    /* + on numeric keypad */

#define PR(x) private ['x']; x
#define PARAM(X,Y,Z) private ['X']; X=[_this, Y, Z] call BIS_fnc_param;



#define P_LOCAL_OBJ 0
#define P_SIM_DISABLE 1
#define P_DAMAGE_DISABLE 2
#define P_HAS_MARKER 3
#define P_IGNORE_PLACEMENT 4

zlt_objGetStdParams = {
	private ["_class","_islocal","_simdisable","_damdisable","_hasmarker","_ignoreplacement"];
	_class = _this;
	_islocal = false; _simdisable = false; _damdisable = false; _hasmarker = false; _ignoreplacement = false;	

	if ( [_class,zlt_localObjectsClasses] call zlt_fnc_cycleKindOf ) then {_islocal = true; _damdisable = true;};
	if ( [_class,zlt_disableSimClasses] call zlt_fnc_cycleKindOf ) then {_islocal = true; _damdisable = true; _simdisable = true; };
	if ( [_class,zlt_objectsWithMarkers] call zlt_fnc_cycleKindOf ) then { _hasmarker = true; };
	if ( [_class,zlt_objectsIgnorePlacement] call zlt_fnc_cycleKindOf ) then {_ignoreplacement = true; };	
	[_islocal, _simdisable, _damdisable, _hasmarker,  _ignoreplacement ]	
};

//ASLToATL ASLtoATL

zlt_createcam = {
	PARAM(_campos, 0,  asltoatl eyePos player)
	zlt_cameraMode = true;
	zlt_camera =  "camera" camCreate _campos;
	zlt_camera cameraEffect ["internal","top"];
	zlt_camera setDir (getDir player);
	zlt_camera camCommitPrepared 0;
	showcinemaborder false;
	
	zlt_cam_handler = [] spawn {
		while {zlt_cameraMode} do {
			_coeff = 1;
			_pos = screentoworld [0.5,0.5];
			_intersectCam = getposasl zlt_camera;
			_intersectTarget = [_pos select 0,_pos select 1,getterrainheightasl _pos];
			_objects = lineIntersectswith [ _intersectCam, _intersectTarget, objnull, objnull, true	];
			_object = objnull;
			if (count _objects > 0) then {
				_object = _objects select (count _objects - 1);
				zlt_cameraTarget = _object;
			};
			
			sleep 0.1;
			_campos = getPosAsl zlt_camera;
			if (zlt_camerakeys select DIK_LSHIFT || zlt_camerakeys select DIK_RSHIFT) then {_coeff = 0.1;};
			if (zlt_camerakeys select DIK_LCONTROL || zlt_camerakeys select DIK_RCONTROL) then {_coeff = 10;};
			if (zlt_camerakeys select DIK_W) then {_campos = [0,1,0,_coeff, _campos] call zlt_movecam;};
			if (zlt_camerakeys select DIK_S) then { _campos=[0,-1,0,_coeff, _campos] call zlt_movecam;};
			if (zlt_camerakeys select DIK_A) then { _campos=[-1,1,0,_coeff, _campos] call zlt_movecam;};
			if (zlt_camerakeys select DIK_D) then { _campos=[1,1,0,_coeff, _campos] call zlt_movecam;};
			if (zlt_camerakeys select DIK_Q) then { _campos=[0,0,1,_coeff, _campos] call zlt_movecam;};
			if (zlt_camerakeys select DIK_Z) then { _campos=[0,0,-1,_coeff, _campos] call zlt_movecam;};			
			if (surfaceIsWater _campos) then {
				zlt_camera camSetPos _campos; } else {
				zlt_camera camSetPos ( ASLtoATL _campos);
			};

			zlt_camera camCommit 0.3;
			comment "13";

		};
	};
};

zlt_removecam = {
	player cameraEffect ["terminate","back"];
	camDestroy zlt_camera;
	zlt_cameraMode = false;
	terminate zlt_cam_handler;
};

zlt_movecam = {
	//diag_log ["zlt_movecam",_this];
	PR(_dx) = _this select 0; PR(_dy) = _this select 1; PR(_dz) = _this select 2; PR(_dl) = _this select 3;
	//PR(_pos) = getPosAsl zlt_camera;
	_pos = _this select 4;
	PR(_dir) = (direction zlt_camera) + _dx *90.0;
	PR(_newcampos) = [ (_pos select 0) + ((sin _dir) * _dl * _dy), (_pos select 1) + ((cos _dir) * _dl * _dy), (_pos select 2) + _dz * _dl ];
	_newcampos set [2,(_newcampos select 2) max (getterrainheightasl _newcampos)];
	//zlt_camera camSetPos (ASLtoATL _newcampos);
	//diag_log ["zlt_movecam",_newcampos];
	_newcampos

};

zlt_rotatecam = {
	if (isNil "zlt_camDir") then {zlt_camDir=0;};
	PR(_dx) = _this select 1;
	PR(_dy) = _this select 2;
	zlt_lastCamPos = [0,_dx,_dy];
	zlt_camDir= (zlt_camDir - _dy*1) max -89 min 89;
	zlt_camera setDir (getDir zlt_camera + _dx*1);
	[ zlt_camera, zlt_camDir, 0 ] call bis_fnc_setpitchbank;
	zlt_camera camCommitPrepared 0;
};


/*
 *
 *
 *  РИСОВАНИЕ РАМОК
 *
 */
zlt_drawBox = {
	PR(_obj) = _this select 0;
	PR(_color) = _this select 1;
	_bl = _this select 2;
	if (_obj in _bl) exitWith {};
	if (isNull _obj) exitWith {};

	PR(_boxBot) = (boundingboxreal _obj) select 0;
	PR(_boxTop) = (boundingboxreal _obj) select 1;

	PR(_xB) = _boxBot select 0;	PR(_xT) = _boxTop select 0;
	PR(_yB) = _boxBot select 1;	PR(_yT) = _boxTop select 1;
	PR(_zB) = _boxBot select 2;	PR(_zT) = _boxTop select 2;

	drawLine3D [ _obj modeltoworld [_xB, _yB, _zB], _obj modeltoworld [_xT, _yB, _zB], _color];
	drawLine3D [ _obj modeltoworld [_xB, _yT, _zB], _obj modeltoworld [_xT, _yT, _zB], _color];
	drawLine3D [ _obj modeltoworld [_xB, _yB, _zB], _obj modeltoworld [_xB, _yT, _zB], _color];
	drawLine3D [ _obj modeltoworld [_xT, _yB, _zB], _obj modeltoworld [_xT, _yT, _zB], _color];

	drawLine3D [ _obj modeltoworld [_xB, _yB, _zT], _obj modeltoworld [_xT, _yB, _zT], _color];
	drawLine3D [ _obj modeltoworld [_xB, _yT, _zT], _obj modeltoworld [_xT, _yT, _zT], _color];
	drawLine3D [ _obj modeltoworld [_xB, _yB, _zT], _obj modeltoworld [_xB, _yT, _zT], _color];
	drawLine3D [ _obj modeltoworld [_xT, _yB, _zT], _obj modeltoworld [_xT, _yT, _zT], _color];

	drawLine3D [ _obj modeltoworld [_xB, _yB, _zB], _obj modeltoworld [_xB, _yB, _zT], _color];
	drawLine3D [ _obj modeltoworld [_xB, _yT, _zB], _obj modeltoworld [_xB, _yT, _zT], _color];
	drawLine3D [ _obj modeltoworld [_xT, _yB, _zB], _obj modeltoworld [_xT, _yB, _zT], _color];
	drawLine3D [ _obj modeltoworld [_xT, _yT, _zB], _obj modeltoworld [_xT, _yT, _zT], _color];
	
	_bl pushback _obj;
};

// выделять - красный - текущий блок
// синий - центр текущей композиции, зеленый - доп. эл-ты текущей композиции


zlt_onEachFrame = {
	_bl = [];
	// подсветка текущей
	[zlt_newlb, [1,0,0,1],_bl] call zlt_drawBox;
	

	if (!zlt_is_comp) then {
		_mb = zlt_newlb getVariable ["zlt_new_masterblock", objNull];
		if (!isnull _mb) then {
			if (_mb != zlt_newlb) then {
				[_mb, [0,0,1,1],_bl] call zlt_drawBox;
			};
		};
		
		_childs = zlt_newlb getVariable ["zlt_new_childblocks", []];
		{
			if (_x != zlt_newlb) then {
				[_x, [0,1,0,1],_bl] call zlt_drawBox;
			};
		} foreach _childs;
	} else {
		// ДЛЯ РЕЖИМА КОМПОЗИЦИИ
		_mb = zlt_new_blocks select 0;
		if (_mb != zlt_newlb) then {
			[_mb, [0,0,1,1],_bl] call zlt_drawBox;
		};
		{
			if (_x != zlt_newlb) then {
				[_x, [0,1,0,1],_bl] call zlt_drawBox;
			};
		} foreach (zlt_new_blocks-[_mb]);
	};
	
	if (!zlt_cameraMode && !isNull cursorTarget) then {
		[cursorTarget, [1,1,0,1],_bl] call zlt_drawBox;
	};
	if (zlt_cameraMode && !isNull zlt_cameraTarget) then {
		[zlt_cameraTarget, [1,1,0,1],_bl] call zlt_drawBox;
	};
};

zlt_fnc_getallcode = {
	private ["_br","_listobj","_txt","_global","_stdparm","_local","_ignore","_simdisable","_listobj2","_hasmarker"];
	_br = toString [13, 10];
	_listobj = +(_this);
	
	{
		_childs = _x getVariable ["zlt_new_childblocks",[]];
		{
			_x setvariable ["zlt_cb", true];
			_listobj pushback _x;
			
		} foreach _childs;
	} foreach _this;


	_listobj2 = +(_listobj);
	_listobj = [];
	{
		_stdparm = (_x call zlt_objGetStdParams);
		_ignore = _stdparm select P_IGNORE_PLACEMENT;
		if ( !_ignore ) then {
			_listobj pushBack _x;
		};
	} foreach _listobj2;
	_listobj2 = nil;


	_txt = "//Generated using generator by [STELS]Zealot"+_br+'if (isnil "zlt_new_blocks") then {zlt_new_blocks = [];};'+_br;
	_txt = _txt + "zlt_fnc_boundingbox = " + str(zlt_fnc_boundingbox) +";"+ _br;
	_txt = _txt + "if(not isDedicated) then {" + _br;
	{
		_stdparm = (_x call zlt_objGetStdParams);
		_hasmarker = ( _stdparm select P_HAS_MARKER );
		if ( _hasmarker ) then {
			_txt = _txt +"    "+format["[%1,%2,%3] call zlt_fnc_boundingbox;",str(boundingBoxReal _x),direction _x, position _x]+_br;
		};
	} foreach _listobj;
	
	_txt = _txt + "};" + _br;
	
//	_txt = _txt + "waituntil {time > 0};" + _br;
	_txt = _txt + "if (isserver) then {" + _br;
	{
		_stdparm = (_x call zlt_objGetStdParams);
		_local = ( _stdparm select P_LOCAL_OBJ );
		_simdisable = ( _stdparm select P_SIM_DISABLE );
		if (!_local) then {
			_txt = _txt + ([_x, _local, _simdisable] call zlt_fnc_getcode);
		};
	} foreach _listobj;
	
	_txt = _txt + "};" + _br;
	_txt = _txt + "if (isdedicated) exitwith {};" + _br;
	
//	_txt = _txt + "waituntil {time > 0};" + _br;
	{
		_stdparm = (_x call zlt_objGetStdParams);
		_local = ( _stdparm select P_LOCAL_OBJ );
		_simdisable = ( _stdparm select P_SIM_DISABLE );
		if not (!_local) then {
			_txt = _txt + ([_x, _local, _simdisable] call zlt_fnc_getcode);
		};
	} foreach _listobj;
	diag_log ["zlt_fnc_getallcode", _txt];
	_txt;
};

zlt_fnc_getcode = {		
	_obj = _this select 0;
	_local = _this select 1;
	_simdisable = _this select 2;

	_objType = typeOf _obj;
	_spawnType = "CAN_COLLIDE";
	_pitchBank = _obj call BIS_fnc_getPitchBank;
	_obj setvectorup [0,0,1];
	_posATL = getPosATL _obj;
	_posASL = getPosASL _obj;
	_posWorld = (getPosWorld _obj) call KK_fnc_positionToString;
	_dir = getDir _obj;
	_pitch = _pitchBank select 0;
	_bank = _pitchBank select 1;
	[_obj, _pitch, _bank] call BIS_fnc_setPitchBank;
	_br = toString [13, 10];
	_copiedTxt = "";
	private ["_txt1","_txt2"];
	_txt1 = ""; _txt2 = "";
	if (not _local) then {
		_txt1 = format ["_pos = %1; zlt_newlb = createVehicle [""%2"", _pos, [], 0, ""%3""];", _posWorld, _objType, _spawnType];
		_txt2 = format ["zlt_newlb setDir %1; zlt_newlb setPosWorld _pos;[zlt_newlb, %2, %3] call BIS_fnc_setPitchBank;zlt_new_blocks pushback zlt_newlb;", _dir, _pitch, _bank];

	} else {
		_txt1 = format ["_pos = %1; zlt_newlb = ""%2"" createVehiclelocal _pos; ", _posWorld, _objType];
		_txt2 = format ["zlt_newlb setDir %1; zlt_newlb setPosWorld _pos; [zlt_newlb, %2, %3] call BIS_fnc_setPitchBank; zlt_new_blocks pushback zlt_newlb; zlt_newlb allowdamage false;", _dir,  _pitch, _bank];
	};
	_copiedTxt = _copiedTxt + _txt1;
	if ( _simdisable ) then {
		_copiedTxt = _copiedTxt + "zlt_newlb enableSimulation false;";
	};
	_copiedTxt = _copiedTxt + _txt2;
	_decl = _obj getVariable ["zlt_new_decl",[]];
	if (count (_decl) != 0 ) then {
		_copiedTxt=_copiedTxt+'if(not isDedicated)then{zlt_newlb setVariable ["zlt_new_decl",' + str(_decl) + '];};';
	};
	
	if (_obj getvariable ["zlt_cb", false]) then {
		_copiedTxt=_copiedTxt+'zlt_newlb setVariable ["zlt_cb",true];';
	};
	_copiedTxt = _copiedTxt + _br;
	_copiedTxt;
};

zlt_fnc_compFromObjs = {
	_list = _this;
	_res = [];
	_mainobj = _list select 0;
	_dir = getDir _mainobj;
	_pitchbank = (_mainobj call BIS_fnc_getPitchBank);
	_pitch = _pitchBank select 0;
	_bank = _pitchBank select 1;
	_res = [typeof _mainobj];
	{
		_res = _res + [typeof _x];
		_res = _res + [_mainobj worldToModel getposatl _x];
		_res = _res + [ getDir _x - _dir];
		_pitchbank2 = _x call BIS_fnc_getPitchBank;
		_pitch2 = _pitchBank2 select 0;
		_bank2 = _pitchBank2 select 1;
		_res = _res + [ _pitch2 - _pitch];
		_res = _res + [ _bank2 - _bank];
	} foreach (_list - [_mainobj]);
	_res;
};



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//["Land_BagBunker_Tower_F","Land_BagFence_Long_F",[2.69531,-1.67871,-0.911802],"Land_BagFence_Long_F",[2.63086,1.33398,-0.911802]]

zlt_fnc_boundingbox = { private ["_dir","_pos","_color","_alpha","_bbox","_b1","_b2","_bbx","_bby","_marker"]; if(!hasInterface)exitWith{}; _bbox = [_this, 0] call BIS_fnc_param; _dir = [_this, 1] call BIS_fnc_param; _pos = [_this, 2] call BIS_fnc_param; _color = [_this, 3, "ColorBlack"] call BIS_fnc_param; _alpha = [_this, 4, 1.0] call BIS_fnc_param; if (isnil "zlt_bb_id") then { zlt_bb_id = 0; };	_b1 = _bbox select 0; _b2 = _bbox select 1;	_bbx = (abs(_b1 select 0) + abs(_b2 select 0)); _bby= (abs(_b1 select 1) + abs(_b2 select 1)); _marker = createmarkerlocal [ format [ "WMT_BundingBoxMarker_%1",zlt_bb_id ], _pos ]; zlt_bb_id = zlt_bb_id + 1;	_marker setmarkerdir _dir; _marker setmarkershapelocal "rectangle";	_marker setmarkersizelocal 	[_bbx/2,_bby/2]; _marker setmarkercolor	_color;	_marker setmarkeralphalocal _alpha;	_marker };

zlt_fnc_cycleKindOf = {
	_ret = false;
	{
		if ( (_this select 0) isKindOf _x ) exitWith {_ret = true; };
	} foreach (_this select 1);
	_ret
};


//////////////////////////////////////////////

zlt_fnc_modeindication = {
	private ["_n","_b","_txt"];
	_txt = "";
	
	if (not isNil "zlt_is_comp" and {zlt_is_comp}) then {
		_txt = _txt + "<t color='#ff0000'> КОМП</t>";
	} else {
		_txt = _txt + "<t color='#ffaa00'> --------</t>";
	};
	if (!zlt_new_vectorup) then {
		_txt = _txt + "<t color='#ff0000'> НОРМ</t>";
	} else {
		_txt = _txt + "<t color='#ffaa00'> ВЕРТ</t>";
	};
	
	if (zlt_new_asl) then {
		_txt = _txt + "<t color='#ffaa00'> ASL</t>";
	} else {
		_txt = _txt + "<t color='#ff0000'> ATL</t>";
	};
	
	if (!zlt_new_micro) then {
		_txt = _txt + "<t color='#ffaa00'> --------</t>";
	} else {
		_txt = _txt + "<t color='#ff0000'> MICRO</t>";
	};


	_txt = _txt + "<br/>";
	
	// покажем текущий блок
	if (not isnull zlt_newlb) then {
		// previous
		_ci = zlt_new_blocks find zlt_newlb;
		
		if (_ci < (count zlt_new_blocks -1)) then {
			_n = _ci + 1;
			_b = zlt_new_blocks select _n;
		
			_txt = _txt + "   " + str(_n) + " "+ typeOf _b + "<br/>";
		} else { _txt=_txt + "         ------------<br/>"; };		
		
		
		if (_ci != -1) then {
			_n = _ci;
			_b = zlt_new_blocks select _n;
		
			_txt = _txt + " > " + str(_n) + " "+ typeOf _b + "<br/>";
		} else { _txt=_txt + "         ------------<br/>"; };
		
		if (_ci > 0) then {
			_n = (_ci - 1);
			_b = zlt_new_blocks select _n;
			_txt = _txt + "   " + str(_n) + " "+ typeOf _b + "<br/>";
		} else { _txt=_txt + "         ------------<br/>"; };
		

	};

	if (not isNil "zlt_cur_class") then {
		_txt=_txt+"<br/>КЛАСС: "+zlt_cur_class +"<br/>"+"НАЗВАНИЕ: "+ getText (configFile >> "CfgVehicles" >> zlt_cur_class >> "displayName") + "<br/>";

	};

	//diag_log [_txt];
	// конец показа текущего блока
	[ format["<t size='0.4' align='left' color='#ffff00'>%1</t>",_txt], safezonex,safezoney+0.1,1,0,0,335] spawn bis_fnc_dynamicText;
};

zlt_fnc_notify = {
	 [ format["<t size='0.75' color='#ffff00'>%1</t>",_this], 0,1,5,0,0,331] spawn bis_fnc_dynamicText;
};

zlt_fnc_notifyhint = {
	private ["_item","_list","_txt","_k","_n"];
	disableSerialization;
	_item = _this select 0;
	_list = _this select 1;
	_k = (_list find _item) max 0;
	//diag_log ['zlt_fnc_notifyhint',_k,_item,_list];
	if (((uiNamespace getVariable "zlt_new_objects_lb") lbText _k) == _item) then {
		
	} else {
		lbClear (uiNamespace getVariable "zlt_new_objects_lb");

		{
			(uiNamespace getVariable "zlt_new_objects_lb") lbAdd _x;
		} foreach _list;

	};
	(uiNamespace getVariable "zlt_new_objects_lb") lbSetCurSel _k;
	(uiNamespace getVariable "zlt_new_objects_lb") ctrlShow true;
	(uiNamespace getVariable "zlt_new_objects_lb") ctrlCommit 0;
	terminate zlt_new_objects_lb_cb;
	zlt_new_objects_lb_cb = [] spawn {
		uiSleep 10;
		(uiNamespace getVariable "zlt_new_objects_lb") ctrlShow false;
		(uiNamespace getVariable "zlt_new_objects_lb") ctrlCommit 0;
	};
};



zlt_new_moveblock = {
	// "UP", "RIGHT", "ROLLZ", "FARER", "PITCH", "BANK"
	// VALUE - Значение на сколько
	private ["_class", "_pos", "_dir", "_pitch", "_bank","_obj"];
	_mode = _this select 0;
	_val = _this select 1;
	PARAM(_fASL, 2, zlt_new_asl)
	
	if ( isnil "zlt_newlb" or {isNull zlt_newlb} ) exitwith {};
	_obj = zlt_newlb;
	_obj call zlt_new_comp_removeaux;
	//получить координаты
	_dir = getdir _obj;
	_pitchBank = _obj call BIS_fnc_getPitchBank; _pitch = _pitchBank select 0; 	_bank = _pitchBank select 1;
	if (_pitch !=0 or _bank != 0) then {
		_obj setvectorup [0,0,1];
	};
	if (_fASL) then {
		_pos = getPosASL _obj;
	} else {
		_pos = getPosATL _obj;
	};
	_dir = getDir _obj;
	_obj setdir 0;
	_pdir = 0;
	
	if (zlt_cameraMode) then {
		_pdir = direction zlt_camera;
	} else {
		_pdir = getdir player;
	};

	if (!_fASL) then {
		switch (_mode) do {
			case ("UP") : { _obj setposatl [_pos select 0, _pos select 1, (_pos select 2) + _val]; };
			case ("RIGHT") : { _obj setposatl [(_pos select 0) + (sin (_pdir + 90) * _val ), (_pos select 1) + (cos (_pdir + 90)* _val ), (_pos select 2)]; };
			case ("LEFT") : { _obj setposatl [(_pos select 0) + (sin (_pdir - 90) * _val ), (_pos select 1) + (cos (_pdir - 90)* _val ), (_pos select 2)]; };
			case ("FARER") : { _obj setposatl [(_pos select 0) + (sin _pdir * _val ), (_pos select 1) + (cos _pdir * _val ), (_pos select 2)]; };
			case ("ROLLZ") : { _dir = _dir + _val; };
			case ("PITCHUP") : { _pitch = _pitch + _val; };
			case ("BANKUP") : { _bank = _bank + _val; };
			
		};
	} else {
		switch (_mode) do {
			case ("UP") : { _obj setposasl [_pos select 0, _pos select 1, (_pos select 2) + _val]; };
			case ("RIGHT") : { _obj setposasl [(_pos select 0) + (sin (_pdir + 90) * _val ), (_pos select 1) + (cos (_pdir + 90)* _val ), (_pos select 2)]; };
			case ("LEFT") : { _obj setposasl [(_pos select 0) + (sin (_pdir - 90) * _val ), (_pos select 1) + (cos (_pdir - 90)* _val ), (_pos select 2)]; };
			case ("FARER") : { _obj setposasl [(_pos select 0) + (sin _pdir * _val ), (_pos select 1) + (cos _pdir * _val ), (_pos select 2)]; };
			case ("ROLLZ") : { _dir = _dir + _val; };
			case ("PITCHUP") : { _pitch = _pitch + _val; };
			case ("BANKUP") : { _bank = _bank + _val; };
			
		};
	};
	_obj setdir _dir;
	if (_pitch !=0 or _bank != 0) then {	
		[_obj, _pitch, _bank] call BIS_fnc_setPitchBank;
	};
	_obj call zlt_new_comp_placeaux;
};


zlt_new_mouseMoving = {

	if (zlt_cameraMode) then {
		_this call zlt_rotatecam;
		
	};
	//diag_log ["M",_x,_y];

};

zlt_new_keyup = {
	private ["_key","_dir"];
	_ret = false;
	if (count _this > 1) then
	{
		_key  = _this select 1;
		zlt_camerakeys set [_key,false];
		_shift = _this select 2;
		_ctrl = _this select 3;
		_alt  = _this select 4;
		_ret = true;
	};
	_ret;
};

	
zlt_new_keydown =
{
	private ["_key","_dir"];
	_ret = false;
	if (count _this > 1) then
	{
		_key  = _this select 1;
		zlt_camerakeys set [_key,true];
		
		_shift = _this select 2;
		_ctrl = _this select 3;
		_alt  = _this select 4;
		//player globalchat format ["%1 - %2",_key,_this];
		_ret = true;
		_pos = getposatl zlt_newlb;
		_dir = getdir zlt_newlb;
		
		
		_coeff = 0.3;
		_angle = 5;
	
		if (_shift) then {_coeff = 0.1; _angle = 1;};
		if (zlt_new_micro) then {
			_coeff = 0.05; _angle = 1;
			if (_shift) then {_coeff = 0.01; _angle = 0.2;};
		};
		
		switch (true) do
		{
			// КАМЕРА
			
			case (!zlt_cameraMode && _key == DIK_F3) : { [] spawn zlt_createcam; };
			case (zlt_cameraMode && _key == DIK_F3) : { [] spawn zlt_removecam; };
	
			case (_key == DIK_UP && _ctrl && !_alt && !zlt_new_is_plc_mode) : {   ["UP", _coeff] call zlt_new_moveblock;  };
			case (_key == DIK_DOWN && _ctrl && !_alt && !zlt_new_is_plc_mode) : {   ["UP", -_coeff] call zlt_new_moveblock;  };
			case (_key == DIK_LEFT && _ctrl && !_alt) : {   ["ROLLZ", -_angle] call zlt_new_moveblock;  };
			case (_key == DIK_RIGHT && _ctrl && !_alt) : {   ["ROLLZ", _angle] call zlt_new_moveblock;  };
			case (_key == DIK_UP && _alt && !_ctrl) : {   ["PITCHUP", -_angle] call zlt_new_moveblock;  };
			
			case (_key == DIK_DOWN && _alt && !_ctrl) : {   ["PITCHUP", _angle] call zlt_new_moveblock;  };
			
			case (_key == DIK_LEFT && _alt && !_ctrl) : {   ["BANKUP", _angle] call zlt_new_moveblock;  };
			
			case (_key == DIK_RIGHT && _alt && !_ctrl) : {   ["BANKUP", -_angle] call zlt_new_moveblock;  };
			// РЕДАКТИРОВАНИЕ КОМПОЗИЦИИ
			case (_key == DIK_INSERT && _alt && _ctrl) : {
				if (isNull zlt_newlb) exitWith {"Якорный блок не выбран!" call zlt_fnc_notify;};
				zlt_new_blocks_bak = zlt_new_blocks;
				zlt_new_blocks = [zlt_newlb] + (zlt_newlb getVariable ["zlt_new_childblocks", []]);
				zlt_is_comp = true;
				"Композиция начата!" call zlt_fnc_notify;
			};
			
			// СОХРАНЕНИЕ КОМПОЗИЦИИ
			case (_key == DIK_END && _alt && _ctrl) : {
				if (!zlt_is_comp) exitWith {"Только для режима редактирования композиции!" call zlt_fnc_notify;};
				_newdecl = zlt_new_blocks call zlt_fnc_compFromObjs;
				_mainobj = zlt_new_blocks select 0;
				zlt_newlb = _mainobj;
				_mainobj setvariable ["zlt_new_decl", _newdecl];
				_mainobj call zlt_new_comp_removeaux;
				zlt_newlb = _mainobj;
				{deleteVehicle _x} foreach (zlt_new_blocks-[_mainobj]);
				_mainobj call zlt_new_comp_placeaux;
				
				copyToClipboard str (_newdecl);
				diag_log str (_newdecl);
				
				zlt_is_comp = false;
				zlt_new_blocks = zlt_new_blocks_bak;
				zlt_new_blocks_bak = nil;
				
				"Композиция сохранена в буфер обмена!" call zlt_fnc_notify;
			};
			
			case (_key == DIK_DELETE && _alt && !_ctrl && !_shift) : {
				// удаление дочерних блоков
				zlt_newlb call zlt_new_comp_removeaux;
				zlt_newlb setVariable ["zlt_new_decl", nil];
				zlt_newlb setVariable ["zlt_new_childblocks", nil];
				zlt_newlb setVariable ["zlt_new_masterblock", nil];
				"Дочерние блоки удалены!" call zlt_fnc_notify;
			};


			//вставить
			case (_key == DIK_INSERT && _alt) : {(zlt_comp_data select zlt_curr_comp) call zlt_new_comp};

			// PD
			case (_key == DIK_PGDN && _alt) : {_ind =  zlt_curr_comp max 0; _ind = _ind + 1; if (_ind > (count (zlt_comp_data) -1)) then {_ind = count (zlt_comp_data) -1 ;};  zlt_curr_comp = _ind;  [zlt_comp_names select zlt_curr_comp, zlt_comp_names] call zlt_fnc_notifyhint;  };
			//PU
			case (_key == DIK_PGUP && _alt) : {_ind =  zlt_curr_comp max 0; _ind = _ind - 1; if (_ind < 0) then {_ind = 0 ;}; zlt_curr_comp = _ind;  [zlt_comp_names select zlt_curr_comp, zlt_comp_names] call zlt_fnc_notifyhint; };
			
			

			//вверх
			case (_key == DIK_UP && !zlt_new_is_plc_mode ) : {["FARER", _coeff] call zlt_new_moveblock;};
			//вниз
			case (_key == DIK_DOWN && !zlt_new_is_plc_mode ) : {["FARER", -_coeff] call zlt_new_moveblock;};
			//влево
			case (_key == DIK_LEFT && !zlt_new_is_plc_mode ) : {["LEFT", _coeff] call zlt_new_moveblock;};
			//вправо
			case (_key == DIK_RIGHT && !zlt_new_is_plc_mode ) : {["RIGHT", _coeff] call zlt_new_moveblock;};
			
			// вставить
			case (_key == DIK_INSERT && _ctrl) : {[_ctrl] call zlt_new_block};

			case (_key == DIK_INSERT) : {
				// режим установки 
				zlt_new_is_plc_mode = true;
				// handle колбека выключения режима установки 
				zlt_new_plc_mode_cb = [] spawn {
					sleep 5;
					zlt_new_is_plc_mode = false;
					hint "Установка отменена!";
				};

				hint "Режим установки";
			};
			//ctrl up down
			case (zlt_new_is_plc_mode && _key == DIK_UP && _ctrl && !_alt) :  { terminate zlt_new_plc_mode_cb;zlt_new_is_plc_mode=false; [false,"UP"] call zlt_new_block; hint "Установка";};
			case (zlt_new_is_plc_mode && _key == DIK_DOWN && _ctrl && !_alt) :  { terminate zlt_new_plc_mode_cb;zlt_new_is_plc_mode=false; [false,"DOWN"] call zlt_new_block; hint "Установка";};
			//up down
			case (zlt_new_is_plc_mode && _key == DIK_DOWN && !_ctrl && !_alt) :  { terminate zlt_new_plc_mode_cb;zlt_new_is_plc_mode=false; [_ctrl,"BACK"] call zlt_new_block; hint "Установка";};
			case (zlt_new_is_plc_mode && _key == DIK_UP && !_ctrl && !_alt) :  { terminate zlt_new_plc_mode_cb;zlt_new_is_plc_mode=false; [_ctrl,"FRONT"] call zlt_new_block; hint "Установка";};
			//left right
			case (zlt_new_is_plc_mode && _key == DIK_LEFT && !_ctrl && !_alt) :  { terminate zlt_new_plc_mode_cb;zlt_new_is_plc_mode=false; [_ctrl,"LEFT"] call zlt_new_block; hint "Установка";};
			case (zlt_new_is_plc_mode && _key == DIK_RIGHT && !_ctrl && !_alt) :  { terminate zlt_new_plc_mode_cb;zlt_new_is_plc_mode=false; [_ctrl,"RIGHT"] call zlt_new_block; hint "Установка";};


			//
			
			// PD + ctrl
			case (_key == DIK_PGDN and _ctrl ) : {  if (zlt_obj_list_index < ( count (zlt_obj_list_all) - 1 ) ) then { zlt_obj_list_index = zlt_obj_list_index +1 ;}; zlt_obj_list = zlt_obj_list_all select zlt_obj_list_index; zlt_cur_class = zlt_obj_list select 0; [zlt_cur_class, zlt_obj_list] call zlt_fnc_notifyhint; };
			// PU + ctrl
			case (_key == DIK_PGUP and _ctrl ) : {  if (zlt_obj_list_index > 0 ) then { zlt_obj_list_index = zlt_obj_list_index -1 ;}; zlt_obj_list = zlt_obj_list_all select zlt_obj_list_index; zlt_cur_class = zlt_obj_list select 0; [zlt_cur_class, zlt_obj_list] call zlt_fnc_notifyhint; };
			
			
			
			// PD
			case (_key == DIK_PGDN ) : {_ind =  (zlt_obj_list find zlt_cur_class ) max 0; _ind = _ind + 1; if (_ind > (count (zlt_obj_list) -1)) then {_ind = count (zlt_obj_list) -1 ;}; zlt_cur_class = zlt_obj_list select _ind; [zlt_cur_class, zlt_obj_list] call zlt_fnc_notifyhint; };
			//PU
			case (_key == DIK_PGUP ) : {_ind =  (zlt_obj_list find zlt_cur_class ) max 0; _ind = _ind - 1; if (_ind < 0) then {_ind = 0 ;}; zlt_cur_class = zlt_obj_list select _ind; [zlt_cur_class, zlt_obj_list] call zlt_fnc_notifyhint; };
			
			//end
			case (_key == DIK_END ) : { zlt_new_blocks call zlt_save_comp ; "Сохронил!" call zlt_fnc_notify; };



			
			//delete
			case (_key == DIK_DELETE) : {
				_oldid = zlt_new_blocks find zlt_newlb;
				zlt_new_blocks = zlt_new_blocks - [zlt_newlb];
				zlt_newlb call zlt_new_comp_removeaux; deletevehicle zlt_newlb;
				zlt_newlb = if (count zlt_new_blocks == 0 )then {objNull;} else {zlt_new_blocks select (_oldid - 1);};
				"Удалено!" call zlt_fnc_notify;
			};
			
			// home 
			case (_key == DIK_HOME) : {
				if (!_ctrl) then { zlt_newlb call zlt_new_comp_removeaux; zlt_newlb setposatl [ getposatl zlt_newlb select 0,  getposatl zlt_newlb select 1, 0]; }
				else {
					
				
				if ( (!zlt_new_vectorup && !_alt) || (zlt_new_vectorup && _alt) ) then {
					zlt_newlb call zlt_new_comp_removeaux;
					zlt_newlb setvectorup ( surfaceNormal (getpos zlt_newlb) );
					zlt_newlb call zlt_new_comp_placeaux;
					"Нормаль" call zlt_fnc_notify;
					//zlt_new_vectorup = false;
				} else {
					zlt_newlb call zlt_new_comp_removeaux;
					[zlt_newlb, 0,0] call bis_fnc_setpitchbank;
					zlt_newlb call zlt_new_comp_placeaux;
					//zlt_new_vectorup = true;
					"Вертикаль" call zlt_fnc_notify;
				};
				
				};
			};
			
			case (_key == DIK_F4) : {
				if (zlt_new_vectorup) then {zlt_new_vectorup = false; "Режим нормали" call zlt_fnc_notify;} 
				else { zlt_new_vectorup = true; "Режим вертикали" call zlt_fnc_notify;};
			};
			case (_key == DIK_F5) : {
				if (zlt_new_asl) then {zlt_new_asl = false; "Режим ATL" call zlt_fnc_notify;} 
				else { zlt_new_asl = true; "Режим ASL" call zlt_fnc_notify;};
			};
			case (_key == DIK_F6) : {
				if (zlt_new_micro) then {zlt_new_micro = false; "Микрорежим выключен" call zlt_fnc_notify;} 
				else { zlt_new_micro = true; "Микрорежим" call zlt_fnc_notify;};
			};			
/*
			case (_key == DIK_F7) : {
				if (zlt_new_posmode) then {zlt_new_posmode = false; "Режим позиций выключен" call zlt_fnc_notify;} 
				else { zlt_new_posmode = true; "Режим позиций" call zlt_fnc_notify;};
			};			
*/

			case (_key == DIK_SPACE) : {
				if (_alt) then {
					if ( [zlt_newlb,["Helper_Base_F"]] call zlt_fnc_cycleKindOf ) then {
						zlt_new_blocks = zlt_new_blocks - [zlt_newlb];
						zlt_newlb = zlt_new_blocks select (count (zlt_new_blocks)  - 1);
						call zlt_exportPos;	
					};
				} else {
					PR(_arr) = call compile copyFromClipboard;

					if (not isNil "_arr" and { not isNull _arr} and {typename _arr == typeName []}) then {
						{
							_o = ["Sign_Arrow_Direction_F"] createVehicle _x;
							zlt_new_blocks pushBack _x;
							zlt_newlb = _x;
						} foreach _arr;
						"Позиции загружены" call zlt_fnc_notify;
						copyToClipboard "";
					} else {
						call zlt_placepos;
						call zlt_exportPos;
					};
				};
			};

			// "/"
			case (_key == DIK_DIVIDE and _ctrl) : {
				[] call zlt_select_block; if (not (zlt_newlb in zlt_new_blocks) and not (isnull zlt_newlb)) then {zlt_new_blocks = zlt_new_blocks + [zlt_newlb];}; 
			};
			case (_key == DIK_DIVIDE and not _ctrl) : {
				[] call zlt_select_block; 
			};

			case (_key == DIK_NUMPADSTAR) : {
				call zlt_force_selBlock;
			};

			case (_key == DIK_SUBTRACT) : {
				if (not isNil "zlt_newlb") then {
					zlt_cur_class = typeof zlt_newlb;
				};

			};
			case (_key == DIK_ADD) : {
				if (zlt_cameraMode) then {zlt_camera camSetPos (getpos zlt_newlb); zlt_camera camCommit 0;};
			};
			
			// NUM 8
			case (_key == DIK_NUM8 ) : {_ind =  (zlt_new_blocks find zlt_newlb ) max 0; _ind = _ind + 1; if (_ind > (count (zlt_new_blocks) -1)) then {_ind = count (zlt_new_blocks) -1 ;}; zlt_newlb = zlt_new_blocks select _ind; ("Selected: "+ str [zlt_newlb, typeof zlt_newlb]) call zlt_fnc_notify;};
			// NUM 2
			case (_key == DIK_NUM2 ) : {_ind =  (zlt_new_blocks find zlt_newlb ) max 0; _ind = _ind - 1; if (_ind < 0) then {_ind = 0 ;}; zlt_newlb = zlt_new_blocks select _ind; ("Selected: "+ str [zlt_newlb, typeof zlt_newlb]) call zlt_fnc_notify; };

			
			default {_ret = false;};
		};
	};
	_ret;
};

zlt_exportPos = {
	PR(_pos) = [];
	{
		if ( [_x,["Helper_Base_F"]] call zlt_fnc_cycleKindOf ) then {
			_pos pushBack (getpos _x);
		};
	} foreach zlt_new_blocks;
	diag_log ["zlt_exportPos",_pos];
	copyToClipboard str (_pos);
};

	
// 	[-1.56135,-0.255241,-0.458448],[1.56135,0.255241,0.458448]]
zlt_new_block = {
	comment "v.1";
	_class = zlt_cur_class;
	_ctrl = [_this,0,false ] call bis_fnc_param;
	_placemode = [_this, 1, "UP"] call bis_fnc_param;
	PARAM(_fASL,2,zlt_new_asl)
	PR(_pos1)=[0,0,0];
	
	_new = createVehicle [_class, [0,0,0], [], 0, "CAN_COLLIDE"];

	//_new = if (_class in zlt_new_globalobjs) then { createVehicle [_class, [0,0,0], [], 0, "CAN_COLLIDE"]; } else { _class createVehiclelocal [0,0,0]; };
	if ( (_new call zlt_objGetStdParams) select P_SIM_DISABLE ) then {
		_new enableSimulation false;
	};
	
	if (!zlt_cameraMode) then {
		_pos1 = player modeltoworld [0, ((boundingboxreal _new select 1 select 0) max (boundingboxreal _new select 1 select 1) ) +1 ,0];
	} else {
		_pos1 = zlt_camera modeltoworld [0, ((boundingboxreal _new select 1 select 0) max (boundingboxreal _new select 1 select 1) ) +1 ,0];
	//	_pos1 = screentoworld [0.5,0.5];
	};
	if (_fASL) then {
		_pos1 = ATLtoASL _pos1;
	};
	
	if (not _ctrl and not isNull zlt_newlb) then {
		_olddir = getdir zlt_newlb;
		_new setdir _olddir;
		_oldpos = [0,0,0];
		if (_fASL) then {
			_oldpos = getposasl zlt_newlb; 
		} else {
			_oldpos = getposatl zlt_newlb; 
		};
		_bboxold = boundingboxreal zlt_newlb;
		_bboxnew = boundingboxreal _new;
		
		_lng = 0;
		_cangle = 90;

		_specialFix = 0;
		if (_class in zlt_new_specialFixObjs) then {
			_ind2 = zlt_new_specialFixObjs find _class;
			_data = zlt_new_specialFixObjsData select _ind2;

			switch (_placemode) do {
				case ("RIGHT") : { _specialFix = _data select 0; };
				case ("LEFT") : { _specialFix = _data select 0; };
				case ("UP") : { _specialFix = _data select 1; };
				case ("DOWN") : { _specialFix = _data select 1; };
				case ("FRONT") : { _specialFix = _data select 2; };
				case ("BACK") : { _specialFix = _data select 2; };
			};

		};

		
		switch (_placemode) do {
			case ("RIGHT") : { _lng = abs(_bboxold select 1 select 0 ) + abs (_bboxnew select 0 select 0) - _specialFix; _cangle = 90;};
			case ("LEFT") : { _lng = abs(_bboxold select 1 select 0 ) + abs (_bboxnew select 0 select 0) - _specialFix; _cangle = 270;};
			case ("UP") : { _lng = abs(_bboxold select 1 select 2 ) + abs (_bboxnew select 0 select 2) - _specialFix; _cangle = 0;};
			case ("DOWN") : { _lng = abs(_bboxold select 1 select 2 ) + abs (_bboxnew select 0 select 2) - _specialFix; _cangle = 0;};
			case ("FRONT") : { _lng = abs(_bboxold select 1 select 1 ) + abs (_bboxnew select 0 select 1) - _specialFix; _cangle = 0;};
			case ("BACK") : { _lng = abs(_bboxold select 1 select 1 ) + abs (_bboxnew select 0 select 1) - _specialFix; _cangle = 180;};
		};
		
		
		switch true do {
			case (_class in  zlt_new_15cmfix) : {_lng = _lng - 0.15;};
			case (_class in  zlt_new_5cmfix) : {_lng = _lng - 0.05;};
			case (_class in  zlt_new_10cmfix) : {_lng = _lng - 0.1;};
		};
		
		if not (_placemode in ["UP","DOWN"]) then {
			_pos1 = [_oldpos, _lng , (_olddir + _cangle)] call BIS_fnc_relPos;
		} else {
			if (_placemode == "UP") then {
				_pos1 = [_oldpos select 0, _oldpos select 1, (_oldpos select 2 ) + _lng];
			} else {
				_pos1 = [_oldpos select 0, _oldpos select 1, (_oldpos select 2 ) - _lng];
			};
		
		};
		diag_log format ["NEW BLOCK %1 %2 _olddir=%3 _bboxold=%4 _bboxnew=%5 _lng=%6 _oldpos=%7 _pos1=%8", zlt_newlb, _new, _olddir, _bboxold, _bboxnew, _lng, _oldpos,_pos1  ];
		((typeof _new) + " блок установлен!") call zlt_fnc_notify;
	};
	//diag_log ["C",_pos1];
	
	if (_fASL) then {
		_new setposasl _pos1;
	} else {
		_new setposatl _pos1;
	};
	if (!zlt_new_vectorup) then {
		_new setvectorup ( surfaceNormal (getpos _new) );
	} else {
		_new setVectorUp [0,0,1];
	};
	
	PR(_closestBlocks) = [zlt_new_blocks,[_new],{_input0 distanceSqr _x},"ASCEND"] call BIS_fnc_sortBy;	
	if ((count zlt_new_blocks > 0) and {(_closestBlocks select 0) distance _new < 0.05} ) then {
		"Ошибка, слишком близко к другому блоку!" call zlt_fnc_notify;
		deleteVehicle _new;
	} else {
		zlt_newlb = _new;
		zlt_new_blocks = zlt_new_blocks + [zlt_newlb];
	};

};

zlt_new_comp = {
	private "_declaration";
	_declaration = +(_this);

	_mainclass = _declaration select 0;
	if ( isNull zlt_newlb ) exitWith {};
	if ( ! ([zlt_newlb, [_mainclass]] call zlt_fnc_cycleKindOf) ) exitWith { "Класс объекта не совпадает" call zlt_fnc_notify };
	

	diag_log ["newcomp", _mainclass, _declaration];
	_newblocks = [];

	_first = zlt_newlb;
	_first setVariable ["zlt_new_masterblock", _first];
	_first setVariable ["zlt_new_decl", _declaration];

	_first call zlt_new_comp_placeaux;
	zlt_newlb = _first;

};


zlt_new_comp_placeaux = {
	private "_first";
	_first = _this;
	_declaration = _first getVariable ["zlt_new_decl", []];
	
	_dir = getDir _first;
	_pitchbank = _first call BIS_fnc_getPitchBank;
	_pitch = _pitchBank select 0;
	_bank = _pitchBank select 1;
	_newblocks = [];

	{
		diag_log ["placeaux", _x, _declaration, _foreachindex];
		if ((_foreachindex-1) mod 5 == 0) then {

			_new = _x createVehiclelocal [0,0,0];
			_dir2 = _declaration select  (_foreachindex + 2);
			_pitch2 = _declaration select (_foreachindex + 3);
			_bank2 = _declaration select (_foreachindex + 4);
			
			_new setposatl (_first modelToWorld (_declaration select (_foreachindex + 1)));
			
			_new setDir (_dir2 + _dir);
			[_new, _pitch2 + _pitch, _bank2 + _bank2] call bis_fnc_setpitchbank;
//			zlt_new_blocks = zlt_new_blocks + [_new];
			_newblocks = _newblocks + [_new];
			_new setVariable ["zlt_new_masterblock", _first];

		};

	} foreach _declaration;
	_first setVariable ["zlt_new_childblocks", _newblocks ];

};

zlt_new_comp_removeaux = {
	private "_first";

	_first = _this;
	_blocks = _first getVariable ["zlt_new_childblocks",[]];
	diag_log ["Remove aux blocks:", _blocks];
	{
		deleteVehicle _x;
		diag_log ["Remove block:", _x];

	} foreach _blocks;
	_first setVariable ["zlt_new_childblocks", []];

};



zlt_force_selBlock = {
	PR(_closestBlocks)=[];
	PR(_pos)=[];
	if (zlt_cameraMode) then {
		_pos = getPos zlt_camera;
	} else {
		_pos = getpos player;
	};
	_closestBlocks = [zlt_new_blocks,[_pos],{_input0 distanceSqr _x},"ASCEND"] call BIS_fnc_sortBy;	
	zlt_newlb = _closestBlocks select 0;
};


zlt_select_block = {
	if (zlt_cameraMode) then {
		if not (isNull zlt_cameraTarget ) then {
			_masterblock = zlt_cameraTarget getVariable ["zlt_new_masterblock", zlt_cameraTarget];
			zlt_newlb = _masterblock;
		};
	} else {
		if not (isNull cursortarget) then {
			_masterblock = cursortarget getVariable ["zlt_new_masterblock", cursorTarget];
			zlt_newlb = _masterblock;
		};
	};
};

zlt_save_comp = {
	_objs = _this ;
	_text = (_objs call zlt_fnc_getallcode);
	
	copytoclipboard _text;
	

};



zlt_placepos = {
	PR(_pos1)=[0,0,0];
	_new = createVehicle ["Sign_Arrow_Direction_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	if (!zlt_cameraMode) then {
		_pos1 = player modeltoworld [0, ((boundingboxreal _new select 1 select 0) max (boundingboxreal _new select 1 select 1) ) +1 ,0];
	} else {
		//_pos1 = zlt_camera modeltoworld [0, ((boundingboxreal _new select 1 select 0) max (boundingboxreal _new select 1 select 1) ) +1 ,0];
		_pos1 = screentoworld [0.5,0.5];
	};
	_new setposatl _pos1;
	//zlt_positions pushBack _new;
	zlt_new_blocks pushBack _new;
	zlt_newlb = _new;
};



Lx_fnc_floatToString = {
	private "_arr";
	_arr = toArray str (_this % 1);
	_arr set [0, 'x'];
	_arr = _arr - ['x'];
	toString (toArray str (_this - _this % 1) + _arr)
};

KK_fnc_positionToString = {
	{ _this = if (_forEachIndex == 0 and _forEachIndex != 2) then [
		{_x call Lx_fnc_floatToString},
		{if (_forEachIndex ==1) then [{_this + "," + (_x call Lx_fnc_floatToString)},{_this + "," + (str _x)}]}];
	} forEach +_this;
	"["+_this+"]"
};


zlt_fnc_initUI = {
	disableSerialization;
	uiNamespace setVariable ["zlt_new_objects_lb", findDisplay 46 ctrlCreate ["RscListBox", -1]];
	(uiNamespace getVariable "zlt_new_objects_lb") ctrlSetPosition [safeZoneX,safezoneY+0.5,0.3,0.5];
	(uiNamespace getVariable "zlt_new_objects_lb") ctrlSetFade 0.25;
	(uiNamespace getVariable "zlt_new_objects_lb") ctrlSetFontHeight 0.03;
	(uiNamespace getVariable "zlt_new_objects_lb") ctrlCommit 0;
	
	zlt_new_objects_lb_cb = [] spawn {
		uiSleep 5;
		(uiNamespace getVariable "zlt_new_objects_lb") ctrlShow false;
		(uiNamespace getVariable "zlt_new_objects_lb") ctrlCommit 0;
	};
};


if (isNil "zlt_eh_keydown") then {

	waitUntil { (!isNull (findDisplay 46) || !(alive player))}; 
	
	(findDisplay 46) displayRemoveAllEventHandlers "KeyDown";
	(findDisplay 46) displayRemoveAllEventHandlers "KeyUp";
	
	zlt_eh_keydown = (findDisplay 46) displayAddEventHandler ["KeyDown", "_aaa=(_this call zlt_new_keydown)"];	
	zlt_eh_keyup = (findDisplay 46) displayAddEventHandler ["KeyUp", "_ccc=(_this call zlt_new_keyup)"];	
	zlt_eh_mouse = (findDisplay 46) displayAddEventHandler ["MouseMoving", "_bbb=(_this call zlt_new_mouseMoving)"];	

	// ВИДЖЕТ СПИСКА
	call zlt_fnc_initUI;

	zlt_cur_class = zlt_obj_list select 0;	
	if (isnil "zlt_new_blocks") then { zlt_new_blocks = [];} else {
		{
			_cb = _x getvariable ["zlt_cb", false];
			if (_cb) then {
				//zlt_new_blocks deleteAt (zlt_new_blocks find _x);
				zlt_new_blocks = zlt_new_blocks - [_x];
				deleteVehicle _x;
			};
			_decl = _x getvariable ["zlt_new_decl", []];
			if (count (_decl) != 0 ) then {
				_x call zlt_new_comp_placeaux;
			};
			
			
		} foreach zlt_new_blocks;
	};
	zlt_newlb = objNull;
	zlt_new_vectorup = true;
	zlt_new_asl = true;
	zlt_new_micro = false;
	
	// камера
	zlt_cameraMode = false;
	zlt_camerakeys = [];
	_DIKcodes = true call bis_fnc_keyCode;
	_DIKlast = _DIKcodes select (count _DIKcodes - 1);
	for "_k" from 0 to (_DIKlast - 1) do {
		zlt_camerakeys set [_k,false];
	};

	zlt_cameraTarget = objNull;

	// композиции
	zlt_is_comp = false;


	// позиции 
	zlt_positions = [];
	zlt_new_posmode = false;
	
	// режим установки 
	zlt_new_is_plc_mode = false;
	// handle колбека выключения режима установки 
	zlt_new_plc_mode_cb = nil;

	addMissionEventHandler ["Draw3D", "call zlt_onEachFrame"];
	
	[] spawn {
		while {true} do {
			sleep 0.1;
			call zlt_fnc_modeindication;
		};
	};

};



 