CREATE TABLE [dbo].[Song] (
    [SongId]          INT            IDENTITY (1, 1) NOT NULL,
    [SongName]        NVARCHAR (255) NOT NULL,
    [GroupId]         INT            NOT NULL,
    [ProjectId]       INT            NOT NULL,
    [ProducerGroupId] INT            NULL,
    [GenreId]         INT            NOT NULL,
    [SceneId]         INT            NULL,
    [ServiceId]       INT            NOT NULL,
    [Duration]        INT            NOT NULL,
    [Rating]          DECIMAL (4, 2) NULL,
    [IsLocalFile]     INT            CONSTRAINT [DF_Song_IsLocalFile] DEFAULT ((0)) NOT NULL,
    [CreatedUtc]      DATETIME       CONSTRAINT [DF_Song_CreatedUtc] DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]       NVARCHAR (255) CONSTRAINT [DF_Song_CreatedBy] DEFAULT (suser_sname()) NULL,
    [ModifiedUtc]     DATETIME       NULL,
    [ModifiedBy]      NVARCHAR (255) NULL,
    CONSTRAINT [PK_Song] PRIMARY KEY CLUSTERED ([SongId] ASC),
    CONSTRAINT [CK_Song_Duration] CHECK ([Duration]>=(0)),
    CONSTRAINT [CK_Song_Rating] CHECK ([Rating]>=(0.00) AND [Rating]<=(10.00)),
    CONSTRAINT [FK_Song_GenreId] FOREIGN KEY ([GenreId]) REFERENCES [dbo].[Genre] ([GenreId]),
    CONSTRAINT [FK_Song_GroupId] FOREIGN KEY ([GroupId]) REFERENCES [dbo].[Group] ([GroupId]),
    CONSTRAINT [FK_Song_ProducerGroup] FOREIGN KEY ([ProducerGroupId]) REFERENCES [dbo].[ProducerGroup] ([ProducerGroupId]),
    CONSTRAINT [FK_Song_ProjectId] FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Project] ([ProjectId]),
    CONSTRAINT [FK_Song_SceneId] FOREIGN KEY ([SceneId]) REFERENCES [dbo].[Scene] ([SceneId]),
    CONSTRAINT [FK_Song_ServiceId] FOREIGN KEY ([ServiceId]) REFERENCES [dbo].[StreamingService] ([ServiceId])
);


GO
EXECUTE sp_addextendedproperty @name = N'CODEOWNER', @value = N'CARLOS', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song';


GO
EXECUTE sp_addextendedproperty @name = N'CreatedBy', @value = N'Carlos', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song';


GO
EXECUTE sp_addextendedproperty @name = N'CreatedDate', @value = N'11/22/2025', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song';


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'Data about individual songs', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song';


GO
EXECUTE sp_addextendedproperty @name = N'ModifiedBy', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song';


GO
EXECUTE sp_addextendedproperty @name = N'ModifiedDate', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song';


GO
EXECUTE sp_addextendedproperty @name = N'SQLVERSION', @value = N'SQL Azure 12.0.2000.8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song';


GO
EXECUTE sp_addextendedproperty @name = N'Version', @value = N'1.0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PK, IDENTITY', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'SongId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the song', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'SongName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The group performing the song. References dbo.Group', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'GroupId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The project the song belongs to. References dbo.Project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The group of producers/producer that produced the song. References dbo.ProducerGroup', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'ProducerGroupId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The genre of the song. References dbo.Genre', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'GenreId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The scene of the song. References dbo.Scene', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'SceneId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The source streaming service of the song. Local files are ported from other streaming services if they are not from Apple Music. References dbo.StreamingService', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'ServiceId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'How long the song lasts in seconds', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'Duration';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The song rating out of 10', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'Rating';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flag if the song is or is not a local file', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'IsLocalFile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was created in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'CreatedUtc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who created the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'CreatedBy';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was modified in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'ModifiedUtc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who modified the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Song', @level2type = N'COLUMN', @level2name = N'ModifiedBy';

