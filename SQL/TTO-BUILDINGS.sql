--==================================================================================================================
--==================================================================================================================
--  BUILDING MOD AND TWEAKS
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
-- Building - Aquamining Network
--==================================================================================================================

-- BuildingClasses
INSERT INTO BuildingClasses (Type, DefaultBuilding, Description)
SELECT	'BUILDINGCLASS_OCEAN_MINING', 'BUILDING_OCEAN_MINING', 'TXT_KEY_BUILDING_OCEAN_MINING'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1);

-- Buildings
INSERT INTO Buildings (Type, BuildingClass, Cost, Water, MinAreaSize, GoldMaintenance, PrereqTech, ConquestProb, HurryCostModifier, ArtDefineTag, IconAtlas, PortraitIndex, Description, Help, Civilopedia, Strategy)
SELECT	'BUILDING_OCEAN_MINING',
        'BUILDINGCLASS_OCEAN_MINING',
        2500,
        1,
        10,
        10,
        'TECH_ROBOTICS',
        80,
        25,
        'ART_DEF_BUILDING_SEAPORT',
        'WTEMOD_ICON_ATLAS',
        0,
        'TXT_KEY_BUILDING_OCEAN_MINING',
        'TXT_KEY_BUILDING_OCEAN_MINING_HELP',
        'TXT_KEY_CIV5_BUILDINGS_OCEAN_MINING_TEXT',
        'TXT_KEY_BUILDING_OCEAN_MINING_STRATEGY'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1);

-- Building_ResourceQuantityRequirements
INSERT  INTO Building_ResourceQuantityRequirements (BuildingType, ResourceType, Cost)
SELECT	'BUILDING_OCEAN_MINING', 'RESOURCE_ALUMINUM', 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1);

-- Building_SeaPlotYieldChanges
INSERT  INTO Building_SeaPlotYieldChanges (BuildingType, YieldType, Yield)
SELECT	'BUILDING_OCEAN_MINING', 'YIELD_PRODUCTION', 5
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1);

-- Building_SeaResourceYieldChanges
INSERT  INTO Building_SeaResourceYieldChanges (BuildingType, YieldType, Yield)
SELECT	'BUILDING_OCEAN_MINING', 'YIELD_PRODUCTION', -4
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1);

-- Building_FeatureYieldChanges
INSERT  INTO Building_FeatureYieldChanges (BuildingType, FeatureType, YieldType, Yield)
SELECT	'BUILDING_OCEAN_MINING', 'FEATURE_ATOLL', 'YIELD_PRODUCTION', -4
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1);
/*
-- Building_ImprovementYieldChanges
INSERT  INTO Building_ImprovementYieldChanges (BuildingType, ImprovementType, YieldType, Yield)
SELECT	'BUILDING_OCEAN_MINING', 'IMPROVEMENT_MINING_PLATFORM', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_AQUAMINING', 'TTO_MININGPLATFORM') AND Value = 1) UNION ALL
SELECT	'BUILDING_OCEAN_MINING', 'IMPROVEMENT_MINING_PLATFORM', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_AQUAMINING', 'TTO_MININGPLATFORM') AND Value = 1) UNION ALL
SELECT	'BUILDING_OCEAN_MINING', 'IMPROVEMENT_OFFSHORE_PLATFORM', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_AQUAMINING', 'TTO_MININGPLATFORM') AND Value = 1) UNION ALL
SELECT	'BUILDING_OCEAN_MINING', 'IMPROVEMENT_OFFSHORE_PLATFORM', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_AQUAMINING', 'TTO_MININGPLATFORM') AND Value = 1);
*/
-- Building_ImprovementYieldChanges
INSERT  INTO Building_ImprovementYieldChanges (BuildingType, ImprovementType, YieldType, Yield)
SELECT	'BUILDING_OCEAN_MINING', i.Type, y.Type, 1 FROM Improvements i, Yields y
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_AQUAMINING', 'TTO_MININGPLATFORM') AND Value = 1)
        AND i.Type IN ('IMPROVEMENT_MINING_PLATFORM', 'IMPROVEMENT_OFFSHORE_PLATFORM')
        AND y.Type IN ('YIELD_PRODUCTION', 'YIELD_SCIENCE');

-- Flavors
INSERT  INTO Building_Flavors (BuildingType, FlavorType, Flavor)
SELECT	'BUILDING_OCEAN_MINING', 'FLAVOR_PRODUCTION', 30
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1) UNION ALL
SELECT	'BUILDING_OCEAN_MINING', 'FLAVOR_SCIENCE', 10
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1);

-- Text
INSERT OR REPLACE INTO Language_en_US (Tag, Text)
SELECT	'TXT_KEY_BUILDING_OCEAN_MINING',
        'Aquamining Network'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1) UNION ALL

SELECT	'TXT_KEY_BUILDING_OCEAN_MINING_HELP',
        '+1 [ICON_PRODUCTION] Production from sea tiles.[NEWLINE]Additonal +4 [ICON_PRODUCTION] Production from sea tiles that does not have a sea Resource.[NEWLINE]Requires 2 [ICON_RES_ALUMINUM] Aluminum.[NEWLINE][NEWLINE]City must have sea tiles nearby.'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1) UNION ALL

SELECT	'TXT_KEY_BUILDING_OCEAN_MINING_STRATEGY',
        'Increases the [ICON_PRODUCTION] production from sea tiles and gives lots of [ICON_PRODUCTION] Production on sea tiles without a resource. 2 [ICON_RES_ALUMINUM] Aluminum is consumed when an Aquamining Network is created.'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1) UNION ALL

SELECT	'TXT_KEY_CIV5_BUILDINGS_OCEAN_MINING_TEXT',
        'An Aquamining Network is a network of underwater mines with a control center in the city. The actual mining is done by robots so as not to endanger human lives and to reduce costs, as no life support is needed and robots are less likely to have lawyers or form unions.'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1);

-- If IMPROVEMENT_MINING_PLATFORM mod feature is enabled
UPDATE  Language_en_US
        SET Text = Text || '[NEWLINE][NEWLINE]+1 [ICON_PRODUCTION] Production and +1 [ICON_RESEARCH] Science from Mining Platform and Offshore Platform.'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_AQUAMINING', 'TTO_MININGPLATFORM') AND Value = 1)
        AND Tag IN (SELECT Help FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_OCEAN_MINING' AND ((Type = 'BUILDING_OCEAN_MINING')));

UPDATE  Language_en_US
        SET Text = Text || '[NEWLINE][NEWLINE]Gives additional [ICON_PRODUCTION] Production and [ICON_RESEARCH] Science from Mining Platform and Offshore Platform.'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_AQUAMINING', 'TTO_MININGPLATFORM') AND Value = 1)
        AND Tag IN (SELECT Strategy FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_OCEAN_MINING' AND ((Type = 'BUILDING_OCEAN_MINING')));

--==================================================================================================================
-- Building - Mountain Yield Enhancements
--==================================================================================================================
/*
-- originally wanted to use this method, didn't work at all
-- Building_TerrainYieldChanges
INSERT  INTO Building_TerrainYieldChanges (BuildingType, TerrainType, YieldType, Yield)
SELECT	'BUILDING_AQUEDUCT', 'TERRAIN_MOUNTAIN', 'YIELD_FOOD', 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1) UNION ALL
SELECT	'BUILDING_OBSERVATORY', 'TERRAIN_MOUNTAIN', 'YIELD_SCIENCE', 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1) UNION ALL
SELECT	'BUILDING_BROADCAST_TOWER', 'TERRAIN_MOUNTAIN', 'YIELD_CULTURE', 4
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1) UNION ALL
SELECT	'BUILDING_BROADCAST_TOWER', 'TERRAIN_MOUNTAIN', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1) UNION ALL
SELECT	'BUILDING_BOMB_SHELTER', 'TERRAIN_MOUNTAIN', 'YIELD_CULTURE_LOCAL', 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1) UNION ALL
SELECT	'BUILDING_BOMB_SHELTER', 'TERRAIN_MOUNTAIN', 'YIELD_PRODUCTION', 4
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1);
*/
-- so, use this method instead
-- Building_YieldPerXTerrainTimes100
INSERT  INTO Building_YieldPerXTerrainTimes100 (BuildingType, TerrainType, YieldType, Yield)
SELECT	'BUILDING_AQUEDUCT', 'TERRAIN_MOUNTAIN', 'YIELD_FOOD', 200
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1) UNION ALL
SELECT	'BUILDING_BROADCAST_TOWER', 'TERRAIN_MOUNTAIN', 'YIELD_CULTURE', 400
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1) UNION ALL
SELECT	'BUILDING_BROADCAST_TOWER', 'TERRAIN_MOUNTAIN', 'YIELD_SCIENCE', 100
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1) UNION ALL
SELECT	'BUILDING_BOMB_SHELTER', 'TERRAIN_MOUNTAIN', 'YIELD_CULTURE_LOCAL', 200
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1) UNION ALL
SELECT	'BUILDING_BOMB_SHELTER', 'TERRAIN_MOUNTAIN', 'YIELD_PRODUCTION', 400
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1);
