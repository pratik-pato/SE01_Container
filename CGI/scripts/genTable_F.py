#!/usr/bin/python

import genJS, psycopg2, sys, cgi
form = cgi.FieldStorage()
sDbname = 'SE01'
sUser = 'pratik_SE'
sHost = 'localhost'
sPass = 'easports'
sTablename = form["tabName"].value
conn = psycopg2.connect("dbname={} user={} host={} password={}".format(sDbname, sUser, sHost, sPass))
conn.autocommit = True
cursor = conn.cursor()
sql = []
sql.append("select column_name from information_schema.columns  where table_name = '%s';"%(sTablename))
sql.append("select count(*) from %s"%(sTablename))

def executeQuery(query):
    resList = []
    try:
        cursor.execute(query)
        results = cursor.fetchall()
        for row in results:
            resList.append(row[0])
        
    except Exception as e:
        print e

    return resList
    conn.close()

'''
try:
    jsFile = open('phase3.html','w+')
except IOError as e:
        print "I/O error({0}): {1}".format(e.errno, e.strerror)
except ValueError:
        print "Could not convert data to an integer."
except:
        print "Unexpected error:", sys.exc_info()[0]
        raise
'''
print("Content-Type: text/html")
print ""
#print(""" """)
genJS.genOpenTag()
genJS.javaScriptType("jquery/jquery.js", "", "")
countRows = executeQuery(sql[1])
countRows = map(int, countRows)
colList = executeQuery(sql[0])
#print colList
colListStr = ','.join(colList)
emptyLst = []
for i in range(countRows[0]):
    emptyLst.append("")
print("<script type=\"text/javascript\">\n")
print("var count = %d;var table = %s;function getValues(event, n) {if(event.which == \"9\") {var focusedElement = $(\":focus\");var ele = Number(focusedElement.attr(\"id\").slice(4));var val = focusedElement.attr(\"value\");var temp = ele/n;var tempDiff = temp%%1;temp = temp - tempDiff;var temp1 = ele%%n;table[temp][temp1] = val;}else if(event.which == \"13\") {var value = \"\";var i;var rowEntry = [];for(i = (count * n); i < ((count + 1) * n); i++) {var temp;temp = document.getElementById(\"attr\" + i);if(temp != null) {value = temp.value;if(value == \'\') {alert(\"enter attribute \" + (i + 1));break;}else {rowEntry.push(value);}}}table.push(rowEntry);count++;var newTableRow = $(document.createElement(\'tr\')).attr(\"id\", \'TableRow\' + count);newTableRow.after().html("%(int(countRows[0]), str(emptyLst)))
genJS.genColumnTag(int(countRows[0]), len(colList))
print(");newTableRow.appendTo(\"#idTable\");document.getElementById(\"attr\" + (count * n)).focus();}else if(event.which == \"37\") {var focusedElement = $(\":focus\");var ele = Number(focusedElement.attr(\"id\").slice(4));if(ele > 0) {var input = document.getElementById(\"attr\" + (ele - 1));input.focus();var val = input.value;input.value = \'\';input.value = val;}else {var input = document.getElementById(\"attr\" + ele);input.focus();var val = input.value;input.value = \'\';input.value = val;}}else if(event.which == \"38\") {var focusedElement = $(\":focus\");var ele = Number(focusedElement.attr(\"id\").slice(4));if(ele >= n) {var input = document.getElementById(\"attr\" + (ele - n));input.focus();var val = input.value;input.value = \'\';input.value = val;}}else if(event.which == \"39\") {var focusedElement = $(\":focus\");var ele = Number(focusedElement.attr(\"id\").slice(4));if(ele < (count * n) + %d) {var input = document.getElementById(\"attr\" + (ele + 1));input.focus();var val = input.value;input.value = \'\';input.value = val;}}else if(event.which == \"40\") {var focusedElement = $(\":focus\");var ele = Number(focusedElement.attr(\"id\").slice(4));if(ele < (count * n)) {var input = document.getElementById(\"attr\" + (ele + n));input.focus();var val = input.value;input.value = \'\';input.value = val;}}}function submitTable(n) {var i;var rowEntry = [];for(i = 0; i < n; i++)rowEntry.push(document.getElementById(\"attr\" + ((count * n) + i)).value);console.log(count);table.push(rowEntry);for(i = 0; i <= count; i++)console.log(table[i]);}</script>"%(len(colList)-1))

print("\n<body>\n<table id=\"idTable\" border=\"1\" style=\"width:100%\">\n<tr id=\"tableHead\">\n")
genJS.genAttrNames(colList)
print("</tr>")
tableDataQuery = "select %s from %s;"%(colListStr, sTablename)
tableData = []
for i in colList:
    tableData.append([])
try:
    cursor.execute(tableDataQuery)
    results = cursor.fetchall()
    for row in results:
        for i in range(len(row)):
            tableData[i].append(row[i])
    #print "tableData"
    #print tableData

except:
    print "Error: unable to fecth data"
conn.close()
genJS.genRow( tableData)
print("</table><input type = \"button\" value = \"Submit\" onkeydown=\"submitTable(%d)\" onclick=\"submitTable(%d)\"></body></html>"%(int(countRows[0]), int(countRows[0])))
