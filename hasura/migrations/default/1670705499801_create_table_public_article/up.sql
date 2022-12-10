CREATE TABLE "public"."article" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "title" text NOT NULL, "author_id" uuid NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("author_id") REFERENCES "public"."author"("id") ON UPDATE cascade ON DELETE cascade, UNIQUE ("id"));
CREATE EXTENSION IF NOT EXISTS pgcrypto;
