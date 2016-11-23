#!/bin/env python
from PyCool import cool
from string import *

def getOFCShapeFlavor():
    onlineOFCFolder="/LAR/ElecCalibFlat/OFC"
    onlineShapeFolder="/LAR/ElecCalibFlat/Shape" 

    offlineOFCFolders=["/LAR/ElecCalibOfl/OFC/PhysWave/RTM/5samples1phase","/LAR/ElecCalibOfl/OFC/PhysWave/RTM/4samples1phase"]
    offlineShapeFolders=["/LAR/ElecCalibOfl/Shape/RTM/5samples1phase","/LAR/ElecCalibOfl/Shape/RTM/4samples1phase"]
    

    dbSvc = cool.DatabaseSvcFactory.databaseService()
    try:
        db= dbSvc.openDatabase("COOLONL_LAR/CONDBR2")
    except Exception,e:
        print "ERROR: Problems connecting to database:",e
        return None

    if db.existsFolder(onlineOFCFolder):
        try:
            pFldr=db.getFolder(onlineOFCFolder)
            currObj=pFldr.findObject(cool.ValidityKeyMax-1,0) #Check only high gain
            pl=currObj.payload()
            curr_nsamples=pl["nSamples"]
        except Exception,e:
            print "Failed to extract data from online OFC folder"
            print e
            curr_nsamples=None
            pass
    else:
        print "ERROR: Folder",onlineOFCFolder,"doesn't exist!"
        curr_nsamples=None
        pass
    
    db.closeDatabase()

    OFCOptions=[]
    ShapeOptions=[]
    currOFCOption=None
    currShapeOption=None

    db=dbSvc.openDatabase("COOLOFL_LAR/CONDBR2")
    #db=dbSvc.openDatabase("sqlite://;schema=freshConstants_ofl.db;dbname=CONDBR2")

    currentOFCOption=None
    for offlineOFCFolder in offlineOFCFolders:
        if db.existsFolder(offlineOFCFolder):
            try:
                pFldr=db.getFolder(offlineOFCFolder)
                ofctaglist=pFldr.listTags()
            except Exception,e:
                print "Failed to extract data from offline database"
                print e
                pass
        
            for t in ofctaglist:
                if t.find("UPD3")!=-1:
                    OFCOptions+=[(offlineOFCFolder,t),]

            if curr_nsamples is not None:
                if offlineOFCFolder.endswith("%isamples1phase" %  curr_nsamples):
                    try:
                        currentOFCOption=(offlineOFCFolder,pFldr.resolveTag("LARCALIB-RUN2-00"))
                    except:
                        print "Could not resolve global tag in folder ",offlineOFCFolder
                        pass
                    pass
                pass #end if "%isamples1phase
            pass #end if curr_nsamples is not None: 
        else: 
            print "Folder",offlineOFCFolder,"does not exist"
            pass
        pass

    #Now check Shape
    currentShapeOption=None
    for offlineShapeFolder in offlineShapeFolders:
        if db.existsFolder(offlineShapeFolder):
            try:
                pFldr=db.getFolder(offlineShapeFolder)
                shapetaglist=pFldr.listTags()
            except Exception,e:
                print "Failed to extract data from offline database"
                print e
                pass

            for t in shapetaglist:
                if t.find("UPD3")!=-1:
                    ShapeOptions+=[(offlineShapeFolder,t),]

            if curr_nsamples is not None:
                if offlineShapeFolder.endswith("%isamples1phase" %  curr_nsamples):
                    try:
                        currentShapeOption=(offlineShapeFolder, pFldr.resolveTag("LARCALIB-RUN2-00"))
                    except:
                        print "Could not resolve global tag in folder ",offlineShapeFolder
                        pass
                    pass
                pass #endif %isamples1phase
            pass #endif  curr_nsamples is not None:
        else:
            print "Folder",offlineShapeFolder,"does not exist"
            pass

    print "Current number of samples:", curr_nsamples


    OFCFolderTag=None

    while (OFCFolderTag is None):

        print "OFC options to copy to online:"
        for idx in range(len(OFCOptions)):
            print "[%i]  %s" % (idx, OFCOptions[idx][1])
            pass
    
        if currentOFCOption is None:
            print "Could not determine default OFC option"
            rep=raw_input("Choose OFC flavor for production (0-%i): " % (len(OFCOptions)-1))
        else:
            rep=raw_input("Choose OFC flavor for production (0-%i)[%s]: " % (len(OFCOptions)-1,currentOFCOption[1]))
            pass
        if rep=="":
            OFCFolderTag=currentOFCOption
        elif rep[0].upper()=="Q":
            print "Quit"
            return None
        elif rep.isdigit():
            choice=long(rep)
            if choice>=0 and choice<len(OFCOptions):
                OFCFolderTag=OFCOptions[choice]
            else:
                print "ERROR: Number out of range, got ",rep
                continue
            pass
        else:
            print "ERROR: Could not interpret your response, got",rep
            continue
        pass    
    


    #Filter wrong number of samples out of ShapeOptions:
    chosen_subfolder=OFCFolderTag[0].split('/')[-1]
    ShapeOptionsFiltered=[]
    for so in ShapeOptions:
        if so[0].endswith(chosen_subfolder):
            ShapeOptionsFiltered.append(so)
            pass
        pass
    
    if len(ShapeOptionsFiltered)==0:
        print "ERROR, not matching shape found"
        return None
            

    print "Shape options to copy to online:"
    for idx in range(len(ShapeOptionsFiltered)):
        print "[%i]  %s" % (idx, ShapeOptionsFiltered[idx][1])
        pass
    
    if currentShapeOption not in ShapeOptionsFiltered:
       currentShapeOption =None

    ShapeFolderTag=None
    while (ShapeFolderTag is None):
        if currentShapeOption is None:
            print "Could not determine default Shape option"
            rep=raw_input("Choose Shape flavor for production (0-%i): " % (len(ShapeOptionsFiltered)-1))
        else:
            rep=raw_input("Choose Shape flavor for production (0-%i)[%s]: " % (len(ShapeOptionsFiltered)-1,currentShapeOption[1]))
            pass
        if rep=="":
            ShapeFolderTag=currentShapeOption
        elif rep[0].upper()=="Q":
            print "Quit"
            return None
        elif rep.isdigit():
            choice=long(rep)
            if choice>=0 and choice<len(ShapeOptionsFiltered):
                ShapeFolderTag=ShapeOptionsFiltered[choice]
            else:
                print "ERROR: Number out of range, got ",rep
                continue
            pass
        else:
            print "ERROR: Could not interpret your response, got ",rep
            continue
        pass    
    
    print "OFC Choice:", OFCFolderTag[1]
    print "Shape Choice:", ShapeFolderTag[1]

    return (OFCFolderTag,ShapeFolderTag)

    
        


if __name__=="__main__":

    ofcShapeForOnline=getOFCShapeFlavor()
    if ofcShapeForOnline is None:
        print "Failed to get OFC/Shapes for online database"
        
    else: 
        outfile=open("OFCShapeFolderTag.py","w") 
        outfile.write("inputFolders=[]\n")
        outfile.write("inputFolders.append((\"%s\",\"%s\"))\n" % ofcShapeForOnline[0])
        outfile.write("inputFolders.append((\"%s\",\"%s\"))\n" % ofcShapeForOnline[1])
        outfile.close()
        pass
    

    

    
#source $lardbtoolsdir/collectDataFromAP.sh $listOfDirFile
#if [ $? -ne 0 ];  then
#    echo "collectDataFromAP.sh failed."
#    exit -1
#else
#    echo "collectDataFromAP.sh successful" 
#fi

