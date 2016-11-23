# echo "cleanup LArCellRec LArCellRec-02-12-94-03 in /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/CMT/v1r25p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtLArCellRectempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtLArCellRectempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=LArCellRec -version=LArCellRec-02-12-94-03 -path=/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter  $* >${cmtLArCellRectempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=LArCellRec -version=LArCellRec-02-12-94-03 -path=/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter  $* >${cmtLArCellRectempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtLArCellRectempfile}
  unset cmtLArCellRectempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtLArCellRectempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtLArCellRectempfile}
unset cmtLArCellRectempfile
exit $cmtcleanupstatus

