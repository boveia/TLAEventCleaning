#from pyAMI import pyAMI
import  pyAMI.utils, pyAMI.client, pyAMI.exception, pyAMI.atlas.api

def getDatasets():
     amiclient=pyAMI.client.Client('atlas',format='dict_object')
     result=amiclient.execute(["ListElement",
                               "-project=POOL_Cond",
                               "-processingStep=2009",
                               "-entity=dataset"
                               ])
     validDS=()
     notValidDS=()
     #for ds in result.getDict()['dataset'].itervalues():
     for ds in result.get_rows_i():
         if ds["AMISTATUS"]=="VALID":
             validDS+=(ds["LOGICALDATASETNAME"],)
         else:
             notValidDS+=(ds["LOGICALDATASETNAME"],)
     return validDS,notValidDS


def getFiles():
    amiclient=pyAMI.client.Client('atlas',format='dict_object')
    result=amiclient.execute(["ListElement",
                              "-project=POOL_Cond",
                              "-processingStep=2009",
                              "-entity=files"
                              ])
    lfns=()
    #for fd in result.getDict()['files'].itervalues():
    for fd in result.get_rows_i():
        if fd.has_key("LFN"):
            lfns+=(fd["LFN"],)
    return lfns
    
     
if __name__=='__main__':
    x=getDatasets()
    print x

    y=getFiles()
    print y
    
