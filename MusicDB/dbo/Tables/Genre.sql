CREATE TABLE [dbo].[Genre]
(
    GenreId                 INT                 IDENTITY(1, 1)
    , GenreName             NVARCHAR(255)       NOT NULL
    , [Description]         NVARCHAR(4000)      NOT NULL
    , CreatedUtc            DATETIME            NOT NULL
    , CreatedBy             NVARCHAR(255)       NOT NULL
    , ModifiedUtc           DATETIME                NULL
    , ModifiedBy            NVARCHAR(255)           NULL
    , CONSTRAINT [PK_Genre] PRIMARY KEY CLUSTERED (GenreId ASC)
);
GO

-- ******************************
-- INDEXES
-- ******************************

-- ******************************
-- CONSTRAINTS
-- ******************************
-- DEFAULTS
ALTER TABLE [dbo].[Genre]
ADD CONSTRAINT [DF_Genre_CreatedUtc]
DEFAULT GETUTCDATE()
FOR [CreatedUtc];
GO

ALTER TABLE [dbo].[Genre]
ADD CONSTRAINT [DF_Genre_CreatedBy]
DEFAULT SUSER_SNAME()
FOR [CreatedBy];
GO

-- ******************************
-- EXTENDED PROPERTIES
-- ******************************
EXEC sys.sp_addextendedproperty
    @name = N'Description'
    , @value = N'Data about genres'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre';
GO

EXEC sys.sp_addextendedproperty
    @name = N'CODEOWNER'
    , @value = N'CARLOS'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SQLVERSION'
    , @value = N'SQL Azure 12.0.2000.8'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Version'
    , @value = N'1.0'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre';
GO

EXEC sys.sp_addextendedproperty
    @name = N'CreatedDate'
    , @value = N'11/22/2025'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre';
GO

EXEC sys.sp_addextendedproperty
    @name = N'CreatedBy'
    , @value = N'Carlos'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre';
GO

EXEC sys.sp_addextendedproperty
    @name = N'ModifiedDate'
    , @value = N''
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre';
GO

EXEC sys.sp_addextendedproperty
    @name = N'ModifiedBy'
    , @value = N''
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre';
GO

-- ******************************
-- FIELD COMMENTS
-- ******************************
EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'PK, IDENTITY'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre'
    , @level2type = N'COLUMN'
    , @level2name = N'GenreId';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'The name of the genre'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre'
    , @level2type = N'COLUMN'
    , @level2name = N'GenreName';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'A brief description of the genre'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre'
    , @level2type = N'COLUMN'
    , @level2name = N'Description';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'When the record was created in UTC'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre'
    , @level2type = N'COLUMN'
    , @level2name = N'CreatedUtc'
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'Who created the record'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre'
    , @level2type = N'COLUMN'
    , @level2name = N'CreatedBy'
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'When the record was modified in UTC'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre'
    , @level2type = N'COLUMN'
    , @level2name = N'ModifiedUtc'
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'Who modified the record'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'Genre'
    , @level2type = N'COLUMN'
    , @level2name = N'ModifiedBy'
GO