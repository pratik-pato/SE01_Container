#/usr/bin/python
import os,sys,inspect,psycopg2
givenWallList = []

def fnConnectPsql():
    sDbname = 'postgres'
    sUser = 'pratik'
    sPassword = ''
    try:
        conn = psycopg2.connect("dbname={} user={} password={}".format(sDbname, sUser, sPassword))
        conn.autocommit = True
        cur = conn.cursor()
        return cur
    except Exception as e:
        print e

def fnInsertFaces(objectId,roof,floor,right,left,front,back):
        
	givenWallList = ([locals()[arg] for arg in inspect.getargspec(fnInsertFaces).args])
	givenWallList = givenWallList[1:] 
    	cur = fnConnectPsql()
    	cur.execute("select concreteroof, concretefront, concreteback, concretefloor, concreteleft, concreteright from containerconcretetypefaces;")
    	usedWalls = cur.fetchall()
    	cur.execute("select concreteroof, concretefront, concreteback, concretefloor, concreteleft, concreteright from noncontainerconcretetypefaces;")
    	wallsTemp = cur.fetchall()
    	for i in wallsTemp:
    	    usedWalls.append(i)
    	usedWalls = [e for l in usedWalls for e in l]
	#print usedWalls
	#print givenWallList
	for i in givenWallList:
            if i in usedWalls:
                print "Wall already used"
                return
                
            else:
                print "Wall VALID"
                return
           	
#fnInsertFaces('ct3','w01','w02','w05','w30','w20','w18') --invalid
#fnInsertFaces('ct5','w37','w38','w39','w40','w41','w42') --valid
# In [9]: uniqueWall.fnInsertFaces('ct3','w01','w02','w05','w30','w20','w18')
# Wall already used

# In [10]: uniqueWall.fnInsertFaces('ct1','w13','w14','w15','w16','w17','w01')
# Wall VALID
