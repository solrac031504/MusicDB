CREATE TABLE [dbo].[ArtistGroupMembership]
(
    counter                 INT                 IDENTITY(1, 1)
    , GroupId               INT                 NOT NULL
    , ArtistId              INT                 NOT NULL
    , CreatedUtc            DATETIME            NOT NULL
    , CreatedBy             NVARCHAR(255)       NOT NULL
    , ModifiedUtc           DATETIME                NULL
    , ModifiedBy            NVARCHAR(255)           NULL
    , CONSTRAINT [PK_ArtistGroupMembership] PRIMARY KEY NONCLUSTERED (counter ASC)
);
GO