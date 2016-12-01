#!/bin/env python
import sys,os
from PyCool import cool
sys.path.append('/afs/cern.ch/user/a/atlcond/CondAFSBufferMgr/python')
from ReadPoolFileCatalog import fileCatalogParser
from GetGUIDs import GUIDExtractor

scriptname_Reco="registerFast.sh"
scriptname_Rest="registerSlow.sh"

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
            if db.existsFolder(fn):
                f=db.getFolder(fn)
                if (f.versioningMode()==cool.FolderVersioning.MULTI_VERSION):
                    tagList=f.listTags()
                    sv=False
                else:
                    tagList=[""] #For singleVersion
                    sv=True
                for t in tagList:
                    itr=f.browseObjects(cool.ValidityKeyMin,cool.ValidityKeyMax,cool.ChannelSelection.all(),t)
                    nObj=0
                    if t.find("UPD1")!=-1:
                        upd1=True
                    else:
                        upd1=False
                    fast=sv or upd1
                    while itr.goToNext():
                        obj=itr.currentRef()
                        payload=obj.payload()
                        nObj+=1
                        thisGuid=extractor.getGUID(payload)
                        if thisGuid is not None:
                            if guiddict.has_key(thisGuid):
                                if fast: guiddict[thisGuid]=True
                            else:
                                guiddict[thisGuid]=fast
                    itr.close()
                    print "Folder",fn,"Tag",t,":",nObj,"objects found",
                    if sv: print "SV",
                    if upd1: print "UPD1",
                    if fast:
                        print "(Reco)"
                    else:
                        print "(Calib)"
        db.closeDatabase()
    #Gathered all guids, not resolve them to pfns:
    fastpfns=list()
    slowpfns=list()
    size=0
    localfiles=list()
    for (g,f) in guiddict.iteritems():
        pfn=catParser.getPFN(g)
        if pfn=="":
            print "ERROR failed to resolve GUID",g,"via catalog",catalog
            nErr+=1

        #Check file size & accessiblity
        try:
            statinfo=os.stat(pfn)
            filesize=statinfo[6]
        except:
            print "ERROR Can't access file: ",pfn
            nErr+=1
            continue
        
        size+=filesize

        if os.path.isabs(pfn):
            if not pfn.startswith("/afs/"):
                localfiles+=pfn
        else: #no absolute path given
            if not os.getcwd().startswith("/afs/"):
                localfiles+=pfn
                #print "ERROR file",pfn," (in current wd) is not on afs!"
                #nErr+=1
                #continue
        
        if f:
            fastpfns+=[pfn]
        else:
            slowpfns+=[pfn]

    
    print "Found %i files with a total size of  %.2f MBytes" % (len(fastpfns)+len(slowpfns),size/(1024*1024.0))



    if len(localfiles)>0:
        command="/afs/cern.ch/user/a/atlcond/utils/registerFiles2 --wait "+ dataset
        if size > 5*1024*1024:
            print "ERROR more than 5 MBytes that need to be copied! Please use afs-based directory!"
            nErr+=1
    else:
        command="/afs/cern.ch/user/a/atlcond/utils/registerFiles2 --symlink --wait "+ dataset
    
    maxFilesPerCommand=10

    raus=open(scriptname_Reco,"w")

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



    raus=open(scriptname_Rest,"w")
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

    return nErr

if __name__=='__main__':
    def usage():
        print "Usage: " 
        print sys.argv[0],"dataset catalog sqlite1 sqlite2 ..."
        print "Creates scrips to register pool files to a conditions dataset"
        print "Dataset: condR2_data.lar.COND or its successor"
    if len(sys.argv)<4:
        usage()
        sys.exit(-1)
    else:
        dbs=[]
        for d in sys.argv[3:]:
            dbs+=["sqlite://;schema="+d+";dbname=CONDBR2"]
        print "Building registration script for dataset:"
        print "Catalog:",sys.argv[2]
        print "Dataset",sys.argv[1]
        print "Database:",dbs
        errs=makeRegScript(dbs,sys.argv[2],sys.argv[1]);
        if errs:
            print "Encountered one or more errors, please check!"
            sys.exit(-1)
        else:
            print "No error encountered."
            print "Output files:"
            print scriptname_Reco,"To upload files used by default reconstruction"
            print scriptname_Rest,"To upload remaining files"
            

        
