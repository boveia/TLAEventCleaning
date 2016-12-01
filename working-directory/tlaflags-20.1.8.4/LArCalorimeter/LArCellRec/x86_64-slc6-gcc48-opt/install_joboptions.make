#-- start of make_header -----------------

#====================================
#  Document install_joboptions
#
#   Generated Wed Dec 16 17:21:41 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_install_joboptions_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_install_joboptions_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_install_joboptions

LArCellRec_tag = $(tag)

#cmt_local_tagfile_install_joboptions = $(LArCellRec_tag)_install_joboptions.make
cmt_local_tagfile_install_joboptions = $(bin)$(LArCellRec_tag)_install_joboptions.make

else

tags      = $(tag),$(CMTEXTRATAGS)

LArCellRec_tag = $(tag)

#cmt_local_tagfile_install_joboptions = $(LArCellRec_tag).make
cmt_local_tagfile_install_joboptions = $(bin)$(LArCellRec_tag).make

endif

include $(cmt_local_tagfile_install_joboptions)
#-include $(cmt_local_tagfile_install_joboptions)

ifdef cmt_install_joboptions_has_target_tag

cmt_final_setup_install_joboptions = $(bin)setup_install_joboptions.make
cmt_dependencies_in_install_joboptions = $(bin)dependencies_install_joboptions.in
#cmt_final_setup_install_joboptions = $(bin)LArCellRec_install_joboptionssetup.make
cmt_local_install_joboptions_makefile = $(bin)install_joboptions.make

else

cmt_final_setup_install_joboptions = $(bin)setup.make
cmt_dependencies_in_install_joboptions = $(bin)dependencies.in
#cmt_final_setup_install_joboptions = $(bin)LArCellRecsetup.make
cmt_local_install_joboptions_makefile = $(bin)install_joboptions.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)LArCellRecsetup.make

#install_joboptions :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'install_joboptions'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = install_joboptions/
#install_joboptions::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------


ifeq ($(INSTALLAREA),)
installarea = $(CMTINSTALLAREA)
else
ifeq ($(findstring `,$(INSTALLAREA)),`)
installarea = $(shell $(subst `,, $(INSTALLAREA)))
else
installarea = $(INSTALLAREA)
endif
endif

install_dir = ${installarea}/jobOptions/LArCellRec

install_joboptions :: install_joboptionsinstall ;

install :: install_joboptionsinstall ;

install_joboptionsclean :: install_joboptionsuninstall

uninstall :: install_joboptionsuninstall


# This is to avoid error in case there are no files to install
# Ideally, the fragment should not be used without files to install,
# and this line should be dropped then
install_joboptionsinstall :: ;

LArCell_jobOptions_py_dependencies = ../share/LArCell_jobOptions.py
LArCellTest_jobOptions_py_dependencies = ../share/LArCellTest_jobOptions.py
LArTimeVetoAlg_jobOptions_py_dependencies = ../share/LArTimeVetoAlg_jobOptions.py
LArCellFromLArRawTool_MC_jobOptions_py_dependencies = ../share/LArCellFromLArRawTool_MC_jobOptions.py
LArCellFromLArHitTool_MC_jobOptions_py_dependencies = ../share/LArCellFromLArHitTool_MC_jobOptions.py
LArCellMakerTool_jobOptions_py_dependencies = ../share/LArCellMakerTool_jobOptions.py
LArCellIDC_Test_jobOptions_py_dependencies = ../share/LArCellIDC_Test_jobOptions.py
LArCellFromLArRawTool_H6_jobOptions_py_dependencies = ../share/LArCellFromLArRawTool_H6_jobOptions.py
LArCellFromLArRawTool_MCG4_jobOptions_py_dependencies = ../share/LArCellFromLArRawTool_MCG4_jobOptions.py
LArCellRec_test_jobOptions_py_dependencies = ../share/LArCellRec_test_jobOptions.py
LArCollisionTime_jobOptions_py_dependencies = ../share/LArCollisionTime_jobOptions.py


install_joboptionsinstall :: ${install_dir}/LArCell_jobOptions.py ;

${install_dir}/LArCell_jobOptions.py :: ../share/LArCell_jobOptions.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCell_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArCell_jobOptions.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../share/LArCell_jobOptions.py : ;

install_joboptionsuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCell_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArCell_jobOptions.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_joboptionsinstall :: ${install_dir}/LArCellTest_jobOptions.py ;

${install_dir}/LArCellTest_jobOptions.py :: ../share/LArCellTest_jobOptions.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellTest_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArCellTest_jobOptions.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../share/LArCellTest_jobOptions.py : ;

install_joboptionsuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellTest_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArCellTest_jobOptions.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_joboptionsinstall :: ${install_dir}/LArTimeVetoAlg_jobOptions.py ;

${install_dir}/LArTimeVetoAlg_jobOptions.py :: ../share/LArTimeVetoAlg_jobOptions.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArTimeVetoAlg_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArTimeVetoAlg_jobOptions.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../share/LArTimeVetoAlg_jobOptions.py : ;

install_joboptionsuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArTimeVetoAlg_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArTimeVetoAlg_jobOptions.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_joboptionsinstall :: ${install_dir}/LArCellFromLArRawTool_MC_jobOptions.py ;

${install_dir}/LArCellFromLArRawTool_MC_jobOptions.py :: ../share/LArCellFromLArRawTool_MC_jobOptions.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellFromLArRawTool_MC_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArCellFromLArRawTool_MC_jobOptions.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../share/LArCellFromLArRawTool_MC_jobOptions.py : ;

install_joboptionsuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellFromLArRawTool_MC_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArCellFromLArRawTool_MC_jobOptions.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_joboptionsinstall :: ${install_dir}/LArCellFromLArHitTool_MC_jobOptions.py ;

${install_dir}/LArCellFromLArHitTool_MC_jobOptions.py :: ../share/LArCellFromLArHitTool_MC_jobOptions.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellFromLArHitTool_MC_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArCellFromLArHitTool_MC_jobOptions.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../share/LArCellFromLArHitTool_MC_jobOptions.py : ;

install_joboptionsuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellFromLArHitTool_MC_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArCellFromLArHitTool_MC_jobOptions.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_joboptionsinstall :: ${install_dir}/LArCellMakerTool_jobOptions.py ;

${install_dir}/LArCellMakerTool_jobOptions.py :: ../share/LArCellMakerTool_jobOptions.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellMakerTool_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArCellMakerTool_jobOptions.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../share/LArCellMakerTool_jobOptions.py : ;

install_joboptionsuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellMakerTool_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArCellMakerTool_jobOptions.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_joboptionsinstall :: ${install_dir}/LArCellIDC_Test_jobOptions.py ;

${install_dir}/LArCellIDC_Test_jobOptions.py :: ../share/LArCellIDC_Test_jobOptions.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellIDC_Test_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArCellIDC_Test_jobOptions.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../share/LArCellIDC_Test_jobOptions.py : ;

install_joboptionsuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellIDC_Test_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArCellIDC_Test_jobOptions.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_joboptionsinstall :: ${install_dir}/LArCellFromLArRawTool_H6_jobOptions.py ;

${install_dir}/LArCellFromLArRawTool_H6_jobOptions.py :: ../share/LArCellFromLArRawTool_H6_jobOptions.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellFromLArRawTool_H6_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArCellFromLArRawTool_H6_jobOptions.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../share/LArCellFromLArRawTool_H6_jobOptions.py : ;

install_joboptionsuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellFromLArRawTool_H6_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArCellFromLArRawTool_H6_jobOptions.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_joboptionsinstall :: ${install_dir}/LArCellFromLArRawTool_MCG4_jobOptions.py ;

${install_dir}/LArCellFromLArRawTool_MCG4_jobOptions.py :: ../share/LArCellFromLArRawTool_MCG4_jobOptions.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellFromLArRawTool_MCG4_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArCellFromLArRawTool_MCG4_jobOptions.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../share/LArCellFromLArRawTool_MCG4_jobOptions.py : ;

install_joboptionsuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellFromLArRawTool_MCG4_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArCellFromLArRawTool_MCG4_jobOptions.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_joboptionsinstall :: ${install_dir}/LArCellRec_test_jobOptions.py ;

${install_dir}/LArCellRec_test_jobOptions.py :: ../share/LArCellRec_test_jobOptions.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellRec_test_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArCellRec_test_jobOptions.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../share/LArCellRec_test_jobOptions.py : ;

install_joboptionsuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCellRec_test_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArCellRec_test_jobOptions.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_joboptionsinstall :: ${install_dir}/LArCollisionTime_jobOptions.py ;

${install_dir}/LArCollisionTime_jobOptions.py :: ../share/LArCollisionTime_jobOptions.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCollisionTime_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArCollisionTime_jobOptions.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../share/LArCollisionTime_jobOptions.py : ;

install_joboptionsuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../share/LArCollisionTime_jobOptions.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArCollisionTime_jobOptions.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi
#-- start of cleanup_header --------------

clean :: install_joboptionsclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(install_joboptions.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

install_joboptionsclean ::
#-- end of cleanup_header ---------------
