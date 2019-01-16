#!/bin/env python

import cppyy
from PyCool import cool
import sys

def overlappingChannelFinder(dbname1, dbname2):
    
    dbSvc = cool.DatabaseSvcFactory.databaseService()

    try:
        print "Connecting to ", dbname1
        db1 = dbSvc.openDatabase(dbname1)
    except Exception, e:
        print e
        print "could not connect to the database"
        sys.exit(-1)


    try:
        print "Connecting to ", dbname2
        db2 = dbSvc.openDatabase(dbname2)
    except Exception, e:
        print e
        print "could not connect to the database"
        sys.exit(-1)


    nodelist=db1.listAllNodes()
    ret=0
    for node in nodelist:
        if db1.existsFolder(node) and  db2.existsFolder(node):
            f1=db1.getFolder(node)
            f2=db2.getFolder(node)
            chans1=f1.listChannels()
            chans2=f2.listChannels()
            for c1 in chans1:
                if c1 in chans2:
                    print "Folder ", node, " channel ",c1, "exists in both databases"
                    ret=ret+1
    return ret


if __name__=='__main__':
     if len(sys.argv) is not 3 :
         print "Usage:"
         print sys.argv[0]," <database1> <database2>"
         sys.exit(-1)
     nc=overlappingChannelFinder(sys.argv[1], sys.argv[2])
     if (nc):
         sys.exit(-1)
     else:
         print "No overlapping channels found"
         sys.exit(0)
         
