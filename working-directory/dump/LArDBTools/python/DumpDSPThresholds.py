#!/bin/env python
# DumpDSPThresholds.py
# Script to dump the tresholds used by the LAr DSP 


import sys,os,tempfile,commands,getpass


def DumpDSPThresholds():
    #Settings: 
    dbRead="oracle://ATLAS_COOLPROD;schema=ATLAS_COOLONL_LAR;dbname=CONDBR2" #Use default reader account
    templateFolder="/LAR/Configuration/DSPThresholdFlat/Templates"
    prodFolder="/LAR/Configuration/DSPThresholdFlat/Thresholds" 
    peekTime=cool.ValidityKeyMax-1

    dbSvc = cool.DatabaseSvcFactory.databaseService()
    try:
        db= dbSvc.openDatabase(dbRead)
    except Exception,e:
        print "Problems connecting to database:",e
        return 1

    if not db.existsFolder(templateFolder):
        print "ERROR: Folder",templateFolder,"doesn't exist!"
        return 1
    
    if not db.existsFolder(prodFolder):
        print "ERROR: Folder",prodFolder,"doesn't exist!"
        return 1
    
    tFldr=db.getFolder(templateFolder)
    knownVersions=tFldr.listTags()
    
 
   #Try to get the current version:
    try:
        pFldr=db.getFolder(prodFolder)
        currObj=pFldr.findObject(peekTime,0)
        currThr=currObj.payload()["Name"]
        print "Currently used set: "
        print currThr
        if currThr is None:
            print "ERROR: Can get current thresholds1"
    except Exception,e:
        print "ERROR: Can get current thresholds2"
        print e
        currTrh=None

    
    print "Checking for available sets...."
    print "Available sets of thresholds:"
    for i in range(len(knownVersions)):
        t=knownVersions[i]
        print "[%i] %s" % (i, t),
        try:
            obj=tFldr.findObject(peekTime,3,t)
            if obj.payload()["PoolRef"] == currThr:
                print " [active]",
            #print obj.payload()["PoolRef"]
        except:
            pass
        print ""
    db.closeDatabase()
        

if __name__=='__main__':
    if (os.system('which AtlCoolConsole.py  2>/dev/null 1>/dev/null')!=0):
        print "Cannot find AtlCoolConsole.py - need offline release setup"
        sys.exit(-1)
    try:
        from PyCool import cool
    except Exception, e:
        print e
        print "ERROR: Can't import PyCool module, wrong setup?"
        sys.exit(-1)


    DumpDSPThresholds()            
