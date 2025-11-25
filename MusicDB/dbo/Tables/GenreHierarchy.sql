CREATE TABLE [dbo].[GenreHierarchy] (
    [counter]       INT            IDENTITY (1, 1) NOT NULL,
    [GenreId]       INT            NOT NULL,
    [ParentGenreId] INT            NULL,
    [CreatedUtc]    DATETIME       NOT NULL,
    [CreatedBy]     NVARCHAR (255) NOT NULL,
    [ModifiedUtc]   DATETIME       NULL,
    [ModifiedBy]    NVARCHAR (255) NULL
);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PK, IDENTITY', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy', @level2type = N'COLUMN', @level2name = N'counter';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The current genre in the hierarchy. References dbo.Genre', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy', @level2type = N'COLUMN', @level2name = N'GenreId';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The parent of the current genre. NULL if the genre is a root genre. References dbo.Genre', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy', @level2type = N'COLUMN', @level2name = N'ParentGenreId';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was created in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy', @level2type = N'COLUMN', @level2name = N'CreatedUtc';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who created the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy', @level2type = N'COLUMN', @level2name = N'CreatedBy';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was modified in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy', @level2type = N'COLUMN', @level2name = N'ModifiedUtc';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who modified the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy', @level2type = N'COLUMN', @level2name = N'ModifiedBy';
GO

EXECUTE sp_addextendedproperty @name = N'Description', @value = N'The hierarchical organization of genres', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy';
GO

EXECUTE sp_addextendedproperty @name = N'ModifiedBy', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy';
GO

EXECUTE sp_addextendedproperty @name = N'CODEOWNER', @value = N'CARLOS', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy';
GO

EXECUTE sp_addextendedproperty @name = N'ModifiedDate', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy';
GO

EXECUTE sp_addextendedproperty @name = N'CreatedBy', @value = N'Carlos', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy';
GO

EXECUTE sp_addextendedproperty @name = N'SQLVERSION', @value = N'SQL Azure 12.0.2000.8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy';
GO

EXECUTE sp_addextendedproperty @name = N'Version', @value = N'1.0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy';
GO

EXECUTE sp_addextendedproperty @name = N'CreatedDate', @value = N'11/22/2025', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GenreHierarchy';
GO

ALTER TABLE [dbo].[GenreHierarchy]
    ADD CONSTRAINT [FK_GenreHierarchy_GenreId] FOREIGN KEY ([GenreId]) REFERENCES [dbo].[Genre] ([GenreId]);
GO

ALTER TABLE [dbo].[GenreHierarchy]
    ADD CONSTRAINT [FK_GenreHierarchy_ParentGenreId] FOREIGN KEY ([ParentGenreId]) REFERENCES [dbo].[Genre] ([GenreId]);
GO

ALTER TABLE [dbo].[GenreHierarchy]
    ADD CONSTRAINT [PK_GenreHierarchy] PRIMARY KEY NONCLUSTERED ([counter] ASC);
GO

ALTER TABLE [dbo].[GenreHierarchy]
    ADD CONSTRAINT [DF_GenreHierarchy_CreatedUtc] DEFAULT (getutcdate()) FOR [CreatedUtc];
GO

ALTER TABLE [dbo].[GenreHierarchy]
    ADD CONSTRAINT [DF_GenreHierarchy_CreatedBy] DEFAULT (suser_sname()) FOR [CreatedBy];
GO

CREATE UNIQUE CLUSTERED INDEX [CIX_GenreHierarchy_GenreId_ParentGenreId]
    ON [dbo].[GenreHierarchy]([GenreId] ASC, [ParentGenreId] ASC);
GO

