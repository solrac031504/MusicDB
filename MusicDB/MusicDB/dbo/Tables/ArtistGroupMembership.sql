CREATE TABLE [dbo].[ArtistGroupMembership]
(
    counter                 INT                 IDENTITY(1, 1)
    , GroupId               INT                 NOT NULL
    , ArtistId              INT                 NOT NULL
    , CreatedUtc            DATETIME            NOT NULL        CONSTRAINT [DF_ArtistGroupMembership_CreatedUtc] DEFAULT (GETUTCDATE())
    , CreatedBy             NVARCHAR(255)       NOT NULL        CONSTRAINT [DF_ArtistGroupMembership_CreatedBy] DEFAULT (SUSER_SNAME())
    , ModifiedUtc           DATETIME                NULL
    , ModifiedBy            NVARCHAR(255)           NULL
    , CONSTRAINT [PK_ArtistGroupMembership] PRIMARY KEY NONCLUSTERED (counter ASC)
);
GO

-- ******************************
-- INDEXES
-- ******************************
CREATE UNIQUE CLUSTERED INDEX [UX_ArtistGroupMembership_GroupId_ArtistId]
ON [dbo].[ArtistGroupMembership] (GroupId, ArtistId);
GO

-- ******************************
-- CONSTRAINTS
-- ******************************
ALTER TAbLE [dbo].[ArtistGroupMembership]
ADD CONSTRAINT [FK_ArtistGroupMembership_GroupId]
FOREIGN KEY (GroupId)
REFERENCES [dbo].[Group] (GroupId);
GO

ALTER TABLE [dbo].[ArtistGroupMembership]
ADD CONSTRAINT [FK_ArtistGroupMembership_ArtistId]
FOREIGN KEY (ArtistId)
REFERENCES [dbo].[Artist] (ArtistId);
GO