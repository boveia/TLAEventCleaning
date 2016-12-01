from pyAMI import pyAMI

def getDatasets():
     amiclient=pyAMI.AMI()
     result=amiclient.execute(["ListElement",
                               "-project=POOL_Cond",
                               "-processingStep=2009",
                               "-entity=dataset"
                               ])
     validDS=()
     notValidDS=()
     for ds in result.getDict()['dataset'].itervalues():
         if ds["AMISTATUS"]=="VALID":
             validDS+=(ds["LOGICALDATASETNAME"],)
         else:
             notValidDS+=(ds["LOGICALDATASETNAME"],)
     return validDS,notValidDS


def getFiles():
    amiclient=pyAMI.AMI()
    result=amiclient.execute(["ListElement",
                              "-project=POOL_Cond",
                              "-processingStep=2009",
                              "-entity=files"
                              ])
    lfns=()
    for fd in result.getDict()['files'].itervalues():
        if fd.has_key("LFN"):
            lfns+=(fd["LFN"],)
    return lfns
    
     
if __name__=='__main__':
    x=getDatasets()
    print x

    y=getFiles()
    print y
    
