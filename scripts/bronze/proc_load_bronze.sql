/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try
		set @batch_start_time = getdate();
		print '======================================';
		print 'Loading Bronze Layer';
		print '======================================';
	
		print '--------------------------------------';
		print 'Loading CRM tables';
		print '--------------------------------------';

		set @start_time = getdate();
		print '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		print '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info 
		from 'C:\Users\mayan\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with(
			firstrow = 2,
			fieldterminator =',',
			tablock
		);
		set @end_time = GETDATE(); 
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '>> --------------'

		set @start_time = getdate();
		print '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		print '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info 
		from 'C:\Users\mayan\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with(
			firstrow = 2,
			fieldterminator =',',
			tablock
		);
		set @end_time = GETDATE(); 
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '>> --------------'

		set @start_time = getdate();
		print '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		print '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details 
		from 'C:\Users\mayan\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with(
			firstrow = 2,
			fieldterminator =',',
			tablock
		);
		set @end_time = GETDATE(); 
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '>> --------------'

		print '--------------------------------------';
		print 'Loading ERP Tables';
		print '--------------------------------------';
		
		set @start_time = getdate();
		print '>> Truncating Table: bronze.erp_CUST_AZ12';
		TRUNCATE TABLE bronze.erp_CUST_AZ12;

		print '>> Inserting Data Into: bronze.erp_CUST_AZ12';
		BULK INSERT bronze.erp_CUST_AZ12 
		from 'C:\Users\mayan\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		with(
			firstrow = 2,
			fieldterminator =',',
			tablock
		);
		set @end_time = GETDATE(); 
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '>> --------------'

		set @start_time = getdate();
		print '>> Truncating Table: bronze.erp_LOC_A101';
		TRUNCATE TABLE bronze.erp_LOC_A101;

		print '>> Inserting Data Into: bronze.erp_LOC_A101';
		BULK INSERT bronze.erp_LOC_A101 
		from 'C:\Users\mayan\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		with(
			firstrow = 2,
			fieldterminator =',',
			tablock
		);
		set @end_time = GETDATE(); 
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '>> --------------'

		set @start_time = getdate();
		print '>> Truncating Table: bronze.erp_PX_CAT_G1V2';
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

		print '>> Inserting Data Into: bronze.erp_PX_CAT_G1V2';
		BULK INSERT bronze.erp_PX_CAT_G1V2 
		from 'C:\Users\mayan\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		with(
			firstrow = 2,
			fieldterminator =',',
			tablock
		);
		set @end_time = GETDATE(); 
		print '>> Load Duration: ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds';
		print '>> --------------'

		set @batch_end_time = getdate();
		print '======================================';
		print 'Loading Bronze Layer is Completed:';
		print 'Totl Load Duration: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + 'seconds';
		print '======================================';
		

		end try
		begin catch
		print '======================================';
		print 'ERROR OCCURS DURING LOADING BRONZE LAYER';
		print 'Error Message' + ERROR_MESSAGE();
		print 'Error Message' + CAST(ERROR_MESSAGE() AS NVARCHAR);
		print 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		print '======================================';

		end catch
end
