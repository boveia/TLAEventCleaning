#!/bin/env python

#getIOVAge.py
#Author: Walter Lampl (walter.lampl@cern.ch)


from RunNumInfo import getNextAtlasRunNumber
import cppyy
from PyCool import cool
import sys,getopt

def getCoolChannelAge(databaseName,folderName,tag,run=cool.ValidityKeyMax>>32):
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    try:
        db= dbSvc.openDatabase(databaseName)
    except Exception,e:
        print "Problems connecting to Oracle database:",e
        return

    results=[]
    nodelist=db.listAllNodes()
    for node in nodelist:
        if node.startswith(folderName) and db.existsFolder(node):
            f=db.getFolder(node)
       
            if f.versioningMode()==cool.FolderVersioning.SINGLE_VERSION:
                restag=""
            elif tag not in f.listTags():
                try:
                    restag=f.resolveTag(tag)
                except Exception:
                    print "Tag", tag, "not defined in foder", node
                    continue
            else:
                restag=tag
            #print "Working on Folder ",node,restag
            r1=run<<32
            itr=f.browseObjects(r1-1,r1,cool.ChannelSelection.all(),restag)
            while itr.goToNext():
                obj=itr.currentRef()
                ch=obj.channelId()
                since=obj.since()>>32
                until=obj.until()>>32
                #print "Channel %i: Valid since %i (%i runs ago) Insertion: %s" % (ch,since,RN-since,obj.insertionTime())
                results+=[(since,until,obj.insertionTime(),node,ch)]
            itr.close()
    return results
#getCoolChannelAge("COOLONL_LAR/COMP200",["/LAR/ElecCalibOnl/Pedestal"],"")

if __name__=='__main__':
    def usage():    
        print "Usage:"
        print sys.argv[0],"<database> -f <folder> -t <tag> -r <run> -c -s"
        print "Options: -c .. list every COOL channel, -s .. sort per age"
        
    if (len(sys.argv)<3):
        usage();
        sys.exit(-1);
            
    dbname=sys.argv[1]


    folder='/'
    tag="HEAD"
    perChan=False
    sort=False
    run=cool.ValidityKeyMax>>32
    opts,args=getopt.getopt(sys.argv[2:],"f:t:r:cs")#,["guid=","folder=","run=","tag="])
    for o,a in opts:
        if o=="-f": folder=a
        if o=="-t": tag=a
        if o=="-r": run=int(a)
        if o=="-c": perChan=True
        if o=="-s": sort=True
            
    data=getCoolChannelAge(dbname,folder,tag,run)
    RN=getNextAtlasRunNumber()
    if sort:
        data.sort(reverse=True);
        
        print "sorted."
    if perChan:
        for d in data:
            print "Folder %s, Channel %i: Valid since %i (%i runs ago) Insertion: %s" % (d[3],d[4],d[0],RN-d[0],d[2])
    else:
        processedFolders=[]
        for d in data:
            if d[3] not in processedFolders:
                processedFolders+=[d[3]]
                print "Folder %s: Valid since %i (%i runs ago) Insertion: %s" % (d[3],d[0],RN-d[0],d[2])
