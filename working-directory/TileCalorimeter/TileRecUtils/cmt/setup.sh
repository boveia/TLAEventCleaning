# echo "setup TileRecUtils TileRecUtils-00-09-47 in /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/CMT/v1r25p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtTileRecUtilstempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtTileRecUtilstempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=TileRecUtils -version=TileRecUtils-00-09-47 -path=/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter  -no_cleanup $* >${cmtTileRecUtilstempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=TileRecUtils -version=TileRecUtils-00-09-47 -path=/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter  -no_cleanup $* >${cmtTileRecUtilstempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtTileRecUtilstempfile}
  unset cmtTileRecUtilstempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtTileRecUtilstempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtTileRecUtilstempfile}
unset cmtTileRecUtilstempfile
return $cmtsetupstatus

