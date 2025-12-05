CREATE TABLE [dbo].[Artist] (
    [ArtistId]    INT            IDENTITY (1, 1) NOT NULL,
    [ArtistName]  NVARCHAR (255) NOT NULL,
    [IsActive]    INT            NOT NULL,
    [CreatedUtc]  DATETIME       CONSTRAINT [DF_Artist_CreatedUtc] DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]   NVARCHAR (255) CONSTRAINT [DF_Artist_CreatedBy] DEFAULT (suser_sname()) NOT NULL,
    [ModifiedUtc] DATETIME       NULL,
    [ModifiedBy]  NVARCHAR (255) NULL,
    CONSTRAINT [PK_Artist] PRIMARY KEY CLUSTERED ([ArtistId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'CODEOWNER', @value = N'CARLOS', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist';


GO
EXECUTE sp_addextendedproperty @name = N'CreatedBy', @value = N'Carlos', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist';


GO
EXECUTE sp_addextendedproperty @name = N'CreatedDate', @value = N'11/22/2025', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist';


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'Data about individual artists', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist';


GO
EXECUTE sp_addextendedproperty @name = N'ModifiedBy', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist';


GO
EXECUTE sp_addextendedproperty @name = N'ModifiedDate', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist';


GO
EXECUTE sp_addextendedproperty @name = N'SQLVERSION', @value = N'SQL Azure 12.0.2000.8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist';


GO
EXECUTE sp_addextendedproperty @name = N'Version', @value = N'1.0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PK, IDENTITY', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist', @level2type = N'COLUMN', @level2name = N'ArtistId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the artist', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist', @level2type = N'COLUMN', @level2name = N'ArtistName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is the artist still making music?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist', @level2type = N'COLUMN', @level2name = N'IsActive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was created in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist', @level2type = N'COLUMN', @level2name = N'CreatedUtc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who created the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist', @level2type = N'COLUMN', @level2name = N'CreatedBy';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was modified in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist', @level2type = N'COLUMN', @level2name = N'ModifiedUtc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who modified the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Artist', @level2type = N'COLUMN', @level2name = N'ModifiedBy';

