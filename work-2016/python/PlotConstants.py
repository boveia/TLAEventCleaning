from ROOT import TFile,TTree,TCanvas

def PlotConstants(filename):
    f=TFile.Open("freshConstants.root")
    pedTree=f.Get("PEDESTALS")
    #acTree=f.Get("AUTOCORR")
    ofcTree=f.Get("OFC")
    rampTree=f.Get("RAMPS")
    mpmcTree=f.Get("MPMC")

    allTrees=(pedTree,ofcTree,rampTree,mpmcTree)

    def makePlot(gain):
        plotname="CalibGAIN"
        if gain==0:
            plotname="HIGH"
        elif gain==1:
            plotname="MED"
        elif gain==2:
            plotname="LOW"

        C=TCanvas("Calib"+plotname,"Calib"+plotname)
        C.Divide(2,2)
        pad=C.cd(1)
        pad.SetLogy()
        if pedTree is not None:
            pedTree.Draw("ped","calibLine!=-999 && gain==%i" % gain)

        pad=C.cd(2)
        pad.SetLogy()
        if rampTree is not None:
            rampTree.Draw("X[1]","corrUndo==0 && gain==%i" % gain)

        pad=C.cd(3)
        pad.SetLogy()
        if ofcTree is not None:
            ofcTree.Draw("OFCa","Gain==%i" % gain)

        pad=C.cd(4)
        pad.SetLogy()
        if mpmcTree is not None:
            mpmcTree.Draw("mphysovermcal","gain==%i" % gain)

        
        return C

    Cs=[]
    Cs+=[makePlot(0)]
    Cs+=[makePlot(1)]
    Cs+=[makePlot(2)]

    return Cs,allTrees


if __name__=="__main__":
    Cs,allTrees=PlotConstants("freshConstants.root")

    ped=allTrees[0]
    ofc=allTrees[1]
    ramp=allTrees[2]
    mpmc=allTrees[3]
    print "Trees available: ped,ramp,ofc,mpmc"
    print "Example:"
    print 'ped.Scan("barrel_ec:pos_neg:FT:slot:channel:gain"," ...")'
    while True:
        try:
            input("> ")
        except EOFError: break
        except Exception,e:
            print e
    print "Exiting.."
