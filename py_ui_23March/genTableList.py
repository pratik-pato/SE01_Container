#!/usr/bin/python

import MySQLdb, sys

# Open database connection
db = MySQLdb.connect("localhost","root","mysql",sys.argv[1] )

# prepare a cursor object using cursor() method
cursor = db.cursor()

# Prepare SQL query to INSERT a record into the database.
sql = "show tables;"

tabNames = []

try:
       # Execute the SQL command
          cursor.execute(sql)
             # Fetch all the rows in a list of lists.
          results = cursor.fetchall()
          for row in results:
               tabNames.append(row[0])
except:
       print "Error: unable to fecth data"

       # disconnect from server
db.close()


iNumberOfTables = int(len(tabNames))

fileName1 = ("genTableList.html")

txt = open(fileName1,'w+')

dynStr = ""
for i in range(0,len(tabNames)):
          dynStr+="TableArray[%s] = \"%s\";\n"%(int(i), tabNames[int(i)])

print dynStr
javaScr = "window.onload = function() {\nvar TableArray = new Array();\n%svar tableList = document.getElementById(\"tableList\");\nfor (i=0;i<TableArray.length;i++)\n{\nvar Entry = document.createElement(\"option\");\nEntry.text = TableArray[i];\ntableList.add(Entry ,null);\n }\n }\n function keyOnTableList(event) {\nvar x = event.which || event.keyCode;\n if(x==13)\n {\n var val = document.getElementById(\"tableList\").value;\n alert(\"The Unicode value is: \" + x +\"  and value is :\" + val);\n }\n }\n"%(dynStr)

txt.write("<html>\n<head>\n<script type=\"text/javascript\">\n%s\n</script>\n</head>\n<body>\n<form>\n<br>\nSelect Table\n<br><select id=\"tableList\" size = %d autofocus onkeypress=\"keyOnTableList(event)\">\n</select>\n</form>\n</body>\n</html>\n"%(javaScr, iNumberOfTables))
