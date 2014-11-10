// by [STELS]Zealot
//_unit = [_this, 0, objNull] call BIS_fnc_param;

if (not local _this) exitWith {};

clearWeaponCargoGlobal _this;
clearMagazineCargoGlobal _this;

switch true do {
	case (_this isKindOf "MRAP_01_base_F") : {
			_this addMagazineCargoGlobal ["HandGrenade",5];
			_this addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",8];
			_this addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag",3];
			_this addMagazineCargoGlobal ["SmokeShell",8];
			_this addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",5];
			_this addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell",8];				
			_this addBackpackCargoGlobal ["tf_rt1523g",1];

	};
	case (_this isKindOf "MRAP_02_base_F") : {
			_this addMagazineCargoGlobal ["HandGrenade",5];
			_this addMagazineCargoGlobal ["30Rnd_65x39_caseless_green",8];
			_this addMagazineCargoGlobal ["150Rnd_762x51_Box",2];
			_this addMagazineCargoGlobal ["SmokeShell",8];
			_this addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",5];
			_this addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell",8];
			_this addBackpackCargoGlobal ["tf_mr3000",1];			


	};
	case (_this isKindOf "MRAP_03_base_F") : {
			_this addMagazineCargoGlobal ["HandGrenade",5];
			_this addMagazineCargoGlobal ["30Rnd_556x45_Stanag",8];
			_this addMagazineCargoGlobal ["200Rnd_65x39_cased_Box",2];
			_this addMagazineCargoGlobal ["SmokeShell",8];
			_this addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",5];
			_this addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell",8];				


	};
	case (_this isKindOf "APC_Wheeled_01_base_F") : {
			_this addMagazineCargoGlobal ["HandGrenade",10];
			_this addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",16];
			_this addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag",6];
			_this addMagazineCargoGlobal ["SmokeShell",16];
			_this addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",10];
			_this addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell",16];				
			_this addBackpackCargoGlobal ["tf_rt1523g",1];
			_this addItemCargoGlobal ["ItemGPS",1];

	};
	case (_this isKindOf "APC_Wheeled_02_base_F") : {
			_this addMagazineCargoGlobal ["HandGrenade",10];
			_this addMagazineCargoGlobal ["30Rnd_65x39_caseless_green",16];
			_this addMagazineCargoGlobal ["150Rnd_762x51_Box",4];
			_this addMagazineCargoGlobal ["SmokeShell",16];
			_this addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",10];
			_this addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell",16];				
			_this addBackpackCargoGlobal ["tf_mr3000",1];			
			_this addItemCargoGlobal ["ItemGPS",1];

	};
	case (_this isKindOf "APC_Wheeled_03_base_F") : {
			_this addMagazineCargoGlobal ["HandGrenade",10];
			_this addMagazineCargoGlobal ["30Rnd_556x45_Stanag",16];
			_this addMagazineCargoGlobal ["200Rnd_65x39_cased_Box",3];
			_this addMagazineCargoGlobal ["SmokeShell",16];
			_this addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",10];
			_this addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell",16];			
			_this addItemCargoGlobal ["ItemGPS",1];

	};
	case (_this isKindOf "APC_Tracked_01_base_F") : {
			_this addMagazineCargoGlobal ["HandGrenade",10];
			_this addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",24];
			_this addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag",12];
			_this addMagazineCargoGlobal ["SmokeShell",16];
			_this addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",10];
			_this addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell",16];				
			_this addBackpackCargoGlobal ["tf_rt1523g",1];
			_this addItemCargoGlobal ["ItemGPS",1];

	};
	case (_this isKindOf "APC_Tracked_02_base_F") : {
			_this addMagazineCargoGlobal ["HandGrenade",10];
			_this addMagazineCargoGlobal ["30Rnd_65x39_caseless_green",24];
			_this addMagazineCargoGlobal ["150Rnd_762x51_Box",8];
			_this addMagazineCargoGlobal ["SmokeShell",16];
			_this addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",10];
			_this addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell",16];				
			_this addBackpackCargoGlobal ["tf_mr3000",1];			
			_this addItemCargoGlobal ["ItemGPS",1];


	};	
	case (_this isKindOf "APC_Tracked_03_base_F") : {
			_this addMagazineCargoGlobal ["HandGrenade",10];
			_this addMagazineCargoGlobal ["30Rnd_556x45_Stanag",24];
			_this addMagazineCargoGlobal ["200Rnd_65x39_cased_Box",6];
			_this addMagazineCargoGlobal ["SmokeShell",16];
			_this addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",10];
			_this addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell",16];				
			_this addItemCargoGlobal ["ItemGPS",1];

	};
	case (_this isKindOf "O_Truck_03_covered_F" || _this isKindOf "O_Truck_03_transport_F") : {
			_this addMagazineCargoGlobal ["HandGrenade",12];
			_this addMagazineCargoGlobal ["30Rnd_65x39_caseless_green",32];
			_this addMagazineCargoGlobal ["150Rnd_762x51_Box",12];
			_this addMagazineCargoGlobal ["SmokeShell",16];
			_this addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",10];
			_this addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell",16];				
			_this addBackpackCargoGlobal ["tf_mr3000",1];			

	};	
	case (_this isKindOf "B_Truck_01_covered_F" || _this isKindOf "B_Truck_01_transport_F") : {
			_this addMagazineCargoGlobal ["HandGrenade",12];
			_this addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag",32];
			_this addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag",16];
			_this addMagazineCargoGlobal ["SmokeShell",16];
			_this addMagazineCargoGlobal ["1Rnd_HE_Grenade_shell",12];
			_this addMagazineCargoGlobal ["1Rnd_Smoke_Grenade_shell",16];				
			_this addBackpackCargoGlobal ["tf_rt1523g",1];
	};	

};



