/*
-- ======================================================
-- Author:        Carlos Gonzalez
-- Date Created:  2025-12-21
-- Description:   Lists genres in alphabetical order
--					Adds Unknown to the end of the list
---------------------------------------------------------
-- YYYY-MM-DD - Author - Change
--
-- ======================================================
*/
CREATE PROCEDURE [list].[ListGenres]
AS

BEGIN

BEGIN TRY
SET NOCOUNT ON

SELECT
	g.GenreId
	, g.GenreName
FROM
	dbo.Genre AS g
ORDER BY
	CASE
		WHEN g.GenreId = -1 THEN 1
		ELSE 0
	END
	, g.GenreName
;

END TRY

BEGIN CATCH

	;THROW

END CATCH

END

GO