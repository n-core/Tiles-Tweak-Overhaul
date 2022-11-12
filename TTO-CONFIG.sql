/* Thanks for downloading Tiles Tweak Overhaul mod! \(^_^)/
--==================================================================================================================
--==================================================================================================================
--
--  Tiles Tweak Overhaul for VP
--  By: N.Core
--  Thanks to:
--  - Bloublou, for their "Terrain - Poor Tiles Tweak" mod. This mod basically made me started this mod.
--  - Tofusojo, for their "Coasts and Rivers Yield Gold Again", "Water Tiles Enhanced", and "Improvements in Water Tiles" mod.
--  - Kevin Fitzgerald, for his "Workable Mountains" mod.
--
--  Some of those mods are already incorporated into this mod in some kind.
--  Thus, those mods are not allowed to be activated alongside this mod since it will cause conflicts.
--
--==================================================================================================================
--==================================================================================================================

What's this mod do exacly?
This mod changes yield system entirely!

Aim of this mod is to make all tiles useable and their yield quantities are balanced.
This mod is not meant for gameplay balancing or realism, but rather to eliminate unlucky starts by making all tile yields have the same number of total yield.

All tiles are now usable and each of them start at 3 different base yield and varied to every possible placement.
Example: hill, river, coastal, and features (forest, jungle, marsh, etc.) changes yield of a tile. When combined, it will create different yields, and it increases as you advanced through technologies.
Impassables such as ice and mountain tiles are also workable by the city.

==================== TTO OPTIONS ====================
These options are set to the default values for this mod.
Almost all features in this mod can be configured.
If there is a feature you don't like, just disable it.

BUT, BEWARE! Some features are correlated with each other.
So if you disable it, some features that are correlated will also be disabled.

 -- OPTIONS --
 -- Read each of the feature description, so you know what that feature does.
 -- By default, almost all options are enabled, and some mod features will be disabled if you disable other features that correlated with.
 -- Set value to 0 if you want to disable a mod feature.
 -- Set value to 1 if you want to force enable some mod features.
    Expect unbalanced yields will appear if you set to this value.
    (NOT RECOMMENDED to some mod features, as they are built correlated with other features.)
 -- Set value to 2 (if applicable) and the mod feature will be automatically activated if condition(s) are met.
*/


--==================================================================================================================
-- TILE TWEAKS
--==================================================================================================================

/*
========== Terrain Tweaks ==========
Description:
  - A main switch for this mod. If disabled, it will disable most of the mod features.
  - Change terrains and Flood Plains yields completely.
  - Also adjust some of the improvements to make them buildable on some terrains.

0 = Disable. Basically defeats the entire purpose of this mod, and auto disable most of the mod features.
1 = Enable. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_TERRAINS', 1);

/*
========== Feature Tweaks ==========
Description:
  - Change some feature (forest, jungle, marsh, etc.) yields completely.

0 = Disable. Auto disable some of Feature related mod.
1 = Force Enable.
2 = Enable. But disabled if TTO_TERRAINS is also disabled. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_FEATURES', 2);

/*
========== Mountain Tweak ==========
Description:
  - Turn Mountain into workable tiles by giving yields to Mountain.

0 = Disable.
1 = Force Enable.
2 = Enable. But disabled if TTO_TERRAINS is also disabled. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_MOUNTAIN', 2);

/*
========== Ice Tweak ==========
Description:
  - Turn Ice into workable tiles and give yields to Ice.

0 = Disable.
1 = Force Enable.
2 = Enable. But disabled if TTO_TERRAINS is also disabled. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_ICE', 2);

/*
========== Fallout Tweak ==========
Description:
  - Make Fallout harsher by eliminating any yields on a tile.
    No, it does not make the tile has negative yields because in a way that this mod do is just put high negative yield on a tile.

0 = Disable.
1 = Enable. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_FALLOUT', 1);

/*
========== Terrain - Condition Tweaks ==========
Description:
  - Coastal and River tile changes yield of a terrain.

0 = Disable.
1 = Force Enable.
2 = Enable. But disabled if TTO_TERRAINS is also disabled. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_TR_CT', 2);

/*
========== Feature - Condition Tweaks ==========
Description:
  - Coastal tile changes Marsh and Flood Plains yield.

0 = Disable.
1 = Force Enable.
2 = Enable. But disabled if TTO_FEATURES is also disabled. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_FR_CT', 2);

/*
========== Mountain - Condition Tweak ==========
Description:
  - Coastal and river tile changes Mountain yield.

0 = Disable.
1 = Force Enable.
2 = Enable. But disabled if TTO_MOUNTAIN is disabled. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_MT_CT', 2);

/*
========== Terrain - Yield Enhancements (EXPERIMENTAL) ==========
Description:
  - Enhance terrains and Flood Plains yields by researching technologies.
    Definitely will change the gameplay significantly.

0 = Disable. Auto disable some of the yield enhancements related mod.
1 = Force Enable.
2 = Enable. But disabled if TTO_TERRAINS is disabled. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_TR_YIELD', 0);

/*
========== Feature - Yield Enhancements (EXPERIMENTAL) ==========
Description:
  - Enhance features yields by researching technologies and constructing buildings.
    Definitely will change the gameplay significantly.

0 = Disable.
1 = Force Enable.
2 = Enable. But disabled if TTO_FEATURES and TTO_TR_YIELD is disabled. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_FR_YIELD', 2);

/*
========== Mountain - Yield Enhancements (EXPERIMENTAL) ==========
Description:
  - Enhance Mountain yields by researching technologies.

0 = Disable.
1 = Force Enable.
2 = Enable. But disabled if TTO_MOUNTAIN and TTO_TR_YIELD is disabled. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_MT_YIELD', 2);

/*
========== Ice - Yield Enhancements (EXPERIMENTAL) ==========
Description:
  - Enhance Ice yields by researching technologies.

0 = Disable.
1 = Force Enable.
2 = Enable. But disabled if TTO_ICE and TTO_TR_YIELD is disabled. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_ICE_YIELD', 2);

/*
========== Feature - Terrain Boolean ==========
Description:
  - Make some features like Marsh and Oasis be able to be generated on other terrains.
    Example: Marshes on Plains and Tundra tiles, and Oases on Grassland and Plains tiles.

0 = Disable. (Default)
1 = Enable.
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_FR_BOOL', 1);

/*
========== Feature - Jungle on Grassland ==========
Description:
  - By default, Jungle always appears on Plains and override any terrains below it to Plains.

0 = Use default; Jungle always appears on Plains. (Default)
1 = Randomize terrain override; Jungle can appear on Grassland, but rare, because there is a 20% chance that Jungle will override terrains to Plains.
2 = Disable terrain override; So Jungle that appears on Grassland will keep the terrain.
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_JUNGLE_BOOL', 0);

/*
========== Terrain - Tundra/Snow River Terrain Change ==========
Description:
  - By default, Tundra river tile will turned into Plains and Snow river will turned into Tundra.
  - You can change it by changing this value.

0 = Use default; Tundra river turned into Plains river, and Snow river turned into Tundra river. (Default)
1 = Randomize; Tundra river occasionally turned into Plains river, and Snow river occasionally turned into Tundra river.
2 = Disable terrain change; Tundra river and Snow river will keep its terrain.
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_ARCTIC_RIVER', 0);

/*
========== Flood Plains - Terrain Boolean ==========
Description:
  - By Default, if you add Flood Plains on Feature_TerrainBooleans table to a terrain, that river terrain will be overridden by Flood Plains.
    This mod already fixed that by modifying the FeatureGenerator.lua file to have a better implementation,
    so it only forcing Desert river to have Flood Plains.

  - So now it is possible to make Flood Plains be able to occasionally generated on other terrains. Like, Grassland, Plains, and Tundra.
  - You can also choose to not forcing Desert river to always have Flood Plains.

0 = Disable. (Default)
1 = Enable.
2 = Enable, but also not forcing Desert river to always have Flood Plains.
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_FP_BOOL', 0);

--==================================================================================================================
-- RESOURCE TWEAKS
--==================================================================================================================

/*
========== Resource - Yield Tweaks (EXPERIMENTAL) ==========
Description:
  - Adjust some of resources, so the total yield matches with other resources when combined with improvement and building.
  - Must be activated alongside the TTO_IMPROVEMENTS mod to make it balanced.

NOTE: This only affects base yields with also accounting additional yield from social policies, but not from ideology policies. Some fine-tuning adjustments still needed.

0 = Disable. (Default)
1 = Force Enable.
2 = Enable. But will be disabled if TTO_IMPROVEMENTS is also disabled.
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_RESOURCES', 0);

/*
========== Strategic Resources Tweak ==========
Description:
  - Some fun specific building changes the yield on strategic resources.

    Airport       = 1 Gold and -1 Production on Oil (Oil turned into a fuel for airplanes.)
    Hydro Plant   = 1 Gold and -1 Production on Iron (Power turned into income.)
    Nuclear Plant = 1 Gold and -1 Science on Uranium (Power turned into income.)
    Solar Plant   = 1 Gold and -1 Production on Aluminum (Power turned into income.)
    Wind Plant    = 1 Gold and -1 Production on Coal (Sell the coals?)

0 = Disable. (Default)
1 = Force Enable.
2 = Enable. But will be disabled if TTO_RESOURCES is also disabled.
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_STRATEGICRES', 0);

/*
========== Resource - Boolean ==========
Description:
  - Adjust some of resources terrain and feature booleans.
    Try to mix with "Improvements - Build Features Tweak" for more vary yields.

0 = Disable. (Default)
1 = Enable.
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_RES_BOOL', 0);

--==================================================================================================================
-- IMPROVEMENT MODS & TWEAKS
--==================================================================================================================

/*
========== Improvement - Mining Platform ==========
Description:
  - Add a Mine equivalent improvement on water tile:
    Mining Platform.

    Available on TECH_REFRIGERATION.
    +1 Producton and +1 Science.
    Buildable on water and using Work Boats.

    +1 Production with TECH_ELECTRONICS and +1 Science with TECH_ROBOTICS.
    
    Can also improves Salt Lake resource from "Better Lakes for VP" by InkAxis if you also play with that mod.
    But that will make Workers also can build the improvement on water tiles.
    Also the unit is not deleted when built.
  
0 = Disable.
1 = Enable. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_MININGPLATFORM', 1);

/*
========== Improvement - Fishing Boats Tweak ==========
Description:
  - Make Fishing Boats buildable on any water tiles, not just resources only.
    So it makes empty water tiles somewhat useful at least.
  - Adjust the yield to more varied yield type.
  - Make Workboat cheaper (but not overpowering them) since they only one-time use unit.
  - Warning, it'll make huge buff to any kind of traits that boosts Fishing Boats (civ traits, beliefs, policies, etc.) But I ain't touching that.
  
0 = Disable. (Default)
1 = Enable.
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_FISHINGMOD', 0);

/*
========== Improvement - Yield Changes (EXPERIMENTAL) ==========
Description:
  - Adjust some of the improvements yield changes to make them more balanced with other improvements,
    and when combined with resource and building.
  - Must be activated alongside the TTO_RESOURCES mod to make it balanced.

0 = Disable.
1 = Force Enable.
2 = Enable. But will be disabled if TTO_RESOURCES is also disabled. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_IMPROVEMENTS', 2);

/*
========== Improvement - Valid Builds ==========
Description:
  - Make some improvements buildable on some terrains that was previously not possible before.

0 = Disable. (Default)
1 = Force Enable.
2 = Enable. But will be disabled if neither of TTO_TERRAIN and TTO_FEATURES is also disabled.
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_VALIDBUILDS', 0);

/*
========== Improvement - Build Features Tweaks ==========
Description:
  - Make improvements keep the removable features (Forest, Jungle, Marsh).
    Except for Farm, Mine, Moai, Pasture, Polder, Quarry, and Terrace Farm.
  - Make Farm, Moai, Pasture, and Quarry keep the Marsh feature.

0 = Disable. (Default)
1 = Force Enable.
2 = Enable. But will be disabled if neither of TTO_TERRAIN and TTO_FEATURES is also disabled.
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_BUILDFEATURES', 0);

--==================================================================================================================
-- BUILDING MODS & TWEAKS
--==================================================================================================================

/*
========== Building - Aquamining Network ==========
Description:
  - Add a building:
    Aquamining Network.

    Available on TECH_ROBOTICS.
    Requires 2 Aluminum and 8 Gold for maintenance.
    +1 Production from sea tiles.
    Additional +4 Production from sea tiles that do not have a sea resource.

    +1 Production and +1 Science from Mining Platform improvement. (If you enabled the mod feature.)

0 = Disable.
1 = Enable. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_AQUAMINING', 1);

/*
========== Building - Mountain Yield Enhancements ==========
Description:
  - Make some buildings add yields to Mountain tile.
    Acting like Mountains is improved by buildings.

    Yield of the mountain is not added (I tried but the function apparently didn't work.)
    Instead, the yield is added to the city that owns the mountain tile.

    Aqueduct adds +1 Food to the city,
    Broadcast Tower adds +2 Culture and +1 Science to the city, and
    Strategic Defense System (formerly Bomb Shelter) add +1 Culture Local and +2 Production to the city.

0 = Disable. (Default)
1 = Force Enable.
2 = Enable. But will be disabled if TTO_MOUNTAIN is also disabled.
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_BLD_MT', 0);

--==================================================================================================================
-- GAMEPLAY BALANCING
--==================================================================================================================

/*
========== Game Speeds Balancing ==========
Description:
  - Balancing the gameplay by adjusting some GameSpeeds values.
    Rather than rebalancing every single entity, this is way more efficient (and time-saving) method.
  - There are 2 types of balance, With and Without Tiles Yield Enhancements.
    The code will automatically detects if Terrain - Yield Enhancements is enabled or not.

0 = Disable.
1 = Force Enable.
2 = Enable. But will be disabled if TTO_TERRAINS and TTO_FEATURES is also disabled. (Default)
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_BALANCING', 2);

/*
========== Trait - Polynesia's Wayfinding Tweak ==========
Description:
  - Some adjustment for Polynesia's Wayfinding trait so it affects most water improvements (including one that added by this mod).
  - Other mods such as Pontoon Bridge, Lake Fishing Boats (Better Lakes for VP) also applied if exists.
  - Yep, this makes them seemed an overpowered maritime civ. So use it if you want to have fun playing this civ.

0 = Disable. (Default)
1 = Enable.
*/

INSERT INTO COMMUNITY (Type, Value)
VALUES ('TTO_WAYFINDING', 0);

--==================================================================================================================
-- MOD SETUP (DO NOT CHANGE ANY VALUE!)
--==================================================================================================================

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_FEATURES'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_TERRAINS', 'TTO_FEATURES') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_MOUNTAIN'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_TERRAINS', 'TTO_MOUNTAIN') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_ICE'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_TERRAINS', 'TTO_ICE') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_TR_CT'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_TERRAINS', 'TTO_TR_CT') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_FR_CT'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_TERRAINS', 'TTO_FR_CT') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_MT_CT'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_MOUNTAIN', 'TTO_MT_CT') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_TR_YIELD'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_TERRAINS', 'TTO_TR_YIELD') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_FR_YIELD'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_FEATURES', 'TTO_TR_YIELD', 'TTO_FR_YIELD') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_MT_YIELD'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_MOUNTAIN', 'TTO_TR_YIELD', 'TTO_MT_YIELD') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_ICE_YIELD'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_ICE', 'TTO_TR_YIELD', 'TTO_ICE_YIELD') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_RESOURCES'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_IMPROVEMENTS', 'TTO_RESOURCES') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_STRATEGICRES'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'TTO_STRATEGICRES') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_IMPROVEMENTS'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'TTO_IMPROVEMENTS') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_VALIDBUILDS'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_TERRAIN', 'TTO_FEATURES', 'TTO_VALIDBUILDS') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_BUILDFEATURES'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_TERRAIN', 'TTO_FEATURES', 'TTO_BUILDFEATURES') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_BLD_MT'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN('TTO_MOUNTAIN', 'TTO_BLD_MT') AND Value = 0);

UPDATE COMMUNITY
SET Value = 1
WHERE Type = 'TTO_BALANCING'
AND NOT EXISTS (SELECT * FROM COMMUNITY WHERE Type IN('TTO_TERRAIN', 'TTO_FEATURES', 'TTO_BALANCING') AND Value = 0);