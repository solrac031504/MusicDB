CREATE TABLE [dbo].[ArtistGroupMembership]
(
    GroupId                 INT                 NOT NULL
    , ArtistId              INT                 NOT NULL
    , CreatedUtc            DATETIME            NOT NULL        CONSTRAINT [DF_ArtistGroupMembership_CreatedUtc] DEFAULT (GETUTCDATE())
    , CreatedBy             NVARCHAR(255)       NOT NULL        CONSTRAINT [DF_ArtistGroupMembership_CreatedBy] DEFAULT (SUSER_SNAME())
    , ModifiedUtc           DATETIME                NULL
    , ModifiedBy            NVARCHAR(255)           NULL
    , CONSTRAINT [PK_ArtistGroupMembership] PRIMARY KEY CLUSTERED (GroupId ASC, ArtistId ASC)
);
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

-- ******************************
-- EXTENDED PROPERTIES
-- ******************************
EXEC sys.sp_addextendedproperty
    @name = N'Description'
    , @value = N'Tracks artist memberships in groups'
    , @level0type = N'SCHEMA'
    , @level0name = N'dbo'
    , @level1type = N'TABLE'
    , @level1name = N'ArtistGroupMembership';
GO