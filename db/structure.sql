CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE IF NOT EXISTS "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "email" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "password_digest" varchar, "remember_digest" varchar, "admin" boolean DEFAULT 'f', "activation_digest" varchar, "activated" boolean DEFAULT 'f', "activated_at" datetime, "reset_digest" varchar, "reset_sent_at" datetime);
CREATE TABLE sqlite_sequence(name,seq);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
INSERT INTO schema_migrations (version) VALUES ('20221210215737');

INSERT INTO schema_migrations (version) VALUES ('20221210234440');

INSERT INTO schema_migrations (version) VALUES ('20221211000946');

INSERT INTO schema_migrations (version) VALUES ('20221212114853');

INSERT INTO schema_migrations (version) VALUES ('20221212220529');

INSERT INTO schema_migrations (version) VALUES ('20221213121059');

INSERT INTO schema_migrations (version) VALUES ('20221213150947');

