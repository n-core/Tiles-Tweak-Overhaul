--==================================================================================================================
--==================================================================================================================
--  Polynesia's Wayfinding Tweak
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
--  Improvement Tweaks
--==================================================================================================================

-- Trait_ImprovementYieldChanges
INSERT  INTO Trait_ImprovementYieldChanges (TraitType, ImprovementType, YieldType, Yield)
SELECT  'TRAIT_WAYFINDING', Type, 'YIELD_PRODUCTION', 1  FROM Improvements
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN('TTO_WAYFINDING', 'TTO_MININGPLATFORM') AND Value = 1)
        AND Type IN ('IMPROVEMENT_MINING_PLATFORM', 'IMPROVEMENT_OFFSHORE_PLATFORM');

/*
-- Trait_BuildsUnitClasses
INSERT  INTO Trait_BuildsUnitClasses (TraitType, UnitClassType, BuildType)
SELECT  'TRAIT_WAYFINDING', Type, 'BUILD_MINING_PLATFORM' FROM UnitClasses
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_WAYFINDING' AND Value = 1)
        AND Type IN ('UNITCLASS_DESTROYER', 'UNITCLASS_EARLY_DESTROYER', 'UNITCLASS_MISSILE_DESTROYER', 'UNITCLASS_ADVANCED_DESTROYER');
*/

-- Trait_BuildsUnitClasses
INSERT  INTO Trait_BuildsUnitClasses (TraitType, UnitClassType, BuildType)
SELECT  'TRAIT_WAYFINDING', Type, 'BUILD_MINING_PLATFORM' FROM UnitClasses
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_WAYFINDING' AND Value = 1)
        AND Type IN (SELECT DISTINCT Class FROM Units WHERE CombatClass = 'UNITCOMBAT_NAVALMELEE');

-- Trait_ImprovementYieldChanges
INSERT  INTO Trait_ImprovementYieldChanges (TraitType, ImprovementType, YieldType, Yield)
SELECT  'TRAIT_WAYFINDING', 'IMPROVEMENT_PONTOON_BRIDGE', Type, 1 FROM Yields
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_PONTOON_BRIDGE')
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_WAYFINDING' AND Value = 1)
        AND Type IN ('YIELD_FOOD', 'YIELD_GOLD');

--==================================================================================================================
--  Atoll Feature Tweak
--==================================================================================================================

-- Trait_FeatureYieldChanges
INSERT  INTO Trait_FeatureYieldChanges (TraitType, FeatureType, YieldType, Yield)
SELECT  'TRAIT_WAYFINDING', 'FEATURE_ATOLL', 'YIELD_FOOD', 2
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_WAYFINDING' AND Value = 1);

--==================================================================================================================
--  Naval Melee Ability to Build Mining Platform
--==================================================================================================================

-- Trait_BuildsUnitClasses
INSERT  INTO Trait_BuildsUnitClasses (TraitType, UnitClassType, BuildType)
SELECT  'TRAIT_WAYFINDING', Type, 'BUILD_MINING_PLATFORM' FROM UnitClasses
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_WAYFINDING' AND Value = 1)
        AND Type IN (SELECT DISTINCT Class FROM Units WHERE CombatClass = 'UNITCOMBAT_NAVALMELEE');

--==================================================================================================================
-- I dunno
--==================================================================================================================

-- Trait_SeaPlotYieldChanges
INSERT  INTO Trait_SeaPlotYieldChanges (TraitType, YieldType, Yield)
SELECT  'TRAIT_WAYFINDING', 'YIELD_CULTURE_LOCAL', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_WAYFINDING' AND Value = 1);