-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/Vj5DcU
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "states" (
    "state" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_states" PRIMARY KEY (
        "state"
     )
);

CREATE TABLE "state_county" (
    "state" VARCHAR(255)   NOT NULL,
    "county" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_state_county" PRIMARY KEY (
        "state","county"
     )
);

CREATE TABLE "state_district" (
    "state" VARCHAR(255)   NOT NULL,
    "district" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_state_district" PRIMARY KEY (
        "state","district"
     )
);

CREATE TABLE "governor_result_county" (
    "state" VARCHAR(255)   NOT NULL,
    "county" VARCHAR(255)   NOT NULL,
    "candidate" VARCHAR(255)   NOT NULL,
    "party" VARCHAR(255)   NOT NULL,
    "candidate_votes" INT   NOT NULL,
    "percent_votes" DECIMAL   NOT NULL,
    "won" BOOL   NOT NULL,
    CONSTRAINT "pk_governor_result_county" PRIMARY KEY (
        "state","county"
     )
);

CREATE TABLE "governor_result_state" (
    "state" VARCHAR(255)   NOT NULL,
    "candidate" VARCHAR(255)   NOT NULL,
    "candidate_votes" INT   NOT NULL,
    "percent_votes" DECIMAL   NOT NULL,
    CONSTRAINT "pk_governor_result_state" PRIMARY KEY (
        "state"
     )
);

CREATE TABLE "governor_total_votes_county" (
    "state" VARCHAR(255)   NOT NULL,
    "county" VARCHAR(255)   NOT NULL,
    "current_votes" INT   NOT NULL,
    "total_votes" INT   NOT NULL,
    CONSTRAINT "pk_governor_total_votes_county" PRIMARY KEY (
        "state","county"
     )
);

CREATE TABLE "governor_total_votes_state" (
    "state" VARCHAR(255)   NOT NULL,
    "total_votes" INT   NOT NULL,
    CONSTRAINT "pk_governor_total_votes_state" PRIMARY KEY (
        "state"
     )
);

CREATE TABLE "house_result" (
    "state" VARCHAR(255)   NOT NULL,
    "district" VARCHAR(255)   NOT NULL,
    "candidate" VARCHAR(255)   NOT NULL,
    "party" VARCHAR(255)   NOT NULL,
    "candidate_votes" INT   NOT NULL,
    "percent_votes" DECIMAL   NOT NULL,
    "won" BOOL   NOT NULL,
    CONSTRAINT "pk_house_result" PRIMARY KEY (
        "state","district"
     )
);

CREATE TABLE "house_total_votes_district" (
    "state" VARCHAR(255)   NOT NULL,
    "district" VARCHAR(255)   NOT NULL,
    "current_votes" INT   NOT NULL,
    "total_votes" INT   NOT NULL,
    "percent" INT   NOT NULL,
    CONSTRAINT "pk_house_total_votes_district" PRIMARY KEY (
        "state","district"
     )
);

CREATE TABLE "president_result_county" (
    "state" VARCHAR(255)   NOT NULL,
    "county" VARCHAR(255)   NOT NULL,
    "candidate" VARCHAR(255)   NOT NULL,
    "party" VARCHAR(255)   NOT NULL,
    "candidate_votes" INT   NOT NULL,
    "percent_votes" DECIMAL   NOT NULL,
    "won" BOOL   NOT NULL,
    CONSTRAINT "pk_president_result_county" PRIMARY KEY (
        "state","county"
     )
);

CREATE TABLE "president_result_state" (
    "state" VARCHAR(255)   NOT NULL,
    "candidate" VARCHAR(255)   NOT NULL,
    "candidate_votes" INT   NOT NULL,
    "percent_votes" DECIMAL   NOT NULL,
    CONSTRAINT "pk_president_result_state" PRIMARY KEY (
        "state"
     )
);

CREATE TABLE "president_total_votes_county" (
    "state" VARCHAR(255)   NOT NULL,
    "county" VARCHAR(255)   NOT NULL,
    "current_votes" INT   NOT NULL,
    "total_votes" INT   NOT NULL,
    CONSTRAINT "pk_president_total_votes_county" PRIMARY KEY (
        "state","county"
     )
);

CREATE TABLE "president_total_votes_state" (
    "state" VARCHAR(255)   NOT NULL,
    "total_votes" INT   NOT NULL,
    CONSTRAINT "pk_president_total_votes_state" PRIMARY KEY (
        "state"
     )
);

CREATE TABLE "senate_result_county" (
    "state" VARCHAR(255)   NOT NULL,
    "county" VARCHAR(255)   NOT NULL,
    "candidate" VARCHAR(255)   NOT NULL,
    "party" VARCHAR(255)   NOT NULL,
    "candidate_votes" INT   NOT NULL,
    "percent_votes" DECIMAL   NOT NULL,
    "won" BOOL   NOT NULL,
    CONSTRAINT "pk_senate_result_county" PRIMARY KEY (
        "state","county"
     )
);

CREATE TABLE "senate_result_state" (
    "state" VARCHAR(255)   NOT NULL,
    "candidate" VARCHAR(255)   NOT NULL,
    "candidate_votes" INT   NOT NULL,
    "percent_votes" DECIMAL   NOT NULL,
    CONSTRAINT "pk_senate_result_state" PRIMARY KEY (
        "state"
     )
);

CREATE TABLE "senate_total_votes_county" (
    "state" VARCHAR(255)   NOT NULL,
    "county" VARCHAR(255)   NOT NULL,
    "current_votes" INT   NOT NULL,
    "total_votes" INT   NOT NULL,
    CONSTRAINT "pk_senate_total_votes_county" PRIMARY KEY (
        "state","county"
     )
);

CREATE TABLE "senate_total_votes_state" (
    "state" VARCHAR(255)   NOT NULL,
    "total_votes" INT   NOT NULL,
    CONSTRAINT "pk_senate_total_votes_state" PRIMARY KEY (
        "state"
     )
);

ALTER TABLE "state_county" ADD CONSTRAINT "fk_state_county_state" FOREIGN KEY("state")
REFERENCES "states" ("state");

ALTER TABLE "state_district" ADD CONSTRAINT "fk_state_district_state" FOREIGN KEY("state")
REFERENCES "states" ("state");

ALTER TABLE "governor_result_county" ADD CONSTRAINT "fk_governor_result_county_state_county" FOREIGN KEY("state", "county")
REFERENCES "state_county" ("state", "county");

ALTER TABLE "governor_result_state" ADD CONSTRAINT "fk_governor_result_state_state" FOREIGN KEY("state")
REFERENCES "states" ("state");

ALTER TABLE "governor_total_votes_county" ADD CONSTRAINT "fk_governor_total_votes_county_state_county" FOREIGN KEY("state", "county")
REFERENCES "state_county" ("state", "county");

ALTER TABLE "governor_total_votes_state" ADD CONSTRAINT "fk_governor_total_votes_state_state" FOREIGN KEY("state")
REFERENCES "states" ("state");

ALTER TABLE "house_result" ADD CONSTRAINT "fk_house_result_state_district" FOREIGN KEY("state", "district")
REFERENCES "state_district" ("state", "district");

ALTER TABLE "house_total_votes_district" ADD CONSTRAINT "fk_house_total_votes_district_state_district" FOREIGN KEY("state", "district")
REFERENCES "state_district" ("state", "district");

ALTER TABLE "president_result_county" ADD CONSTRAINT "fk_president_result_county_state_county" FOREIGN KEY("state", "county")
REFERENCES "state_county" ("state", "county");

ALTER TABLE "president_result_state" ADD CONSTRAINT "fk_president_result_state_state" FOREIGN KEY("state")
REFERENCES "states" ("state");

ALTER TABLE "president_total_votes_county" ADD CONSTRAINT "fk_president_total_votes_county_state_county" FOREIGN KEY("state", "county")
REFERENCES "state_county" ("state", "county");

ALTER TABLE "president_total_votes_state" ADD CONSTRAINT "fk_president_total_votes_state_state" FOREIGN KEY("state")
REFERENCES "states" ("state");

ALTER TABLE "senate_result_county" ADD CONSTRAINT "fk_senate_result_county_state_county" FOREIGN KEY("state", "county")
REFERENCES "state_county" ("state", "county");

ALTER TABLE "senate_result_state" ADD CONSTRAINT "fk_senate_result_state_state" FOREIGN KEY("state")
REFERENCES "states" ("state");

ALTER TABLE "senate_total_votes_county" ADD CONSTRAINT "fk_senate_total_votes_county_state_county" FOREIGN KEY("state", "county")
REFERENCES "state_county" ("state", "county");

ALTER TABLE "senate_total_votes_state" ADD CONSTRAINT "fk_senate_total_votes_state_state" FOREIGN KEY("state")
REFERENCES "states" ("state");

