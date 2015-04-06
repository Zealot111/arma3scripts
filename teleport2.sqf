 zlt_fnc_tel = {
    private ["_markers","_fmt"];
    diag_log ["zlt_fnc_tel",_this];
    zlt_pos_markers = _this select 0;
    zlt_pos_addparams = _this select 1;
    zlt_fnc_pos_cb = _this select 2;
    zlt_mutexAction = true;
    // параметры - список маркеров, колбэк, который вызывается в случае установки
    _fmt = "<t color='#ff0000' size='2' shadow='1' shadowColor='#000000' align='center'>%1</t>";
    sleep 0.5;
    hint parseText format [_fmt,"Выберите позицию:"];
    sleep 0.05;
    openMap true;
    sleep 0.05;
    onMapSingleClick {
        private ["_closestPoints", "_point","_dir","_pos"];
        _closestPoints = [zlt_pos_markers,[_pos],{_input0 distanceSqr (getMarkerPos _x)},"ASCEND"] call BIS_fnc_sortBy;
        _point = _closestPoints select 0;
        _pos = markerPos _point;
        _dir = markerDir _point;
        onMapSingleClick {};
        hint parseText format [_fmt,"Позиция выбрана"];
        [_pos, _dir, _point, zlt_pos_markers,zlt_pos_markers find _point,zlt_pos_addparams] spawn zlt_fnc_pos_cb;
        zlt_mutexAction = false;
        zlt_pos_cb=nil; zlt_pos_markers=nil;zlt_pos_addparams=nil;
        openMap false;
        true
    };
    waitUntil {not visibleMap};
    if (zlt_mutexAction) then {
        hintSilent "";
        sleep 0.05;
        hint parseText format [_fmt,"Установка отменена!"];
        onMapSingleClick {};
        zlt_mutexAction = false;
    };
};

// массив [юниты, техника, [массив техники]]
zlt_fnc_teleport = {
    private ["_units","_markers","_fmt","_pos","_dir"];
    _fmt = "<t color='#ff0000' size='2' shadow='1' shadowColor='#000000' align='center'>%1</t>";
    _objs = _this select 0;
    _markers = _this select 1;
    if (count _objs != count _markers) then {diag_log "SELECT_POS.SQF Внимание, количество меток не соотв. кол-ву объектов!";};
    {
        _pos = markerPos (_markers select _foreachindex);
        _dir = markerDir (_markers select _foreachindex);
        switch true do {
            case (typeName _x == typeName []) : {
                _posx = _pos;
                _txt = format [_fmt, "Вы были перенесены командиром отряда!"];
                {
                    if (_x isKindOf "Quadbike_01_base_F") then {
                        _posx = [ (_pos select 0) +  round (_foreachindex / 2) * 3, (_pos select 1) + (_foreachindex % 2)*3, _pos select 2];
                    } else {
                        _posx = [ (_pos select 0) +  round (_foreachindex / 3) * 1.5, (_pos select 1) + (_foreachindex % 3)*1.5, _pos select 2];
                    };
                    [[ [_x,_posx,_dir, _txt] ,{
                        if (vehicle player != player) then {moveOut player};
                        if (!isDedicated) then {wmt_freeze_startpos = (_this select 1);
                        "PlayerFreeze" setMarkerPosLocal (_this select 1); hint parseText (_this select 3);};
                        (_this select 0) setpos (_this select 1);
                        (_this select 0) setDir (_this select 2);
                    }],"bis_fnc_spawn",_x] call bis_fnc_mp;
                    //"Sign_Sphere100cm_F" createVehicle _posx;
                    diag_log ['zlt_fnc_teleport',_pos, _posx];
                } foreach _x;
            };
            case (typename _x == typename objNull) : {
                diag_log ['zlt_fnc_teleport2',_pos];
                [[ [_x,_pos,_dir] ,{(_this select 0) setpos (_this select 1); (_this select 0) setDir (_this select 2);}],"bis_fnc_spawn",_x] call bis_fnc_mp;
            };
        };
        sleep 0.001;
    } foreach _objs;
};
private ["_selmarkers","_tlpunits","_posmarkers"];
// маркеры выбора
_tlpunits = _this select 0;
_selmarkers = _this select 1;
_posmarkers = _this select 2;


if (isNil "zlt_mutexAction") then {zlt_mutexAction=false;};
if (isDedicated) exitwith {};
waitUntil {!isNull player};
zlt_tlMaxTime = 300;
zlt_teleMenuId = player addAction ["<t color='#ff0000'>ВЫБРАТЬ ТОЧКУ СТАРТА</t>", {[((_this select 3) select 1),[((_this select 3) select 0),((_this select 3) select 2)],{[(_this select 5) select 0,((_this select 5) select 1) select (_this select 4)] call zlt_fnc_teleport}] call zlt_fnc_tel}, [_tlpunits,_selmarkers,_posmarkers], -1, false, true, "", '!zlt_mutexAction'];
waitUntil {time > zlt_tlMaxTime && missionnamespace getvariable ["WMT_pub_frzState",3] >=3};
player removeAction zlt_teleMenuId;
zlt_fnc_tel=nil;
zlt_fnc_teleport =nil;
