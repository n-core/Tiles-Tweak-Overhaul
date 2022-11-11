--==================================================================================================================
--==================================================================================================================
--  If Improvement - Pontoon Bridge mod exists
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
-- Improvement Tweaks
--==================================================================================================================

UPDATE  Improvements SET PillageGold = 8
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_PONTOON_BRIDGE')
        AND Type = 'IMPROVEMENT_PONTOON_BRIDGE';

UPDATE  Improvement_TechYieldChanges SET YieldType = 'YIELD_PRODUCTION'
        WHERE EXISTS (SELECT * FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_PONTOON_BRIDGE' AND TechType = 'TECH_COMPASS') 
        AND ImprovementType = 'IMPROVEMENT_PONTOON_BRIDGE'
        AND TechType = 'TECH_COMPASS';

-- Improvement_TechYieldChanges
INSERT  INTO Improvement_TechYieldChanges (ImprovementType, TechType, YieldType, Yield)
SELECT  'IMPROVEMENT_PONTOON_BRIDGE', 'TECH_STEEL', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_PONTOON_BRIDGE')
        AND NOT EXISTS (SELECT * FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_PONTOON_BRIDGE' AND TechType = 'TECH_COMPASS') UNION ALL
SELECT  'IMPROVEMENT_PONTOON_BRIDGE', 'TECH_ARCHITECTURE', 'YIELD_CULTURE', 1
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_PONTOON_BRIDGE')
        AND NOT EXISTS (SELECT * FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_PONTOON_BRIDGE' AND TechType = 'TECH_NAVIGATION') UNION ALL
SELECT  'IMPROVEMENT_PONTOON_BRIDGE', 'TECH_REPLACEABLE_PARTS', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_PONTOON_BRIDGE') UNION ALL
SELECT  'IMPROVEMENT_PONTOON_BRIDGE', 'TECH_MOBILE_TACTICS', 'YIELD_SCIENCE', 1
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_PONTOON_BRIDGE');

-- Improvement_AdjacentImprovementYieldChanges (Pontoon Bridge)
INSERT  INTO Improvement_AdjacentImprovementYieldChanges (ImprovementType, OtherImprovementType, YieldType, Yield)
SELECT  'IMPROVEMENT_KASBAH', 'IMPROVEMENT_PONTOON_BRIDGE', 'YIELD_GOLD', 2
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_PONTOON_BRIDGE') UNION ALL
SELECT  'IMPROVEMENT_FEITORIA', 'IMPROVEMENT_PONTOON_BRIDGE', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_PONTOON_BRIDGE');

-- Policy_ImprovementYieldChanges
INSERT  INTO Policy_ImprovementYieldChanges (PolicyType, ImprovementType, YieldType, Yield)
SELECT  'POLICY_NAVAL_TRADITION', 'IMPROVEMENT_PONTOON_BRIDGE', 'YIELD_SCIENCE', 2
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_PONTOON_BRIDGE') UNION ALL
SELECT  'POLICY_NAVAL_TRADITION', 'IMPROVEMENT_PONTOON_BRIDGE', 'YIELD_CULTURE', 1
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_PONTOON_BRIDGE') UNION ALL
SELECT  'POLICY_MOBILIZATION', 'IMPROVEMENT_PONTOON_BRIDGE', 'YIELD_SCIENCE', 3
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_PONTOON_BRIDGE');

-- EventChoice_ImprovementYieldChanges
INSERT  INTO EventChoice_ImprovementYieldChanges (EventChoiceType, ImprovementType, YieldType, Yield)
SELECT  'PLAYER_EVENT_CHOICE_MINOR_CIV_BYBLOS', 'IMPROVEMENT_PONTOON_BRIDGE', 'YIELD_FOOD', '1'
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_PONTOON_BRIDGE')
        AND EXISTS (SELECT * FROM EventChoices WHERE Type = 'PLAYER_EVENT_CHOICE_MINOR_CIV_BYBLOS');

--==================================================================================================================
-- If MUCfVP mod also exists
--==================================================================================================================

-- Improvement_AdjacentImprovementYieldChanges
INSERT  INTO Improvement_AdjacentImprovementYieldChanges (ImprovementType, OtherImprovementType, YieldType, Yield)
SELECT 'IMPROVEMENT_INDONESIA_KAMPONG', 'IMPROVEMENT_PONTOON_BRIDGE', 'YIELD_GOLD', 2
        WHERE EXISTS (SELECT * FROM Improvements WHERE Type IN('IMPROVEMENT_INDONESIA_KAMPONG', 'IMPROVEMENT_PONTOON_BRIDGE'));