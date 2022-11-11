--==================================================================================================================
--==================================================================================================================
--  If Coastal Fortress mod by Hulfgar exists
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
-- Improvement Tweaks
--==================================================================================================================

-- Improvement_TechYieldChanges
INSERT INTO Improvement_TechYieldChanges (ImprovementType, TechType, YieldType, Yield)
SELECT  'IMPROVEMENT_COASTAL_FORT', Type, 'YIELD_SCIENCE', 2 FROM Technologies
        WHERE Type IN('TECH_CHEMISTRY', 'TECH_BALLISTICS', 'TECH_STEALTH')
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_COASTAL_FORT') UNION ALL
SELECT  'IMPROVEMENT_COASTAL_FORT', Type, 'YIELD_CULTURE_LOCAL', 2 FROM Technologies
        WHERE Type IN('TECH_RIFLING', 'TECH_BALLISTICS', 'TECH_STEALTH')
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_COASTAL_FORT');

-- Improvement_ValidTerrains
INSERT INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
SELECT  'IMPROVEMENT_COASTAL_FORT', 'TERRAIN_HILL'
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_COASTAL_FORT');
/*
-- Improvement_ValidFeatures
INSERT INTO Improvement_ValidFeatures (ImprovementType, FeatureType)
SELECT  'IMPROVEMENT_COASTAL_FORT', Type FROM Features
        WHERE Type IN('FEATURE_JUNGLE', 'FEATURE_FOREST', 'FEATURE_MARSH')
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_COASTAL_FORT');
*/

-- BuildFeatures
UPDATE  BuildFeatures SET Remove = 0
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BUILDFEATURES' AND Value = 1)
        AND EXISTS (SELECT * FROM Builds WHERE BuildType = 'BUILD_COASTAL_FORT')
        AND BuildType = 'BUILD_COASTAL_FORT'
        AND FeatureType IN ('FEATURE_FOREST', 'FEATURE_JUNGLE', 'FEATURE_MARSH');

-- Policy_ImprovementYieldChanges
INSERT INTO Policy_ImprovementYieldChanges (PolicyType, ImprovementType, YieldType, Yield)
SELECT  'POLICY_NAVAL_TRADITION', 'IMPROVEMENT_COASTAL_FORT', 'YIELD_SCIENCE', 2
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_COASTAL_FORT') UNION ALL
SELECT  'POLICY_NAVAL_TRADITION', 'IMPROVEMENT_COASTAL_FORT', 'YIELD_CULTURE', 1
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_COASTAL_FORT') UNION ALL
SELECT  'POLICY_MOBILIZATION', 'IMPROVEMENT_COASTAL_FORT', 'YIELD_SCIENCE', 3
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_COASTAL_FORT');

-- Improvement_ResourceTypes
/*
UPDATE  Improvement_ResourceTypes SET ResourceMakesValid = 0, ResourceTrade = 0
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_COASTAL_FORT';
*/
DELETE  FROM Improvement_ResourceTypes
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_COASTAL_FORT';

--==================================================================================================================
-- If Unique CIty-States mod also exists
--==================================================================================================================

-- EventChoice_ImprovementYieldChange
INSERT INTO EventChoice_ImprovementYieldChange (EventChoiceType, ImprovementType, YieldType, YieldChange)
SELECT	'PLAYER_EVENT_CHOICE_MINOR_CIV_PANAMA_CITY', 'IMPROVEMENT_COASTAL_FORT', 'YIELD_FOOD',	1
        WHERE EXISTS (SELECT * FROM Improvements i, MinorCivilizations mc WHERE i.Type = 'IMPROVEMENT_COASTAL_FORT' AND mc.Type='MINOR_CIV_PANAMA_CITY');