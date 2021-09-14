import requests
from bs4 import BeautifulSoup
import pandas as pd
from pprint import pprint

rcra_entity_map = {
    "RCRA_FACILITIES.csv": {
        "table_index": 1
    },
    "RCRA_ENFORCEMENTS.csv": {
        "table_index": 2
    },
    "RCRA_EVALUATIONS.csv": {
        "table_index": 3
    },
    "RCRA_VIOLATIONS.csv": {
        "table_index": 4
    },
    "RCRA_NAICS.csv": {
        "table_index": 5
    },
    "RCRA_VIOSNC_HISTORY.csv": {
        "table_index": 6
    },
}

def parse_doc_content():
    url = "https://echo.epa.gov/tools/data-downloads/rcrainfo-download-summary"
    r = requests.get(url)
    if r.status_code != 200:
        raise(ValueError(f"Web site could not be retrieved. Status Code: {r.status_code}"))

    # Get the tables into a list of dataframes
    tables = pd.read_html(r.text)

    # Work through each dataframe/table corresponding to a RCRA table and stub out a JSON Schema document
    schemas = list()
    for entity,config in rcra_entity_map.items():
        schema = {
            "$schema": "http://json-schema.org/draft-07/schema",
            "$id": f"epa:{entity.split('.')[0].lower()}",
            "type": "object",
            "title": f"{entity} Schema",
            "description": "",
            "properties": dict()
        }
        property_table = tables[int(config["table_index"])].copy()
        for col in [i for i in property_table.columns if i not in ["Element","Data Type"]]:
            property_table = property_table.drop(col, 1)
        property_table.columns = ["title","type"]
        property_table["$id"] = property_table["title"].apply(lambda x: f"{schema['$id']}:{x.lower()}")
        for index, row in property_table.iterrows():
            schema["properties"][row["title"]] = {
                "$id": row["$id"],
                "type": row["type"],
                "title": row["title"]
            }
        schemas.append(schema)

    # Work through the descriptive content and inject property descriptions into the appropriate schema docs
    doc_soup = BeautifulSoup(r.text, 'lxml')
    for i in doc_soup.find_all('h3'):
        table_name = i.text[i.text.find("(")+1:i.text.find(")")]
        if table_name and ".csv" in table_name:
            schema_id = ":".join(["epa",table_name.split(".")[0].lower()])
            for sib in i.next_siblings:
                if sib.name == 'p':
                    p_parts = sib.text.split("-")
                    if len(p_parts) > 1:
                        property_name = p_parts[0].strip()
                        schema = next((i for i in schemas if i["$id"] == schema_id), None)
                        if schema is not None and property_name in schema["properties"]:
                            schema["properties"][property_name]["description"] = "-".join(p_parts[1:])
                elif sib.name == 'h3':
                    break

    return schemas

if __name__ == '__main__':
    rcra_schemas = parse_doc_content()
    
    # Just print out each schema to console for now
    # Need to come up with a destination to write the schemas
    for schema in rcra_schemas:
        pprint(schema)