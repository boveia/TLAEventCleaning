
from glob import glob
from colours import printcol

def main():
    # event-veto-info-merge  event-veto-info-periodF

    info1 = '../data/event-veto-info-merge'
    info2 = '../data/event-veto-info-all2016'

    info1 = '../data/event-veto-info-all2016'
    info1 = '../data/event-veto-info-merge'
    # info2 = '/afs/cern.ch/user/d/doglioni/public/TLA/event-veto-info-all2016/'

    checkstr = '-3*'

    files1 = getFiles(info1, checkstr)
    files2 = getFiles(info2, checkstr)

    col = 'green'
    if len(files1) != len(files2): col = 'red'
    print printcol(info1 + ' has ' + str(len(files1)) + ' files matching ' + checkstr, col)
    print printcol(info2 + ' has ' + str(len(files2)) + ' files matching ' + checkstr, col)

    outDict1 = {}
    for infofile in files1:
        DSID = int(infofile.split('-veto-')[-1].split('.txt')[0])
        outDict1[DSID] = getNumbers(infofile)

    outDict2 = {}
    for infofile in files2:
        DSID = int(infofile.split('-veto-')[-1].split('.txt')[0])
        outDict2[DSID] = getNumbers(infofile)


    # print crash info
    print info1, info2
    print printcol('no crash, all there','green')
    print printcol('with crash, but output OK','blue')
    print printcol('with crash, no output','red')

    for DSID in sorted(outDict1):
        if not outDict1[DSID]['crashed'] and outDict1[DSID]['nInteresting'] in [2,4,6]: col1 = 'green'
        elif outDict1[DSID]['nInteresting'] in [2,4,6]: col1 = 'blue'
        else: col1 = 'red'

        try:
            DSID2 = DSID
            if not outDict2[DSID]['crashed'] and outDict2[DSID]['nInteresting'] in [2,4,6]: col2 = 'green'
            elif outDict2[DSID]['nInteresting'] in [2,4,6]: col2 = 'blue'
            else: col2 = 'red'
        except:
            DSID2 = 'n/a'
            col2 = 'red'

        print printcol(str(DSID), col1), '\t', printcol(str(DSID2), col2)


    # print interesting cases in full
    print '\nHere are the interesting cases'
    for DSID in sorted(outDict1):
        if DSID not in outDict2: continue

        if outDict1[DSID]['nInteresting'] in [2,4,6] and outDict2[DSID]['nInteresting'] in [2,4,6] and not outDict1[DSID]['crashed'] and not outDict2[DSID]['crashed']: continue

        print DSID
        print outDict1[DSID]
        print outDict2[DSID]


# end of file looks like one of:
"""
Found a total of 4 noisy periods, covering a total of 0.04 seconds
Lumi loss due to noise-bursts: 0.10 nb-1 out of 10269.25 nb-1 (0.01 per-mil)

Found a total of 1547 noisy periods, covering a total of 29.29 seconds
Found a total of 4607 Mini noise periods, covering a total of 46.08 seconds
Lumi loss due to noise-bursts: 173.41 nb-1 out of 530882.45 nb-1 (0.33 per-mil)
Lumi loss due to mini-noise-bursts: 325.15 nb-1 out of 530882.45 nb-1 (0.61 per-mil)

Found a total of 80 noisy periods, covering a total of 0.82 seconds
Found a total of 1061 Mini noise periods, covering a total of 10.61 seconds
Found a total of 7 corruption periods, covering a total of 126.40 seconds
Lumi loss due to noise-bursts: 6.19 nb-1 out of 326266.87 nb-1 (0.02 per-mil)
Lumi loss due to mini-noise-bursts: 77.47 nb-1 out of 326266.87 nb-1 (0.24 per-mil)
Lumi loss due to corruption: 1012.05 nb-1 out of 326266.87 nb-1 (3.10 per-mil)
"""
    
def getNumbers(filename):
    infile = open(filename)
    lines = infile.readlines()
    infile.close()
    outDict = {}
    nInterestingLines = 0
    outDict['crashed'] = False

    # Event Veto ['MiniNoiseBurst'], Sun Oct  9 17:47:00 2016 UTC-Sun Oct  9 17:47:00 2016 UTC (0.010 )  Run 310249, LB 554 (1476035220072295168.000000,1476035220062295296.000000)
    # Event Veto ['MiniNoiseBurst'], Sun Oct  9 17:47:00 2016 UTC-Sun Oct  9 17:47:00 2016 UTC (0.010 ) CORAL/RelationalPlugins/oracle Error ORA-25408: can not safely replay call (retrieving the describe handle of ATLAS_COOLONL_TRIGGER."COOL_C2" (Schema::existsTable))
    # Connection lost! Skipping  1476035220972258155
    # Run 0, LBs 0-554 (1476035220982258176.000000,1476035220972258048.000000)

    os.system('grep "Connection failed" '+filename)
    # for line in lines:
        # if line.startswith('Event Veto') and not line.endswith('.000000)'):
            

    # for line in lines[-7:]:
    for line in lines[-20:]:
        nInterestingLines += 1
        if 'noisy periods' in line:
            outDict['nNoisy'] = int(line.split(' noisy periods')[0].split()[-1])
            outDict['tNoisy'] = float(line.split(' seconds')[0].split()[-1])
        elif 'Mini noise periods' in line:
            outDict['nMiniNoisy'] = int(line.split(' Mini noise periods')[0].split()[-1])
            outDict['tMiniNoisy'] = float(line.split(' seconds')[0].split()[-1])
        elif 'corruption periods' in line:
            outDict['nCorrupt'] = int(line.split(' corruption periods')[0].split()[-1])
            outDict['tCorrupt'] = float(line.split(' seconds')[0].split()[-1])
        elif 'due to noise-bursts' in line:
            outDict['lNoisy'] = float(line.split('noise-bursts: ')[1].split()[0])
            outDict['lTotal'] = float(line.split('out of ')[1].split()[0])
        elif 'due to mini-noise-bursts' in line:
            outDict['lMiniNoisy'] = float(line.split('noise-bursts: ')[1].split()[0])
        elif 'due to corruption' in line:
            outDict['lCorrupt'] = float(line.split('corruption: ')[1].split()[0])
        else:
            nInterestingLines -= 1

        if 'terminate called after throwing' in line:
            outDict['crashed'] = True
            

    outDict['nInteresting'] = nInterestingLines
    return outDict
            


def getFiles(infoPath, checkstr='-*'):
    files = glob(infoPath+'/event-veto'+checkstr+'.txt')
    return sorted(files)


if __name__=='__main__':
    main()
