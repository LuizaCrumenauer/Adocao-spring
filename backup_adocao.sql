--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

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
-- Name: adocao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.adocao (
    id integer NOT NULL,
    cachorro_id integer NOT NULL,
    adotante_id integer NOT NULL,
    informacoes character varying(500) NOT NULL
);


ALTER TABLE public.adocao OWNER TO postgres;

--
-- Name: adocao_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.adocao_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.adocao_id_seq OWNER TO postgres;

--
-- Name: adocao_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.adocao_id_seq OWNED BY public.adocao.id;


--
-- Name: cachorro; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cachorro (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    raca character varying(255) NOT NULL,
    sexo character varying(255) NOT NULL,
    porte character varying(255) NOT NULL,
    adotado boolean NOT NULL
);


ALTER TABLE public.cachorro OWNER TO postgres;

--
-- Name: cachorro_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cachorro_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cachorro_id_seq OWNER TO postgres;

--
-- Name: cachorro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cachorro_id_seq OWNED BY public.cachorro.id;


--
-- Name: cachorro_imagens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cachorro_imagens (
    id_imagem integer NOT NULL,
    id_cachorro integer NOT NULL,
    caminho_imagem character varying(255) NOT NULL
);


ALTER TABLE public.cachorro_imagens OWNER TO postgres;

--
-- Name: cachorro_imagens_id_imagem_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cachorro_imagens_id_imagem_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cachorro_imagens_id_imagem_seq OWNER TO postgres;

--
-- Name: cachorro_imagens_id_imagem_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cachorro_imagens_id_imagem_seq OWNED BY public.cachorro_imagens.id_imagem;


--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    nome character varying(255) NOT NULL,
    endereco character varying(255) NOT NULL,
    cpf character varying(14) NOT NULL,
    celular character varying(14) NOT NULL,
    email character varying(255) NOT NULL,
    senha character varying(255) NOT NULL,
    isadmin boolean NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_id_seq OWNER TO postgres;

--
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- Name: adocao id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adocao ALTER COLUMN id SET DEFAULT nextval('public.adocao_id_seq'::regclass);


--
-- Name: cachorro id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cachorro ALTER COLUMN id SET DEFAULT nextval('public.cachorro_id_seq'::regclass);


--
-- Name: cachorro_imagens id_imagem; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cachorro_imagens ALTER COLUMN id_imagem SET DEFAULT nextval('public.cachorro_imagens_id_imagem_seq'::regclass);


--
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- Data for Name: adocao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.adocao (id, cachorro_id, adotante_id, informacoes) FROM stdin;
6	3	3	adotado dia 02
\.


--
-- Data for Name: cachorro; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cachorro (id, nome, raca, sexo, porte, adotado) FROM stdin;
2	Luffy	SRD	Macho	Médio	t
1	Max	Labrador Retriever	Macho	Grande	f
3	Toby	SRD	Macho	Médio	t
11	Marley	Golden	Macho	Grande	f
14	Susi	Pastor Alemão	Fêmea	Grande	f
12	Zé	SRD	Macho	Médio	f
6	Marcelino	Pincher	Macho	Pequeno	f
16	José	SRD	Macho	Grande	f
17	Olivia	SRD	Fêmea	Grande	f
18	Thor	SRD	Macho	Grande	f
20	Lola	SRD	Fêmea	Médio	f
15	Lolla	SRD	Fêmea	Médio	f
4	Bella	SRD	Fêmea	Pequeno	f
\.


--
-- Data for Name: cachorro_imagens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cachorro_imagens (id_imagem, id_cachorro, caminho_imagem) FROM stdin;
15	11	1751726702698_264292112-golden-retriever-1.webp
16	11	1751726702808_raca-de-cachorro-docil-2.jpg
17	14	1751726724376_pastor_alemao-p.jpg
18	12	1751726751103_78ptgsfeddfh638dkkzya5p3y.jpg
19	12	1751726751112_comportamento-do-vira-lata.jpg
20	12	1751726751121_vira-lata-caramelo-pode-se-tornar-manifestacao-cultural-imaterial-do-brasil-1992779-article.webp
21	15	1751726777289_depositphotos_121452170-stock-photo-dog-adoption-shelter-animal.jpg
22	15	1751726777298_istockphoto-1254477516-612x612.jpg
23	6	1751726797094_cachorro-para-adocao.jpeg
24	16	1751726861151_758c4a_d1024c4006a846d192f982d020f3a261~mv2.avif
25	17	1751726884132_Adocao-Cachorros-Cachorro-Animal.webp
26	18	1751726917110_cachorro.jpeg
28	4	1752005709469_dodz8rp9oahxqc9u53t96yiau.jpg
30	20	1752006678114_depositphotos_121452170-stock-photo-dog-adoption-shelter-animal.jpg
31	20	1752006678128_istockphoto-1254477516-612x612.jpg
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id, nome, endereco, cpf, celular, email, senha, isadmin) FROM stdin;
1	Ana Silva	Rua das Flores, 123, São Paulo, SP	111.222.333-44	(11)98765-4321	ana.silva@email.com	senha123	f
2	Carlos Admin	Avenida Principal, 789, Rio de Janeiro, RJ	999.888.777-66	(21)91234-5678	admin@admin	admin	t
3	Luiza Crumenauer	Rua Ernesto Pereira, 239	999.888.777-66	(21)91234-5677	crumenauerluiza@gmail.com	123	f
6	Betina Rios	Rua Borges	999.888.777-66	(21)91234-5677	betina@gmail.com	123	f
14	Luiza Crumenauer	Rua Cinco de Março	999.888.777-66	(21)91234-5678	luiza@gmail.com	123	f
8	Amanda Flores	Rua Ernesto Pereira, 239	999.888.777-66	(21)91234-5670	amanda@gmail.com	123	t
\.


--
-- Name: adocao_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.adocao_id_seq', 10, true);


--
-- Name: cachorro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cachorro_id_seq', 20, true);


--
-- Name: cachorro_imagens_id_imagem_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cachorro_imagens_id_imagem_seq', 31, true);


--
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_seq', 14, true);


--
-- Name: adocao adocao_cachorro_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adocao
    ADD CONSTRAINT adocao_cachorro_id_key UNIQUE (cachorro_id);


--
-- Name: adocao adocao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adocao
    ADD CONSTRAINT adocao_pkey PRIMARY KEY (id);


--
-- Name: cachorro_imagens cachorro_imagens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cachorro_imagens
    ADD CONSTRAINT cachorro_imagens_pkey PRIMARY KEY (id_imagem);


--
-- Name: cachorro cachorro_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cachorro
    ADD CONSTRAINT cachorro_pkey PRIMARY KEY (id);


--
-- Name: usuario email_unico; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT email_unico UNIQUE (email);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- Name: adocao fk_adocao_cachorro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adocao
    ADD CONSTRAINT fk_adocao_cachorro FOREIGN KEY (cachorro_id) REFERENCES public.cachorro(id) ON DELETE CASCADE;


--
-- Name: adocao fk_adocao_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.adocao
    ADD CONSTRAINT fk_adocao_usuario FOREIGN KEY (adotante_id) REFERENCES public.usuario(id) ON DELETE CASCADE;


--
-- Name: cachorro_imagens fk_cachorro_img; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cachorro_imagens
    ADD CONSTRAINT fk_cachorro_img FOREIGN KEY (id_cachorro) REFERENCES public.cachorro(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

