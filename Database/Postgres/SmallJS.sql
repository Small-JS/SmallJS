--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.1

-- Started on 2024-12-24 20:44:01

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
-- TOC entry 217 (class 1259 OID 16465)
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
-- TOC entry 218 (class 1259 OID 16468)
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
-- TOC entry 4923 (class 0 OID 0)
-- Dependencies: 218
-- Name: Order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Order_id_seq" OWNED BY public."Order".id;


--
-- TOC entry 219 (class 1259 OID 16469)
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
-- TOC entry 220 (class 1259 OID 16474)
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
-- TOC entry 4924 (class 0 OID 0)
-- Dependencies: 220
-- Name: Person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Person_id_seq" OWNED BY public."Person".id;


--
-- TOC entry 221 (class 1259 OID 16475)
-- Name: Product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Product" (
    id integer NOT NULL,
    name text NOT NULL,
    price integer
);


ALTER TABLE public."Product" OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16480)
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
-- TOC entry 4925 (class 0 OID 0)
-- Dependencies: 222
-- Name: Product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Product_id_seq" OWNED BY public."Product".id;


--
-- TOC entry 4752 (class 2604 OID 16481)
-- Name: Order id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order" ALTER COLUMN id SET DEFAULT nextval('public."Order_id_seq"'::regclass);


--
-- TOC entry 4753 (class 2604 OID 16482)
-- Name: Person id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Person" ALTER COLUMN id SET DEFAULT nextval('public."Person_id_seq"'::regclass);


--
-- TOC entry 4754 (class 2604 OID 16483)
-- Name: Product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product" ALTER COLUMN id SET DEFAULT nextval('public."Product_id_seq"'::regclass);


--
-- TOC entry 4911 (class 0 OID 16465)
-- Dependencies: 217
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Order" VALUES (1, 1, 1, 10);
INSERT INTO public."Order" VALUES (2, 1, 2, 5);
INSERT INTO public."Order" VALUES (3, 2, 3, 2);


--
-- TOC entry 4913 (class 0 OID 16469)
-- Dependencies: 219
-- Data for Name: Person; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Person" VALUES (1, 'John', '3faa016d7bff29d2a5cefda632f42899c3d9e955f8c28e0994ee316d000082a9', 858185);
INSERT INTO public."Person" VALUES (2, 'Michael', '086ef341030ba97592ad54629f7773daca2a1b58b6ec481179887010ecdf8870', 351360);
INSERT INTO public."Person" VALUES (3, 'Robert', '35e2b3530c3b7b2c7c0ae6670a1a6eb60a2e9e57c3c393f4a0ceaf11e71351ff', 484813);


--
-- TOC entry 4915 (class 0 OID 16475)
-- Dependencies: 221
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Product" VALUES (1, 'Apple', 100);
INSERT INTO public."Product" VALUES (2, 'Orange', 150);
INSERT INTO public."Product" VALUES (3, 'Mango', 220);


--
-- TOC entry 4926 (class 0 OID 0)
-- Dependencies: 218
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 3, true);


--
-- TOC entry 4927 (class 0 OID 0)
-- Dependencies: 220
-- Name: Person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Person_id_seq"', 452, true);


--
-- TOC entry 4928 (class 0 OID 0)
-- Dependencies: 222
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 3, true);


--
-- TOC entry 4756 (class 2606 OID 16485)
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- TOC entry 4761 (class 2606 OID 16487)
-- Name: Person Person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Person"
    ADD CONSTRAINT "Person_pkey" PRIMARY KEY (id);


--
-- TOC entry 4763 (class 2606 OID 16489)
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- TOC entry 4757 (class 1259 OID 16490)
-- Name: fki_Order - Person; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Order - Person" ON public."Order" USING btree (person);


--
-- TOC entry 4758 (class 1259 OID 16491)
-- Name: fki_Order - Person 2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Order - Person 2" ON public."Order" USING btree (person);


--
-- TOC entry 4759 (class 1259 OID 16492)
-- Name: fki_Order - Product; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "fki_Order - Product" ON public."Order" USING btree (product);


--
-- TOC entry 4764 (class 2606 OID 16493)
-- Name: Order Order - Person; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order - Person" FOREIGN KEY (person) REFERENCES public."Person"(id) NOT VALID;


--
-- TOC entry 4765 (class 2606 OID 16498)
-- Name: Order Order - Product; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order - Product" FOREIGN KEY (product) REFERENCES public."Product"(id) NOT VALID;


-- Completed on 2024-12-24 20:44:01

--
-- PostgreSQL database dump complete
--

