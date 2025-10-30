--
-- PostgreSQL database dump
--

\restrict 3GJcQiwad5Awh6CRUKmEJaC0Xc4tHJITk51EoLuxWbPMZj1Pye8Tqn2ucg0Orhk

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-10-27 20:48:10

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

--
-- TOC entry 5033 (class 0 OID 16389)
-- Dependencies: 219
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Order" VALUES (1, 1, 1, 10);
INSERT INTO public."Order" VALUES (2, 1, 2, 5);
INSERT INTO public."Order" VALUES (3, 2, 3, 2);


--
-- TOC entry 5035 (class 0 OID 16397)
-- Dependencies: 221
-- Data for Name: Person; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Person" VALUES (1, 'John', '3faa016d7bff29d2a5cefda632f42899c3d9e955f8c28e0994ee316d000082a9', 858185);
INSERT INTO public."Person" VALUES (2, 'Michael', '086ef341030ba97592ad54629f7773daca2a1b58b6ec481179887010ecdf8870', 351360);
INSERT INTO public."Person" VALUES (3, 'Robert', '35e2b3530c3b7b2c7c0ae6670a1a6eb60a2e9e57c3c393f4a0ceaf11e71351ff', 484813);


--
-- TOC entry 5037 (class 0 OID 16405)
-- Dependencies: 223
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Product" VALUES (1, 'Apple', 100);
INSERT INTO public."Product" VALUES (2, 'Orange', 150);
INSERT INTO public."Product" VALUES (3, 'Mango', 220);


--
-- TOC entry 5039 (class 0 OID 16413)
-- Dependencies: 225
-- Data for Name: Type; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5050 (class 0 OID 0)
-- Dependencies: 220
-- Name: Order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Order_id_seq"', 3, true);


--
-- TOC entry 5051 (class 0 OID 0)
-- Dependencies: 222
-- Name: Person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Person_id_seq"', 637, true);


--
-- TOC entry 5052 (class 0 OID 0)
-- Dependencies: 224
-- Name: Product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Product_id_seq"', 3, true);


--
-- TOC entry 5053 (class 0 OID 0)
-- Dependencies: 226
-- Name: Type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Type_id_seq"', 154, true);


-- Completed on 2025-10-27 20:48:10

--
-- PostgreSQL database dump complete
--

\unrestrict 3GJcQiwad5Awh6CRUKmEJaC0Xc4tHJITk51EoLuxWbPMZj1Pye8Tqn2ucg0Orhk

