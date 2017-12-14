
private
[
	"_unit"
];

_unit = _this select 0;
PMC_corpses = PMC_corpses + [_unit];
PMC_killedNum = PMC_killedNum + 1;
publicVariable "PMC_killedNum";
