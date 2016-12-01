#!/bin/env python
import sys,os
from PyCool import cool
sys.path.append('/afs/cern.ch/user/a/atlcond/CondAFSBufferMgr/python')
from ReadPoolFileCatalog import fileCatalogParser
from GetGUIDs import GUIDExtractor
import BuildMetaData


def makeRegScript(dbnames,catalog,dataset):
    nErr=0
    catParser=fileCatalogParser([catalog])
    extractor=GUIDExtractor()
    if len(catParser._files)==0: 
        print "No data read from",catalog
        return 1
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    guiddict=dict()
    for dbname in dbnames:
        try:
            db= dbSvc.openDatabase(dbname)
        except Exception,e:
            print "Problems connecting to database:",e
            return 1


        nodelist=db.listAllNodes()
        for fn in nodelist:
            if fn.find('ElecCalibOnl')!=-1 or fn.find('samples')!=-1:
                fast=True
            else:
                fast=False
            if db.existsFolder(fn):
                f=db.getFolder(fn)
                if (f.versioningMode()==cool.FolderVersioning.MULTI_VERSION):
                    tagList=f.listTags()
                else:
                    tagList=[""] #For singleVersion
                for t in tagList:
                    itr=f.browseObjects(cool.ValidityKeyMin,cool.ValidityKeyMax,cool.ChannelSelection.all(),t)
                    nObj=0
                    while itr.hasNext():
                        obj=itr.next()
                        payload=obj.payload()
                        chan=obj.channelId()
                        nObj+=1
                        thisGuid=extractor.getGUID(payload)
                        if thisGuid is not None:
                            if not guiddict.has_key(thisGuid):
                                guiddict[thisGuid]={fn:set((chan,))}
                            else:
                                guidentry=guiddict[thisGuid]
                                if guidentry.has_key(fn):
                                    guidentry[fn].add(chan)
                                else:
                                    guidentry[fn]=set((chan,))
                    itr.close()
                    print "Folder",fn,"Tag",t,":",nObj,"objecs found."
        db.closeDatabase()
    #Gathered all guids, not resolve them to pfns:
    fastpfns=list()
    slowpfns=list()
    size=0
    for (g,f) in guiddict.iteritems():
        pfn=catParser.getPFN(g)
        if pfn=="":
            print "ERROR failed to resolve GUID",g,"via catalog",catalog
            nErr+=1

        #Check file size & accessiblity
        try:
            statinfo=os.stat(pfn)
        except:
            print "ERROR Can't access file: ",pfn
            nErr+=1
            continue

       ##  #Check if file is on afs (necessary to uplaod)
##         if os.path.isabs(pfn):
##             if not pfn.startswith("/afs/"):
##                 print "ERROR file",pfn,"is not on afs!"
##                 nErr+1
##                 continue
##         else: #no absolute path given
##             if not os.getcwd().startswith("/afs/"):
##                 print "ERROR file",pfn," (in current wd) is not on afs!"
##                 nErr+1
##                 continue

        fast=False
        for fn in f.iterkeys():
            if fn.find('ElecCalibOnl')!=-1 or fn.find('samples')!=-1:
                fast=True
                break
        if fast:
            fastpfns+=[pfn]
        else:
            slowpfns+=[pfn]
        size+=statinfo[6]
        
    print "Found",len(fastpfns)+len(slowpfns),"files with a total size of",size/(1024*1024.0),"MBytes"
    mddict=BuildMetaData.MetaData("freshConstants.provenance")
    for (g,fchans) in guiddict.iteritems():
        print g
        for (f,chans) in fchans.iteritems():
            print mddict.BuildMetaData(f,chans)
        
##         mraus=open("meta"+g,"w")
##         for (f,c) in fchans.iteritems():
            

##     del d

    maxFilesPerCommand=10

    raus=open("registerFast.sh","w")
    command="/afs/cern.ch/user/a/atlcond/utils/registerFiles2 --symlink --wait "+ dataset
    nf=0
    line=command
    npfns=len(fastpfns)
    ip=0
    while (ip<npfns):
        pfn=fastpfns[ip]
        line+=" "+pfn
        ip+=1
        if (ip==npfns or (ip%maxFilesPerCommand==0)):
            line+="\n"
            raus.write(line)
            line=command 
    raus.close()



    raus=open("registerSlow.sh","w")
    nf=0
    line=command
    npfns=len(slowpfns)
    ip=0
    while (ip<npfns):
        pfn=slowpfns[ip]
        line+=" "+pfn
        ip+=1
        if (ip==npfns or (ip%maxFilesPerCommand==0)):
            line+="\n"
            raus.write(line)
            line=command 
    raus.close()




    return 0

if __name__=='__main__':
    def usage():
        print "Usage: " 
        print sys.argv[0],"dataset catalog sqlite1 sqlite2 ..."
        print "Creates scrips to register pool files to a conditions dataset"
    if len(sys.argv)<4:
        usage()
    else:
        dbs=[]
        for d in sys.argv[3:]:
            dbs+=["sqlite://;schema="+d+";dbname=COMP200"]
        print "Building registration script for dataset:"
        print "Catalog:",sys.argv[2]
        print "Dataset",sys.argv[1]
        print "Database:",dbs
        makeRegScript(dbs,sys.argv[2],sys.argv[1]);
