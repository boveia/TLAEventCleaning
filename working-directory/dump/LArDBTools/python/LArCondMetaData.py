import FolderToDatatype

class LArCondMetaDataObject:
    def __init__(self,folder):
        #self.oid=oid
        self.folder=folder
        self.channels=set()
        self.PartGainProv=tuple()
        self.type="unknown"
        self.procDate=0
        self.procVersion="unknown"

class LArCondMetaDataFile:
    def __init__(self,guid):
        self._guid=guid
        self._objects=dict()


    def objIter(self):
        return self._objects.iteritems()

    def size(self):
        return len(self._objects)

    def DateAndVersion(self):
        myDate=0xFFFFFFFF
        myVers="unknown"
        for obj in self._objects.itervalues():
            if obj.procDate<myDate:
                myDate=obj.procDate
                myVers=obj.procVersion
        return (myDate,myVers)

    def add(self,oid,folder,channel):
        if self._objects.has_key(oid):
            #obj already there
            obj=self._objects[oid]
            if obj.folder is not folder:
                if FolderToDatatype.FolderToDatatype[obj.folder]!=FolderToDatatype.FolderToDatatype[folder]:
                    print "ERROR Same GUID/OID found in different folders!"
                    print obj.folder,folder
                    return False
                #else: Same data type though in different folder, probably ok
        else:
            obj=self._objects[oid]=LArCondMetaDataObject(folder)

        obj.channels.add(channel)
