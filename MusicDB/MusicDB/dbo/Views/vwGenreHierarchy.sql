/*
-- ======================================================
-- Author:        Carlos Gonzalez
-- Date Created:  2025-12-21
-- Description:   Displays the full hierarchy of the Genres and the root genre they fall under
---------------------------------------------------------
-- YYYY-MM-DD - Author - Change
--
-- ======================================================
*/
CREATE VIEW [dbo].[vwGenreHierarchy]
AS

WITH cte_GenreHierarchy AS
(
	-- Anchor: Get all root nodes (no parent)
    SELECT 
        g.GenreId
        , g.GenreName
        , CAST(g.GenreName AS NVARCHAR(MAX)) AS HierarchyPath
        , gh.ParentGenreId
        , 1 AS [Level]
        , g.GenreName AS RootGenre
        , g.GenreId AS RootGenreId
    FROM 
        dbo.Genre AS g
        JOIN dbo.GenreHierarchy AS gh 
            ON g.GenreId = gh.GenreId
    WHERE 
        gh.ParentGenreId = -1
    
    UNION ALL
    
    -- Recursive: Get children
    SELECT 
        g.GenreId
        , g.GenreName
        , CAST(CONCAT(cte.HierarchyPath, ' > ', g.GenreName) AS NVARCHAR(MAX))
        , gh.ParentGenreId
        , cte.[Level] + 1
        , cte.RootGenre
        , cte.RootGenreId
    FROM 
        dbo.Genre AS g
        JOIN dbo.GenreHierarchy AS gh 
            ON g.GenreId = gh.GenreId
        JOIN cte_GenreHierarchy AS cte 
            ON gh.ParentGenreId = cte.GenreId
    WHERE 
        gh.ParentGenreId <> -1
)
SELECT 
    cgh.GenreId
    , cgh.GenreName
    , cgh.HierarchyPath
    , cgh.ParentGenreId
    , cgh.[Level]
    , cgh.RootGenre
    , cgh.RootGenreId
FROM 
    cte_GenreHierarchy AS cgh
;

GO