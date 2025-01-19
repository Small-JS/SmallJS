--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.1

-- Started on 2025-01-18 16:10:24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16504)
-- Name: Order; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Order" (
    id integer NOT NULL,
    person integer NOT NULL,
    product integer NOT NULL,
    amount integer NOT NULL
);


ALTER TABLE public."Order" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16507)
-- Name: Order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Order_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Order_id_seq" OWNER TO postgres;

--
-- TOC entry 4930 (class 0 OID 0)
-- Dependencies: 218
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- TOC entry 219 (class 1259 OID 16508)
-- Name: Person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Person" (
    id integer NOT NULL,
    name text NOT NULL,
    password text,
    salt integer
);


ALTER TABLE public."Person" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16513)
-- Name: Person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Person_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Person_id_seq" OWNER TO postgres;

--
-- TOC entry 4931 (class 0 OID 0)
-- Dependencies: 220
-- Name: Person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Person_id_seq" OWNED BY public."Person".id;


--
-- TOC entry 221 (class 1259 OID 16514)
-- Name: Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Product" (
    id integer NOT NULL,
    name text NOT NULL,
    price integer
);


ALTER TABLE public."Product" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16519)
-- Name: Product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Product_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Product_id_seq" OWNER TO postgres;

--
-- TOC entry 4932 (class 0 OID 0)
-- Dependencies: 222
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;


--
-- TOC entry 224 (class 1259 OID 16545)
-- Name: Type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Type" (
    id integer NOT NULL,
    string text NOT NULL,
    "integer" integer NOT NULL,
    "float" double precision NOT NULL,
    date text NOT NULL,
    "boolean" boolean NOT NULL,
    "binary" bytea NOT NULL,
    anil integer
);


ALTER TABLE public."Type" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16544)
-- Name: Type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Type_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Type_id_seq" OWNER TO postgres;

--
-- TOC entry 4933 (class 0 OID 0)
-- Dependencies: 223
-- Name: Type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Type_id_seq" OWNED BY public."Type".id;


--
-- TOC entry 4753 (class 2604 OID 16520)
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- TOC entry 4754 (class 2604 OID 16521)
-- Name: Person id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Person" ALTER COLUMN id SET DEFAULT nextval('public."Person_id_seq"'::regclass);


--
-- TOC entry 4755 (class 2604 OID 16522)
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- TOC entry 4756 (class 2604 OID 16548)
-- Name: Type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Type" ALTER COLUMN id SET DEFAULT nextval('public."Type_id_seq"'::regclass);


--
-- TOC entry 4917 (class 0 OID 16504)
-- Dependencies: 217
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Order" VALUES (1, 1, 1, 10);
INSERT INTO public."Order" VALUES (2, 1, 2, 5);
INSERT INTO public."Order" VALUES (3, 2, 3, 2);


--
-- TOC entry 4919 (class 0 OID 16508)
-- Dependencies: 219
-- Data for Name: Person; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Person" VALUES (1, 'John', '3faa016d7bff29d2a5cefda632f42899c3d9e955f8c28e0994ee316d000082a9', 858185);
INSERT INTO public."Person" VALUES (2, 'Michael', '086ef341030ba97592ad54629f7773daca2a1b58b6ec481179887010ecdf8870', 351360);
INSERT INTO public."Person" VALUES (3, 'Robert', '35e2b3530c3b7b2c7c0ae6670a1a6eb60a2e9e57c3c393f4a0ceaf11e71351ff', 484813);


--
-- TOC entry 4921 (class 0 OID 16514)
-- Dependencies: 221
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Product" VALUES (1, 'Apple', 100);
INSERT INTO public."Product" VALUES (2, 'Orange', 150);
INSERT INTO public."Product" VALUES (3, 'Mango', 220);


--
-- TOC entry 4924 (class 0 OID 16545)
-- Dependencies: 224
-- Data for Name: Type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4934 (class 0 OID 0)
-- Dependencies: 218
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 3, true);


--
-- TOC entry 4935 (class 0 OID 0)
-- Dependencies: 220
-- Name: Person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Person_id_seq"', 637, true);


--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 222
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 3, true);


--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 223
-- Name: Type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Type_id_seq"', 41, true);


--
-- TOC entry 4758 (class 2606 OID 16524)
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- TOC entry 4763 (class 2606 OID 16543)
-- Name: Person Person_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Person"
    ADD CONSTRAINT "Person_name" UNIQUE (name);


--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 4763
-- Name: CONSTRAINT "Person_name" ON "Person"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT "Person_name" ON public."Person" IS 'Must be unique.';


--
-- TOC entry 4765 (class 2606 OID 16526)
-- Name: Person Person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Person"
    ADD CONSTRAINT "Person_pkey" PRIMARY KEY (id);


--
-- TOC entry 4767 (class 2606 OID 16528)
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- TOC entry 4769 (class 2606 OID 16552)
-- Name: Type Type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Type"
    ADD CONSTRAINT "Type_pkey" PRIMARY KEY (id);


--
-- TOC entry 4759 (class 1259 OID 16529)
-- Name: fki_Order - Person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Order - Person" ON public."Order" USING btree (person);


--
-- TOC entry 4760 (class 1259 OID 16530)
-- Name: fki_Order - Person 2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Order - Person 2" ON public."Order" USING btree (person);


--
-- TOC entry 4761 (class 1259 OID 16531)
-- Name: fki_Order - Product; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Order - Product" ON public."Order" USING btree (product);


--
-- TOC entry 4770 (class 2606 OID 16532)
-- Name: Order Order - Person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order - Person" FOREIGN KEY (person) REFERENCES public."Person"(id) NOT VALID;


--
-- TOC entry 4771 (class 2606 OID 16537)
-- Name: Order Order - Product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order - Product" FOREIGN KEY (product) REFERENCES public."Product"(id) NOT VALID;


-- Completed on 2025-01-18 16:10:25

--
-- PostgreSQL database dump complete
--

