#!/usr/bin/python

import psycopg2
import sys,inspect

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

def fnWallDimCheck(containerID,roof,floor,right,left,front,back):
    lWall = []
    lallWallDim = []
    cur = fnConnectPsql()
    lWall = ([locals()[arg] for arg in inspect.getargspec(fnWallDimCheck).args])
    lWall = lWall[1:]
 #   print lWall

    for j in lWall:
        #print j
        cur.execute("select walllengthab,walllengthad from abstractwall where wallid = '%s';"%(j))
        ls2 = cur.fetchall()
        lallWallDim.append(ls2)
        
    #print lallWallDim


    
    cur.execute("select containerlengthab,containerlengthad,containerlengthae from containerconcretetypes where containerconcretetypeid = '%s';"%(containerID))
    lDims = cur.fetchall()
    #print lDims
    flg = 0
    iWidth = lDims[0][0]
    iLength = lDims[0][1]
    iHgt = lDims[0][2]
    #print iWidth
    #print iLength
    #print iHgt
    

    
    #print iWidth , lallWallDim[0][0][0] ,iLength , lallWallDim[0][0][1]
    if (iWidth == lallWallDim[0][0][0] and iLength == lallWallDim[0][0][1]) or (iWidth == lallWallDim[0][0][1] and iLength == lallWallDim[0][0][0]):
        flg = 0
    else:
        print "INVALID"
        return
        
    
    #print iWidth , lallWallDim[1][0][0] ,iLength , lallWallDim[1][0][1]
    if (iWidth == lallWallDim[1][0][0] and iLength == lallWallDim[1][0][1]) or (iWidth == lallWallDim[1][0][1] and iLength == lallWallDim[1][0][0]):
        flg = 0
    else:
        print "INVALID"
        return
    
    #print iLength , lallWallDim[2][0][0] ,iHgt , lallWallDim[2][0][1]
    if (iLength == lallWallDim[2][0][0] and iHgt == lallWallDim[2][0][1]) or (iLength == lallWallDim[2][0][1] and iHgt == lallWallDim[2][0][0]):
        flg = 0
    else:
        print "INVALID"
        return
    
    #print iLength , lallWallDim[3][0][0] ,iHgt , lallWallDim[3][0][1]
    if (iLength == lallWallDim[3][0][0] and iHgt == lallWallDim[3][0][1]) or (iLength == lallWallDim[3][0][1] and iHgt == lallWallDim[3][0][0]):
        flg = 0
    else:
        print "INVALID"
        return
    
    #print iWidth , lallWallDim[4][0][0] ,iHgt , lallWallDim[4][0][1]
    if (iWidth == lallWallDim[4][0][0] and iHgt == lallWallDim[4][0][1]) or (iWidth == lallWallDim[4][0][1] and iHgt == lallWallDim[4][0][0]):
        flg = 0
    else:
        print "INVALID"
        return
    
    #print iWidth , lallWallDim[5][0][0] ,iHgt , lallWallDim[5][0][1]
    if (iWidth == lallWallDim[5][0][0] and iHgt == lallWallDim[5][0][1]) or (iWidth == lallWallDim[5][0][1] and iHgt == lallWallDim[5][0][0]):
        flg = 0
        
    else:
        print "INVALID"
        return
                                              


    if flg == 0:
        print "VALID"
    else:
        print "INVALID"
                                
                        
    
#wallDimCheck.fnWallDimCheck('ct1','w05','w06','w01','w02','w03','w04')--val
#wallDimCheck.fnWallDimCheck('ct1','w01','w02','w03','w04','w05','w06')--inv
