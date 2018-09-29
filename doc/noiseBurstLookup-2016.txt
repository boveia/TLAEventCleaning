
# how to retrieve noise burst info from the COOL database?

The following are notes from the 2015 development of the TLA noise burst lookup tools. For 2016 changes, skip to [here][notes2016]

## accessing the DB from athena.py

One can access the DB directly from Athena with code like

```
from IOVDbSvc.CondDB import conddb
conddb.addFolder('LAR_OFL',"/LAR/BadChannelsOfl")

from AthenaCommon.GlobalFlags import globalflags
globalflags.DataSource = 'data'  # or set this to 'geant4' if running on MC! ...
globalflags.DatabaseInstance = 'CONDBR2' # e.g. if you want run 2 data, set to COMP200 if you want run1. This is completely ignored in MC.

conddb.setGlobalTag("CONDBR2-BLKPA-2015-14")

svcMgr.EventSelector.RunNumber=281385 #set to the run you want
#svcMgr.EventSelector.InitialTimeStamp=4566 #set to the UTC timestamp you want COOL info for!
```

etc. Nevertheless, maybe this is inconvenient. There is another way.

## using the database console


```
AtlCoolConsole.py  "COOLOFL_LAR/CONDBR2"
cd LAR
cd BadChannelsOfl
listtags EventVeto
> Listing tags for folder /LAR/BadChannelsOfl/EventVeto
> LARBadChannelsOflEventVeto-RUN2-UPD1-00 (locked) []
> LARBadChannelsOflEventVeto-RUN2-UPD4-04 (locked) []
> LARBadChannelsOflEventVeto-RUN2-empty (locked) []
```


```
usetag LARBadChannelsOflEventVeto-RUN2-UPD4-04
>>> userunlumi 281385
>>> userunlumi 281385 5 281385 5
>>> more EventVeto
```

This dumps a huge list, looks like summary table of all noise burst info since 2012.

## AtlCoolConsole.py can't do what I want?

AtlCoolConsole.py has the following list of commands:

```
Available commands:
  cd       : change directory
  clonetag : clone data from one tag to another
  exit     : quit the interpreter session
  filtertags : list tags in folder / folder set with filtering
  headtag  : apply HEAD-style tag to a folder
  help     : help overview
  less     : list contents of folders, e.g. less "/a"
  listchans : list channels in folder
  listinfo : list info about folder (type, columns)
  listtags : list tags in folder / folder set
  ll       : list contents of foldersets with entry count
  locktag  : lock a tag so the contents cannot be changed
  ls       : list contents of foldersets, e.g. ls "/"
  more     : list contents of folders (ATLAS specific)
  open     : open the specified database, e.g. open 'sqlite://...'
  pwd      : print current directory
  pws      : print current tag and channel selections used by less
  quit     : alias for exit
  rmdir    : remove a folder or folderset
  rmtag    : remove tag or hierarchical tag relation to a parent
  setchan  : set channel name/description
  setdesc  : set folder description (meta-data) string
  settag   : set hierarchical tag for a folder+parent
  settginfo : set tag description string
  tracetags : list tags defined in subfolders for parent
  usechan  : set subsequent list operations (less) to display given COOL channel number only
  userunlumi : set limits for run/lumi blocks in more/less
  usetag   : set subsequent list operations (less) to use given COOL tag
  usetimes : set limits for timestamps in more/less
```
  
I don't see how to look past the summary to see inside the DB payload,
and there are two other things in this folder: BadChannels and
MissingFEBs. What are they?


## BadChannels

```
listtags BadChannels
usetag LARBadChannelsOflBadChannels-RUN2-UPD4-14
more BadChannels
```

dumps what looks like a summary of what is actually in the database, e.g.

```
Using tag selection: LARBadChannelsOflBadChannels-RUN2-UPD4-14
[110000,0] - [110854,0) (0) [ChannelSize (UInt32) : 4], [StatusWordSize (UInt32) : 4], [Endianness (UInt32) : 0], [Version (UInt32) : 1], [Blob (Blob64k) : size=2728,chk=1325606396]
[110855,0] - [113660,0) (0) [ChannelSize (UInt32) : 4], [StatusWordSize (UInt32) : 4], [Endianness (UInt32) : 0], [Version (UInt32) : 1], [Blob (Blob64k) : size=1360,chk=-685463463]
```

is there a way to dump the contents?

```
listchans BadChannels
>Listing channel IDs, names, descriptions for folder/LAR/BadChannelsOfl/BadChannels
>Total number of channels defined: 8
>Seq ChannelNum ChannelName Desc
>0: 0  
>1: 1  
>2: 2  
>3: 3  
>4: 4  
>5: 5  
>6: 6  
listinfo BadChannels
>Specification for multi-version folder /LAR/BadChannelsOfl/BadChannels
> ChannelSize (UInt32)
> StatusWordSize (UInt32)
> Endianness (UInt32)
> Version (UInt32)
> Blob (Blob64k)
>Description: <timeStamp>run-lumi</timeStamp><addrHeader><address_header service_type="71" clid="1238547719" /></addrHeader><typeName>CondAttrListCollection</typeName>
```


## MissingFEBs


```
listtags MissingFEBs
> Listing tags for folder /LAR/BadChannelsOfl/MissingFEBs
> LARBadChannelsOflMissingFEBs-RUN2-UPD1-01 (locked) []
> LARBadChannelsOflMissingFEBs-RUN2-UPD3-01 (unlocked) []
> LARBadChannelsOflMissingFEBs-RUN2-UPD4-01 (locked) []
usetags LARBadChannelsOflMissingFEBs-RUN2-UPD4-01
> Changed current tag selection to s LARBadChannelsOflMissingFEBs-RUN2-UPD4-01
usetag LARBadChannelsOflMissingFEBs-RUN2-UPD4-01
> Changed current tag selection to LARBadChannelsOflMissingFEBs-RUN2-UPD4-01
more MissingFEBs
> Using tag selection: LARBadChannelsOflMissingFEBs-RUN2-UPD4-01
> [215064,0] - [215274,0) (0) [ChannelSize (UInt32) : 4], [StatusWordSize (UInt32) : 4], [Endianness (UInt32) : 0], [Version (UInt32) : 2], [Blob (Blob64k) : size=40,chk=1828760124]
> [215274,0] - [2147483647,4294967295) (0) [ChannelSize (UInt32) : 4], [StatusWordSize (UInt32) : 4], [Endianness (UInt32) : 0], [Version (UInt32) : 2], [Blob (Blob64k) : size=8,chk=-256926225]
```
Therefore I need to figure out if this information is useful (there are always bad channels, but the cleaning tools make decisions based on the bad channel expectation and what is actually seen in the detector, and we do not have the latter in the DataScouting stream. If so, then I'll learn how to access the missing FEB and BadChannel data. I can infer that it exists from these summaries, at any rate.

## dumping bad channels for a run with LArCalorimeter/LArBadChannelTool/share/LArBadChannel2Ascii.py
- dumps table for a given run and db tag (must be set inside the job options)
- dumps a text file like

```
0 0 0 6 91 0 deadReadout unstable  # 0x3802db00
0 0 1 3 0 0 distorted  # 0x38090000
0 0 1 3 64 0 distorted  # 0x38094000
0 0 1 10 112 0 distorted  # 0x380cf000
0 0 1 10 113 0 deadCalib  # 0x380cf100
0 0 1 10 115 0 distorted  # 0x380cf300
0 0 1 10 124 0 distorted  # 0x380cfc00
0 0 1 10 127 0 distorted  # 0x380cff00
0 0 1 11 4 0 deadReadout  # 0x380d0400
0 0 2 5 127 0 unstable distorted  # 0x38127f00
0 0 3 9 0 0 lowNoiseHG  # 0x381c0000
0 0 3 13 126 0 highNoiseHG  # 0x381e7e00
0 0 3 13 127 0 lowNoiseHG  # 0x381e7f00
0 0 4 8 127 0 distorted  # 0x3823ff00
0 0 4 11 0 0 distorted  # 0x38250000
0 0 4 11 1 0 distorted  # 0x38250100
0 0 4 11 2 0 distorted  # 0x38250200
0 0 4 11 3 0 distorted  # 0x38250300
0 0 4 11 50 0 distorted  # 0x38253200
0 0 5 1 115 0 unstable lowNoiseHG  # 0x38287300
0 0 5 6 77 0 deadCalib  # 0x382acd00
0 0 5 12 97 0 deadCalib  # 0x382de100
0 0 5 12 99 0 deadCalib  # 0x382de300
0 0 5 12 104 0 deadCalib  # 0x382de800
0 0 5 12 106 0 deadCalib  # 0x382dea00
```

## LArCalorimeter/​LArBadChannelTool/​share/​LArBadChannelSummary.py

There's also ​LArBadChannelSummary.py and LArBadFeb2Ascii.cxx which appear to dump MissingFEB information.

# EventVeto

I need a way to dump the actual EventVeto data from the database.

Poking around in LXR full text search,```/afs/cern.ch/user/l/larcalib/LArDBTools/python/showEventVeto.py``` lists some information like

```
Event Veto ['NoiseBurst'], Mon Jul 20 05:13:45 2015 UTC-Mon Jul 20 05:13:45 2015 UTC (0.485 )  Run 272531, LB 118
Event Veto ['NoiseBurst'], Mon Jul 20 05:16:06 2015 UTC-Mon Jul 20 05:16:06 2015 UTC (0.288 )  Run 272531, LB 120
Event Veto ['NoiseBurst'], Mon Jul 20 05:20:11 2015 UTC-Mon Jul 20 05:20:11 2015 UTC (0.200 )  Run 272531, LB 125
```

where the format is 

```
print "Event Veto %s, %s-%s (%.3f ) " % (str(types),ts2string(tf),ts2string(ts),(ts-tf)/1e9 ),
print "Run %i, LBs %i-%i" % (rl1[0],rl1[1],rl2[1]) 

```
The lumi block numbers are actually converted from the start/stop timestamps.

There is no EventNumber range here! If we retrieve the timestamp from the DataScounting event info and use that to veto events, there's a corresponding loss in luminosity. Is this loss in luminosity already corrected for (Defects DB?) when the good run list is created? TODO!

The time string is formatted as

```
def ts2string(ts):
    if ts==0:
        return "0"
    if ts==cool.ValidityKeyMax:
        return "INF"
    stime=int(ts/1000000000L)
    return asctime(gmtime(stime))+" UTC"
```

The argument of gmtime is the number of seconds since the epoch, i.e. ts is the timestamp in nanoseconds. The [EventInfo header](http://acode-browser.usatlas.bnl.gov/lxr/source/atlas/Event/EventInfo/EventInfo/EventID.h) has

```
     /// run number - 32 bit unsigned
     number_type   run_number           (void) const;
 
     /// event number - 64 bit unsigned
     uint64_t      event_number         (void) const;
 
     /// time stamp - posix time in seconds from 1970, 32 bit unsigned
     number_type   time_stamp           (void) const; 
 
     /// time stamp ns - ns time offset for time_stamp, 32 bit unsigned
     number_type   time_stamp_ns_offset (void) const; 
 
     /// luminosity block identifier, 32 bit unsigned
     number_type   lumi_block           (void) const;
```
which should be sufficient, if filled. TODO: I should write some dumper code to process some of the reco-ed DataScouting output (pre-Merlin-ntuples) and see whether this is the case.

I downloaded a few files from run 280520 for xAODAnaHelpers analysis. The entire list of noise bursts is:

```
160116 lxplus0037 python >python showEventVeto.py -r 280520 -e 280520

Dumping EventVeto data from run 280520 to run 280520  lasting from Mon Sep 28 14:38:59 2015 UTC to Mon Sep 28 22:16:15 2015 UTC
Event Veto ['NoiseBurst'], Mon Sep 28 16:24:07 2015 UTC-Mon Sep 28 16:24:08 2015 UTC (0.050 )  Run 280520, LB 106 (1443457448021783552.000000,1443457447971514624.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 17:17:50 2015 UTC-Mon Sep 28 17:17:50 2015 UTC (0.050 )  Run 280520, LB 162 (1443460670799929344.000000,1443460670749928448.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 17:20:36 2015 UTC-Mon Sep 28 17:20:36 2015 UTC (0.050 )  Run 280520, LB 164 (1443460836492641280.000000,1443460836442640128.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 17:30:11 2015 UTC-Mon Sep 28 17:30:11 2015 UTC (0.050 )  Run 280520, LB 177 (1443461411442652416.000000,1443461411392651776.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 17:31:38 2015 UTC-Mon Sep 28 17:31:38 2015 UTC (0.050 )  Run 280520, LB 179 (1443461498484150784.000000,1443461498434150400.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 17:40:18 2015 UTC-Mon Sep 28 17:40:19 2015 UTC (0.050 )  Run 280520, LB 187 (1443462019049110528.000000,1443462018998835200.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:05:54 2015 UTC-Mon Sep 28 18:05:54 2015 UTC (0.050 )  Run 280520, LB 215 (1443463554292449792.000000,1443463554242448896.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:06:11 2015 UTC-Mon Sep 28 18:06:11 2015 UTC (0.050 )  Run 280520, LB 215 (1443463571132692480.000000,1443463571082692096.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:06:26 2015 UTC-Mon Sep 28 18:06:26 2015 UTC (0.050 )  Run 280520, LB 215 (1443463586752434432.000000,1443463586702433792.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:24:33 2015 UTC-Mon Sep 28 18:24:33 2015 UTC (0.050 )  Run 280520, LB 233 (1443464673773182208.000000,1443464673723056640.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:26:51 2015 UTC-Mon Sep 28 18:26:51 2015 UTC (0.050 )  Run 280520, LB 237 (1443464811557856256.000000,1443464811507855872.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:32:12 2015 UTC-Mon Sep 28 18:32:12 2015 UTC (0.050 )  Run 280520, LB 245 (1443465132446770688.000000,1443465132396770048.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:40:46 2015 UTC-Mon Sep 28 18:40:46 2015 UTC (0.050 )  Run 280520, LB 257 (1443465646495336960.000000,1443465646445062656.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:44:05 2015 UTC-Mon Sep 28 18:44:05 2015 UTC (0.093 )  Run 280520, LB 261 (1443465845452323328.000000,1443465845359345408.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:46:59 2015 UTC-Mon Sep 28 18:46:59 2015 UTC (0.050 )  Run 280520, LB 263 (1443466019675847936.000000,1443466019625847040.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:47:29 2015 UTC-Mon Sep 28 18:47:29 2015 UTC (0.050 )  Run 280520, LB 264 (1443466049102002944.000000,1443466049052002304.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:47:37 2015 UTC-Mon Sep 28 18:47:37 2015 UTC (0.050 )  Run 280520, LB 264 (1443466057422787328.000000,1443466057372786944.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:47:48 2015 UTC-Mon Sep 28 18:47:48 2015 UTC (0.050 )  Run 280520, LB 264 (1443466068524335104.000000,1443466068474334464.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:48:21 2015 UTC-Mon Sep 28 18:48:21 2015 UTC (0.050 )  Run 280520, LB 265 (1443466101070066944.000000,1443466101020066304.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:48:28 2015 UTC-Mon Sep 28 18:48:28 2015 UTC (0.050 )  Run 280520, LB 265 (1443466108914114304.000000,1443466108864113920.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:49:08 2015 UTC-Mon Sep 28 18:49:08 2015 UTC (0.050 )  Run 280520, LB 266 (1443466148183198720.000000,1443466148133198080.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:49:41 2015 UTC-Mon Sep 28 18:49:41 2015 UTC (0.050 )  Run 280520, LB 266 (1443466181644180736.000000,1443466181594180096.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:54:03 2015 UTC-Mon Sep 28 18:54:03 2015 UTC (0.050 )  Run 280520, LB 271 (1443466443330318592.000000,1443466443280317952.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:54:07 2015 UTC-Mon Sep 28 18:54:07 2015 UTC (0.050 )  Run 280520, LB 271 (1443466447320194816.000000,1443466447270194176.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:00:24 2015 UTC-Mon Sep 28 19:00:24 2015 UTC (0.050 )  Run 280520, LB 277 (1443466824125842944.000000,1443466824075842304.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:06:58 2015 UTC-Mon Sep 28 19:06:58 2015 UTC (0.050 )  Run 280520, LB 285 (1443467218801331968.000000,1443467218751331328.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:07:28 2015 UTC-Mon Sep 28 19:07:28 2015 UTC (0.050 )  Run 280520, LB 286 (1443467248822475520.000000,1443467248772474880.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:22:33 2015 UTC-Mon Sep 28 19:22:33 2015 UTC (0.050 )  Run 280520, LB 302 (1443468153659888640.000000,1443468153609888256.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:23:59 2015 UTC-Mon Sep 28 19:23:59 2015 UTC (0.050 )  Run 280520, LB 303 (1443468239887756288.000000,1443468239837755904.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:24:45 2015 UTC-Mon Sep 28 19:24:45 2015 UTC (0.050 )  Run 280520, LB 304 (1443468285380109312.000000,1443468285330108672.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:25:28 2015 UTC-Mon Sep 28 19:25:28 2015 UTC (0.050 )  Run 280520, LB 305 (1443468328506791680.000000,1443468328456791040.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:27:16 2015 UTC-Mon Sep 28 19:27:16 2015 UTC (0.050 )  Run 280520, LB 307 (1443468436378364416.000000,1443468436328278784.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:28:01 2015 UTC-Mon Sep 28 19:28:01 2015 UTC (0.050 )  Run 280520, LB 308 (1443468481341735680.000000,1443468481291735296.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:29:08 2015 UTC-Mon Sep 28 19:29:09 2015 UTC (0.050 )  Run 280520, LB 309 (1443468549029035008.000000,1443468548979034112.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:29:20 2015 UTC-Mon Sep 28 19:29:20 2015 UTC (0.050 )  Run 280520, LB 309 (1443468560663288832.000000,1443468560613288448.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:30:50 2015 UTC-Mon Sep 28 19:30:50 2015 UTC (0.050 )  Run 280520, LB 311 (1443468650245683712.000000,1443468650195683328.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:31:36 2015 UTC-Mon Sep 28 19:31:36 2015 UTC (0.050 )  Run 280520, LB 312 (1443468696273964800.000000,1443468696223964160.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:33:53 2015 UTC-Mon Sep 28 19:33:53 2015 UTC (0.050 )  Run 280520, LB 314 (1443468833079464192.000000,1443468833029463552.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:37:37 2015 UTC-Mon Sep 28 19:37:37 2015 UTC (0.050 )  Run 280520, LB 318 (1443469057644790272.000000,1443469057594789632.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:39:40 2015 UTC-Mon Sep 28 19:39:40 2015 UTC (0.050 )  Run 280520, LB 320 (1443469180573593600.000000,1443469180523557120.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:41:27 2015 UTC-Mon Sep 28 19:41:27 2015 UTC (0.050 )  Run 280520, LB 322 (1443469287180540928.000000,1443469287130430464.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 19:59:58 2015 UTC-Mon Sep 28 19:59:58 2015 UTC (0.050 )  Run 280520, LB 343 (1443470398695674112.000000,1443470398645673984.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 20:21:01 2015 UTC-Mon Sep 28 20:21:01 2015 UTC (0.050 )  Run 280520, LB 377 (1443471661162923008.000000,1443471661112922880.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 20:26:08 2015 UTC-Mon Sep 28 20:26:09 2015 UTC (0.050 )  Run 280520, LB 384 (1443471969034963200.000000,1443471968984962560.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 20:35:40 2015 UTC-Mon Sep 28 20:35:41 2015 UTC (0.050 )  Run 280520, LB 394 (1443472541003896576.000000,1443472540953896192.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 20:56:37 2015 UTC-Mon Sep 28 20:56:37 2015 UTC (0.051 )  Run 280520, LB 422 (1443473797990746624.000000,1443473797939467264.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 20:56:38 2015 UTC-Mon Sep 28 20:56:38 2015 UTC (0.058 )  Run 280520, LB 422 (1443473798170198528.000000,1443473798112658688.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 20:56:38 2015 UTC-Mon Sep 28 20:56:38 2015 UTC (0.050 )  Run 280520, LB 422 (1443473798922522880.000000,1443473798872435200.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 21:21:30 2015 UTC-Mon Sep 28 21:21:30 2015 UTC (0.050 )  Run 280520, LB 462 (1443475290205867520.000000,1443475290155866880.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 21:21:30 2015 UTC-Mon Sep 28 21:21:30 2015 UTC (0.050 )  Run 280520, LB 462 (1443475290943809024.000000,1443475290893808128.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 21:24:05 2015 UTC-Mon Sep 28 21:24:05 2015 UTC (0.050 )  Run 280520, LB 465 (1443475445676749824.000000,1443475445626747648.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 21:37:20 2015 UTC-Mon Sep 28 21:37:20 2015 UTC (0.096 )  Run 280520, LB 478 (1443476240687897344.000000,1443476240591654144.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 21:38:37 2015 UTC-Mon Sep 28 21:38:37 2015 UTC (0.050 )  Run 280520, LB 480 (1443476317386342400.000000,1443476317336341760.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 21:45:15 2015 UTC-Mon Sep 28 21:45:15 2015 UTC (0.068 )  Run 280520, LB 486 (1443476715121732864.000000,1443476715053656064.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 21:45:19 2015 UTC-Mon Sep 28 21:45:19 2015 UTC (0.050 )  Run 280520, LB 486 (1443476719261881856.000000,1443476719211881472.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 22:03:57 2015 UTC-Mon Sep 28 22:03:58 2015 UTC (0.071 )  Run 280520, LB 518 (1443477838013330688.000000,1443477837941903616.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 22:05:37 2015 UTC-Mon Sep 28 22:05:37 2015 UTC (0.050 )  Run 280520, LB 520 (1443477937759550208.000000,1443477937709549312.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 22:11:55 2015 UTC-Mon Sep 28 22:11:55 2015 UTC (0.050 )  Run 280520, LB 528 (1443478315418902784.000000,1443478315368901888.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 22:12:33 2015 UTC-Mon Sep 28 22:12:33 2015 UTC (0.050 )  Run 280520, LB 529 (1443478353875425024.000000,1443478353825424128.000000)
Found a total of 59 noisy periods, covering a total of 3.09 seconds
Found a total of 0 corruption periods, covering a total of 0.00 seconds
Lumi loss due to noise-bursts: 5.60 nb-1 out of 31361.66 nb-1 (0.18 per-mil)
Overlaps are counted as noise
```

The xAODs have info like

```
root -lb  AOD.07287267._000017.pool.root.1
...
root [1] CollectionTree->Scan("EventInfoAux.runNumber:EventInfoAux.eventNumber:EventInfoAux.lumiBlock:EventInfoAux.timeStamp:EventInfoAux.timeStampNSOffset","","colsize=15")
******************************************************************************************************
*    Row   * EventInfoAux.ru * EventInfoAux.ev * EventInfoAux.lu * EventInfoAux.ti * EventInfoAux.ti *
******************************************************************************************************
*        0 *          280520 *        91966037 *             247 *      1443465171 *        40948640 *
*        1 *          280520 *        91960938 *             247 *      1443465170 *       928586880 *
*        2 *          280520 *        91966852 *             247 *      1443465171 *        59267200 *
*        3 *          280520 *        91964968 *             247 *      1443465171 *        16537760 *
*        4 *          280520 *        91968083 *             247 *      1443465171 *        85429970 *
*        5 *          280520 *        91958122 *             247 *      1443465170 *       865364525 *
*        6 *          280520 *        91980461 *             247 *      1443465171 *       353871330 *
*        7 *          280520 *        91971696 *             247 *      1443465171 *       161862345 *
*        8 *          280520 *        91983662 *             247 *      1443465171 *       425454580 *
*        9 *          280520 *        91983675 *             247 *      1443465171 *       425810500 *
*       10 *          280520 *        91984894 *             247 *      1443465171 *       452820625 *
*       11 *          280520 *        91988686 *             247 *      1443465171 *       541326060 *
*       12 *          280520 *        91972516 *             247 *      1443465171 *       179374945 *
*       13 *          280520 *        92001218 *             247 *      1443465171 *       817676080 *
*       14 *          280520 *        91994032 *             247 *      1443465171 *       657989205 *
*       15 *          280520 *        92007743 *             247 *      1443465171 *       961446755 *
*       16 *          280520 *        92003001 *             247 *      1443465171 *       857116290 *
*       17 *          280520 *        91995043 *             247 *      1443465171 *       680937995 *
*       18 *          280520 *        91960858 *             247 *      1443465170 *       927369860 *
*       19 *          280520 *        92023980 *             247 *      1443465172 *       317407625 *
*       20 *          280520 *        91963579 *             247 *      1443465170 *       984031840 *
*       21 *          280520 *        91955523 *             247 *      1443465170 *       807983690 *
```

In the range near LBN=247,

```
Event Veto ['NoiseBurst'], Mon Sep 28 18:32:12 2015 UTC-Mon Sep 28 18:32:12 2015 UTC (0.050 )  Run 280520, LB 245 (1443465132446770688.000000,1443465132396770048.000000)
Event Veto ['NoiseBurst'], Mon Sep 28 18:40:46 2015 UTC-Mon Sep 28 18:40:46 2015 UTC (0.050 )  Run 280520, LB 257 (1443465646495336960.000000,1443465646445062656.000000)
```

The time stamp for the LB245 entry is is 1443465132446770688 in ns = 1443465132 + (10^-9 *
446770688) seconds (for example). Each LB is 60 seconds in this run (I
assume, since that is what was typically set in run control) so that LB 247 should be about 120 seconds beyond LB 245. Indeed, one of the events

```
*        5 *          280520 *        91958122 *             247 *      1443465170 *       865364525 *
```

is 37.55 seconds ahead of the start of the burst.

## Thus, I need:

1. a list of the 90 TLA runs in 2015
2. to run showEventVeto.py for each of the 90 TLA runs in 2015, making a table like the above
3. some code that provides function whose input is an xAOD EventInfo header and whose output is whether or not the timestamp lies within a NoiseBurst window.

### 1

```
dq2-ls "data15_13TeV.00*.calibration_DataScouting_05_Jets.merge.AOD.r7370_p2424/" | grep "^data15" > list-2015-datasets
cat list-2015-datasets.txt | awk -F'.' '{printf("%d\n",$2)}' | sort -n > list-2015-runnumbers.txt
wc list-2015-runnumbers.txt 
> 90      90     630 list-2015-runnumbers.txt
```

### 2

```
cp list-2015-runnumbers.txt /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/dump/LArDBTools/python/
cd /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/dump/LArDBTools/python
for runno in `cat list-2015-runnumbers.txt`
do
python showEventVeto.py -r $runno -e $runno >& event-veto-$runno.txt
done
```
makes my input text files. These total of 1.6MB (lots of wasted repetition) which compress (bz2) to 179KB.

### 3

Lookup should be, in this order:

- list of ranges to be compared

- in a map keyed by LB number

- in a map keyed by run number

Since each lumiblock is 60 seconds, there are a finite number of noise bursts in a LB. How long is the typical noise burst? How many noise bursts are there per lumiblock, at most?

```
grep 'noisy periods, covering a total of' event-veto-2*.txt | awk '{if($5>0){print $12/$5; }}' | sort -n
>0.05
>0.05
>0.05
>0.05
>0.05
>0.05
>0.05
>0.05
>0.05
>0.05
>0.05
>0.05
>0.05
>0.05
>0.05
>0.050099
>0.0505714
>0.0506762
>0.0507143
>0.051
>0.0513043
>0.0513333
>0.0515385
>0.0518182
>0.0518234
>0.0519149
>0.051933
>0.052
>0.052
>0.0521739
>0.0522581
>0.0522807
>0.0522997
>0.0523404
>0.0523636
>0.0523729
>0.0524444
>0.0525
>0.0525
>0.0525
>0.0525434
>0.0525974
>0.0528283
>0.0529412
>0.0530104
>0.053057
>0.05325
>0.0533333
>0.0535714
>0.0536364
>0.0537037
>0.0538095
>0.0538182
>0.0538462
>0.0539407
>0.0539844
>0.0539855
>0.0541113
>0.0541243
>0.0542759
>0.0547368
>0.0554412
>0.0555629
>0.0558209
>0.0558333
>0.0560714
>0.0565217
>0.0571429
>0.058
>0.0584091
>0.0585714
>0.0588189
>0.0590476
>0.0604348
>0.0627273
>0.0666667
>0.0792857
>0.12
>0.123143
>0.16129
>0.177368
>0.179091
>0.461111
>0.628889
>0.708
```
therefore in this dataset a single noise burst / data corruption interval  is at least 50 ms long, and at most about 700 ms.

What is the maximum number of intervals per event?

```
# print run number and LB, count number of times each combination appears to get number of intervals per LBN&run, and then histogram this number of intervals
grep '^Event Veto' event-veto-*.txt | awk '{print $18,$20}' | sort -n | uniq -c | sort -n -k 1 | awk '{print $1}' | uniq -c
>4458 1
> 950 2
> 212 3
>  90 4
>  31 5
>  18 6
>  13 7
>   2 9
>   1 10
>   1 12
>   1 17
```

i.e. the maximum number is 17. there are 4458 LBNs which have only 1
interval, 950 LBNs which have two intervals (noise bursts, data
corruption events), etc. Thus 97% of all LBNs have no more than 3
intervals to test. Maybe just ordering the ranges by starting
timestamp and going through them one by one is good enough?  (update:
in the above there are some LB ranges "x-y" which are being counted as
a single unique LB distinct from x or y)

How many LBNs per run with at least one veto interval?

```
grep '^Event Veto' event-veto-*.txt | awk '{print $18,$20}' | sort -n | uniq | awk -F',' '{print $1}' | sort -n | uniq -c | awk '{printf("%4d\n",$1)}' | sort -n | uniq -c | awk 'BEGIN{sum=0;} {sum+=$1; printf("%10f\t%s\n",(sum/86.),$0)}'
  0.046512	   4    1
  0.069767	   2    2
  0.093023	   2    3
  0.116279	   2    5
  0.139535	   2    6
  0.162791	   2    7
  0.174419	   1   10
  0.209302	   3   11
  0.220930	   1   13
  0.255814	   3   15
  0.290698	   3   18
  0.325581	   3   19
  0.337209	   1   20
  0.348837	   1   21
  0.360465	   1   22
  0.372093	   1   23
  0.406977	   3   24
  0.418605	   1   25
  0.430233	   1   26
  0.441860	   1   27
  0.465116	   2   28
  0.476744	   1   33
  0.488372	   1   34
  0.500000	   1   35
  0.523256	   2   39
  0.546512	   2   40
  0.558140	   1   41
  0.581395	   2   42
  0.593023	   1   44
  0.604651	   1   46
  0.616279	   1   47
  0.627907	   1   48
  0.639535	   1   50
  0.651163	   1   51
  0.662791	   1   63
  0.674419	   1   64
  0.686047	   1   65
  0.697674	   1   68
  0.709302	   1   69
  0.732558	   2   75
  0.744186	   1   89
  0.755814	   1   95
  0.767442	   1   96
  0.779070	   1   98
  0.790698	   1  104
  0.802326	   1  106
  0.825581	   2  108
  0.837209	   1  109
  0.848837	   1  115
  0.860465	   1  121
  0.872093	   1  134
  0.883721	   1  161
  0.895349	   1  164
  0.906977	   1  183
  0.918605	   1  216
  0.930233	   1  218
  0.941860	   1  222
  0.953488	   1  231
  0.965116	   1  261
  0.976744	   1  322
  0.988372	   1  397
  1.000000	   1  415
```

i.e. 4 runs have only one LBN with a veto interval, 1 run has 415 veto
intervals, etc. But 20% of runs have over 104 LBNs to check...
(update: again, in the above there are some LB ranges "x-y" which are
being counted as a single unique LB distinct from x or y)

What is the largest LBN that could possibly hit a veto interval?

```
grep '^Event Veto' event-veto-*.txt | awk '{print $20}' | sort -n | uniq | tail -n 1
> 1539
```
=> 11 bits


Worst case, we're going to execute this veto interval check on every
one of 2 10^9 events. If it takes 10 ms, that's an additional 5556
CPU-hours! (We probably won't check the veto interval until later in
the cutflow, but clearly we'll want the check to run quickly...)

Most events are

- going to be in a run with a veto interval, so our job is to find a
  pointer to the structure holding LBNs as quickly as possible. There
  are 90 runs to search.

- not going to be in a LBN with a veto interval. therefore we don't
  want to pay O(NvetoLBNs) to find out we're ok. 20% of runs
  have NvetoLBNs>~100 => bloom filter? nah, overkill. options:

    * std::set - lookup in log N

    * sorted std::vector - lookup in log N, better memory usage
      (lookup with std::lower_bound)
    
    * std::unordred_set - lookup on average O(1), worst case O(N).

- if in a LBN with a veto interval (which is probably 50-60ms), not
  going to be in the interval (0.06/60 = 0.001% chance), so we'll pay
  O(Nintervals), but Nintervals is small, so that constant time
  overhead is the bottleneck.


Therefore we would want to optimize, in this order

- determining that an LBN does not have a veto interval, as quickly as possible

- looking up the veto LBN table for a given run

- determining that a timestamp is not in a veto interval, as quickly as possible.
  we only need bother with accessing the timestamp at this last step.

## profiling results

I implemented the data structures as just a dumb lookup:

    map< run , map< lbn , vector<intervals> >

Lookup of random input data in the input domain takes 92 microseconds
per lookup. This is hardly worth optimizing. In addition, I was barely
right about the bottleneck: a slim majority, 51%, of the time is
indeed spent in LBN lookup. Neverthless the run number lookup accounts
for almost the same amount of time (44%). Since the run number
infrequently/never changes within a job, we can cache this lookup and
save a factor of ~2.

Implemented => if run number never changes, lookup drops to 32
microseconds per event (LBN lookup is now 83% of the CPU). At this cost,
2 billion events => ~17 CPU-hours during ntupling of the whole dataset. Not worthwhile?

Things that could be improved:

- optimize LBN lookup

- reduce disk size of showEventVeto text files (bzip2-compress and
  read them compressed)


# Notes on 2016 development [notes2016]

Because 2016 is another year, let's carefully check whether the tool
still works. Pavol Strizenec wrote some documentation of the 2016
calibration procedures
here:
[https://twiki.cern.ch/twiki/bin/view/AtlasComputing/LArDatabaseUpdateHowTo](AtlasComputing/LArDatabaseUpdateHowTo).

I also retrieved the LArDBTools from

```
/afs/cern.ch/user/l/larcalib/LArDBTools
```

and examined the differences between it and the code I used in 2015.

There are some interesting ones:

- there are now 'mini noise bursts'

- ```LARBadChannelsOflEventVeto-RUN2-UPD1-00``` instead of ```LARBadChannelsOflEventVeto-RUN2-UPD4-04```

- in fillEventVetoFolder.py,
  ```noiseRangesEECC=buildFilteredRange(allNoise,2,0.2,noiseWord,1);``` becomes ```noiseRangesEECC=buildFilteredRange(allNoise,2,0.05,noiseWord,1);``` and elsewhere ```window``` changes similarly from 0.2 s to 0.05 s


and some routine ones

- Athena ```20.7.5.2``` instead of ```20.1.4.8```

From the above twiki, 

> The Event Veto folder is now updated for noise bursts by application
> running online. The cron job running the script for data corruption
> and MiniNoise burst EventVeto, should send an email, in case some
> corruption periods were found. In such case the produced sqlite file
> and/or log should be inspected and uploaded in case everything looks
> fine.

> Because of online application for MiniNoise bursts is not fully
> debugged yet, it is recommended to run the EventVeto hunting script
> for every collisions run. It has to be updated for the bulk
> processing based on the result of the express processing. So this
> step has to be done before the 48h calibration loop expires and
> after the merged DQ Monitoring histogram files from the express
> processing have arrived on eos. In case of many MinINoise bursts, a
> second processing of CosmicCalo could be asked, after uploading the
> EvenVeto from first processing.

> We have currently three cronjob daemons running, trying to extract
> the EventVeto immediatelly (sic), once the files are available:

> - one looking to a data corruption only, it produces the sqlite
>   files with name: EventVeto<run>.db, usually not used currently

> - second one is looking for Noise and data corruption, produces the
>   files with name: EventVeto<run>_Noise_CORR_CosmicCalo.db

> - third one is looking for MNB and data corruption,it is reading
>   also the express_express files, and produces the file with name:
>   EventVeto<run>_MNB_CORR.db

## Mini-noise bursts

Prior to 2016, time intervals were flagged to veto as LAr "noise
bursts" (NB) when calibration processing identified coherent noise in
the EM endcap (EMEC) affecting multiple front-end boards (FEBs). In
2016, LAr began also flagged time intervals as "mini noise bursts"
(MNB) when coherent noise was identified in specific isolated FEBs in
the EM barrel (EMB). For an overview of the LAr changes in 2016, see
Steffan
Starz's
[talk](https://indico.cern.ch/event/402291/contributions/2294963/attachments/1356441/2050446/2016_10_ATLAS_week_LAr_status_report.pdf),
at the ATLAS Week in October 2016,
and
[this talk](https://indico.cern.ch/event/569856/contributions/2311894/attachments/1345622/2029979/20160929_MLB_MNBStudies.pdf) on
mini-noise bursts
and
[this overview](https://indico.cern.ch/event/569856/contributions/2304541/attachments/1345345/2028137/20160929-LArWeekPlenary.pdf) at
the ATLAS LAr Week in September 2016.

The algorithm to identify MNBs began as an offline algorithm during
2016 commissioning, and began running online on the LArNoiseBurst
stream as of run 306384.


 
## Hasty first attempt

On the afternoon before Thanksgiving, I glanced through the diffs
above, copied what seemed to be the mini-noise-burst changes in
```showEventVeto.py```, and ran the ```makeEventVetoLists.sh``` script
for all of the 2016 runs. Will Kalderon passed this data into my
TLAEventCleaning reader and compared to the offline LArError flag for
physics_Main data
in
[this talk](https://indico.cern.ch/event/591250/contributions/2386293/attachments/1379515/2096484/2016.11.29_TLA_weekly.pdf). He
found that, for 1/3 of Run 304006, the tool failed to flag 98.2% of
Time Veto events. So something is drastically wrong. (It did not flag
any events bad that were ok, so its performance could have been
worse!)

## Thoughtful attempt

I've patched the TLA dumping code to match the LArDBTools currently on AFS, which use

```
    source /afs/cern.ch/atlas/software/dist/AtlasSetup/scripts/asetup.sh 20.7.5.2
```

The 'hasty' attempt only included a partial patch of the
showEventVeto.py, with the wrong output format. This attempt fixed the
output format and included the changes to the other python code in the
package. The result: the output now contains mini noise bursts as
of Run 306310, which was recorded on 14 August. 

Using the hasty-attempt output, Will checked a run prior to this run. So we have two questions

- does the output that includes mini noise bursts (and has been
  reformatted) agree with the offline LAr veto more than 1.8% of the time?
  
- what about runs < 306310? The LAr Week talks state that the MNB
  algorithm ran throughout 2016, but prior to 306310 it ran offline
  and somehow fed into the bulk processing. Where is the output of
  that offline run?
  


# Appendix

## locations of the AFS LAr DB python tools and some other COOL tools

```
/afs/cern.ch/user/l/larcalib/LArDBTools
LArCalorimeter/​LArMonitoring/​python/​MiscLibraries/​MyCOOLlib.py
LArCalorimeter/​LArBadChannelTool/​LArBadChannelTool/​LArBadChannelDBTools.h
```
## given a good run list XML, scrape run numbers to a text file with

```less data15_13TeV.periodAllYear_DetStatus-v67-pro19-02_DQDefects-00-01-02_PHYS_StandardGRL_All_Good.xml | grep '<Run>' | awk -F'>' '{print $2}' | awk -F'<' '{print $1}' > goodruns.txt```


