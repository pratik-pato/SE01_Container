#!/usr/bin/python

import psycopg2, sys, cgi


sDbname = 'SE01'
sUser = 'pratik_SE'
sHost = 'localhost'
sPass = 'easports'
conn = psycopg2.connect("dbname={} user={} host={} password={}".format(sDbname, sUser, sHost, sPass))
conn.autocommit = True
cursor = conn.cursor()
sql = "select table_name from information_schema.tables where table_schema = 'public';"
tabNames = []
try:
    cursor.execute(sql)
    results = cursor.fetchall()
    for row in results:
        tabNames.append(row[0])
except Exception as e:
    print e

conn.close()

iNumberOfTables = int(len(tabNames))
dynStr = ""
for i in range(0,len(tabNames)):
          dynStr+="TableArray[%s] = \"%s\";\n"%(int(i), tabNames[int(i)])

javaScr = "window.onload = function() {\nvar TableArray = new Array();\n%svar tableList = document.getElementById(\"tableList\");\nfor (i=0;i<TableArray.length;i++)\n{\nvar Entry = document.createElement(\"option\");\nEntry.text = TableArray[i];\ntableList.add(Entry ,null);\n }\n }\n function keyOnTableList(event) {\nvar x = event.which || event.keyCode;\n if(x==13)\n {\n var val = document.getElementById(\"tableList\").value;\n alert(\"The Unicode value is: \" + x +\"  and value is :\" + val);\ndocument.getElementById(\"fieldSet\").value=val; }\n }\n"%(dynStr)

print("Content-Type: text/html")
print ""

#print "Content-type:text/javascript\r\n\r\n"
print "<html>\n<head>\n<script type=\"text/javascript\">\n%s\n</script>\n</head>\n<body>\n<form action=\"genTable_F.py\" method=\"get\">\n<br>\nSelect Table\n<br><select id=\"tableList\" iNumberOfTables= %d autofocus onkeypress=\"keyOnTableList(event)\">\n</select>\n<br><input type=\"submit\" value=\"getTable\"><br><input id = \"fieldSet\" type = \"text\" name=\"tabName\" value= \"\" style \"display: none;\"></form>\n</body>\n</html>\n"%(javaScr, iNumberOfTables)
