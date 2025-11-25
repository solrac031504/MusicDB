CREATE TABLE [dbo].[Group] (
    [GroupId]     INT            IDENTITY (1, 1) NOT NULL,
    [GroupName]   NVARCHAR (255) NOT NULL,
    [ArtistId]    INT            NOT NULL,
    [IsActive]    INT            NOT NULL,
    [CreatedUtc]  DATETIME       NOT NULL,
    [CreatedBy]   NVARCHAR (255) NOT NULL,
    [ModifiedUtc] DATETIME       NULL,
    [ModifiedBY]  NVARCHAR (255) NULL
);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PK, IDENTITY', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group', @level2type = N'COLUMN', @level2name = N'GroupId';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the group', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group', @level2type = N'COLUMN', @level2name = N'GroupName';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The artist or one of the artists belonging to the group. References dbo.Artist', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group', @level2type = N'COLUMN', @level2name = N'ArtistId';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is the group still making music/together?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group', @level2type = N'COLUMN', @level2name = N'IsActive';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was created in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group', @level2type = N'COLUMN', @level2name = N'CreatedUtc';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who created the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group', @level2type = N'COLUMN', @level2name = N'CreatedBy';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was modified in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group', @level2type = N'COLUMN', @level2name = N'ModifiedUtc';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who modified the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group', @level2type = N'COLUMN', @level2name = N'ModifiedBY';
GO

EXECUTE sp_addextendedproperty @name = N'ModifiedBy', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group';
GO

EXECUTE sp_addextendedproperty @name = N'ModifiedDate', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group';
GO

EXECUTE sp_addextendedproperty @name = N'CODEOWNER', @value = N'CARLOS', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group';
GO

EXECUTE sp_addextendedproperty @name = N'SQLVERSION', @value = N'SQL Azure 12.0.2000.8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group';
GO

EXECUTE sp_addextendedproperty @name = N'CreatedBy', @value = N'Carlos', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group';
GO

EXECUTE sp_addextendedproperty @name = N'Version', @value = N'1.0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group';
GO

EXECUTE sp_addextendedproperty @name = N'CreatedDate', @value = N'11/22/2025', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group';
GO

EXECUTE sp_addextendedproperty @name = N'Description', @value = N'Data about groups of artists or single artists', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Group';
GO

ALTER TABLE [dbo].[Group]
    ADD CONSTRAINT [FK_Group_ArtistId] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId]);
GO

ALTER TABLE [dbo].[Group]
    ADD CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED ([GroupId] ASC);
GO

ALTER TABLE [dbo].[Group]
    ADD CONSTRAINT [DF_Group_CreatedBy] DEFAULT (suser_sname()) FOR [CreatedBy];
GO

ALTER TABLE [dbo].[Group]
    ADD CONSTRAINT [DF_Group_CreatedUtc] DEFAULT (getutcdate()) FOR [CreatedUtc];
GO

