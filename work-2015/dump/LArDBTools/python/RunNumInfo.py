#!/bin/env python
# RunNumInfo.py
# Nils Gollub <nils.gollub@cern.ch>, 2008-05-29
"""
Python module providing information about run numbers
"""

from ROOT import TSQLServer

#______________________________________________________________________________
def getNextAtlasRunNumber():
    """
    Returns the next free ATLAS run number
    """

    runNum    = -1
    server    = "oracle://localhost/atlr"
    statement = "select MAX(RUNNUMBER) FROM atlas_run_number.RUNNUMBER"
    db = TSQLServer.Connect(server,"atlas_run_number_r","07-Run.Num.rEaDeR")
    if not db or not db.IsConnected():
        raise(Exception("Problem connecting to run number server \"%s\"" % server))
    stmt = db.Statement(statement)
    if stmt.Process():
        stmt.StoreResult()
        stmt.NextResultRow()
        runNum = (stmt.GetUInt(0)+1)
    else:
        raise(Exception("Error in processing statement \"%s\"" % statement ))
    db.Close()
    return runNum


#______________________________________________________________________________
if __name__=="__main__":
    print "Next ATLAS run number will be: ", getNextAtlasRunNumber()
