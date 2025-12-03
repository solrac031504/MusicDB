/*
-- ======================================================
-- Author:        Carlos Gonzalez
-- Date Created:  2025-11-23
-- Description:   Lists all streaming services for parameter selection.
---------------------------------------------------------
-- YYYY-MM-DD - Author - Change
--
-- ======================================================
*/
CREATE PROCEDURE [reporting].[ListStreamingServices]

AS

BEGIN
BEGIN TRY
SET NOCOUNT ON

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