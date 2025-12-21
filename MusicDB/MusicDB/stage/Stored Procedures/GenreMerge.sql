/*
-- ======================================================
-- Author:        Carlos Gonzalez
-- Date Created:  2025-12-20
-- Description:   Merges Genre records from stage
---------------------------------------------------------
-- YYYY-MM-DD - Author - Change
-- 
-- ======================================================
*/
CREATE PROCEDURE [stage].[GenreMerge]
	@poInsertedRows INT OUTPUT
	,@poUpdatedRows INT OUTPUT
	,@poDeletedRows INT OUTPUT
AS

BEGIN

BEGIN TRY
SET NOCOUNT ON
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

/*
-- ======================================================
-- Update rows if they exist
-- ======================================================
*/
UPDATE
	tgt
SET
	tgt.GenreName			= src.GenreName
	,tgt.ModifiedBy			= SUSER_SNAME()
	,tgt.ModifiedUtc		 = GETUTCDATE()
FROM
	dbo.Genre AS tgt
	JOIN stage.Genre AS src
		ON tgt.GenreId = src.GenreId
;

SET @poUpdatedRows = @@ROWCOUNT;

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

END TRY

BEGIN CATCH

	;THROW

END CATCH

END

GO