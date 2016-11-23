# echo "setup TileRecUtils TileRecUtils-00-09-47 in /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/CMT/v1r25p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtTileRecUtilstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtTileRecUtilstempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=TileRecUtils -version=TileRecUtils-00-09-47 -path=/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter  -no_cleanup $* >${cmtTileRecUtilstempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe setup -csh -pack=TileRecUtils -version=TileRecUtils-00-09-47 -path=/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter  -no_cleanup $* >${cmtTileRecUtilstempfile}"
  set cmtsetupstatus=2
  /bin/rm -f ${cmtTileRecUtilstempfile}
  unset cmtTileRecUtilstempfile
  exit $cmtsetupstatus
endif
set cmtsetupstatus=0
source ${cmtTileRecUtilstempfile}
if ( $status != 0 ) then
  set cmtsetupstatus=2
endif
/bin/rm -f ${cmtTileRecUtilstempfile}
unset cmtTileRecUtilstempfile
exit $cmtsetupstatus

