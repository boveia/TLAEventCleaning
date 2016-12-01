# echo "cleanup LArBadChannelTool LArBadChannelTool-00-00-77 in /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter"

if ( $?CMTROOT == 0 ) then
  setenv CMTROOT /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/CMT/v1r25p20140131
endif
source ${CMTROOT}/mgr/setup.csh
set cmtLArBadChannelTooltempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if $status != 0 then
  set cmtLArBadChannelTooltempfile=/tmp/cmt.$$
endif
${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=LArBadChannelTool -version=LArBadChannelTool-00-00-77 -path=/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter  -quiet -without_version_directory $* >${cmtLArBadChannelTooltempfile}
if ( $status != 0 ) then
  echo "${CMTROOT}/${CMTBIN}/cmt.exe cleanup -csh -pack=LArBadChannelTool -version=LArBadChannelTool-00-00-77 -path=/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter  -quiet -without_version_directory $* >${cmtLArBadChannelTooltempfile}"
  set cmtcleanupstatus=2
  /bin/rm -f ${cmtLArBadChannelTooltempfile}
  unset cmtLArBadChannelTooltempfile
  exit $cmtcleanupstatus
endif
set cmtcleanupstatus=0
source ${cmtLArBadChannelTooltempfile}
if ( $status != 0 ) then
  set cmtcleanupstatus=2
endif
/bin/rm -f ${cmtLArBadChannelTooltempfile}
unset cmtLArBadChannelTooltempfile
exit $cmtcleanupstatus

