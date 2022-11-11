--==================================================================================================================
--==================================================================================================================
--  TERRAIN AND FEATURE TWEAKS
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
-- Terrain Tweaks
--==================================================================================================================

-- Terrain_Yields
DELETE  FROM Terrain_Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) 
        AND TerrainType IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS', 'TERRAIN_TUNDRA', 'TERRAIN_COAST', 'TERRAIN_OCEAN');

INSERT  INTO Terrain_Yields (TerrainType, YieldType, Yield)
SELECT  'TERRAIN_GRASS', 'YIELD_FOOD', 2 
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL
SELECT  'TERRAIN_GRASS', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL

SELECT  'TERRAIN_PLAINS', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL
SELECT  'TERRAIN_PLAINS', 'YIELD_PRODUCTION', 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL

SELECT  t.Type, y.Type, 1 FROM Terrains t, Yields y
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1)
        AND t.Type IN ('TERRAIN_DESERT', 'TERRAIN_TUNDRA')
        AND y.Type IN ('YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_GOLD') UNION ALL

SELECT  'TERRAIN_SNOW', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1)
        AND Type IN ('YIELD_FOOD', 'YIELD_GOLD', 'YIELD_CULTURE_LOCAL') UNION ALL

SELECT  'TERRAIN_COAST', 'YIELD_FOOD', 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL
SELECT  'TERRAIN_COAST', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL

SELECT  'TERRAIN_OCEAN', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1)
        AND Type IN ('YIELD_FOOD', 'YIELD_GOLD');

-- Terrain_HillsYieldChanges
DELETE  FROM Terrain_HillsYieldChanges 
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) 
        AND TerrainType IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS', 'TERRAIN_DESERT', 'TERRAIN_TUNDRA');

INSERT  INTO Terrain_HillsYieldChanges (TerrainType, YieldType, Yield)
SELECT  Type, 'YIELD_FOOD', -1 FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1)
        AND Type IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS', 'TERRAIN_DESERT', 'TERRAIN_TUNDRA', 'TERRAIN_SNOW') UNION ALL
SELECT  Type, 'YIELD_PRODUCTION', 1 FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1)
        AND Type IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS', 'TERRAIN_DESERT', 'TERRAIN_TUNDRA', 'TERRAIN_SNOW');
/*
INSERT  INTO Terrain_HillsYieldChanges (TerrainType, YieldType, Yield)
SELECT  'TERRAIN_GRASS', 'YIELD_FOOD', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL
SELECT  'TERRAIN_GRASS', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL

SELECT  'TERRAIN_PLAINS', 'YIELD_FOOD', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL
SELECT  'TERRAIN_PLAINS', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL

SELECT  'TERRAIN_DESERT', 'YIELD_FOOD', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL
SELECT  'TERRAIN_DESERT', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL

SELECT  'TERRAIN_TUNDRA', 'YIELD_FOOD', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL
SELECT  'TERRAIN_TUNDRA', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL

SELECT  'TERRAIN_SNOW', 'YIELD_FOOD', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL
SELECT  'TERRAIN_SNOW', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1);
*/

-- Feature_YieldChanges
DELETE  FROM Feature_YieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1)
        AND FeatureType = 'FEATURE_FLOOD_PLAINS';

INSERT  INTO Feature_YieldChanges (FeatureType, YieldType, Yield)
SELECT  'FEATURE_FLOOD_PLAINS', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1) UNION ALL
SELECT  'FEATURE_FLOOD_PLAINS', 'YIELD_PRODUCTION', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1);

-- Improvement_ValidTerrains
INSERT  INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
SELECT  'IMPROVEMENT_FARM', Type FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1)
        AND Type IN('TERRAIN_DESERT', 'TERRAIN_TUNDRA') UNION ALL
SELECT  Type, 'TERRAIN_SNOW' FROM Improvements
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1)
        AND Type IN('IMPROVEMENT_BARBARIAN_CAMP','IMPROVEMENT_GOODY_HUT', 'IMPROVEMENT_MINE', 'IMPROVEMENT_TRADING_POST') UNION ALL
SELECT  'IMPROVEMENT_FORT', 'TERRAIN_HILL'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TERRAINS' AND Value = 1);
/*
-- Improvement_ValidFeatures
INSERT  INTO Improvement_ValidFeatures (ImprovementType, FeatureType)
SELECT  i.Type, f.Type FROM Improvements i, Features f
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FEATURES' AND Value = 1)
        AND i.Type IN('IMPROVEMENT_FORT', 'IMPROVEMENT_TRADING_POST')
        AND f.Type IN('FEATURE_FOREST', 'FEATURE_JUNGLE', 'FEATURE_MARSH');
*/

--==================================================================================================================
-- Feature Tweaks
--==================================================================================================================

-- Feature_YieldChanges
DELETE  FROM Feature_YieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FEATURES' AND Value = 1)
        AND FeatureType IN ('FEATURE_FOREST', 'FEATURE_JUNGLE', 'FEATURE_MARSH');

INSERT  INTO Feature_YieldChanges (FeatureType, YieldType, Yield)
SELECT  'FEATURE_FOREST', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FEATURES' AND Value = 1 )UNION ALL
SELECT  'FEATURE_FOREST', 'YIELD_FOOD', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FEATURES' AND Value = 1) UNION ALL

SELECT  'FEATURE_JUNGLE', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FEATURES' AND Value = 1) UNION ALL
SELECT  'FEATURE_JUNGLE', 'YIELD_PRODUCTION', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FEATURES' AND Value = 1) UNION ALL

SELECT  'FEATURE_MARSH', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FEATURES' AND Value = 1) UNION ALL
SELECT  'FEATURE_MARSH', 'YIELD_PRODUCTION', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FEATURES' AND Value = 1);

--==================================================================================================================
-- Mountain Tweaks
--==================================================================================================================

-- Terrain_Yields
INSERT  INTO Terrain_Yields (TerrainType, YieldType, Yield)
SELECT  'TERRAIN_MOUNTAIN', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MOUNTAIN' AND Value = 1)
        AND Type IN ('YIELD_FOOD', 'YIELD_PRODUCTION', 'YIELD_CULTURE_LOCAL');

--==================================================================================================================
-- Ice Tweaks
--==================================================================================================================

-- CustomModOptions
UPDATE  CustomModOptions SET Value = '1'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_ICE' AND Value = 1)
        AND Name = 'GLOBAL_NUKES_MELT_ICE';
UPDATE  CustomModOptions SET Value = '0'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_ICE' AND Value = 1)
        AND Name = 'NO_YIELD_ICE';

-- Feature_YieldChanges
INSERT  INTO Feature_YieldChanges (FeatureType, YieldType, Yield)
SELECT  'FEATURE_ICE', 'YIELD_FOOD', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_ICE' AND Value = 1) UNION ALL
SELECT  'FEATURE_ICE', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_ICE' AND Value = 1);

--==================================================================================================================
-- Fallout Tweak
--==================================================================================================================

-- Make Fallout harsher by eliminating any yields on a tile.
-- No, it does not make the tile has negative yields.

-- Feature_YieldChanges
DELETE  FROM Feature_YieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FALLOUT' AND Value = 1)
        AND FeatureType = 'FEATURE_FALLOUT';

INSERT  INTO Feature_YieldChanges (FeatureType, YieldType, Yield)
SELECT  'FEATURE_FALLOUT', Type, -10 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FALLOUT' AND Value = 1)
        AND Type IN (
                'YIELD_FOOD', 
                'YIELD_PRODUCTION', 
                'YIELD_GOLD', 
                'YIELD_SCIENCE', 
                'YIELD_CULTURE', 
                'YIELD_FAITH', 
                'YIELD_TOURISM', 
                'YIELD_GOLDEN_AGE_POINTS', 
                'YIELD_CULTURE_LOCAL');

--==================================================================================================================
-- Terrain - Condition Tweaks
--==================================================================================================================

-- Terrain_RiverYieldChanges
INSERT  INTO Terrain_RiverYieldChanges (TerrainType, YieldType, Yield)
SELECT  Type, 'YIELD_GOLD', 1 FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_CT' AND Value = 1)
        AND Type IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS', 'TERRAIN_TUNDRA') UNION ALL
SELECT  Type, 'YIELD_PRODUCTION', -1 FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_CT' AND Value = 1)
        AND Type IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS', 'TERRAIN_TUNDRA') UNION ALL

SELECT  'TERRAIN_DESERT', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_CT' AND Value = 1) UNION ALL
SELECT  'TERRAIN_DESERT', 'YIELD_GOLD', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_CT' AND Value = 1) UNION ALL

SELECT  'TERRAIN_SNOW', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_CT' AND Value = 1) UNION ALL
SELECT  'TERRAIN_SNOW', 'YIELD_GOLD', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_CT' AND Value = 1); 

-- Terrain_CoastalLandYields
INSERT  INTO Terrain_CoastalLandYields (TerrainType, YieldType, Yield)
SELECT  Type, 'YIELD_FOOD', 1 FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_CT' AND Value = 1)
        AND Type IN ('TERRAIN_PLAINS', 'TERRAIN_DESERT') UNION ALL
SELECT  Type, 'YIELD_PRODUCTION', -1 FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_CT' AND Value = 1)
        AND Type IN ('TERRAIN_PLAINS', 'TERRAIN_DESERT') UNION ALL

SELECT  'TERRAIN_TUNDRA', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_CT' AND Value = 1) UNION ALL
SELECT  'TERRAIN_TUNDRA', 'YIELD_GOLD', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_CT' AND Value = 1) UNION ALL

SELECT  'TERRAIN_SNOW', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_CT' AND Value = 1) UNION ALL
SELECT  'TERRAIN_SNOW', 'YIELD_CULTURE_LOCAL', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_CT' AND Value = 1);

--==================================================================================================================
-- Feature - Condition Tweaks
--==================================================================================================================

-- Feature_CoastalLandYields
INSERT INTO Feature_CoastalLandYields (FeatureType, YieldType, Yield)
SELECT  Type, 'YIELD_GOLD', 1 FROM Features
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_CT' AND Value = 1)
        AND Type IN ('FEATURE_FLOOD_PLAINS', 'FEATURE_MARSH') UNION ALL
SELECT  Type, 'YIELD_FOOD', -1 FROM Features
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_CT' AND Value = 1)
        AND Type IN ('FEATURE_FLOOD_PLAINS', 'FEATURE_MARSH');

--==================================================================================================================
-- Mountain - Condition Tweaks
--==================================================================================================================

-- Terrain_RiverYieldChanges
INSERT  INTO Terrain_RiverYieldChanges (TerrainType, YieldType, Yield)
SELECT  'TERRAIN_MOUNTAIN', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MT_CT' AND Value = 1) UNION ALL
SELECT  'TERRAIN_MOUNTAIN', 'YIELD_PRODUCTION', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MT_CT' AND Value = 1); 

-- Terrain_CoastalLandYields
INSERT  INTO Terrain_CoastalLandYields (TerrainType, YieldType, Yield)
SELECT  'TERRAIN_MOUNTAIN', 'YIELD_CULTURE_LOCAL', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MT_CT' AND Value = 1) UNION ALL
SELECT  'TERRAIN_MOUNTAIN', 'YIELD_FOOD', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MT_CT' AND Value = 1);

--==================================================================================================================
-- Terrain - Yield Enhancements
--==================================================================================================================

-- Terrain_TechYieldChanges
INSERT  INTO Terrain_TechYieldChanges (TerrainType, TechType, YieldType, Yield)
SELECT  'TERRAIN_GRASS', 'TECH_CIVIL_SERVICE', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_GRASS', 'TECH_FERTILIZER', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_GRASS', 'TECH_ECOLOGY', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_GRASS', 'TECH_GLOBALIZATION', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL

SELECT  'TERRAIN_PLAINS', 'TECH_CIVIL_SERVICE', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_PLAINS', 'TECH_INDUSTRIALIZATION', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_PLAINS', 'TECH_ECOLOGY', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_PLAINS', 'TECH_GLOBALIZATION', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL

SELECT  'TERRAIN_DESERT', 'TECH_GUILDS', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_DESERT', 'TECH_BIOLOGY', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_DESERT', 'TECH_RADAR', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_DESERT', 'TECH_TELECOM', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL

SELECT  'TERRAIN_TUNDRA', 'TECH_GUNPOWDER', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_TUNDRA', 'TECH_REFRIGERATION', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_TUNDRA', 'TECH_ROCKETRY', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_TUNDRA', 'TECH_NANOTECHNOLOGY', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL

SELECT  'TERRAIN_SNOW', 'TECH_ASTRONOMY', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_SNOW', 'TECH_REFRIGERATION', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_SNOW', 'TECH_ROBOTICS', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_SNOW', 'TECH_NANOTECHNOLOGY', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL

SELECT  'TERRAIN_COAST', 'TECH_NAVIGATION', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_OCEAN', 'TECH_OPTICS', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_OCEAN', 'TECH_BIOLOGY', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1);

/*
-- I wanted to use buildings instead of technologies for the terrain enhancements, just like the features.
-- But this apparently a bad implementation because it would also affect both the terrains and also features on top of it.
INSERT  INTO Building_TerrainYieldChanges (BuildingType, TerrainType, YieldType, Yield)
SELECT  b.Type, t.Type, 'YIELD_FOOD', 1
        FROM Buildings b, Terrains t
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND b.Type IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_GROCER')
        AND t.Type IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS', 'TERRAIN_DESERT') UNION ALL

SELECT  b.Type, t.Type, 'YIELD_GOLD', 1
        FROM Buildings b, Terrains t
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND b.Type IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_STOCKYARD')
        AND t.Type IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS') UNION ALL

SELECT  b.Type, 'TERRAIN_DESERT', 'YIELD_GOLD', 1
        FROM Buildings b
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND b.Type IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_AIRPORT') UNION ALL

SELECT  b.Type, 'TERRAIN_TUNDRA', 'YIELD_CULTURE_LOCAL', 1
        FROM Buildings b
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND b.Type IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_CASTLE') UNION ALL

SELECT  b.Type, 'TERRAIN_TUNDRA', 'YIELD_SCIENCE', 1
        FROM Buildings b
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND b.Type IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_PUBLIC_SCHOOL') UNION ALL

SELECT  b.Type, 'TERRAIN_SNOW', y.Type, 1
        FROM Buildings b, Yields y
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND b.Type IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_LABORATORY')
        AND y.Type IN ('YIELD_SCIENCE', 'YIELD_PRODUCTION');

-- Compatibility
CREATE TRIGGER TTO_TERRAINYIELD
AFTER INSERT ON Civilization_BuildingClassOverrides
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
AND NEW.BuildingClassType
    IN(
        SELECT  DISTINCT b.BuildingClass
                FROM Buildings b, Terrains t, Building_TerrainYieldChanges tyc
                WHERE t.Type IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS', 'TERRAIN_DESERT', 'TERRAIN_TUNDRA', 'TERRAIN_SMOW')
                AND tyc.TerrainType = t.Type
                AND b.Type = tyc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
        INSERT  INTO Building_TerrainYieldChanges (BuildingType, TerrainType, YieldType, Yield)
        SELECT  DISTINCT NEW.BuildingType, t.Type, 'YIELD_FOOD', 1
                FROM Terrains t, Building_TerrainYieldChanges tyc, BuildingClasses bc
                WHERE t.Type IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS', 'TERRAIN_DESERT')
                AND tyc.TerrainType = t.Type
                AND bc.Type = 'BUILDINGCLASS_GROCER'
                AND tyc.BuildingType = bc.DefaultBuilding UNION ALL

        SELECT  DISTINCT NEW.BuildingType, t.Type, 'YIELD_GOLD', 1
                FROM Terrains t, Building_TerrainYieldChanges tyc, BuildingClasses bc
                WHERE t.Type IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS')
                AND tyc.TerrainType = t.Type
                AND bc.Type = 'BUILDINGCLASS_STOCKYARD'
                AND tyc.BuildingType = bc.DefaultBuilding UNION ALL

        SELECT  DISTINCT NEW.BuildingType, 'TERRAIN_DESERT', 'YIELD_GOLD', 1
                FROM Building_TerrainYieldChanges tyc, BuildingClasses bc
                WHERE tyc.TerrainType = 'TERRAIN_DESERT'
                AND bc.Type = 'BUILDINGCLASS_AIRPORT'
                AND tyc.BuildingType = bc.DefaultBuilding UNION ALL

        SELECT  DISTINCT NEW.BuildingType, 'TERRAIN_TUNDRA', 'YIELD_CULTURE_LOCAL', 1
                FROM Building_TerrainYieldChanges tyc, BuildingClasses bc
                WHERE tyc.TerrainType = 'TERRAIN_TUNDRA'
                AND bc.Type = 'BUILDINGCLASS_CASTLE'
                AND tyc.BuildingType = bc.DefaultBuilding UNION ALL

        SELECT  DISTINCT NEW.BuildingType, 'TERRAIN_TUNDRA', 'YIELD_SCIENCE', 1
                FROM Building_TerrainYieldChanges tyc, BuildingClasses bc
                WHERE tyc.TerrainType = 'TERRAIN_TUNDRA'
                AND bc.Type = 'BUILDINGCLASS_PUBLIC_SCHOOL'
                AND tyc.BuildingType = bc.DefaultBuilding UNION ALL

        SELECT  DISTINCT NEW.BuildingType, 'TERRAIN_SMOW', 'YIELD_SCIENCE', 1
                FROM Building_TerrainYieldChanges tyc, BuildingClasses bc
                WHERE tyc.TerrainType = 'TERRAIN_SNOW'
                AND bc.Type = 'BUILDINGCLASS_LABORATORY'
                AND tyc.BuildingType = bc.DefaultBuilding;
END;

-- Building_ResourceQuantityRequirements
UPDATE  Building_ResourceQuantityRequirements SET Cost = '1'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND ResourceType = 'RESOURCE_HORSE'
        AND BuildingType = 'BUILDING_STOCKYARD';
*/

-- FLOOD PLAINS
-- Because Flood Plains actually acting like a terrain, so just put it inside the Terrain - Yield Enhancements mod.

-- Feature_TechYieldChanges
INSERT  INTO Feature_TechYieldChanges (FeatureType, TechType, YieldType, Yield)
SELECT  'FEATURE_FLOOD_PLAINS', 'TECH_GUILDS', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'FEATURE_FLOOD_PLAINS', 'TECH_BIOLOGY', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'FEATURE_FLOOD_PLAINS', 'TECH_ECOLOGY', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'FEATURE_FLOOD_PLAINS', 'TECH_GLOBALIZATION', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1);
/*
INSERT  INTO Feature_TechYieldChanges (FeatureType, TechType, YieldType, Yield)
SELECT  'FEATURE_FLOOD_PLAINS', 'TECH_ECOLOGY', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1) UNION ALL
SELECT  'FEATURE_FLOOD_PLAINS', 'TECH_GLOBALIZATION', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1);
*/
/*
-- Building_FeatureYieldChanges
INSERT  INTO Building_FeatureYieldChanges (BuildingType, FeatureType, YieldType, Yield)
SELECT  b.Type, 'FEATURE_FLOOD_PLAINS', y.Type, 1
        FROM Buildings b, Yields y
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND b.Type IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_GROCER')
        AND y.Type IN ('YIELD_FOOD') UNION ALL
SELECT  b.Type, 'FEATURE_FLOOD_PLAINS', y.Type, 1
        FROM Buildings b, Yields y
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND b.Type IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_WINDMILL')
        AND y.Type IN ('YIELD_GOLD');

-- Compatibility
CREATE TRIGGER TTO_FLPLAINS_BLD
AFTER INSERT ON Civilization_BuildingClassOverrides
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
AND NEW.BuildingClassType
    IN(
        SELECT  DISTINCT b.BuildingClass
                FROM Buildings b, Features f, Building_FeatureYieldChanges fyc
                WHERE f.Type = 'FEATURE_FLOOD_PLAINS'
                AND fyc.FeatureType = f.Type
                AND b.Type = fyc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
        INSERT  INTO Building_FeatureYieldChanges (BuildingType, FeatureType, YieldType, Yield)
        SELECT  DISTINCT NEW.BuildingType, 'FEATURE_FLOOD_PLAINS', 'YIELD_FOOD', 1
                FROM Building_FeatureYieldChanges fyc, BuildingClasses bc
                WHERE fyc.FeatureType = 'FEATURE_FLOOD_PLAINS'
                AND bc.Type = 'BUILDINGCLASS_GROCER'
                AND fyc.BuildingType = bc.DefaultBuilding UNION ALL

        SELECT  DISTINCT NEW.BuildingType, 'FEATURE_FLOOD_PLAINS', 'YIELD_GOLD', 1
                FROM Building_FeatureYieldChanges fyc, BuildingClasses bc
                WHERE fyc.FeatureType = 'FEATURE_FLOOD_PLAINS'
                AND bc.Type = 'BUILDINGCLASS_WINDMILL'
                AND fyc.BuildingType = bc.DefaultBuilding;
END;
*/

--==================================================================================================================
-- Feature - Yield Enhancements
--==================================================================================================================

-- MARSH

-- Building_FeatureYieldChanges
UPDATE  Building_FeatureYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
        AND FeatureType = 'FEATURE_MARSH'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_WINDMILL');

-- Compatibility with other mod
CREATE TRIGGER TTO_WINDMARSH_ADJUST
AFTER INSERT ON Civilization_BuildingClassOverrides
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
AND NEW.BuildingClassType
    IN(
        SELECT  DISTINCT b.BuildingClass
                FROM Buildings b, Features f, Building_FeatureYieldChanges fyc
                WHERE f.Type = 'FEATURE_MARSH'
                AND fyc.FeatureType = f.Type
                AND b.Type = fyc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
        UPDATE  Building_FeatureYieldChanges SET Yield = 1
                WHERE FeatureType = 'FEATURE_MARSH'
                AND BuildingType = NEW.BuildingType
                AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_WINDMILL');
END;

-- Feature_TechYieldChanges
INSERT  INTO Feature_TechYieldChanges (FeatureType, TechType, YieldType, Yield)
SELECT  'FEATURE_MARSH', 'TECH_BIOLOGY', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1) UNION ALL
SELECT  'FEATURE_MARSH', 'TECH_MOBILE_TACTICS', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1);

-- FOREST & JUNGLE

-- Feature_TechYieldChanges
INSERT  INTO Feature_TechYieldChanges (FeatureType, TechType, YieldType, Yield)
SELECT  'FEATURE_JUNGLE', 'TECH_BIOLOGY', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1) UNION ALL
SELECT  'FEATURE_FOREST', 'TECH_ROCKETRY', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1) UNION ALL
SELECT  Type, 'TECH_ROBOTICS', 'YIELD_PRODUCTION', 1 FROM Features
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
        AND Type IN ('FEATURE_FOREST', 'FEATURE_JUNGLE');

-- Building_FeatureYieldChanges
INSERT  INTO Building_FeatureYieldChanges (BuildingType, FeatureType, YieldType, Yield)
SELECT	Type, 'FEATURE_JUNGLE', 'YIELD_FOOD', 1 FROM Buildings
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
        AND Type IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_MEDICAL_LAB');

-- Compatibility
CREATE TRIGGER TTO_JUNGLELAB
AFTER INSERT ON Civilization_BuildingClassOverrides
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
AND NEW.BuildingClassType
    IN(
        SELECT  DISTINCT b.BuildingClass
                FROM Buildings b, Features f, Building_FeatureYieldChanges fyc
                WHERE f.Type = 'FEATURE_JUNGLE'
                AND fyc.FeatureType = f.Type
                AND b.Type = fyc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
        INSERT  INTO Building_FeatureYieldChanges (BuildingType, FeatureType, YieldType, Yield)
        SELECT  DISTINCT NEW.BuildingType, 'FEATURE_JUNGLE', 'YIELD_FOOD', 1
                FROM Building_FeatureYieldChanges fyc, BuildingClasses bc
                WHERE fyc.FeatureType = 'FEATURE_JUNGLE'
                AND bc.Type = 'BUILDINGCLASS_MEDICAL_LAB'
                AND fyc.BuildingType = bc.DefaultBuilding;
END;

-- OTHER FEATURES
-- Feature_TechYieldChanges
INSERT  INTO Feature_TechYieldChanges (FeatureType, TechType, YieldType, Yield)
SELECT  'FEATURE_OASIS', 'TECH_BIOLOGY', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1) UNION ALL
SELECT  Type, 'TECH_BIOLOGY', 'YIELD_PRODUCTION', 1 FROM Features
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
        AND Type IN ('FEATURE_OASIS', 'FEATURE_ATOLL') UNION ALL
SELECT  Type, 'TECH_ECOLOGY', 'YIELD_CULTURE', 2 FROM Features
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
        AND Type IN ('FEATURE_OASIS', 'FEATURE_ATOLL') UNION ALL
SELECT  Type, 'TECH_ECOLOGY', 'YIELD_TOURISM', 4 FROM Features
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
        AND Type IN ('FEATURE_OASIS', 'FEATURE_ATOLL') UNION ALL
SELECT  Type, 'TECH_GLOBALIZATION', 'YIELD_GOLD', 2 FROM Features
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
        AND Type IN ('FEATURE_OASIS', 'FEATURE_ATOLL');

--==================================================================================================================
-- Mountain - Yield Enhancements
--==================================================================================================================

-- Terrain_TechYieldChanges
INSERT  INTO Terrain_TechYieldChanges (TerrainType, TechType, YieldType, Yield)
SELECT  'TERRAIN_MOUNTAIN', 'TECH_GUNPOWDER', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MT_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_MOUNTAIN', 'TECH_DYNAMITE', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MT_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_MOUNTAIN', 'TECH_RADAR', 'YIELD_CULTURE_LOCAL', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MT_YIELD' AND Value = 1) UNION ALL
SELECT  'TERRAIN_MOUNTAIN', 'TECH_SATELLITES', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MT_YIELD' AND Value = 1);

--==================================================================================================================
-- Ice - Yield Enhancements
--==================================================================================================================

-- Feature_TechYieldChanges
INSERT INTO Feature_TechYieldChanges (FeatureType, TechType, YieldType, Yield)
SELECT  'FEATURE_ICE', 'TECH_STEAM_POWER', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_ICE_YIELD' AND Value = 1) UNION ALL
SELECT  'FEATURE_ICE', 'TECH_REFRIGERATION', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_ICE_YIELD' AND Value = 1) UNION ALL
SELECT  'FEATURE_ICE', 'TECH_ROBOTICS', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_ICE_YIELD' AND Value = 1);

--==================================================================================================================
-- Feature - Terrain Booleans
--==================================================================================================================

-- Feature_TerrainBooleans
INSERT INTO Feature_TerrainBooleans (FeatureType, TerrainType)
SELECT  'FEATURE_JUNGLE', Type FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_BOOL' AND Value = 1)
        AND Type = 'TERRAIN_GRASS' UNION ALL
SELECT  'FEATURE_OASIS', Type FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_BOOL' AND Value = 1)
        AND Type IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS') UNION ALL
SELECT  'FEATURE_MARSH', Type FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_BOOL' AND Value = 1)
        AND Type IN ('TERRAIN_PLAINS', 'TERRAIN_TUNDRA');

-- Some Tweaks (i don't even know if this working or not)
UPDATE  Features SET AppearanceProbability = 100
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_BOOL' AND Value = 1)
        AND Type = 'FEATURE_MARSH';
UPDATE  Features SET Growth = 80, GrowthTerrainType = NULL
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_BOOL' AND Value = 1)
        AND Type = 'FEATURE_JUNGLE';
UPDATE  Features SET Growth = 75
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_BOOL' AND Value = 1)
        AND Type = 'FEATURE_FOREST';

--==================================================================================================================
-- Flood Plains - Terrain Boolean
--==================================================================================================================

-- Feature_TerrainBooleans
INSERT INTO Feature_TerrainBooleans (FeatureType, TerrainType)
SELECT  'FEATURE_FLOOD_PLAINS', Type FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FP_BOOL' AND Value = 1)
        AND Type IN ('TERRAIN_GRASS', 'TERRAIN_PLAINS');

-- Some Tweaks (this apparently don't work, LOL)
UPDATE  Features SET AppearanceProbability = '-5000', DisappearanceProbability = '50'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FP_BOOL' AND Value = 1)
        AND Type = 'FEATURE_FLOOD_PLAINS';

--==================================================================================================================
-- If Unique City-States mod by Techpriest Enginseer exists
--==================================================================================================================

-- Improvement_ValidTerrains
INSERT  INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
SELECT  'IMPROVEMENT_MARSH', Type FROM Terrains
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_BOOL' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_MARSH')
        AND Type IN('TERRAIN_GRASS', 'TERRAIN_PLAINS');