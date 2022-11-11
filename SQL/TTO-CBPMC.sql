--==================================================================================================================
--==================================================================================================================
-- If CBPMC mod by Techpriest Enginseer and Building Packs by thecrazyscotsman exists
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
-- Resource Tweaks
--==================================================================================================================

-- Building_ResourceYieldChanges
INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_APOTHECARY', 'RESOURCE_INCENSE', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_MEDIRENA') AND Value = 1)
        AND Type IN ('YIELD_FOOD', 'YIELD_GOLD');

UPDATE  Building_ResourceYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_MEDIRENA') AND Value = 1)
        AND ResourceType = 'RESOURCE_GOLD'
        AND YieldType = 'YIELD_GOLD'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');

DELETE  FROM Building_ResourceYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_MEDIRENA') AND Value = 1)
        AND ResourceType = 'RESOURCE_GEMS'
        AND YieldType = 'YIELD_CULTURE'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');

DELETE  FROM Building_ResourceYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_MEDIRENA') AND Value = 1)
        AND ResourceType = 'RESOURCE_SILVER'
        AND YieldType = 'YIELD_GOLD'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');

-- Compatibility with other mod
CREATE TRIGGER TTO_CPBMC_ALCHEMIST
AFTER INSERT ON Civilization_BuildingClassOverrides
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_MEDIRENA') AND Value = 1)
AND NEW.BuildingClassType
    IN(
        SELECT DISTINCT b.BuildingClass
        FROM Buildings b, Resources r, Building_ResourceYieldChanges ryc
        WHERE r.Type IN ('RESOURCE_GEMS', 'RESOURCE_GOLD', 'RESOURCE_SILVER')
        AND ryc.ResourceType = r.Type
        AND b.Type = ryc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
        UPDATE  Building_ResourceYieldChanges SET Yield = '1'
                WHERE ResourceType = 'RESOURCE_GOLD'
                AND YieldType = 'YIELD_GOLD'
                AND BuildingType = NEW.BuildingType
                AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');

        DELETE  FROM Building_ResourceYieldChanges
                WHERE ResourceType = 'RESOURCE_GEMS'
                AND YieldType = 'YIELD_CULTURE'
                AND BuildingType = NEW.BuildingType
                AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');

        DELETE  FROM Building_ResourceYieldChanges
                WHERE ResourceType = 'RESOURCE_SILVER'
                AND YieldType = 'YIELD_GOLD'
                AND BuildingType = NEW.BuildingType
                AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_BANK');
END;

INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_TCS_GROCER', Type, 'YIELD_GOLD', 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_INDUSTRIAL') AND Value = 1)
        AND Type IN ('RESOURCE_CLOVES', 'RESOURCE_COCOA', 'RESOURCE_NUTMEG', 'RESOURCE_PEPPER', 'RESOURCE_SPICES', 'RESOURCE_SUGAR', 'RESOURCE_WINE');

INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_TEXTILE_MILL', 'RESOURCE_FUR', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_INDUSTRIAL') AND Value = 1)
        AND Type IN ('YIELD_GOLD', 'YIELD_CULTURE');

UPDATE  Building_ResourceYieldChanges SET Yield = 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_INDUSTRIAL') AND Value = 1)
        AND ResourceType IN ('RESOURCE_COTTON', 'RESOURCE_SILK')
        AND BuildingType = 'BUILDING_TEXTILE_MILL';

UPDATE  Building_ResourceYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_INDUSTRIAL') AND Value = 1)
        AND YieldType IN ('YIELD_FOOD', 'YIELD_PRODUCTION')
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_STABLE');
/*
UPDATE  Building_ResourceYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_INDUSTRIAL') AND Value = 1)
        AND ResourceType = 'RESOURCE_HORSE'
        AND YieldType = 'YIELD_PRODUCTION'
        AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_STABLE');
*/
DELETE  FROM Building_ResourceYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_INDUSTRIAL') AND Value = 1)
        AND YieldType = 'YIELD_GOLD'
        AND BuildingType = 'BUILDING_RANCH'
        AND ResourceType NOT IN ('RESOURCE_COW', 'RESOURCE_HORSE');
/*
INSERT INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_RACING_COURSE', 'RESOURCE_HORSE', 'YIELD_PRODUCTION', -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_STRATEGIC') AND Value = 1);
*/
UPDATE  Building_ResourceYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_STRATEGIC') AND Value = 1)
        AND ResourceType = 'RESOURCE_IRON'
        AND YieldType = 'YIELD_PRODUCTION'
        AND BuildingType = 'BUILDING_STEELMILL';

-- Compatibility with other mod
CREATE TRIGGER TTO_CPBMC
AFTER INSERT ON Civilization_BuildingClassOverrides
WHEN EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_INDUSTRIAL') AND Value = 1)
AND NEW.BuildingClassType
    IN(
        SELECT DISTINCT b.BuildingClass
        FROM Buildings b, Building_ResourceYieldChanges ryc
        WHERE b.Type = ryc.BuildingType
    )
AND NEW.BuildingType IS NOT NULL
BEGIN
        UPDATE  Building_ResourceYieldChanges SET Yield = '1'
                WHERE YieldType IN ('YIELD_FOOD', 'YIELD_PRODUCTION')
                AND BuildingType = NEW.BuildingType
                AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_STABLE');
        
        UPDATE  Building_ResourceYieldChanges SET Yield = '2'
                WHERE ResourceType = 'RESOURCE_HORSE'
                AND YieldType = 'YIELD_PRODUCTION'
                AND BuildingType = NEW.BuildingType
                AND BuildingType IN (SELECT Type FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_STABLE');
END;

-- Building_LocalResourceOrs
INSERT INTO Building_LocalResourceOrs (BuildingType, ResourceType)
SELECT  'BUILDING_TEXTILE_MILL', Type FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_INDUSTRIAL') AND Value = 1)
        AND Type IN('RESOURCE_DYE', 'RESOURCE_FUR');

-- Building_ResourceQuantityRequirements
UPDATE  Building_ResourceQuantityRequirements SET Cost = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_STRATEGIC') AND Value = 1)
        AND ResourceType = 'RESOURCE_HORSE'
        AND BuildingType = 'BUILDING_RACING_COURSE';
        
UPDATE  Building_ResourceQuantityRequirements SET Cost = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_STRATEGIC') AND Value = 1)
        AND ResourceType = 'RESOURCE_IRON'
        AND BuildingType = 'BUILDING_STEELMILL';

--==================================================================================================================
-- Building Tweaks
--==================================================================================================================

UPDATE  BuildingClasses SET MaxPlayerInstances = '-1'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_BLD_MT', 'CBPMC_INDUSTRIAL') AND Value = 1)
        AND Type = 'BUILDINGCLASS_INDUSTRIAL_MINE';

DELETE  FROM Building_TerrainYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_BLD_MT', 'CBPMC_INDUSTRIAL') AND Value = 1)
        AND BuildingType = 'BUILDING_INDUSTRIAL_MINE';

INSERT  INTO Building_YieldPerXTerrainTimes100 (BuildingType, TerrainType, YieldType, Yield)
SELECT	'BUILDING_INDUSTRIAL_MINE', 'TERRAIN_MOUNTAIN', 'YIELD_PRODUCTION', 100
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_BLD_MT', 'CBPMC_INDUSTRIAL') AND Value = 1);

UPDATE  Building_YieldPerXTerrainTimes100 SET Yield = 300
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_BLD_MT', 'CBPMC_INDUSTRIAL') AND Value = 1)
        AND BuildingType = 'BUILDING_BOMB_SHELTER'
        AND YieldType = 'YIELD_PRODUCTION';

--==================================================================================================================
-- Resources Tweak for Additional Industrial Buildings
--==================================================================================================================

DELETE  FROM Building_ResourceYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_RESOURCES', 'CBPMC_MOREINDUSTRIAL') AND Value = 1)
        AND BuildingType IN ('BUILDING_OIL_REFINERY', 'BUILDING_SYNTHFUEL_PLANT', 'BUILDING_WEAPONS_FACTORY', 'BUILDING_MUNITIONS_FACTORY');