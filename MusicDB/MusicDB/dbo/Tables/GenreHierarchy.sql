CREATE TABLE [dbo].[GenreHierarchy]
(
    [GenreId]               INT                 NOT NULL
    , [ParentGenreId]       INT                 NOT NULL
    , [CreatedUtc]          DATETIME            NOT NULL        CONSTRAINT [DF_GenreHierarchy_CreatedUtc]   DEFAULT (GETUTCDATE())
    , [CreatedBy]           NVARCHAR(255)       NOT NULL        CONSTRAINT [DF_GenreHierarchy_CreatedBy]    DEFAULT (SUSER_SNAME())
    , [ModifiedUtc]         DATETIME                NULL
    , [ModifiedBy]          NVARCHAR(255)           NULL
    , CONSTRAINT [PK_GenreHierarchy] PRIMARY KEY CLUSTERED (GenreId ASC, ParentGenreId ASC)
);
GO

-- ******************************
-- CONSTRAINTS
-- ******************************
-- FOREIGN KEYS
ALTER TABLE [dbo].[GenreHierarchy]
ADD CONSTRAINT [FK_GenreHierarchy_GenreId]
FOREIGN KEY (GenreId)
REFERENCES [dbo].[Genre] (GenreId);
GO

ALTER TABLE [dbo].[GenreHierarchy]
ADD CONSTRAINT [FK_GenreHierarchy_ParentGenreId]
FOREIGN KEY (ParentGenreId)
REFERENCES [dbo].[Genre] (GenreId);
GO

-- ******************************
-- EXTENDED PROPERTIES
-- ******************************
EXEC sys.sp_addextendedproperty
    @name = N'Description'
    , @value = N'The hierarchical organization of genres'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy';
GO

EXEC sys.sp_addextendedproperty
    @name = N'CODEOWNER'
    , @value = N'CARLOS'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SQLVERSION'
    , @value = N'SQL Azure 12.0.2000.8'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Version'
    , @value = N'1.1'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy';
GO

EXEC sys.sp_addextendedproperty
    @name = N'CreatedDate'
    , @value = N'11/22/2025'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy';
GO

EXEC sys.sp_addextendedproperty
    @name = N'CreatedBy'
    , @value = N'Carlos'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy';
GO

EXEC sys.sp_addextendedproperty
    @name = N'ModifiedDate'
    , @value = N'12/11/2025'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy';
GO

EXEC sys.sp_addextendedproperty
    @name = N'ModifiedBy'
    , @value = N'Carlos Gonzalez'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy';
GO

-- ******************************
-- FIELD COMMENTS
-- ******************************
EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'PK. The current genre in the hierarchy. References dbo.Genre'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy'
    , @level2type = N'COLUMN'
    , @level2name = N'GenreId';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'PK. The parent of the current genre. -1 if the genre is a root genre. References dbo.Genre'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy'
    , @level2type = N'COLUMN'
    , @level2name = N'ParentGenreId';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'When the record was created in UTC'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy'
    , @level2type = N'COLUMN'
    , @level2name = N'CreatedUtc'
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'Who created the record'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy'
    , @level2type = N'COLUMN'
    , @level2name = N'CreatedBy'
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'When the record was modified in UTC'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy'
    , @level2type = N'COLUMN'
    , @level2name = N'ModifiedUtc'
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'Who modified the record'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'GenreHierarchy'
    , @level2type = N'COLUMN'
    , @level2name = N'ModifiedBy'
GO