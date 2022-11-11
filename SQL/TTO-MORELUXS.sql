--==================================================================================================================
--==================================================================================================================
-- If More Luxuries for VP mod by Barathor exists
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
-- Resource & Improvement Tweaks
--==================================================================================================================

-- Building_ResourceYieldChanges
-- Basic buildings
INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_GROCER', 'RESOURCE_OLIVE', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_OLIVE') UNION ALL
SELECT	'BUILDING_MUSEUM', Type, 'YIELD_CULTURE', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_JADE', 'RESOURCE_LAPIS'))
        AND Type IN ('RESOURCE_AMBER', 'RESOURCE_JADE', 'RESOURCE_LAPIS');

-- Unique buildings
INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT	DISTINCT bco.BuildingType, 'RESOURCE_OLIVE', 'YIELD_FOOD', 1 
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_OLIVE')
        AND ryc.ResourceType = 'RESOURCE_OLIVE'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_GROCER'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT	DISTINCT bco.BuildingType, r.Type, 'YIELD_CULTURE', 1
        FROM Buildings b, Resources r, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_JADE', 'RESOURCE_LAPIS'))
        AND r.Type IN ('RESOURCE_AMBER', 'RESOURCE_JADE', 'RESOURCE_LAPIS')
        AND ryc.ResourceType = r.Type
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_MUSEUM'
        AND bco.BuildingType IS NOT NULL;

-- Compatibility
CREATE TRIGGER TTO_MoreLuxsVP
AFTER INSERT ON Civilization_BuildingClassOverrides
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_AMBER', 'RESOURCE_JADE', 'RESOURCE_LAPIS', 'RESOURCE_OLIVE'))
AND NEW.BuildingClassType
    IN(
    SELECT  DISTINCT b.BuildingClass
            FROM Buildings b, Resources r, Building_ResourceYieldChanges ryc
            WHERE r.Type IN ('RESOURCE_AMBER', 'RESOURCE_JADE', 'RESOURCE_LAPIS', 'RESOURCE_OLIVE')
            AND ryc.ResourceType = r.Type
            AND b.Type = ryc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
    INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_OLIVE', 'YIELD_FOOD', 1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_OLIVE'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL
            
    SELECT  DISTINCT NEW.BuildingType, r.Type, 'YIELD_CULTURE', 1
            FROM Resources r, Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE r.Type IN ('RESOURCE_AMBER', 'RESOURCE_JADE', 'RESOURCE_LAPIS')
            AND ryc.ResourceType = r.Type
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding;
END;

-- Improvement_ResourceType_Yields
UPDATE  Improvement_ResourceType_Yields SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_PERFUME')
        AND ImprovementType = 'IMPROVEMENT_PLANTATION'
        AND ResourceType = 'RESOURCE_PERFUME'
        AND YieldType = 'YIELD_GOLD';

-- Improvement_ResourceType_Yields
INSERT  INTO Improvement_ResourceType_Yields (ImprovementType, ResourceType, YieldType, Yield)
SELECT	'IMPROVEMENT_FISHING_BOATS', 'RESOURCE_CORAL', 'YIELD_FOOD', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_FISHINGMOD' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_CORAL');

--==================================================================================================================
-- Resources Boolean Tweaks
--==================================================================================================================

-- Resource_TerrainBooleans
INSERT  INTO Resource_TerrainBooleans (ResourceType, TerrainType)
SELECT  Type, 'TERRAIN_DESERT' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_OLIVE', 'RESOURCE_PERFUME', 'RESOURCE_TOBACCO'))
        AND Type IN ('RESOURCE_OLIVE', 'RESOURCE_PERFUME', 'RESOURCE_TOBACCO');

-- Resource_FeatureBooleans
INSERT INTO Resource_FeatureBooleans (ResourceType, FeatureType)
SELECT  r.Type, f.Type FROM Resources r, Features f
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_PERFUME', 'RESOURCE_TEA', 'RESOURCE_TOBACCO'))
        AND r.Type IN ('RESOURCE_PERFUME', 'RESOURCE_TEA', 'RESOURCE_TOBACCO')
        AND f.Type IN ('FEATURE_FLOOD_PLAINS', 'FEATURE_FOREST', 'FEATURE_JUNGLE') UNION ALL

SELECT  Type, 'FEATURE_MARSH' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_JADE', 'RESOURCE_OLIVE'))
        AND Type IN ('RESOURCE_JADE', 'RESOURCE_OLIVE');

--==================================================================================================================
-- If CBPMC - Industrial Bulding Pack mod by thecrazyscotsman also exists
--==================================================================================================================

INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_TCS_GROCER', Type, 'YIELD_GOLD', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_INDUSTRIAL') AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_COFFEE', 'RESOURCE_OLIVE', 'RESOURCE_PERFUME', 'RESOURCE_TEA'))
        AND Type IN ('RESOURCE_COFFEE', 'RESOURCE_OLIVE', 'RESOURCE_PERFUME', 'RESOURCE_TEA');