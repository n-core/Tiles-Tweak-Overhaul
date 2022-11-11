--==================================================================================================================
--==================================================================================================================
-- If More Unit Components for VP mod exists
--==================================================================================================================
--==================================================================================================================

--==================================================================================================================
-- Improvement Tweaks
--==================================================================================================================

-- Improvement_ResourceTypes
INSERT INTO Improvement_ResourceTypes (ImprovementType, ResourceType, ResourceMakesValid, ResourceTrade)
SELECT  'IMPROVEMENT_INDONESIA_KAMPONG', 'RESOURCE_FISH', 1, 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements  WHERE Type = 'IMPROVEMENT_INDONESIA_KAMPONG');

-- Improvement_ResourceType_Yields
INSERT INTO Improvement_ResourceType_Yields (ImprovementType, ResourceType, YieldType, Yield)
SELECT  'IMPROVEMENT_INDONESIA_KAMPONG', 'RESOURCE_FISH', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1);

-- Improvement_TechYieldChanges
INSERT INTO Improvement_TechYieldChanges (ImprovementType, TechType, YieldType, Yield)
SELECT  'IMPROVEMENT_ETHIOPIA_MONOLITHIC_CHURCH_HILL', 'TECH_GUILDS', 'YIELD_FOOD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_ETHIOPIA_MONOLITHIC_CHURCH_HILL') UNION ALL

SELECT  'IMPROVEMENT_ETHIOPIA_MONOLITHIC_CHURCH_HILL', 'TECH_ARCHITECTURE', 'YIELD_CULTURE', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_ETHIOPIA_MONOLITHIC_CHURCH_HILL') UNION ALL

SELECT  'IMPROVEMENT_ETHIOPIA_MONOLITHIC_CHURCH_HILL', 'TECH_TELECOM', 'YIELD_TOURISM', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_ETHIOPIA_MONOLITHIC_CHURCH_HILL');

UPDATE  Improvement_TechYieldChanges SET Yield = 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_ROME_LATIFUNDIUM')
        AND ImprovementType = 'IMPROVEMENT_ROME_LATIFUNDIUM' 
        AND TechType = 'TECH_CURRENCY';
/*
DELETE  FROM Improvement_TechYieldChanges
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_ROME_LATIFUNDIUM')
        AND ImprovementType = 'IMPROVEMENT_ROME_LATIFUNDIUM' 
        AND TechType = 'TECH_CIVIL_SERVICE'
        AND YieldType = 'YIELD_PRODUCTION';
*/

-- Improvement_AdjacentImprovementYieldChanges
INSERT INTO Improvement_AdjacentImprovementYieldChanges (ImprovementType, OtherImprovementType, YieldType, Yield)
SELECT  i.Type, oi.Type, 'YIELD_PRODUCTION', 1 FROM Improvements i, Improvements oi
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_IMPROVEMENTS', 'TTO_MININGPLATFORM') AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type IN ('IMPROVEMENT_INDONESIA_KAMPONG', 'IMPROVEMENT_CELTS_OPPIDUM'))
        AND i.Type IN ('IMPROVEMENT_INDONESIA_KAMPONG', 'IMPROVEMENT_CELTS_OPPIDUM')
        AND oi.Type IN ('IMPROVEMENT_MINING_PLATFORM', 'IMPROVEMENT_OFFSHORE_PLATFORM') UNION ALL

SELECT 'IMPROVEMENT_CELTS_OPPIDUM', Type, 'YIELD_SCIENCE', 1 FROM Improvements
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_IMPROVEMENTS', 'TTO_MININGPLATFORM') AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_CELTS_OPPIDUM')
        AND Type IN ('IMPROVEMENT_MINING_PLATFORM', 'IMPROVEMENT_OFFSHORE_PLATFORM');

-- Improvement_AdjacentFeatureYieldChanges
INSERT  INTO Improvement_AdjacentFeatureYieldChanges (ImprovementType, FeatureType, YieldType, Yield)
SELECT  'IMPROVEMENT_INDONESIA_KAMPONG', 'FEATURE_ATOLL', 'YIELD_GOLD', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_IMPROVEMENTS' AND Value = 1)
        AND EXISTS (SELECT * FROM Improvements WHERE Type = 'IMPROVEMENT_INDONESIA_KAMPONG');

-- BuildFeatures
UPDATE  BuildFeatures SET Remove = 0
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BUILDFEATURES' AND Value = 1)
        AND EXISTS (SELECT * FROM Builds WHERE BuildType IN ('BUILD_CELTS_OPPIDUM', 'BUILD_ROME_LATIFUNDIUM'))
        AND BuildType IN ('BUILD_CELTS_OPPIDUM', 'BUILD_ROME_LATIFUNDIUM')
        AND FeatureType IN ('FEATURE_FOREST', 'FEATURE_JUNGLE', 'FEATURE_MARSH');
        
--==================================================================================================================
-- Resource Tweaks
--==================================================================================================================

-- Resource_YieldChanges
INSERT INTO Resource_YieldChanges (ResourceType, YieldType, Yield)
SELECT  'RESOURCE_EGYPT_FLAX', 'YIELD_PRODUCTION', 1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_RESOURCES' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_EGYPT_FLAX');