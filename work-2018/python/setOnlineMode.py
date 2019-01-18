#!/bin/env python

import cppyy
from PyCool import cool
import sys

def setOnlineMode(connect):
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    try:
        print "Connecting to ", connect
        db = dbSvc.openDatabase(connect,False)
    except Exception, e:
        print e
        print "could not connect to the database"
        sys.exit(-1)

    FLAG="<updateMode>UPD1</updateMode>"
    haveSV=False
    nodelist=db.listAllNodes()
    for node in nodelist:
        if db.existsFolder(node):
            folder=db.getFolder(node)
            if folder.versioningMode()==cool.FolderVersioning.SINGLE_VERSION:
                print "Working on folder ", node
                haveSV=True
                descr=folder.description()
                if descr.find(FLAG)!=-1:
                    print "Folder already update-only, ignore."
                else:
                    descr+=FLAG
                folder.setDescription(descr)
                print "Set to update-mode 1"
    if not haveSV:
        print "No single-version folder found!"
  

if __name__=='__main__':
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
    setOnlineMode(connect)
