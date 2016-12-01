# echo "setup LArBadChannelTool LArBadChannelTool-00-00-77 in /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter"

if test "${CMTROOT}" = ""; then
  CMTROOT=/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/CMT/v1r25p20140131; export CMTROOT
fi
. ${CMTROOT}/mgr/setup.sh
cmtLArBadChannelTooltempfile=`${CMTROOT}/${CMTBIN}/cmt.exe -quiet build temporary_name`
if test ! $? = 0 ; then cmtLArBadChannelTooltempfile=/tmp/cmt.$$; fi
${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=LArBadChannelTool -version=LArBadChannelTool-00-00-77 -path=/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter  -quiet -without_version_directory -no_cleanup $* >${cmtLArBadChannelTooltempfile}
if test $? != 0 ; then
  echo >&2 "${CMTROOT}/${CMTBIN}/cmt.exe setup -sh -pack=LArBadChannelTool -version=LArBadChannelTool-00-00-77 -path=/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter  -quiet -without_version_directory -no_cleanup $* >${cmtLArBadChannelTooltempfile}"
  cmtsetupstatus=2
  /bin/rm -f ${cmtLArBadChannelTooltempfile}
  unset cmtLArBadChannelTooltempfile
  return $cmtsetupstatus
fi
cmtsetupstatus=0
. ${cmtLArBadChannelTooltempfile}
if test $? != 0 ; then
  cmtsetupstatus=2
fi
/bin/rm -f ${cmtLArBadChannelTooltempfile}
unset cmtLArBadChannelTooltempfile
return $cmtsetupstatus

