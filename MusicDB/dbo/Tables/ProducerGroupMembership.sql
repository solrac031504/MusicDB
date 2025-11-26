CREATE TABLE [dbo].[ProducerGroupMembership]
(
    counter                 INT                 IDENTITY(1, 1)
    , ProducerGroupId       INT                 NOT NULL
    , ProducerId            INT                 NOT NULL
    , CreatedUtc            DATETIME            NOT NULL
    , CreatedBy             NVARCHAR(255)       NOT NULL
    , ModifiedUtc           DATETIME                NULL
    , ModifiedBy            NVARCHAR(255)           NULL
    , CONSTRAINT [PK_ProducerGroupMembership] PRIMARY KEY NONCLUSTERED (counter ASC)
);
GO