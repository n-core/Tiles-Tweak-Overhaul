--==================================================================================================================
--==================================================================================================================
--  RESOURCE TWEAKS
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
--  A Lot of adjustments to all the things that affect yields of a resource.
--==================================================================================================================

-- Resource_YieldChanges
INSERT  INTO Resource_YieldChanges (ResourceType, YieldType, Yield)
SELECT  'RESOURCE_SALT', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1) UNION ALL

SELECT  Type, 'YIELD_PRODUCTION', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND Type IN ('RESOURCE_CLOVES', 'RESOURCE_FUR', 'RESOURCE_SILVER', 'RESOURCE_SPICES') UNION ALL

SELECT  Type, 'YIELD_GOLD', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND Type IN ('RESOURCE_COAL', 'RESOURCE_MARBLE', 'RESOURCE_OIL') UNION ALL

SELECT  'RESOURCE_DYE', 'YIELD_CULTURE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1) UNION ALL

SELECT  'RESOURCE_ALUMINUM', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1);

UPDATE  Resource_YieldChanges SET Yield = 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ResourceType IN ('RESOURCE_COPPER', 'RESOURCE_IVORY')
        AND YieldType = 'YIELD_PRODUCTION';

UPDATE  Resource_YieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ResourceType = 'RESOURCE_CORAL'
        AND YieldType = 'YIELD_GOLD';

UPDATE  Resource_YieldChanges SET Yield = 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ResourceType = 'RESOURCE_GEMS'
        AND YieldType = 'YIELD_GOLD';

INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_FACTORY', Type, 'YIELD_GOLD', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND Type IN ('RESOURCE_STONE', 'RESOURCE_COAL') UNION ALL

SELECT  'BUILDING_FACTORY', 'RESOURCE_COPPER', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1) UNION ALL

SELECT  'BUILDING_GROCER', Type, 'YIELD_FOOD', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND Type IN ('RESOURCE_WHEAT', 'RESOURCE_CITRUS', 'RESOURCE_CLOVES', 'RESOURCE_SPICES', 'RESOURCE_SUGAR') UNION ALL

SELECT  'BUILDING_GROCER', Type, 'YIELD_GOLD', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND Type IN ('RESOURCE_COCOA', 'RESOURCE_NUTMEG', 'RESOURCE_PEPPER', 'RESOURCE_SALT') UNION ALL

SELECT  'BUILDING_MUSEUM', 'RESOURCE_MARBLE', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND Type IN ('YIELD_CULTURE', 'YIELD_GOLD');

UPDATE  Building_ResourceYieldChanges SET Yield = 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ResourceType = 'RESOURCE_ALUMINUM'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_LABORATORY');

UPDATE  Building_ResourceYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ResourceType = 'RESOURCE_COPPER'
        AND YieldType = 'YIELD_GOLD'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_FORGE');

UPDATE  Building_ResourceYieldChanges SET Yield = 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ResourceType = 'RESOURCE_GEMS'
        AND YieldType = 'YIELD_GOLD'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');

UPDATE  Building_ResourceYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ResourceType = 'RESOURCE_GEMS'
        AND YieldType = 'YIELD_CULTURE'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');

UPDATE  Building_ResourceYieldChanges SET Yield = 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ResourceType = 'RESOURCE_GOLD'
        AND YieldType = 'YIELD_GOLD'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');

DELETE  FROM Building_ResourceYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ResourceType = 'RESOURCE_IRON'
        AND YieldType = 'YIELD_GOLD'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_FORGE');

DELETE  FROM Building_ResourceYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ResourceType = 'RESOURCE_SILVER'
        AND YieldType = 'YIELD_CULTURE'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');

-- Unique buildings
INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  DISTINCT bco.BuildingType, r.Type, 'YIELD_GOLD', 1 
        FROM Buildings b, Resources r, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND r.Type IN ( 'RESOURCE_STONE', 'RESOURCE_COAL')
        AND ryc.ResourceType = r.Type
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_FACTORY'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT  DISTINCT bco.BuildingType, 'RESOURCE_COPPER', 'YIELD_PRODUCTION', 1 
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ryc.ResourceType = 'RESOURCE_COPPER'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_FACTORY'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT  DISTINCT bco.BuildingType, r.Type, 'YIELD_FOOD', 1
        FROM Buildings b, Resources r, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND r.Type IN ('RESOURCE_WHEAT', 'RESOURCE_CITRUS', 'RESOURCE_CLOVES', 'RESOURCE_SPICES', 'RESOURCE_SUGAR')
        AND ryc.ResourceType = r.Type
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_GROCER'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT  DISTINCT bco.BuildingType, r.Type, 'YIELD_GOLD', 1
        FROM Buildings b, Resources r, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND r.Type IN ('RESOURCE_COCOA', 'RESOURCE_NUTMEG', 'RESOURCE_PEPPER', 'RESOURCE_SALT')
        AND ryc.ResourceType = r.Type
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_GROCER'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT  DISTINCT bco.BuildingType, 'RESOURCE_MARBLE', y.Type, 1
        FROM Buildings b, Yields y, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND y.Type IN ('YIELD_CULTURE', 'YIELD_GOLD')
        AND ryc.ResourceType = 'RESOURCE_MARBLE'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_MUSEUM'
        AND bco.BuildingType IS NOT NULL;

-- Compatibility
CREATE TRIGGER TTO_NEWCustomBuildingRYC
AFTER INSERT ON Civilization_BuildingClassOverrides 
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
AND NEW.BuildingClassType
    IN(
    SELECT  DISTINCT b.BuildingClass
            FROM Buildings b, Resources r, Building_ResourceYieldChanges ryc
            WHERE r.Type IN ('RESOURCE_STONE', 'RESOURCE_WHEAT', 'RESOURCE_CITRUS', 'RESOURCE_CLOVES', 'RESOURCE_COCOA', 'RESOURCE_COPPER','RESOURCE_NUTMEG', 'RESOURCE_PEPPER', 'RESOURCE_SALT', 'RESOURCE_SPICES', 'RESOURCE_SUGAR', 'RESOURCE_ALUMINUM', 'RESOURCE_COAL', 'RESOURCE_IRON')
            AND ryc.ResourceType = r.Type
            AND b.Type = ryc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
    INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
    SELECT  DISTINCT NEW.BuildingType, r.Type, 'YIELD_GOLD', 1 
            FROM Resources r, Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE r.Type IN ('RESOURCE_STONE', 'RESOURCE_COAL')
            AND ryc.ResourceType = r.Type
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_COPPER', y.Type, 1
            FROM Yields y, Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE y.Type = 'YIELD_PRODUCTION'
            AND ryc.ResourceType = 'RESOURCE_COPPER'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, r.Type, 'YIELD_FOOD', 1
            FROM Resources r, Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE r.Type IN ('RESOURCE_WHEAT', 'RESOURCE_CITRUS', 'RESOURCE_CLOVES', 'RESOURCE_SPICES', 'RESOURCE_SUGAR')
            AND ryc.ResourceType = r.Type
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, r.Type, 'YIELD_GOLD', 1
            FROM Resources r, Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE r.Type IN ('RESOURCE_COCOA', 'RESOURCE_NUTMEG', 'RESOURCE_PEPPER', 'RESOURCE_SALT')
            AND ryc.ResourceType = r.Type
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_MARBLE', y.Type, 1
            FROM Yields y, Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE y.Type IN ('YIELD_CULTURE', 'YIELD_GOLD')
            AND ryc.ResourceType = 'RESOURCE_MARBLE'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding;

    UPDATE  Building_ResourceYieldChanges SET Yield = 2
            WHERE ResourceType = 'RESOURCE_ALUMINUM'
            AND YieldType = 'YIELD_SCIENCE'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_LABORATORY');

    UPDATE  Building_ResourceYieldChanges SET Yield = 2
            WHERE ResourceType = 'RESOURCE_GEMS'
            AND YieldType = 'YIELD_GOLD'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');

    UPDATE  Building_ResourceYieldChanges SET Yield = 1
            WHERE ResourceType = 'RESOURCE_GEMS'
            AND YieldType = 'YIELD_CULTURE'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');

    UPDATE  Building_ResourceYieldChanges SET Yield = 2
            WHERE ResourceType = 'RESOURCE_GOLD'
            AND YieldType = 'YIELD_GOLD'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');

    DELETE  FROM Building_ResourceYieldChanges
            WHERE ResourceType = 'RESOURCE_IRON'
            AND YieldType = 'YIELD_GOLD'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_FORGE');

    DELETE  FROM Building_ResourceYieldChanges
            WHERE ResourceType = 'RESOURCE_SILVER'
            AND YieldType = 'YIELD_CULTURE'
            AND BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');
END;

-- Building_SeaResourceYieldChanges
UPDATE  Building_SeaResourceYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_SEAPORT');

CREATE TRIGGER TTO_NEWSeaResourceRYC
AFTER INSERT ON Civilization_BuildingClassOverrides 
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
AND NEW.BuildingClassType
    IN(
    SELECT  DISTINCT b.BuildingClass
            FROM Buildings b, Resources r, Building_SeaResourceYieldChanges sryc
            WHERE b.Type = sryc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
    UPDATE  Building_SeaResourceYieldChanges SET Yield = 1
            WHERE BuildingType = NEW.BuildingType
            AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_SEAPORT');
END;

-- Improvement_ResourceType_Yields
INSERT  INTO Improvement_ResourceType_Yields (ImprovementType, ResourceType, YieldType, Yield)
SELECT	'IMPROVEMENT_CAMP', 'RESOURCE_DEER', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1) UNION ALL
SELECT	'IMPROVEMENT_PLANTATION', Type, 'YIELD_GOLD', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND Type IN ('RESOURCE_CLOVES', 'RESOURCE_NUTMEG');
/*
UPDATE  Improvement_ResourceType_Yields SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_PASTURE'
        AND ResourceType = 'RESOURCE_COW';
*/
UPDATE  Improvement_ResourceType_Yields SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_PASTURE'
        AND ResourceType = 'RESOURCE_SHEEP';

UPDATE  Improvement_ResourceType_Yields SET Yield = 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_PLANTATION'
        AND ResourceType = 'RESOURCE_BANANA'
        AND YieldType = 'YIELD_FOOD';

UPDATE  Improvement_ResourceType_Yields SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_PLANTATION'
        AND ResourceType = 'RESOURCE_COTTON'
        AND YieldType = 'YIELD_GOLD';
/*
UPDATE  Improvement_ResourceType_Yields SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_FISHING_BOATS'
        AND ResourceType = 'RESOURCE_CRAB'
        AND YieldType = 'YIELD_PRODUCTION';
*/
UPDATE  Improvement_ResourceType_Yields SET Yield = 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_FISHING_BOATS'
        AND ResourceType = 'RESOURCE_CORAL'
        AND YieldType = 'YIELD_GOLD';

UPDATE  Improvement_ResourceType_Yields SET Yield = 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_PLANTATION'
        AND ResourceType = 'RESOURCE_SILK';

UPDATE  Improvement_ResourceType_Yields SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_MINE'
        AND ResourceType = 'RESOURCE_SILVER';
/*
DELETE  FROM Improvement_ResourceType_Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_FISHING_BOATS'
        AND ResourceType = 'RESOURCE_FISH'
        AND YieldType = 'YIELD_PRODUCTION';
*/
DELETE  FROM Improvement_ResourceType_Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_MINE'
        AND ResourceType = 'RESOURCE_GEMS'
        AND YieldType = 'YIELD_PRODUCTION';

--==================================================================================================================
--  Strategic Resource Tweaks
--==================================================================================================================

INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_AIRPORT', 'RESOURCE_OIL', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1) UNION ALL
SELECT  'BUILDING_AIRPORT', 'RESOURCE_OIL', 'YIELD_PRODUCTION', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1) UNION ALL

SELECT  'BUILDING_HYDRO_PLANT', 'RESOURCE_IRON', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1) UNION ALL
SELECT  'BUILDING_HYDRO_PLANT', 'RESOURCE_IRON', 'YIELD_PRODUCTION', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1) UNION ALL

SELECT  'BUILDING_NUCLEAR_PLANT', 'RESOURCE_URANIUM', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1) UNION ALL
SELECT  'BUILDING_NUCLEAR_PLANT', 'RESOURCE_URANIUM', 'YIELD_SCIENCE', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1) UNION ALL

SELECT  'BUILDING_SOLAR_PLANT', 'RESOURCE_ALUMINUM', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1) UNION ALL
SELECT  'BUILDING_SOLAR_PLANT', 'RESOURCE_ALUMINUM', 'YIELD_PRODUCTION', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1) UNION ALL

SELECT  'BUILDING_WIND_PLANT', 'RESOURCE_COAL', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1) UNION ALL
SELECT  'BUILDING_WIND_PLANT', 'RESOURCE_COAL', 'YIELD_PRODUCTION', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1);

-- Just in case someone added unique buildings for these
INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  DISTINCT bco.BuildingType, 'RESOURCE_OIL', 'YIELD_GOLD', 1
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1)
        AND ryc.ResourceType = 'RESOURCE_OIL'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_AIRPORT'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT  DISTINCT bco.BuildingType, 'RESOURCE_OIL', 'YIELD_PRODUCTION', -1
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1)
        AND ryc.ResourceType = 'RESOURCE_OIL'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_AIRPORT'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT  DISTINCT bco.BuildingType, 'RESOURCE_IRON', 'YIELD_GOLD', 1
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1)
        AND ryc.ResourceType = 'RESOURCE_IRON'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_HYDRO_PLANT'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT  DISTINCT bco.BuildingType, 'RESOURCE_IRON', 'YIELD_PRODUCTION', -1
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1)
        AND ryc.ResourceType = 'RESOURCE_IRON'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_HYDRO_PLANT'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT  DISTINCT bco.BuildingType, 'RESOURCE_URANIUM', 'YIELD_GOLD', 1
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1)
        AND ryc.ResourceType = 'RESOURCE_URANIUM'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_NUCLEAR_PLANT'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT  DISTINCT bco.BuildingType, 'RESOURCE_URANIUM', 'YIELD_PRODUCTION', -1
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1)
        AND ryc.ResourceType = 'RESOURCE_URANIUM'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_NUCLEAR_PLANT'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT  DISTINCT bco.BuildingType, 'RESOURCE_ALUMINUM', 'YIELD_GOLD', 1
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1)
        AND ryc.ResourceType = 'RESOURCE_ALUMINUM'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_SOLAR_PLANT'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT  DISTINCT bco.BuildingType, 'RESOURCE_ALUMINUM', 'YIELD_PRODUCTION', -1
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1)
        AND ryc.ResourceType = 'RESOURCE_ALUMINUM'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_WIND_PLANT'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT  DISTINCT bco.BuildingType, 'RESOURCE_COAL', 'YIELD_GOLD', 1
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1)
        AND ryc.ResourceType = 'RESOURCE_COAL'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_SOLAR_PLANT'
        AND bco.BuildingType IS NOT NULL UNION ALL

SELECT  DISTINCT bco.BuildingType, 'RESOURCE_COAL', 'YIELD_PRODUCTION', -1
        FROM Buildings b, Civilization_BuildingClassOverrides bco, Building_ResourceYieldChanges ryc
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1)
        AND ryc.ResourceType = 'RESOURCE_COAL'
        AND b.Type = ryc.BuildingType
        AND bco.BuildingClassType = 'BUILDINGCLASS_WIND_PLANT'
        AND bco.BuildingType IS NOT NULL;

-- Compatibility
CREATE TRIGGER TTO_NEWStrategicRYC
AFTER INSERT ON Civilization_BuildingClassOverrides 
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_STRATEGICRES' AND Value = 1)
AND NEW.BuildingClassType
    IN(
    SELECT  DISTINCT b.BuildingClass
            FROM Buildings b, Resources r, Building_ResourceYieldChanges ryc
            WHERE r.Type IN ('RESOURCE_ALUMINUM', 'RESOURCE_COAL', 'RESOURCE_IRON', 'RESOURCE_OIL', 'RESOURCE_URANIUM')
            AND ryc.ResourceType = r.Type
            AND b.Type = ryc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
    INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_OIL', 'YIELD_GOLD', 1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_OIL'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_OIL', 'YIELD_PRODUCTION', -1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_OIL'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_IRON', 'YIELD_GOLD', 1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_IRON'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_IRON', 'YIELD_PRODUCTION', -1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_IRON'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_URANIUM', 'YIELD_GOLD', 1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_URANIUM'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_URANIUM', 'YIELD_PRODUCTION', -1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_URANIUM'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_ALUMINUM', 'YIELD_GOLD', 1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_ALUMINUM'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_ALUMINUM', 'YIELD_PRODUCTION', -1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_ALUMINUM'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_COAL', 'YIELD_GOLD', 1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_COAL'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding UNION ALL

    SELECT  DISTINCT NEW.BuildingType, 'RESOURCE_COAL', 'YIELD_PRODUCTION', -1
            FROM Building_ResourceYieldChanges ryc, BuildingClasses bc
            WHERE ryc.ResourceType = 'RESOURCE_COAL'
            AND bc.Type = NEW.BuildingClassType
            AND ryc.BuildingType = bc.DefaultBuilding;
END;

--==================================================================================================================
-- Resource Boolean Tweaks
--==================================================================================================================

-- Resource_TerrainBooleans
INSERT  INTO Resource_TerrainBooleans (ResourceType, TerrainType)
SELECT  Type, 'TERRAIN_GRASS' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND Type IN ('RESOURCE_ALUMINUM', 'RESOURCE_COCOA', 'RESOURCE_FUR', 'RESOURCE_IVORY', 'RESOURCE_SILK', 'RESOURCE_SUGAR') UNION ALL
SELECT  Type, 'TERRAIN_PLAINS' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND Type IN ('RESOURCE_COCOA', 'RESOURCE_COW', 'RESOURCE_DEER', 'RESOURCE_DYE', 'RESOURCE_FUR', 'RESOURCE_SILK', 'RESOURCE_SPICES') UNION ALL
SELECT  Type, 'TERRAIN_DESERT' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND Type IN ('RESOURCE_BISON', 'RESOURCE_HORSE', 'RESOURCE_WHEAT') UNION ALL
SELECT  Type, 'TERRAIN_TUNDRA' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND Type IN ('RESOURCE_BISON', 'RESOURCE_COAL', 'RESOURCE_SHEEP') UNION ALL
SELECT  Type, 'TERRAIN_SNOW' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND Type IN ('RESOURCE_ALUMINUM', 'RESOURCE_BISON', 'RESOURCE_COAL', 'RESOURCE_GOLD', 'RESOURCE_MARBLE', 'RESOURCE_SHEEP', 'RESOURCE_SILVER') UNION ALL
SELECT  'RESOURCE_COAL', 'TERRAIN_HILL';

-- Resource_FeatureBooleans
INSERT  INTO Resource_FeatureBooleans (ResourceType, FeatureType)
SELECT  Type, 'FEATURE_FLOOD_PLAINS' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND Type IN ('RESOURCE_BISON', 'RESOURCE_CITRUS', 'RESOURCE_COTTON', 'RESOURCE_COW', 'RESOURCE_HORSE', 'RESOURCE_OIL', 'RESOURCE_SPICES', 'RESOURCE_URANIUM', 'RESOURCE_WINE') UNION ALL
SELECT  Type, 'FEATURE_FOREST' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND Type IN ('RESOURCE_COCOA', 'RESOURCE_COPPER', 'RESOURCE_GEMS', 'RESOURCE_GOLD', 'RESOURCE_SILVER', 'RESOURCE_SPICES', 'RESOURCE_WINE') UNION ALL
SELECT  Type, 'FEATURE_JUNGLE' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND Type IN ('RESOURCE_COPPER', 'RESOURCE_GOLD', 'RESOURCE_SILK', 'RESOURCE_SILVER', 'RESOURCE_WINE') UNION ALL
SELECT  Type, 'FEATURE_MARSH' FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RES_BOOL' AND Value = 1)
        AND Type IN ('RESOURCE_BISON', 'RESOURCE_DEER', 'RESOURCE_DYE', 'RESOURCE_FUR', 'RESOURCE_HORSE', 'RESOURCE_SALT', 'RESOURCE_WINE');
