#!/bin/env python
import sys,getopt
from PyCool import cool
import PyCintex

def listDBUpdates(dbname,fName,tag,fromRun=0,detail=0,getROChans=False):
    print "Connecting to database",dbname,".."
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    try:
        db= dbSvc.openDatabase(dbname+";user=ATLAS_COOL_READER;password=COOLRED4PRO")
    except Exception,e:
        print "Problems connecting to database:",e
        return 1
    print "Done"

    print "Checking tag",tag,"for runs >",fromRun
    
    if not db.existsFolder(fName):
        print "ERROR: Folder",fName,"not found in ",dbname
        return -1


    class iovSummary:
        def __init__(self,uT,coolCh,bcSum,roCh):
            self.bcSummary=bcSum
            self.roChans=set(roCh)
            self.coolChans=set((coolCh,))
            self.updateTime=uT
            return
        
        def add(self,uT,coolCh,bcSum,roCh):
            self.coolChans.add(coolCh)
            self.roChans.update(roCh)
            self.updateTime=uT
            for i in range(min(len(bcSum),len(self.bcSummary))):
                self.bcSummary[i]+=bcSum[i]
            return
        
        def toString(self,prevChans=set()):
            ut=self.updateTime
            result=" %i-%.2i-%.2i %.2i:%.2i:%.2i" % \
                  (ut.year(),ut.month(),ut.day(),ut.hour(),ut.minute(),ut.second())
            if len(self.bcSummary)==1:
                result+=" %i" % self.bcSummary[0]
                                                             
            elif len(self.bcSummary)>1:
                for bs in self.bcSummary:
                    result+=" %i" % bs
            else:
                pass

            if len(self.roChans)>0 and len(prevChans)>0:
                addCh=self.roChans.difference(prevChans)
                remCh=prevChans.difference(self.roChans)
                result+="\n\tAdded readout Channels:"
                for ch in addCh:
                    result+=" 0x%x" % ch
                result+="\n\tRemoved readout Channels:"
                for ch in remCh:
                    result+=" 0x%x" % ch
            
            return result
            
    iovs=dict()
    def newIOV(since,updateTime,BCSummary,coolCh,roChans):
        if not iovs.has_key(since):
            iovs[since]=iovSummary(updateTime,coolCh,BCSummary,roChans)
        else:
            if len(BCSummary) != len(iovs[since].bcSummary):
                print "Ch",coolCh,"Incosistency found related to Channel summary length",len(BCSummary), len(iovs[since].bcSummary)
            iovs[since].add(updateTime,coolCh,BCSummary,roChans)
        return

    f=db.getFolder(fName)
    if (f.versioningMode()==cool.FolderVersioning.MULTI_VERSION):
        if not f.existsUserTag(tag):
            print "ERROR: Tag",tag,"not defined in folder",fName
            return -1
    else: #SingleVersion folder
        tag="HEAD"

    fR=fromRun<<32

    if (detail>0 or getROChans):
        cl_LArBadChannel=PyCintex.makeClass('LArBadChannel')
        cl_LArBadChannelDBTools=PyCintex.makeNamespace('LArBadChannelDBTools')
        cl_AthenaAttributeList=PyCintex.makeClass('AthenaAttributeList')
        #cl_AttrList=PyCintex.makeClass('coral::AttributeList')
        ms=cl_LArBadChannelDBTools.getDefaultMsgStream()
    
    itr=f.browseObjects(fR,cool.ValidityKeyMax,cool.ChannelSelection.all(),tag)
    while itr.goToNext():
        obj=itr.currentRef()
        pl=obj.payload()
        s=obj.since()
        roChans=set()
        updatetime=obj.insertionTime()
        if detail>0 or getROChans:
            al=cl_AthenaAttributeList(pl.attributeList())
            vect_BadChanEntry=cl_LArBadChannelDBTools.readBadChan(al,ms)
            nchannels=len(vect_BadChanEntry)
            bcSum=[nchannels,]
            if (getROChans):
                for (id,bc) in vect_BadChanEntry:
                    roChans.add(id.get_compact())
            
            if detail==1: 
                nSporadic=0
                nNoise=0
                for (id,bc) in vect_BadChanEntry:
                    if bc.sporadicBurstNoise(): nSporadic+=1
                    if bc.reallyNoisy(): nNoise+=1
                bcSum+=[nNoise,nSporadic]
            elif detail==2:
                bcSum+=[0 for i in range(32)]
                for (id,bc) in vect_BadChanEntry:
                    for i in range(32):
                        bcSum[i]+=(bc.packedData()>>i)&0x1
        else:
            bcSum=[pl["Blob"].size()/8,]
        
        newIOV(s,updatetime,bcSum,obj.channelId(),roChans)
        
    itr.close()

    db.closeDatabase()

    #output:
    #      169966 0 2010-12-06 16:43:43  2998 195 1397
    if detail==0:
        print "Run  LB   updated at          # of Bad Channels "  
    elif detail==1:
        print "Run  LB   updated at          Tot  Noise Sporadic"
    elif detail==2:
        print "Run  LB   updated at          deadReadout deadCalib deadPhys almostDead short unstable distorted lowNoiseHG highNoiseHG unstableNoiseHG lowNoiseMG highNoiseMG unstableNoiseMG lowNoiseLG highNoiseLG unstableNoiseLG peculiarCalibrationLine problematicForUnknownReason sporadicBurstNoise"
        
    ss=iovs.keys();
    ss.sort()
    prevROChans=set()
    for i in ss:
        iov=iovs[i]
        print i>>32,i&0xFFFFFFFF,
        print iov.toString(prevROChans)
        prevROChans=iov.roChans
        
        
    return

if __name__ == "__main__":

    def usage():
        print "Sytnax:"
        print sys.argv[0]," -c -d <levelOfDetail> [ONLINE/OFFLINE] tag <fromRun>"
        print "  -d Level of detail. 0: total nbr of channels"
        print "                      1: total, noise, sporadic"
        print "                      2: all bit"
        print " -c List channels added/removed"
        sys.exit(-1) 

    details=0
    printChans=False
    opts,args=getopt.getopt(sys.argv[1:],"c,d:",["details"])
    for o,a in opts:
        if o=='-d': details=long(a)
        if o=="--details":
            if not isdigit(a):
                print "Expected numerical value for 'details', got",a
                sys.exit(-1)
            details=long(a)
        if o=="-c": printChans=True

        
    if len(args)<2 or len(args)>3:
        usage()

    if details<0 or details>2:
        print "Expected 0,1 or 2 as level of detail, got", details
        sys.exit(-1)

    onOff=args[0].upper()

    if len(onOff)<2 or len(onOff)>7:
        usage();
    
    if onOff.startswith("ON"):
        dbname="oracle://ATLR;schema=ATLAS_COOLONL_LAR;dbname=COMP200"
        folder="/LAR/BadChannels/BadChannels"
    elif onOff.startswith("OFF"):
        dbname="oracle://ATLR;schema=ATLAS_COOLOFL_LAR;dbname=COMP200"
        folder="/LAR/BadChannelsOfl/BadChannels"
    else:
        usage()


    tag=args[1]
    tagbase="".join(folder.split("/"))
    if len(tag)==4:
        tag=tagbase+"-"+tag+"-00"
    elif len(tag)==7:
        tag=tagbase+"-"+tag
    else:
        if not tag.startswith(tagbase):
            print "WARNING: tag should start with",tagbase

    if len(args)>2:
        if not args[2].isdigit():
            print "Expected a run number, got",args[2]
            sys.exit(-1)
        fromRun=long(args[2])

    else:
        fromRun=0
                
    #listDBUpdates("COOLOFL_LAR/COMP200","/LAR/BadChannelsOfl/BadChannels","LARBadChannelsOflBadChannels-UPD4-00",150000)
    listDBUpdates(dbname,folder,tag,fromRun,details,printChans)
