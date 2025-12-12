/*
-- ======================================================
-- Author:        Carlos Gonzalez
-- Date Created:  2025-11-23
-- Description:   Lists all streaming services
---------------------------------------------------------
-- YYYY-MM-DD - Author - Change
--
-- ======================================================
*/
CREATE PROCEDURE [list].[ListStreamingServices]

AS

BEGIN
BEGIN TRY

SELECT
  sts.ServiceId
  , sts.ServiceName
FROM
  dbo.StreamingService AS sts
ORDER BY
  sts.ServiceName
;

END TRY
BEGIN CATCH
  ;THROW
END CATCH

END

GO

-- ******************************
-- EXTENDED PROPERTIES
-- ******************************
EXEC sys.sp_addextendedproperty
	@name = N'Description'
	, @value = N'Lists all streaming services for parameter selection'
	, @level0type = N'SCHEMA'
	, @level0name = N'list'
	, @level1type = N'PROCEDURE'
	, @level1name = N'ListStreamingServices';
GO