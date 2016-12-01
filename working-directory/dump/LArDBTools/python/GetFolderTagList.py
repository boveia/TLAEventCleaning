#!/bin/env python
import sys,os

def GetFolderTagList(dbname,tags):
    from PyCool import cool
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    db = dbSvc.openDatabase(dbname)
    #from CoolConvUtilities.AtlCoolLib import indirectOpen 
    #db = indirectOpen("COOLOFL_LAR/COMP200",readOnly=True,oracle=True)

    nodelist=db.listAllNodes()

    retval=list()
    
    for node in nodelist:
        if db.existsFolder(node):
            f=db.getFolder(node)
            foldertaglist=[node,]
            for gt in tags:
                try:
                    t=f.resolveTag(gt)
                except:
                    t="NA"
                    pass
                foldertaglist.append(t)

            retval.append(foldertaglist)
    db.closeDatabase()
    return retval 
        

if __name__=="__main__":
    if os.environ.has_key("GLOBALTAG"):
        globaltag=os.environ["GLOBALTAG"]
    else:
        globaltag="CURRENT"
    
    if globaltag.upper()=="CURRENT" or globaltag.upper()=="NEXT":
        sys.path.append('/afs/cern.ch/user/a/atlcond/utils/python/')
        from AtlCoolBKLib import resolveAlias
        resolver=resolveAlias()
        if globaltag.upper()=="CURRENT":
            globaltag=resolver.getCurrent().replace("*","ST")
        else:
            globaltag=resolver.getNext().replace("*","ST")
        print "Global tag resolved to",globaltag
    else:
        print "Global tag set to",globaltag
            
    tagsToResolve=[globaltag,]

    if os.environ.has_key("LARTAG"):
        lartag=os.environ["LARTAG"]
        print "Found LAR-Global tag:",lartag
        tagsToResolve.append(lartag)    

    
    taglist=GetFolderTagList("COOLOFL_LAR/CONDBR2",tagsToResolve)

    for fl in taglist:
        for f in fl:
            print f,
        print ""

