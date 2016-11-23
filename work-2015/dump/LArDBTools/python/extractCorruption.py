#!/bin/env python

from PyCool import cool
#from time import asctime,gmtime,localtime

class extractCorruption:
    def __init__(self,dbname,tag):
        folderName="/LAR/BadChannelsOfl/EventVeto"
        self._tag=tag
        dbSvc = cool.DatabaseSvcFactory.databaseService()
        try:
            self._db = dbSvc.openDatabase(dbname)
        except Exception:
            print "Database does not exist."
            return

        if not self._db.existsFolder(folderName):
            print "ERROR: Folder",folderName,"not found."
            self._db.closeDatabase()
            return
        
        print "Reading folder",folderName,"from DB",dbname
        self._folder=self._db.getFolder(folderName)
        if not self._folder.existsUserTag(tag):
            print "ERROR Tag",tag,"does not exist in foder",folder
            return

        return

    def isOpen(self):
        return self._db.isOpen()


    def __del__(self):
        if self._db.isOpen():
            self._db.closeDatabase()
        return
        
    def extract(self,t1,t2,tag):
        sel=cool.FieldSelection('EventVeto',cool.StorageType.UInt32,cool.FieldSelection.GE,0x8000000)
        retval=[]

        itr=self._folder.browseObjects(t1,t2,cool.ChannelSelection(0),tag,sel)
        while itr.goToNext():
            obj=itr.currentRef()
            payload=obj.payload()
            tf=obj.since()
            ts=obj.until()
            retval.append([tf,ts,0x8000000])
            pass
        itr.close()
        return retval
