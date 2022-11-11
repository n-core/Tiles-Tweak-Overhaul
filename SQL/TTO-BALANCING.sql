--==================================================================================================================
--==================================================================================================================
--  GAMEPLAY BALANCING
--==================================================================================================================
--==================================================================================================================
/*

Balancing the gameplay by adjusting some GameSpeeds values.
There are 2 types, With and Without Tiles Tech Enhancements.
So there will be no unit or building cost manual adjustment needed.

*/
--==================================================================================================================
-- Without Tiles Yield Enhancements
--==================================================================================================================

-- Make things just a little inflated because of all base 3 yield.

-- For GAMESPEED_QUICK (Default values = 67)
UPDATE  GameSpeeds SET
        GrowthPercent = 75,
        TrainPercent = 75,
        ConstructPercent = 75,
        CreatePercent = 75,
        ResearchPercent = 75,
        GoldPercent = 75,
        CulturePercent = 75,
        FaithPercent = 75,
        FeatureProductionPercent = 75,
        UnitDiscoverPercent = 75,
        UnitHurryPercent = 75,
        UnitTradePercent = 75
        WHERE Type = 'GAMESPEED_QUICK'
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BALANCING' AND Value = 1)
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 0);

-- For GAMESPEED_STANDARD (Default values = 100)
UPDATE  GameSpeeds SET
        GrowthPercent = 125,
        TrainPercent = 125,
        ConstructPercent = 125,
        CreatePercent = 125,
        ResearchPercent = 125,
        GoldPercent = 125,
        CulturePercent = 125,
        FaithPercent = 125,
        FeatureProductionPercent = 125,
        UnitDiscoverPercent = 125,
        UnitHurryPercent = 125,
        UnitTradePercent = 125
        WHERE Type = 'GAMESPEED_STANDARD'
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BALANCING' AND Value = 1)
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 0);

-- For GAMESPEED_EPIC (Default values = 150)
UPDATE  GameSpeeds SET
        GrowthPercent = 175,
        TrainPercent = 175,
        ConstructPercent = 175,
        CreatePercent = 175,
        ResearchPercent = 175,
        GoldPercent = 175,
        CulturePercent = 175,
        FaithPercent = 175,
        FeatureProductionPercent = 175,
        UnitDiscoverPercent = 175,
        UnitHurryPercent = 175,
        UnitTradePercent = 175
        WHERE Type = 'GAMESPEED_EPIC'
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BALANCING' AND Value = 1)
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 0);

-- For GAMESPEED_MARATHON (Default values = 300)
UPDATE  GameSpeeds SET
        GrowthPercent = 350,
        TrainPercent = 350,
        ConstructPercent = 350,
        CreatePercent = 350,
        ResearchPercent = 350,
        GoldPercent = 350,
        CulturePercent = 350,
        FaithPercent = 350,
        FeatureProductionPercent = 350,
        UnitDiscoverPercent = 350,
        UnitHurryPercent = 350,
        UnitTradePercent = 350
        WHERE Type = 'GAMESPEED_MARATHON'
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_BALANCING' AND Value = 1)
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_TR_YIELD' AND Value = 0);

--==================================================================================================================
-- With Tiles Yield Enhancements
--==================================================================================================================

-- Make things more inflated since this mod adds more yields by researching techs

-- For GAMESPEED_QUICK (Default values = 67)
UPDATE  GameSpeeds SET
        GrowthPercent = 100,
        TrainPercent = 100,
        ConstructPercent = 100,
        CreatePercent = 100,
        ResearchPercent = 100,
        GoldPercent = 100,
        CulturePercent = 100,
        FaithPercent = 100,
        FeatureProductionPercent = 100,
        UnitDiscoverPercent = 100,
        UnitHurryPercent = 100,
        UnitTradePercent = 100
        WHERE Type = 'GAMESPEED_QUICK'
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_BALANCING', 'TTO_TR_YIELD') AND Value = 1);

-- For GAMESPEED_STANDARD (Default values = 100)
UPDATE  GameSpeeds SET
        GrowthPercent = 150,
        TrainPercent = 150,
        ConstructPercent = 150,
        CreatePercent = 150,
        ResearchPercent = 150,
        GoldPercent = 150,
        CulturePercent = 150,
        FaithPercent = 150,
        FeatureProductionPercent = 150,
        UnitDiscoverPercent = 150,
        UnitHurryPercent = 150,
        UnitTradePercent = 150
        WHERE Type = 'GAMESPEED_STANDARD'
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_BALANCING', 'TTO_TR_YIELD') AND Value = 1);

-- For GAMESPEED_EPIC (Default values = 150)
UPDATE  GameSpeeds SET
        GrowthPercent = 250,
        TrainPercent = 250,
        ConstructPercent = 250,
        CreatePercent = 250,
        ResearchPercent = 250,
        GoldPercent = 250,
        CulturePercent = 250,
        FaithPercent = 250,
        FeatureProductionPercent = 250,
        UnitDiscoverPercent = 250,
        UnitHurryPercent = 250,
        UnitTradePercent = 250
        WHERE Type = 'GAMESPEED_EPIC'
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_BALANCING', 'TTO_TR_YIELD') AND Value = 1);

-- For GAMESPEED_MARATHON (Default values = 300)
UPDATE  GameSpeeds SET
        GrowthPercent = 425,
        TrainPercent = 425,
        ConstructPercent = 425,
        CreatePercent = 425,
        ResearchPercent = 425,
        GoldPercent = 425,
        CulturePercent = 425,
        FaithPercent = 425,
        FeatureProductionPercent = 425,
        UnitDiscoverPercent = 425,
        UnitHurryPercent = 425,
        UnitTradePercent = 425
        WHERE Type = 'GAMESPEED_MARATHON'
        AND EXISTS (SELECT * FROM COMMUNITY WHERE Type IN ('TTO_BALANCING', 'TTO_TR_YIELD') AND Value = 1);