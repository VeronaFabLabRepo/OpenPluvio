----
-- phpLiteAdmin database dump (http://phpliteadmin.googlecode.com)
-- phpLiteAdmin version: 1.9.5
-- Exported: 10:29pm on January 1, 2007 (CET)
-- database file: ./openpluvio
----
BEGIN TRANSACTION;

----
-- Table structure for basculate
----
CREATE TABLE 'basculate' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'t_timestamp' DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);

----
-- Table structure for parameters
----
CREATE TABLE 'parameters' ('count_2_mm' REAL);

----
-- Data dump for parameters, a total of 1 rows
----
INSERT INTO "parameters" ("count_2_mm") VALUES ('0.2');
COMMIT;