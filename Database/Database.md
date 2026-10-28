# SmallJS database support

SmallJS currently supports these databases: Postgres, MariaDB, MySQL and SQLite.
Note that using MySQL in commercial software requires a paid license.

# Resources

The JS "driver" (client library) for each database is already installed
in the projects `./Node` and `./Examples/Shop/Server`.

Here are the download locations for the database server and administration software.
These can be installed with their default settings.

## Postgres

- Server:   https://www.postgresql.org/download/
- Admin:    https://www.pgadmin.org/download/

## MariaDB

- Server:   https://mariadb.org/download/
- Admin:    https://www.heidisql.com/download.php

## MySQL

- Server:   https://dev.mysql.com/downloads/mysql/
- Admin:    https://dev.mysql.com/downloads/workbench/

## SQLite

- Server:   Is built into Node.js starting version 22.5.0.
- Admin:    https://sqlitebrowser.org/dl/

# Create the SmallJS database

Start the admin tool of the database of your choice.
Then run the SQL script ./\<database name\>/SmallJS.sql from the admin tool:

- Postgres: First create a database called "smalljs", then run the script in that database.
  This can also be done with: `psql -U postgres -d smalljs -f Postgres/SmallJS.sql`
- MariaDB, MySQL: The script creates the database "smalljs" itself, if it does not exist yet.
- SQLite: No admin tool is needed. Run **./install.sh**, which creates the file **./SQLite/smalljs.db**.

The scripts drop existing tables first, so they can be run again to reset the database.
How to run a script exactly is database dependent. Check the corresponding documentation.

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
to return an array of column descriptors each with a subarray of 2 items:
    1 name: name of the SQL column name and the same accessor (also variable) in the subclass of SqlObject.
    2 type: The desired Smalltalk class of the column.
    - E.g. for Product.columns: ^ #( #( 'name' String ) #( 'price' Integer ) )'.

These Smalltalk types are supported by the ORM:
    String, Integer, Float, Date, Boolean, Uint8Array (binary / BLOB), Nil (null).

The following conversions are done due to limited database (driver) type support:
    ST Date is stored as an SQL String for all databases.
    This is because SQLite does not support a SQL Timestamp type,
    and other databases have limited precision on it,
    making a source JS Date not equal to the SQL Timestamp when retrieved.
    ST Boolean to SQL Integer for: SQLite, MariaDB.

See the test classes in ../Smalltalk/Node/Database/\<database\>/Test for this and following examples,
e.g. TestPostgresDatabase. They are run from the ./Node workspace.

## Connecting to a database

All database operations are async, so they are awaited in async methods.
Connecting to a database is done with this ST code:

    database := PostgresDatabase new.
    await database connect: connectionString.

where connectionString is something like:

    'postgresql://postgres:password@localhost:5432/smalljs'

For different databases replace PostgresDatabase with MariadbDatabase, MysqlDatabase or SqliteDatabase.
Or use "SqlDatabaseFactory newFor: connectionString" to select the class from the connection string.
When done, close the connection with "await database end".

## Connect a database table to a ST class with ORM

Then connect to a table with code ST like:

    productTable := database connectTable: 'Product' rowClass: MyProduct.

Table names are case sensitive on some databases (e.g. MariaDB and MySQL on Linux),
so use the exact name as in the SQL scripts.

Note: Tables should exist already, the ORM does not support creating them.
    A "database first" approach is taken, to keep the SQL clean and reusable elsewhere.

## Create, Read, Update, Delete (CRUD) operations

The following code examples implement CRUD operations:

### Create (insert)

Insert new product, setting its id:

    product := MyProduct new name: 'Test'.
    await productTable insert: product.

### Read (select query)

Read all products:

    products := await productTable selectAll.

Read multiple products by price:

    products := await productTable select: '`price` >= 100'.

Or with parameters:

    products := await productTable select: '`price` >= ?' with: #( 100 ).

Read single product by Id:

    product := await productTable selectId: 1.

If the id does not exist, nil is returned.

### Update

Update a product using its id:

    product name: 'Changed name'.
    await productTable update: product.

### Delete

Delete a product, using its id:

    await productTable delete: product.

## Using a database without ORM

This is done by executing SQL commands directly on the database.
Note that these are always called queries, even if they contain mutation commands.

To query a Postgres table for which there is no SqlObject mapping, you can use:

    queryResult := await database query: 'SELECT id, name FROM "Product" WHERE id = 1'.

And then read the results with:

        "queryResult fieldNames" returns: #( 'id' 'name' ).
        "queryResult rows first atJsProperty: 'name'" returns: 'Apple'.

When using a Postgres database, "queryResult" will be an instance of the class PostgresQueryResult.
Other databases will have other implementation details.
To be (more) database independent, it is recommended to use the ORM mapping functionality described above.
