#!/bin/env python

from PyCool import cool
import sys


def setSgKey(db,fName,key):
    if not db.existsFolder(fName):
        print "Folder ",fName,"does not exist."
        return

    f=db.getFolder(fName);
    print "Working on folder",fName
    oldDescr=f.description()
    print "Old folder description:", oldDescr
    marker1="<key>"
    marker2="</key>"
    p1=oldDescr.find(marker1)
    p2=oldDescr.find(marker2)
    if (p1==-1 or p2==-1):
        print "ERROR No SG key set in this folder??" 
        return

    p2+=len(marker2)

    oldKey=oldDescr[p1:p2]
    header=oldDescr[:p1] 
    trailer=oldDescr[p2:]
    
    newKey=marker1+key+marker2

    if (newKey==oldKey):
        print "StoreGate key",newKey,"already ok. Leave untouched"
        return
    
    print "Changing SG key from",oldKey,"to",newKey

    newDescr=header+newKey+trailer
    f.setDescription(newDescr)
    return

    
if __name__=='__main__':

    folderKeys=(#("/LAR/ElecCalibOfl/AutoCorrs/PhysicsAutoCorr","LArAutoCorr"),
                ("/LAR/ElecCalibOfl/OFC/PhysWave/RTM/5samples1phase","LArOFC"),
                ("/LAR/ElecCalibOfl/OFC/PhysWave/RTM/5samples3bins17phases","LArOFC"),
                ("/LAR/ElecCalibOfl/OFC/PhysWave/RTM/4samples1phase","LArOFC"),
                ("/LAR/ElecCalibOfl/OFC/PhysWave/RTM/4samples3bins17phases","LArOFC"),
                ("/LAR/ElecCalibOfl/Shape/RTM/5samples1phase","LArShape"),
                ("/LAR/ElecCalibOfl/Shape/RTM/5samples3bins17phases","LArShape"),
                ("/LAR/ElecCalibOfl/Shape/RTM/4samples1phase","LArShape"),
                ("/LAR/ElecCalibOfl/Shape/RTM/4samples3bins17phases","LArShape"),
                )
    
    if (len(sys.argv)<2 or len(sys.argv)>3):
        print "Usage:"
        print sys.argv[0], " <sqlite> {<dbname>}"
        sys.exit(-1)

    if (len(sys.argv)==3):
        dbname=sys.argv[2]
    else:
        dbname="CONDBR2"

    file=sys.argv[1]
    connect="sqlite://;schema="+file+";dbname="+dbname
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    try:
        print "Connecting to ", connect
        db = dbSvc.openDatabase(connect,False)
    except Exception, e:
        print e
        print "could not connect to the database"
        sys.exit(-1)

    print "Working on database",connect
    for (folder,key) in folderKeys:
        setSgKey(db,folder,key)
        
    db.closeDatabase()
    
        
