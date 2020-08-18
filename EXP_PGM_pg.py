

def process_pgm( conn, pgm ):
    sql = "select \"REGISTRY_ID\", \"{}\" from \"ECHO_EXPORTER\" where \"{}\" = 'Y' and \"REGISTRY_ID\" is NOT NULL".format( pgm[1], pgm[0], pgm[0])
    cursor = conn.execute( sql )

    base_sql = "insert into \"EXP_PGM\" ( \"PGM\", \"REGISTRY_ID\", \"PGM_ID\" ) values {} )"

    sql = ""
    insert_list = []
    max_insert = 500
    pos = 0
    for row in cursor:
        for id in row[1].split():
            pos += 1
            # print (pgm[1],row[0])
            insert_list.append( "('{}', '".format( pgm[1] ) + row[0] + "', '" + id + "')," )
            if ( pos % max_insert == 0 ):
                sql = base_sql.format( ''.join( item for item in insert_list ))
                sql = sql[:-3]
                # print( sql )
                conn.execute( sql )
                print( "Inserted {} records".format( max_insert ))
                sql = ""
                insert_list = []

    if ( pos % max_insert > 0 ):
        sql = base_sql.format( ''.join( item for item in insert_list ))
        sql = sql[:-3]
        print( sql )
        conn.execute( sql )
        print( "Inserted {} records".format( pos % max_insert ))
    return pos
        
def build(conn):
    conn.execute("truncate \"EXP_PGM\"")
    flags_and_ids = { 
        "SDWIS_FLAG": "SDWA_IDS",
        "RCRA_FLAG": "RCRA_IDS",    
        "NPDES_FLAG": "NPDES_IDS",
        "AIR_FLAG": "AIR_IDS",
        "RCRA_FLAG": "RCRA_IDS",
    }

    for pgm in flags_and_ids.items():
        num = process_pgm( conn, pgm )
        print( "Program {} found {} ids".format( pgm[0], str(num)))

if __name__ == '__main__':
    import db_connect
    engine,whichDb= db_connect.connect()
    build(engine)
  
