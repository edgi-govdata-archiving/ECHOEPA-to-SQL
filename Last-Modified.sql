--
-- PostgreSQL database dump
--

-- Dumped from database version 11.9 (Ubuntu 11.9-1.pgdg18.04+1)
-- Dumped by pg_dump version 12.4

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

SET default_tablespace = '';

--
-- Name: Last-Modified; Type: TABLE; Schema: public; Owner: echoepa
--

CREATE TABLE public."Last-Modified" (
    name character varying(40),
    zip character varying(40),
    modified date
);


ALTER TABLE public."Last-Modified" OWNER TO echoepa;

--
-- Data for Name: Last-Modified; Type: TABLE DATA; Schema: public; Owner: echoepa
--

COPY public."Last-Modified" (name, zip, modified) FROM stdin;
FRS_PROGRAM_LINKS	frs_downloads.zip	2020-08-29
ICIS-AIR_STACK_TESTS	ICIS-AIR_downloads.zip	2020-08-30
ICIS-AIR_VIOLATION_HISTORY	ICIS-AIR_downloads.zip	2020-08-30
ICIS-AIR_FORMAL_ACTIONS	ICIS-AIR_downloads.zip	2020-08-30
ICIS-AIR_FCES_PCES	ICIS-AIR_downloads.zip	2020-08-30
ICIS-AIR_FACILITIES	ICIS-AIR_downloads.zip	2020-08-30
NPDES_DMRS_FY2020	npdes_dmrs_fy2020.zip	2020-08-30
NPDES_EFF_VIOLATIONS	npdes_eff_downloads.zip	2020-08-30
POLL_RPT_COMBINED_EMISSIONS	POLL_RPT_COMBINED_EMISSIONS.zip	2020-08-30
RCRA_EVALUATIONS	rcra_downloads.zip	2020-08-30
RCRA_VIOLATIONS	rcra_downloads.zip	2020-08-30
RCRA_ENFORCEMENTS	rcra_downloads.zip	2020-08-30
CASE_FACILITIES	case_downloads.zip	2020-09-19
ICIS_FEC_EPA_INSPECTIONS	case_downloads.zip	2020-09-19
CASE_ENFORCEMENTS	case_downloads.zip	2020-09-19
CASE_ENFORCEMENTS_CONCLUSIONS	case_downloads.zip	2020-09-19
EPA_INFORMAL_ENFORCEMENT_ACTIONS	case_downloads.zip	2020-09-19
NPDES_INSPECTIONS	npdes_downloads.zip	2020-08-30
NPDES_CS_VIOLATIONS	npdes_downloads.zip	2020-08-30
ICIS_PERMITS	npdes_downloads.zip	2020-08-30
NPDES_PS_VIOLATIONS	npdes_downloads.zip	2020-08-30
NPDES_SE_VIOLATIONS	npdes_downloads.zip	2020-08-30
NPDES_FORMAL_ENFORCEMENT_ACTIONS	npdes_downloads.zip	2020-08-30
NPDES_QNCR_HISTORY	npdes_downloads.zip	2020-08-30
CASE_ENFORCEMENT_CONCLUSION_POLLUTANTS	case_downloads.zip	2020-09-19
ECHO_EXPORTER	echo_exporter.zip	2020-09-19
SDWA_PUB_WATER_SYSTEMS	SDWA_downloads.zip	2020-09-10
SDWA_VIOLATIONS	SDWA_downloads.zip	2020-09-10
SDWA_SITE_VISITS	SDWA_downloads.zip	2020-09-10
SDWA_ENFORCEMENTS	SDWA_downloads.zip	2020-09-10
SDWA_SERIOUS_VIOLATORS	SDWA_downloads.zip	2020-09-10
\.


--
-- Name: TABLE "Last-Modified"; Type: ACL; Schema: public; Owner: echoepa
--

GRANT SELECT ON TABLE public."Last-Modified" TO echoepa_public;


--
-- PostgreSQL database dump complete
--

