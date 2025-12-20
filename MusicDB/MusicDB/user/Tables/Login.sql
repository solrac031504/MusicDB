CREATE TABLE [user].[Login]
(
	LoginId					INT IDENTITY(1, 1)		NOT NULL
	, UserName				NVARCHAR(50)			NOT NULL
	, [Password]			BINARY(32)				NOT NULL
	, LoginCount			INT						NOT NULL CONSTRAINT [DF_Login_LoginCount] DEFAULT (( 0 ))
	, LastLoginDate			DATETIME					NULL
	, LastLoginOrigin		NVARCHAR(50)				NULL
    , IsActive              INT                     NOT NULL CONSTRAINT [DF_Login_IsActive] DEFAULT (( 0 ))
    , IsAdmin               INT                     NOT NULL CONSTRAINT [DF_Login_IsAdmin] DEFAULT (( 0 ))
	, CreatedBy				NVARCHAR(255)			NOT NULL CONSTRAINT [DF_Login_CreatedBy] DEFAULT (SUSER_SNAME())
	, CreatedUtc			DATETIME				NOT NULL CONSTRAINT [DF_Login_CreatedUtc] DEFAULT (GETUTCDATE())
	, ModifiedBy			NVARCHAR(255)				NULL
	, ModifiedUtc			DATETIME					NULL
	, CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED (LoginId ASC)
);
GO

-- ******************************
-- INDEXES
-- ******************************
CREATE UNIQUE NONCLUSTERED INDEX [UX_Login_UserName]
ON [user].[Login] (UserName)
INCLUDE ([Password], IsActive);
GO

-- ******************************
-- EXTENDED PROPERTIES
-- ******************************
EXEC sys.sp_addextendedproperty
    @name = N'Description'
    , @value = N'Data about individual artists'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login';
GO

EXEC sys.sp_addextendedproperty
    @name = N'CODEOWNER'
    , @value = N'CARLOS'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login';
GO

EXEC sys.sp_addextendedproperty
    @name = N'SQLVERSION'
    , @value = N'SQL Azure 12.0.2000.8'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login';
GO

EXEC sys.sp_addextendedproperty
    @name = N'Version'
    , @value = N'1.0.1'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login';
GO

EXEC sys.sp_addextendedproperty
    @name = N'CreatedDate'
    , @value = N'12/13/2025'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login';
GO

EXEC sys.sp_addextendedproperty
    @name = N'CreatedBy'
    , @value = N'Carlos'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login';
GO

EXEC sys.sp_addextendedproperty
    @name = N'ModifiedDate'
    , @value = N'12/20/2025'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login';
GO

EXEC sys.sp_addextendedproperty
    @name = N'ModifiedBy'
    , @value = N'Carlos'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login';
GO

-- ******************************
-- FIELD COMMENTS
-- ******************************
EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'PK, IDENTITY'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login'
    , @level2type = N'COLUMN'
    , @level2name = N'LoginId';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'The login username'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login'
    , @level2type = N'COLUMN'
    , @level2name = N'UserName';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'The hashed login password'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login'
    , @level2type = N'COLUMN'
    , @level2name = N'Password';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'How many times the login has been triggered'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login'
    , @level2type = N'COLUMN'
    , @level2name = N'LoginCount';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'The last time the login was matched in UTC'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login'
    , @level2type = N'COLUMN'
    , @level2name = N'LastLoginDate';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'Where the last login was triggered from'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login'
    , @level2type = N'COLUMN'
    , @level2name = N'LastLoginOrigin';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'Flags if the login is active or disabled'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login'
    , @level2type = N'COLUMN'
    , @level2name = N'IsActive';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'Flags if the user is an admin user on the website'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login'
    , @level2type = N'COLUMN'
    , @level2name = N'IsAdmin';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'Who created the record'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login'
    , @level2type = N'COLUMN'
    , @level2name = N'CreatedBy';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'When the record was created in UTC'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login'
    , @level2type = N'COLUMN'
    , @level2name = N'CreatedUtc';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'Who modified the record'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login'
    , @level2type = N'COLUMN'
    , @level2name = N'ModifiedBy';
GO

EXEC sys.sp_addextendedproperty
    @name = N'MS_Description'
    , @value = N'When the record was modified in UTC'
    , @level0type = N'SCHEMA'
    , @level0name = N'user'
    , @level1type = N'TABLE'
    , @level1name = N'Login'
    , @level2type = N'COLUMN'
    , @level2name = N'ModifiedUtc';
GO