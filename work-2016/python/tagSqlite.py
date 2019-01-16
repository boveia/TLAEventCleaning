#!/bin/env python

from PyCool import cool
import sys,os

def tagSqlite(sqlitefile, topTag, dbName):
    
    dbname="sqlite://;schema=%s;dbname=%s" % (sqlitefile, dbName)
    
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    try:
        db= dbSvc.openDatabase(dbname,False)
    except Exception,e:
        print "Problems connecting to Oracle database:",e
        return 1

    nodelist=db.listAllNodes()
    for folderName in nodelist:
        if db.existsFolder(folderName):
            folder=db.getFolder(folderName)
            if (folder.versioningMode()==cool.FolderVersioning.SINGLE_VERSION): continue
            print "Leaf Folder Name:",folderName
            parentName="/".join(folderName.split("/")[0:-1])
            while (folderName!="/"):
                if db.existsFolderSet(folderName):
                    folder=db.getFolderSet(folderName)
                folderTags=folder.listTags()
                if (len(folderTags)>1):
                    print "ERROR More than one tag defined in",folderName
                    return 1
                folderTag=folderTags[0]
                print "Folder Tag:",folderTag
                print "Folder(set): %s [%s]" % (folderName,folderTag)
                parent=db.getFolderSet(parentName)
                parentTags=parent.listTags()
                if len(parentTags)==0:
                    parentTag="".join(folderName.split("/")[0:-1])+"-00"
                    print "Parent set: %s [%s] (new)" % (parentName, parentTag)
                else:
                    parentTag=parentTags[0]
                    print "Parent set: %s [%s]" % (parentName, parentTag)
                    #Check if tag relation exists already
                    tagExists=False
                    try:
                        if (folder.findTagRelation(parentTag)==folderTag):
                            print "Tag-releation exists already, go to next leaf folder"
                            tagExists=True
                    except:
                        pass
                    if tagExists: break
                if (parentName=="/"): #reached top-level
                    print "create top-level tag relation:",folderTag,"->",topTag
                    folder.createTagRelation(topTag,folderTag)
                    break
                else:
                    print "create folder-level tag relation:",folderTag,"->",parentTag
                    folder.createTagRelation(parentTag,folderTag)
                #go down one level:
                folderName=parentName
                parentName="/".join(folderName.split("/")[0:-1])
                if parentName=="": parentName="/"
                

    db.closeDatabase()



if __name__=='__main__':
    if (len(sys.argv) < 3) and (len(sys.argv) > 4):
        print "Usage: ",sys.argv[0]," <sqlitefile> <top-level tag> [dbname]"
        print "Builds a tag-hierachy in a sqlite file"
        print "dbname is CONDBR2 by default"
        sys.exit(-1)
    
    sqlite=sys.argv[1]
    tag=sys.argv[2]
    if not os.access(sqlite,os.W_OK):
        print "File",sqlite,"not accessible for writing!"
        sys.exit(-1)
    dbName="CONDBR2"
    if len(sys.argv) == 4:
       dbName=sys.argv[3]

    tagSqlite(sqlite,tag,dbName)
