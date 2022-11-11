--==================================================================================================================
--==================================================================================================================
--  If Improvement - Airbase mod by William Howard exists
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
-- Improvement Tweaks
--==================================================================================================================

--Improvement_TechYieldChanges
INSERT INTO Improvement_TechYieldChanges (ImprovementType, TechType, YieldType, Yield)
SELECT  'IMPROVEMENT_AIRBASE', Type, 'YIELD_SCIENCE', 2 FROM Technologies
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_AIRBASE')
        AND Type IN ('TECH_FLIGHT', 'TECH_BALLISTICS', 'TECH_LASERS') UNION ALL
SELECT  'IMPROVEMENT_AIRBASE', Type, 'YIELD_CULTURE_LOCAL', 2 FROM Technologies
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_AIRBASE')
        AND Type IN ('TECH_FLIGHT', 'TECH_COMBINED_ARMS', 'TECH_STEALTH');

-- BuildFeatures
UPDATE  BuildFeatures SET Remove = 0
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BUILDFEATURES' AND Value = 1)
        AND EXISTS (SELECT * FROM Builds WHERE BuildType = 'BUILD_AIRBASE')
        AND BuildType = 'BUILD_AIRBASE'
        AND FeatureType IN ('FEATURE_FOREST', 'FEATURE_JUNGLE', 'FEATURE_MARSH');

-- Policy_ImprovementYieldChanges
INSERT  INTO Policy_ImprovementYieldChanges (PolicyType, ImprovementType, YieldType, Yield)
SELECT  'POLICY_MOBILIZATION', 'IMPROVEMENT_AIRBASE', 'YIELD_SCIENCE', 3
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_AIRBASE') UNION ALL
SELECT  'POLICY_URBANIZATION', 'IMPROVEMENT_AIRBASE', 'YIELD_FOOD', 4
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_AIRBASE');

-- Improvement_ResourceTypes
/*
UPDATE  Improvement_ResourceTypes SET ResourceMakesValid = 0, ResourceTrade = 0
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_AIRBASE';
*/
DELETE  FROM Improvement_ResourceTypes
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND ImprovementType = 'IMPROVEMENT_AIRBASE';

--==================================================================================================================
-- If Unique City-States mod by Techpriest Enginseer also exists
--==================================================================================================================

-- EventChoice_ImprovementYieldChange
INSERT  INTO EventChoice_ImprovementYieldChange (EventChoiceType, ImprovementType, YieldType, YieldChange)
SELECT	'PLAYER_EVENT_CHOICE_MINOR_CIV_SURREY', 'IMPROVEMENT_AIRBASE', 'YIELD_SCIENCE',	2
        WHERE EXISTS (SELECT * FROM Improvements i, MinorCivilizations mc WHERE i.Type = 'IMPROVEMENT_AIRBASE' AND mc.Type='MINOR_CIV_SURREY');