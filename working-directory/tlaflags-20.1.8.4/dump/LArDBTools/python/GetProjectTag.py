#!/bin/env python

import sys

def GetSFO_LBNEvents( cursor, runno, streamname ):
    """returns nfiles, fsize, nevents"""
    stype, sep, sname = streamname.partition('_')
    cursor.execute( "SELECT SUM(NREVENTS),LUMIBLOCKNR FROM SFO_TZ_File WHERE RUNNR=:arg_1 and STREAMTYPE=:arg_2 and STREAM=:arg_3 GROUP BY LUMIBLOCKNR ORDER BY LUMIBLOCKNR",
                    arg_1=runno, arg_2=stype, arg_3=sname )
    #cursor.execute( "SELECT SUM(NREVENTS),LUMIBLOCKNR FROM SFO_TZ_File WHERE RUNNR=:arg_1 and STREAMTYPE=:arg_2 and STREAM=:arg_3",
     #               arg_1=runno, arg_2=stype, arg_3=sname )
                    
    return cursor.fetchall()

def GetSFO_LBs( cursor, runno ):
    cursor.execute( "SELECT MIN(LUMIBLOCKNR), MAX(LUMIBLOCKNR) FROM SFO_TZ_Lumiblock WHERE RUNNR=:arg_1", arg_1=runno )
    return cursor.fetchone()[0:2]

def OpenSFOConnection():
    import cx_Oracle
    return cx_Oracle.connect("ATLAS_SFO_T0_R/readmesfotz2008@atlr")


def GetProjectTag(runno):
    projectTag=None
    import cx_Oracle
    connection   =  cx_Oracle.connect("ATLAS_SFO_T0_R/readmesfotz2008@atlr")
    cursor = connection.cursor()
    
    cursor.execute( "SELECT PROJECT FROM SFO_TZ_RUN WHERE RUNNR=:arg_1", arg_1=runno )
    result=cursor.fetchone()
    #print result
    if len(result)>0:
        project=result[0]
    cursor.close()
    connection.close()
    return project

if __name__ == '__main__':
    if len(sys.argv)==2 and sys.argv[1]!="-h" and  sys.argv[1]!="--help":
        if sys.argv[1].isdigit():
            runno=int(sys.argv[1])
        else:
            print "ERROR, expected run-number, got",sys.argv[1]
            sys.exit(-1)

        print GetProjectTag(runno)
               

    else:
        print "Usage:"
        print sys.argv[0]," <runnumber> " 
        
    
