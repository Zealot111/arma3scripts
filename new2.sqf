hint "Загрузка началась...";


// A3_Bush A3_Plants A3_Stones A3_Trees RSPN_Assets
// ["Ficus_Bush_2","Ficus_Bush_1","Cane2","Cane1","Ficus_Bush_3","Oleander1","Oleander2"."Oleander_White","Thistle_Thorn_Green_Bush"] + ["BluntRock_Apart", "BluntRock_Monolith","BluntRock_Spike","BluntRock_WallH","BluntRock_WallV","BluntStone1","BluntStone1_LC","BluntStone2","BluntStone2_LC","BluntStone3","BluntStone3_LC","BluntStone_Erosion"] + ["Paper_Mulberry","Ficus_1","Ficus_2","Fraxinus","Olive_1","Olive_2","Palm_1","Palm_2","Pine_1","Pine_2","Pine_3","Pine_4","Poplar_Dead","Poplar","Oak","Fallen_Branch1","Fallen_Branch2","Fallen_Branch3","Branch_Big"]
// ["CS_End01","CB_End01","CS_End02","CB_End02","CS_Long","CB_Long","CS_Short","CB_Short","CS_Entrance01","CB_Entrance01","CS_Entrance02","CB_Entrance02","CS_Intersect01","CB_Intersect01","Cover_Sharprock","Cover_Bluntstone","Cover_Sand_Inset","Cover_Dirt_Inset","Cover_Grass_Inset","CS_H45","CB_H45","CS_H90","CB_H90","CS_Intersect02","CB_Intersect02"]

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

ZltMap = {
    private ["_res","_txt","_fr"]; _res = []; _code = _this select 1;
    {_fr = _x call _code; if (!isNil _fr) then {_res pushBack _fr;};} foreach (_this select 0);
};

// https://community.bistudio.com/wiki/Arma_3_CfgPatches_CfgVehicles

zlt_obj_list_index = 0;
zlt_obj_list_all = [
    ['A3_Structures_F_Mil_Fortification','A3_Structures_F_Mil_BagBunker','A3_Structures_F_Mil_BagFence',"A3_Structures_F_Mil_Shelters"] call zlt_units
    ,[["A3_Structures_F_Mil_Cargo","A3_Structures_F_Mil_Radar","A3_Structures_F_Mil_Offices","A3_Structures_F_Mil_Barracks","A3_Structures_F_Mil_Bunker","A3_Structures_F_Mil_TentHangar","A3_Structures_F_Research"] call zlt_units, { not (["ruins", _x] call bis_fnc_instring) }] call zlt_filter
    ,["A3_Structures_F_Walls"] call zlt_units
    ,["A3_Structures_F_Training" call zlt_units, { (["shoot_house", _x] call bis_fnc_instring) or (["obstacle", _x] call bis_fnc_instring) or (["concrete", _x] call bis_fnc_instring) }] call zlt_filter
    ,["Land_Pallet_static_F","Land_Pallet_vertical_static_F","A3_Structures_F_Civ_Constructions","A3_Structures_F_EPA_Civ_Constructions","A3_Structures_F_Civ_Camping"] call zlt_units
    ,(["A3_Structures_F_Items_Documents","A3_Structures_F_Items_Electronics","A3_Structures_F_Items_Cans","A3_Structures_F_Items_Gadgets","A3_Structures_F_Items_Luggage","A3_Structures_F_Items_Stationery","A3_Structures_F_Items_Tools","A3_Structures_F_Items_Valuables","A3_Structures_F_EPA_Items_Electronics","A3_Structures_F_EPA_Items_Food","A3_Structures_F_EPA_Items_Medical","A3_Structures_F_EPA_Items_Tools","A3_Structures_F_EPA_Items_Vessels","A3_Structures_F_EPC_Items_Documents","A3_Structures_F_EPC_Items_Electronics"] call zlt_units)
    ,[["A3_Structures_F_Households_Addons","A3_Structures_F_Households_House_Big01",'A3_Structures_F_Households_House_Big02','A3_Structures_F_Households_House_Shop01','A3_Structures_F_Households_House_Shop02', 'A3_Structures_F_Households_House_Small01', 'A3_Structures_F_Households_House_Small02', 'A3_Structures_F_Households_House_Small03', 'A3_Structures_F_Households_Slum', 'A3_Structures_F_Households_Stone_Big', 'A3_Structures_F_Households_Stone_Shed', 'A3_Structures_F_Households_Stone_Small', 'A3_Structures_F_Households_WIP','A3_Structures_F_Ind_AirPort' ] call zlt_units,{ not (["ruins", _x] call bis_fnc_instring)  and not (["_dam_", _x] call bis_fnc_instring) and not (["_d_", _x] call bis_fnc_instring) } ] call zlt_filter
    ,(["A3_Structures_F_Naval_Piers","A3_Structures_F_Naval_RowBoats"] call zlt_units)
    ,["Land_Bench_F","Land_CashDesk_F","Land_HeatPump_F","Land_ChairPlastic_F","Land_ChairWood_F","Land_Icebox_F","Land_Metal_rack_F","Land_Metal_rack_Tall_F","Land_Metal_wooden_rack_F","Land_Rack_F","Land_ShelvesMetal_F","Land_ShelvesWooden_F","Land_TableDesk_F"]
    ,["A3_Structures_F_EPB_Furniture","A3_Structures_F_Furniture","A3_Structures_F_Items_Vessels", "A3_Structures_F_EPA_Civ_Camping","A3_Structures_F_EPB_Items_Vessels"] call zlt_units
    ,["A3_Structures_F_Civ_InfoBoards","A3_Structures_F_EPC_Civ_InfoBoards","A3_Signs_F","A3_Signs_F_AD","A3_Structures_F_EPB_Civ_Accessories","A3_Structures_F_EPC_Civ_Accessories"] call zlt_units
    ,["Land_fort_rampart_EP1","Land_fort_rampart","Hedgehog","Misc_cargo_cont_small","TK_GUE_WarfareBUAVterminal_Base_EP1","TK_GUE_WarfareBArtilleryRadar_Base_EP1","TK_GUE_WarfareBAntiAirRadar_Base_EP1","Fort_Barricade","Land_fort_artillery_nest_EP1","Land_fort_artillery_nest","Hhedgehog_concrete","Hhedgehog_concreteBig","Barrack2","PowGen_Big","Land_Misc_Cargo1E_EP1","Land_BarGate2","Land_tent_east","CampEast_EP1","Land_GuardShed","Land_Antenna","Land_A_Villa_EP1","Land_Mil_Barracks_i_EP1"]
    ,["A3_Structures_F_Dominants_Hospital", "A3_Structures_F_EPC_Dominants_GhostHotel"] call zlt_units
    ,(["A3_Structures_F_Civ_Garbage","A3_Structures_F_EPA_Mil_Scrapyard","A3_Structures_F_Wrecks","A3_Structures_F_EPB_Civ_Garbage"] call zlt_units)+["Submarine_01_F"]
    ,["Ficus_Bush_2","Ficus_Bush_1","Cane2","Cane1","Ficus_Bush_3","Oleander1","Oleander2","Oleander_White","Thistle_Thorn_Green_Bush"] + ["BluntRock_Apart", "BluntRock_Monolith","BluntRock_Spike","BluntRock_WallH","BluntRock_WallV","BluntStone1","BluntStone1_LC","BluntStone2","BluntStone2_LC","BluntStone3","BluntStone3_LC","BluntStone_Erosion"] + ["Paper_Mulberry","Ficus_1","Ficus_2","Fraxinus","Olive_1","Olive_2","Palm_1","Palm_2","Pine_1","Pine_2","Pine_3","Pine_4","Poplar_Dead","Poplar","Oak","Fallen_Branch1","Fallen_Branch2","Fallen_Branch3","Branch_Big"]
    ,["CS_End01","CB_End01","CS_End02","CB_End02","CS_Long","CB_Long","CS_Short","CB_Short","CS_Entrance01","CB_Entrance01","CS_Entrance02","CB_Entrance02","CS_Intersect01","CB_Intersect01","Cover_Sharprock","Cover_Bluntstone","Cover_Sand_Inset","Cover_Dirt_Inset","Cover_Grass_Inset","CS_H45","CB_H45","CS_H90","CB_H90","CS_Intersect02","CB_Intersect02"]
    ,(["xCam_Metal" call zlt_units, {!(["_base", _x] call bis_fnc_instring) }] call zlt_filter)
    ,["xcam_objects"] call zlt_units
    ,(["xcam_pipe" call zlt_units, {!(["_base", _x] call bis_fnc_instring) }] call zlt_filter)
    ,["xcam_wood"] call zlt_units
    ,(["xcam_woodworks" call zlt_units, {!(["_base", _x] call bis_fnc_instring) }] call zlt_filter)
    ,["Land_Dam_Conc_20","Land_Dam_ConcP_20","Land_Dam_Barrier_40","land_mbg_apartments_big_04","land_mbg_brickhouse_01","land_mbg_brickhouse_02","land_mbg_brickhouse_03","mbg_apartments_big_04_EO","mbg_brickhouse_01_EO","mbg_brickhouse_02_EO","mbg_brickhouse_03_EO","Fortress1","Fortress2","Shed","ShedSmall","ShedBig","Camp","CampEast","ACamp","MASH","Land_Molo_beton","Land_Molo_drevo","Land_Molo_drevo_bs","Land_Molo_drevo_end","Land_Molo_krychle","Land_Molo_krychle2","Land_Cihlovej_dum","Land_Cihlovej_Dum_in","Land_Cihlovej_Dum_mini","Land_Deutshe_mini","Land_Dulni_bs","Land_Dum_zboreny","Land_Hospoda_mesto","Land_House_y","Land_Hut_old02","Land_Podesta_1_cube","Land_Podesta_1_cube_long","Land_Podesta_1_cornl","Land_Podesta_1_cornp","Land_Podesta_1_mid_cornl","Land_Podesta_1_mid_cornp","Land_Podesta_1_mid","Land_Podesta_1_stairs","Land_Podesta_1_stairs2","Land_Podesta_1_stairs3","Land_Podesta_1_stairs4","Land_Podesta_5","Land_Podesta_10","Land_Podesta_s5","Land_Podesta_s10","Land_Ryb_domek","Land_Stodola_old_open","Land_Army_hut3_long_int","Land_Army_hut3_long","Land_Army_hut2_int","Land_Army_hut2","Land_Army_hut_int","Land_Army_hut_storrage","Land_Bouda2_vnitrek","Land_Garaz_s_tankem","Land_Hruzdum","Land_Dum_rasovna","Land_Hlaska","Land_Panelak","Land_Sara_Domek_sedy","Land_Posed","Land_Leseni4x","Land_Leseni2x","Land_Sara_domek_zluty","Land_Watertower1","Land_Sara_zluty_statek_in","Land_Panelak2","Land_Panelak3","Land_Hotel","Land_Dum_mesto2","Land_Trafostanica_mala","Land_Dum_olezlina","Land_Dum_mesto_in","Land_Hangar_2","Land_Garaz_mala","Land_Garaz_long_open","Land_Budova2","Land_Budova3","Land_Dum_olez_istan2_maly","Land_Dum_olez_istan2","Land_Dum_olez_istan2_open2","Land_Dum_olez_istan2_open_dam","Land_Dum_olez_istan2_open2_dam","Land_Dum_olez_istan1","Land_Dum_olez_istan1_open2","Land_panelak_one_floor","Land_panelak_top_floor_rooms","Land_R_Minaret","Land_jezekbeton","Barrels","Camera1","Computer","TVStudio","M113Wreck","BlackhawkWreck","Vec03","FenceWood","FenceWoodPalet","Wire","Heli_H_civil","Heli_H_rescue","Land_water_tank","Land_ladder","Land_ladder_half","snowman","snow","SeaFox_EP1","Land_A_CraneCon","Land_Barn_W_01","Land_Barn_W_02","Land_A_Castle_Stairs_A","Land_A_Office01_ruins","Land_A_Office01","Land_A_Hospital","ladder","LadderLong","Land_A_Office02","Land_a_stationhouse","Land_Shed_Ind02","Land_Vysilac_budova","Land_vodni_vez","Land_pristresek_camo","Land_MBG_GER_HUS_1","Land_MBG_GER_HUS_2","Land_MBG_GER_HUS_3","Land_MBG_GER_HUS_4","Land_MBG_GER_RHUS_1","Land_MBG_GER_RHUS_2","Land_MBG_GER_RHUS_3","Land_MBG_GER_RHUS_4","Land_MBG_GER_RHUS_5","Land_MBG_GER_ESTATE_1","Land_MBG_GER_ESTATE_2","Land_MBG_Beach_Chair_1","Land_MBG_Beach_Chair_2","Land_MBG_Beach_Chair_3","Land_MBG_GER_SUPERMARKET_1","Land_MBG_GER_SUPERMARKET_2","Land_MBG_GER_SUPERMARKET_3","Land_MBG_GER_SUPERMARKET_4","Land_MBG_GER_PUB_1","Land_MBG_GER_PUB_2","Land_MBG_HeavyShelter","Land_MBG_ATC_Segment","Land_MBG_ATC_Tower","Land_MBG_ATC_Base","Land_A_GeneralStore_01","Land_A_Pub_01","Land_Misc_Cargo1Ao","Land_Misc_Cargo1Bo","Land_Misc_Cargo1B","Misc_Cargo1B_military","Misc_Cargo1Bo_civil","Land_Misc_Cargo1C","Land_Misc_Cargo1D","Land_Misc_Cargo1E","Land_Misc_Cargo1F","Land_Misc_Cargo1G","Land_Misc_Cargo2B","Land_Misc_Cargo2C","Land_Misc_Cargo2D","Land_Misc_Cargo2E","Land_HBarrier_large","Land_HBarrier1","Land_HBarrier3","Land_HBarrier5","Land_fort_bagfence_corner","Land_fort_bagfence_long","Land_fort_bagfence_round","Land_BagFenceCorner","Land_BagFenceEnd","Land_BagFenceLong","Land_BagFenceRound","Land_BagFenceShort","Land_fort_artillery_nest","Land_fort_rampart","Fort_RazorWire","Fort_Crate_wood","WarfareBCamp","Fort_CAmp","Land_fortified_nest_small","Fort_Nest","Land_Fort_Watchtower","Fort_Barracks_USMC","Hedgehog","Hhedgehog_concrete","Hhedgehog_concreteBig","Fort_EnvelopeSmall","Fort_EnvelopeBig","Fort_Barricade","Land_Ind_Timbers","Land_Ind_BoardsPack1","Land_Ind_BoardsPack2","Haystack","Land_seno_balik","Misc_palletsfoiled_heap","Misc_palletsfoiled","Land_A_tent","Land_tent_east","Land_GuardShed","Land_Antenna","Land_CamoNet_NATO","Land_CamoNetVar_NATO","Land_CamoNetB_NATO","Land_CamoNet_EAST","Land_CamoNetVar_EAST","Land_CamoNetB_EAST","76n6ClamShell","PowGen_Big","Land_BarGate2","Land_Barrack2","Misc_cargo_cont_small","Misc_cargo_cont_small2","Misc_cargo_cont_tiny","Misc_cargo_cont_net1","Misc_cargo_cont_net2","Misc_cargo_cont_net3","Land_obstacle_get_over","Land_obstacle_prone","Land_obstacle_run_duck","Land_WoodenRamp","Land_ConcreteRamp","Land_ConcreteBlock","Land_Dirthump01","Land_Dirthump02","Land_Dirthump03","BRDMWreck","UralWreck","BMP2Wreck","HMMWVWreck","T72Wreck","WarfareBDepot","Base_WarfareBBarracks","USMC_WarfareBBarracks","RU_WarfareBBarracks","CDF_WarfareBBarracks","Ins_WarfareBBarracks","Gue_WarfareBBarracks","Base_WarfareBContructionSite","USMC_WarfareBContructionSite","USMC_WarfareBContructionSite1","RU_WarfareBContructionSite","RU_WarfareBContructionSite1","CDF_WarfareBContructionSite","CDF_WarfareBContructionSite1","Ins_WarfareBContructionSite","USMC_WarfareBLightFactory","RU_WarfareBLightFactory","USMC_WarfareBHeavyFactory","RU_WarfareBHeavyFactory","CDF_WarfareBHeavyFactory","USMC_WarfareBAircraftFactory","RU_WarfareBAircraftFactory","USMC_WarfareBFieldhHospital","RU_WarfareBFieldhHospital","CDF_WarfareBFieldhHospital","GUE_WarfareBFieldhHospital","USMC_WarfareBAntiAirRadar","RU_WarfareBAntiAirRadar","CDF_WarfareBAntiAirRadar","INS_WarfareBAntiAirRadar","GUE_WarfareBAntiAirRadar","USMC_WarfareBArtilleryRadar","RU_WarfareBArtilleryRadar","CDF_WarfareBArtilleryRadar","Ins_WarfareBArtilleryRadar","Gue_WarfareBArtilleryRadar","USMC_WarfareBUAVterminal","RU_WarfareBUAVterminal","CDF_WarfareBUAVterminal","INS_WarfareBUAVterminal","GUE_WarfareBUAVterminal","USMC_WarfareBVehicleServicePoint","RU_WarfareBVehicleServicePoint","Base_WarfareBBarrier5x","Base_WarfareBBarrier10x","Base_WarfareBBarrier10xTall","BRDM2_HQ_Gue_unfolded","BTR90_HQ_unfolded","LAV25_HQ_unfolded","BMP2_HQ_INS_unfolded","BMP2_HQ_CDF_unfolded","WarfareBunkerSign","C130J_wreck_EP1","Land_Wreck_C130J_EP1_ruins","Land_fort_artillery_nest_EP1","Land_fort_rampart_EP1","Land_fortified_nest_big_EP1","Land_fortified_nest_small_EP1","Land_Fort_Watchtower_EP1","Hedgehog_EP1","Fort_EnvelopeSmall_EP1","Fort_EnvelopeBig_EP1","Fort_Barricade_EP1","Land_CamoNet_NATO_EP1","Land_CamoNetVar_NATO_EP1","Land_CamoNetB_NATO_EP1","Land_CamoNet_EAST_EP1","Land_CamoNetVar_EAST_EP1","Land_CamoNetB_EAST_EP1","76n6ClamShell_EP1","PowGen_Big_EP1","Land_PowGen_Big_ruins_EP1","Land_Barrack2_EP1","Misc_cargo_cont_small_EP1","AmmoCrates_NoInteractive_Large","Camp_EP1","CampEast_EP1","C130J_static_EP1","Land_ladderEP1","Land_ladder_half_EP1","Land_Dirthump01_EP1","Land_Dirthump02_EP1","Land_Dirthump03_EP1","Land_Fuel_tank_stairs_ep1","Land_Misc_Cargo1Ao_EP1","Land_Misc_Cargo1Bo_EP1","Land_Misc_Cargo1Eo_EP1","Land_Misc_Cargo1E_EP1","Land_Misc_Cargo1A_EP1","Land_Misc_Cargo1B_EP1","Land_Misc_Cargo1C_EP1","Land_Misc_Cargo1D_EP1","Land_Misc_Cargo2A_EP1","Land_Misc_Cargo2B_EP1","Land_Misc_Cargo2C_EP1","Land_Misc_Cargo2D_EP1","Land_Misc_CargoMarket1a_EP1","Land_Misc_Cargo2E_EP1","Dirtmount_EP1","US_WarfareBBarracks_Base_EP1","TK_WarfareBBarracks_Base_EP1","US_WarfareBBarracks_EP1","TK_WarfareBBarracks_EP1","US_WarfareBLightFactory_base_EP1","TK_WarfareBLightFactory_base_EP1","TK_GUE_WarfareBLightFactory_base_EP1","US_WarfareBLightFactory_EP1","TK_WarfareBLightFactory_EP1","TK_GUE_WarfareBLightFactory_EP1","US_WarfareBHeavyFactory_Base_EP1","TK_WarfareBHeavyFactory_Base_EP1","TK_GUE_WarfareBHeavyFactory_Base_EP1","US_WarfareBHeavyFactory_EP1","TK_WarfareBHeavyFactory_EP1","TK_GUE_WarfareBHeavyFactory_EP1","US_WarfareBAircraftFactory_Base_EP1","TK_WarfareBAircraftFactory_Base_EP1","TK_GUE_WarfareBAircraftFactory_Base_EP1","US_WarfareBAircraftFactory_EP1","TK_WarfareBAircraftFactory_EP1","TK_GUE_WarfareBAircraftFactory_EP1","US_WarfareBFieldhHospital_Base_EP1","TK_WarfareBFieldhHospital_Base_EP1","TK_GUE_WarfareBFieldhHospital_Base_EP1","US_WarfareBFieldhHospital_EP1","TK_WarfareBFieldhHospital_EP1","TK_GUE_WarfareBFieldhHospital_EP1","US_WarfareBAntiAirRadar_Base_EP1","TK_WarfareBAntiAirRadar_Base_EP1","TK_GUE_WarfareBAntiAirRadar_Base_EP1","US_WarfareBAntiAirRadar_EP1","TK_WarfareBAntiAirRadar_EP1","TK_GUE_WarfareBAntiAirRadar_EP1","US_WarfareBArtilleryRadar_Base_EP1","TK_WarfareBArtilleryRadar_Base_EP1","TK_GUE_WarfareBArtilleryRadar_Base_EP1","US_WarfareBArtilleryRadar_EP1","TK_WarfareBArtilleryRadar_EP1","TK_GUE_WarfareBArtilleryRadar_EP1","US_WarfareBUAVterminal_Base_EP1","TK_WarfareBUAVterminal_Base_EP1","TK_GUE_WarfareBUAVterminal_Base_EP1","US_WarfareBUAVterminal_EP1","TK_WarfareBUAVterminal_EP1","TK_GUE_WarfareBUAVterminal_EP1","US_WarfareBVehicleServicePoint_Base_EP1","TK_WarfareBVehicleServicePoint_Base_EP1","TK_GUE_WarfareBVehicleServicePoint_Base_EP1","US_WarfareBVehicleServicePoint_EP1","TK_WarfareBVehicleServicePoint_EP1","TK_GUE_WarfareBVehicleServicePoint_EP1","US_WarfareBBarrier5x_EP1","US_WarfareBBarrier10x_EP1","US_WarfareBBarrier10xTall_EP1","BRDM2_HQ_TK_GUE_unfolded_Base_EP1","BRDM2_HQ_TK_GUE_unfolded_EP1","M1130_HQ_unfolded_Base_EP1","BMP2_HQ_TK_unfolded_Base_EP1","Land_A_TVTower_Base","Land_A_TVTower_Mid","Land_A_TVTower_Top","Land_A_Minaret_Porto_EP1","Land_A_Villa_EP1","Land_Misc_Coltan_Heap_EP1","Land_mbg_observation_tower","Land_mbg_companybuilding_1","FootBridge_0_ACR","FootBridge_30_ACR","Land_Device_assembled_F","Land_Device_disassembled_F","Hotze_lavicka_1","Hotze_Place_1","Hotze_Place_2","Hotze_Place_3","Hotze_Place_4","Hotze_Place_6","Hotze_SwalkA_B1","Hotze_SwalkA_B2","Hotze_SwalkA_B3","Hotze_Panelak1","Hotze_Panelak2","Hotze_Panelak3","Land_Hotze_HBridge_A","Land_ibr_most_stred30","Land_ibr_most_bez_lamp","Land_ibr_Kamenny_most30","Land_GymBench_01_F","Land_GymRack_01_F","Land_GymRack_02_F","Land_GymRack_03_F","rhs_Flag_Russia_F"]
];

zltNewObjListAllCurIndSel = []; zltNewObjListAllCurIndSel resize (count zlt_obj_list_all);

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
    +["CS_End01","CB_End01","CS_End02","CB_End02","CS_Long","CB_Long","CS_Short","CB_Short","CS_Entrance01","CB_Entrance01","CS_Entrance02","CB_Entrance02","CS_Intersect01","CB_Intersect01","Cover_Sharprock","Cover_Bluntstone","Cover_Sand_Inset","Cover_Dirt_Inset","Cover_Grass_Inset","CS_H45","CB_H45","CS_H90","CB_H90","CS_Intersect02","CB_Intersect02"]
    +["Hhedgehog_concreteBig","Land_Pier_small_F","Hedgehog","Hhedgehog_concrete","Land_PierLadder_F","Land_PierLadder_F","Land_fort_artillery_nest_EP1","Land_fort_rampart_EP1","Land_Bunker_F","Land_Slums02_4m"]
    ,(["xCam_Metal" call zlt_units, {!(["_base", _x] call bis_fnc_instring) }] call zlt_filter)
    ,(["xcam_objects" call zlt_units, {(["_cnc", _x] call bis_fnc_instring) || (["_wood", _x] call bis_fnc_instring)}] call zlt_filter)
    ,(["xcam_pipe" call zlt_units, {!(["bunker", _x] call bis_fnc_instring) }] call zlt_filter)
    ,["xcam_wood"] call zlt_units
    ,["xcam_woodworks"] call zlt_units
    ,["A3_Structures_F_Civ_Dead","A3_Structures_F_Civ_Garbage","A3_Structures_F_EPB_Civ_Dead"] call zlt_units

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


#define DIK_UP              200
#define DIK_DOWN            208
#define DIK_LEFT            203
#define DIK_RIGHT           205
#define DIK_HOME            199
#define DIK_END             207
#define DIK_INSERT          0xD2    /* Insert on arrow keypad */
#define DIK_PGUP            0xC9    /* PgUp on arrow keypad */
#define DIK_PGDN            0xD1    /* PgDn on arrow keypad */
#define DIK_END             0xCF    /* End on arrow keypad */
#define DIK_HOME            0xC7    /* Home on arrow keypad */
#define DIK_DELETE          0xD3    /* Delete on arrow keypad */
#define DIK_DIVIDE          0xB5
#define DIK_NUM8            0x48
#define DIK_NUM2            0x50

#define DIK_1               0x02
#define DIK_2               0x03
#define DIK_3               0x04
#define DIK_4               0x05
#define DIK_5               0x06
#define DIK_6               0x07
#define DIK_7               0x08
#define DIK_8               0x09
#define DIK_9               0x0A
#define DIK_0               0x0B

#define DIK_X               0x2D
#define DIK_C               0x2E
#define DIK_V               0x2F


#define DIK_W               0x11
#define DIK_S               0x1F
#define DIK_A               0x1E
#define DIK_D               0x20
#define DIK_Q               0x10
#define DIK_Z               0x2C

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

#define DIK_1               0x02
#define DIK_2               0x03
#define DIK_3               0x04
#define DIK_4               0x05
#define DIK_5               0x06
#define DIK_6               0x07
#define DIK_7               0x08
#define DIK_8               0x09
#define DIK_9               0x0A
#define DIK_0               0x0B


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
            _objects = lineIntersectswith [ _intersectCam, _intersectTarget, objnull, objnull, true ];
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

    if (isNil "_obj") exitWith{};
    if (_obj in _bl) exitWith {};
    if (isNull _obj) exitWith {};

    PR(_boxBot) = (boundingboxreal _obj) select 0;
    PR(_boxTop) = (boundingboxreal _obj) select 1;

    PR(_xB) = _boxBot select 0; PR(_xT) = _boxTop select 0;
    PR(_yB) = _boxBot select 1; PR(_yT) = _boxTop select 1;
    PR(_zB) = _boxBot select 2; PR(_zT) = _boxTop select 2;

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


zlt_fnc_help = {


    _help_data = [["F1","Справка"],["F3","Режим камеры"],["F4","Режим нормали к земле"],["F5","ATL/ASL режим"],["F6","Микро-режим"],["F7","Режим автоселекции новых блоков"],["Ctrl+Ins","Установить новый объект здесь и сделать его текущим"],
    ["Ctrl+PgUp,PgDn","Переключение страниц библиотеки объектов"],["Ctrl+Home","Выравнивание текущего объекта по вертикали и ландшафту"],["Home","Выравнивание текущего объекта по вертикали"],
    ["End","Сохрание позиций построенных объектов в буфер обмена"],["Delete","Удаление текущего объекта"],["/(цифр.)","Делает объект текущим"],["Ctrl+/(цифр.)","Выбрать объект и сделать текущим"],
    ["*(цифр.)","Выбрать ближайший объект"],["-(цифр.)","Выбрать класс выбранного объекта"],["+(цифр.)","Переместить камеру на выбранный объект"],["Up Down Left Right","Пермещение текущего объекта"],
    ["Ctrl+Up,Down,Left,Right","Вращение текущего объекта и пермещение его по вертикали"],["PgUp,PgDn","Выбор объекта на текущей странице библиотеки объектов"],
    ["Alt+Up,Down,Left,Right","Наклон текущего объекта(может вызвать баги)"],["Shift+клавиши перемещения объекта","Выполнение действия с меньшим шагом"],["Ins","Установить объект рядом с текущим(ждет нажатия клавиши Up,Dn,Left, Right)"],
    ["Space","Выделить объект под курсором"],["Ctrl+Space","Снять выделение с группы"],["Alt+Space","Добавить в выделение текущий объект"]
    ];
    _help_txt2="<t size='0.5' color='#ffff00' align='left'>";
    {_help_txt2 =_help_txt2 + format["<t color='#ff0000'>%1</t> - %2<br/>", (_help_data select _foreachindex)select 0,(_help_data select _foreachindex)select 1];} foreach _help_data;
    _help_txt2=_help_txt2+"</t>";
    [ _help_txt2, 0,0,5,0,0,331] spawn bis_fnc_dynamicText;
};


zlt_onEachFrame = {
    _bl = [];
    // подсветка текущей
    [zlt_newlb, [1,0,0,1],_bl] call zlt_drawBox;

    if (!zlt_cameraMode && !isNull cursorTarget) then {
        [cursorTarget, [1,1,0,1],_bl] call zlt_drawBox;
    };
    if (zlt_cameraMode && !isNull zlt_cameraTarget) then {
        [zlt_cameraTarget, [1,1,0,1],_bl] call zlt_drawBox;
    };
    { [_x, [1,1,1,1],_bl] call zlt_drawBox; } foreach zltNewCurSel;

};

zlt_fnc_getallcode = {
    private ["_br","_listobj","_txt","_global","_stdparm","_local","_ignore","_simdisable","_listobj2","_hasmarker"];
    _br = toString [13, 10];
    _listobj = +(_this);


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

//  _txt = _txt + "waituntil {time > 0};" + _br;
    _txt = _txt + "if (isserver) then {" + _br;
    {
        _stdparm = (_x call zlt_objGetStdParams);
        _local = ( _stdparm select P_LOCAL_OBJ );
        _simdisable = ( _stdparm select P_SIM_DISABLE );
        if (!_local) then {
            _txt = _txt + "_script = [] spawn {";
            _txt = _txt + ([_x, _local, _simdisable] call zlt_fnc_getcode);
            _txt = _txt + "}; waitUntil {scriptDone _script};";
        };
    } foreach _listobj;

    _txt = _txt + "};" + _br;
    _txt = _txt + "if (isdedicated) exitwith {};" + _br;

//  _txt = _txt + "waituntil {time > 0};" + _br;
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
    if (_objType=="") exitWith{""};
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



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//["Land_BagBunker_Tower_F","Land_BagFence_Long_F",[2.69531,-1.67871,-0.911802],"Land_BagFence_Long_F",[2.63086,1.33398,-0.911802]]

zlt_fnc_boundingbox = { private ["_dir","_pos","_color","_alpha","_bbox","_b1","_b2","_bbx","_bby","_marker"]; if(!hasInterface)exitWith{}; _bbox = [_this, 0] call BIS_fnc_param; _dir = [_this, 1] call BIS_fnc_param; _pos = [_this, 2] call BIS_fnc_param; _color = [_this, 3, "ColorGrey"] call BIS_fnc_param; _alpha = [_this, 4, 1.0] call BIS_fnc_param; if (isnil "zlt_bb_id") then { zlt_bb_id = 0; };    _b1 = _bbox select 0; _b2 = _bbox select 1; _bbx = (abs(_b1 select 0) + abs(_b2 select 0)); _bby= (abs(_b1 select 1) + abs(_b2 select 1)); _marker = createmarkerlocal [ format [ "WMT_BundingBoxMarker_%1",zlt_bb_id ], _pos ]; zlt_bb_id = zlt_bb_id + 1; _marker setmarkerdir _dir; _marker setmarkershapelocal "rectangle"; _marker setmarkersizelocal  [_bbx/2,_bby/2]; _marker setmarkercolor _color; _marker setmarkeralphalocal _alpha; _marker setMarkerBrushLocal "SolidFull"; _marker };

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

    if (!isNil "zltNewAutoSelect" && {zltNewAutoSelect}) then {
        _txt = _txt + "<t color='#ff0000'> АВТО </t>";
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
    if (count zltNewCurSel !=0 ) then {
        _txt = _txt + format["Выбрано %1 блоков",count zltNewCurSel]  + "<br/>";
    };

    // покажем текущий блок
    if (!isNil "zlt_newlb" && {!isnull zlt_newlb}) then {
        // previous
        _ci = zlt_new_blocks find zlt_newlb;

        if (_ci < (count zlt_new_blocks -1)) then {
            _n = _ci + 1;
            _b = zlt_new_blocks select _n;
             if !(_b in zltNewCurSel) then {
                _txt = _txt + "   " + str(_n) + " "+ typeOf _b + "<br/>";
            }else {
                _txt = _txt + "   <t color='#00001A'>" + str(_n) + " "+ typeOf _b + "</t><br/>";
            };
        } else { _txt=_txt + "         ------------<br/>"; };


        if (_ci != -1) then {
                _n = _ci;
                _b = zlt_new_blocks select _n;
                 if !(_b in zltNewCurSel) then {
                    _txt = _txt + " > " + str(_n) + " "+ typeOf _b + "<br/>";
                } else {
                    _txt = _txt + " ><t color='#00001A'> " + str(_n) + " "+ typeOf _b + "</t><br/>";
                };
        } else { _txt=_txt + "         ------------<br/>"; };

        if (_ci > 0) then {
            _n = (_ci - 1);
            _b = zlt_new_blocks select _n;
             if !(_b in zltNewCurSel) then {
                _txt = _txt + "   " + str(_n) + " "+ typeOf _b + "<br/>";
            }else {
                _txt = _txt + "   <t color='#00001A'>" + str(_n) + " "+ typeOf _b + "</t><br/>";
            };

        } else { _txt=_txt + "         ------------<br/>"; };


    };


    _classTxt = "";
    if (isClass (configFile >> "CfgVehicles" >> zlt_cur_class)) then {
        _classTxt = getText (configFile >> "CfgVehicles" >> zlt_cur_class >> "displayName");

    };

    if (not isNil "zlt_cur_class") then {
        _txt=_txt+"<br/>КЛАСС: "+zlt_cur_class +"<br/>"+"НАЗВАНИЕ: "+ _classTxt + "<br/>";

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

ZltNewSaveGroupToClipboard = {
    private ["_mainobj","_group","_delete","_pos","_res","_first"];
    _group = _this select 0;
    _delete = _this select 1;
    if (!zlt_cameraMode) then {_pos = screentoworld [0.5,0.5];} else {_pos = getposworld zlt_camera};
    _mainobj= "Sign_Sphere10cm_F" createVehicle _pos; [_mainobj,0,0] call bis_fnc_setPitchBank;
    _mainobj setdir 0;
    if (zlt_cameraMode) then {_mainobj setdir direction zlt_camera};
    _mainobj setPosWorld _pos;
    _res = "[";
    _first = true;
    { if (!_first) then{_res=_res+","};_res=_res+"["; _res=_res+"'"+(typeOf _x)+"'"; _res=_res+","+ ( (getDir _mainobj - getDir _x) call KK_fnc_floatToString );_res=_res+","+((_mainobj worldToModel (getPosATL _x)) call KK_fnc_positionToString);_res=_res+"]"; _first=false; } foreach _group;
    _res=_res+"]";
    if (_delete) then { {zlt_new_blocks = zlt_new_blocks - [_x]} foreach _group; if (zlt_newlb in _group)then{zlt_newlb=objNull;};{deleteVehicle _x;} foreach _group;_group=[];};
    deleteVehicle _mainobj;
    copyToClipboard _res;
    _res
};

ZltNewLoadGroupFromClipboard = {
    private ["_mainobj","_objects","_obj","_pos","_data"];
    if (!zlt_cameraMode) then {_pos = screentoworld [0.5,0.5];} else {_pos = getposworld zlt_camera};
    _mainobj= "Sign_Sphere10cm_F" createVehicle _pos;
    _mainobj setdir 0;
    if (zlt_cameraMode) then {_mainobj setdir direction zlt_camera};
    _mainobj setPosWorld _pos; [_mainobj,0,0] call bis_fnc_setPitchBank;
    _data = call compile copyFromClipboard;
    _objects = [];
    {
        _obj = (_x select 0) createVehicle [0,0,0];
        _obj setDir (getdir _mainobj + (_x select 1));
        _obj setPosATL (_mainobj modeltoworld (_x select 2));
        diag_log ["Place", _obj, getposWorld _obj, getposWorld _mainobj];
        _objects pushback _obj;
    } foreach _data;
    zlt_new_blocks = zlt_new_blocks + _objects;
    zlt_newlb=(_objects select 0);
    deleteVehicle _mainobj;
    _objects
};


ZltNewSaveGroupParam = {
    private ["_mainobj","_group","_pblb","_pbx"];
    _mainobj=_this select 0;
    _group=_this select 1;

    {
        _x setvariable ["ZltPosDiff",_mainobj worldToModel (getPosATL _x)];
        _x setvariable ["ZltDirDiff",getdir _x - getdir _mainobj];
        /*
        _pblb=_mainobj call bis_fnc_getPitchBank; _pbx=_x call bis_fnc_getPitchBank;
        _x setvariable ["ZltPitchBankDiff",[(_pbx select 0) - (_pblb select 0)  ,(_pbx select 1)-(_pblb select 1)]];
        _x setvariable ["ZltVectorDirDiff", (vectorDir _mainobj) vectordiff (vectorDir _x) ];
        _x setvariable ["ZltVectorUpDiff", (vectorUp _mainobj) vectordiff (vectorUp _x) ];*/
    } foreach _group;
};

ZltNewUseGroupParam = {
    private ["_mainobj","_group","_pblb","_pbx"];
    _mainobj=_this select 0;
    _group=_this select 1;
    _group = _group - [_mainobj];
    _vectors = nil;
    {
        _x setDir (getdir _mainobj + (_x getvariable "ZltDirDiff"));
        _x setPosATL (_mainobj modeltoworld (_x getvariable "ZltPosDiff"));
        if (!_vectors) then {
            _pblb=_mainobj call bis_fnc_getPitchBank; _pbdiff = _x getvariable "ZltPitchBankDiff";
            [_x,(_pblb select 0) + (_pbdiff select 0), (_pblb select 1)+(_pbdiff select 1)] call bis_fnc_setPitchBank;
        } else {
            _x setVectorDirAndUp [(vectorDir _mainobj) vectorAdd (_x getvariable "ZltVectorDirDiff"), (vectorUp _mainobj) vectoradd ( _x getvariable "ZltVectorUpDiff") ];
        };
    } foreach _group;
};


zlt_new_moveblock = {
    // "UP", "RIGHT", "ROLLZ", "FARER", "PITCH", "BANK"
    // VALUE - Значение на сколько
    private ["_class", "_pos", "_dir", "_pitch", "_bank","_obj"];
    _mode = _this select 0;
    _val = _this select 1;
    PARAM(_fASL, 2, zlt_new_asl)

    if ( isnil "zlt_newlb" or {isNull zlt_newlb} ) exitwith {};
    //для текущего выделения
    [zlt_newlb, zltNewCurSel] call ZltNewSaveGroupParam;

    //конец обработки текущего выделения


    _obj = zlt_newlb;
    //получить координаты
    _dir = getdir _obj;
    _pitchBank = _obj call BIS_fnc_getPitchBank; _pitch = _pitchBank select 0;  _bank = _pitchBank select 1;
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
        diag_log ["SET",_obj,_pitch,_bank];
        [_obj, _pitch, _bank] call BIS_fnc_setPitchBank;
    };

    [zlt_newlb, zltNewCurSel] call ZltNewUseGroupParam;
    //конец обработки текущего выделения
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


ZltNewGetCameraTarget = { if (zlt_cameraMode) then {zlt_cameraTarget} else {cursortarget}; };


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

//      diag_log ["new2 kh",_this];

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
            case (_key == DIK_PGDN and _ctrl ) : {
                private "_oi";
                if (zlt_obj_list_index < ( count (zlt_obj_list_all) - 1 ) ) then { zlt_obj_list_index = zlt_obj_list_index +1 ;};
                zlt_obj_list = zlt_obj_list_all select zlt_obj_list_index;
                _oi = zltNewObjListAllCurIndSel select zlt_obj_list_index;
                if !(isNil "_oi") then {zlt_cur_class = zlt_obj_list select _oi;} else {
                zlt_cur_class = zlt_obj_list select 0; };
                [zlt_cur_class, zlt_obj_list] call zlt_fnc_notifyhint;
            };
            // PU + ctrl
            case (_key == DIK_PGUP and _ctrl ) : {
                private "_oi";
                if (zlt_obj_list_index > 0 ) then { zlt_obj_list_index = zlt_obj_list_index -1 ;};
                zlt_obj_list = zlt_obj_list_all select zlt_obj_list_index;
                _oi = zltNewObjListAllCurIndSel select zlt_obj_list_index;
                if !(isNil "_oi") then {zlt_cur_class = zlt_obj_list select _oi;} else {
                zlt_cur_class = zlt_obj_list select 0; };
                [zlt_cur_class, zlt_obj_list] call zlt_fnc_notifyhint;
            };



            // PD
            case (_key == DIK_PGDN ) : {_ind =  (zlt_obj_list find zlt_cur_class ) max 0; _ind = _ind + (if (_shift) then {10} else {1} ); if (_ind > (count (zlt_obj_list) -1)) then {_ind = count (zlt_obj_list) -1 ;}; zlt_cur_class = zlt_obj_list select _ind; [zlt_cur_class, zlt_obj_list] call zlt_fnc_notifyhint; zltNewObjListAllCurIndSel set [zlt_obj_list_index,_ind]; };
            //PU
            case (_key == DIK_PGUP ) : {_ind =  (zlt_obj_list find zlt_cur_class ) max 0; _ind = _ind - (if (_shift) then {10} else {1} ); if (_ind < 0) then {_ind = 0 ;}; zlt_cur_class = zlt_obj_list select _ind; [zlt_cur_class, zlt_obj_list] call zlt_fnc_notifyhint; };

            //end
            case (_key == DIK_END && !_ctrl) : { zlt_new_blocks call zlt_save_comp ; "Сохронил!" call zlt_fnc_notify; };

            case (_key == DIK_END && _ctrl) : {
                zlt_disableSimClasses2 = zlt_disableSimClasses;
                zlt_disableSimClasses = [];
                zlt_localObjectsClasses2= zlt_localObjectsClasses;
                zlt_localObjectsClasses = [];
                zlt_new_blocks call zlt_save_comp ; "Сохронил глобально!" call zlt_fnc_notify;
                zlt_disableSimClasses = zlt_disableSimClasses2;
                zlt_disableSimClasses2 = nil;
                zlt_localObjectsClasses= zlt_localObjectsClasses2;
                zlt_localObjectsClasses2=nil;
            };




            //delete
            case (_key == DIK_DELETE) : {
                _oldid = zlt_new_blocks find zlt_newlb;
                zlt_new_blocks = zlt_new_blocks - [zlt_newlb];
                if (zlt_newlb in zltNewCurSel) then {zltNewCurSel=zltNewCurSel-[zlt_newlb];};
                deletevehicle zlt_newlb;
                zlt_newlb = if (count zlt_new_blocks == 0 )then {objNull} else {if(_oldid > 0) then{ zlt_new_blocks select (_oldid - 1)} else {zlt_new_blocks select 0}};

                "Удалено!" call zlt_fnc_notify;
            };

            // home
            case (_key == DIK_HOME) : {
                if (!_ctrl) then {
                    [zlt_newlb, zltNewCurSel] call ZltNewSaveGroupParam;
                    zlt_newlb setposatl [ getposatl zlt_newlb select 0,  getposatl zlt_newlb select 1, 0];
                    [zlt_newlb, zltNewCurSel] call ZltNewUseGroupParam;
                }else {
                    if ( (!zlt_new_vectorup && !_alt) || (zlt_new_vectorup && _alt) ) then {
                        [zlt_newlb, zltNewCurSel] call ZltNewSaveGroupParam;
                        zlt_newlb setvectorup ( surfaceNormal (getpos zlt_newlb) );
                        [zlt_newlb, zltNewCurSel] call ZltNewUseGroupParam;
                        "Нормаль" call zlt_fnc_notify;
                        //zlt_new_vectorup = false;
                    } else {
                        [zlt_newlb, zltNewCurSel] call ZltNewSaveGroupParam;
                        [zlt_newlb, 0,0] call bis_fnc_setpitchbank;
                        [zlt_newlb, zltNewCurSel] call ZltNewUseGroupParam;
                        //zlt_new_vectorup = true;
                        "Вертикаль" call zlt_fnc_notify;
                    };
                };
            };

            case (_key == DIK_F1) : {
                [] call zlt_fnc_help;
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

/*          case (_key == DIK_F7) : {
                if (isNil "zltNewAutoSelect") then {zltNewAutoSelect=false;};
                if (zltNewAutoSelect) then {zltNewAutoSelect = false; "Режим автовыбора выключен" call zlt_fnc_notify;}
                else { zltNewAutoSelect = true; "Режим автовыбора" call zlt_fnc_notify;};
            };          */




            case (_ctrl && _key >= 0x02 && _key <= 0x0B ) : { zltNewCurrentFastObjects set [_key-0x02,zlt_cur_class]; profilenamespace setvariable ["zltNewCurrentFastObjects",zltNewCurrentFastObjects];        };
            case (!_ctrl && _key >= 0x02 && _key <= 0x0B ) : {private "_co"; _co = zltNewCurrentFastObjects select (_key-0x02); if !(isNil "_co") then {zlt_cur_class=_co;}else{"Быстрая клавиша не назначена" call zlt_fnc_notify};};
            case (_ctrl && _key==DIK_C) : {
                [zltNewCurSel, false] call ZltNewSaveGroupToClipboard;
                "Скопировано в буфер" call zlt_fnc_notify;
            };
            case (_ctrl && _key==DIK_V) : {
                zltNewCurSel=0 call ZltNewLoadGroupFromClipboard;
                "Вставлено из буфера" call zlt_fnc_notify;
            };
            case (_ctrl && _key==DIK_X) : {
                [zltNewCurSel, true] call ZltNewSaveGroupToClipboard;
                zltNewCurSel=[];
                "Вырезано из буфера" call zlt_fnc_notify;
            };

            case (_alt && !_ctrl && _key == DIK_SPACE) : {if (zlt_newlb in zltNewCurSel) then {zltNewCurSel = zltNewCurSel-[zlt_newlb]; "Удалено" call zlt_fnc_notify} else {zltNewCurSel pushBack zlt_newlb; "Добавлено" call zlt_fnc_notify;};};
            case (!_alt && _ctrl && _key == DIK_SPACE) : {zltNewCurSel=[]; "Выделение снято" call zlt_fnc_notify};
            case (!_alt && !_ctrl && _key == DIK_SPACE) : {
                private "_target";
                _target = 0 call ZltNewGetCameraTarget;
                if !(isnull _target) then {
                    if (_target in zlt_new_blocks) then {
                        if !(_target in zltNewCurSel) then {
                            zltNewCurSel pushBack _target; "Добавлено в выделение" call zlt_fnc_notify; } else {zltNewCurSel = zltNewCurSel - [_target]; "Убрано из выделения" call zlt_fnc_notify;};
                    } else {"Блок нельзя выделить - он поставлен не нами" call zlt_fnc_notify;};
                } else {"Блок не выбран" call zlt_fnc_notify;};
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


//  [-1.56135,-0.255241,-0.458448],[1.56135,0.255241,0.458448]]
zlt_new_block = {
    comment "v.1";
    _class = zlt_cur_class;
    if (!isClass (configFile >> "CfgVehicles" >> zlt_cur_class)) exitWith { "Такого класса нет в данной сборке!" call zlt_fnc_notify};

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
    //  _pos1 = screentoworld [0.5,0.5];
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

    PR(_closestBlocks) = (getpos _new ) nearObjects 10;
    _closestBlocks = _closestBlocks - [_new];
    _closestBlocks = [+_closestBlocks,[_new],{_input0 distanceSqr _x},"ASCEND"] call BIS_fnc_sortBy;
    
    if ((count zlt_new_blocks > 0) and {(_closestBlocks select 0) distance _new < 0.05} ) then {
        "Ошибка, слишком близко к другому блоку!" call zlt_fnc_notify;
        deleteVehicle _new;
    } else {
        zlt_newlb = _new;
        zlt_new_blocks = zlt_new_blocks + [zlt_newlb];
        if (!isNil "zltNewAutoSelect" && {zltNewAutoSelect}) then {if !(_new in zltNewCurSel) then {zltNewCurSel pushBack _new};};
    };
};

zlt_save_comp = {
    _objs = _this ;
    _text = (_objs call zlt_fnc_getallcode);
    copytoclipboard _text;
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
            zlt_newlb = zlt_cameraTarget;
        };
    } else {
        if not (isNull cursortarget) then {
            zlt_newlb = cursortarget;
        };
    };
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


KK_fnc_floatToString = {
    private "_arr";
    _arr = toArray str (_this % 1);
    _arr set [0, 'x'];
    _arr = _arr - ['x'];
    toString (toArray str (_this - _this % 1) + _arr)
};

KK_fnc_positionToString = {
    { _this = if (_forEachIndex == 0 and _forEachIndex != 2) then [
        {_x call KK_fnc_floatToString},
        {if (_forEachIndex ==1) then [{_this + "," + (_x call KK_fnc_floatToString)},{_this + "," + (str _x)}]}];
    } forEach +_this;
    "["+_this+"]"
};






KK_fnc_floatToString = {
    private ["_num","_rem"];
    _num = str _this + ".";
    _rem = str (_this % 1);
    (_num select [0, _num find "."]) + (_rem select [_rem find "."])
};

KK_fnc_positionToString = {
    private ["_f2s","_num","_rem"];
    _f2s = {
        _num = str _this + ".";
        _rem = str (_this % 1);
        (_num select [0, _num find "."]) + (_rem select [_rem find "."])
    };
    format [
        "[%1,%2,%3]",
        _this select 0 call _f2s,
        _this select 1 call _f2s,
        _this select 2 call _f2s
    ]
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



// zlt_new_blocks
zlt_fnc_ZeusSync = {
    if ( count allCurators == 0 ) exitWith {};
    private ['_curator','_curObjs'];
    _curator = allCurators select 0;
    _curObjs = curatorEditableObjects _curator;
    {
        if !(_x in zlt_new_blocks) then {zlt_new_blocks pushBack _x};
    } foreach (_curObjs);
    {
        if !(_x in _curObjs) then { _curator addCuratorEditableObjects [[_x],false]; };
    } foreach zlt_new_blocks;
};



if (isNil "zlt_eh_keydown") then {

    waitUntil { (!isNull (findDisplay 46) || !(alive player))};
    zlt_backDisplayCheck = [] spawn {
        while {true} do {
            [] spawn zlt_fnc_ZeusSync;
            zlt_eh_keydown = (findDisplay 46) displayAddEventHandler ["KeyDown", "_aaa=(_this call zlt_new_keydown)"];
            zlt_eh_keyup = (findDisplay 46) displayAddEventHandler ["KeyUp", "_ccc=(_this call zlt_new_keyup)"];
            zlt_eh_mouse = (findDisplay 46) displayAddEventHandler ["MouseMoving", "_bbb=(_this call zlt_new_mouseMoving)"];
            waitUntil { !isNull(findDisplay 312) }; // сработает после запуска Zeus
            [] spawn zlt_fnc_ZeusSync;
            waitUntil { isNull(findDisplay 312) };
            [] spawn zlt_fnc_ZeusSync;
            (findDisplay 46) displayRemoveEventHandler ["KeyDown", zlt_eh_keydown];
            (findDisplay 46) displayRemoveEventHandler ["KeyUp", zlt_eh_keyup];
            (findDisplay 46) displayRemoveEventHandler ["MouseMoving", zlt_eh_mouse];
        };
    };

/*
    (findDisplay 46) displayRemoveAllEventHandlers "KeyDown";
    (findDisplay 46) displayRemoveAllEventHandlers "KeyUp"; */


    // ВИДЖЕТ СПИСКА
    call zlt_fnc_initUI;

    zlt_cur_class = zlt_obj_list select 0;
    if (isnil "zlt_new_blocks") then { zlt_new_blocks = [];};
    zlt_newlb = objNull;
    zlt_new_vectorup = true;
    zlt_new_asl = true;
    zlt_new_micro = false;

    zltNewCurSel=[]; //текущее выделение через пробел


    zltNewCurrentFastObjects=[]; zltNewCurrentFastObjects resize 10;
    zltNewCurrentFastObjects=profilenamespace getvariable ["zltNewCurrentFastObjects",zltNewCurrentFastObjects];

    // камера
    zlt_cameraMode = false;
    zlt_camerakeys = [];
    _DIKcodes = true call bis_fnc_keyCode;
    _DIKlast = _DIKcodes select (count _DIKcodes - 1);
    for "_k" from 0 to (_DIKlast - 1) do {
        zlt_camerakeys set [_k,false];
    };

    zlt_cameraTarget = objNull;

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

hint "Загрузка завершена";
