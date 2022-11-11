--==================================================================================================================
--==================================================================================================================
-- If Even More Resources for VP by HungryForFood mod exists
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
-- Resource Tweaks
--==================================================================================================================

-- Building_ResourceYieldChanges
-- Basic buildings
INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_FACTORY', 'RESOURCE_TIN', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_TIN') UNION ALL

SELECT	'BUILDING_GROCER', 'RESOURCE_COCONUT', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_COCONUT') UNION ALL

SELECT	'BUILDING_GROCER', Type, 'YIELD_FOOD', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_MAIZE', 'RESOURCE_RICE'))
        AND Type IN ('RESOURCE_MAIZE', 'RESOURCE_RICE') UNION ALL

SELECT	'BUILDING_ARSENAL', Type, 'YIELD_PRODUCTION', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_RUBBER', 'RESOURCE_SULFUR'))
        AND Type IN ('RESOURCE_RUBBER', 'RESOURCE_SULFUR') UNION ALL

SELECT	'BUILDING_LABORATORY', Type, 'YIELD_SCIENCE', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_OBSIDIAN', 'RESOURCE_LEAD'))
        AND Type IN ('RESOURCE_OBSIDIAN', 'RESOURCE_LEAD') UNION ALL

SELECT	'BUILDING_MUSEUM', 'RESOURCE_OBSIDIAN', 'YIELD_CULTURE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_OBSIDIAN');

-- Unique buildings
INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT	DISTINCT bco.BuildingType, 'RESOURCE_TIN', 'YIELD_PRODUCTION', 1
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_TIN')
        AND ryc.ResourceType = 'RESOURCE_TIN'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_FACTORY'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT	DISTINCT bco.BuildingType, 'RESOURCE_COCONUT', 'YIELD_GOLD', 1
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_COCONUT')
        AND ryc.ResourceType = 'RESOURCE_COCONUT'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_GROCER'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT	DISTINCT bco.BuildingType, r.Type, 'YIELD_FOOD', 1
        FROM Resources r, Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_MAIZE', 'RESOURCE_RICE'))
        AND r.Type IN ('RESOURCE_MAIZE', 'RESOURCE_RICE')
        AND ryc.ResourceType = r.Type
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_GROCER'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT	DISTINCT bco.BuildingType, r.Type, 'YIELD_PRODUCTION', 1
        FROM Resources r, Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_RUBBER')
        AND r.Type IN ('RESOURCE_RUBBER', 'RESOURCE_SULFUR')
        AND ryc.ResourceType = r.Type
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_ARSENAL'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT	DISTINCT bco.BuildingType, r.Type, 'YIELD_SCIENCE', 1
        FROM Resources r, Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_OBSIDIAN')
        AND r.Type IN ('RESOURCE_OBSIDIAN', 'RESOURCE_LEAD')
        AND ryc.ResourceType = r.Type
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_LABORATORY'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT	DISTINCT bco.BuildingType, 'RESOURCE_OBSIDIAN', 'YIELD_CULTURE', 1
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_OBSIDIAN')
        AND ryc.ResourceType = 'RESOURCE_OBSIDIAN'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_MUSEUM'
        AND bco.BuildingType IS NOT NULL;

UPDATE  Building_ResourceYieldChanges SET Yield = '1'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_PLATINUM')
        AND ResourceType = 'RESOURCE_PLATINUM'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_PUBLIC_SCHOOL');

UPDATE  Building_ResourceYieldChanges SET Yield = '1'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_LEAD')
        AND ResourceType = 'RESOURCE_LEAD'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_FORGE');

UPDATE  Building_ResourceYieldChanges SET Yield = '1'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_PINEAPPLE')
        AND ResourceType = 'RESOURCE_PINEAPPLE'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_MARKET');

UPDATE  Building_ResourceYieldChanges SET Yield = '1'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_PINEAPPLE', 'RESOURCE_POTATO'))
        AND ResourceType IN ('RESOURCE_PINEAPPLE', 'RESOURCE_POTATO')
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_GROCER');

UPDATE  Building_ResourceYieldChanges SET Yield = '2'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_RUBBER', 'RESOURCE_SULFUR'))
        AND ResourceType IN ('RESOURCE_RUBBER', 'RESOURCE_SULFUR')
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_FACTORY');

UPDATE  Building_ResourceYieldChanges SET Yield = '1'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_TITANIUM')
        AND ResourceType = 'RESOURCE_TITANIUM'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_LABORATORY');

DELETE  FROM Building_ResourceYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_POTATO')
        AND ResourceType = 'RESOURCE_POTATO'
        AND YieldType = 'YIELD_FOOD'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_GROCER');

DELETE  FROM Building_ResourceYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_HARDWOOD')
        AND ResourceType = 'RESOURCE_HARDWOOD'
        AND YieldType = 'YIELD_PRODUCTION'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_WORKSHOP');

DELETE  FROM Building_ResourceYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_TIN')
        AND ResourceType = 'RESOURCE_TIN'
        AND YieldType = 'YIELD_PRODUCTION'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_FORGE');

DELETE  FROM Building_ResourceYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_TITANIUM')
        AND ResourceType = 'RESOURCE_TITANIUM'
        AND YieldType = 'YIELD_PRODUCTION'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_LABORATORY');

-- Compatibility with other mod
CREATE TRIGGER TTO_EMRfVP
AFTER INSERT ON Civilization_BuildingClassOverrides
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_COCONUT', 'RESOURCE_HARDWOOD', 'RESOURCE_MAIZE', 'RESOURCE_OBSIDIAN', 'RESOURCE_PINEAPPLE', 'RESOURCE_POTATO', 'RESOURCE_RICE', 'RESOURCE_RUBBER', 'RESOURCE_TITANIUM'))
AND NEW.BuildingClassType
    IN(
    SELECT  DISTINCT b.BuildingClass
            FROM Buildings b, Resources r, Building_ResourceYieldChanges ryc
            WHERE r.Type IN ('RESOURCE_COCONUT', 'RESOURCE_HARDWOOD', 'RESOURCE_MAIZE', 'RESOURCE_OBSIDIAN', 'RESOURCE_PINEAPPLE', 'RESOURCE_POTATO', 'RESOURCE_RICE', 'RESOURCE_RUBBER', 'RESOURCE_TIN', 'RESOURCE_TITANIUM')
            AND ryc.ResourceType = r.Type
            AND b.Type = ryc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
    INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_TIN', 'YIELD_PRODUCTION', 1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_TIN'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_COCONUT', 'YIELD_GOLD', 1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_COCONUT'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, r.Type, 'YIELD_FOOD', 1
            FROM Resources r, Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE r.Type IN ('RESOURCE_MAIZE', 'RESOURCE_RICE')
            AND ryc.ResourceType = r.Type
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, r.Type, 'YIELD_PRODUCTION', 1
            FROM Resources r, Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE r.Type IN ('RESOURCE_RUBBER', 'RESOURCE_SULFUR')
            AND ryc.ResourceType = r.Type
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, r.Type, 'YIELD_SCIENCE', 1
            FROM Resources r, Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE r.Type IN ('RESOURCE_OBSIDIAN', 'RESOURCE_LEAD')
            AND ryc.ResourceType = r.Type
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_OBSIDIAN', 'YIELD_CULTURE', 1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_OBSIDIAN'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding;

    UPDATE  Building_ResourceYieldChanges SET Yield = 1
            WHERE ResourceType = 'RESOURCE_PLATINUM'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_PUBLIC_SCHOOL');

    UPDATE  Building_ResourceYieldChanges SET Yield = 1
            WHERE ResourceType = 'RESOURCE_LEAD'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_FORGE');

    UPDATE  Building_ResourceYieldChanges SET Yield = 1
            WHERE ResourceType = 'RESOURCE_PINEAPPLE'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_MARKET');

    UPDATE  Building_ResourceYieldChanges SET Yield = 1
            WHERE ResourceType IN ('RESOURCE_PINEAPPLE', 'RESOURCE_POTATO')
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_GROCER');

    UPDATE  Building_ResourceYieldChanges SET Yield = 2
            WHERE ResourceType IN ('RESOURCE_RUBBER', 'RESOURCE_SULFUR')
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_FACTORY');

    UPDATE  Building_ResourceYieldChanges SET Yield = 1
            WHERE ResourceType = 'RESOURCE_TITANIUM'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_LABORATORY');

    DELETE  FROM Building_ResourceYieldChanges
            WHERE ResourceType = 'RESOURCE_POTATO'
            AND YieldType = 'YIELD_FOOD'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_GROCER');

    DELETE  FROM Building_ResourceYieldChanges
            WHERE ResourceType = 'RESOURCE_HARDWOOD'
            AND YieldType = 'YIELD_PRODUCTION'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_WORKSHOP');

    DELETE  FROM Building_ResourceYieldChanges
            WHERE ResourceType = 'RESOURCE_TIN'
            AND YieldType = 'YIELD_PRODUCTION'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_FORGE');

    DELETE  FROM Building_ResourceYieldChanges
            WHERE ResourceType = 'RESOURCE_TITANIUM'
            AND YieldType = 'YIELD_PRODUCTION'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_LABORATORY');
END;

-- Resource_YieldChanges
INSERT INTO Resource_YieldChanges (ResourceType, YieldType, Yield)
SELECT  'RESOURCE_LAVENDER', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_LAVENDER') UNION ALL
SELECT  'RESOURCE_OBSIDIAN', 'YIELD_FAITH', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_OBSIDIAN') UNION ALL
SELECT  'RESOURCE_PLATINUM', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_PLATINUM') UNION ALL
SELECT  'RESOURCE_POPPY', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_POPPY') UNION ALL
SELECT  'RESOURCE_TIN', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_TIN');

UPDATE  Resource_YieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_RUBBER')
        AND ResourceType = 'RESOURCE_RUBBER'
        AND YieldType = 'YIELD_GOLD';

-- Improvement_ResourceType_Yields
UPDATE  Improvement_ResourceType_Yields SET Yield = '2'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_POTATO', 'RESOURCE_PINEAPPLE'))
        AND ImprovementType = 'IMPROVEMENT_PLANTATION'
        AND ResourceType IN ('RESOURCE_POTATO', 'RESOURCE_PINEAPPLE')
        AND YieldType = 'YIELD_FOOD';

UPDATE  Improvement_ResourceType_Yields SET Yield = '1'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_RUBBER')
        AND ImprovementType = 'IMPROVEMENT_PLANTATION'
        AND ResourceType = 'RESOURCE_RUBBER'
        AND YieldType = 'YIELD_PRODUCTION';

UPDATE  Improvement_ResourceType_Yields SET Yield = '1'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_TITANIUM')
        AND ImprovementType = 'IMPROVEMENT_MINE'
        AND ResourceType = 'RESOURCE_TITANIUM'
        AND YieldType = 'YIELD_SCIENCE';

DELETE  FROM Improvement_ResourceType_Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_PINEAPPLE')
        AND ImprovementType = 'IMPROVEMENT_PLANTATION'
        AND ResourceType = 'RESOURCE_PINEAPPLE'
        AND YieldType = 'YIELD_GOLD';

DELETE  FROM Improvement_ResourceType_Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_RUBBER')
        AND ImprovementType = 'IMPROVEMENT_PLANTATION'
        AND ResourceType = 'RESOURCE_RUBBER'
        AND YieldType = 'YIELD_GOLD';

DELETE  FROM Improvement_ResourceType_Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_TIN')
        AND ImprovementType = 'IMPROVEMENT_MINE'
        AND ResourceType = 'RESOURCE_TIN'
        AND YieldType = 'YIELD_PRODUCTION';

DELETE  FROM Improvement_ResourceType_Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_TITANIUM')
        AND ImprovementType = 'IMPROVEMENT_MINE'
        AND ResourceType = 'RESOURCE_TITANIUM'
        AND YieldType = 'YIELD_PRODUCTION';

INSERT  INTO Improvement_ResourceType_Yields (ImprovementType, ResourceType, YieldType, Yield)
SELECT  'IMPROVEMENT_LUMBERMILL_JUNGLE', 'RESOURCE_HARDWOOD', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_HARDWOOD');

-- Improvement_ResourceTypes
INSERT INTO Improvement_ResourceTypes (ImprovementType, ResourceType, ResourceMakesValid, ResourceTrade)
SELECT  'IMPROVEMENT_LUMBERMILL_JUNGLE', 'RESOURCE_HARDWOOD', 1, 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_HARDWOOD');

/*
-- Improvement_ValidFeatures
INSERT INTO Improvement_ValidFeatures (ImprovementType, FeatureType)
SELECT  'IMPROVEMENT_LUMBERMILL', 'FEATURE_JUNGLE'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_HARDWOOD');
*/

--==================================================================================================================
-- Resources Boolean Tweaks
--==================================================================================================================

-- Resource_TerrainBooleans
INSERT  INTO Resource_TerrainBooleans (ResourceType, TerrainType)
SELECT  Type, 'TERRAIN_GRASS' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_PINEAPPLE', 'RESOURCE_POTATO' /*, 'RESOURCE_RICE'*/))
        AND Type IN ('RESOURCE_PINEAPPLE', 'RESOURCE_POTATO'/*, 'RESOURCE_RICE'*/) UNION ALL

SELECT  Type, 'TERRAIN_PLAINS' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_MAIZE', 'RESOURCE_POTATO'))
        AND Type IN ('RESOURCE_MAIZE', 'RESOURCE_POTATO') UNION ALL

SELECT  'RESOURCE_RUBBER', 'TERRAIN_TUNDRA'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_RUBBER') UNION ALL

SELECT  'RESOURCE_LEAD', 'TERRAIN_SNOW'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_LEAD') UNION ALL

SELECT  Type, 'TERRAIN_HILL' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_PLATINUM', 'RESOURCE_TIN'))
        AND Type IN ('RESOURCE_PLATINUM', 'RESOURCE_TIN');

-- Resource_FeatureBooleans
INSERT  INTO Resource_FeatureBooleans (ResourceType, FeatureType)
SELECT  Type, 'FEATURE_FLOOD_PLAINS' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_COCONUT', 'RESOURCE_LAVENDER',  /*'RESOURCE_MAIZE',*/ 'RESOURCE_PINEAPPLE', 'RESOURCE_POPPY', 'RESOURCE_POTATO' /*, 'RESOURCE_RICE'*/))
        AND Type IN ('RESOURCE_COCONUT', 'RESOURCE_LAVENDER',  /*'RESOURCE_MAIZE',*/ 'RESOURCE_PINEAPPLE', 'RESOURCE_POPPY', 'RESOURCE_POTATO' /*, 'RESOURCE_RICE'*/) UNION ALL

SELECT  Type, 'FEATURE_FOREST' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_PINEAPPLE', 'RESOURCE_RUBBER'))
        AND Type IN ('RESOURCE_PINEAPPLE', 'RESOURCE_RUBBER') UNION ALL

SELECT  Type, 'FEATURE_JUNGLE' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_LAVENDER', 'RESOURCE_PINEAPPLE', 'RESOURCE_POPPY'))
        AND Type IN ('RESOURCE_LAVENDER', 'RESOURCE_PINEAPPLE', 'RESOURCE_POPPY') UNION ALL

SELECT  Type, 'FEATURE_MARSH' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_COCONUT',  /*'RESOURCE_MAIZE',*/ 'RESOURCE_PINEAPPLE',  /*'RESOURCE_RICE',*/ 'RESOURCE_RUBBER', 'RESOURCE_SULFUR', 'RESOURCE_TITANIUM'))
        AND Type IN ('RESOURCE_COCONUT',  /*'RESOURCE_MAIZE',*/ 'RESOURCE_PINEAPPLE', /*'RESOURCE_RICE',*/ 'RESOURCE_RUBBER', 'RESOURCE_SULFUR', 'RESOURCE_TITANIUM');

--==================================================================================================================
-- If CBPMC - Medieval and Renaissance Bulding Pack mod by thecrazyscotsman also exists
--==================================================================================================================

-- Building_ResourceYieldChanges
INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_APOTHECARY', 'RESOURCE_POPPY', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_POPPY')
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'CBPMC_MEDIRENA' AND Value = 1) UNION ALL
SELECT  'BUILDING_APOTHECARY', Type, 'YIELD_GOLD', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_POPPY', 'RESOURCE_LAVENDER'))
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'CBPMC_MEDIRENA' AND Value = 1)
        AND Type IN('RESOURCE_POPPY', 'RESOURCE_LAVENDER');

--==================================================================================================================
-- If CBPMC - Industrial Bulding Pack mod by thecrazyscotsman also exists
--==================================================================================================================

-- Building_ResourceYieldChanges
INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_TCS_GROCER', Type, 'YIELD_GOLD', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_INDUSTRIAL') AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_PINEAPPLE', 'RESOURCE_POTATO'))
        AND Type IN ('RESOURCE_PINEAPPLE', 'RESOURCE_POTATO');

--==================================================================================================================
-- If Enlightenment Era for VP mod also exists
--==================================================================================================================

-- EE_TAVERN
DELETE  FROM Building_ResourceYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_TAVERN')
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_MAIZE', 'RESOURCE_RICE'))
        AND ResourceType IN ('RESOURCE_MAIZE', 'RESOURCE_RICE')
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_GROCER');

-- Compatibility with other mod
CREATE TRIGGER TTO_TAVERNRIZE
AFTER INSERT ON Civilization_BuildingClassOverrides
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
AND EXISTS (SELECT * FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_EE_TAVERN')
AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_MAIZE', 'RESOURCE_RICE'))
AND NEW.BuildingClassType
    IN(
        SELECT  DISTINCT b.BuildingClass
                FROM Buildings b, Resources r, Building_ResourceYieldChanges ryc
                WHERE r.Type IN ('RESOURCE_MAIZE', 'RESOURCE_RICE')
                AND ryc.ResourceType = r.Type
                AND b.Type = ryc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
        DELETE  FROM Building_ResourceYieldChanges
                WHERE ResourceType IN ('RESOURCE_MAIZE', 'RESOURCE_RICE')
                AND BuildingType = NEW.BuildingType
                AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_GROCER');
END;