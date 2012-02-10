CREATE TABLE "event_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "events" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255) NOT NULL, "description" varchar(255), "start_date" date NOT NULL, "end_date" date NOT NULL, "max_att" integer NOT NULL, "active" boolean, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "field_replies" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "field_id" integer, "reply_id" integer, "content" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "field_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255) NOT NULL, "field_type" varchar(255) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "fields" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "field_label" varchar(255) NOT NULL, "field_order" varchar(255) NOT NULL, "description" varchar(255), "required" boolean NOT NULL, "event_id" integer NOT NULL, "field_type_id" integer NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "replies" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "event_id" integer, "field_reply_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar(255) NOT NULL, "email" varchar(255), "crypted_password" varchar(255), "salt" varchar(255), "role" varchar(255) DEFAULT 'admin', "name" varchar(255), "created_at" datetime, "updated_at" datetime, "remember_me_token" varchar(255) DEFAULT NULL, "remember_me_token_expires_at" datetime DEFAULT NULL, "reset_password_token" varchar(255) DEFAULT NULL, "reset_password_token_expires_at" datetime DEFAULT NULL, "reset_password_email_sent_at" datetime DEFAULT NULL);
CREATE INDEX "index_users_on_remember_me_token" ON "users" ("remember_me_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20110505234542');

INSERT INTO schema_migrations (version) VALUES ('20110506230629');

INSERT INTO schema_migrations (version) VALUES ('20110507003134');

INSERT INTO schema_migrations (version) VALUES ('20110507003450');

INSERT INTO schema_migrations (version) VALUES ('20110507023453');

INSERT INTO schema_migrations (version) VALUES ('20110507025444');

INSERT INTO schema_migrations (version) VALUES ('20111030132354');

INSERT INTO schema_migrations (version) VALUES ('20111030132355');

INSERT INTO schema_migrations (version) VALUES ('20111030132356');