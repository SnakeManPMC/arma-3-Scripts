/*

	Adds CUP USMC Headgear and Uniforms to vehicle cargo

Syntax:
[vehicle, 10] execVM "PMC\PMC_CUP_UniformsToCargo.sqf";

Example:
[pmc_ammobox] execVM "PMC\PMC_ClearVehicleCargo.sqf";
[pmc_ammobox, 10] execVM "PMC\PMC_CUP_UniformsToCargo.sqf";

Requires:
-

Returns:
-

*/
private _v = _this select 0;
private _amount = _this select 1;
if !(local _v) exitWith {};

{
// headgear
	_v addItemCargoGlobal ["CUP_H_FR_BandanaGreen", _x];
	_v addItemCargoGlobal ["CUP_H_FR_BeanieGreen", _x];
	_v addItemCargoGlobal ["CUP_H_FR_BoonieMARPAT", _x];
	_v addItemCargoGlobal ["CUP_H_FR_BoonieWDL", _x];
	_v addItemCargoGlobal ["CUP_H_FR_Cap_Headset_Green", _x];
	_v addItemCargoGlobal ["CUP_H_FR_Cap_Officer_Headset", _x];
	_v addItemCargoGlobal ["CUP_H_FR_ECH", _x];
	_v addItemCargoGlobal ["CUP_H_FR_Headband_Headset", _x];
	_v addItemCargoGlobal ["CUP_H_FR_Headset", _x];
/* very special for ship crews only, not much use for infantry men
	_v addItemCargoGlobal ["CUP_H_Navy_CrewHelmet_Blue", _x];
	_v addItemCargoGlobal ["CUP_H_Navy_CrewHelmet_Brown", _x];
	_v addItemCargoGlobal ["CUP_H_Navy_CrewHelmet_Green", _x];
	_v addItemCargoGlobal ["CUP_H_Navy_CrewHelmet_Red", _x];
	_v addItemCargoGlobal ["CUP_H_Navy_CrewHelmet_Violet", _x];
	_v addItemCargoGlobal ["CUP_H_Navy_CrewHelmet_White", _x];
	_v addItemCargoGlobal ["CUP_H_Navy_CrewHelmet_Yellow", _x];
*/
	_v addItemCargoGlobal ["CUP_H_PMC_Cap_Back_PRR_Tan", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_ACVC_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_ACVC_WDL", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_BOONIE_PRR_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_BOONIE_PRR_WDL", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_CAP_PRR_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_Crew_Helmet", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_Goggles_HelmetWDL", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_Headset_GoggleW_HelmetWDL", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_Headset_HelmetWDL", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_Helmet_Pilot", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_HelmetWDL", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_ESS_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_ESS_HS_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_ESS_HS_WDL", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_ESS_LR_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_ESS_LR_WDL", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_ESS_WDL", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_NVGMOUNT_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_NVGMOUNT_ESS_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_NVGMOUNT_ESS_LR_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_NVGMOUNT_ESS_LR_WDL", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_NVGMOUNT_ESS_WDL", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_NVGMOUNT_WDL", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_LWH_WDL", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_MICH2000_COMM_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_MICH2000_DEF_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_MICH2000_DEF_ESS_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_MICH2000_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_MICH2000_ESS_COMM_DES", _x];
	_v addItemCargoGlobal ["CUP_H_USMC_Officer_Cap", _x];

// uniforms
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_AR", _x];
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_AT", _x];
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_Corpsman", _x];
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_DMR", _x];
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_Empty", _x];
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_GL", _x];
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_MG", _x];
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_Officer", _x];
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_Patrol", _x];
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_Rifleman", _x];
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_RTO", _x];
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_Scout", _x];
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_SL", _x];
	_v addItemCargoGlobal ["CUP_V_B_Eagle_SPC_TL", _x];
/* very special for ship crews only, not much use for infantry men
	_v addItemCargoGlobal ["CUP_V_B_LHDVest_Blue", _x];
	_v addItemCargoGlobal ["CUP_V_B_LHDVest_Brown", _x];
	_v addItemCargoGlobal ["CUP_V_B_LHDVest_Green", _x];
	_v addItemCargoGlobal ["CUP_V_B_LHDVest_Red", _x];
	_v addItemCargoGlobal ["CUP_V_B_LHDVest_Violet", _x];
	_v addItemCargoGlobal ["CUP_V_B_LHDVest_White", _x];
	_v addItemCargoGlobal ["CUP_V_B_LHDVest_Yellow", _x];
*/
	_v addItemCargoGlobal ["CUP_V_B_MTV", _x];
	_v addItemCargoGlobal ["CUP_V_B_MTV_LegPouch", _x];
	_v addItemCargoGlobal ["CUP_V_B_MTV_Marksman", _x];
	_v addItemCargoGlobal ["CUP_V_B_MTV_MG", _x];
	_v addItemCargoGlobal ["CUP_V_B_MTV_Mine", _x];
	_v addItemCargoGlobal ["CUP_V_B_MTV_noCB", _x];
	_v addItemCargoGlobal ["CUP_V_B_MTV_Patrol", _x];
	_v addItemCargoGlobal ["CUP_V_B_MTV_PistolBlack", _x];
	_v addItemCargoGlobal ["CUP_V_B_MTV_Pouches", _x];
	_v addItemCargoGlobal ["CUP_V_B_MTV_TL", _x];
	_v addItemCargoGlobal ["CUP_V_B_PilotVest", _x];
	_v addItemCargoGlobal ["CUP_V_B_RRV_DA1", _x];
	_v addItemCargoGlobal ["CUP_V_B_RRV_DA2", _x];
	_v addItemCargoGlobal ["CUP_V_B_RRV_Light", _x];
	_v addItemCargoGlobal ["CUP_V_B_RRV_Medic", _x];
	_v addItemCargoGlobal ["CUP_V_B_RRV_MG", _x];
	_v addItemCargoGlobal ["CUP_V_B_RRV_Officer", _x];
	_v addItemCargoGlobal ["CUP_V_B_RRV_Scout", _x];
	_v addItemCargoGlobal ["CUP_V_B_RRV_Scout2", _x];
	_v addItemCargoGlobal ["CUP_V_B_RRV_Scout3", _x];
	_v addItemCargoGlobal ["CUP_V_B_RRV_TL", _x];
} forEach [_amount];
