#Make a phone book

pb = {
    "Ian" : { "Home" : "111-222-3333", "Work" : "444-555-6666" },
    "Julie" : { "Home" : "777-888-9999", "Work" : "111-222-1234"}
    }

# what to think about when data modeling: consistency, access, validity across rows
# name of person must be unique, fast access, declaring a head of time


import sqlite3
from pprint import pprint


# Return one row with the column names attached
                                       
with sqlite3.connect('sf-trees.db', timeout = 1) as conn:
    conn.row_factory = sqlite3.Row # return keys and values in rows
    cursor = conn.execute('''
        SELECT * FROM Street_Tree_List
        LIMIT 1; 
    ''') # <-- context manager, prevents database access outside with clause


    for row in cursor:
        pprint(dict(row))


with sqlite3.connect('sf-trees.db', timeout=1) as conn:
    cursor = conn.execute("SELECT value FROM qCaretaker;")
        
    for row in cursor:
        print(row)


with sqlite3.connect('sf-trees.db', timeout=1) as conn:
    cursor = conn.execute('''
            SELECT count(Street_Tree_List.qAddress)
            FROM Street_Tree_List, qCaretaker
            WHERE Street_Tree_List.qCaretaker == qCaretaker.id
            AND qCaretaker.value == "Police Dept"
            ;
            '''
        )
        
    for row in cursor:
        print(row)


with sqlite3.connect('sf-trees.db', timeout=1) as conn:
    cursor = conn.execute('''
            SELECT Street_Tree_List.qAddress
            FROM Street_Tree_List, qCaretaker, qLegalStatus
            WHERE Street_Tree_List.qCaretaker == qCaretaker.id
            AND Street_Tree_List.qLegalStatus = qLegalStatus.id
            AND qCaretaker.value == "Police Dept"
            AND qLegalStatus.value LIKE "Sig%"
            ;
            '''
        )
        
    for row in cursor:
        print(row)


# https://github.com/jgarst/PythonClass/blob/master/course/sqlite3/sqlite.ipynb



print("creating table...")


with sqlite3.connect('sf-trees.db', timeout=1) as conn:
    cursor = conn.execute('''
    CREATE TABLE t1(
        x INTEGER PRIMARY KEY,
        y INTEGER,
        month TEXT,
        day TEXT,
        FFMC INTEGER,
        DMC INTEGER,
        DC INTEGER,
        ISI INTEGER,
        temp INTEGER,
        RH INTEGER,
        wind INTEGER,
        rain INTEGER,
        area BLOB
       '''
);

print("inserting row...")

with sqlite3.connect('sf-trees.db', timeout=1) as conn:

    cursor = conn.execute('''
    INSERT into t1 VALUES(7, 5,	"mar",	"fri", 86.2, 26.2, 94.3, 5.1, 8.2,  51,	6.7, 0, 0);
       '''
)





# look at dataset page, sqllite then .data or .schema, or load first row of data in sql database 
