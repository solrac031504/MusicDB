CREATE TABLE [dbo].[Project] (
    [ProjectId]     INT            IDENTITY (1, 1) NOT NULL,
    [ProjectName]   NVARCHAR (255) NOT NULL,
    [SceneId]       INT            NULL,
    [ProjectTypeId] INT            NOT NULL,
    [ReleaseDate]   DATE           NOT NULL,
    [Rating]        DECIMAL (4, 2) NULL,
    [CreatedUtc]    DATETIME       CONSTRAINT [DF_Project_CreatedUtc] DEFAULT (getutcdate()) NOT NULL,
    [CreatedBy]     NVARCHAR (255) CONSTRAINT [DF_Project_CreatedBy] DEFAULT (suser_sname()) NULL,
    [ModifiedUtc]   DATETIME       NULL,
    [ModifiedBy]    NVARCHAR (255) NULL,
    [GroupId]       INT            NOT NULL,
    CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED ([ProjectId] ASC),
    CONSTRAINT [FK_Project_GroupId] FOREIGN KEY ([GroupId]) REFERENCES [dbo].[Group] ([GroupId]),
    CONSTRAINT [FK_Project_ProjectTypeID] FOREIGN KEY ([ProjectTypeId]) REFERENCES [dbo].[ProjectType] ([ProjectTypeId]),
    CONSTRAINT [FK_Project_SceneId] FOREIGN KEY ([SceneId]) REFERENCES [dbo].[Scene] ([SceneId])
);


GO
EXECUTE sp_addextendedproperty @name = N'CODEOWNER', @value = N'CARLOS', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project';


GO
EXECUTE sp_addextendedproperty @name = N'CreatedBy', @value = N'Carlos', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project';


GO
EXECUTE sp_addextendedproperty @name = N'CreatedDate', @value = N'11/22/2025', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project';


GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'Data about musical projects', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project';


GO
EXECUTE sp_addextendedproperty @name = N'ModifiedBy', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project';


GO
EXECUTE sp_addextendedproperty @name = N'ModifiedDate', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project';


GO
EXECUTE sp_addextendedproperty @name = N'SQLVERSION', @value = N'SQL Azure 12.0.2000.8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project';


GO
EXECUTE sp_addextendedproperty @name = N'Version', @value = N'1.0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PK, IDENTITY', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'ProjectId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'ProjectName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The musical scene of the project. References dbo.Scene', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'SceneId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The type of musical project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'ProjectTypeId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The date the musical project was released', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'ReleaseDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The overall rating of the musical project out of 10', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'Rating';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was created in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'CreatedUtc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who created the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'CreatedBy';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was modified in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'ModifiedUtc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who modified the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Project', @level2type = N'COLUMN', @level2name = N'ModifiedBy';

