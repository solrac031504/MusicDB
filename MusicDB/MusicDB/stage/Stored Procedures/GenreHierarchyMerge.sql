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
SET IDENTITY_INSERT dbo.Genre ON
INSERT INTO dbo.Genre
(
	GenreId
	,GenreName
	,[Description]
)
SELECT
	src.GenreId
	,src.GenreName
	,N'' AS [Description] -- import as empty and set later
FROM
	stage.Genre AS src
WHERE
	1=1
	AND NOT EXISTS
	(
		SELECT
			1
		FROM
			dbo.Genre AS tgt
		WHERE
			tgt.GenreId = src.GenreId
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