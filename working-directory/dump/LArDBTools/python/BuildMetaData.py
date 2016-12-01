#!/usr/bin/env python

from  MakeProvenanceDict import ProvenanceDict, ProvenanceItem
import FolderToDatatype
from LArCondMetaData import LArCondMetaDataFile, LArCondMetaDataObject
#from LArConditionsCommon import LArExtendedFTGrouping
from LArConditionsCommon import LArExtendedSubDetGrouping 
from PyCool import cool
import sys,os,getpass
from pyAMI import pyAMI
from  pyAMI.pyAMIErrors import AMI_Error
from time import localtime,asctime
sys.path.append('/afs/cern.ch/user/a/atlcond/CondAFSBufferMgr/python')
from GetGUIDs import GUIDExtractor
from ReadPoolFileCatalog import fileCatalogParser
from ReadMetaData import getDatasets

class fixedValues:
    dataset=""# "LArConditionsTest" #Only for tests
    AMIProject="POOL_Cond"
    processingStep="2009"
    


class MetaData:
    def __init__(self,provdictfile,catalogs):
        self._provDict=ProvenanceDict(provdictfile)
        #self._grouping=LArExtendedFTGrouping.LArExtendedFTGrouping()
        self._grouping=LArExtendedSubDetGrouping.LArExtendedSubDetGrouping()
        self._extractor=GUIDExtractor()
        self._amilogfilename="ami.log"
        self._gainToString=("HIGH","MEDIUM","LOW")
        self._castorCatParser=fileCatalogParser(catalogs)
        self._pfns=self._castorCatParser.getAllFiles()
        self._exec=True
        #self._provDict.dump()

          
    def BuildMetaData(self,mdPerObj):
        folder=mdPerObj.folder
        channels=mdPerObj.channels
        if not FolderToDatatype.FolderToDatatype.has_key(folder):
            print "ERROR Unknown folder",folder
            return True
        type=FolderToDatatype.FolderToDatatype[folder]

        #print folder,channels,type
        #PartGainProv=tuple()
        pts=self._grouping.channelsPerPartition(channels)
        for p in pts.itervalues():
            for gain in (0,1,2):
                if p.counts[gain]>0:
                    prov=self._provDict.getProvenance(folder,set(self._grouping.getChannelList([p.name],[gain])))
                    if len(prov)==0:
                        print "ERROR: No provenance record found for object",type,"gain",gain
                        #return True
                    elif (len(prov)>1):
                        print "ERROR: Expected exactly one provenance object for folder",folder,"partition",p.name,"Gain",gain,"Got",len(prov)
                        #return True
                    else:
                        mdPerObj.PartGainProv+=((p.name,gain,prov[0][0]),) #,prov[0][1],prov[0][2]),)
                        mdPerObj.procDate=prov[0][1]
                        mdPerObj.procVersion=prov[0][2]
                    
        mdPerObj.type=type
        return False

    def writeToAmi(self,cmd):
        for c in cmd:
            if c.startswith("-AMIPass"):
                self._alf.write("-AMIPASS=<pwd> ")
            else:
                self._alf.write(c+" ")
        self._alf.write("\n")

        if not self._exec:
            #Dummy mode, return
            return 0
     
        else:
            retries=0
            while retries<2:
                retries=retries+1
                try:
                    result=self._amiclient.execute(cmd)
                    self._alf.write(result.output())
                    self._alf.write("\n ---------- \n")
                    return 0 #everything worked as expected
                except AMI_Error, aerr:
                    self._alf.write(aerr.errMsg)
                    self._alf.write("\n ---------- \n")
                    #Deal with known errors:
                    if aerr.errMsg.find("ORA-00001")!=-1:
                        return 1
                    elif aerr.errMsg.find('wrong AMI identification')!=-1:
                        print aerr.errMsg
                        return 2
                    else:
                        print aerr.errMsg
                        print "Attempt #",retries
                        self._alf.write("Attempt #"+str(retries)+"\n")
            return 3 #after two unsuccessful attempts

                        

    

    def buildFromSqlite(self, sf, amiuser, amipass, dbname="COMP200"):
        dbspec="sqlite://;schema="+sf+";dbname="+dbname
        try:
            dbSvc= cool.DatabaseSvcFactory.databaseService()
            db = dbSvc.openDatabase(dbspec)
            print "Opend",dbspec
        except Exception, e:
            print e
            print "could not connect to the database"
            sys.exit(-1)
            

        metaPerFile=dict()

            
        #Loop through all folders & tags:
        nodelist=db.listAllNodes()
        for node in nodelist:
            if db.existsFolder(node):
                folder=db.getFolder(node)
                #print "Working on folder",node
                if folder.versioningMode()==cool.FolderVersioning.SINGLE_VERSION:
                    tags=[""]
                else:
                    tags=folder.listTags()
                for t in tags:
                    #print "Found Tag",t
                    itr=folder.browseObjects(cool.ValidityKeyMin,cool.ValidityKeyMax,cool.ChannelSelection.all(),t)
                    while itr.goToNext():
                        obj=itr.currentRef()
                        payload=obj.payload()
                        thisGuid=self._extractor.getGUID(payload)
                        thisOids=self._extractor.getOIDs(payload)
                        if thisGuid is None or thisOids is None:
                            print "Failed to extract GUID and OIDs from payload",payload
                            return 1
                        if not metaPerFile.has_key(thisGuid):
                            metaPerFile[thisGuid]=LArCondMetaDataFile(thisGuid)
                        metaPerFile[thisGuid].add(thisOids[0],node,obj.channelId())
                    itr.close()
        db.closeDatabase()


        #Complete Meta-data objects:
        for file in metaPerFile.itervalues():
            for (oid,objmd) in file.objIter():
                objmd.oid=oid
                stat=self.BuildMetaData(objmd)
                if stat:
                    print "ERROR in BuildMetaData"
                    return 2

        #Now do the AMI transactions
        print "Start doing AMI transactions..."
        self._amiclient=pyAMI.AMI()

        try:
            self._alf=open(self._amilogfilename,"w")
        except:
            print "Failed to open log file",self._amilogfilename
            return 3

        #Get Dataset  & LFNs from POOL file catalog
        #Get availabe datasets:
        (validDS,invalidDS)=getDatasets()
        #(validDS,invalidDS)=([""],[""]) Hack to create 2010 datasets in AMI
        firstDS=""
        for (guid,file) in metaPerFile.iteritems():
            if not self._pfns.has_key(guid):
                print "ERROR: GUID",guid,"not found in POOL file catalogs!"
                return 3
            physPath=self._pfns[guid][0].split('/')
            if fixedValues.dataset=="":
                if len(physPath)<2:
                    print "ERROR: Can't defer dataset from POOL file path!"
                    return 6
                file.dataset=physPath[-2]
            else:
                file.dataset=fixedValues.dataset            
            file.lfn=physPath[-1]

            if firstDS=="":
                firstDS=file.dataset
            elif firstDS!=file.dataset:
                print "WARNING: More than one dataset referenced in this sqlite file!"

            if file.dataset in invalidDS:
                print "ERROR Datset",file.dataset,"exist but is not valid"
                sys.exit(-1);
            if not file.dataset in validDS:
                res=raw_input("Dataset "+file.dataset+" does not exist in AMI. Create [Y/N]")
                if not res.upper().startswith("Y"):
                    print "Dataset does not exist and not created. Exit."
                    return 4
                else:
                    print "Creating dataset",file.dataset
                    amiCmd=("AddDataset",
                            "-project="+fixedValues.AMIProject,
                            "-processingStep="+fixedValues.processingStep,
                            "-logicalDatasetName="+file.dataset,
                            "-dataType=COND",
                            "-AMIUser="+amiuser,"-AMIPass="+amipass
                            )
                    stat=self.writeToAmi(amiCmd)
                    if stat: return stat
                    validDS+=(file.dataset,)

                    
        #All subsequent command start with the same initial part:
        amiCmdHead=("AddElement",
                    "-project="+fixedValues.AMIProject,
                    "-processingStep="+fixedValues.processingStep,
                    "-AMIUser="+amiuser,"-AMIPass="+amipass)
                
        
        for (guid,file) in metaPerFile.iteritems():
            # 1. File-object
            if file.size()==0: continue
            (procDate,procVersion)=file.DateAndVersion()
        
            print "Info for file guid,lfn,dataset,version,time",guid,file.lfn,file.dataset,procVersion,asctime(localtime(procDate))

            procDateTuple=localtime(procDate)
            amiCmd=amiCmdHead + ("-entity=files",
                                 "-logicalDatasetName="+file.dataset,
                                 "-LFN="+file.lfn,
                                 "-fileGUID="+guid,
                                 #"-processingDate=2010-08-14 00:00:00",
                                 "-processingDate=%.4i-%.2i-%.2i %.2i:%.2i:%.2i" % (procDateTuple[0],procDateTuple[1],procDateTuple[2],procDateTuple[3],procDateTuple[4],procDateTuple[5]),
                                 "-ATLASRelease="+procVersion
                                 )
            stat=self.writeToAmi(amiCmd)
            #return value 1 means file exists alreayd. Ignore.
            if stat>1: return stat

            # 2. Objects inside file 
            for (oid,objmd) in file.objIter():
                print "\tInfo for object",oid,"Type",objmd.type,"Date",asctime(localtime(objmd.procDate)),"Version",objmd.procVersion
                amiCmd=amiCmdHead + ("-entity=file_objects",
                                     #-LFN="+file.lfn,
                                     "-fileGUID="+guid,
                                     "-fileObjectIndex="+str(oid),
                                     "-calibDataType="+objmd.type
                                     )
                stat=self.writeToAmi(amiCmd)
                #return value 1 means file exists alreayd. Ignore.
                if stat>1: return stat
                
                for part in objmd.PartGainProv:
                    #3.Partitions in objects:
        
                    partition=part[0]
                    gain=part[1]
                    prov=part[2]
                    runs=prov.split("_")
                    if len(runs)<3:
                        print "ERROR: Provenance string",prov,"malformed."
                    pedrun=int(runs[0])
                    delayrun=int(runs[1])
                    ramprun=int(runs[2])
                    #print "\t\tPartition %s, gain %i, prov %s, date %s, version %s" % (partition,gain,prov,asctime(localtime(procDate)),procVersion)


                    amiCmd=amiCmdHead + ("-entity=object_details",
                                         #-LFN="+file.lfn,
                                         "-fileGUID="+guid,
                                         "-calibDataType="+objmd.type,         
                                         "-detectorPart="+partition,
                                         "-gain="+self._gainToString[gain],
                                         "-pedestalRunNum=%i" % pedrun,
                                         "-delayRunNum=%i" % delayrun,
                                         "-rampRunNum=%i" % ramprun,
                                         "-directory="+prov
                                         )
                    stat=self.writeToAmi(amiCmd)
                    #return value 1 means file exists alreayd. Ignore.
                    if stat>1: return stat
                    print "\t\tPartition %s, gain %i, prov %s" % (partition,gain,prov)
        self._alf.close()
        return 0



if __name__=='__main__':
    if len(sys.argv) < 3:
        print "ERROR, wrong number of parameters. Syntax:"
        print sys.argv[0],"<provenance file> <sqlite-file>"
        sys.exit(-1)

    provFile=sys.argv[1]
    sqFile=sys.argv[2]
    if len(sys.argv)>3:
        catalogs=sys.argv[3:]
    else:
        catalogs=()
        catalogDir="/afs/cern.ch/atlas/conditions/poolcond/catalogue/fragments/"
        import re
        catPattern=re.compile("PoolCat_cond[0-9][0-9]_data.*.lar.COND_castor.xml")
        #PoolCat_comcond.000004.lar_conditions.recon.pool.v0000_castor.xml
        allcats=os.listdir(catalogDir)
        for c in allcats:
            if catPattern.search(c):
                catalogs+=(catalogDir+c,)

    if not os.access(provFile,os.R_OK):
        print "ERROR: Can't read provenance file",provFile
        sys.exit(-1)

    if not os.access(sqFile,os.R_OK):
        print "ERROR: Can't read sqlite file",sqFile
        sys.exit(-1)
    
    user=raw_input("AMI-user:")
    passwd=getpass.getpass()


    md=MetaData(provFile,catalogs)
    err=md.buildFromSqlite(sqFile,user,passwd)
    if err!=0:
        sys.exit(-1)
