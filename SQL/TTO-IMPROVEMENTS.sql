--==================================================================================================================
--==================================================================================================================
--  IMPROVEMENTS TWEAK
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
-- Make new improvement, Mining Platform to fill the water tiles.
-- A Mine equivalent improvement on water tiles, even though it comes on later era.
--==================================================================================================================

-- Improvements
INSERT  INTO Improvements (Type, Water, PillageGold, DestroyedWhenPillaged, PortraitIndex, IconAtlas, ArtDefineTag, Description, Civilopedia)
SELECT  'IMPROVEMENT_MINING_PLATFORM',
        1,
        20,
        1,
        27,
        'TERRAIN_ATLAS',
        'ART_DEF_IMPROVEMENT_OFFSHORE_PLATFORM',
        'TXT_KEY_IMPROVEMENT_MINING_PLATFORM',
        'TXT_KEY_CIV5_IMPROVEMENTS_MINING_PLATFORM_TEXT'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1);

-- Improvement_Yields
INSERT  INTO Improvement_Yields (ImprovementType, YieldType, Yield)
SELECT  'IMPROVEMENT_MINING_PLATFORM', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1)
        AND Type IN ('YIELD_PRODUCTION', 'YIELD_SCIENCE');

-- Improvement_TechYieldChanges
INSERT INTO Improvement_TechYieldChanges (ImprovementType, TechType, YieldType, Yield)
SELECT  'IMPROVEMENT_MINING_PLATFORM', 'TECH_ELECTRONICS', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1) UNION ALL
SELECT  'IMPROVEMENT_MINING_PLATFORM', 'TECH_ROBOTICS', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1);

-- Improvement_ValidTerrains
INSERT  INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
SELECT  'IMPROVEMENT_MINING_PLATFORM', Type FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1) 
        AND Type IN ('TERRAIN_COAST', 'TERRAIN_OCEAN');

-- Improvement_ValidFeatures
INSERT  INTO Improvement_ValidFeatures (ImprovementType, FeatureType)
SELECT  'IMPROVEMENT_MINING_PLATFORM', 'FEATURE_ICE'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1);

UPDATE  Features SET NoImprovement = 0
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1)
        AND Type = 'FEATURE_ICE';

-- Builds
INSERT  INTO Builds (Type, PrereqTech, ImprovementType, Kill, Water, CanBeEmbarked, EntityEvent, HotKey, OrderPriority, IconIndex, IconAtlas, Description)
SELECT  'BUILD_MINING_PLATFORM',
        'TECH_REFRIGERATION',
        'IMPROVEMENT_MINING_PLATFORM',
        0,
        1,
        1,
        'ENTITY_EVENT_BUILD',
        'KB_O',
        98,
        34,
        'UNIT_ACTION_ATLAS',
        'TXT_KEY_BUILD_MINING_PLATFORM'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1);

-- Unit_Builds
INSERT  INTO Unit_Builds (UnitType, BuildType)
SELECT  'UNIT_WORKER', 'BUILD_MINING_PLATFORM'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1);

-- Improvement_AdjacentImprovementYieldChanges
INSERT  INTO Improvement_AdjacentImprovementYieldChanges (ImprovementType, OtherImprovementType, YieldType, Yield)
SELECT  'IMPROVEMENT_KASBAH', Type, 'YIELD_GOLD', 2 FROM Improvements
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1)
        AND Type IN ('IMPROVEMENT_MINING_PLATFORM', 'IMPROVEMENT_OFFSHORE_PLATFORM') UNION ALL
SELECT  'IMPROVEMENT_FEITORIA', Type, 'YIELD_GOLD', 1 FROM Improvements
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1)
        AND Type IN ('IMPROVEMENT_MINING_PLATFORM', 'IMPROVEMENT_OFFSHORE_PLATFORM');

-- Text
INSERT OR REPLACE INTO Language_en_US (Tag, Text)
SELECT  'TXT_KEY_IMPROVEMENT_MINING_PLATFORM', 'Mining Platform'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1) UNION ALL
SELECT  'TXT_KEY_BUILD_MINING_PLATFORM', 'Create Mining Platform'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1) UNION ALL
SELECT  'TXT_KEY_CIV5_IMPROVEMENTS_MINING_PLATFORM_TEXT', 'The mining platform is an important late-game improvement as it provides access to the vast mineral wealth of the sea depths. It is a control station and cargo transfer point for an underwater mine deep beneath it.'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1);

-- Building_ImprovementYieldChangesGlobal
INSERT  INTO Building_ImprovementYieldChangesGlobal (BuildingType, ImprovementType, YieldType, Yield)
SELECT  'BUILDING_RUHR_VALLEY', 'IMPROVEMENT_MINING_PLATFORM', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_RUHR_VALLEY');

-- EventChoice_ImprovementYieldChange
INSERT  INTO EventChoice_ImprovementYieldChange (EventChoiceType, ImprovementType, YieldType, YieldChange)
SELECT  'PLAYER_EVENT_CHOICE_MINOR_CIV_BYBLOS', 'IMPROVEMENT_MINING_PLATFORM', 'YIELD_FOOD', '1'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1)
        AND EXISTS (SELECT * FROM EventChoices WHERE Type = 'PLAYER_EVENT_CHOICE_MINOR_CIV_BYBLOS');

--==================================================================================================================
-- Make Fishing Boats buildable on any water tiles, not just resources only.
-- Other resources still got their previous yield, but not Food generated by the Fishing Boats.
--==================================================================================================================

-- Improvement_Yields
INSERT  INTO Improvement_Yields (ImprovementType, YieldType, Yield)
SELECT  'IMPROVEMENT_FISHING_BOATS', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FISHINGMOD' AND Value = 1);

-- Improvement_ResourceType_Yields
INSERT  INTO Improvement_ResourceType_Yields (ImprovementType, ResourceType, YieldType, Yield)
SELECT	'IMPROVEMENT_FISHING_BOATS', Type, 'YIELD_FOOD', -1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FISHINGMOD' AND Value = 1)
        AND Type IN ('RESOURCE_FISH', 'RESOURCE_PEARLS', 'RESOURCE_WHALE');

DELETE  FROM Improvement_ResourceType_Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FISHINGMOD' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_FISHING_BOATS'
        AND ResourceType = 'RESOURCE_CRAB'
        AND YieldType = 'YIELD_FOOD';

-- Improvement_ValidTerrains
INSERT  INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
SELECT  'IMPROVEMENT_FISHING_BOATS', Type FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FISHINGMOD' AND Value = 1) 
        AND Type IN ('TERRAIN_COAST', 'TERRAIN_OCEAN');

-- Improvement_ValidFeatures
DELETE  FROM Improvement_ValidFeatures
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FISHINGMOD' AND Value = 1) 
        AND ImprovementType = 'IMPROVEMENT_FISHING_BOATS';

-- Improvement_TechYieldChanges
INSERT  INTO Improvement_TechYieldChanges (ImprovementType, TechType, YieldType, Yield)
SELECT  'IMPROVEMENT_FISHING_BOATS', 'TECH_ROBOTICS', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FISHINGMOD' AND Value = 1);

UPDATE  Improvement_TechYieldChanges SET YieldType = 'YIELD_PRODUCTION'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FISHINGMOD' AND Value = 1) 
        AND ImprovementType = 'IMPROVEMENT_FISHING_BOATS'
        AND TechType = 'TECH_NAVIGATION';

UPDATE  Improvement_TechYieldChanges SET Yield = 1, YieldType = 'YIELD_GOLD'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FISHINGMOD' AND Value = 1) 
        AND ImprovementType = 'IMPROVEMENT_FISHING_BOATS'
        AND TechType = 'TECH_REFRIGERATION';
/*
DELETE  FROM Improvement_TechYieldChanges
        WHERE ImprovementType = 'IMPROVEMENT_FISHING_BOATS'
        AND TechType = 'TECH_COMPASS';
*/
-- Units
-- Make Workboat cheaper (but not overpowering them) since they only one-time use unit.
UPDATE  Units SET Cost = 20
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FISHINGMOD' AND Value = 1)
        AND Type = 'UNIT_WORKBOAT';

--==================================================================================================================
-- Improvements - Yield Changes
--==================================================================================================================

-- Improvement_Yields
UPDATE  Improvement_Yields SET Yield = 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1) 
        AND ImprovementType = 'IMPROVEMENT_BRAZILWOOD_CAMP' 
        AND  YieldType = 'YIELD_GOLD';

UPDATE  Improvement_Yields SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1) 
        AND ImprovementType = 'IMPROVEMENT_TERRACE_FARM' 
        AND  YieldType = 'YIELD_PRODUCTION';

-- Improvement_TechYieldChanges
INSERT  INTO Improvement_TechYieldChanges (ImprovementType, TechType, YieldType, Yield)
SELECT  'IMPROVEMENT_BRAZILWOOD_CAMP', 'TECH_FLIGHT', 'YIELD_TOURISM', 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1) UNION ALL

SELECT  'IMPROVEMENT_CAMP', 'TECH_ROBOTICS', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1) UNION ALL

SELECT  'IMPROVEMENT_LUMBERMILL', Type, 'YIELD_GOLD', 1 FROM Technologies
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND Type IN ('TECH_INDUSTRIALIZATION', 'TECH_ROBOTICS') UNION ALL
        
SELECT  'IMPROVEMENT_LUMBERMILL_JUNGLE', Type, 'YIELD_PRODUCTION', 1 FROM Technologies
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND Type IN ('TECH_INDUSTRIALIZATION', 'TECH_ROBOTICS') UNION ALL

SELECT  Type, 'TECH_ROBOTICS', 'YIELD_SCIENCE', 1 FROM Improvements
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND Type IN ('IMPROVEMENT_LUMBERMILL', 'IMPROVEMENT_LUMBERMILL_JUNGLE') UNION ALL

SELECT  'IMPROVEMENT_MINE', 'TECH_INDUSTRIALIZATION', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1) UNION ALL
SELECT  'IMPROVEMENT_MINE', 'TECH_ROBOTICS', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1) UNION ALL

SELECT  'IMPROVEMENT_MOAI', 'TECH_GLOBALIZATION', 'YIELD_TOURISM', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1) UNION ALL

SELECT  'IMPROVEMENT_PLANTATION', 'TECH_ROBOTICS', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1) UNION ALL

SELECT  'IMPROVEMENT_TRADING_POST', 'TECH_CORPORATIONS', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND Type IN ('YIELD_GOLD', 'YIELD_PRODUCTION') UNION ALL

SELECT  'IMPROVEMENT_QUARRY', 'TECH_INDUSTRIALIZATION', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1) UNION ALL
SELECT  'IMPROVEMENT_QUARRY', 'TECH_ADVANCED_BALLISTICS', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1);

UPDATE  Improvement_TechYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_FARM' 
        AND TechType = 'TECH_ROBOTICS';

UPDATE  Improvement_TechYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_TERRACE_FARM' 
        AND TechType = 'TECH_ROBOTICS';
/*
UPDATE  Improvement_TechYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_MINE' 
        AND TechType = 'TECH_ROBOTICS';
*/
UPDATE  Improvement_TechYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_MINE' 
        AND TechType = 'TECH_STEAM_POWER';

UPDATE  Improvement_TechYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_PASTURE' 
        AND TechType = 'TECH_CIVIL_SERVICE';

UPDATE  Improvement_TechYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_PASTURE' 
        AND TechType = 'TECH_FERTILIZER';

UPDATE  Improvement_TechYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_PASTURE' 
        AND TechType = 'TECH_ROBOTICS';

UPDATE  Improvement_TechYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_QUARRY' 
        AND TechType = 'TECH_DYNAMITE';

DELETE  FROM Improvement_TechYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_MINE' 
        AND TechType = 'TECH_ROBOTICS'
        AND YieldType = 'YIELD_PRODUCTION';

DELETE  FROM Improvement_TechYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_QUARRY' 
        AND TechType = 'TECH_STEAM_POWER';

-- Improvement_AdjacentFeatureYieldChanges
INSERT  INTO Improvement_AdjacentFeatureYieldChanges (ImprovementType, FeatureType, YieldType, Yield)
SELECT  'IMPROVEMENT_KASBAH', Type, 'YIELD_GOLD', 2 FROM Features
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND Type IN ('FEATURE_ATOLL', 'FEATURE_OASIS');

-- Building_ImprovementYieldChanges
INSERT  INTO Building_ImprovementYieldChanges (BuildingType, ImprovementType, YieldType, Yield)
SELECT	iyc.BuildingType, 'IMPROVEMENT_TERRACE_FARM', iyc.YieldType, iyc.Yield
        FROM Buildings b, Improvements i, Building_ImprovementYieldChanges iyc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND i.Type = 'IMPROVEMENT_FARM'
        AND iyc.ImprovementType = i.Type
        AND b.Type = iyc.BuildingType;

UPDATE  Building_ImprovementYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_PASTURE'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_STOCKYARD');

-- Compatibility
CREATE TRIGGER TTO_NEWBuildingIYC
AFTER INSERT ON Civilization_BuildingClassOverrides 
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
AND NEW.BuildingClassType
    IN(
    SELECT  DISTINCT b.BuildingClass
            FROM Buildings b, Improvements i, Building_ImprovementYieldChanges iyc
            WHERE i.Type IN ('IMPROVEMENT_TERRACE_FARM', 'IMPROVEMENT_FARM', 'IMPROVEMENT_PASTURE')
            AND iyc.ImprovementType = i.Type
            AND b.Type = iyc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
    INSERT  INTO Building_ImprovementYieldChanges (BuildingType, ImprovementType, YieldType, Yield)
    SELECT  DISTINCT NEW.BuildingType, 'IMPROVEMENT_TERRACE_FARM', iyc.YieldType, iyc.Yield
            FROM Improvements i, Building_ImprovementYieldChanges iyc, BuildingClasses bc
            WHERE i.Type = 'IMPROVEMENT_FARM'
            AND iyc.ImprovementType = i.Type
            AND bc.Type = NEW.BuildingClassType
            AND iyc.BuildingType = bc.DefaultBuilding;
            
    UPDATE  Building_ImprovementYieldChanges SET Yield = 1
            WHERE ImprovementType = 'IMPROVEMENT_PASTURE'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_STOCKYARD');
END;

--==================================================================================================================
-- Improvements - Valid Builds
--==================================================================================================================

-- Improvement_ValidTerrains
INSERT  INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
SELECT  'IMPROVEMENT_EKI', Type FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_VALIDBUILDS' AND Value = 1)
        AND Type IN ('TERRAIN_DESERT', 'TERRAIN_TUNDRA', 'TERRAIN_SNOW') UNION ALL
SELECT  'IMPROVEMENT_KUNA', Type FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_VALIDBUILDS' AND Value = 1)
        AND Type IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS', 'TERRAIN_DESERT', 'TERRAIN_TUNDRA', 'TERRAIN_SNOW');
/*
-- Improvement_ValidFeatures
INSERT  INTO Improvement_ValidFeatures (ImprovementType, FeatureType)
SELECT  i.Type, f.Type FROM Improvements i, Features f
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_VALIDBUILDS' AND Value = 1)
        AND i.Type IN('IMPROVEMENT_EKI', 'IMPROVEMENT_KASBAH')
        AND f.Type IN('FEATURE_FOREST', 'FEATURE_JUNGLE', 'FEATURE_MARSH') UNION ALL
SELECT  'IMPROVEMENT_KUNA', 'FEATURE_MARSH'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_VALIDBUILDS' AND Value = 1);
*/

--==================================================================================================================
-- Improvements - Build Features Tweak
--==================================================================================================================

-- BuildFeatures (To make improvements keep the features)
INSERT  INTO BuildFeatures (BuildType, FeatureType, PrereqTech, Time, Remove)
SELECT	'BUILD_KASBAH', 'FEATURE_FOREST', 'TECH_CALENDAR', 500, 0
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BUILDFEATURES' AND Value = 1) UNION ALL
SELECT	'BUILD_KASBAH', 'FEATURE_JUNGLE', 'TECH_MINING', 400, 0
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BUILDFEATURES' AND Value = 1) UNION ALL
SELECT	'BUILD_KASBAH', 'FEATURE_MARSH', 'TECH_IRON_WORKING', 600, 0
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BUILDFEATURES' AND Value = 1);

UPDATE  BuildFeatures SET Remove = 0
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BUILDFEATURES' AND Value = 1)
        AND FeatureType IN ('FEATURE_FOREST', 'FEATURE_JUNGLE', 'FEATURE_MARSH')
        /* AND BuildType NOT IN ('BUILD_FARM', 'BUILD_MINE', 'BUILD_MOAI', 'BUILD_PASTURE', 'BUILD_POLDER', 'BUILD_QUARRY', 'BUILD_REMOVE_FOREST', 'BUILD_REMOVE_JUNGLE', 'BUILD_REMOVE_MARSH', 'BUILD_TERRACE_FARM'); */
        AND BuildType NOT IN ('BUILD_MOAI',  'BUILD_REMOVE_FOREST', 'BUILD_REMOVE_JUNGLE', 'BUILD_REMOVE_MARSH');

UPDATE  BuildFeatures SET Remove = 0
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BUILDFEATURES' AND Value = 1)
        AND FeatureType IN ('FEATURE_MARSH')
        AND BuildType IN ('BUILD_FARM', 'BUILD_MINE', 'BUILD_MOAI', 'BUILD_PASTURE', 'BUILD_QUARRY');

UPDATE  BuildFeatures SET Remove = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BUILDFEATURES' AND Value = 1)
        AND EXISTS (SELECT * FROM Builds WHERE BuildType = 'BUILD_FOREST')
        AND BuildType = 'BUILD_FOREST';

--==================================================================================================================
-- If Unique City-States mod exists
--==================================================================================================================

-- Improvement_ValidFeatures
INSERT  INTO Improvement_ValidFeatures (ImprovementType, FeatureType)
SELECT  'IMPROVEMENT_MOUND', Type FROM Features
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_VALIDBUILDS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_MOUND')
        AND Type IN ('FEATURE_FOREST', 'FEATURE_JUNGLE', 'FEATURE_MARSH');

-- Improvement_TechYieldChanges
INSERT  INTO Improvement_TechYieldChanges (ImprovementType, TechType, YieldType, Yield)
SELECT  'IMPROVEMENT_MOUND', 'TECH_CHIVALRY', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_MOUND') UNION ALL
SELECT  'IMPROVEMENT_MOUND', 'TECH_CHIVALRY', 'YIELD_CULTURE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_MOUND') UNION ALL
SELECT  'IMPROVEMENT_MOUND', 'TECH_REPLACEABLE_PARTS', 'YIELD_PRODUCTION', 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_MOUND') UNION ALL
SELECT  'IMPROVEMENT_MOUND', 'TECH_MOBILE_TACTICS', 'YIELD_CULTURE_LOCAL', 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_MOUND');

-- BuildFeatures
UPDATE  BuildFeatures SET Remove = 0
        WHERE EXISTS (SELECT * FROM Builds WHERE BuildType = 'BUILD_MOUND')
        AND BuildType = 'BUILD_MOUND'
        AND FeatureType IN ('FEATURE_FOREST', 'FEATURE_JUNGLE', 'FEATURE_MARSH');

UPDATE  BuildFeatures SET Remove = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BUILDFEATURES' AND Value = 1)
        AND EXISTS (SELECT * FROM Builds WHERE BuildType = 'BUILD_MARSH')
        AND BuildType = 'BUILD_MARSH';

-- ICON FIX
INSERT  INTO IconTextureAtlases	(Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn)
SELECT  'UNIT_ACTION_DLC04_ATLAS', 045, 'UnitAction45_DLC_Denmark.dds', '1', '1'
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_MOUND') UNION ALL
SELECT  'UNIT_ACTION_DLC04_ATLAS', 064, 'UnitAction64_DLC_Denmark.dds', '1', '1'
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_MOUND') UNION ALL
SELECT  'UNIT_ACTION_DLC04_GOLD_ATLAS', 045, 'UnitActionGold45_DLC_Denmark.dds', '1', '1'
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_MOUND') UNION ALL
SELECT  'UNIT_ACTION_DLC04_GOLD_ATLAS', 064, 'UnitActionGold64_DLC_Denmark.dds', '1', '1'
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_MOUND') UNION ALL
SELECT  'DENMARK_TERRAIN_ATLAS', 256, 'TerrainIcons256_DLC_Denmark.dds', '2', '1'
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_MOUND') UNION ALL
SELECT  'DENMARK_TERRAIN_ATLAS', 064, 'TerrainIcons64_DLC_Denmark.dds', '2', '1'
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_MOUND');

UPDATE Improvements SET PortraitIndex = 1, IconAtlas = 'DENMARK_TERRAIN_ATLAS' WHERE Type = 'IMPROVEMENT_MOUND' AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_MOUND');
UPDATE Builds SET IconIndex = 0, IconAtlas = 'UNIT_ACTION_DLC04_ATLAS' WHERE Type = 'BUILD_MOUND' AND EXISTS (SELECT * FROM Builds WHERE Type = 'BUILD_MOUND');
