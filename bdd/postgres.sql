--
-- PostgreSQL database dump
--

-- Dumped from database version 13.19 (Debian 13.19-1.pgdg120+1)
-- Dumped by pg_dump version 13.19 (Debian 13.19-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.vote_thread DROP CONSTRAINT IF EXISTS vote_thread_thread_id_fkey;
ALTER TABLE IF EXISTS ONLY public.vote_thread DROP CONSTRAINT IF EXISTS vote_thread_author_uuid_fkey;
ALTER TABLE IF EXISTS ONLY public.vote_reply DROP CONSTRAINT IF EXISTS vote_reply_reply_fk_fkey;
ALTER TABLE IF EXISTS ONLY public.vote_reply DROP CONSTRAINT IF EXISTS vote_reply_author_fk_fkey;
ALTER TABLE IF EXISTS ONLY public.token DROP CONSTRAINT IF EXISTS token_userid_fkey;
ALTER TABLE IF EXISTS ONLY public.thread DROP CONSTRAINT IF EXISTS fk_thread_forum;
ALTER TABLE IF EXISTS ONLY public.thread DROP CONSTRAINT IF EXISTS fk_thread_author;
ALTER TABLE IF EXISTS ONLY public.reply DROP CONSTRAINT IF EXISTS fk_post_thread;
ALTER TABLE IF EXISTS ONLY public.reply DROP CONSTRAINT IF EXISTS fk_post_response;
ALTER TABLE IF EXISTS ONLY public.reply DROP CONSTRAINT IF EXISTS fk_post_author;
ALTER TABLE IF EXISTS ONLY public.privatemessage DROP CONSTRAINT IF EXISTS fk_pm_recipient;
ALTER TABLE IF EXISTS ONLY public.privatemessage DROP CONSTRAINT IF EXISTS fk_pm_conversation;
ALTER TABLE IF EXISTS ONLY public.privatemessage DROP CONSTRAINT IF EXISTS fk_pm_author;
ALTER TABLE IF EXISTS ONLY public."group" DROP CONSTRAINT IF EXISTS fk_group_forum;
ALTER TABLE IF EXISTS ONLY public.conversation DROP CONSTRAINT IF EXISTS fk_conversation_author;
ALTER TABLE IF EXISTS ONLY public.banhammer DROP CONSTRAINT IF EXISTS fk_ban_user;
ALTER TABLE IF EXISTS ONLY public.banhammer DROP CONSTRAINT IF EXISTS fk_ban_forum;
ALTER TABLE IF EXISTS ONLY public.thread DROP CONSTRAINT IF EXISTS thread_pkey;
ALTER TABLE IF EXISTS ONLY public."right" DROP CONSTRAINT IF EXISTS right_pkey;
ALTER TABLE IF EXISTS ONLY public.privatemessage DROP CONSTRAINT IF EXISTS privatemessage_pkey;
ALTER TABLE IF EXISTS ONLY public.reply DROP CONSTRAINT IF EXISTS post_pkey;
ALTER TABLE IF EXISTS ONLY public."group" DROP CONSTRAINT IF EXISTS group_pkey;
ALTER TABLE IF EXISTS ONLY public.forum DROP CONSTRAINT IF EXISTS forum_pkey;
ALTER TABLE IF EXISTS ONLY public.disease DROP CONSTRAINT IF EXISTS disease_pkey;
ALTER TABLE IF EXISTS ONLY public.conversation DROP CONSTRAINT IF EXISTS conversation_pkey;
ALTER TABLE IF EXISTS ONLY public.banhammer DROP CONSTRAINT IF EXISTS banhammer_pkey;
ALTER TABLE IF EXISTS ONLY public.article DROP CONSTRAINT IF EXISTS article_pkey;
ALTER TABLE IF EXISTS ONLY public.account DROP CONSTRAINT IF EXISTS account_pkey;
ALTER TABLE IF EXISTS public.vote_thread ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.vote_reply ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.thread ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.subscribe ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public."right" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.reply ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.privatemessage ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public."group" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.forum ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.disease ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.conversation ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.banhammer ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.article ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.vote_thread_id_seq;
DROP TABLE IF EXISTS public.vote_thread;
DROP SEQUENCE IF EXISTS public.vote_reply_id_seq;
DROP TABLE IF EXISTS public.vote_reply;
DROP TABLE IF EXISTS public.token;
DROP SEQUENCE IF EXISTS public.thread_id_seq;
DROP TABLE IF EXISTS public.thread;
DROP SEQUENCE IF EXISTS public.subscribe_id_seq;
DROP TABLE IF EXISTS public.subscribe;
DROP SEQUENCE IF EXISTS public.right_id_seq;
DROP TABLE IF EXISTS public."right";
DROP SEQUENCE IF EXISTS public.reply_id_seq;
DROP TABLE IF EXISTS public.reply;
DROP SEQUENCE IF EXISTS public.privatemessage_id_seq;
DROP TABLE IF EXISTS public.privatemessage;
DROP SEQUENCE IF EXISTS public.group_id_seq;
DROP TABLE IF EXISTS public."group";
DROP SEQUENCE IF EXISTS public.forum_id_seq;
DROP TABLE IF EXISTS public.forum;
DROP SEQUENCE IF EXISTS public.disease_id_seq;
DROP TABLE IF EXISTS public.disease;
DROP SEQUENCE IF EXISTS public.conversation_id_seq;
DROP TABLE IF EXISTS public.conversation;
DROP SEQUENCE IF EXISTS public.banhammer_id_seq;
DROP TABLE IF EXISTS public.banhammer;
DROP SEQUENCE IF EXISTS public.article_id_seq;
DROP TABLE IF EXISTS public.article;
DROP TABLE IF EXISTS public.account;
DROP EXTENSION IF EXISTS "uuid-ossp";
--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public.account (
    uuid uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    firstname character varying(100) NOT NULL,
    lastname character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    phone character varying(50) NOT NULL,
    karma integer DEFAULT 0 NOT NULL,
    global_bantime bigint DEFAULT '0'::bigint NOT NULL,
    validated boolean DEFAULT false NOT NULL
);


ALTER TABLE public.account OWNER TO chronoadmin;

--
-- Name: article; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public.article (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    content text,
    ratio integer DEFAULT 0,
    created_at timestamp without time zone,
    source character varying(255),
    cover_img_url character varying(255)
);


ALTER TABLE public.article OWNER TO chronoadmin;

--
-- Name: article_id_seq; Type: SEQUENCE; Schema: public; Owner: chronoadmin
--

CREATE SEQUENCE public.article_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.article_id_seq OWNER TO chronoadmin;

--
-- Name: article_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chronoadmin
--

ALTER SEQUENCE public.article_id_seq OWNED BY public.article.id;


--
-- Name: banhammer; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public.banhammer (
    id integer NOT NULL,
    account_fk uuid,
    forum_id integer,
    bantime character varying(255)
);


ALTER TABLE public.banhammer OWNER TO chronoadmin;

--
-- Name: banhammer_id_seq; Type: SEQUENCE; Schema: public; Owner: chronoadmin
--

CREATE SEQUENCE public.banhammer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.banhammer_id_seq OWNER TO chronoadmin;

--
-- Name: banhammer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chronoadmin
--

ALTER SEQUENCE public.banhammer_id_seq OWNED BY public.banhammer.id;


--
-- Name: conversation; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public.conversation (
    id integer NOT NULL,
    created_at timestamp without time zone,
    author_uuid uuid
);


ALTER TABLE public.conversation OWNER TO chronoadmin;

--
-- Name: conversation_id_seq; Type: SEQUENCE; Schema: public; Owner: chronoadmin
--

CREATE SEQUENCE public.conversation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conversation_id_seq OWNER TO chronoadmin;

--
-- Name: conversation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chronoadmin
--

ALTER SEQUENCE public.conversation_id_seq OWNED BY public.conversation.id;


--
-- Name: disease; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public.disease (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    symptomes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


ALTER TABLE public.disease OWNER TO chronoadmin;

--
-- Name: disease_id_seq; Type: SEQUENCE; Schema: public; Owner: chronoadmin
--

CREATE SEQUENCE public.disease_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.disease_id_seq OWNER TO chronoadmin;

--
-- Name: disease_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chronoadmin
--

ALTER SEQUENCE public.disease_id_seq OWNED BY public.disease.id;


--
-- Name: forum; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public.forum (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    img_url character varying(255),
    is_archived boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.forum OWNER TO chronoadmin;

--
-- Name: forum_id_seq; Type: SEQUENCE; Schema: public; Owner: chronoadmin
--

CREATE SEQUENCE public.forum_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forum_id_seq OWNER TO chronoadmin;

--
-- Name: forum_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chronoadmin
--

ALTER SEQUENCE public.forum_id_seq OWNED BY public.forum.id;


--
-- Name: group; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public."group" (
    id integer NOT NULL,
    name character varying(255),
    forum_id integer
);


ALTER TABLE public."group" OWNER TO chronoadmin;

--
-- Name: group_id_seq; Type: SEQUENCE; Schema: public; Owner: chronoadmin
--

CREATE SEQUENCE public.group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.group_id_seq OWNER TO chronoadmin;

--
-- Name: group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chronoadmin
--

ALTER SEQUENCE public.group_id_seq OWNED BY public."group".id;


--
-- Name: privatemessage; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public.privatemessage (
    id integer NOT NULL,
    message text NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    author_uuid uuid,
    recipient_fk uuid,
    conversation_fk integer
);


ALTER TABLE public.privatemessage OWNER TO chronoadmin;

--
-- Name: privatemessage_id_seq; Type: SEQUENCE; Schema: public; Owner: chronoadmin
--

CREATE SEQUENCE public.privatemessage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.privatemessage_id_seq OWNER TO chronoadmin;

--
-- Name: privatemessage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chronoadmin
--

ALTER SEQUENCE public.privatemessage_id_seq OWNED BY public.privatemessage.id;


--
-- Name: reply; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public.reply (
    id integer NOT NULL,
    content text NOT NULL,
    ratio integer DEFAULT 0,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    author_uuid uuid,
    thread_fk integer,
    response_to_fk integer
);


ALTER TABLE public.reply OWNER TO chronoadmin;

--
-- Name: reply_id_seq; Type: SEQUENCE; Schema: public; Owner: chronoadmin
--

CREATE SEQUENCE public.reply_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reply_id_seq OWNER TO chronoadmin;

--
-- Name: reply_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chronoadmin
--

ALTER SEQUENCE public.reply_id_seq OWNED BY public.reply.id;


--
-- Name: right; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public."right" (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public."right" OWNER TO chronoadmin;

--
-- Name: right_id_seq; Type: SEQUENCE; Schema: public; Owner: chronoadmin
--

CREATE SEQUENCE public.right_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.right_id_seq OWNER TO chronoadmin;

--
-- Name: right_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chronoadmin
--

ALTER SEQUENCE public.right_id_seq OWNED BY public."right".id;


--
-- Name: subscribe; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public.subscribe (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    "accountUuid" uuid,
    "forumId" integer
);


ALTER TABLE public.subscribe OWNER TO chronoadmin;

--
-- Name: subscribe_id_seq; Type: SEQUENCE; Schema: public; Owner: chronoadmin
--

CREATE SEQUENCE public.subscribe_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscribe_id_seq OWNER TO chronoadmin;

--
-- Name: subscribe_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chronoadmin
--

ALTER SEQUENCE public.subscribe_id_seq OWNED BY public.subscribe.id;


--
-- Name: thread; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public.thread (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    img_url character varying(255),
    ratio integer DEFAULT 0,
    is_archived boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    author_uuid uuid,
    forum_id integer
);


ALTER TABLE public.thread OWNER TO chronoadmin;

--
-- Name: thread_id_seq; Type: SEQUENCE; Schema: public; Owner: chronoadmin
--

CREATE SEQUENCE public.thread_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.thread_id_seq OWNER TO chronoadmin;

--
-- Name: thread_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chronoadmin
--

ALTER SEQUENCE public.thread_id_seq OWNED BY public.thread.id;


--
-- Name: token; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public.token (
    uuid uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    expire_at timestamp without time zone DEFAULT ((now() + '01:00:00'::interval))::timestamp without time zone NOT NULL,
    token text,
    type text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    revoked boolean DEFAULT false NOT NULL
);


ALTER TABLE public.token OWNER TO chronoadmin;

--
-- Name: vote_reply; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public.vote_reply (
    id integer NOT NULL,
    author_fk uuid NOT NULL,
    reply_fk integer NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    vote_type boolean NOT NULL
);


ALTER TABLE public.vote_reply OWNER TO chronoadmin;

--
-- Name: vote_reply_id_seq; Type: SEQUENCE; Schema: public; Owner: chronoadmin
--

CREATE SEQUENCE public.vote_reply_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vote_reply_id_seq OWNER TO chronoadmin;

--
-- Name: vote_reply_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chronoadmin
--

ALTER SEQUENCE public.vote_reply_id_seq OWNED BY public.vote_reply.id;


--
-- Name: vote_thread; Type: TABLE; Schema: public; Owner: chronoadmin
--

CREATE TABLE public.vote_thread (
    id integer NOT NULL,
    vote_type boolean NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    author_uuid uuid NOT NULL,
    thread_id integer NOT NULL
);


ALTER TABLE public.vote_thread OWNER TO chronoadmin;

--
-- Name: vote_thread_id_seq; Type: SEQUENCE; Schema: public; Owner: chronoadmin
--

CREATE SEQUENCE public.vote_thread_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vote_thread_id_seq OWNER TO chronoadmin;

--
-- Name: vote_thread_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: chronoadmin
--

ALTER SEQUENCE public.vote_thread_id_seq OWNED BY public.vote_thread.id;


--
-- Name: article id; Type: DEFAULT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.article ALTER COLUMN id SET DEFAULT nextval('public.article_id_seq'::regclass);


--
-- Name: banhammer id; Type: DEFAULT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.banhammer ALTER COLUMN id SET DEFAULT nextval('public.banhammer_id_seq'::regclass);


--
-- Name: conversation id; Type: DEFAULT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.conversation ALTER COLUMN id SET DEFAULT nextval('public.conversation_id_seq'::regclass);


--
-- Name: disease id; Type: DEFAULT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.disease ALTER COLUMN id SET DEFAULT nextval('public.disease_id_seq'::regclass);


--
-- Name: forum id; Type: DEFAULT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.forum ALTER COLUMN id SET DEFAULT nextval('public.forum_id_seq'::regclass);


--
-- Name: group id; Type: DEFAULT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public."group" ALTER COLUMN id SET DEFAULT nextval('public.group_id_seq'::regclass);


--
-- Name: privatemessage id; Type: DEFAULT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.privatemessage ALTER COLUMN id SET DEFAULT nextval('public.privatemessage_id_seq'::regclass);


--
-- Name: reply id; Type: DEFAULT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.reply ALTER COLUMN id SET DEFAULT nextval('public.reply_id_seq'::regclass);


--
-- Name: right id; Type: DEFAULT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public."right" ALTER COLUMN id SET DEFAULT nextval('public.right_id_seq'::regclass);


--
-- Name: subscribe id; Type: DEFAULT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.subscribe ALTER COLUMN id SET DEFAULT nextval('public.subscribe_id_seq'::regclass);


--
-- Name: thread id; Type: DEFAULT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.thread ALTER COLUMN id SET DEFAULT nextval('public.thread_id_seq'::regclass);


--
-- Name: vote_reply id; Type: DEFAULT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.vote_reply ALTER COLUMN id SET DEFAULT nextval('public.vote_reply_id_seq'::regclass);


--
-- Name: vote_thread id; Type: DEFAULT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.vote_thread ALTER COLUMN id SET DEFAULT nextval('public.vote_thread_id_seq'::regclass);


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--

INSERT INTO public.account VALUES ('00000000-aaaa-bbbb-cccc-000000000001', 'John', 'Doe', 'john.doe@example.com', 'hashed_password_john', '+330123456789', 10, 0, true);
INSERT INTO public.account VALUES ('00000000-aaaa-bbbb-cccc-000000000002', 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_jane', '+330987654321', 5, 0, false);


--
-- Data for Name: article; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--

INSERT INTO public.article VALUES (5000, 'article Santé 1', 'Contenu de l article 1', 10, '2025-01-10 09:00:00', 'Le Journal de la Santé', 'https://example.com/article1.png');
INSERT INTO public.article VALUES (5001, 'article Santé 2', 'Contenu de l article 2', 5, '2025-01-11 09:00:00', 'Magazine Bien-Être', 'https://example.com/article2.png');


--
-- Data for Name: banhammer; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--

INSERT INTO public.banhammer VALUES (2000, '00000000-aaaa-bbbb-cccc-000000000002', 1, '2025-01-03 00:00:00');
INSERT INTO public.banhammer VALUES (2001, '00000000-aaaa-bbbb-cccc-000000000001', 2, '2025-01-08 00:00:00');


--
-- Data for Name: conversation; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--

INSERT INTO public.conversation VALUES (3000, '2025-01-03 12:00:00', '00000000-aaaa-bbbb-cccc-000000000001');
INSERT INTO public.conversation VALUES (3001, '2025-01-05 10:30:00', '00000000-aaaa-bbbb-cccc-000000000002');


--
-- Data for Name: disease; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--

INSERT INTO public.disease VALUES (6000, 'Grippe', 'Maladie virale saisonnière', 'Fièvre, toux, courbatures', '2025-01-12 10:00:00', NULL);
INSERT INTO public.disease VALUES (6001, 'Rhume', 'Infection virale bénigne', 'Écoulement nasal, éternuements', '2025-01-13 14:00:00', '2025-01-14 09:00:00');


--
-- Data for Name: forum; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--

INSERT INTO public.forum VALUES (1, 'Présentation & Règles', 'forum dédié à la présentation et aux règles', 'https://example.com/forum1.png', false, '2025-01-01 09:00:00');
INSERT INTO public.forum VALUES (2, 'Discussions Générales', 'forum pour tous les sujets généraux', 'https://example.com/forum2.png', false, '2025-01-05 08:00:00');


--
-- Data for Name: group; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--

INSERT INTO public."group" VALUES (7000, 'Modérateurs', 1);
INSERT INTO public."group" VALUES (7001, 'Utilisateurs VIP', 2);


--
-- Data for Name: privatemessage; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--

INSERT INTO public.privatemessage VALUES (4000, 'Salut, comment vas-tu ?', '2025-01-03 12:05:00', NULL, '00000000-aaaa-bbbb-cccc-000000000001', '00000000-aaaa-bbbb-cccc-000000000002', 3000);
INSERT INTO public.privatemessage VALUES (4001, 'Je vais bien merci !', '2025-01-03 12:10:00', '2025-01-03 12:15:00', '00000000-aaaa-bbbb-cccc-000000000002', '00000000-aaaa-bbbb-cccc-000000000001', 3000);
INSERT INTO public.privatemessage VALUES (4002, 'Petite question importante...', '2025-01-05 10:35:00', NULL, '00000000-aaaa-bbbb-cccc-000000000002', '00000000-aaaa-bbbb-cccc-000000000001', 3001);


--
-- Data for Name: reply; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--

INSERT INTO public.reply VALUES (1000, 'Premier post du thread 100', 2, '2025-01-02 15:05:00', '2025-01-02 15:10:00', '00000000-aaaa-bbbb-cccc-000000000002', 100, NULL);
INSERT INTO public.reply VALUES (1001, 'Réponse au post 1000', 1, '2025-01-02 15:20:00', '2025-01-02 15:25:00', '00000000-aaaa-bbbb-cccc-000000000001', 100, 1000);
INSERT INTO public.reply VALUES (1002, 'Premier post du thread 101', 3, '2025-01-07 11:00:00', NULL, '00000000-aaaa-bbbb-cccc-000000000002', 101, NULL);


--
-- Data for Name: right; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--

INSERT INTO public."right" VALUES (8000, 'MODERATE_forum');
INSERT INTO public."right" VALUES (8001, 'CREATE_thread');
INSERT INTO public."right" VALUES (8002, 'BAN_user');


--
-- Data for Name: subscribe; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--



--
-- Data for Name: thread; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--

INSERT INTO public.thread VALUES (100, 'Première Discussion', 'Contenu du premier thread', 'https://example.com/thread1.png', 0, false, '2025-01-02 15:00:00', '2025-01-02 15:10:00', '00000000-aaaa-bbbb-cccc-000000000001', 1);
INSERT INTO public.thread VALUES (101, 'Deuxième Discussion', 'Contenu du deuxième thread', NULL, 5, false, '2025-01-06 10:00:00', '2025-01-07 09:00:00', '00000000-aaaa-bbbb-cccc-000000000002', 2);


--
-- Data for Name: token; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--

INSERT INTO public.token VALUES ('12ed0488-d3c1-45ac-910c-3fd8efd879db', '00000000-aaaa-bbbb-cccc-000000000001', '2025-04-10 10:40:54.699361', NULL, 'validation_token', '2025-04-10 09:40:54.699361', false);


--
-- Data for Name: vote_reply; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--



--
-- Data for Name: vote_thread; Type: TABLE DATA; Schema: public; Owner: chronoadmin
--



--
-- Name: article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chronoadmin
--

SELECT pg_catalog.setval('public.article_id_seq',(select max(id) from public.article), false);


--
-- Name: banhammer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chronoadmin
--

SELECT pg_catalog.setval('public.banhammer_id_seq',(select max(id) from public.banhammer), false);


--
-- Name: conversation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chronoadmin
--

SELECT pg_catalog.setval('public.conversation_id_seq',(select max(id) from public.conversation), false);


--
-- Name: disease_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chronoadmin
--

SELECT pg_catalog.setval('public.disease_id_seq',(select max(id) from public.disease), false);


--
-- Name: forum_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chronoadmin
--

SELECT pg_catalog.setval('public.forum_id_seq',(select max(id) from public.forum), false);


--
-- Name: group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chronoadmin
--

SELECT pg_catalog.setval('public.group_id_seq',(select max(id) from public.group), false);


--
-- Name: privatemessage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chronoadmin
--

SELECT pg_catalog.setval('public.privatemessage_id_seq',(select max(id) from public.privatemessage), false);


--
-- Name: reply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chronoadmin
--

SELECT pg_catalog.setval('public.reply_id_seq',(select max(id) from public.reply), false);


--
-- Name: right_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chronoadmin
--

SELECT pg_catalog.setval('public.right_id_seq',(select max(id) from public.right), false);


--
-- Name: subscribe_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chronoadmin
--

SELECT pg_catalog.setval('public.subscribe_id_seq',(select max(id) from public.subscribe), false);


--
-- Name: thread_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chronoadmin
--

SELECT pg_catalog.setval('public.thread_id_seq',(select max(id) from public.thread), false);


--
-- Name: vote_reply_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chronoadmin
--

SELECT pg_catalog.setval('public.vote_reply_id_seq',(select max(id) from public.vote_reply), false);


--
-- Name: vote_thread_id_seq; Type: SEQUENCE SET; Schema: public; Owner: chronoadmin
--

SELECT pg_catalog.setval('public.vote_thread_id_seq',(select max(id) from public.vote_thread), false);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (uuid);


--
-- Name: article article_pkey; Type: CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.article
    ADD CONSTRAINT article_pkey PRIMARY KEY (id);


--
-- Name: banhammer banhammer_pkey; Type: CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.banhammer
    ADD CONSTRAINT banhammer_pkey PRIMARY KEY (id);


--
-- Name: conversation conversation_pkey; Type: CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT conversation_pkey PRIMARY KEY (id);


--
-- Name: disease disease_pkey; Type: CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.disease
    ADD CONSTRAINT disease_pkey PRIMARY KEY (id);


--
-- Name: forum forum_pkey; Type: CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.forum
    ADD CONSTRAINT forum_pkey PRIMARY KEY (id);


--
-- Name: group group_pkey; Type: CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT group_pkey PRIMARY KEY (id);


--
-- Name: reply post_pkey; Type: CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.reply
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- Name: privatemessage privatemessage_pkey; Type: CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.privatemessage
    ADD CONSTRAINT privatemessage_pkey PRIMARY KEY (id);


--
-- Name: right right_pkey; Type: CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public."right"
    ADD CONSTRAINT right_pkey PRIMARY KEY (id);


--
-- Name: thread thread_pkey; Type: CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.thread
    ADD CONSTRAINT thread_pkey PRIMARY KEY (id);


--
-- Name: banhammer fk_ban_forum; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.banhammer
    ADD CONSTRAINT fk_ban_forum FOREIGN KEY (forum_id) REFERENCES public.forum(id) ON DELETE CASCADE;


--
-- Name: banhammer fk_ban_user; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.banhammer
    ADD CONSTRAINT fk_ban_user FOREIGN KEY (account_fk) REFERENCES public.account(uuid) ON DELETE CASCADE;


--
-- Name: conversation fk_conversation_author; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.conversation
    ADD CONSTRAINT fk_conversation_author FOREIGN KEY (author_uuid) REFERENCES public.account(uuid) ON DELETE SET NULL;


--
-- Name: group fk_group_forum; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public."group"
    ADD CONSTRAINT fk_group_forum FOREIGN KEY (forum_id) REFERENCES public.forum(id) ON DELETE CASCADE;


--
-- Name: privatemessage fk_pm_author; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.privatemessage
    ADD CONSTRAINT fk_pm_author FOREIGN KEY (author_uuid) REFERENCES public.account(uuid) ON DELETE SET NULL;


--
-- Name: privatemessage fk_pm_conversation; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.privatemessage
    ADD CONSTRAINT fk_pm_conversation FOREIGN KEY (conversation_fk) REFERENCES public.conversation(id) ON DELETE CASCADE;


--
-- Name: privatemessage fk_pm_recipient; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.privatemessage
    ADD CONSTRAINT fk_pm_recipient FOREIGN KEY (recipient_fk) REFERENCES public.account(uuid) ON DELETE CASCADE;


--
-- Name: reply fk_post_author; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.reply
    ADD CONSTRAINT fk_post_author FOREIGN KEY (author_uuid) REFERENCES public.account(uuid) ON DELETE SET NULL;


--
-- Name: reply fk_post_response; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.reply
    ADD CONSTRAINT fk_post_response FOREIGN KEY (response_to_fk) REFERENCES public.reply(id) ON DELETE CASCADE;


--
-- Name: reply fk_post_thread; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.reply
    ADD CONSTRAINT fk_post_thread FOREIGN KEY (thread_fk) REFERENCES public.thread(id) ON DELETE CASCADE;


--
-- Name: thread fk_thread_author; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.thread
    ADD CONSTRAINT fk_thread_author FOREIGN KEY (author_uuid) REFERENCES public.account(uuid) ON DELETE SET NULL;


--
-- Name: thread fk_thread_forum; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.thread
    ADD CONSTRAINT fk_thread_forum FOREIGN KEY (forum_id) REFERENCES public.forum(id) ON DELETE CASCADE;


--
-- Name: token token_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT token_userid_fkey FOREIGN KEY (user_id) REFERENCES public.account(uuid);


--
-- Name: vote_reply vote_reply_author_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.vote_reply
    ADD CONSTRAINT vote_reply_author_fk_fkey FOREIGN KEY (author_fk) REFERENCES public.account(uuid);


--
-- Name: vote_reply vote_reply_reply_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.vote_reply
    ADD CONSTRAINT vote_reply_reply_fk_fkey FOREIGN KEY (reply_fk) REFERENCES public.reply(id);


--
-- Name: vote_thread vote_thread_author_uuid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.vote_thread
    ADD CONSTRAINT vote_thread_author_uuid_fkey FOREIGN KEY (author_uuid) REFERENCES public.account(uuid);


--
-- Name: vote_thread vote_thread_thread_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: chronoadmin
--

ALTER TABLE ONLY public.vote_thread
    ADD CONSTRAINT vote_thread_thread_id_fkey FOREIGN KEY (thread_id) REFERENCES public.thread(id);


--
-- PostgreSQL database dump complete
--