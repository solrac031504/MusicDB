CREATE TABLE [dbo].[StreamingService] (
    [ServiceId]   INT            IDENTITY (1, 1) NOT NULL,
    [ServiceName] NVARCHAR (255) NOT NULL,
    [CreatedUtc]  DATETIME       NOT NULL,
    [CreatedBy]   NVARCHAR (255) NULL,
    [ModifiedUtc] DATETIME       NULL,
    [ModifiedBy]  NVARCHAR (255) NULL
);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PK, IDENTITY', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService', @level2type = N'COLUMN', @level2name = N'ServiceId';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the source streaming service', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService', @level2type = N'COLUMN', @level2name = N'ServiceName';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was created in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService', @level2type = N'COLUMN', @level2name = N'CreatedUtc';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who created the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService', @level2type = N'COLUMN', @level2name = N'CreatedBy';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the record was modified in UTC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService', @level2type = N'COLUMN', @level2name = N'ModifiedUtc';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Who modified the record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService', @level2type = N'COLUMN', @level2name = N'ModifiedBy';
GO

ALTER TABLE [dbo].[StreamingService]
    ADD CONSTRAINT [DF_StreamingService_CreatedBy] DEFAULT (suser_sname()) FOR [CreatedBy];
GO

ALTER TABLE [dbo].[StreamingService]
    ADD CONSTRAINT [DF_StreamingService_CreatedUtc] DEFAULT (getutcdate()) FOR [CreatedUtc];
GO

EXECUTE sp_addextendedproperty @name = N'CreatedDate', @value = N'11/22/2025', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService';
GO

EXECUTE sp_addextendedproperty @name = N'Version', @value = N'1.0', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService';
GO

EXECUTE sp_addextendedproperty @name = N'CreatedBy', @value = N'Carlos', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService';
GO

EXECUTE sp_addextendedproperty @name = N'SQLVERSION', @value = N'SQL Azure 12.0.2000.8', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService';
GO

EXECUTE sp_addextendedproperty @name = N'CODEOWNER', @value = N'CARLOS', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService';
GO

EXECUTE sp_addextendedproperty @name = N'ModifiedDate', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService';
GO

EXECUTE sp_addextendedproperty @name = N'ModifiedBy', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService';
GO

EXECUTE sp_addextendedproperty @name = N'Description', @value = N'The StreamingService streaming service source', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'StreamingService';
GO

ALTER TABLE [dbo].[StreamingService]
    ADD CONSTRAINT [PK_StreamingService] PRIMARY KEY CLUSTERED ([ServiceId] ASC);
GO

