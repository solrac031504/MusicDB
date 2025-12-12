CREATE SCHEMA [list];
GO

EXEC sys.sp_addextendedproperty
	@name = N'Description'
	, @value = N'Schema for listing procs'
	, @level0type = N'SCHEMA'
	, @level0name = N'list';
GO