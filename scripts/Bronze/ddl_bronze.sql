/*
DDL Script : Create bronze tables 

Script perpose:
  This Script create tables in the 'Bronze' Schema. dropping existing tables
  If they are already exist.
  Run This Script to redefine the DDL Structure of 'bronze' Tables.
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze as 
begin
	DECLARE @start_time datetime, @end_time datetime,@start datetime;
	begin try
	set @start = GETDATE();
		PRINT 'Loading data into Bronze layer...';

		PRINT 'Loading CRM data...';

		set @start_time = GETDATE();
		TRUNCATE TABLE Bronze.crm_cust_info;
		BULK INSERT Bronze.crm_cust_info
		FROM 'E:\DS\Data With Bara\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock --for performance, allows other operations to access the table while the bulk insert is running
		);set @end_time = GETDATE();
		print '>> Load Duration '+ cast(datediff(second, @start_time, @end_time) as varchar) + ' seconds';

		set @start_time = GETDATE();
		TRUNCATE TABLE Bronze.crm_prd_info;
		BULK INSERT Bronze.crm_prd_info
		FROM 'E:\DS\Data With Bara\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock --for performance, allows other operations to access the table while the bulk insert is running
		);
		set @end_time = GETDATE();
		print '>> Load Duration '+ cast(datediff(second, @start_time, @end_time) as varchar) + ' seconds';

		set @start_time = GETDATE();
		TRUNCATE TABLE Bronze.crm_sales_details;
		BULK INSERT Bronze.crm_sales_details
		FROM 'E:\DS\Data With Bara\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock --for performance, allows other operations to access the table while the bulk insert is running
		);
		set @end_time = GETDATE();
		print '>> Load Duration '+ cast(datediff(second, @start_time, @end_time) as varchar) + ' seconds';

		print 'Loading ERP data...';
		set @start_time = GETDATE();
		TRUNCATE TABLE Bronze.erp_cust_AZ12;
		BULK INSERT Bronze.erp_cust_AZ12
		FROM 'E:\DS\Data With Bara\sql-data-warehouse-project\datasets\source_erp\cust_AZ12.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock --for performance, allows other operations to access the table while the bulk insert is running
		);
		set @end_time = GETDATE();
		print '>> Load Duration '+ cast(datediff(second, @start_time, @end_time) as varchar) + ' seconds';

		set @start_time = GETDATE();
		TRUNCATE TABLE Bronze.erp_loc_a101;
		BULK INSERT Bronze.erp_loc_a101
		FROM 'E:\DS\Data With Bara\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock --for performance, allows other operations to access the table while the bulk insert is running
		);
		set @end_time = GETDATE();
		print '>> Load Duration '+ cast(datediff(second, @start_time, @end_time) as varchar) + ' seconds';

		set @start_time = GETDATE();
		TRUNCATE TABLE Bronze.erp_px_cat_g1v2;
		BULK INSERT Bronze.erp_px_cat_g1v2
		FROM 'E:\DS\Data With Bara\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with(
			firstrow = 2,
			fieldterminator = ',',
			tablock --for performance, allows other operations to access the table while the bulk insert is running
		);set @end_time = GETDATE();
		print '>> Load Duration '+ cast(datediff(second, @start_time, @end_time) as varchar) + ' seconds';
		print 'Bronze layer loading completed successfully in '+ 
		cast(datediff(second,@start,@end_time)as varchar)+ ' second';
	end try
	begin catch
	print 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
	PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS VARCHAR);
	PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS VARCHAR);
	end catch
end
