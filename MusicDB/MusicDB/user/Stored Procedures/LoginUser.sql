/*
-- ======================================================
-- Author:        Carlos Gonzalez
-- Date Created:  2025-12-13
-- Description:   Login a user and update the count, time, and origin of the last login
---------------------------------------------------------
-- YYYY-MM-DD - Author - Change
--
-- ======================================================
*/
CREATE PROCEDURE [user].[LoginUser]
	@pUserName				NVARCHAR(50)
	, @pPassword			BINARY(32)
	, @pLastLoginOrigin		NVARCHAR(50)
	, @poAuthenticated		BIT OUTPUT
AS

BEGIN

BEGIN TRY
SET NOCOUNT ON

/*
-- ======================================================
-- If login exists in the table, update the record
-- ======================================================
*/
IF EXISTS (SELECT 1 FROM [user].[Login] AS u WHERE u.UserName = @pUserName AND u.[Password] = @pPassword AND u.IsActive = 1)
	BEGIN
		SET @poAuthenticated = 1;

		SET XACT_ABORT ON
		BEGIN TRANSACTION

		UPDATE
			ul
		SET
			ul.LoginCount = ul.LoginCount + 1
			, ul.LastLoginDate = GETUTCDATE()
			, ul.LastLoginOrigin = @pLastLoginOrigin
			, ul.ModifiedBy = SUSER_SNAME()
			, ul.ModifiedUtc = GETUTCDATE()
		FROM
			[user].[Login] AS ul
		;

		COMMIT TRANSACTION
	END
ELSE
	BEGIN
		SET @poAuthenticated = 0;
	END

END TRY

BEGIN CATCH

	;THROW

END CATCH

END

GO