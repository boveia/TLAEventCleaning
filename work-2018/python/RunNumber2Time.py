#!/bin/env python
# MagFieldUtils.py
# Routines to read magnetic field information from COOL
# Richard Hawkings 25/9/08

from PyCool import cool
from CoolConvUtilities.AtlCoolLib import indirectOpen

def RunNumber2Time(runnumber):

    tdaqDB=indirectOpen('COOLONL_TDAQ/CONDBR2',oracle=True)
    if (tdaqDB is None):
        print "ERROR: Cannot connect to COOLONL_TDAQ/CONDBR2"
        return None
    sortime=0
    try:
        tdaqfolder=tdaqDB.getFolder('/TDAQ/RunCtrl/SOR')
        runiov=run << 32
        obj=tdaqfolder.findObject(runiov,0)
        payload=obj.payload()
        sortime=payload['SORTime']
    except Exception,e:
        print "ERROR accessing /TDAQ/RunCtrl/SOR"
        print e
    tdaqDB.closeDatabase()
    # if we do not have a valid time, exit
    print sortime
    
if __name__=='__main__':
    import sys
    if len(sys.argv)!=2:
        print "Syntax",sys.argv[0],'<run>'
        sys.exit(-1)
    run=int(sys.argv[1])
    RunNumber2Time(run)
    
