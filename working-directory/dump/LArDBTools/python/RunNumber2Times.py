#!/bin/env python

from PyCool import cool
from CoolConvUtilities.AtlCoolLib import indirectOpen

def RunNumber2Times(runnumber, outs=False):

    tdaqDB=indirectOpen('COOLONL_TDAQ/CONDBR2',oracle=True)
    if (tdaqDB is None):
        print "ERROR: Cannot connect to COOLONL_TDAQ/CONDBR2"
        return None
    sortime=0
    eortime=0
    try:
        tdaqfolder=tdaqDB.getFolder('/TDAQ/RunCtrl/SOR')
        runiov=run << 32
        obj=tdaqfolder.findObject(runiov,0)
        payload=obj.payload()
        sortime=payload['SORTime']
    except Exception,e:
        print "ERROR accessing /TDAQ/RunCtrl/SOR"
        print e
    try:
        tdaqfolder=tdaqDB.getFolder('/TDAQ/RunCtrl/EOR')
        runiov=run << 32
        obj=tdaqfolder.findObject(runiov,0)
        payload=obj.payload()
        eortime=payload['EORTime']
    except Exception,e:
        print "ERROR accessing /TDAQ/RunCtrl/EOR"
        print e
    tdaqDB.closeDatabase()
    if outs:
       import time
       print time.strftime("%Y-%m-%d:%H:%M:%S",time.gmtime(sortime/1000000000)),' ',time.strftime("%Y-%m-%d:%H:%M:%S",time.gmtime(eortime/1000000000))
    else:
       print sortime,' ',eortime
    
if __name__=='__main__':
    import sys
    if len(sys.argv)!=2 and len(sys.argv)!=3:
        print "Syntax",sys.argv[0],' [-s] <run>'
        sys.exit(-1)
    outs=False
    if len(sys.argv)==2:
      run=int(sys.argv[1])
    else:
      run=int(sys.argv[2])
      outs=True

    RunNumber2Times(run,outs)
    
