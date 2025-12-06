CREATE TABLE [dbo].[ProducerGroupMembership]
(
    counter                 INT                 IDENTITY(1, 1)
    , ProducerGroupId       INT                 NOT NULL
    , ProducerId            INT                 NOT NULL
    , CreatedUtc            DATETIME            NOT NULL        CONSTRAINT [DF_ProducerGroupMembership_CreatedUtc] DEFAULT (GETUTCDATE())
    , CreatedBy             NVARCHAR(255)       NOT NULL        CONSTRAINT [DF_ProducerGroupMembership_CreatedBy] DEFAULT (SUSER_SNAME())
    , ModifiedUtc           DATETIME                NULL
    , ModifiedBy            NVARCHAR(255)           NULL
    , CONSTRAINT [PK_ProducerGroupMembership] PRIMARY KEY NONCLUSTERED (counter ASC)
);
GO

-- ******************************
-- INDEXES
-- ******************************
CREATE UNIQUE CLUSTERED INDEX [UX_ProducerGroupMembership_ProducerGroupId_ProducerId]
ON [dbo].[ProducerGroupMembership] (ProducerGroupId, ProducerId);
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