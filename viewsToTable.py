import db_connect
def build(conn):
    views=[
    "AIR_COMPLIANCE",
    "AIR_ENFORCEMENTS",
    "AIR_FORMAL_ACTIONS",
    "AIR_INSPECTIONS",
    "AIR_VIOLATIONS",
    "CLEAN_WATER_ENFORCEMENT_ACTIONS",
    "CLEAN_WATER_INSPECTIONS",
    "COMBINED_AIR_EMISSIONS",
    "GREENHOUSE_GASES",
    "RCRA_ENFORCEMENTS",
    "RCRA_EVALUATIONS",
    "RCRA_VIOLATIONS",
    "SDWA_ENFORCEMENTS",
    "SDWA_PUBLIC_WATER_SYSTEMS",
    "SDWA_SERIOUS_VIOLATORS",
    "SDWA_SITE_VISITS",
    "SDWA_VIOLATIONS",
    "TOXIC_RELEASES",
    "WATER_QUARTERLY_VIOLATIONS",
    "DMR_FY2020"
    ]
#    views=["NPDES_DMRS_FY2020"]
    indexes=["FAC_NAME",
    "FAC_STREET",
    "FAC_CITY",
    "FAC_STATE",
    "FAC_ZIP",
    "FAC_COUNTY",
    "FAC_EPA_REGION",
    "FAC_LAT",
    "FAC_LONG",
    "FAC_DERIVED_WBD",
    "FAC_DERIVED_CD113",
    "FAC_PERCENT_MINORITY",
    "FAC_POP_DEN",
    "FAC_DERIVED_HUC",
    "FAC_SIC_CODES",
    "FAC_NAICS_CODES"
    ]
    
    for view in views:
        print("creating table %s" %(view))
        conn.execute('DROP MATERIALIZED VIEW IF EXISTS "%s_MVIEW"'% view)
        conn.execute('create MATERIALIZED VIEW "%s_MVIEW" as select * from  "%s_VIEW"' % (view,view))
        for index in indexes:
            # print ("creating index %s for table %s" %(index,view))
            conn.execute('create index "%s_%s" on "%s_MVIEW"("%s")' %(index,view,view,index))
        conn.execute('REFRESH MATERIALIZED VIEW  "%s_MVIEW"' % view)
if __name__ == '__main__':
    engine,whichDb= db_connect.connect()
    build(engine)
