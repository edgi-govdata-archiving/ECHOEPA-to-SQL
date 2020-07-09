
-- SET character_set_server='utf8mb4';
-- SET collation_connection = 'utf8mb4_bin';
-- create table EXP_PGM (
--     PGM text,
--     REGISTRY_ID varchar(20),
--     PGM_ID text
-- );

create view RCRA_VIOLATIONS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from RCRA_VIOLATIONS re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'RCRA_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.ID_NUMBER;
create view RCRA_EVALUATIONS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from RCRA_EVALUATIONS re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'RCRA_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.ID_NUMBER;
create view RCRA_ENFORCEMENTS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from RCRA_ENFORCEMENTS re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'RCRA_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.ID_NUMBER;
create view AIR_INSPECTIONS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from ICIS_FEC_EPA_INSPECTIONS re, ECHO_EXPORTER ee
    where re.REGISTRY_ID = ee.REGISTRY_ID; 
/* *********** Too much trouble to test this locally
*/
create view AIR_ENFORCEMENTS_VIEW as
    select cf.*, ce.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from CASE_FACILITIES cf, CASE_ENFORCEMENTS ce, ECHO_EXPORTER ee
    where cf.REGISTRY_ID = ee.REGISTRY_ID and ce.HQ_DIVISION = 'AIR'
        and ce.CASE_NUMBER = cf.CASE_NUMBER;
/*
 *********** */
/* *********** Sqlite does not like the ` or '-' in these 3 table names
*/
create view AIR_VIOLATIONS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from `ICIS-AIR_VIOLATION_HISTORY` re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'AIR_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.pgm_sys_id;
create view AIR_FORMAL_ACTIONS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from `ICIS-AIR_FORMAL_ACTIONS` re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'AIR_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.pgm_sys_id;
create view AIR_COMPLIANCE_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from `ICIS-AIR_FCES_PCES` re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'AIR_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.PGM_SYS_ID;
/*
************ */
/* *********** Sqlite does not like the ` or '-' in these 3 table names
create view AIR_VIOLATIONS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from ICIS_AIR_VIOLATION_HISTORY re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'AIR_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.pgm_sys_id;
create view AIR_FORMAL_ACTIONS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from ICIS_AIR_FORMAL_ACTIONS re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'AIR_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.pgm_sys_id;
create view AIR_COMPLIANCE_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from ICIS_AIR_FCES_PCES re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'AIR_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.PGM_SYS_ID;
************ */
create view COMBINED_AIR_EMISSIONS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from POLL_RPT_COMBINED_EMISSIONS re, ECHO_EXPORTER ee
    where re.REGISTRY_ID = ee.REGISTRY_ID;
create view GREENHOUSE_GASES_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from POLL_RPT_COMBINED_EMISSIONS re, ECHO_EXPORTER ee
    where re.REGISTRY_ID = ee.REGISTRY_ID and re.PGM_SYS_ACRN = 'E-GGRT';
create view TOXIC_RELEASES_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from POLL_RPT_COMBINED_EMISSIONS re, ECHO_EXPORTER ee
    where re.REGISTRY_ID = ee.REGISTRY_ID and re.PGM_SYS_ACRN = 'TRIS';
create view WATER_QUARTERLY_VIOLATIONS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from NPDES_QNCR_HISTORY re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'NPDES_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.NPDES_ID;
create view CLEAN_WATER_INSPECTIONS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from NPDES_INSPECTIONS re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'NPDES_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.NPDES_ID;
create view CLEAN_WATER_ENFORCEMENT_ACTIONS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from NPDES_FORMAL_ENFORCEMENT_ACTIONS re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'NPDES_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.NPDES_ID;
create view SDWA_SITE_VISITS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from SDWA_SITE_VISITS re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'SDWA_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.PWSID;
create view SDWA_ENFORCEMENTS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from SDWA_ENFORCEMENTS re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'SDWA_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.PWSID;
create view SDWA_PUBLIC_WATER_SYSTEMS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from SDWA_PUB_WATER_SYSTEMS re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'SDWA_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.PWSID;
create view SDWA_VIOLATIONS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from SDWA_VIOLATIONS re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'SDWA_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.PWSID;
create view SDWA_SERIOUS_VIOLATORS_VIEW as
    select re.*, 
        ee.REGISTRY_ID,
        ee.FAC_NAME,
        ee.FAC_STREET,
        ee.FAC_CITY,
        ee.FAC_STATE,
        ee.FAC_ZIP,
        ee.FAC_COUNTY,
        ee.FAC_EPA_REGION,
        ee.FAC_LAT,
        ee.FAC_LONG,
        ee.FAC_DERIVED_WBD,
        ee.FAC_DERIVED_CD113,
        ee.FAC_PERCENT_MINORITY,
        ee.FAC_POP_DEN
    from SDWA_SERIOUS_VIOLATORS re, ECHO_EXPORTER ee, EXP_PGM ep 
    where ep.PGM = 'SDWA_IDS' and ep.REGISTRY_ID = ee.REGISTRY_ID 
        and ep.PGM_ID = re.PWSID;
