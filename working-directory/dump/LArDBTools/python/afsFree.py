#!/bin/env python
import sys,commands

def getFreeAfsSpace(path=""):
    quotatxt="Current disk quota is "
    usedtxt="Current blocks used are "
    (stat,out)=commands.getstatusoutput("fs examine "+path)
    if stat!=0:
        print "fs examine returned an error"
        print out
        return -1

    pos1=out.find(quotatxt)
    if pos1<0:
        print "Can't interpret output"
        print  out
        return -1
    pos1+=len(quotatxt)
    pos2=out.find("\n",pos1)
    if pos2<0:
        print "Can't interpret output"
        print  out
        return -1
    
    quota=int(out[pos1:pos2])


    pos1=out.find(usedtxt)
    if pos1<0:
        print "Can't interpret output"
        print  out
        return -1
    
    pos1+=len(usedtxt)    
    pos2=out.find("\n",pos1)
    if pos2<0:
        print "Can't interpret output"
        print  out
        return -1

    used=int(out[pos1:pos2])
    return quota-used
    #print "Quota =",quota/1000,"MB, used=",used/1000,"MB, free=",(quota-used)/1000,"MB"
    

if __name__=='__main__':

    if len(sys.argv)>1:
        path=sys.argv[1]
    else:
        path=""
    print getFreeAfsSpace(path)
    
