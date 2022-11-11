--==================================================================================================================
--==================================================================================================================
-- Miscellaneous. For individual mod that should be adjusted to be balanced with this mod.
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
-- If Polar Station for VP from "Few More Buildings" mod by Asterix Rage exists
--==================================================================================================================
/*
DELETE  FROM Building_TerrainYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_POLAR_STATION')
        AND TerrainType = 'TERRAIN_SNOW'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_LABORATORY');
*/

DELETE  FROM Terrain_TechYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_POLAR_STATION')
        AND TerrainType = 'TERRAIN_SNOW'
        AND TechType IN ('TECH_REFRIGERATION', 'TECH_ROBOTICS');

UPDATE  Building_TerrainYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_POLAR_STATION')
        AND TerrainType = 'TERRAIN_SNOW'
        AND BuildingType = 'BUILDING_POLAR_STATION';

INSERT  INTO Building_TerrainYieldChanges (BuildingType, TerrainType, YieldType, Yield)
SELECT  'BUILDING_POLAR_STATION', 'TERRAIN_SNOW', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_POLAR_STATION');

--==================================================================================================================
-- If Ski Resort for VP from "Few More Buildings" mod by Asterix Rage exists
--==================================================================================================================

UPDATE  Building_YieldPerXTerrainTimes100 SET Yield = 100
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_SKI_RESORT')
        AND BuildingType = 'BUILDING_SKI_RESORT';

UPDATE  Building_YieldPerXTerrainTimes100 SET Yield = 300
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_SKI_RESORT')
        AND BuildingType = 'BUILDING_BROADCAST_TOWER'
        AND YieldType = 'YIELD_CULTURE';

UPDATE  Building_YieldPerXTerrainTimes100 SET Yield = 100
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BLD_MT' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_SKI_RESORT')
        AND BuildingType = 'BUILDING_BOMB_SHELTER'
        AND YieldType = 'YIELD_CULTURE_LOCAL';

--==================================================================================================================
-- If National Parks mod by pineappledan exists
--==================================================================================================================

INSERT  INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
SELECT  'IMPROVEMENT_NATIONAL_PARK', 'TERRAIN_DESERT'
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_NATIONAL_PARK');

INSERT  INTO Improvement_AdjacentFeatureYieldChanges (ImprovementType, FeatureType, YieldType, Yield)
SELECT  'IMPROVEMENT_NATIONAL_PARK', f.Type, y.Type, 2 FROM Features f, Yields y
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_NATIONAL_PARK')
        AND f.PseudoNaturalWonder = 1
        AND y.Type IN ('YIELD_CULTURE', 'YIELD_SCIENCE');

INSERT  INTO Improvement_TechYieldChanges
        (ImprovementType, TechType, YieldType, Yield)
SELECT  'IMPROVEMENT_NATIONAL_PARK', 'TECH_GLOBALIZATION', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_NATIONAL_PARK')
        AND Type IN ('YIELD_CULTURE', 'YIELD_SCIENCE', 'YIELD_TOURISM');