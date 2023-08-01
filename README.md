### This is an OLAP system from OLTP data warehouse, contains the transactions for one day.
### With a composite primary key in the fact table that consist of (orderId, ItemId)
<br>

this repo contains:
* TSQL queries that define the star schema.
* Generate dimension date table by TSQL.
* ad-hoc queries for quick discovery.
* UAT queries for data quality and evaluation.
* ER diagram that shows entities and their relations.
* views for advanced insights.

![ER diagram](ER_StarSchema.png)
