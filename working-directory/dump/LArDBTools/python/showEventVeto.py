#!/bin/env python

from PyCool import cool
from time import asctime,gmtime,localtime
#from fillEventVetoFolder import RunLumiToTimeStamp

def ts2string(ts):
    if ts==0:
        return "0"
    if ts==cool.ValidityKeyMax:
        return "INF"
    stime=int(ts/1000000000L)
    return asctime(gmtime(stime))+" UTC"


class LumiGetter:
    def __init__(self):
       dbSvc = cool.DatabaseSvcFactory.databaseService()
       self._db=dbSvc.openDatabase("COOLONL_TDAQ/CONDBR2")
       self._folder=self._db.getFolder("/TDAQ/OLC/LUMINOSITY")

    def getLumi(self,since, until):
        itr=self._folder.browseObjects(cool.ValidityKey(since),cool.ValidityKey(until),cool.ChannelSelection(0));
        lumi=0
        while itr.goToNext():
            obj=itr.currentRef()
            payload=obj.payload()
            instLumi=payload["LBAvInstLumPhys"]
            valid=payload["Valid"]
            if (valid & 0x3 == 0):
                s=max(since,obj.since())
                u=min(until,obj.until())
                len=(u-s)/1e9
                #print "%i - %i (%i): %.2f" % (int(s/1e9),int(u/1e9),len,instLumi)
                lumi+=len*instLumi
        itr.close()
        return lumi
        




class TimeStampToRunLumi:
    def __init__(self):
        dbSvc = cool.DatabaseSvcFactory.databaseService()
        self._db=dbSvc.openDatabase("COOLONL_TRIGGER/CONDBR2")
        self._folder=self._db.getFolder("/TRIGGER/LUMI/LBTIME")
        pass
    
    def __del__(self):
        self._db.closeDatabase()

    def getRunLumi(self,since,until):
        retval=dict()
        itr=self._folder.browseObjects(cool.ValidityKey(since),cool.ValidityKey(until),cool.ChannelSelection(0))        
        while itr.goToNext():
            obj=itr.currentRef()
            payload=obj.payload()
            pl=obj.payload()
            run=pl["Run"]
            lb=pl["LumiBlock"]
            if not retval.has_key(run):
                retval[run]=set()
            retval[run].add(lb)
        itr.close()
        return retval

    def getRunLumi(self,pointInTime):
            obj=self._folder.findObject(cool.ValidityKey(pointInTime),0)
            pl=obj.payload()
            run=pl["Run"]
            lb=pl["LumiBlock"]
            return run,lb

def showEventVetoFolder(dbname,folderName,tag,run1,run2,levelOfDetail=3):
    retval=dict() 
    
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    try:
        db = dbSvc.openDatabase(dbname)
    except Exception:
        print "Database does not exist."
        return

    if not db.existsFolder(folderName):
        print "Folder",folderName,"not found."
        return


    if levelOfDetail>0: print "Reading folder",folderName,"from DB",dbname
    folder=db.getFolder(folderName)
    if not folder.existsUserTag(tag):
        print "Tag",tag,"does not exist in foder",folder
        return

    totalVeto=[0,0,0]
    nPeriods=[0,0,0]
    lostLumi=[0.,0.,0.]

    allNoise=[]
    allMNB=[]
    allCorruption=[]

    corrMask =0xFFF00000
    noiseMask=0x00008FFF 
    MNBMask = 0x10FFF

    totalLumi=None
    lg=LumiGetter()

    if run1 is not None:
        from fillEventVetoFolder import RunLumiToTimeStamp
        Rltots=RunLumiToTimeStamp()
        t1,t2=Rltots.getRunStartStop(run1)
        if t1 is None or t2 is None:
            print "Can't get start/stop time of run",run1
            return
        
        if run2 is not None:
           x,t2=Rltots.getRunStartStop(run2)  
           if t2 is None:
               print "Can't get start/stop time of run",run2
               return
           if levelOfDetail>0: print "Dumping EventVeto data from run %i to run %i  lasting from %s to %s" % (run1, run2, ts2string(t1),ts2string(t2))
        else:
            if levelOfDetail>0: print "Dumping EventVeto data for run %i, lasting from %s to %s" % (run1, ts2string(t1),ts2string(t2))

        totalLumi=lg.getLumi(t1,t2)
        retval['totalLumi']=totalLumi
            
    else:
        t1=cool.ValidityKeyMin
        t2=cool.ValidityKeyMax

    if levelOfDetail>2:
        tsToRl=TimeStampToRunLumi()
    

    
    itr=folder.browseObjects(t1,t2,cool.ChannelSelection(0),tag)
    while itr.goToNext():
        obj=itr.currentRef()
        payload=obj.payload()
        flag=payload["EventVeto"]
        if flag==0: continue
        tf=obj.since()
        ts=obj.until()
        types=[]
        if flag & noiseMask:
            types+=["NoiseBurst",]
            totalVeto[0]+=(ts-tf)
            nPeriods[0]+=1
            lostLumi[0]+=lg.getLumi(tf,ts)
            allNoise.append((tf,ts))
        if flag & MNBMask:
            types+=["MiniNoiseBurst",]
            totalVeto[1]+=(ts-tf)
            nPeriods[1]+=1
            lostLumi[1]+=lg.getLumi(tf,ts)
            allMNB.append((tf,ts))
        if flag & corrMask:
            types+=["DataCorruption",]
            totalVeto[2]+=(ts-tf)
            nPeriods[2]+=1
            lostLumi[2]+=lg.getLumi(tf,ts)
            allCorruption.append((tf,ts))
        if len(types)==0:
            types=("UnkonwnFlag",)
        if levelOfDetail>1:
            print "Event Veto %s, %s-%s (%.3f ) " % (str(types),ts2string(tf),ts2string(ts),(ts-tf)/1e9 ),
            if levelOfDetail>2:
                rl1=tsToRl.getRunLumi(tf)
                rl2=tsToRl.getRunLumi(ts)
                if rl1==rl2:
                    print "Run %i, LB %i" % (rl1[0],rl1[1]),
                else:
                    print "Run %i, LBs %i-%i" % (rl1[0],rl1[1],rl2[1]),
                print "(%f,%f)" % (ts,tf)
                pass
            else:
                print ""
    itr.close()
    try:
       if db.isOpen():
          db.closeDatabase()
    except Exception:
       print "Closing database exception, not a problem...."
    if levelOfDetail>0:
       if nPeriods[0] > 0:
         print "Found a total of %i noisy periods, covering a total of %.2f seconds" % (nPeriods[0],totalVeto[0]/1e9)
       if nPeriods[1] > 0:
         print "Found a total of %i Mini noise periods, covering a total of %.2f seconds" % (nPeriods[1],totalVeto[1]/1e9)
       if nPeriods[2] > 0:
         print "Found a total of %i corruption periods, covering a total of %.2f seconds" % (nPeriods[2],totalVeto[2]/1e9)
       if totalLumi is not None and totalLumi>0:
            if (nPeriods[0]>0): 
               print "Lumi loss due to noise-bursts: %.2f nb-1 out of %.2f nb-1 (%.2f per-mil)" %(lostLumi[0]/1e3,totalLumi/1e3,1000.*lostLumi[0]/totalLumi)
            if (nPeriods[1]>0): 
               print "Lumi loss due to mini-noise-bursts: %.2f nb-1 out of %.2f nb-1 (%.2f per-mil)" %(lostLumi[1]/1e3,totalLumi/1e3,1000.*lostLumi[1]/totalLumi)
            if (nPeriods[2]>0): 
               print "Lumi loss due to corruption: %.2f nb-1 out of %.2f nb-1 (%.2f per-mil)" %(lostLumi[2]/1e3,totalLumi/1e3,1000.*lostLumi[2]/totalLumi)
       else:
            if (nPeriods[0]>0): 
                print "Lumi loss due to noise-bursts: %.2f nb-1" % (lostLumi[0]/1e3)
            if (nPeriods[1]>0): 
                print "Lumi loss due to mini-noise-burts: %.2f nb-1" % (lostLumi[1]/1e3)
            if (nPeriods[2]>0): 
                print "Lumi loss due to corruption: %.2f nb-1" % (lostLumi[2]/1e3)
        
        #print "Overlaps are counted as noise"

        
    retval['noiseBurst']=(nPeriods[0],totalVeto[0],lostLumi[0])
    retval['miniNoiseBurst']=(nPeriods[1],totalVeto[1],lostLumi[1])
    retval['corruption']=(nPeriods[2],totalVeto[2],lostLumi[2])
    retval['allCorruption']=allCorruption
    retval['allNoise']=allNoise
    retval['MNBNoise']=allMNB

        
    return retval


if __name__=="__main__":
    import sys,getopt

    db="oracle://ATLAS_COOLPROD;schema=ATLAS_COOLOFL_LAR;dbname=CONDBR2"
    run1=None
    run2=None
    tag="LARBadChannelsOflEventVeto-RUN2-UPD1-00"
    folderName="/LAR/BadChannelsOfl/EventVeto"
    levelOfDetail=3
    try:
        opts,args=getopt.getopt(sys.argv[1:],"d:s:r:e:t:l:f:h",[])
    except getopt.GetoptError,e:
        print "Failed to interpret arguments"
        print e
        sys.exit(-1)
        pass

    dbSet=0

    for (o,a) in opts:
        if o=="-h":
            print "Parameters:"
            print "-r <runnumber> (Default: Show for all runs)"
            print "-e <runnumber> Dump event veto from runs r to e"
            print "-t <tag> (Default: %s)" % tag
            print "-s <sqlitefile> (Default: use Oracle)" 
            print "-d <database connection string>"
            print "-l <levelOfDetail> (0, 1 or 2)"
            print "-f <folder>"  
            sys.exit(0)

        if o=="-t": tag=a
        if o=="-r": run1=int(a)
        if o=="-e": run2=int(a)
        if o=="-s": 
            dbSet+=1
            db="sqlite://;schema="+a+";dbname=CONDBR2"
        if o=="-d": 
            dbSet+=1
            db=a
        if o=="-l": levelOfDetail=int(a)
        if o=="-f": folderName=a

        pass

    if dbSet>1:
        print "ERROR, inconsistent parameters! -d and -s are mutually exclusive"
        sys.exe(-1)

    #print run1,run2


    if tag is None:
        from LArConditionsCommon.getCurrentFolderTag import getCurrentFolderTag
        (current,next)=getCurrentFolderTag("COOLOFL_LAR/CONDBR2","/LAR/BadChannelsOfl/EventVeto")
        if current is None:
            print "Failed to get CURRENT folder level tag!"
            sys.exit(-1)
        else:
            tag=current

    print "Reading event veto info from db %s, tag %s" % (db,tag),
    if run1 is not None:
        if run2 is not None:
            print " Run",run1,"to",run2
        else:
            print " Run",run1
    else:
        print ""
    
        
    showEventVetoFolder(db,folderName,tag,run1,run2,levelOfDetail)
    
    #showEventVetoFolder("COOLOFL_LAR/CONDBR2","LARBadChannelsOflEventVeto-UPD4-01",188951)
