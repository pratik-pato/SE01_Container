#!/usr/bin/python

import MySQLdb
import sys
import genJS #Created own module to generate javascript 

# Open database connection
db = MySQLdb.connect("localhost","root","mysql",sys.argv[1])

# prepare a cursor object using cursor() method
cursor = db.cursor()

# Prepare SQL query to INSERT a record into the database.
sql = "SELECT `COLUMN_NAME`  FROM `INFORMATION_SCHEMA`.`COLUMNS`  WHERE `TABLE_SCHEMA`='container'  AND `TABLE_NAME`='%s';"%(sys.argv[2])
colList = []
try:
       # Execute the SQL command
          cursor.execute(sql)
             # Fetch all the rows in a list of lists.
          results = cursor.fetchall()
          for row in results:
               colList.append(row[0])
               
          print "Columns\n",colList
except:
       print "Error: unable to fecth data"

       # disconnect from server
       db.close()
jsFile = open('genColList.html','w+')
jsFile.write("<html>\n<body>\n")
genJS.javaScriptType(jsFile, "js/jquery.min.js", "css/bootstrap.min.css", "stylesheet")
genJS.javaScriptType(jsFile, "js/bootstrap.min.js", "css/bootstrap-multiselect.css", "stylesheet")
genJS.javaScriptType(jsFile, "js/bootstrap-multiselect.js", "", "")
jsFile.write("<script type=\"text/javascript\">\n$(function () {\n$(\'#optionList\').multiselect({\nincludeSelectAllOption: true\n});\n$(\'#btnSelected\').click(function () {\nvar selected = $(\"#optionList option:selected\");\nvar message = \"\";\nselected.each(function () {\nmessage += $(this).text() + \" \" + $(this).val() + \"\";\n});\nalert(message);\n});\n});\n</script>\n")
genJS.genOptions(jsFile, colList)
jsFile.write("</body>\n</html>")
