

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

