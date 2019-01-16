#!/bin/env python

import sys
import cppyy
sys.modules['PyCintex'] = PyCintex = cppyy

from PyCool import cool
from time import asctime,gmtime
from ROOT import TTree,TFile

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

def convertMissingFebList(inputList):
    mintime=0L
    maxtime=9223372036854775807
    
    if len(inputList)==1:
        print "Single Missing FEB IOV",mintime,maxtime,inputList[0][2]
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
        outputList.append((ts1,ts2,pl))
        #print "Missing FEB IOV",ts1,ts2,pl
    return outputList


def getMissingFEBsForTime(t,missingFebsAllIOV):
    for (t1,t2,pl) in missingFebsAllIOV:
        if (t>t1 and t<t2): return pl

    return set()


def getMissingFebsForRun(runnumber,ofile=""):

    #Read MissingFEB info from database:
    from LArBadChannelTool.getMissingFebs import getMissingFebs
    from LArConditionsCommon.getCurrentFolderTag import getCurrentFolderTag
    (current,next)=getCurrentFolderTag("COOLOFL_LAR/CONDBR2","/LAR/BadChannelsOfl/MissingFEBs") 
    ignoreFebsLB=getMissingFebs(runnumber,current)
    if ignoreFebsLB is None:
        print "Failed to get list of missing/corrupt febs from MissingFeb database!"
        sys.exit(-1)

    print "ignoreFebsLB :",ignoreFebsLB
    ignoreFebs=convertMissingFebList(ignoreFebsLB)
    print "Missing FEBs:",ignoreFebs

    if ofile != "":
       f = open(ofile, 'w')
       for (ts,te,mf) in ignoreFebs:
          f.write(str(ts)+'\t'+str(te))
          for febid in mf:
              f.write('\t'+str(febid))
          if len(mf)== 0: f.write('\t 0')
          f.write('\n')
       f.close()

if __name__=='__main__':
    import os,sys,getopt

    if len(sys.argv)<2 or sys.argv[1]=="-h" or sys.argv[1]=="--help":
        print "Usage:"

        print "Automated version:"
        print "getMissingFebsForRun.py runnumber "
        print "Finds MissingFebs list for this run"
        sys.exit(-1)


    from LArConditionsCommon.getCurrentFolderTag import getCurrentFolderTag
    (current,next)=getCurrentFolderTag("COOLOFL_LAR/CONDBR2","/LAR/BadChannelsOfl/EventVeto")
    if current is None:
        print "Failed to get CURRENT folder level tag!"
        sys.exit(-1)
    
    if (len(sys.argv)>=2 ) and sys.argv[1].isdigit():
        runnumber=int(sys.argv[1])
    else:
        print "Wrong parameter"
        sys.exit(-1)

    if (len(sys.argv)>=3 ):
        ofile=sys.argv[2]
    else:
        ofile=""
    getMissingFebsForRun(runnumber,ofile)    
    sys.exit(0)
