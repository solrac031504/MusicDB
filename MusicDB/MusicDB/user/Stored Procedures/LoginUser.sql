/*
-- ======================================================
-- Author:        Carlos Gonzalez
-- Date Created:  2025-12-13
-- Description:   Login a user and update the count, time, and origin of the last login
---------------------------------------------------------
-- YYYY-MM-DD - Author - Change
-- 2025-12-20 - Carlos Gonzalez - Added output error message, admin flag, and login expiration datetime
-- ======================================================
*/
CREATE PROCEDURE [user].[LoginUser]
	@pUserName				NVARCHAR(50)
	, @pPassword			BINARY(32)
	, @pLastLoginOrigin		NVARCHAR(50)
	, @poAuthenticated		BIT				OUTPUT
	, @poAuthExpiration		DATETIME		OUTPUT
	, @poIsAdmin			BIT				OUTPUT
	, @poErrorMessage		NVARCHAR(255)	OUTPUT
AS

BEGIN

BEGIN TRY
SET NOCOUNT ON
SET XACT_ABORT ON

-- Initialize vars
SET @poAuthenticated = 0;
SET @poAuthExpiration = NULL;
SET @poIsAdmin = 0;
SET @poErrorMessage = NULL;

-- Declare vars
DECLARE 
@LoginId					INT			= NULL
, @IsActive					BIT			= 0
;

-- Get the user
SELECT
	@LoginId = u.LoginId
	, @poIsAdmin = u.IsAdmin
	, @IsActive = u.IsActive
FROM
	[user].[Login] AS u
WHERE
	1=1
	AND u.UserName = @pUserName
	AND u.[Password] = @pPassword
;

/*
-- ======================================================
-- Check if user exists
-- ======================================================
*/
IF @LoginId IS NULL
BEGIN
	RAISERROR(N'Invalid username or password', 16, 1);
END

/*
-- ======================================================
-- Check if user is active
-- ======================================================
*/
IF @IsActive = 0
BEGIN
	RAISERROR(N'Login is deactivated', 16, 1);
END

/*
-- ======================================================
-- If the user exists and is active, set authenticated = 1 and update login
-- ======================================================
*/
SET @poAuthenticated = 1;
SET @poAuthExpiration = DATEADD(hour, 2, GETUTCDATE());

BEGIN TRANSACTION

UPDATE
	u
SET
	u.LastLoginDate = GETUTCDATE()
	, u.LastLoginOrigin = @pLastLoginOrigin
	, u.LoginCount = u.LoginCount + 1
	, u.ModifiedBy = SUSER_SNAME()
	, u.ModifiedUtc = GETUTCDATE()
FROM
	[user].[Login] AS u
WHERE
	1=1
	AND u.LoginId = @LoginId
;

COMMIT TRANSACTION

/*
-- ======================================================
-- Error handling
-- ======================================================
*/
END TRY

BEGIN CATCH

	-- Capture error message
	SET @poErrorMessage = ERROR_MESSAGE();
	SET @poAuthenticated = 0;
	SET @poAuthExpiration = NULL;
	SET @poIsAdmin = 0;

	IF (@@TRANCOUNT > 0)
	BEGIN
		ROLLBACK TRANSACTION
	END

	;THROW

END CATCH

END

GO

-- ******************************
-- EXTENDED PROPERTIES
-- ******************************
EXEC sys.sp_addextendedproperty
	@name = N'Description'
	, @value = N'Autheticates a user login and updates login stats'
	, @level0type = N'SCHEMA'
	, @level0name = N'user'
	, @level1type = N'PROCEDURE'
	, @level1name = N'LoginUser';
GO

EXEC sys.sp_addextendedproperty
	@name = N'MS_Description'
	, @value = N'The username being used to login'
	, @level0type = N'SCHEMA'
	, @level0name = N'user'
	, @level1type = N'PROCEDURE'
	, @level1name = N'LoginUser'
	, @level2type = N'PARAMETER'
	, @level2name = N'@pUserName';
GO

EXEC sys.sp_addextendedproperty
	@name = N'MS_Description'
	, @value = N'The password being used to login'
	, @level0type = N'SCHEMA'
	, @level0name = N'user'
	, @level1type = N'PROCEDURE'
	, @level1name = N'LoginUser'
	, @level2type = N'PARAMETER'
	, @level2name = N'@pPassword';
GO

EXEC sys.sp_addextendedproperty
	@name = N'MS_Description'
	, @value = N'Tracks the origin from which the last successful login was triggered'
	, @level0type = N'SCHEMA'
	, @level0name = N'user'
	, @level1type = N'PROCEDURE'
	, @level1name = N'LoginUser'
	, @level2type = N'PARAMETER'
	, @level2name = N'@pLastLoginOrigin';
GO

EXEC sys.sp_addextendedproperty
	@name = N'MS_Description'
	, @value = N'Outputs if the login info was successfully authenticated'
	, @level0type = N'SCHEMA'
	, @level0name = N'user'
	, @level1type = N'PROCEDURE'
	, @level1name = N'LoginUser'
	, @level2type = N'PARAMETER'
	, @level2name = N'@poAuthenticated';
GO

EXEC sys.sp_addextendedproperty
	@name = N'MS_Description'
	, @value = N'Returns when the login will expire. When it has expired, the website will require the user to login again'
	, @level0type = N'SCHEMA'
	, @level0name = N'user'
	, @level1type = N'PROCEDURE'
	, @level1name = N'LoginUser'
	, @level2type = N'PARAMETER'
	, @level2name = N'@poAuthExpiration';
GO

EXEC sys.sp_addextendedproperty
	@name = N'MS_Description'
	, @value = N'Outputs if the user is a website admin'
	, @level0type = N'SCHEMA'
	, @level0name = N'user'
	, @level1type = N'PROCEDURE'
	, @level1name = N'LoginUser'
	, @level2type = N'PARAMETER'
	, @level2name = N'@poIsAdmin';
GO

EXEC sys.sp_addextendedproperty
	@name = N'MS_Description'
	, @value = N'Outputs any error messages that may occur'
	, @level0type = N'SCHEMA'
	, @level0name = N'user'
	, @level1type = N'PROCEDURE'
	, @level1name = N'LoginUser'
	, @level2type = N'PARAMETER'
	, @level2name = N'@poErrorMessage';
GO