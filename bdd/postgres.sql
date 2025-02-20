-- Supprimer les tables si elles existent déjà (ordre inverse des dépendances)
DROP TABLE IF EXISTS "banhammer" CASCADE;
DROP TABLE IF EXISTS "privatemessage" CASCADE;
DROP TABLE IF EXISTS "conversation" CASCADE;
DROP TABLE IF EXISTS "post" CASCADE;
DROP TABLE IF EXISTS "thread" CASCADE;
DROP TABLE IF EXISTS "forum" CASCADE;
DROP TABLE IF EXISTS "article" CASCADE;
DROP TABLE IF EXISTS "disease" CASCADE;
DROP TABLE IF EXISTS "group" CASCADE;
DROP TABLE IF EXISTS "right" CASCADE;
DROP TABLE IF EXISTS "account" CASCADE;

-- ===================================
-- Table: account
-- ===================================
CREATE TABLE "account" (
    "uuid"             uuid         PRIMARY KEY DEFAULT gen_random_uuid(),
    "firstname"        VARCHAR(100) NOT NULL,
    "lastname"         VARCHAR(100) NOT NULL,
    "email"            VARCHAR(255) NOT NULL,
    "password"         VARCHAR(255) NOT NULL,
    "phone"            VARCHAR(50),
    "karma"            INT          DEFAULT 0,
    "global_bantime"   VARCHAR(255),       -- ou TIMESTAMP/DATE/INT selon vos données
    "validated"        BOOLEAN      DEFAULT FALSE
);

-- ===================================
-- Table: forum
-- ===================================
CREATE TABLE "forum" (
    "id"            INT          PRIMARY KEY,
    "title"         VARCHAR(255) NOT NULL,
    "description"   TEXT,
    "img_url"       VARCHAR(255),
    "creation_date" TIMESTAMP    -- ou VARCHAR(255), selon vos données
);

-- ===================================
-- Table: thread
-- ===================================
CREATE TABLE "thread" (
    "id"                INT          PRIMARY KEY,
    "title"             VARCHAR(255) NOT NULL,
    "content"           TEXT         NOT NULL,
    "img_url"           VARCHAR(255),
    "ratio"             INT          DEFAULT 0,
    "creation_date"     TIMESTAMP,
    "modification_date" TIMESTAMP,
    "author_fk"         uuid,
    "forum_fk"          INT,
    CONSTRAINT fk_thread_author FOREIGN KEY ("author_fk") REFERENCES "account"("uuid")   ON DELETE SET NULL,
    CONSTRAINT fk_thread_forum  FOREIGN KEY ("forum_fk")  REFERENCES "forum"("id")    ON DELETE CASCADE
);

-- ===================================
-- Table: post
-- ===================================
CREATE TABLE "post" (
    "id"                INT          PRIMARY KEY,
    "content"           TEXT         NOT NULL,
    "ratio"             INT          DEFAULT 0,
    "creation_date"     TIMESTAMP,
    "modification_date" TIMESTAMP,
    "author_fk"         uuid,
    "thread_fk"         INT,
    "response_to_fk"    INT,
    CONSTRAINT fk_post_author    FOREIGN KEY ("author_fk")      REFERENCES "account"("uuid")   ON DELETE SET NULL,
    CONSTRAINT fk_post_thread    FOREIGN KEY ("thread_fk")      REFERENCES "thread"("id")   ON DELETE CASCADE,
    CONSTRAINT fk_post_response  FOREIGN KEY ("response_to_fk") REFERENCES "post"("id")     ON DELETE CASCADE
);

-- ===================================
-- Table: banhammer
-- ===================================
CREATE TABLE "banhammer" (
    "id"       INT    PRIMARY KEY,
    "account_fk"  uuid,
    "forum_fk" INT,
    "bantime"  VARCHAR(255),   -- ou TIMESTAMP/DATE/INT selon vos données
    CONSTRAINT fk_ban_user   FOREIGN KEY ("account_fk")  REFERENCES "account"("uuid")  ON DELETE CASCADE,
    CONSTRAINT fk_ban_forum  FOREIGN KEY ("forum_fk") REFERENCES "forum"("id")   ON DELETE CASCADE
);

-- ===================================
-- Table: conversation
-- ===================================
CREATE TABLE "conversation" (
    "id"            INT PRIMARY KEY,
    "creation_date" TIMESTAMP,
    "author_fk"     uuid,
    CONSTRAINT fk_conversation_author FOREIGN KEY ("author_fk") REFERENCES "account"("uuid") ON DELETE SET NULL
);

-- ===================================
-- Table: privatemessage
-- ===================================
CREATE TABLE "privatemessage" (
    "id"               INT       PRIMARY KEY,
    "message"          TEXT      NOT NULL,
    "creation_date"    TIMESTAMP,
    "modification_date" TIMESTAMP,
    "author_fk"        uuid,
    "recipient_fk"     uuid,
    "conversation_fk"  INT,
    CONSTRAINT fk_pm_author       FOREIGN KEY ("author_fk")       REFERENCES "account"("uuid")          ON DELETE SET NULL,
    CONSTRAINT fk_pm_recipient    FOREIGN KEY ("recipient_fk")    REFERENCES "account"("uuid")          ON DELETE CASCADE,
    CONSTRAINT fk_pm_conversation FOREIGN KEY ("conversation_fk") REFERENCES "conversation"("id")     ON DELETE CASCADE
);

-- ===================================
-- Table: article
-- ===================================
CREATE TABLE "article" (
    "id"             INT          PRIMARY KEY,
    "title"          VARCHAR(255) NOT NULL,
    "content"        TEXT,
    "ratio"          INT          DEFAULT 0,
    "creation_date"  TIMESTAMP,
    "source"         VARCHAR(255),
    "cover_img_url"  VARCHAR(255)
);

-- ===================================
-- Table: disease
-- ===================================
CREATE TABLE "disease" (
    "id"                INT          PRIMARY KEY,
    "name"              VARCHAR(255) NOT NULL,
    "description"       TEXT,
    "symptomes"         TEXT,
    "creation_date"     TIMESTAMP,
    "modification_date" TIMESTAMP
);

-- ===================================
-- Table: group
-- ===================================
CREATE TABLE "group" (
    "id"       INT           PRIMARY KEY,
    "name"     VARCHAR(255),
    "forum_fk" INT,
    CONSTRAINT fk_group_forum FOREIGN KEY ("forum_fk") REFERENCES "forum"("id") ON DELETE CASCADE
);

-- ===================================
-- Table: right
-- ===================================
CREATE TABLE "right" (
    "id"   INT           PRIMARY KEY,
    "name" VARCHAR(255)
);

-- ===================================
-- Fin de la création de la structure
-- ===================================
-- ========================
-- DÉBUT DE LA TRANSACTION
-- ========================
BEGIN;

-- ======================================
-- Exemple d'insertion dans la table "account"
-- ======================================
INSERT INTO "account" (uuid, firstname, lastname, email, password, phone, karma, global_bantime, validated) VALUES
('00000000-aaaa-bbbb-cccc-000000000001', 'John', 'Doe', 'john.doe@example.com', 'hashed_password_john', '+330123456789', 10, '2025-01-01 10:00:00', TRUE),
('00000000-aaaa-bbbb-cccc-000000000002', 'Jane', 'Smith', 'jane.smith@example.com', 'hashed_password_jane', '+330987654321', 5,  '2025-01-02 11:30:00', FALSE);

-- ======================================
-- Exemple d'insertion dans la table "forum"
-- ======================================
INSERT INTO "forum" (id, title, description, img_url, creation_date) VALUES
(1, 'Présentation & Règles', 'forum dédié à la présentation et aux règles', 'https://example.com/forum1.png', '2025-01-01 09:00:00'),
(2, 'Discussions Générales', 'forum pour tous les sujets généraux', 'https://example.com/forum2.png', '2025-01-05 08:00:00');

-- ======================================
-- Exemple d'insertion dans la table "thread"
-- ======================================
INSERT INTO "thread" (id, title, content, img_url, ratio, creation_date, modification_date, author_fk, forum_fk) VALUES
(100, 'Première Discussion', 'Contenu du premier thread', 'https://example.com/thread1.png', 0, '2025-01-02 15:00:00', '2025-01-02 15:10:00', '00000000-aaaa-bbbb-cccc-000000000001', 1),
(101, 'Deuxième Discussion', 'Contenu du deuxième thread', NULL, 5, '2025-01-06 10:00:00', '2025-01-07 09:00:00', '00000000-aaaa-bbbb-cccc-000000000002', 2);

-- ======================================
-- Exemple d'insertion dans la table "post"
-- ======================================
INSERT INTO "post" (id, content, ratio, creation_date, modification_date, author_fk, thread_fk, response_to_fk) VALUES
(1000, 'Premier post du thread 100', 2, '2025-01-02 15:05:00', '2025-01-02 15:10:00', '00000000-aaaa-bbbb-cccc-000000000002', 100, NULL),
(1001, 'Réponse au post 1000', 1, '2025-01-02 15:20:00', '2025-01-02 15:25:00', '00000000-aaaa-bbbb-cccc-000000000001', 100, 1000),
(1002, 'Premier post du thread 101', 3, '2025-01-07 11:00:00', NULL, '00000000-aaaa-bbbb-cccc-000000000002', 101, NULL);

-- ======================================
-- Exemple d'insertion dans la table "banhammer"
-- ======================================
INSERT INTO "banhammer" (id, account_fk, forum_fk, bantime) VALUES
(2000, '00000000-aaaa-bbbb-cccc-000000000002', 1, '2025-01-03 00:00:00'),
(2001, '00000000-aaaa-bbbb-cccc-000000000001', 2, '2025-01-08 00:00:00');

-- ======================================
-- Exemple d'insertion dans la table "conversation"
-- ======================================
INSERT INTO "conversation" (id, creation_date, author_fk) VALUES
(3000, '2025-01-03 12:00:00', '00000000-aaaa-bbbb-cccc-000000000001'),
(3001, '2025-01-05 10:30:00', '00000000-aaaa-bbbb-cccc-000000000002');

-- ======================================
-- Exemple d'insertion dans la table "privatemessage"
-- ======================================
INSERT INTO "privatemessage" (id, message, creation_date, modification_date, author_fk, recipient_fk, conversation_fk) VALUES
(4000, 'Salut, comment vas-tu ?', '2025-01-03 12:05:00', NULL, '00000000-aaaa-bbbb-cccc-000000000001', '00000000-aaaa-bbbb-cccc-000000000002', 3000),
(4001, 'Je vais bien merci !', '2025-01-03 12:10:00', '2025-01-03 12:15:00', '00000000-aaaa-bbbb-cccc-000000000002', '00000000-aaaa-bbbb-cccc-000000000001', 3000),
(4002, 'Petite question importante...', '2025-01-05 10:35:00', NULL, '00000000-aaaa-bbbb-cccc-000000000002', '00000000-aaaa-bbbb-cccc-000000000001', 3001);

-- ======================================
-- Exemple d'insertion dans la table "article"
-- ======================================
INSERT INTO "article" (id, title, content, ratio, creation_date, source, cover_img_url) VALUES
(5000, 'article Santé 1', 'Contenu de l article 1', 10, '2025-01-10 09:00:00', 'Le Journal de la Santé', 'https://example.com/article1.png'),
(5001, 'article Santé 2', 'Contenu de l article 2', 5,  '2025-01-11 09:00:00', 'Magazine Bien-Être', 'https://example.com/article2.png');

-- ======================================
-- Exemple d'insertion dans la table "disease"
-- ======================================
INSERT INTO "disease" (id, name, description, symptomes, creation_date, modification_date) VALUES
(6000, 'Grippe', 'Maladie virale saisonnière', 'Fièvre, toux, courbatures', '2025-01-12 10:00:00', NULL),
(6001, 'Rhume', 'Infection virale bénigne', 'Écoulement nasal, éternuements', '2025-01-13 14:00:00', '2025-01-14 09:00:00');

-- ======================================
-- Exemple d'insertion dans la table "group"
-- ======================================
INSERT INTO "group" (id, name, forum_fk) VALUES
(7000, 'Modérateurs', 1),
(7001, 'Utilisateurs VIP', 2);

-- ======================================
-- Exemple d'insertion dans la table "right"
-- ======================================
INSERT INTO "right" (id, name) VALUES
(8000, 'MODERATE_forum'),
(8001, 'CREATE_thread'),
(8002, 'BAN_user');

-- =====================
-- FIN DE LA TRANSACTION
-- =====================
COMMIT;

