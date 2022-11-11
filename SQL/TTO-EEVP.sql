--==================================================================================================================
--==================================================================================================================
-- If Enlightenment Era for VP mod exists
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
-- Resource Tweaks
--==================================================================================================================

-- EE_TAVERN
DELETE  FROM Building_ResourceYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_TAVERN')
        AND ResourceType = 'RESOURCE_WHEAT'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_GROCER');

DELETE  FROM Improvement_ResourceType_Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_TAVERN')
        AND ImprovementType = 'IMPROVEMENT_FISHING_BOATS'
        AND ResourceType = 'RESOURCE_FISH'
        AND YieldType = 'YIELD_PRODUCTION';

-- Compatibility with other mod
CREATE TRIGGER TTO_TAVERNWHEAT
AFTER INSERT ON Civilization_BuildingClassOverrides
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_TAVERN')
AND NEW.BuildingClassType
    IN(
        SELECT  DISTINCT b.BuildingClass
                FROM Buildings b, Resources r, Building_ResourceYieldChanges ryc
                WHERE r.Type = 'RESOURCE_WHEAT'
                AND ryc.ResourceType = r.Type
                AND b.Type = ryc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
        DELETE  FROM Building_ResourceYieldChanges
                WHERE ResourceType = 'RESOURCE_WHEAT'
                AND BuildingType = NEW.BuildingType
                AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_GROCER');
END;

-- EE_MENAGERIE
INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_EE_MENAGERIE', 'RESOURCE_TRUFFLES', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND Type IN ('YIELD_GOLD', 'YIELD_CULTURE')
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_MENAGERIE');

-- EE_CLOTH_MILL
DELETE  FROM Building_ResourceYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_CLOTH_MILL')
        AND ResourceType IN ('RESOURCE_COTTON', 'RESOURCE_SHEEP', 'RESOURCE_SILK')
        AND BuildingType = 'BUILDING_EE_CLOTH_MILL';

INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_EE_CLOTH_MILL', 'RESOURCE_SHEEP', 'YIELD_FOOD', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_CLOTH_MILL') UNION ALL
SELECT  'BUILDING_EE_CLOTH_MILL', Type, 'YIELD_GOLD', -1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_CLOTH_MILL')
        AND Type IN ('RESOURCE_COTTON', 'RESOURCE_SILK') UNION ALL
SELECT  'BUILDING_EE_CLOTH_MILL', Type, 'YIELD_PRODUCTION', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_CLOTH_MILL')
        AND Type IN ('RESOURCE_SHEEP', 'RESOURCE_COTTON', 'RESOURCE_SILK');

--==================================================================================================================
-- Terrain and Feature Tweaks
--==================================================================================================================

-- Building_TerrainYieldChanges
/*
DELETE  FROM Building_TerrainYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_BASTION')
        AND TerrainType = 'TERRAIN_TUNDRA'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_CASTLE');

INSERT  INTO Building_TerrainYieldChanges (BuildingType, TerrainType, YieldType, Yield)
SELECT  'BUILDING_EE_BASTION', 'TERRAIN_TUNDRA', 'YIELD_CULTURE_LOCAL', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_BASTION');
*/
-- EE_MENAGERIE
UPDATE  Building_FeatureYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_MENAGERIE')
        AND BuildingType = 'BUILDING_EE_MENAGERIE'
        AND FeatureType IN ('FEATURE_FOREST', 'FEATURE_JUNGLE')
        AND YieldType = 'YIELD_TOURISM';

DELETE  FROM Building_FeatureYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_MENAGERIE')
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_WORKSHOP')
        AND FeatureType = 'FEATURE_FOREST'
        AND YieldType = 'YIELD_PRODUCTION';

DELETE  FROM Building_FeatureYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_MENAGERIE')
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_MEDICAL_LAB')
        AND FeatureType = 'FEATURE_JUNGLE';

-- Compatibility with other mod
CREATE TRIGGER TTO_FORESTJUNGLE
AFTER INSERT ON Civilization_BuildingClassOverrides
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_MENAGERIE')
AND NEW.BuildingClassType
    IN(
        SELECT  DISTINCT b.BuildingClass
                FROM Buildings b, Features f, Building_FeatureYieldChanges fyc
                WHERE f.Type IN ('FEATURE_FOREST', 'FEATURE_JUNGLE')
                AND fyc.FeatureType = f.Type
                AND b.Type = fyc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
        DELETE  FROM Building_FeatureYieldChanges
                WHERE FeatureType = 'FEATURE_FOREST'
                AND YieldType = 'YIELD_PRODUCTION'
                AND BuildingType = NEW.BuildingType
                AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_WORKSHOP');
        
        DELETE  FROM Building_FeatureYieldChanges
                WHERE FeatureType = 'FEATURE_JUNGLE'
                AND BuildingType = NEW.BuildingType
                AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_MEDICAL_LAB');
END;

DELETE  FROM Feature_TechYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_MENAGERIE')
        AND FeatureType IN ('FEATURE_FOREST', 'FEATURE_JUNGLE')
        AND TechType IN ('TECH_BIOLOGY', 'TECH_ROBOTICS');

INSERT  INTO Feature_TechYieldChanges (FeatureType, TechType, YieldType, Yield)
SELECT  'FEATURE_JUNGLE', 'TECH_PENICILIN', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FR_YIELD' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_MENAGERIE');