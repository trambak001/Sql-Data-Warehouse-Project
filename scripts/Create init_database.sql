Use Masters;
Go

IF EXIST(SELECT 1 FROM sys.database WHERE name = 'DataWarehouse')
Begin
  ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE Datawarehouse;
END;
GO

use master;

CREATE DATABASE DataWarhouse;

USE Datawarhouse;

CREATE Schema Bronze;
go
CREATE Schema Silver;
go
CREATE Schema Gold;
