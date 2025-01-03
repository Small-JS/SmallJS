# SmallJS database support

SmallJS currently supports these databases: Postgres, MariaDB, MySQL and SQLite.
Note that using MySQL in commercial software requires a payed license.

# Resources

The JS "driver" (client library) for each database is already installed
in the projects `./Node` and `./Shop/Server`.

Here are the download locations for the database server and administration software:
The these can be installed with their default settings.

## Postgres

- Server:	https://www.postgresql.org/download/
- Admin:	https://www.pgadmin.org/download/

## MariaDB

- Server:	https://mariadb.org/download/
- Admin:	https://www.heidisql.com/download.php

## MySQL

- Server:	https://dev.mysql.com/downloads/mysql/
- Admin:	https://dev.mysql.com/downloads/workbench/

## SQLite

- Server:	Is built into Nodes.js starting v 22.5.0,
			Currently (v23.5) requiring startup flag to enable it: "--experimental-sqlite".
- Admin:	https://sqlitebrowser.org/dl/

# Create the SmallJS database

Start the admin tool of the database of your choice.
First create a database called "smalljs".
Then run the SQL script ./\<database name\>/SmallJS.sql from the admin tool.

How to do this exactly is database dependent. Check the corresponding documentation.

# Testing your database

The file **./Node/.env.example** contains example connection strings to the databases.
Copy the file to **.env**, uncomment the database(s) that you want to use
and set the correct port and credentials for connecting.

Now the unit tests for these databases will be enabled automatically.
Note that database operations are always async,
so you will see an increase in the number of async tests that run.

# Object Relational Mapper (ORM)

Note: Use of the ORM is optional, see last paragraph.

A lightweight approach is taken where SQL persisted objects in ST inherit from the class SqlObject.
This base class has an 'id' variable that identifies the object in the corresponding SQL table.
So that table must have an 'id' column of type "autonumber", that is the primary key.

A subclass of SqlObject, say Product, should overload the method 'columns'
to return an array of column names in the SQL table next to 'id'
then are also equal to variable names in the SqlObject subclass.

	- E.g. for Product.columns: ^ #( 'name' 'price' )'.

See class TestDabase in the ./Node workspace for this and following examples.

## Connecting to a database

Connecting to a database is done with this line of ST code:

	database := PostgresDatabase new connect: connectionString then: [ self onConnect ].

where connectionString is something like:

	'postgres://postgres:password@localhost:5432/smalljs

For different databases please PostgresDatabase with MariadbDatabase or MysqlDatabase

## Connect a database table to a ST class with ORM

Then connect to a table with code ST like:

	productTable := database table: 'public."Product"' rowClass: Product.

Note: Tables should exist already, the ORM does not support creating them.
	A "database first" approach is taken, to keep the SQL clean and reusable elsewhere.

## Create, Read, Update, Delete (CRUD) operations

The following code examples implement CRUD operations:

### Create (insert)

Insert new product, setting its id:

	product := Product new name: 'Test'.
	productTable insert: product then: [ :product | ... ].

### Read (select query)

Read multiple products by price:

	productTable query: 'price >= 100' then: [ :products | ... ].

Read single product by Id:

	productTable queryId: 1 then: [ :product | ... ].

### Update

Update a product using its id:

	product name: 'Changed name'.
	productTable update: product then: [ ... ].

### Delete

Delete a product, using its id:

	productTable delete: product then: [ ... ].

## Using a database without ORM

This is done my executing SQL commands directly on the database.
Note that these are always called queries, even if they contain mutation commands.

To query a Postgres table for which there is no SqlObject mapping, you can use:

	database query: 'SELECT id, name FROM "Product" WHERE id = 1'
		then: [ :queryResult | self onProductQuery: queryResult ].

And then in "onProductQuery: queryResult" read the results with:

		"queryResult fieldNames" returns: #( 'id' 'name' 'price' ).
		"queryResult rows first atJsProperty: 'name'" returns: 'Apple'.

Then using a Postgress database, "queryResult" with be an instance of the class PostgresQueryResult.
Other databases will have other implementation details.
To be (more) database independent, it is recommended to use the ORM mapping functionality described above.
