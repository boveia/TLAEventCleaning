#!/bin/env python
# MagFieldUtils.py
# Routines to read magnetic field information from COOL
# Richard Hawkings 25/9/08

from PyCool import cool
from CoolConvUtilities.AtlCoolLib import indirectOpen

class MagFieldDCSInfo:
    "Wrapper class to hold magnetic field current info from DCS data"
    def __init__(self,solC,solSetC,torC,torSetC):
        "Initialise given values for solenoid & toroid acual and set currents"
        self._solC=solC
        self._solSetC=solSetC
        self._torC=torC
        self._torSetC=torSetC

    def solenoidCurrent(self):
        "Return the solenoid current"
        return self._solC

    def solenoidSetCurrent(self):
        "Return the requested solenoid current (set point)"
        return self._solSetC

    def toroidCurrent(self):
        "Return the toroid current"
        return self._torC

    def toroidSetCurrent(self):
        "Return the requested toroid current (set point)"
        return self._torSetC

def getFieldForRun(run,readOracle=True):
    "Get the magnetic field currents (MagFieldDCSInfo) for a given run"
    # access the TDAQ schema to translate run number into timestamp
    tdaqDB=indirectOpen('COOLONL_TDAQ/CONDBR2',oracle=readOracle)
    if (tdaqDB is None):
        print "MagFieldUtils.getFieldForRun ERROR: Cannot connect to COOLONL_TDAQ/CONDBR2"
        return None
    sortime=0
    try:
        tdaqfolder=tdaqDB.getFolder('/TDAQ/RunCtrl/SOR')
        runiov=run << 32
        obj=tdaqfolder.findObject(runiov,0)
        payload=obj.payload()
        sortime=payload['SORTime']
    except Exception,e:
        print "MagFieldUtils.getFieldForRun ERROR accessing /TDAQ/RunCtrl/SOR"
        print e
    tdaqDB.closeDatabase()
    # if we do not have a valid time, exit
    if (sortime==0): 
        print "MagFieldUtils.getFieldForRun, could not find time for run ",run
        return None
    
    print "MagFieldUtils.getFieldForRun got time ",sortime
    # now having got the start of run timestamp, lookup the field info in DCS
    dcsDB=indirectOpen('COOLOFL_DCS/CONDBR2',oracle=readOracle)
    if (dcsDB is None):
        print "MagFieldUtils.getFieldForRun ERROR: Cannot connect to COOLOFL_DCS/CONDBR2"
        return None
    data=None
    try:
        dcsfolder=dcsDB.getFolder('/EXT/DCS/MAGNETS/SENSORDATA')
        objs=dcsfolder.findObjects(sortime,cool.ChannelSelection.all())
        data=[-1.,-1.,-1.,-1.]
        for obj in objs:
            chan=obj.channelId()
            if (chan>0 and chan<5):
                data[chan-1]=obj.payload()['value']
    except Exception,e:
        print "MagFieldUtils.getFieldForRun ERROR accessing /EXT/DCS/MAGNETS/SENSORDATA"
        print e
    dcsDB.closeDatabase()
    # if problem accessing folder, exit
    if data is None:
        return None
    # return a MagFIeldDCSInfo object containing the result
    return MagFieldDCSInfo(data[0],data[1],data[2],data[3])

# command line driver for convenience
if __name__=='__main__':
    import sys
    if len(sys.argv)!=2:
        print "Syntax",sys.argv[0],'<run>'
        sys.exit(-1)
    run=int(sys.argv[1])
    magfield=getFieldForRun(run)
    print "Magnetic field information for run %i" % run
    if (magfield is not None):
        print "Solenoid current %8.2f (requested %8.2f)" % (magfield.solenoidCurrent(),magfield.solenoidSetCurrent())
        print "Toroid   current %8.2f (requested %8.2f)" % (magfield.toroidCurrent(),magfield.toroidSetCurrent())
    else:
        print "Not available"
