# echo "cleanup LArCellRec LArCellRec-02-12-94-03 in /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/CMT/v1r25p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtLArCellRectempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtLArCellRectempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=LArCellRec -version=LArCellRec-02-12-94-03 -path=/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter  $* >${cmtLArCellRectempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -sh -pack=LArCellRec -version=LArCellRec-02-12-94-03 -path=/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter  $* >${cmtLArCellRectempfile}"
  cmtcleanupstatus=2
  /bin/rm -f ${cmtLArCellRectempfile}
  unset cmtLArCellRectempfile
  return $cmtcleanupstatus
fi
cmtcleanupstatus=0
. ${cmtLArCellRectempfile}
if test $? != 0 ; then
  cmtcleanupstatus=2
fi
/bin/rm -f ${cmtLArCellRectempfile}
unset cmtLArCellRectempfile
return $cmtcleanupstatus

