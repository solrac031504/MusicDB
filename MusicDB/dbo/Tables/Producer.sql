CREATE TABLE [dbo].[Producer] (
    [ProducerId]   INT            IDENTITY (1, 1) NOT NULL,
    [ProducerName] NVARCHAR (255) NOT NULL,
    [IsActive]     INT            NOT NULL,
    [CreatedUtc]   DATETIME       NOT NULL,
    [CreatedBy]    NVARCHAR (255) NOT NULL,
    [ModifiedUtc]  DATETIME       NULL,
    [ModifiedBy]   NVARCHAR (255) NULL
);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PK, IDENTITY', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer', @level2type = N'COLUMN', @level2name = N'ProducerId';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the producer', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer', @level2type = N'COLUMN', @level2name = N'ProducerName';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is the producer still producing?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer', @level2type = N'COLUMN', @level2name = N'IsActive';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was created in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer', @level2type = N'COLUMN', @level2name = N'CreatedUtc';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who created the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer', @level2type = N'COLUMN', @level2name = N'CreatedBy';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was modified in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer', @level2type = N'COLUMN', @level2name = N'ModifiedUtc';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who modified the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer', @level2type = N'COLUMN', @level2name = N'ModifiedBy';
GO

EXECUTE sp_addextendedproperty @name = N'Description', @value = N'Data about individual producers', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer';
GO

EXECUTE sp_addextendedproperty @name = N'ModifiedBy', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer';
GO

EXECUTE sp_addextendedproperty @name = N'ModifiedDate', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer';
GO

EXECUTE sp_addextendedproperty @name = N'Version', @value = N'1.0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer';
GO

EXECUTE sp_addextendedproperty @name = N'SQLVERSION', @value = N'SQL Azure 12.0.2000.8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer';
GO

EXECUTE sp_addextendedproperty @name = N'CODEOWNER', @value = N'CARLOS', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer';
GO

EXECUTE sp_addextendedproperty @name = N'CreatedDate', @value = N'11/22/2025', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer';
GO

EXECUTE sp_addextendedproperty @name = N'CreatedBy', @value = N'Carlos', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Producer';
GO

ALTER TABLE [dbo].[Producer]
    ADD CONSTRAINT [PK_Producer] PRIMARY KEY CLUSTERED ([ProducerId] ASC);
GO

ALTER TABLE [dbo].[Producer]
    ADD CONSTRAINT [DF_Producer_CreatedUtc] DEFAULT (getutcdate()) FOR [CreatedUtc];
GO

ALTER TABLE [dbo].[Producer]
    ADD CONSTRAINT [DF_Producer_CreatedBy] DEFAULT (suser_sname()) FOR [CreatedBy];
GO

