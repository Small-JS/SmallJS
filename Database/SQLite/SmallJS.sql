BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "Type" (
	"id"	INTEGER NOT NULL UNIQUE,
	"string"	TEXT NOT NULL,
	"integer"	INTEGER NOT NULL,
	"float"	REAL NOT NULL,
	"date"	TEXT NOT NULL,
	"boolean"	INTEGER NOT NULL,
	"binary"	BLOB NOT NULL,
	"anil"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "Person" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL UNIQUE,
	"password"	TEXT,
	"salt"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT)
);

INSERT INTO "Person" VALUES (1,'John','3faa016d7bff29d2a5cefda632f42899c3d9e955f8c28e0994ee316d000082a9',858185);
INSERT INTO "Person" VALUES (2,'Michael','086ef341030ba97592ad54629f7773daca2a1b58b6ec481179887010ecdf8870',351360);
INSERT INTO "Person" VALUES (3,'Robert','35e2b3530c3b7b2c7c0ae6670a1a6eb60a2e9e57c3c393f4a0ceaf11e71351ff',484813);

CREATE TABLE IF NOT EXISTS "Product" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL UNIQUE,
	"price"	INTEGER,
	PRIMARY KEY("id" AUTOINCREMENT)
);

INSERT INTO "Product" VALUES (1,'Apple',100);
INSERT INTO "Product" VALUES (2,'Orange',150);
INSERT INTO "Product" VALUES (3,'Mango',220);

CREATE TABLE IF NOT EXISTS "Order" (
	"id"	INTEGER NOT NULL UNIQUE,
	"person"	INTEGER NOT NULL,
	"product"	INTEGER NOT NULL,
	"amount"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "person" FOREIGN KEY("person") REFERENCES "Person"("id"),
	CONSTRAINT "product" FOREIGN KEY("product") REFERENCES "Product"("id")
);

INSERT INTO "Order" VALUES (1,1,1,10);
INSERT INTO "Order" VALUES (2,1,2,5);
INSERT INTO "Order" VALUES (3,2,3,2);

COMMIT;
