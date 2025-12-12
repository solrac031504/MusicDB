CREATE TABLE [dbo].[ProducerGroupMembership]
(
    ProducerGroupId         INT                 NOT NULL
    , ProducerId            INT                 NOT NULL
    , CreatedUtc            DATETIME            NOT NULL        CONSTRAINT [DF_ProducerGroupMembership_CreatedUtc] DEFAULT (GETUTCDATE())
    , CreatedBy             NVARCHAR(255)       NOT NULL        CONSTRAINT [DF_ProducerGroupMembership_CreatedBy] DEFAULT (SUSER_SNAME())
    , ModifiedUtc           DATETIME                NULL
    , ModifiedBy            NVARCHAR(255)           NULL
    , CONSTRAINT [PK_ProducerGroupMembership] PRIMARY KEY CLUSTERED (ProducerGroupId ASC, ProducerId ASC)
);
GO

-- ******************************
-- CONSTRAINTS
-- ******************************
ALTER TABLE [dbo].[ProducerGroupMembership]
ADD CONSTRAINT [FK_ProducerGroupMembership_ProducerGroupId]
FOREIGN KEY (ProducerGroupId)
REFERENCES [dbo].[ProducerGroup] (ProducerGroupId);
GO

ALTER TABLE [dbo].[ProducerGroupMembership]
ADD CONSTRAINT [FK_ProducerGroupMembership_ProducerId]
FOREIGN KEY (ProducerId)
REFERENCES [dbo].[Producer] (ProducerId);
GO

-- ******************************
-- EXTENDED PROPERTIES
-- ******************************
EXEC sys.sp_addextendedproperty
    @name = N'Description'
    , @value = N'Tracks producer memberships in groups'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'ProducerGroupMembership';
GO