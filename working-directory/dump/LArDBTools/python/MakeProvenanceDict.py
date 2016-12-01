#!/bin/env python

import sys,os,stat,cPickle,shelve
from PyCool import cool


class ProvenanceItem:
    def __init__(self,foldersAndChannels,date,version):
        self.foldersAndChannels=foldersAndChannels
        self.date=date
        self.version=version
    

class ProvenanceDict:
    def __init__(self,filename,write=False):
        self._filename=filename
        self._write=write
        if write:
            flag='c'
        else:
            flag='r'
        self._provFile=shelve.open(filename,flag,writeback=write)
        self._dbSvc= cool.DatabaseSvcFactory.databaseService()

    def __del__(self):
        if (self._write):
            self._provFile.sync()
        del self._provFile

    def addSqlites(self,provenance,sqlitefiles,dbname="COMP200",checkDuplicate=True):
        if not self._write:
            print "ERROR: Cant add data if file isn't open for writing"
            sys.exit(-1)

        foldersAndChans=dict()
        try:
            version=provenance.split("_")[6]
        except:
            print "ERROR provenance string",provenance,"malformed"
            version="unknown" 

        for sf in sqlitefiles:
            if not os.access(sf,os.R_OK):
                print "ERROR: Can't access sqlite file",sf
                sys.exit(-1)
            procDate=os.stat(sf)[stat.ST_MTIME]
            
            dbspec="sqlite://;schema="+sf+";dbname="+dbname
            #print dbspec
            try:
                db = self._dbSvc.openDatabase(dbspec)
            except Exception, e:
                print e
                print "could not connect to the database"
                sys.exit(-1)
            nodelist=db.listAllNodes()
            for node in nodelist:
                if db.existsFolder(node):
                    f=db.getFolder(node)
                    chans=f.listChannels()
                    if foldersAndChans.has_key(node):
                        foldersAndChans[node]|=set(chans)
                    else:
                        foldersAndChans[node]=set(chans)
            db.closeDatabase()


            if checkDuplicate:
                print "Checking for duplicates for",sf
                for (p,fc) in self._provFile.iteritems():
                    if p==provenance: continue
                    for (f,c) in fc.foldersAndChannels.iteritems():
                        if foldersAndChans.has_key(f):
                            overlap=c & foldersAndChans[f]
                            if len(overlap)>0:
                                print "WARNING: Same object in several files, ambigous provenance!"
                                print "Folder",f
                                print "Channels ",overlap
                                print "appear in"
                                print p
                                print provenance
                            #else:
                            #    print "No overlap found between",p,"and",provenance
            
        
            if not self._provFile.has_key(provenance):
                self._provFile[provenance]=ProvenanceItem(foldersAndChans,procDate,version)
            else:
                provItem=self._provFile[provenance]
                for (f,c) in foldersAndChans.iteritems():
                    if provItem.foldersAndChannels.has_key(f):
                        provItem.foldersAndChannels[f] |= c
                    else:
                        provItem.foldersAndChannels[f] = c
                if procDate<provItem.date:
                    provItem.date=procDate

                if version != provItem.version:
                    print "WARNING: Version mismatch:",version,"vs",provItem.version
                    
                self._provFile[provenance]=provItem
            

    def getProvenance(self,folder,chanSet):
        provenance=tuple()
        #print "Checking provenance for folder",folder,"Channels",chanSet
        for (p,provRecord) in self._provFile.iteritems():
            if provRecord.foldersAndChannels.has_key(folder):
                overlap=provRecord.foldersAndChannels[folder] & chanSet
                if len(overlap):
                    provenance+=((p,provRecord.date,provRecord.version),)
                #    print "Overlap:",overlap
                #    print "For",p

        return provenance

    def dump(self):
        for (p,fc) in self._provFile.iteritems():
            print "\nProvenance:",p
            print "Version:",fc.version
            print "Date:",fc.date
            for (f,cns) in fc.foldersAndChannels.iteritems():
                print "   ",f,
                for c in cns:
                    print c,
                print "\n",
                


if __name__=='__main__':
    def usage():
        print "Usage: " 
        print sys.argv[0],"<bookkeeping-file> <provenance1> <sqlitefile1> <provenance2> <sqlitefile2> .."
        print "Adds folder and channels per provenance to book-keeping file"

    if len(sys.argv)==2:
        d=ProvenanceDict(sys.argv[1],False)
        d.dump()
    elif len(sys.argv)<4:
        usage()
    else:
        bkfile=sys.argv[1]
        i=2
        provSql=[]
        while i+1<len(sys.argv):
            provSql+=((sys.argv[i],sys.argv[i+1]),)
            i=i+2
        d=ProvenanceDict(bkfile,True)
        for (provenance,sqfile) in provSql:
            d.addSqlites(provenance,(sqfile,),checkDuplicate=False)

    sys.exit(0)
    
