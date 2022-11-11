--==================================================================================================================
--==================================================================================================================
-- If Better Lakes for VP by InkAxis mod exists
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
-- Improvement Tweaks
--==================================================================================================================
/*
DELETE  FROM Improvement_ResourceTypes
        WHERE ImprovementType = 'IMPROVEMENT_IA_LAKE_FISHING_BOATS'
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_IA_LAKE_FISHING_BOATS');

-- Improvement_ResourceTypes
INSERT  INTO Improvement_ResourceTypes
        (ImprovementType, ResourceType, ResourceMakesValid, ResourceTrade)
SELECT  'IMPROVEMENT_IA_LAKE_FISHING_BOATS', Type, 1, 1 FROM Improvements
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_IA_LAKE_FISHING_BOATS')
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_IA_LAKE_FISH', 'RESOURCE_IA_SALT_LAKE'))
        AND Type IN ('RESOURCE_IA_LAKE_FISH', 'RESOURCE_IA_SALT_LAKE');

-- Improvement_ResourceType_Yields
INSERT  INTO Improvement_ResourceType_Yields (ImprovementType, ResourceType, YieldType, Yield)
SELECT  'IMPROVEMENT_IA_LAKE_FISHING_BOATS', 'RESOURCE_IA_SALT_LAKE', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_IA_LAKE_FISHING_BOATS')
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_IA_SALT_LAKE')
        AND Type IN ('YIELD_PRODUCTION', 'YIELD_FOOD');
*/
UPDATE  Improvements SET DestroyedWhenPillaged = 1, PillageGold = 15
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_IA_LAKE_FISHING_BOATS')
        AND Type = 'IMPROVEMENT_IA_LAKE_FISHING_BOATS';

-- Improvement_ResourceTypes
INSERT  INTO Improvement_ResourceTypes (ImprovementType, ResourceType, ResourceMakesValid, ResourceTrade)
SELECT  'IMPROVEMENT_MINING_PLATFORM', 'RESOURCE_IA_SALT_LAKE', 1, 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_IA_SALT_LAKE');

UPDATE  Improvement_ResourceTypes SET ResourceTrade = 0
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_IA_SALT_LAKE')
        AND ImprovementType = 'IMPROVEMENT_IA_LAKE_FISHING_BOATS'
        AND ResourceType = 'RESOURCE_IA_SALT_LAKE';

-- Improvement_ResourceType_Yields
INSERT  INTO Improvement_ResourceType_Yields (ImprovementType, ResourceType, YieldType, Yield)
SELECT  'IMPROVEMENT_MINING_PLATFORM', 'RESOURCE_IA_SALT_LAKE', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_IA_SALT_LAKE')
        AND Type IN ('YIELD_PRODUCTION', 'YIELD_SCIENCE');
/*
-- Trait_ImprovementYieldChanges
INSERT  INTO Trait_ImprovementYieldChanges (TraitType, ImprovementType, YieldType, Yield)
SELECT  'TRAIT_WAYFINDING', 'IMPROVEMENT_IA_LAKE_FISHING_BOATS', 'YIELD_FOOD', '2'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_WAYFINDING' AND Value = 1);
*/
-- Trait_BuildsUnitClasses
INSERT  INTO Trait_BuildsUnitClasses (TraitType, UnitClassType, BuildType)
SELECT  'TRAIT_WAYFINDING', Type, 'BUILD_IA_LAKE_FISHBOAT' FROM UnitClasses
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_WAYFINDING' AND Value = 1)
        AND Type IN (SELECT DISTINCT Class FROM Units WHERE CombatClass = 'UNITCOMBAT_NAVALMELEE');

--==================================================================================================================
-- -- Dummy Building Fix For Aquamining Network
--      
--    Aquamining Network reduces -4 Production for resources on water tiles.
--    So it would subtract the additional +5 Production on sea tiles.
--    It does make the building work as intended, +1 Production on sea tiles with resources and +4 Production elsewhere.
--
--    Yes, that means it includes Lake Fish and Salt Lake as well.
--    Sadly, they didn't get the +5 Production since the code only affects sea tiles, not lakes.
--    So, to fix this, we just make a dummy building to balance it out.
--==================================================================================================================

-- Building Classes
INSERT  INTO BuildingClasses (Type, DefaultBuilding, Description)
SELECT  'BUILDINGCLASS_OCEAN_MINING_DUMMY', 'BUILDING_OCEAN_MINING_DUMMY', 'TXT_KEY_BUILDING_OCEAN_MINING_DUMMY'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_IA_SALT_LAKE', 'RESOURCE_IA_LAKE_FISH'));

-- Building
INSERT  INTO Buildings (Type, BuildingClass, Description, CapitalOnly, GoldMaintenance, Cost, FaithCost, GreatWorkCount, NeverCapture, NukeImmune, ConquestProb, HurryCostModifier, IconAtlas, PortraitIndex, IsDummy)
SELECT  'BUILDING_OCEAN_MINING_DUMMY',
        'BUILDINGCLASS_OCEAN_MINING_DUMMY',
        'TXT_KEY_BUILDING_OCEAN_MINING_DUMMY',
	0,
        0,
        -1,
        -1,
        -1,
        1,
        1,
        0,
        -1,
        'WTEMOD_ICON_ATLAS',
        0,
        1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_IA_SALT_LAKE', 'RESOURCE_IA_LAKE_FISH'));

-- Building_ResourceYieldChanges
INSERT  INTO Building_ResourceYieldChanges (BuildingType, ResourceType, YieldType, Yield)
SELECT  'BUILDING_OCEAN_MINING_DUMMY', 'RESOURCE_IA_SALT_LAKE', 'YIELD_PRODUCTION', 4
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_IA_SALT_LAKE') UNION ALL

SELECT  'BUILDING_OCEAN_MINING_DUMMY', 'RESOURCE_IA_LAKE_FISH',	'YIELD_PRODUCTION', 4
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_IA_LAKE_FISH');

-- Text
INSERT OR REPLACE INTO Language_en_US (Tag, Text)
SELECT  'TXT_KEY_BUILDING_OCEAN_MINING_DUMMY', 'Aquamining Network Dummy'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_IA_SALT_LAKE', 'RESOURCE_IA_LAKE_FISH'));

UPDATE  Buildings SET FreeBuildingThisCity = 'TXT_KEY_BUILDING_OCEAN_MINING_DUMMY'
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_AQUAMINING' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type IN ('RESOURCE_IA_SALT_LAKE', 'RESOURCE_IA_LAKE_FISH'))
        AND BuildingClass = 'BUILDINGCLASS_OCEAN_MINING';

--==================================================================================================================
-- -- BUILDING_IA_SEAPORT_DUMMY Fix
--      
--    This mod reduces Seaport's Building_SeaResourceYieldChanges to +1 instead of +2.
--    So this change should fix that.
--==================================================================================================================

UPDATE  Building_ResourceYieldChanges SET Yield = -1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Buildings WHERE Type = 'BUILDING_IA_SEAPORT_DUMMY')
        AND BuildingType = 'BUILDING_IA_SEAPORT_DUMMY';

--==================================================================================================================
-- If More Unit Components for VP mod exists
-- Make Kampong Improvement from MUCfVP buildable on Salt Lake and Fish Lake resource
--==================================================================================================================

-- Improvement_ResourceTypes
INSERT  INTO Improvement_ResourceTypes (ImprovementType, ResourceType, ResourceMakesValid, ResourceTrade)
SELECT  'IMPROVEMENT_INDONESIA_KAMPONG', Type, 1, 1 FROM Resources
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements  WHERE Type = 'IMPROVEMENT_INDONESIA_KAMPONG')
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_IA_SALT_LAKE')
        AND Type IN ('RESOURCE_IA_SALT_LAKE', 'RESOURCE_IA_LAKE_FISH');

-- Improvement_ResourceType_Yields
INSERT INTO Improvement_ResourceType_Yields (ImprovementType, ResourceType, YieldType, Yield)
SELECT  'IMPROVEMENT_INDONESIA_KAMPONG', 'RESOURCE_IA_SALT_LAKE', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_IA_SALT_LAKE')
        AND Type IN ('YIELD_FOOD', 'YIELD_GOLD') UNION ALL
SELECT  'IMPROVEMENT_INDONESIA_KAMPONG', 'RESOURCE_IA_LAKE_FISH', 'YIELD_FOOD', 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_IA_LAKE_FISH');

-- Improvement_AdjacentImprovementYieldChanges
INSERT INTO Improvement_AdjacentImprovementYieldChanges (ImprovementType, OtherImprovementType, YieldType, Yield)
SELECT  'IMPROVEMENT_INDONESIA_KAMPONG', 'IMPROVEMENT_IA_LAKE_FISHING_BOATS', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_INDONESIA_KAMPONG') UNION ALL

SELECT  'IMPROVEMENT_CELTS_OPPIDUM', 'IMPROVEMENT_IA_LAKE_FISHING_BOATS', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_CELTS_OPPIDUM')
        AND Type IN ('YIELD_GOLD', 'YIELD_FAITH');

--==================================================================================================================
-- Make Pontoon Bridge buildable on Salt Lake resource
--==================================================================================================================

-- Improvement_ResourceTypes
INSERT INTO Improvement_ResourceTypes (ImprovementType, ResourceType, ResourceMakesValid, ResourceTrade)
SELECT  'IMPROVEMENT_PONTOON_BRIDGE', 'RESOURCE_IA_SALT_LAKE', 1, 0
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements  WHERE Type = 'IMPROVEMENT_PONTOON_BRIDGE')
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_IA_SALT_LAKE');

-- Improvement_ResourceType_Yields
INSERT  INTO Improvement_ResourceType_Yields (ImprovementType, ResourceType, YieldType, Yield)
SELECT  'IMPROVEMENT_PONTOON_BRIDGE', 'RESOURCE_IA_SALT_LAKE', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_IA_SALT_LAKE')
        AND Type IN ('YIELD_PRODUCTION', 'YIELD_CULTURE_LOCAL');
