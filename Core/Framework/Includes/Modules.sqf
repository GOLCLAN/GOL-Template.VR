
// ================================================================
	#define PREFIX ACE
	#define ADDON DOUBLES(PREFIX,COMPONENT)
	#define Add(Variable, Value) MakePublic(DOUBLES(ADDON,Variable), Value);

	if (isClass(configFile>>"CfgPatches">>"ACE_Respawn")) then {
		#define COMPONENT Respawn
		Add(RemoveDeadBodiesDisconnected, true);
		Add(SavePreDeathGear, true);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Medical")) then {
		#define COMPONENT Medical
//		ACE 3 Medical
		Add(level, 1);
		Add(medicSetting, 1);
		Add(allowLitterCreation, true);
		Add(litterCleanUpDelay, 0);
		Add(enableScreams, true);
		Add(playerDamageThreshold, 1.5);
		Add(AIDamageThreshold, 1);
		Add(enableUnconsciousnessAI, 1);
		Add(remoteControlledAI, false);
		Add(preventInstaDeath, false);
		Add(bleedingCoefficient, 11.0);
		Add(painCoefficient, 8.0);
		Add(keepLocalSettingsSynced, true);

		Add(enableOverdosing, true);
		Add(painEffectType, 1);
		Add(allowDeadBodyMovement, true);
		Add(allowUnconsciousAnimationOnTreatment, true);
		Add(moveUnitsFromGroupOnUnconscious, false);

//		ACE 3 Advanced Medical
		Add(enableFor, 1);
		Add(enableAdvancedWounds, false);
		Add(enableVehicleCrashes, false);
		Add(medicSetting_PAK, 0);
		Add(consumeItem_PAK, 0);
		Add(useLocation_PAK, 0);
		Add(useCondition_PAK, 0);
		Add(medicSetting_SurgicalKit, 0);
		Add(consumeItem_SurgicalKit, 0);
		Add(useLocation_SurgicalKit, 0);
		Add(useCondition_SurgicalKit, 0);
		Add(healHitPointAfterAdvBandage, true);
		Add(painIsOnlySuppressed, true);

//		ACE 3 Revive Settings
		Add(enableRevive, 0);
		Add(maxReviveTime, 120);
		Add(amountOfReviveLives, -1);
	};

// *	================================================================
// *		DONT EDIT ANYTHING BELOW
// *	================================================================

	if (isClass(configFile>>"CfgPatches">>"ACE_Advanced_Ballistics")) then {
		#define COMPONENT Advanced_Ballistics
		Add(enabled, false);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Advanced_Fatigue")) then {
		#define COMPONENT Advanced_Fatigue
		Add(enabled, true);
		Add(enableStaminaBar, false);
		Add(performanceFactor, 1.5);
		Add(recoveryFactor, 2);
		Add(loadFactor, 0);
		Add(terrainGradientFactor, 0);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Advanced_Throwing")) then {
		#define COMPONENT Advanced_Throwing
		Add(enabled, true);
		Add(showThrowArc, true);
		Add(showMouseControls, true);
		Add(enablePickUp, true);
		Add(enablePickUpAttached, false);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Captives")) then {
		#define COMPONENT Captives
		Add(allowHandcuffOwnSide, false);
		Add(requireSurrender,0);
		Add(allowSurrender, false);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Common")) then {
		#define COMPONENT Common
		Add(checkPBOsAction, 0);
		Add(checkPBOsCheckAll, false);
		Add(checkPBOsWhitelist, "['ace_tracers']");
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Dragging")) then {
		MakePublic(ACE_maxWeightDrag,100000);
		MakePublic(ACE_maxWeightCarry,100000);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Frag")) then {
		#define COMPONENT Frag
		Add(Enabled,true);
		Add(EnableDebugTrace,false);
		Add(SpallEnabled,false);
		Add(maxTrack,500);
		Add(MaxTrackPerFrame,50);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Finger")) then {
		#define COMPONENT Finger
		Add(enabled,true);
		Add(maxRange,5);
		Add(indicatorForSelf,true);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Hearing")) then {
		#define COMPONENT Hearing
		Add(EnableCombatDeafness, false);
		Add(EarplugsVolume, 1.0);
		Add(UnconsciousnessVolume, 0.8);
		Add(DisableEarRinging, true);
		Add(enabledForZeusUnits, false);
		Add(autoAddEarplugsToUnits, false);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Interaction")) then {
		#define COMPONENT Interaction
		Add(EnableTeamManagement, false);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Map")) then {
		#define COMPONENT Map
		Add(mapIllumination, true);
		Add(mapGlow, true);
		Add(mapShake, true);
		Add(mapLimitZoom, false);
		Add(mapShowCursorCoordinates, false);
		Add(DefaultChannel, 3);
		Add(BFT_Enabled, false);
		Add(BFT_Interval, 5.0);
		Add(BFT_HideAiGroups, true);

		#define COMPONENT Maptools
		Add(EveryoneCanDrawOnBriefing, false);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Map_Gestures")) then {
		#define COMPONENT Map_Gestures
		Add(enabled, true);
		Add(maxRange, 7);
		Add(interval, 0.05);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Nametags")) then {
		#define COMPONENT Nametags
		Add(playerNamesViewDistance, 50);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_NightVision")) then {
		#define COMPONENT NightVision
		Add(disableNVGsWithSights,false);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Viewdistance")) then {
		MakePublic(ACE_Viewdistance_Enabled,false);
		MakePublic(ACE_Viewdistance_limitViewDistance,10000);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Weather")) then {
		#define COMPONENT Weather
		Add(enableServerController, true);
		Add(useACEWeather, true);
		Add(syncRain, true);
		Add(syncWind, true);
		Add(syncMisc, true);
		Add(serverUpdateInterval, 60);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_WindDeflection")) then {
		#define COMPONENT WindDeflection
		Add(enabled, false);
	};

	if (isClass(configFile>>"CfgPatches">>"ACE_Zeus")) then {
		#define COMPONENT Zeus
		Add(zeusAscension, false);
		Add(zeusBird, false);
		Add(remoteWind, false);
		Add(radioOrdnance, false);
		Add(revealMines, 0);
		Add(autoAddObjects, false);
	};

// ================================================================

	["FRAMEWORK MODULES INITIALIZED",["GOL-Modules",__FILE__,__LINE__],"log"] call GOL_Fnc_DebugLog;
