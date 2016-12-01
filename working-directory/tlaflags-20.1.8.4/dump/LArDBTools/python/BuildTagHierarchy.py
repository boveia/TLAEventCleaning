#!/bin/env python

from PyCool import cool
import sys,os




def tagFolderSet(db,folderset,parenttag,foldertag):
    if parenttag is not None:
        #if folderset.findTagRelation(parenttag)
        if foldertag in folderset.listTags():
            print "Folderset %s has already a tag %s" % (folderset.fullPath(),foldertag)
        else:
            folderset.createTagRelation(parenttag,foldertag)

    #Work on subfolders:
    for subFolderName in folderset.listFolders():
        print "Working on folder",subFolderName
        folder=db.getFolder(subFolderName)
        if (folder.versioningMode()==cool.FolderVersioning.MULTI_VERSION):
            tl=folder.listTags()
            newTag=tl[0]
            if len(tl)>1:
                taghint=os.environ.get("pileupOFCTag")
                #print taghint
                if taghint is not None and taghint in tl:
                    newTag=taghint
                    print "More than one tag in in",subFolderName,"using",newTag,"(hint)"
                else: 
                    print "WARNING: More than one tag found in",subFolderName,"using",newTag
            try:
                folder.createTagRelation(foldertag,newTag)
            except:
                print "Tag relation exists already"
            
    #Work on sub-foldersets
    for subFolderName in folderset.listFolderSets():
        print "Working on folderset",subFolderName
        newTag="".join(subFolderName.split("/"))+"-00"
        folderset=db.getFolderSet(subFolderName)
        tagFolderSet(db,folderset,foldertag,newTag)


def tagSqlite(sqlitefile, topTag):
    
    dbname="sqlite://;schema=%s;dbname=CONDBR2" % (sqlitefile)    
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    try:
        db= dbSvc.openDatabase(dbname,False)
    except Exception,e:
        print "Problems connecting to database:",e
        return 1

    root=db.getFolderSet("/")
    tagFolderSet(db,root,None,topTag)


    db.closeDatabase()
    


if __name__=='__main__':
    if (len(sys.argv) !=3):
        print "Usage: ",sys.argv[0]," <sqlitefile> <top-level tag"
        print "Builds a tag-hierachy in a sqlite file"
        sys.exit(-1)
    
    sqlite=sys.argv[1]
    tag=sys.argv[2]
    if not os.access(sqlite,os.W_OK):
        print "File",sqlite,"not accessible for writing!"
        sys.exit(-1)

    tagSqlite(sqlite,tag)
