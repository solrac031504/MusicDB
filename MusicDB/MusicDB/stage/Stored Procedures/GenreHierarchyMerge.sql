/*
-- ======================================================
-- Author:        Carlos Gonzalez
-- Date Created:  2025-12-20
-- Description:   Merges GenreHierarchy records from stage
---------------------------------------------------------
-- YYYY-MM-DD - Author - Change
-- 
-- ======================================================
*/
CREATE PROCEDURE [stage].[GenreHierarchyMerge]
	@poInsertedRows INT OUTPUT
	,@poUpdatedRows INT OUTPUT
	,@poDeletedRows INT OUTPUT
AS

BEGIN

BEGIN TRY
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRANSACTION

/*
-- ======================================================
-- Insert rows that don't exist
-- ======================================================
*/
INSERT INTO dbo.GenreHierarchy
(
	GenreId
	,ParentGenreId
)
SELECT
	src.GenreId
	,src.ParentGenreId
FROM
	stage.GenreHierarchy AS src
WHERE
	1=1
	AND NOT EXISTS
	(
		SELECT
			1
		FROM
			dbo.GenreHierarchy AS tgt
		WHERE
			1=1
			AND tgt.GenreId = src.GenreId
			AND tgt.ParentGenreId = src.ParentGenreId
	)
;

SET @poInsertedRows = @@ROWCOUNT;

COMMIT TRANSACTION

/*
-- ======================================================
-- Error handling
-- ======================================================
*/

END TRY

BEGIN CATCH

	IF (@@TRANCOUNT > 0)
		ROLLBACK TRANSACTION

	;THROW

END CATCH

END

GO