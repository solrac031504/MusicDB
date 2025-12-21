CREATE SCHEMA [stage];
GO

EXEC sys.sp_addextendedproperty
	@name = N'Description'
	, @value = N'Schema holding all objects for ETL fast load and upser'
	, @level0type = N'SCHEMA'
	, @level0name = N'stage';
GO