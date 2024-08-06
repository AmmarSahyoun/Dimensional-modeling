# Dimensional Data Warehouse,  SQL Server -> ADLS

## Overview
This repository demonstrates the **scripts** to design and implementation of a dimensional data warehouse (DW) built from a distributed Online Transaction Processing (OLTP) system in SQL Server ( the famous database AdventureWorks2016 by [Microsoft](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms) ). The project focuses on transforming the OLTP data into a star schema optimized for analytical queries in Azure Data Lake Storage (ADLS).


## Clone the repository:
```bash
git clone https://github.com/AmmarSahyoun/Dimensional-Data-Warehouse.git
```

## Architecture
* **Source:** Distributed OLTP system in SQL Server.

![OLTP](DW.jpg)

* **Target:** Dimensional data warehouse in Parquet format within Azure Data Lake Storage (ADLS). 

![OLAP](ER_StarSchema.png)

* **ETL Process:**
    * Data extraction from SQL Server tables.
    * Transformation into a dimensional star schema.
    * Data loading into Parquet files within ADLS.
* **Data Model:**
    * Snowflake schema in the OLTP system (visual representation included).
    * Star schema in the data warehouse (visual representation included).
    * Fact table with composite primary key (orderId, ItemId).
* **Reporting:** Power BI report showcasing revenue analysis by region, year, month, and product category (visual representation included).

![ER diagram](report01.png)

## Scripts
* **Copy pipeline:** Transfers data from SQL Server tables to Parquet files in ADLS.
* **Dimension table generation:** TSQL script for creating the date dimension table.
* **Star schema definition:** TSQL queries defining the dimensional star schema tables.
* **Ad-hoc queries:** Sample TSQL queries for data exploration within the data warehouse.
* **Stored Procedures and Views:** Scripts for advanced data analysis and manipulation.
* **Data Quality Checks:** Scripts for ensuring data integrity and accuracy.

## Benefits
* Improved performance for analytical queries compared to the OLTP system.
* Easier data exploration and discovery through the dimensional model.
* Ability to create reports and dashboards using Power BI.


