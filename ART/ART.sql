INSERT INTO ArtDefine_Landmarks
        (Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
VALUES  ('Ancient',
        'Any',
        0.0659999992980232,
        'ART_DEF_IMPROVEMENT_FISHING_BOATS',
        'ANIMATED',
        'ART_DEF_RESOURCE_NONE',
        'Assets/Buildings/Resources/Fish.fxsxml',
        1),

        ('Industrial',
        'Any',
        0.0659999992980232,
        'ART_DEF_IMPROVEMENT_FISHING_BOATS',
        'ANIMATED',
        'ART_DEF_RESOURCE_NONE',
        'Assets/Buildings/Resources/Fish_Industrial.fxsxml',
        1),

        ('Any',
        'Any',
        1.5,
        'ART_DEF_IMPROVEMENT_OFFSHORE_PLATFORM',
        'SNAPSHOT',
        'ART_DEF_RESOURCE_NONE',
        'Assets/Buildings/Improvements/Oil_Rig/Water/Oil_Platform.fxsxml',
        1);

INSERT INTO IconTextureAtlases	(Atlas, IconSize, Filename, IconsPerRow, IconsPerColumn) VALUES
	    ('WTEMOD_ICON_ATLAS', 256, 'WTEmodIconAtlas256.dds', '1', '1'),
	    ('WTEMOD_ICON_ATLAS', 128, 'WTEmodIconAtlas128.dds', '1', '1'),
	    ('WTEMOD_ICON_ATLAS', 064, 'WTEmodIconAtlas64.dds', '1', '1'),
	    ('WTEMOD_ICON_ATLAS', 045, 'WTEmodIconAtlas45.dds', '1', '1');

INSERT INTO ArtDefine_Landmarks
        (Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT  'Any',
        'Any',
        0.7,
        'ART_DEF_IMPROVEMENT_OFFSHORE_PLATFORM',
        'SNAPSHOT',
        'ART_DEF_RESOURCE_IA_SALT_LAKE',
        'Assets/Buildings/Improvements/Oil_Rig/Water/Super_Oil_Platform.fxsxml',
        1
        WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type = 'TTO_MININGPLATFORM' AND Value = 1)
        AND EXISTS (SELECT * FROM Resources WHERE Type = 'RESOURCE_IA_SALT_LAKE');