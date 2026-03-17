/*
	=======================================================================================================================
	NOTES FOR MISSION EDITORS (please take a few time to read and understand these lines to avoid any issue)
	=======================================================================================================================

	 - Adding custom mods into OPEX is your responsibility, so if you do so, please do it at your own risk and don't complain if something doesn't work as intended.
	 - Adding custom mods into OPEX requires some scripting skills and above all a lot of concentration - a single wrong data can break the whole mission so keep that in mind at any time.
	 - Keep the same variables types : some of them must be strings (""), some others are arrays ([]) etc... so double check before doing anything.
	 - Do NOT delete anything in PART 2.
	 - Do NOT edit or delete anything in PART 3.
	 - Do NOT let any variable undefined or empty in PART 4.
	 - If you want to add something to the vanilla content (if variable is an array), use this command: OPEX_exampleArray append ["myCustomData1", "myCustomData2", "myCustomData3", ""myCustomDataN"]
	 - If you want to replace the vanilla content (if variable is an array), use this command: OPEX_exampleArray = ["myCustomData1", "myCustomData2", "myCustomData3", ""myCustomDataN"]
	 - So be aware of how the variables are defined (with " = " or " append ") !
	 - If you want to use vanilla content, simply remove the data (for example, if your mod doesn't have any aircraft, simply remove the line that defines OPEX_friendly_aircrafts).
	 - Tip: if you want to increase the probability of usaage of a specific item, list it several times (example: OPEX_exampleArray = ["myCustomData1", "myCustomData1", "myCustomData1", ""myCustomData2"] means that "myCustomData1" has 3 times more chances to be used than "myCustomData2")
	 - When your template is ready, don't forget to enable it by editing the "settings\init.sqf" file.
	 - If you want your custom mod to be officially integrated into OPEX, please be sure your template is 100% working and send it to gemini.69@free.fr

	If you need help, please contact me:
	 - on the OPEX public comments on Steam (please do NOT add me to your friend list): https://steamcommunity.com/workshop/filedetails/?id=908003375
	 - on the official OPEX forum: https://forums.bohemia.net/forums/topic/194070-opex/
	 - by email: gemini.69@free.fr

	I will provide as much support as I can but please keep in mind that I'm alone and I'm developping OPEX on my free time.

	- Gemini
*/

// =======================================================================================================================
// PART 1 (you need AT LEAST ONE ENTRY to avoid this custom mod loading on computers that don't have it)
// =======================================================================================================================

	if (!(isClass (configFile >> "CfgPatches" >> "bwa3_common"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "bwa3_weapons"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check
	if (!(isClass (configFile >> "CfgPatches" >> "bwa3_units"))) exitWith {}; // replace "xxxxx" by the name of the file you need to check

// =======================================================================================================================
// PART 2 (you HAVE to edit these variables but DO NOT DELETE them !)
// =======================================================================================================================

	// DEFINING FACTION NAMES
	_OPEX_friendly_modName = "BW"; // mod name (example: "myCustomMod")
	_OPEX_friendly_factionName = "STR_friendly_mainFaction_NATO"; // faction name (example: "NATO") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)
	_OPEX_friendly_subFaction = "STR_friendly_subFaction_Germany"; // country name (example: "USA") - (note: if you want to define a localized variable, don't forget to define it into the stringtable.xml file)

// =======================================================================================================================
// PART 3 (DO NOT EDIT OR DELETE these lines !)
// =======================================================================================================================

	// ENABLING FACTION
	waitUntil {!isNil "OPEX_friendly_factions"};
	if (isServer) then {OPEX_friendly_factions append [[_OPEX_friendly_subFaction, _OPEX_friendly_modName]]}; publicVariable "OPEX_friendly_factions";

	// WAITING FOR FACTION SELECTION
	waitUntil {!isNil "OPEX_params_ready"};
	waitUntil {OPEX_params_ready};
	if (!(OPEX_param_friendlyFaction isEqualTo [_OPEX_friendly_subFaction, _OPEX_friendly_modName])) exitWith {};

	// CONFIRMING FACTION NAMES
	OPEX_friendly_modName = _OPEX_friendly_modName;
	OPEX_friendly_factionName = _OPEX_friendly_factionName;
	OPEX_friendly_subFaction = _OPEX_friendly_subFaction;

// =======================================================================================================================
// PART 4 (DO NOT LET ANY VARIABLE UNDEFINED OR EMPTY)
//		- if you don't know what a variable is about, please ask
//		- if you don't need to define a variable, simply delete the line (default content will be used instead)
// =======================================================================================================================

	// ARMY NAME
	OPEX_friendly_army = localize "STR_friendly_army_ger"; // country name (example: "US Army") - (note: if you want to define a localized variable, don't forget to define it into the "stringtable.xml" file)

	// FLAGS
	OPEX_friendly_flag_marker = "flag_Germany"; // flag marker (example: "flag_USA")
	OPEX_friendly_flag_faction = "pictures\flag_nato.paa"; // faction flag (example: "pictures\flag_nato.paa")
	OPEX_friendly_flag_country = "pictures\flag_germany.paa"; // country flag (example: "pictures\flag_usa.paa")
	OPEX_friendly_flag_army = "pictures\flag_army_germany.paa"; // camp flag (example: "pictures\flag_liberty.paa")
	OPEX_friendly_insigna = "NATO"; // uniform insigna - (note: if you want to use your own insigna, don't forget to define it into the "scripts\Gemini\hpp_insignas.hpp" file)

	// CAMP
	OPEX_friendly_camp = "Camp Wagner"; // camp name (example: "Camp Gemini"
	OPEX_sign_camp = "pictures\sign_camp_ger.paa"; // camp signboard (example: "pictures\sign_camp_gemini.paa")

	// SIGNBOARD TEXTURES
	OPEX_sign_ammo = "pictures\sign_ammo_generic.paa";
	OPEX_sign_armory = "pictures\sign_armory_generic.paa";
	OPEX_sign_canteen = "pictures\sign_canteen_generic.paa";
	OPEX_sign_delivery = "pictures\sign_delivery_generic.paa";
	OPEX_sign_dormitory = "pictures\sign_dormitory_generic.paa";
	OPEX_sign_fitness = "pictures\sign_fitness_generic.paa";
	OPEX_sign_fuel = "pictures\sign_fuel_generic.paa";
	OPEX_sign_jail = "pictures\sign_jail_generic.paa";
	OPEX_sign_medical = "pictures\sign_medical_generic.paa";
	OPEX_sign_practice = "pictures\sign_practice_generic.paa";
	OPEX_sign_shooting = "pictures\sign_shooting_generic.paa";
	OPEX_sign_toc = "pictures\sign_toc_generic.paa";
	OPEX_sign_training = "pictures\sign_training_generic.paa";
	OPEX_sign_workshop = "pictures\sign_workshop_generic.paa";
	OPEX_sign_showers = "pictures\sign_showers_generic.paa";
	OPEX_sign_recreation = "pictures\sign_recreation_generic.paa";

	// OTHER TEXTURES
	OPEX_briefingBoard = "pictures\briefingboard_generic.paa";
	OPEX_briefingScreen_sitrep = "pictures\briefingscreen_sitrep_de.paa";
	OPEX_briefingScreen_objectives = "pictures\briefingscreen_objectives_de.paa";
	OPEX_briefingScreen_intel = "pictures\briefingscreen_intel_de.paa";
	OPEX_briefingScreen_roe = "pictures\briefingscreen_roe_de.paa";
	OPEX_briefingScreen_strategy = "pictures\briefingscreen_strategy_de.paa";
	OPEX_briefingScreen_questions = "pictures\briefingscreen_questions_de.paa";
	OPEX_briefingScreen_debriefing = "pictures\briefingscreen_debriefing_de.paa";
	OPEX_tv = "pictures\tv_generic.paa";
	OPEX_monitorBig_specialization = "pictures\specialization_board_en.paa";
	OPEX_laptop_specialization = "pictures\laptop1610_specialization_ge.paa";
	OPEX_keepclear = "pictures\keepclear_generic.paa";

	// AI GLOBAL SKILL
	OPEX_friendly_AIskill = [0.50, 1.00]; // [lowest possible level, highest possible level]

	// IDENTITIES
	OPEX_friendly_identities = ["german_01", "german_02", "german_03", "german_04", "german_05", "german_06", "german_07", "german_08", "german_09", "german_10", "german_11", "german_12", "german_13", "german_14", "german_15", "german_16", "german_17", "german_18", "german_19", "german_20", "german_21", "german_22", "german_23", "german_24", "german_25", "german_26", "german_27", "german_28", "german_29", "german_30", "german_31", "german_32", "german_33", "german_34", "german_35", "german_36", "german_37", "german_38", "german_39", "german_40", "german_41", "german_42", "german_43", "german_44", "german_45", "german_46", "german_47", "german_48", "german_49", "german_50"]; // identities of the AI teammates (for example, if you want to make them having specing names, voices, faces...) - (note: you need to defined them into the "scripts\Gemini\hpp_identities.hpp" file)

	// VEHICLES
	OPEX_friendly_transportTrucksOpened_woodland = ["rnt_lkw_7t_mil_gl_kat_i_transport_trope", "rnt_lkw_5t_mil_gl_kat_i_transport_trope"];
	OPEX_friendly_transportTrucksOpened_desert = ["rnt_lkw_7t_mil_gl_kat_i_transport_trope", "rnt_lkw_5t_mil_gl_kat_i_transport_trope"];
	OPEX_friendly_transportTrucksOpened_snow = ["rnt_lkw_7t_mil_gl_kat_i_transport_trope", "rnt_lkw_5t_mil_gl_kat_i_transport_trope"];
	OPEX_friendly_transportTrucksCovered_woodland = ["rnt_lkw_7t_mil_gl_kat_i_transport_trope", "rnt_lkw_5t_mil_gl_kat_i_transport_trope"];
	OPEX_friendly_transportTrucksCovered_desert = ["rnt_lkw_7t_mil_gl_kat_i_transport_trope", "rnt_lkw_5t_mil_gl_kat_i_transport_trope"];
	OPEX_friendly_transportTrucksCovered_snow = ["rnt_lkw_7t_mil_gl_kat_i_transport_trope", "rnt_lkw_5t_mil_gl_kat_i_transport_trope"];
	OPEX_friendly_fuelTrucks_woodland = ["rnt_lkw_5t_mil_gl_kat_i_fuel_trope"];
	OPEX_friendly_fuelTrucks_desert = ["rnt_lkw_5t_mil_gl_kat_i_fuel_trope"];
	OPEX_friendly_fuelTrucks_snow = ["rnt_lkw_5t_mil_gl_kat_i_fuel_trope"];
	OPEX_friendly_logisticTrucks_woodland = ["BWA3_Multi_Tropen"];
	OPEX_friendly_logisticTrucks_desert = ["BWA3_Multi_Tropen"];
	OPEX_friendly_logisticTrucks_snow = ["BWA3_Multi_Tropen"];
	OPEX_friendly_medicalTrucks_woodland = ["Redd_Tank_Fuchs_1A4_San_Tropentarn", "Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_San"];
	OPEX_friendly_medicalTrucks_desert = ["Redd_Tank_Fuchs_1A4_San_Tropentarn", "Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_San"];
	OPEX_friendly_medicalTrucks_snow = ["Redd_Tank_Fuchs_1A4_San_Tropentarn", "Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_San"];
	OPEX_friendly_repairTrucks_woodland = ["rnt_lkw_10t_mil_gl_kat_i_repair_trope", "BWA3_Multi_Tropen", "Redd_Tank_Fuchs_1A4_Pi_Tropentarn"];
	OPEX_friendly_repairTrucks_desert = ["rnt_lkw_10t_mil_gl_kat_i_repair_trope", "BWA3_Multi_Tropen", "Redd_Tank_Fuchs_1A4_Pi_Tropentarn"];
	OPEX_friendly_repairTrucks_snow = ["rnt_lkw_10t_mil_gl_kat_i_repair_trope", "BWA3_Multi_Tropen", "Redd_Tank_Fuchs_1A4_Pi_Tropentarn"];
	OPEX_friendly_ammoTrucks_woodland = ["rnt_lkw_7t_mil_gl_kat_i_mun_trope", "BWA3_Multi_Tropen"];
	OPEX_friendly_ammoTrucks_desert = ["rnt_lkw_7t_mil_gl_kat_i_mun_trope", "BWA3_Multi_Tropen"];
	OPEX_friendly_ammoTrucks_snow = ["rnt_lkw_7t_mil_gl_kat_i_mun_trope", "BWA3_Multi_Tropen"];	
	OPEX_friendly_transportCars_woodland = ["Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_FueFu", "Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_FJg", "BWA3_Eagle_Tropen"];
	OPEX_friendly_transportCars_desert = ["Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_FueFu", "Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_FJg", "BWA3_Eagle_Tropen"];
	OPEX_friendly_transportCars_snow = ["Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_FueFu", "Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_FJg", "BWA3_Eagle_Tropen"];
	OPEX_friendly_combatCarsMG_woodland = ["BWA3_Dingo2_FLW100_MG3_Tropen", "BWA3_Dingo2_FLW200_M2_Tropen", "BWA3_Dingo2_FLW200_GMW_Tropen", "BWA3_Eagle_FLW100_Tropen", "Redd_Tank_Fuchs_1A4_Jg_Tropentarn"];
	OPEX_friendly_combatCarsMG_desert = ["BWA3_Dingo2_FLW100_MG3_Tropen", "BWA3_Dingo2_FLW200_M2_Tropen", "BWA3_Dingo2_FLW200_GMW_Tropen", "BWA3_Eagle_FLW100_Tropen", "Redd_Tank_Fuchs_1A4_Jg_Tropentarn"];
	OPEX_friendly_combatCarsMG_snow = ["BWA3_Dingo2_FLW100_MG3_Tropen", "BWA3_Dingo2_FLW200_M2_Tropen", "BWA3_Dingo2_FLW200_GMW_Tropen", "BWA3_Eagle_FLW100_Tropen", "Redd_Tank_Fuchs_1A4_Jg_Tropentarn"];
	OPEX_friendly_combatCarsGL_woodland = ["BWA3_Dingo2_FLW100_MG3_Tropen", "BWA3_Dingo2_FLW200_M2_Tropen", "BWA3_Dingo2_FLW200_GMW_Tropen", "BWA3_Eagle_FLW100_Tropen", "Redd_Tank_Fuchs_1A4_Jg_Tropentarn"];
	OPEX_friendly_combatCarsGL_desert = ["BWA3_Dingo2_FLW100_MG3_Tropen", "BWA3_Dingo2_FLW200_M2_Tropen", "BWA3_Dingo2_FLW200_GMW_Tropen", "BWA3_Eagle_FLW100_Tropen", "Redd_Tank_Fuchs_1A4_Jg_Tropentarn"];
	OPEX_friendly_combatCarsGL_snow = ["BWA3_Dingo2_FLW100_MG3_Tropen", "BWA3_Dingo2_FLW200_M2_Tropen", "BWA3_Dingo2_FLW200_GMW_Tropen", "BWA3_Eagle_FLW100_Tropen", "Redd_Tank_Fuchs_1A4_Jg_Tropentarn"];
	OPEX_friendly_vtt_woodland = ["Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Wiesel_1A4_MK20_Tropentarn", "Redd_Tank_Wiesel_1A4_MK20_Tropentarn", "Redd_Tank_Wiesel_1A2_TOW_Tropentarn"];
	OPEX_friendly_vtt_desert = ["Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Wiesel_1A4_MK20_Tropentarn", "Redd_Tank_Wiesel_1A4_MK20_Tropentarn", "Redd_Tank_Wiesel_1A2_TOW_Tropentarn"];
	OPEX_friendly_vtt_snow = ["Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", "Redd_Tank_Wiesel_1A4_MK20_Tropentarn", "Redd_Tank_Wiesel_1A4_MK20_Tropentarn", "Redd_Tank_Wiesel_1A2_TOW_Tropentarn"];
	OPEX_friendly_tanks_woodland = ["Redd_Marder_1A5_Tropentarn"];
	OPEX_friendly_tanks_desert = ["Redd_Marder_1A5_Tropentarn"];
	OPEX_friendly_tanks_snow = ["Redd_Marder_1A5_Tropentarn"];
	OPEX_friendly_quads_woodland = ["RDS_tt650_Civ_01"];
	OPEX_friendly_quads_desert = ["RDS_tt650_Civ_01"];
	OPEX_friendly_quads_snow = ["RDS_tt650_Civ_01"];
	OPEX_friendly_zodiacs = ["B_Boat_Transport_01_F"];
	OPEX_friendly_ships = ["B_Boat_Armed_01_minigun_F"];
	OPEX_friendly_aircrafts = ["RHS_A10", "RHS_C130J", "rhsusf_f22"];	
	OPEX_friendly_smallCombatHelicopters_woodland = ["RHS_MELB_AH6M", "RHS_MELB_AH6M_H", "RHS_MELB_AH6M_L", "RHS_MELB_AH6M_M"];
	OPEX_friendly_smallCombatHelicopters_desert = ["RHS_MELB_AH6M", "RHS_MELB_AH6M_H", "RHS_MELB_AH6M_L", "RHS_MELB_AH6M_M"];
	OPEX_friendly_smallCombatHelicopters_snow = ["RHS_MELB_AH6M", "RHS_MELB_AH6M_H", "RHS_MELB_AH6M_L", "RHS_MELB_AH6M_M"];
	OPEX_friendly_mediumCombatHelicopters_woodland = ["BWA3_Tiger_RMK", "BWA3_Tiger_RMK"];
	OPEX_friendly_mediumCombatHelicopters_desert = ["BWA3_Tiger_RMK", "BWA3_Tiger_RMK"];
	OPEX_friendly_mediumCombatHelicopters_snow = ["BWA3_Tiger_RMK", "BWA3_Tiger_RMK"];
	OPEX_friendly_smallTransportHelicopters_woodland = ["RHS_MELB_MH6M"];
	OPEX_friendly_smallTransportHelicopters_desert = ["RHS_MELB_MH6M"];
	OPEX_friendly_smallTransportHelicopters_snow = ["RHS_MELB_MH6M"];
	OPEX_friendly_mediumTransportHelicopters_woodland = ["BWA3_NH90_TTH_Fleck", "BWA3_NH90_TTH_M3M_Fleck", "BWA3_NH90_TTH_Tropen", "BWA3_NH90_TTH_M3M_Tropen"];
	OPEX_friendly_mediumTransportHelicopters_desert = ["BWA3_NH90_TTH_Fleck", "BWA3_NH90_TTH_M3M_Fleck", "BWA3_NH90_TTH_Tropen", "BWA3_NH90_TTH_M3M_Tropen"];
	OPEX_friendly_mediumTransportHelicopters_snow = ["BWA3_NH90_TTH_Fleck", "BWA3_NH90_TTH_M3M_Fleck", "BWA3_NH90_TTH_Tropen", "BWA3_NH90_TTH_M3M_Tropen"];
	OPEX_friendly_bigTransportHelicopters_woodland = ["BWA3_NH90_TTH_Fleck", "BWA3_NH90_TTH_M3M_Fleck", "BWA3_NH90_TTH_Tropen", "BWA3_NH90_TTH_M3M_Tropen"];
	OPEX_friendly_bigTransportHelicopters_desert = ["BWA3_NH90_TTH_Fleck", "BWA3_NH90_TTH_M3M_Fleck", "BWA3_NH90_TTH_Tropen", "BWA3_NH90_TTH_M3M_Tropen"];
	OPEX_friendly_bigTransportHelicopters_snow = ["BWA3_NH90_TTH_Fleck", "BWA3_NH90_TTH_M3M_Fleck", "BWA3_NH90_TTH_Tropen", "BWA3_NH90_TTH_M3M_Tropen"];
	OPEX_friendly_UAVs = ["USAF_MQ9"];
	OPEX_friendly_UGVs = ["B_Quadbike_01_F"];
	OPEX_friendly_portableDrones = ["B_UAV_01_F"];
	OPEX_friendly_portableDronesBackpack = ["B_UAV_01_backpack_F"];
	OPEX_friendly_drones = OPEX_friendly_UAVs + OPEX_friendly_UGVs + OPEX_friendly_portableDrones;
	OPEX_friendly_MGstatics = ["RHS_M2StaticMG_WD", "RHS_M2StaticMG_MiniTripod_WD"];
	OPEX_friendly_GLstatics = ["RHS_MK19_TriPod_WD"];
	OPEX_friendly_ATstatics = ["BWA3_MELLS_static_Fleck"];
	OPEX_friendly_AAstatics = ["RHS_Stinger_AA_pod_D"];
	OPEX_friendly_mortarStatics = ["BWA3_MRS120_Tropen"];
	OPEX_friendly_vehicle_variants = ["LOP_CDF_BTR70", "LOP_CDF_BMP2D", "LOP_CDF_Mi8MT_Cargo", "rhsusf_m113d_usarmy_unarmed"];

	// WEAPONS
	OPEX_friendly_commonHandguns = ["BWA3_P8"];
	OPEX_friendly_specialHandguns = ["BWA3_P12"];
	OPEX_friendly_commonRifles = ["BWA3_G36A1", "BWA3_G36A2","BWA3_G36A3"];
	OPEX_friendly_specialRifles = ["BWA3_G36KA0","BWA3_G36KA2", "BWA3_G36KA3"];
	OPEX_friendly_GLrifles = ["BWA3_G36A1_AG40","BWA3_G36A2_AG40","BWA3_G36A3_AG40"];
	OPEX_friendly_MGriflesLight = ["BWA3_MG4"];
	OPEX_friendly_MGriflesHeavy = ["BWA3_MG3", "BWA3_MG5"];
	OPEX_friendly_MGrifles = OPEX_friendly_MGriflesLight + OPEX_friendly_MGriflesHeavy; // don't delete this line if you have defined any of these variables
	OPEX_friendly_compactRifles = ["BWA3_MP7"];
	OPEX_friendly_precisionRifles = ["BWA3_G28"];
	OPEX_friendly_sniperRifles = ["BWA3_G82", "BWA3_G29"];
	OPEX_friendly_ATlaunchers = ["BWA3_Bunkerfaust","BWA3_CarlGustav","BWA3_PzF3","BWA3_RGW90"];
	OPEX_friendly_AAlaunchers = ["BWA3_Fliegerfaust"];
	OPEX_friendly_shotguns = ["rhs_weap_M590_8RD", "rhs_weap_M590_5RD"];

	OPEX_friendly_handGrenades = ["BWA3_DM51A1"];
	OPEX_friendly_smokeGrenades_white = ["BWA3_DM25"];
	OPEX_friendly_smokeGrenades_colors = ["BWA3_DM32_Blue","BWA3_DM32_Green","BWA3_DM32_Orange","BWA3_DM32_Purple","BWA3_DM32_Red","BWA3_DM32_Yellow"];

	// WEAPON ACCESSORIES
	OPEX_friendly_closeCombatOptics = ["BWA3_optic_RSAS", "BWA3_optic_EOTech552"];
	OPEX_friendly_distantCombatOptics = ["BWA3_optic_ZO4x30","BWA3_optic_ZO4x30_RSAS","BWA3_optic_ZO4x30i","BWA3_optic_ZO4x30i_RSAS"];
	OPEX_friendly_sniperOptics = ["BWA3_optic_PMII_ShortdotCC","BWA3_optic_PMII_DMR","BWA3_optic_PMII_DMR_MicroT1_front","BWA3_optic_PMII_DMR_MicroT1_rear","BWA3_optic_M5Xi_MSR","BWA3_optic_M5Xi_MSR_MicroT2","BWA3_optic_M5Xi_Tremor3","BWA3_optic_M5Xi_Tremor3_MicroT2"];
	OPEX_friendly_rifleSilencers = ["BWA3_muzzle_snds_Rotex_II", "BWA3_muzzle_snds_Rotex_IIA","BWA3_muzzle_snds_QDSS","BWA3_muzzle_snds_Rotex_IIIC","BWA3_muzzle_snds_Rotex_Monoblock"];
	OPEX_friendly_handgunSilencers = ["BWA3_muzzle_snds_Impuls_IIA"];
	OPEX_friendly_pointers = ["BWA3_acc_VarioRay_irlaser_black","BWA3_acc_LLM01_irlaser","BWA3_acc_LLMPI_irlaser"];
	OPEX_friendly_bipods = ["BWA3_bipod_Harris","BWA3_bipod_Atlas","BWA3_bipod_MG3"];

	// VARIOUS ITEMS
	OPEX_medical_commonSupplies append ["BWA3_ItemNaviPad"];

	// UNIFORMS
	OPEX_friendly_commonUniforms_woodland = ["BWA3_Uniform2_Tropen","BWA3_Uniform2_sleeves_Tropen"];
	OPEX_friendly_commonUniforms_desert = ["BWA3_Uniform2_Tropen","BWA3_Uniform2_sleeves_Tropen"];
	OPEX_friendly_commonUniforms_snow = ["BWA3_Uniform2_Tropen","BWA3_Uniform2_sleeves_Tropen"];
	OPEX_friendly_specialUniforms_woodland = ["BWA3_Uniform_Crye_G3_Multi"];
	OPEX_friendly_specialUniforms_desert = ["BWA3_Uniform_Crye_G3_Multi"];
	OPEX_friendly_specialUniforms_snow = ["BWA3_Uniform_Crye_G3_Multi"];
	OPEX_friendly_ghillieUniforms_woodland = ["BWA3_Uniform2_Ghillie_Tropen"];
	OPEX_friendly_ghillieUniforms_desert = ["BWA3_Uniform2_Ghillie_Tropen"];
	OPEX_friendly_ghillieUniforms_snow = ["BWA3_Uniform2_Ghillie_Tropen"];
	OPEX_friendly_heliPilotUniforms_woodland = ["BWA3_Uniform_Helipilot"];
	OPEX_friendly_heliPilotUniforms_desert = ["BWA3_Uniform_Helipilot"];
	OPEX_friendly_heliPilotUniforms_snow = ["BWA3_Uniform_Helipilot"];
	OPEX_friendly_aircraftPilotUniforms_woodland = ["BWA3_Uniform_Helipilot"];
	OPEX_friendly_aircraftPilotUniforms_desert = ["BWA3_Uniform_Helipilot"];
	OPEX_friendly_aircraftPilotUniforms_snow = ["BWA3_Uniform_Helipilot"];
	OPEX_friendly_tankPilotUniforms_woodland = ["BWA3_Uniform_Crew_Tropen"];
	OPEX_friendly_tankPilotUniforms_desert = ["BWA3_Uniform_Crew_Tropen"];
	OPEX_friendly_tankPilotUniforms_snow = ["BWA3_Uniform_Crew_Tropen"];
	OPEX_friendly_medicUniforms_woodland = ["BWA3_Uniform2_Tropen","BWA3_Uniform2_sleeves_Tropen"];
	OPEX_friendly_medicUniforms_desert = ["BWA3_Uniform2_Tropen","BWA3_Uniform2_sleeves_Tropen"];
	OPEX_friendly_medicUniforms_snow = ["BWA3_Uniform2_Tropen","BWA3_Uniform2_sleeves_Tropen"];
	OPEX_friendly_instructorUniforms_woodland = ["BWA3_Uniform_sleeves_Tropen"];
	OPEX_friendly_instructorUniforms_desert = ["BWA3_Uniform_sleeves_Tropen"];
	OPEX_friendly_instructorUniforms_snow = ["BWA3_Uniform_sleeves_Tropen"];
	OPEX_friendly_tshirtUniforms_woodland = ["BWA3_Uniform_tee_Tropen"];
	OPEX_friendly_tshirtUniforms_desert = ["BWA3_Uniform_tee_Tropen"];
	OPEX_friendly_tshirtUniforms_snow = ["BWA3_Uniform_tee_Tropen"];
	OPEX_friendly_tshirtUniforms = [];
	OPEX_friendly_tshirtUniforms append OPEX_friendly_tshirtUniforms_woodland;

	// VESTS
	OPEX_friendly_commonVests_woodland = ["BWA3_Vest_Rifleman_Tropen"];
	OPEX_friendly_commonVests_desert = ["BWA3_Vest_Rifleman_Tropen"];
	OPEX_friendly_commonVests_snow = ["BWA3_Vest_Rifleman_Tropen"];
	OPEX_friendly_commonVests = [];
	OPEX_friendly_commonVests append OPEX_friendly_commonVests_woodland;
	OPEX_friendly_specialVests_woodland = ["BWA3_Vest_Leader_Tropen"];
	OPEX_friendly_specialVests_desert = ["BWA3_Vest_Leader_Tropen"];
	OPEX_friendly_specialVests_snow = ["BWA3_Vest_Leader_Tropen"];
	OPEX_friendly_medicVests_woodland = ["BWA3_Vest_Medic_Tropen"];
	OPEX_friendly_medicVests_desert = ["BWA3_Vest_Medic_Tropen"];
	OPEX_friendly_medicVests_snow = ["BWA3_Vest_Medic_Tropen"];
	OPEX_friendly_lightVests_woodland = ["BWA3_Vest_Tropen"];
	OPEX_friendly_lightVests_desert = ["BWA3_Vest_Tropen"];
	OPEX_friendly_lightVests_snow = ["BWA3_Vest_Tropen"];
	OPEX_friendly_grenadierVests_woodland = ["BWA3_Vest_Grenadier_Tropen"];
	OPEX_friendly_grenadierVests_desert = ["BWA3_Vest_Grenadier_Tropen"];
	OPEX_friendly_grenadierVests_snow = ["BWA3_Vest_Grenadier_Tropen"];
	OPEX_friendly_EODvests_woodland = ["BWA3_Vest_Grenadier_Tropen"];
	OPEX_friendly_EODvests_desert = ["BWA3_Vest_Grenadier_Tropen"];
	OPEX_friendly_EODvests_snow = ["BWA3_Vest_Grenadier_Tropen"];

	// HEADGEAR
	OPEX_friendly_commonHelmets_woodland = ["BWA3_M92_Tropen"];
	OPEX_friendly_commonHelmets_desert = ["BWA3_M92_Tropen"];
	OPEX_friendly_commonHelmets_snow = ["BWA3_M92_Tropen"];
	OPEX_friendly_specialHelmets_woodland = ["BWA3_OpsCore_FastMT_Peltor_Tropen","BWA3_OpsCore_FastMT_SOF_Tropen"];
	OPEX_friendly_specialHelmets_desert = ["BWA3_OpsCore_FastMT_Peltor_Tropen","BWA3_OpsCore_FastMT_SOF_Tropen"];
	OPEX_friendly_specialHelmets_snow = ["BWA3_OpsCore_FastMT_Peltor_Tropen","BWA3_OpsCore_FastMT_SOF_Tropen"];
	OPEX_friendly_EODhelmets_woodland = ["BWA3_OpsCore_FastMT_Peltor_Tropen","BWA3_OpsCore_FastMT_SOF_Tropen"];
	OPEX_friendly_EODhelmets_desert = ["BWA3_OpsCore_FastMT_Peltor_Tropen","BWA3_OpsCore_FastMT_SOF_Tropen"];
	OPEX_friendly_EODhelmets_snow = ["BWA3_OpsCore_FastMT_Peltor_Tropen","BWA3_OpsCore_FastMT_SOF_Tropen"];
	OPEX_friendly_heliPilotHelmets = ["BWA3_TopOwl_nvg"];
	OPEX_friendly_aircraftPilotHelmets = ["BWA3_Knighthelm"];
	OPEX_friendly_tankCrewHelmets = ["BWA3_CrewmanKSK_Tropen_Headset"];
	OPEX_friendly_cameraHelmets_woodland append ["rhsusf_opscore_fg_pelt_cam","rhsusf_opscore_mc_cover_pelt_cam", "rhsusf_opscore_paint_pelt_nsw_cam", "rhsusf_opscore_ut_pelt_cam", "rhsusf_opscore_ut_pelt_nsw_cam"];
	OPEX_friendly_cameraHelmets_desert append ["rhsusf_opscore_fg_pelt_cam","rhsusf_opscore_mc_cover_pelt_cam", "rhsusf_opscore_paint_pelt_nsw_cam", "rhsusf_opscore_ut_pelt_cam", "rhsusf_opscore_ut_pelt_nsw_cam"];
	OPEX_friendly_cameraHelmets_snow append ["rhsusf_opscore_fg_pelt_cam","rhsusf_opscore_mc_cover_pelt_cam", "rhsusf_opscore_paint_pelt_nsw_cam", "rhsusf_opscore_ut_pelt_cam", "rhsusf_opscore_ut_pelt_nsw_cam"];
	OPEX_friendly_cameraHelmets = OPEX_friendly_cameraHelmets_woodland + OPEX_friendly_cameraHelmets_desert + OPEX_friendly_cameraHelmets_snow; // don't delete this line if you have defined any of these variables
	OPEX_friendly_hats_woodland = ["BWA3_Booniehat_Tropen"];
	OPEX_friendly_hats_desert = ["BWA3_Booniehat_Tropen"];
	OPEX_friendly_hats_snow = ["BWA3_Booniehat_Tropen"];
	OPEX_friendly_leaderHeadgear_woodland = ["BWA3_OpsCore_FastMT_Peltor_Tropen","BWA3_OpsCore_FastMT_SOF_Tropen"];
	OPEX_friendly_leaderHeadgear_desert = ["BWA3_OpsCore_FastMT_Peltor_Tropen","BWA3_OpsCore_FastMT_SOF_Tropen"];
	OPEX_friendly_leaderHeadgear_snow = ["BWA3_OpsCore_FastMT_Peltor_Tropen","BWA3_OpsCore_FastMT_SOF_Tropen"];
	OPEX_friendly_berets = ["BWA3_Beret_Falli","BWA3_Beret_HFlieger","BWA3_Beret_Jaeger","BWA3_Beret_PzAufkl","BWA3_Beret_PzGren","BWA3_Beret_Pz","BWA3_Beret_Wach_blue","BWA3_Beret_Wach_green"];
	OPEX_friendly_bandanas = [""];
	OPEX_friendly_leaderHeadgear = [];
	OPEX_friendly_leaderHeadgear append OPEX_friendly_leaderHeadgear_woodland;

	// FACEGEAR
	OPEX_friendly_glasses append ["BWA3_G_Combat_clear","BWA3_G_Combat_clear","BWA3_G_Combat_clear"];
	OPEX_friendly_sunglasses append ["BWA3_G_Combat_clear","BWA3_G_Combat_black","BWA3_G_Combat_black","BWA3_G_Combat_black","BWA3_G_Combat_black","BWA3_G_Combat_black","BWA3_G_Combat_orange","BWA3_G_Combat_orange","BWA3_G_Combat_orange"];

	// BACKPACKS
	OPEX_friendly_mediumBackpacks_woodland = ["BWA3_AssaultPack_Tropen","BWA3_FieldPack_Tropen","BWA3_TacticalPack_Tropen","BWA3_Kitbag_Tropen"];
	OPEX_friendly_mediumBackpacks_desert = ["BWA3_AssaultPack_Tropen","BWA3_FieldPack_Tropen","BWA3_TacticalPack_Tropen","BWA3_Kitbag_Tropen"];
	OPEX_friendly_mediumBackpacks_snow = ["BWA3_AssaultPack_Tropen","BWA3_FieldPack_Tropen","BWA3_TacticalPack_Tropen","BWA3_Kitbag_Tropen"];
	OPEX_friendly_bigBackpacks_woodland = ["BWA3_PatrolPack_Tropen","BWA3_Carryall_Tropen"];
	OPEX_friendly_bigBackpacks_desert = ["BWA3_PatrolPack_Tropen","BWA3_Carryall_Tropen"];
	OPEX_friendly_bigBackpacks_snow = ["BWA3_PatrolPack_Tropen","BWA3_Carryall_Tropen"];
	OPEX_friendly_medicBackpacks_woodland = ["BWA3_TacticalPack_Tropen_Medic","BWA3_TacticalPack_Fleck_Medic","BWA3_Kitbag_Tropen_Medic", "BWA3_AssaultPack_Tropen_Medic"];
	OPEX_friendly_medicBackpacks_desert = ["BWA3_TacticalPack_Tropen_Medic","BWA3_TacticalPack_Fleck_Medic","BWA3_Kitbag_Tropen_Medic", "BWA3_AssaultPack_Tropen_Medic"];
	OPEX_friendly_medicBackpacks_snow = ["BWA3_TacticalPack_Tropen_Medic","BWA3_TacticalPack_Fleck_Medic","BWA3_Kitbag_Tropen_Medic", "BWA3_AssaultPack_Tropen_Medic"];

OPEX_vehicleTypeDingo = [
    [
        "BWA3_Dingo2_FLW100_MG3_Tropen", 
        "BWA3_Dingo2_FLW200_GMW_Tropen", 
        "BWA3_Dingo2_FLW200_M2_Tropen", 
        "BWA3_Dingo2_FLW200_GMW_CG13_Tropen", 
        "BWA3_Dingo2_FLW200_M2_CG13_Tropen", 
        "BWA3_Dingo2_FLW100_MG3_CG13_Tropen", 
        "BWA3_Dingo2_FLW100_MG3_Fleck", 
        "BWA3_Dingo2_FLW200_GMW_Fleck", 
        "BWA3_Dingo2_FLW200_M2_Fleck", 
        "BWA3_Dingo2_FLW200_GMW_CG13_Fleck", 
        "BWA3_Dingo2_FLW200_M2_CG13_Fleck", 
        "BWA3_Dingo2_FLW100_MG3_CG13_Fleck"
    ], [
        [
            ["BWA3_G36KA2_RSAS_pointer", 2],
            ["BWA3_PzF3_Tandem_Loaded", 2],
            ["BWA3_30Rnd_556x45_G36", 30],
            ["BWA3_30Rnd_556x45_G36_Tracer", 6],
            ["BWA3_200Rnd_556x45", 10],
            ["BWA3_DM51A1", 10],
            ["BWA3_DM25", 10],
            ["BWA3_DM32_Purple", 2],
            ["BWA3_DM32_Red", 2],
            ["kat_IFAK", 3],
            ["ToolKit", 1],
            ["ACE_rope15", 1]
        ], [
            ["BWA3_AssaultPack_Tropen", 1]
        ]
    ]
];
OPEX_vehicleTypeEagle = [
    [
        "BWA3_Eagle_Fleck", 
        "BWA3_Eagle_FLW100_Fleck", 
        "BWA3_Eagle_Tropen", 
        "BWA3_Eagle_FLW100_Tropen",
        "Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_FueFu", 
        "Redd_Tank_LKW_leicht_gl_Wolf_Wintertarn_FueFu", 
        "Redd_Tank_LKW_leicht_gl_Wolf_Flecktarn_FueFu", 
        "Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_FJg", 
        "Redd_Tank_LKW_leicht_gl_Wolf_Wintertarn_FJg", 
        "Redd_Tank_LKW_leicht_gl_Wolf_Flecktarn_FJg"
    ], [
        [
            ["BWA3_G36KA2_RSAS_pointer", 2],
            ["BWA3_PzF3_Tandem_Loaded", 1],
            ["BWA3_30Rnd_556x45_G36", 20],
            ["BWA3_30Rnd_556x45_G36_Tracer", 4],
            ["BWA3_200Rnd_556x45", 10],
            ["BWA3_DM51A1", 10],
            ["BWA3_DM25", 10],
            ["BWA3_DM32_Purple", 2],
            ["BWA3_DM32_Red", 2],
            ["kat_IFAK", 2],
            ["ToolKit", 1],
            ["ACE_rope15", 1]
        ], [
            ["BWA3_AssaultPack_Tropen", 1]
        ]
    ]
];
OPEX_vehicleTypeFuchs = [
    [
        "Redd_Tank_Fuchs_1A4_Jg_Tropentarn", 
        "Redd_Tank_Fuchs_1A4_Jg_Wintertarn", 
        "Redd_Tank_Fuchs_1A4_Jg_Flecktarn", 
        "Redd_Tank_Fuchs_1A4_Jg_Milan_Tropentarn", 
        "Redd_Tank_Fuchs_1A4_Jg_Milan_Wintertarn", 
        "Redd_Tank_Fuchs_1A4_Jg_Milan_Flecktarn"
    ], [
        [
            ["BWA3_G36KA2_RSAS_pointer", 2],
            ["BWA3_PzF3_Tandem_Loaded", 2],
            ["BWA3_30Rnd_556x45_G36", 50],
            ["BWA3_30Rnd_556x45_G36_Tracer", 10],
            ["BWA3_200Rnd_556x45", 10],
            ["BWA3_120Rnd_762x51_soft", 8],
            ["BWA3_DM51A1", 15],
            ["BWA3_DM25", 15],
            ["BWA3_DM32_Purple", 2],
            ["BWA3_DM32_Red", 2],
            ["kat_IFAK", 5],
            ["ToolKit", 1],
            ["ACE_rope15", 1]
        ], [
            ["BWA3_AssaultPack_Tropen", 1]
        ]
    ]
];
OPEX_vehicleTypeMarder = [
    [
        "Redd_Marder_1A5_Tropentarn", 
        "Redd_Marder_1A5_Wintertarn", 
        "Redd_Marder_1A5_Flecktarn"
    ], [
        [
            ["BWA3_MP7_RSAS_pointer", 1],
            ["BWA3_PzF3_Tandem_Loaded", 2],
            ["BWA3_30Rnd_556x45_G36", 50],
            ["BWA3_30Rnd_556x45_G36_Tracer", 10],
            ["BWA3_200Rnd_556x45", 10],
            ["BWA3_120Rnd_762x51_soft", 8],
            ["BWA3_40Rnd_46x30_MP7", 4],
            ["BWA3_DM51A1", 15],
            ["BWA3_DM25", 15],
            ["BWA3_DM32_Purple", 2],
            ["BWA3_DM32_Red", 2],
            ["kat_IFAK", 5],
            ["ToolKit", 1],
            ["ACE_rope15", 1]
        ], [
            ["BWA3_AssaultPack_Tropen", 1]
        ]
    ]
];
OPEX_vehicleTypeFuchsEngi = [
    [
        "Redd_Tank_Fuchs_1A4_Pi_Tropentarn", 
        "Redd_Tank_Fuchs_1A4_Pi_Wintertarn", 
        "Redd_Tank_Fuchs_1A4_Pi_Flecktarn"
    ], [
        [
            ["BWA3_G36KA2_RSAS_pointer", 2],
            ["BWA3_CarlGustav_Optic", 1],
            ["rhs_weap_M136_hedp", 2],
            ["ACE_VMM3", 3],
            ["BWA3_30Rnd_556x45_G36", 40],
            ["BWA3_30Rnd_556x45_G36_Tracer", 8],
            ["BWA3_200Rnd_556x45", 5],
            ["BWA3_120Rnd_762x51_soft", 5],
            ["BWA3_CarlGustav_HEDP", 2],
            ["BWA3_CarlGustav_HE", 4],
            ["BWA3_DM51A1", 10],
            ["BWA3_DM25", 10],
            ["BWA3_DM32_Purple", 2],
            ["BWA3_DM32_Red", 2],
            ["rhsusf_m112_mag", 8],
            ["rhsusf_m112x4_mag", 1],
            ["kat_IFAK", 4],
            ["ACE_EntrenchingTool", 3],
            ["ACE_Clacker", 1],
            ["tsp_breach_shock", 3],
            ["ACE_wirecutter", 1],
            ["ACE_DefusalKit", 3],
            ["ToolKit", 2],
            ["ACE_rope15", 1]
        ], [
            ["BWA3_AssaultPack_Tropen", 2]
        ]
    ]
];
OPEX_vehicleTypeFuchsMed = [
    [
        "Redd_Tank_Fuchs_1A4_San_Tropentarn", 
        "Redd_Tank_Fuchs_1A4_San_Wintertarn", 
        "Redd_Tank_Fuchs_1A4_San_Flecktarn",
        "Redd_Tank_LKW_leicht_gl_Wolf_Tropentarn_San", 
        "Redd_Tank_LKW_leicht_gl_Wolf_Wintertarn_San", 
        "Redd_Tank_LKW_leicht_gl_Wolf_Flecktarn_San"
    ], [
        [
            ["BWA3_G36KA2_RSAS_pointer", 1],
            ["BWA3_30Rnd_556x45_G36", 25],
            ["BWA3_30Rnd_556x45_G36_Tracer", 5],
            ["BWA3_200Rnd_556x45", 10],
            ["BWA3_DM51A1", 10],
            ["BWA3_DM25", 10],
            ["BWA3_DM32_Purple", 2],
            ["BWA3_DM32_Red", 2],
            ["kat_IFAK", 4],
            ["kat_MFAK", 2],
            ["ACE_surgicalKit", 2],
            ["ACE_suture", 75],
            ["kat_X_AED", 1],
            ["kat_nasal", 2],
            ["kat_ultrasound", 1],
            ["kat_clamp", 2],
            ["kat_retractor", 2],
            ["kat_scalpel", 2],
            ["kat_accuvac", 2],
            ["kat_Pulseoximeter", 2],
            ["kat_plate", 15],
            ["kat_etomidate", 15],
            ["kat_lorazepam", 15],
            ["kat_flumazenil", 15],
            ["ACE_atropine", 15],
            ["kat_lidocaine", 15],
            ["kat_norepinephrine", 15],
            ["kat_nitroglycerin", 15],
            ["kat_IV_16", 15],
            ["kat_IO_FAST", 2],
            ["kat_larynx", 15],
            ["kat_BVM", 1],
            ["kat_oxygenTank_300", 5],
            ["ACE_plasmaIV_500", 4],
            ["ACE_salineIV", 3],
            ["ACE_salineIV_500", 6],
            ["kat_bloodIV_O_N_500", 2],
            ["KAT_Empty_bloodIV_500", 4],
            ["ToolKit", 1],
            ["ACE_rope15", 1],
            ["ACE_bodyBag", 15]
        ], [
            ["BWA3_AssaultPack_Tropen", 1]
        ]
    ]
];
OPEX_vehicleTypeTruck = [
    [
        "BWA3_Multi_Fleck", 
        "BWA3_Multi_Tropen", 
        "Redd_Tank_Wiesel_1A2_TOW_Tropentarn", 
        "Redd_Tank_Wiesel_1A2_TOW_Wintertarn", 
        "Redd_Tank_Wiesel_1A2_TOW_Flecktarn", 
        "Redd_Tank_Wiesel_1A4_MK20_Tropentarn", 
        "Redd_Tank_Wiesel_1A4_MK20_Wintertarn", 
        "Redd_Tank_Wiesel_1A4_MK20_Flecktarn", 
        "rnt_lkw_10t_mil_gl_kat_i_repair_trope", 
        "rnt_lkw_10t_mil_gl_kat_i_repair_winter", 
        "rnt_lkw_10t_mil_gl_kat_i_repair_fleck", 
        "rnt_lkw_5t_mil_gl_kat_i_fuel_trope", 
        "rnt_lkw_5t_mil_gl_kat_i_fuel_winter", 
        "rnt_lkw_5t_mil_gl_kat_i_fuel_fleck", 
        "rnt_lkw_5t_mil_gl_kat_i_transport_trope", 
        "rnt_lkw_5t_mil_gl_kat_i_transport_winter", 
        "rnt_lkw_5t_mil_gl_kat_i_transport_fleck", 
        "rnt_lkw_7t_mil_gl_kat_i_mun_trope", 
        "rnt_lkw_7t_mil_gl_kat_i_mun_winter", 
        "rnt_lkw_7t_mil_gl_kat_i_mun_fleck", 
        "rnt_lkw_7t_mil_gl_kat_i_transport_trope", 
        "rnt_lkw_7t_mil_gl_kat_i_transport_winter", 
        "rnt_lkw_7t_mil_gl_kat_i_transport_fleck"
    ], [
        [
            ["BWA3_G36KA2_RSAS_pointer", 2],
            ["BWA3_30Rnd_556x45_G36", 15],
            ["BWA3_30Rnd_556x45_G36_Tracer", 3],
            ["kat_IFAK", 2],
            ["ToolKit", 1],
            ["ACE_rope15", 1]
        ], [
            ["BWA3_AssaultPack_Tropen", 1]
        ]
    ]
];
OPEX_vehicleTypeHeli = [
    [
        "BWA3_NH90_TTH_Fleck", 
        "BWA3_NH90_TTH_M3M_Fleck", 
        "BWA3_Tiger", 
        "BWA3_Tiger_RMK", 
        "BWA3_NH90_TTH_Tropen", 
        "BWA3_NH90_TTH_M3M_Tropen", 
        "RHS_MELB_AH6M",
        "RHS_MELB_AH6M_H", 
        "RHS_MELB_AH6M_L", 
        "RHS_MELB_AH6M_M", 
        "RHS_MELB_MH6M", 
        "RHS_MELB_H6M"
    ], [
        [
            ["BWA3_MP7_RSAS_pointer", 2],
            ["BWA3_40Rnd_46x30_MP7", 8],
            ["BWA3_DM32_Purple", 2],
            ["ACE_HandFlare_Green", 2],
            ["kat_IFAK", 2],
            ["ACE_rope36", 2],
            ["ACE_bodyBag", 10]
        ], []
    ]
];
OPEX_loadoutHeliDefault = [
    [
        ["BWA3_MP7_RSAS_pointer", 2],
        ["BWA3_40Rnd_46x30_MP7", 8],
        ["BWA3_DM32_Purple", 2],
        ["ACE_HandFlare_Green", 2],
        ["kat_IFAK", 2],
        ["ACE_rope36", 2],
        ["ACE_bodyBag", 10]
    ], []
];
OPEX_loadoutCarDefault = [
    [
        ["BWA3_G36KA2_RSAS_pointer", 2],
        ["BWA3_30Rnd_556x45_G36", 15],
        ["BWA3_30Rnd_556x45_G36_Tracer", 3],
        ["kat_IFAK", 2],
        ["ToolKit", 1],
        ["ACE_rope15", 1]
    ], [
        ["BWA3_AssaultPack_Tropen", 1]
    ]
];