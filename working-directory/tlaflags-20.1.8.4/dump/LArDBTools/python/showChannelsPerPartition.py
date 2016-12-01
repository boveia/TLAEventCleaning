#!/bin/env python

import sys
from PyCool import cool
from LArConditionsCommon import LArExtendedFTGrouping

def showChannelsPerPartition(dbnames,mode=0):
    #mode=0: Print number of channels for each partition & gain for each folder
    #mode=1: 
    
    g=LArExtendedFTGrouping.LArExtendedFTGrouping()
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    foldersAndChans=dict()
    for dbname in dbnames:
        try:
            db = dbSvc.openDatabase(dbname)
        except Exception, e:
            print e
            print "could not connect to the database"
            sys.exit(-1)

        nodelist=db.listAllNodes()
        for node in nodelist:
            if db.existsFolder(node):
                f=db.getFolder(node)
                chans=f.listChannels()
                if foldersAndChans.has_key(node):
                    foldersAndChans[node]+=tuple(chans)
                else:
                    foldersAndChans[node]=tuple(chans)
        db.closeDatabase()
        
    for (node, chans) in foldersAndChans.iteritems():
        pts=g.channelsPerPartition(chans)
        if mode==0:
            print "Folder:",node
            pts["EMBA"].show()
            pts["EMBC"].show()
            pts["EMBAPS"].show()
            pts["EMBCPS"].show()

            pts["EMECA"].show()
            pts["EMECC"].show()
            pts["EMECAPS"].show()
            pts["EMECCPS"].show()


            pts["HECA"].show()
            pts["HECC"].show()

            pts["FCALA"].show()
            pts["FCALC"].show()

            pts["EMPTYC"].show()
            pts["EMPTYA"].show()
            print ""
        elif mode==1:
            print node,
            for p in pts.itervalues():
                if p.counts[0]>0:
                    print p.name,"HIGH,",
                if p.counts[1]>0:
                    print p.name,"MEDIUM,",
                if p.counts[2]>0:
                    print p.name,"LOW,",
            print ""



if __name__=='__main__':
     if len(sys.argv)<2 :
         print "Usage:"
         print sys.argv[0],"COMPL <database1> <database2> ..."
         print sys.argv[0],"TOC <database1> <database2> ..."
         print "COMPL: Check completness. Print number of channels per folder, partition and gain"
         print "TOC: Print 'table of content' (list of partitions/gain per folder)"
         sys.exit(-1)


     if sys.argv[1]=="COMPL":
         details=0
     elif sys.argv[1]=="TOC":
         details=1
     else:
         print "Unknown action",sys.argv[1]
         sys.exit(-1)

     dbns=[]
     for dbn in sys.argv[2:]:
         if dbn.find(":/")>-1: #assume complete db name
             dbns+=[dbn]
         else: #assume name of sqlite file
             dbns+=["sqlite://;schema="+dbn+";dbname=CONDBR2"]
             
     showChannelsPerPartition(dbns,details)
