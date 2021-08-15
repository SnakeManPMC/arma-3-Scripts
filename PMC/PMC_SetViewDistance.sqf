
private _viewDistance = ["PMC_viewdistance"] call BIS_fnc_getParamValue;

setViewdistance _viewDistance;
setObjectViewDistance (_viewDistance / 2);
