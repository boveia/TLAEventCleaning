#!/bin/env python

#projectTag="data11_7TeV"
#projectTag="data11_hi"
#projectTag="data12_8TeV"

#projectTag="data12_hip"
#projectTag="data13_hip"
#projectTag="data13_2p76TeV"
#projectTag="data15_cos"
#projectTag="data15_comm"
#projectTag="data15_13TeV"
import sys
import cppyy
sys.modules['PyCintex'] = PyCintex = cppyy

from PyCool import cool
from time import asctime,gmtime
from ROOT import TTree,TFile

noiseWord=0x1<<15
corruptWord=0x1<<31

# removed from AFS in July 2017:
#eoscmd="/afs/cern.ch/project/eos/installation/0.3.84-aquamarine/bin/eos.select"
eoscmd="/usr/bin/eos"

class RunLumiToTimeStamp:
    def __init__(self):
        from CoolConvUtilities.AtlCoolLib import indirectOpen
        #self._db=dbSvc.openDatabase("COOLONL_TRIGGER/CONDBR2")
        self._db=indirectOpen("COOLONL_TRIGGER/CONDBR2")
        self._folder=self._db.getFolder("/TRIGGER/LUMI/LBLB")
        pass
    
    def __del__(self):
        self._db.closeDatabase()

    def getRunStartStop(self,run):
        t1=None
        t2=None
        itr=self._folder.browseObjects(cool.ValidityKey(run<<32),cool.ValidityKey((1+run)<<32),cool.ChannelSelection(0))
        while itr.goToNext():
            obj=itr.currentRef()
            pl=obj.payload()
            if t1 is None: t1=pl["StartTime"]
            t2=pl["EndTime"]
            pass
        return (t1,t2)
            
    def getStartStop(self,(r1,l1),(r2,l2)):
        rl1=(r1<<32) | l1
        rl2=(r2<<32) | l2
        try:
            obj1=self._folder.findObject(cool.ValidityKey(rl1),0)
            pl1=obj1.payload()
            t1=pl1["StartTime"]
        except:
            t1=None
            
        try:
            obj2=self._folder.findObject(cool.ValidityKey(rl2),0)            
            pl2=obj2.payload()
            t2=pl2["StartTime"]
        except:
            t2=None
        return (t1,t2)


def createFolder(db,name):
    desc='<timeStamp>time</timeStamp><addrHeader><address_header service_type="71" clid="40774348" /></addrHeader><typeName>AthenaAttributeList</typeName>'
    spec = cool.RecordSpecification()
    spec.extend('EventVeto',cool.StorageType.UInt32)
    fspec=cool.FolderSpecification(cool.FolderVersioning.MULTI_VERSION, spec)
    return db.createFolder(name,fspec,desc, True)

def ts2string(ts):
    if ts==0:
        return "0"
    if ts==cool.ValidityKeyMax:
        return "INF"
    stime=int(ts/1000000000L)
    return asctime(gmtime(stime))+" UTC"

def sumRanges(inputRange):
    total=0
    for r in inputRange:
        total+=r[1]-r[0]
    return total/1e9



def buildFilteredRange(inputSet, nEvents,TimeWindow,word,minStd=0):
    print "Converting event time stamps into time ranges. Requiring",nEvents,"events within",TimeWindow,"second(s)",
    if (minStd>0):
        print "with at least",minStd,"events from LArNoisyRO_Std"
    else:
        print ""
    if (nEvents<=0 or TimeWindow<=0): return None
    
    TimeWindow_ns=int(TimeWindow*1000000000L)
    output=[]
    if isinstance(inputSet,set):
        indict=dict.fromkeys(inputSet,0x1)
    else:
        indict=inputSet
        
    inList=sorted(indict.items(), key=lambda rng: rng[0]) 
    #print "Before filter:",inList

    print "Have",len(inList),"problematic events in total"
    #half=int(TimeWindow/2)
    half=TimeWindow_ns>>1
    i=0
    nDropped=0
    while i<len(inList):
        j=1
        if (inList[i][1] & 0x1): 
            nStd=1
        else:
            nStd=0
    
        while (i+j<len(inList) and ((inList[i+j][0]-inList[i][0]<TimeWindow_ns) or (j>=nEvents and inList[i+j][0]-inList[i+j-1][0]<TimeWindow_ns))) :
            j=j+1
            if (inList[i+j-1][1] & 0x1): nStd=nStd+1
            pass
        
        if j<nEvents or nStd<minStd: #ignore this burst
            #print j,nEvents,nStd,minStd
            i=i+1
            nDropped+=1
        else:
            output.append((inList[i][0]-half,inList[i+j-1][0]+half))
            i=i+j
            pass
        pass
    print "Found",len(output),"Veto Ranges"
    print "Dropped",nDropped,"isolated events"
    #print "After Filter:",[(d[0]/1e9,d[1]/1e9) for d in output]
    return [(d[0],d[1],word) for d in output]
  
            

def purgeRanges(inputList):
    output=[]
    #inputLen=sumRanges(inputList)
    overlap_ns=0L
    #1. sort by iov-begin
    sortedInput=sorted(inputList, key=lambda rng: rng[0])
    sz=len(sortedInput)
    idx=0
    #for idx1 in range(s):
    while (idx<sz):
        (s,u,w)=sortedInput[idx]
        #print "Starting point [%u] (%u,%u,0x%x)" % (idx,s,u,w)
        #for idx2 in range(idx1+1,s):
        while (idx<sz):
            idx+=1
            if (idx==sz): break
            (s1,u1,w1)=sortedInput[idx]
            #print "Evaluating point [%u] (%u,%u,0x%x)" % (idx,s1,u1,w1)
            if (s1<u and w==w1):
                #Found overlap
                #print "Found overlap",u,u1
                if (u1>u):
                    overlap_ns+=(u-s1)
                    u=u1
                else:
                    overlap_ns+=(u1-s1)
                pass    
            else:
                break #inner for loop
            pass
        output.append((s,u,w))
        pass
    #print "Removing overlapping ranges. Input size",sz,"output size",len(output)
    print "Removing overlapping ranges. Input size %i, output size %i, total overlap removed %.2f seconds" % (sz,len(output),overlap_ns/1e9)

    #outputLen=sumRanges(output)
    #print "Input time veto:", inputLen," output time veto",outputLen,"diff",inputLen-outputLen
    
    return output
 
 
def convertMissingFebList(inputList):
    mintime=0L
    maxtime=9223372036854775807
    
    if isinstance(inputList,set): #backward compatiblity
        return ((mintime,maxtime,inputList),)
    if len(inputList)==1:
        #print "Single Missing FEB IOV",mintime,maxtime,inputList[0][2]
        return ((mintime,maxtime,inputList[0][2]),)

    print "Found ",len(inputList),"MissingFEBs IOVs for this run. Converting to time-stamps."
    rlTots=RunLumiToTimeStamp()
    outputList=[]
    for (rl1,rl2,pl) in inputList:
        run1=rl1>>32
        LB1=rl1 & 0xFFFFFFFF
        run2=rl2>>32
        LB2=rl2 & 0xFFFFFFFF
        ts1,ts2=rlTots.getStartStop((run1,LB1),(run2,LB2))
        if ts1 is None: ts1=mintime
        if ts2 is None: ts2=maxtime
        pl32=set()
        for fpl in pl: pl32.add(fpl>>32)
        #outputList.append((ts1,ts2,pl))
        outputList.append((ts1,ts2,pl32))
        #print "Missing FEB IOV",ts1,ts2,pl
    return outputList


def getMissingFEBsForTime(t,missingFebsAllIOV):
    for (t1,t2,pl) in missingFebsAllIOV:
        if (t>t1 and t<t2): return pl

    return set()



def fillEventVetoFolder(db,tag,dataIn,
                         folderName="/LAR/BadChannelsOfl/EventVeto"):

    data=purgeRanges(dataIn)

    if db.existsFolder(folderName):
        folder = db.getFolder(folderName)
    else:
        #create new folder
        print "Folder", folderName,"does not exit yet. Creating it now." 
        folder=createFolder(db,folderName)

    sum=0L
    N=0
    for veto in data:
        if len(veto)!=3:
            print "Error: Expected three numbers as data word, got",veto
            return -1
        since=cool.ValidityKey(veto[0])
        until=cool.ValidityKey(veto[1])
        word=veto[2]

        #The DB could already contain data for this IOV. Read back if there.
        #IOV-range + payload word is stored in the objectsInIOV structure
        objectsInIOV=[]
        if folder.existsUserTag(tag):
            itr=folder.browseObjects(cool.ValidityKey(since),cool.ValidityKey(until),cool.ChannelSelection(0),tag)
            while itr.goToNext():
                obj=itr.currentRef()
                payload=obj.payload()
                objectsInIOV.append([obj.since(),obj.until(),payload["EventVeto"]])
            itr.close()

        if len(objectsInIOV)==0:
            #print "No previous IOV found"
            #Create one entry in the objectsInIOV with full range and no payload
            objectsInIOV.append((since,until,0x0));

        else:
            if not (len(objectsInIOV)==1 and objectsInIOV[0][2]==0x0):  print "Data for this IOV exists already (0x%x)" % objectsInIOV[0][2]
            #print "since=",since," until=",until," IOVstart=",objectsInIOV[0][0]," IOVEnd=", objectsInIOV[-1][1]
            #Need to adjust IOV-boundaries so that it covers the input range ....
            # ...either by shortening...
            if objectsInIOV[0][0]<since:  objectsInIOV[0][0]=since 
            if objectsInIOV[-1][1]>until:  objectsInIOV[-1][1]=until
            #... or by padding.
            if objectsInIOV[0][0]>since: #Padding at the IOV-start
                objectsInIOV.insert(0,(since,objectsInIOV[0][0],0x0))
            if objectsInIOV[-1][1]<until: #Padding at the IOV-start
                objectsInIOV.append((objectsInIOV[-1][1],until,0x0))

        #now loop over iovs found and update the payload
        for obj in objectsInIOV:
            s=obj[0]
            u=obj[1]
            w=obj[2]
            if s==u: continue #The IOV shortening could leave us with a zero-size IOV
            payload = cool.Record(folder.payloadSpecification())
            payload["EventVeto"]=(w | word)  #bitwise OR of old and new payload
            #print "Adding event veto lasting from %i to %i, Flag: 0x%x" % (s,u,payload["EventVeto"])
            print "Adding event veto lasting from %s to %s, Flag: 0x%x" % (ts2string(s),ts2string(u),payload["EventVeto"])
            #print s,u,payload,tag
            folder.storeObject(s,u,payload,cool.ChannelId(0),tag)
            N+=1
            sum+=(u-s)

            
    print "Added a total of %i veto periods lasting a total of %.2f seconds (ignoring overlaps)" % (N,sum/1e9)
    return 0

def readFromText(filename):
    #Expected format:
    #iovStart iovStop Flag
    inFile=open(filename)
    data=[]
    for line in inFile:
        l1=line.split("#")[0]
        elem=l1.split()
        if len(elem)==0: continue
        if len(elem)!=3:
            print "ERROR, failed to interpret line. Expect three integers, got [%s]" % line
            continue
        entry=[]
        for e in elem:
            if e.startswith("0x"):
                base=16
                e=e[2:]
            else:
                base=10
            try:
                number=int(e,base)
            except ValueError:
                print "ERROR, failed to interpret line. Expect three integers, got [%s]" % line
                continue
            entry+=(number,)

        data+=((1000000000L*entry[0],1000000000L*entry[1],entry[2]),)
    inFile.close()

    print "Successfully ready",len(data),"entries from file",filename
    return data




def readFromROOT(filename,readNoise=True, readCorruption=True, ignoreFebs=()):
    treename_noise="/LAr/NoisyRO/LArNoise"
    treename_corrupt="/LAr/FEBMon/Summary/LArCorrupted"
    noisePoints=dict()
    corruptionPoints=set()
    
    print "Reading file",filename

    if filename.startswith("/eos/"):
        filename="root://eosatlas//"+filename
    
    inFile=TFile.Open(filename)
    if inFile is None or inFile.IsZombie():
        print "ERROR, could not open file",filename
        return None
    
        
    nTreesRead=0
    runNumbers=[]

    kl=inFile.GetListOfKeys()
    for k in kl:
        nm=k.GetName()
        if nm.startswith("run_"):
            try:
                runNumbers.append(int(nm[4:],10))
            except Exception,e:
                print "ERROR: Failed to extract run-number of directory name"
                print e
                pass
            
            if readNoise:
                tree_noise=inFile.Get(nm+treename_noise)
                if isinstance(tree_noise,TTree):
                    print "Collecting noise-burst information from", nm+treename_noise
                    noisePoints.update(readNoiseFromROOT(tree_noise,filename))
                    nTreesRead+=1
                else:
                    print "Failed to get tree",nm+treename_noise,"from file",filename
            #end if readNoise
            if readCorruption:
                tree_corrupt=inFile.Get(nm+treename_corrupt)
                if isinstance(tree_corrupt,TTree):
                    print "Collecting data-corruption information from",nm+treename_corrupt
                    corruptionPoints|=readCorruptionFromROOT(tree_corrupt,filename,ignoreFebs) # merge sets
                    nTreesRead+=1
                else:
                    print "Failed to get tree",nm+treename_corrupt,"from file",filename
            #end if readCorruption

    if nTreesRead==0:
        print "ERROR, could not read any tree from file",filename
        data=None

    return (noisePoints,corruptionPoints,runNumbers)


def readCorruptionFromROOT(inTree,filename, ignoreFebs=()):
    time_stamps=set()
    N=inTree.GetEntriesFast()
    #if len(ignoreFebs)>0 and not hasattr(inTree,"febHwId"):
    #    print "WARNING: TTree has no leave called \"febHwId\""
    for i in xrange(N):
        nb=inTree.GetEntry(i)
        if nb<=0:
            print "Failed to read entry",i,"of Tree",inTreeree.GetName(),"in file",filename
            return None
        
        if hasattr(inTree,"iovStart"):
            #2011 version:
            t=1000000000L*int(inTree.iovStart)+500000000L
            #t2=1000000000L*int(inTree.iovStop)
        else:
            #2012 version:        
            t=1000000000L*int(inTree.time)+int(inTree.time_ns)

        if hasattr(inTree,"febHwId"):
            febids=set(inTree.febHwId)
            ignoreFebsNow=getMissingFEBsForTime(t,ignoreFebs)
            print 'febids ',febids,' ignoreFebsNow ',ignoreFebsNow,' ignoreFebs ',ignoreFebs
            if not len(febids-ignoreFebsNow)>0: continue
            pass

        #print "Found data corrution at",t
        time_stamps.add(t)
        pass
    
    return time_stamps


def readNoiseFromROOT(inTree,filename):
    N=inTree.GetEntriesFast()
    retval=dict() 
    for i in xrange(N):
        nb=inTree.GetEntry(i)
        if nb<=0:
            print "Failed to read entry",i,"of Tree",inTree.GetName(),"in file",filename
            return None


        if hasattr(inTree,"algo"):
            algotype=ord(inTree.algo)
        else:
            algotype=1
        
        t=1000000000L*int(inTree.time)
        if hasattr(inTree,"time_ns"):
            t+=int(inTree.time_ns)
        retval[t]=algotype
        pass

    return retval


def getCastorPath(run,stream):
    import os,commands
    eigthDigits="%.8i" % run
    #os.environ["STAGE_SVCCLASS"]="atlcal"

    #Get project tag (from SFO DB):
    from GetProjectTag import GetProjectTag
    projectTag=GetProjectTag(run)
    if projectTag is None:
        print "Failed to get ProjectTag for run",run,"from SFO DB"
        return None
    else:
        print "Found project tag",projectTag,"for run",run

    #find histogram files:
    #/castor/cern.ch/grid/atlas/tzero/prod1/perm/data11_7TeV/physics_CosmicCalo/00186669/data11_7TeV.00186669.physics_CosmicCalo.merge.HIST.x140_m926/data11_7TeV.00186669.physics_CosmicCalo.merge.HIST.x140_m926._0001.1
    #path1="/castor/cern.ch/grid/atlas/atlasdatadisk/data11_7TeV/HIST/r2558_p635_p635/"
    #path1="/castor/cern.ch/grid/atlas/tzero/prod1/perm/"+projectTag+"/"+stream+"/"+eigthDigits
    #cmd = "nsls %s" % path1


    #/eos/atlas/atlastier0/rucio/data15_cos/express_express/00261453/data15_cos.00261453.express_express.merge.HIST.x316_h17/data15_cos.00261453.express_express.merge.HIST.x316_h17._0001.1
    path1="/eos/atlas/atlastier0/rucio/"+projectTag+"/"+stream+"/"+eigthDigits
    print path1

    if "Main" in stream:
       filenamestart=".".join((projectTag,eigthDigits,stream,"merge","HIST","f"))
    else:
       filenamestart=".".join((projectTag,eigthDigits,stream,"merge","HIST","x"))
    # For HI changed to
    #filenamestart=".".join((projectTag,eigthDigits,stream,"recon","HIST","x"))

    print 'Looking for sub-directory starting with "%s" in castor directory %s' % (filenamestart,path1)
    cmd="%s ls %s" % (eoscmd,path1)
    (stat,out)=commands.getstatusoutput(cmd)
    if (stat != 0):
        print "ERROR: Command \n%s\n failed.\n%s" % (cmd,out)
        return None
    #print out
    #print filenamestart
    nsdirlist=out.split(os.linesep)
    histfiles=[]
    for d in nsdirlist:
        if d.startswith(filenamestart):
            path2=path1+"/"+d
            #cmd = "nsls %s" % path2
            cmd="%s ls %s" % (eoscmd,path2)
            (stat,out)=commands.getstatusoutput(cmd)
            if (stat != 0):
                print "ERROR: Command \n%s\n failed.\n%s" % (cmd,out)
                return None
            nsfilelist=out.split(os.linesep)
            for f in nsfilelist:
                if f.startswith(filenamestart):
                    histfiles.append(path2+"/"+f)
                    pass
                pass
            pass
        pass
    return histfiles

def fillEventVetoForRun(runnumber,withNoise=True,fromMain=False):

    if fromMain:
       mainfiles=getCastorPath(runnumber,"physics_Main")
       if mainfiles is None or len(mainfiles)==0:
          print "ERROR: No files found for Main stream of run",runnumber
          sys.exit(-1)
          pass

       print "Main stream files:"
       for f in mainfiles:
          print "\t",f
    else: 
       cosmiccalofiles=getCastorPath(runnumber,"physics_CosmicCalo")
       if cosmiccalofiles is None or len(cosmiccalofiles)==0:
          print "ERROR: No files found for CosmicCalo stream of run",runnumber
          sys.exit(-1)
          pass
    
       if len(cosmiccalofiles)>1:
          print "WARNING: More than one monitoring root file fould for CosmicCalo stream of run",runnumber
        

       expressexpressfiles=getCastorPath(runnumber,"express_express")
       if expressexpressfiles is None or len(expressexpressfiles)==0:
          print "ERROR: No files found for express_express stream of run",runnumber
          sys.exit(-1)
          pass

       if len(expressexpressfiles)>1:
          print "WARNING: More than one monitoring root file fould for express_express stream of run",runnumber


       print "CosmicCalo stream files:"
       for f in cosmiccalofiles:
          print "\t",f

       print "Express stream files:"
       for f in expressexpressfiles:
          print "\t",f


    #Read MissingFEB info from database:
    from LArBadChannelTool.getMissingFebs import getMissingFebs
    ignoreFebsLB=getMissingFebs(runnumber,"LARBadChannelsOflMissingFEBs-RUN2-UPD4-02")
    #ignoreFebsLB=getMissingFebs(runnumber)
    if ignoreFebsLB is None:
        print "Failed to get list of missing/corrupt febs from MissingFeb database!"
        sys.exit(-1)
    #else:
    #    print "Missing FEBs:",ignoreFebsLB

    ignoreFebs=convertMissingFebList(ignoreFebsLB)
    print "Missing FEBs:",ignoreFebs

    #sys.stdout.flush()
    noisePointsM=dict()
    corruptionPointsM=set()
    if fromMain:
       for f in mainfiles:
          fileResult=readFromROOT(f,readNoise=withNoise, readCorruption=True,ignoreFebs=ignoreFebs)
          if fileResult is None:
             print "ERROR, failed read from",f
             sys.exit(-1)
             pass
          noisePointsM.update(fileResult[0])
          corruptionPointsM|=fileResult[1]
          pass
    else:
       noisePointsCC=dict()
       corruptionPointsCC=set()
       for f in cosmiccalofiles:
          fileResult=readFromROOT(f,readNoise=withNoise, readCorruption=True,ignoreFebs=ignoreFebs)
          if fileResult is None:
            print "ERROR, failed read from",f
            sys.exit(-1)
            pass
          noisePointsCC.update(fileResult[0])
          corruptionPointsCC|=fileResult[1]
          pass

       noisePointsEE=dict()
       corruptionPointsEE=set()
       for f in expressexpressfiles:
          fileResult=readFromROOT(f,readNoise=withNoise, readCorruption=True,ignoreFebs=ignoreFebs)
          if fileResult is None:
            print "ERROR, failed read from",f
            sys.exit(-1)
            pass
          noisePointsEE.update(fileResult[0])
          corruptionPointsEE|=(fileResult[1])
          pass

    #Strategy:
    #1. We search for noise burst in the CosmicCalo stream, with 1 event in 1 second, eg. also isolated events are accepted
    #2. We search for noise burst in the combination of CosmicCalo and Express, asking for at least 2 events in 2 seconds
    #3. We search for data corruption in combination of CosmicCalo and Express
    #Nose: noisePointsXX are python sets. The | operator builds a union of input sets


    # ** TO BE PUT BACK IN AFTER THE TS **
    # print "Filtering Noise bursts from CosmicCalo"
    # noiseRangesCC=buildFilteredRange(noisePointsCC,1,1,noiseWord);
    # print "Found a total of %i veto periods covering %.2f seconds because of noise bursts in the CosmicCalo stream" % (len(noiseRangesCC),sumRanges(noiseRangesCC)) 
    # ** TO BE PUT BACK IN AFTER THE TS **


    if (withNoise):
        print "Searching boise burst events in Express and CosmicCalo stream."
        if fromMain:
           allNoise=noisePointsM
        else:
           allNoise=noisePointsCC;
           allNoise.update(noisePointsEE);
        #noiseRangesEECC=buildFilteredRange(allNoise,2,0.2,noiseWord,1);
        noiseRangesEECC=buildFilteredRange(allNoise,2,0.05,noiseWord,1);
        print "Found a total of %i veto periods covering %.2f seconds because of noise bursts in the Express+CosmicCalo stream" % (len(noiseRangesEECC),sumRanges(noiseRangesEECC))



    #For debugging only: Check Express stream standalone
    #print "Filtering Noise bursts from Express"
    #noiseRangesEE=buildFilteredRange(noisePointsEE,2,2,noiseWord);
    #print "Found a total of %i veto periods covering %.2f seconds because of noise bursts in the Express stream (requesting 2 events in 2 seconds" % (len(noiseRangesEE),sumRanges(noiseRangesEE))
    #del noiseRangesEE

    if fromMain:
       print "Filtering data corruption from Main"
       corruptionRanges=buildFilteredRange(corruptionPointsM,2,0.5,corruptWord)
    else:
       print "Filtering data corruption from Express and CosmicCalo"
       corruptionRanges=buildFilteredRange(corruptionPointsEE | corruptionPointsCC,2,0.5,corruptWord)
    print "Found a total of %i veto periods covering %.2f seconds because of data-corrpution (CosmicCalo+express combined)" % (len(corruptionRanges),sumRanges(corruptionRanges))


    if withNoise:
        return noiseRangesEECC+corruptionRanges
    else:
        return corruptionRanges


if __name__=='__main__':
    import os,sys,getopt

    if len(sys.argv)<2 or sys.argv[1]=="-h" or sys.argv[1]=="--help":
        print "Usage:"

        print "Automated version:"
        print "fillEventVetoFolder.py runnumber {--withNoise} {--fromMain}"
        print "Finds monitoring files for given run on castor and builds sqlite file EventVeto<run>.db"
        print "containing only data corruption (unless run with --withNoise option) from the"
        print "physics_CosmicCalo stream and the express_express stream. The folder-level tag is resolved"
        print "from CURRENT global tag"
    
        print "\nManual version:"
        print "fillEventVetoFolder.py {-t tagSuffix --noNoise --noCorruption } <sqlitefile> <rootfile1> <rootfile2> <textfile1>..."
        print "\nThe trees 'LArNoise' and 'LArCorruption' are read from the monitoring root file(s)"
        print "Paramters:"
        print "tagSuffix : Suffix for the folder-tag in the database"
        print "--noNoise : Do not read LArNoise tree"
        print "--noCorruption : Do not read LArCorruption tree"
        print "--ignoreFebs=<textfile> : List of FEB identifiers to be ignored"
        print "--window : Time-window to mask (in seconds) (root input only)"
        print "--prefill=<run> : Pre-load data-corruption periods <run>. run=0: Get run-number(s) from ROOT input file(s)" 
        print "--minEvents : minium required number of noisy events in a time-window to maks (root-input only)" 
        print "\n Text-files are recognized by their extension '.txt'"
        print "Format:"
        print "iovStart iovStop flag # Comment"
        print "iov-times are in seconds"
        sys.exit(-1)


    from LArConditionsCommon.getCurrentFolderTag import getCurrentFolderTag
    (current,next)=getCurrentFolderTag("COOLOFL_LAR/CONDBR2","/LAR/BadChannelsOfl/EventVeto")
    if current is None:
        print "Failed to get CURRENT folder level tag!"
        sys.exit(-1)
    
    if (len(sys.argv)==2 or len(sys.argv)==3 or len(sys.argv)==4) and sys.argv[1].isdigit():
        #Fully automated case:
        runnumber=int(sys.argv[1])

        withNoise=False
        fromMain=False
        if len(sys.argv)==3:
            if (sys.argv[2]=="--withNoise"):
                print "Will include noise-bursts vetos" 
                withNoise=True
            elif (sys.argv[2]=="--fromMain"):
                print "Will run on Main stream"
                fromMain=True
            else:
                print "Parameter error, 2, don't understand argument",sys.argv[2]
                sys.exit(-1)
            pass
        elif len(sys.argv)==4:
            if (sys.argv[3]=="--withNoise"):
                print "Will include noise-bursts vetos" 
                withNoise=True
            elif (sys.argv[3]=="--fromMain"):
                print "Will run on Main stream"
                fromMain=True
            else:
                print "Parameter error, 3, don't understand argument",sys.argv[3]
                sys.exit(-1)
            pass
        pass
        if fromMain:
           folderTag="LARBadChannelsOflEventVeto-RUN2-Bulk-00"
           sqlitename="EventVeto%i_Main.db" % runnumber
        else:
           folderTag=current
           sqlitename="EventVeto%i.db" % runnumber
        if os.access(sqlitename,os.F_OK):
            print "ERROR: File",sqlitename,"exists already. Please delete!"
            sys.exit(-1)

        print "Using folder-level tag:",folderTag

        data=fillEventVetoForRun(runnumber,withNoise,fromMain)
    else:
        #Manual case:
        folderTag=current
        withNoise=True
        readCorruption=True
        ignorefebfile=None
        minEvents=2
        window=0.05 # new default
        minStd=1
        prefillCorrupt=set()

        #interprting arguments:
        try:
            opts,args=getopt.getopt(sys.argv[1:],"t:",["noNoise","noCorruption","prefill=","tag=","ignoreFebs=","window=","minEvents=","minStd="])
        except getopt.GetoptError,e:
            print "Failed to interpret arguments"
            print e
            sys.exit(-1)
            pass
        
        for o,a in opts:
            if (o=="-t" or o=="--tag"):
                if a.startswith('-'):a=a[1:]
                folderTag="LARBadChannelsOflEventVeto-"+a
            if o=="--noNoise": withNoise=False
            if o=="--noCorruption": readCorruption=False
            if o=="--ignoreFebs": ignorefebfile=a
            if o=="--minEvents": minEvents=int(a)
            if o=="--window": window=float(a)
            if o=="--minStd": minStd=int(a)
            if o=="--prefill":prefillCorrupt.add(int(a))
            pass
        for a in args:
            if a.startswith("-"):
                print "ERROR: Unhandled argument",a
                sys.exit(-1)
                pass
            
        if len(args)<2:
            print "ERROR: Not enough arguments"
            sys.exit(-1)

        sqlitename=args[0]
        if (os.access(sqlitename,os.F_OK) and not os.access(sqlitename,os.W_OK)):
            print "ERROR: No write access to database file",sqlitename
            sys.exit(-1)
            pass


        infiles=[]
        for flist in args[1:]:
            for f in flist.split(","):
                if not (f.startswith("/castor/") or f.startswith("/eos/") or os.access(f,os.R_OK)):
                    print "ERROR no read access to input file",f
                    sys.exit(-1)
                    pass
                infiles.append(f)
                pass
            pass
        
        ignoreFebsLB=set()
        if ignorefebfile is not None:
            if os.access(ignorefebfile,os.R_OK):
                inFile=open(ignorefebfile)
                for line in inFile:
                    try:
                        l1=line.split("#")[0]
                        for nbr in l1.split():
                            ignoreFebsLB.add(int(nbr))
                    except Exception,e:
                        print "Failed to interpret line"
                        print line
                        print e
                        sys.exit(-1)
                        pass
                    pass
                pass
            else:
                if ignorefebfile.isdigit():
                    #Read MissingFEB info from database:
                    from LArBadChannelTool.getMissingFebs import getMissingFebs
                    ignoreFebsLB=getMissingFebs(int(ignorefebfile))
                    if ignoreFebsLB is None:
                        print "Failed to get list of missing/corrupt febs from MissingFeb database!"
                        sys.exit(-1)
                else:
                    print "Can't access missing FEBs from file", ignorefebfile
                    pass
        ignoreFebs=convertMissingFebList(ignoreFebsLB)
        print "Input: ", ", ".join(infiles)
        print "Output:", sqlitename
        print "Tag   :", folderTag
        print "Febs to be igored:"
        for iov in ignoreFebsLB:
            print "\t",
            for f in iov[2]:
                print "0x%x," % f,
            print ""

        if not withNoise: print "LArNoise tree is ignored"
        if not readCorruption: print "LArCorruption tree is ignored"

        if 0 in prefillCorrupt:
            prefillFromRun=True
        else:
            prefillFromRun=False

            
        data=[]
        textdata=[]
        noisePoints=dict()
        corruptionPoints=set()
        for f in infiles:
            if f.endswith(".txt"):
                d=readFromText(f)
                if d is None:
                    print "ERROR, failed read from text file",f
                    sys.exit(-1)
                    pass
                data+=d
            else: # assume root file
                fileresult=readFromROOT(f,withNoise,readCorruption,ignoreFebs)
                if fileresult is None:
                    print "ERROR, failed read from",f
                    sys.exit(-1)
                    pass
                noisePoints.update(fileresult[0])
                corruptionPoints|=fileresult[1]
                if prefillFromRun:
                    prefillCorrupt.update(set(fileresult[2]))
            pass # End loop over infiles

        if len(noisePoints)>0:
            print "Working on Noise Bursts"
            data+=buildFilteredRange(noisePoints,minEvents,window,noiseWord,minStd)

        if len(corruptionPoints)>0:
            print "Working on data corruption"
            data+=buildFilteredRange(corruptionPoints,minEvents,window,corruptWord)


        if len(prefillCorrupt)>0:
            from extractCorruption import extractCorruption
            extractor=extractCorruption("COOLOFL_LAR/CONDBR2",current)
            rltots=RunLumiToTimeStamp()
            for runToExtract in prefillCorrupt:
                if (runToExtract==0): continue
                t1,t2=rltots.getRunStartStop(runToExtract)
                previousCorrupted=extractor.extract(t1,t2,current)
                print "Run %i: Extracted %i data-corruption period(s) from current Event Veto tag %s " % (runToExtract,len(previousCorrupted),current)
                data+=previousCorrupted
                pass
            pass
        pass
    #end manual case
    
    if len(data)>0:
        print "Found %i noise-burst and data-corruptions in input file(s)" % len(data)
        connect="sqlite://;schema="+sqlitename+";dbname=CONDBR2"
        dbSvc = cool.DatabaseSvcFactory.databaseService()
        try:
            db = dbSvc.openDatabase(connect,False)
        except Exception:
            print "Database does not exist, try to create it ..."
            try:
                db=dbSvc.createDatabase(connect)
            except Exception,e:
                print e
                print "Could not create database"
                sys.exit(-1)
                pass
            pass
        fillEventVetoFolder(db,folderTag,data)
        print "/afs/cern.ch/user/a/atlcond/utils/AtlCoolMerge.py "+sqlitename+" CONDBR2 ATLAS_COOLWRITE ATLAS_COOLOFL_LAR_W <password>"
            
    else: 
        if (withNoise):
            print "Did not find any data-corruption. No update needed."
        else:
            print "Did not find any noise-burst nor data-corruption. No update needed."
    sys.exit(0)
