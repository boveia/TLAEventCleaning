#!/bin/env python

from PyCool import cool
from CoolConvUtilities.AtlCoolLib import indirectOpen

def getReadyForPhysics(runnumber):

    tdaqDB=indirectOpen('COOLONL_TDAQ/CONDBR2',oracle=True)
    if (tdaqDB is None):
        print "ERROR: Cannot connect to COOLONL_TDAQ/CONDBR2"
        return None
    retval=0
    try:
        tdaqfolder=tdaqDB.getFolder('/TDAQ/RunCtrl/DataTakingMode')
        runiov=runnumber << 32
        itr=tdaqfolder.browseObjects(cool.ValidityKey(runnumber << 32),cool.ValidityKey((1+runnumber)<<32),cool.ChannelSelection(0))
        while itr.goToNext():
           obj=itr.currentRef()
           #obj=tdaqfolder.findObject(runiov,0)
           payload=obj.payload()
           rfp=payload['ReadyForPhysics']
           if rfp == 1: retval=1
    except Exception,e:
        print "ERROR accessing /TDAQ/RunCtrl/SOR"
        print e
    tdaqDB.closeDatabase()
    print retval
    
if __name__=='__main__':
    import sys
    if len(sys.argv)!=2:
        print "Syntax",sys.argv[0],'<run>'
        sys.exit(-1)
    run=int(sys.argv[1])
    getReadyForPhysics(run)
    
