--
-- SmallJS example database for PostgreSQL
--
-- Run this script in the database "smalljs", e.g. from the pgAdmin query tool or with:
--   psql -U postgres -d smalljs -f SmallJS.sql
-- Existing tables are dropped first, so the script can be run again.
--

DROP TABLE IF EXISTS public."Order", public."Person", public."Product", public."Type" CASCADE;

-- Type

CREATE TABLE public."Type" (
    id serial NOT NULL,
    string text NOT NULL,
    "integer" integer NOT NULL,
    "float" double precision NOT NULL,
    date text NOT NULL,
    "boolean" boolean NOT NULL,
    "binary" bytea NOT NULL,
    anil integer,
    CONSTRAINT "Type_pkey" PRIMARY KEY ( id )
 );

SELECT pg_catalog.setval( 'public."Type_id_seq"', 1, false );

-- Person

CREATE TABLE public."Person" (
    id serial NOT NULL,
    name text NOT NULL,
    password text,
    salt integer,
    CONSTRAINT "Person_pkey" PRIMARY KEY ( id ),
    CONSTRAINT "Person_name" UNIQUE ( name )
 );

INSERT INTO public."Person" VALUES ( 1, 'John', '3faa016d7bff29d2a5cefda632f42899c3d9e955f8c28e0994ee316d000082a9', 858185 );
INSERT INTO public."Person" VALUES ( 2, 'Michael', '086ef341030ba97592ad54629f7773daca2a1b58b6ec481179887010ecdf8870', 351360 );
INSERT INTO public."Person" VALUES ( 3, 'Robert', '35e2b3530c3b7b2c7c0ae6670a1a6eb60a2e9e57c3c393f4a0ceaf11e71351ff', 484813 );

SELECT pg_catalog.setval( 'public."Person_id_seq"', 3, true );

-- Product

CREATE TABLE public."Product" (
    id serial NOT NULL,
    name text NOT NULL,
    price integer,
    CONSTRAINT "Product_pkey" PRIMARY KEY ( id )
 );

INSERT INTO public."Product" VALUES ( 1, 'Apple', 100 );
INSERT INTO public."Product" VALUES ( 2, 'Orange', 150 );
INSERT INTO public."Product" VALUES ( 3, 'Mango', 220 );

SELECT pg_catalog.setval( 'public."Product_id_seq"', 3, true );

-- Order

CREATE TABLE public."Order" (
    id serial NOT NULL,
    person integer NOT NULL,
    product integer NOT NULL,
    amount integer NOT NULL,
    CONSTRAINT "Order_pkey" PRIMARY KEY ( id ),
    CONSTRAINT "Order - Person" FOREIGN KEY ( person ) REFERENCES public."Person"( id ),
    CONSTRAINT "Order - Product" FOREIGN KEY ( product ) REFERENCES public."Product"( id )
 );

INSERT INTO public."Order" VALUES ( 1, 1, 1, 10 );
INSERT INTO public."Order" VALUES ( 2, 1, 2, 5 );
INSERT INTO public."Order" VALUES ( 3, 2, 3, 2 );

SELECT pg_catalog.setval( 'public."Order_id_seq"', 3, true );

CREATE INDEX "fki_Order - Person" ON public."Order" USING btree ( person );
CREATE INDEX "fki_Order - Product" ON public."Order" USING btree ( product );

