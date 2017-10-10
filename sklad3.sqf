//by [STELS]Zealot
// номер файла, нужно менять если используется несколько скриптов selpoints2.sqf на одной миссии
#define FNUM 2

#define CONCAT(A,B) A##B

// [hunter, ["point1","point2"], "car1"] execVM "selpoints2.sqf";
 

// 1 параметр - объект который устанавливается
CONCAT(zlt_sp_obj,FNUM) = Sklad3;

// 2 параметр - маркера на точки установки
CONCAT(zlt_sp_allowedmrkrs,FNUM) = ["marker_25","marker_27", "marker_29"];

// 2.5 параметр - Список маркеров которые нужно сделать видимыми перед установкой и невидимыми после (т.е. маркера на точки установки)
CONCAT(zlt_sp_selmrkrs,FNUM) = ["marker_24","marker_26", "marker_28"];

// 3 параметр - маркер на технику
CONCAT(zlt_sp_mrkend,FNUM) =  "marker_sklad3";

// справка, которая покажется перед выбором точки нахождения техники
CONCAT(zlt_sp_msghelp,FNUM) = "Кликните на карте в один из маркеров расположения объекта";

// сообщение для того, кто установит технику
CONCAT(zlt_sp_msgall,FNUM) = "Объект установлен";

CONCAT(zlt_spFormat,FNUM) = "<t color='#ff0000' size='2' shadow='1' shadowColor='#000000' align='center'>%1</t>";

CONCAT(zlt_spActionId,FNUM) = player addAction ["<t color='#ff0000'>Выбрать место для склада 3</t>", {call CONCAT(zlt_sp_placeObj,FNUM)}];
//
[] spawn {
	waitUntil { ((( missionNamespace getVariable ["WMT_pub_frzState",0] ) >= 3) && time > 120 ) || time > 600};
	player removeAction CONCAT(zlt_spActionId,FNUM);
};

CONCAT(zlt_sp_placeObj,FNUM) = {
	//CONCAT(zlt_sp_mrkend,FNUM) setMarkerAlpha 0; 
	{
		_x setMarkerAlphaLocal 1;
	} foreach CONCAT(zlt_sp_selmrkrs,FNUM);
	sleep 0.5;
	CONCAT(zlt_mutexAction,FNUM) = true;
	hintSilent "";
	sleep 0.05;
	hint parseText format [CONCAT(zlt_spFormat,FNUM),CONCAT(zlt_sp_msghelp,FNUM)];
	sleep 0.05;
	openMap true;
	onMapSingleClick {
		private _closestPoints = [CONCAT(zlt_sp_allowedmrkrs,FNUM),[_pos],{_input0 distance (getMarkerPos _x)},"ASCEND"] call BIS_fnc_sortBy;
		private _point = _closestPoints select 0;
		onMapSingleClick {};
		_point spawn {
			sleep 0.1;
			CONCAT(zlt_sp_obj,FNUM) setPos (getMarkerPos _this);
			CONCAT(zlt_sp_obj,FNUM) setDir (markerDir _this);
			CONCAT(zlt_sp_mrkend,FNUM) setMarkerPosLocal (getMarkerPos _this);
		};
		
		hint parseText format [CONCAT(zlt_spFormat,FNUM),CONCAT(zlt_sp_msgall,FNUM)];
		{
			_x setMarkerAlphaLocal 0;
		} foreach CONCAT(zlt_sp_selmrkrs,FNUM);


		// метка на технику должна обновиться у всех союзников игрока
		[
			[
				[  CONCAT(zlt_sp_mrkend,FNUM), getMarkerPos _point],
				{
					(_this select 0) setMarkerPosLocal (_this select 1); (_this select 0) setMarkerAlphaLocal 1;
				} 
			],"bis_fnc_spawn", playerSide
		] call bis_fnc_mp;
		openMap false;
		CONCAT(zlt_mutexAction,FNUM) = false;
		true
	};

	waitUntil {not visibleMap};
	if (CONCAT(zlt_mutexAction,FNUM)) then {
		hintSilent "";
		sleep 0.05;
		hint parseText format [CONCAT(zlt_spFormat,FNUM),"Установка отменена!"];
		onMapSingleClick {};
	};

};