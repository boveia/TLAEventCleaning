#!/bin/env python

import sys
from PyCool import cool
from pyAMI import pyAMI
sys.path.append('/afs/cern.ch/user/a/atlcond/CondAFSBufferMgr/python')
from GetGUIDs import GUIDExtractor
from LArConditionsCommon import LArExtendedFTGrouping


def getProvenance(databaseName,folderName,tag,run,detPart,gain,year="2009"):
    #Get COOL channels for detPart
    grouping=LArExtendedFTGrouping.LArExtendedFTGrouping()
    #print detPart,gain
    cls=grouping.getChannelList([detPart],[gain])
    if len(cls)==0:
        print "ERROR: No COOL channels defined for detPart",detPart,"and gain",gain
        return 1
    sel=cool.ChannelSelection(cls[0])
    i=1
    #print "0",cls[0]
    while i<len(cls):
        #print i,cls[i]
        sel.addChannel(cls[i])
        i=i+1

    #Open COOL DB to get GUIDs
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    try:
        inputdb= dbSvc.openDatabase(databaseName)
    except Exception,e:
        print "Problems connecting to Oracle database:",e
        return
    extractor=GUIDExtractor()

    folder=inputdb.getFolder(folderName)
    if folder.versioningMode()==cool.FolderVersioning.SINGLE_VERSION:
        restag=""
    elif tag not in folder.listTags():
        try:
            restag=folder.resolveTag(tag)
        except Exception:
            print "Tag ", tag, " not defined in foder ", folderName
            return guids
    else:
        restag=tag
    itr=folder.browseObjects((run<<32),(run<<32),sel,restag)
    guidsAndOids=dict()
    while itr.goToNext():
        obj=itr.currentRef()
        payload=obj.payload()
        thisGuid=extractor.getGUID(payload)
        thisOids=extractor.getOIDs(payload)
        #print thisGuid,thisOids[0]
        if guidsAndOids.has_key(thisGuid):
            guidsAndOids[thisGuid].update((thisOids[0],))
        else:
            guidsAndOids[thisGuid]=set((thisOids[0],))
    itr.close()
    inputdb.closeDatabase()
    amiclient=pyAMI.AMI()


    print "Found Metadata records:"
    for g,os in guidsAndOids.iteritems():
        #Get file information via GUID
        cmd=("ListElement",
             "-entity=files",
             "-project=POOL_Cond",
             "-processingStep="+year,
             "-fileGUID="+g
             )

        result=amiclient.execute(cmd)
        files=result.getDict()['files']
        if not files.has_key('row_1'):
            print "ERROR: No AMI record found for this POOL file"
            return

        file=files['row_1']
    
        print "POOL file: Guid:",g,"LFN:",file['LFN']
        print "  Athena Version:",file['ATLASRELEASE']
        print "  Processing Date:",file['PROCESSINGDATE']

        # Get object details using guid,oid and DetPart
        for o in os:
            cmd=("ListElement", 
                 "-entity=object_details",
                 "-project=POOL_Cond",
                 "-processingStep="+year,
                 "-fileGUID="+g,
                 "-fileObjectIndex="+str(o),
                 "-detectorPart="+detPart,
             )


            result=amiclient.execute(cmd)
            object_details=result.getDict()['object_details']
            print "  Found",len(object_details),"object details:"
            for prov in object_details.itervalues():
                print "    DetPart:%s Gain:%s PedRN:%s DelayRN:%s RampRN:%s Dir:%s" %\
                      (prov['DETECTORPART'],prov['GAIN'],prov['PEDESTALRUNNUM'],prov['DELAYRUNNUM'],prov['RAMPRUNNUM'],prov['DIRECTORY'])


    return "Done"



if __name__=='__main__':
    def usage():
        print "Usage: "
        print sys.argv[0],"<runnumber> <folder> <partition> <gain> <year> [<tag>]" 
        print "Returns the AMI provenance record for a given piece of LAr calibration"
        sys.exit(-1)
        

    if len(sys.argv)<3 or len(sys.argv)>6:
        usage()

    #db="COOLONL_LAR/COMP200"
    rn=int(sys.argv[1])
    folder=sys.argv[2]
    part=sys.argv[3]
    gain=int(sys.argv[4])
    year=sys.argv[5]
    if len(sys.argv)>6:
        tag=sys.argv[6]
        db="COOLOFL_LAR/COMP200"
    else:
        tag=""
        db="COOLONL_LAR/COMP200"
        
    print "Query provenance record for:"
    print "Database:",db
    print "Folder: ",folder
    print "Gain", gain
    print "Year", year
    print "Partition",part
    print "Tag:",tag

    getProvenance(db,folder,tag,rn,part,gain)
    

#print getProvenance("COOLONL_LAR/COMP200","/LAR/ElecCalibOnl/Pedestal","",800000,"EMBC",0)



#amiCommand ListElement -fileGUID=FC1712CD-E3AC-DE11-B13A-00304879FC6E -entity=file_objects -project=POOL_Cond -processingStep=2009

#amiCommand ListElement -fileGUID=FC1712CD-E3AC-DE11-B13A-00304879FC6E -entity=files -project=POOL_Cond -processingStep=2009
#amiCommand ListElement -fileGUID=FC1712CD-E3AC-DE11-B13A-00304879FC6E -entity=object_details -project=POOL_Cond -processingStep=2009 -detectorPart=EMBCPS
# amiCommand ListElement -fileGUID=FC1712CD-E3AC-DE11-B13A-00304879FC6E -entity=object_details -project=POOL_Cond -processingStep=2009 -detectorPart=EMBCPS fileObjectIndex=3



