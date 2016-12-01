#-- start of make_header -----------------

#====================================
#  Document check_install_joboptions
#
#   Generated Wed Dec 16 17:21:27 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_check_install_joboptions_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_check_install_joboptions_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_check_install_joboptions

LArCellRec_tag = $(tag)

#cmt_local_tagfile_check_install_joboptions = $(LArCellRec_tag)_check_install_joboptions.make
cmt_local_tagfile_check_install_joboptions = $(bin)$(LArCellRec_tag)_check_install_joboptions.make

else

tags      = $(tag),$(CMTEXTRATAGS)

LArCellRec_tag = $(tag)

#cmt_local_tagfile_check_install_joboptions = $(LArCellRec_tag).make
cmt_local_tagfile_check_install_joboptions = $(bin)$(LArCellRec_tag).make

endif

include $(cmt_local_tagfile_check_install_joboptions)
#-include $(cmt_local_tagfile_check_install_joboptions)

ifdef cmt_check_install_joboptions_has_target_tag

cmt_final_setup_check_install_joboptions = $(bin)setup_check_install_joboptions.make
cmt_dependencies_in_check_install_joboptions = $(bin)dependencies_check_install_joboptions.in
#cmt_final_setup_check_install_joboptions = $(bin)LArCellRec_check_install_joboptionssetup.make
cmt_local_check_install_joboptions_makefile = $(bin)check_install_joboptions.make

else

cmt_final_setup_check_install_joboptions = $(bin)setup.make
cmt_dependencies_in_check_install_joboptions = $(bin)dependencies.in
#cmt_final_setup_check_install_joboptions = $(bin)LArCellRecsetup.make
cmt_local_check_install_joboptions_makefile = $(bin)check_install_joboptions.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)LArCellRecsetup.make

#check_install_joboptions :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'check_install_joboptions'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = check_install_joboptions/
#check_install_joboptions::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of cmt_action_runner_header ---------------

ifdef ONCE
check_install_joboptions_once = 1
endif

ifdef check_install_joboptions_once

check_install_joboptionsactionstamp = $(bin)check_install_joboptions.actionstamp
#check_install_joboptionsactionstamp = check_install_joboptions.actionstamp

check_install_joboptions :: $(check_install_joboptionsactionstamp)
	$(echo) "check_install_joboptions ok"
#	@echo check_install_joboptions ok

#$(check_install_joboptionsactionstamp) :: $(check_install_joboptions_dependencies)
$(check_install_joboptionsactionstamp) ::
	$(silent) /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/cmt/atlas_check_installations.sh -files=' -s=../share *.txt *.py ' -installdir=/afs/cern.ch/work/b/boveia/tlaflags-20.1.8.4/InstallArea/jobOptions/LArCellRec -level=
	$(silent) cat /dev/null > $(check_install_joboptionsactionstamp)
#	@echo ok > $(check_install_joboptionsactionstamp)

check_install_joboptionsclean ::
	$(cleanup_silent) /bin/rm -f $(check_install_joboptionsactionstamp)

else

#check_install_joboptions :: $(check_install_joboptions_dependencies)
check_install_joboptions ::
	$(silent) /cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/cmt/atlas_check_installations.sh -files=' -s=../share *.txt *.py ' -installdir=/afs/cern.ch/work/b/boveia/tlaflags-20.1.8.4/InstallArea/jobOptions/LArCellRec -level=

endif

install ::
uninstall ::

#-- end of cmt_action_runner_header -----------------
#-- start of cleanup_header --------------

clean :: check_install_joboptionsclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(check_install_joboptions.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

check_install_joboptionsclean ::
#-- end of cleanup_header ---------------
