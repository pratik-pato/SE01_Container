#!/usr/bin/python

import psycopg2
import sys

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


def fnGetWallDoorDimension(wallId,doorId,displacementAB,displacementAD,orientation):
    cur = fnConnectPsql()
    cur.execute("select walllengthab,walllengthad from abstractwall where wallid = '%s';"%(wallId))
    wallDim = cur.fetchone()
    wallAB = wallDim[0]
    wallAD = wallDim[1]
    wallArea = wallDim[0]*wallDim[1]
 
    cur.execute("select doorlengthab,doorlengthad from abstractdoor where doorid = '%s';"%(doorId))
    doorDim = cur.fetchone()
    doorAB = doorDim[0]
    doorAD = doorDim[1]
    doorArea = doorDim[0]*doorDim[1]

    if wallArea <= doorArea:
		print "door dimension exceeds limit"
    elif  orientation == 'ABCD':
		if (displacementAB + doorAB >= wallAB) or (displacementAD + doorAD >= wallAD):
                    print "given orientation has problems"
		else:
                    print "door with this orientation  placed on wall"
    elif orientation == 'BCDA':
		if (displacementAD - doorAB <= 0) or (displacementAB + doorAD >= wallAB):
                    print "given orientation has problems"
		else:
                    print "door with this orientation  placed on wall"
                    
    elif orientation == 'CDAB':
		if (displacementAD - doorAD <= 0) or (displacementAB - doorAB <= 0):
                    print "given orientation has problems"
		else:
                    print "door with this orientation  placed on wall"
                    
    elif orientation == 'DABC':
		if (displacementAD + doorAB >= wallAD) or (displacementAB - doorAD >= 0):
                    print "given orientation has problems"
		else:
                    print "door with this orientation  placed on wall"
			
    elif orientation == 'BADC':
		if (displacementAD + doorAD >= wallAD) or (displacementAB - doorAB <= 0):
                    print "given orientation has problems"
		else:
                    print "door with this orientation  placed on wall"
                    
    elif orientation == 'ADCB':
		if (displacementAD + doorAB >= wallAD) or (displacementAB + doorAD >= wallAB):
                    print "given orientation has problems"
		else:
                    print "door with this orientation  placed on wall"

    elif orientation == 'DCBA':
		if (displacementAD - doorAD <= 0) or (displacementAB + doorAB >= wallAB):
                    print "given orientation has problems"
		else:
                    print "door with this orientation  placed on wall"

    elif orientation == 'CBAD':
		if (displacementAD - doorAB <=0) or (displacementAB - doorAD <= 0):
                    print "given orientation has problems"
		else:
                    print "door with this orientation  placed on wall"



                    # In [2]: validateDoorWall.fnGetWallDoorDimension('w01','d1',10,10,'BCDA')
                    # given orientation has problems

                    # In [3]: validateDoorWall.fnGetWallDoorDimension('w01','d1',10,10,'ABCD')
                    # door with this orientation  placed on wall

                    # In [4]: validateDoorWall.fnGetWallDoorDimension('w13','d1',10,10,'ABCD')
                    # door dimension exceeds limit
                    
