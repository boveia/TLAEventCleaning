#-- start of make_header -----------------

#====================================
#  Document install_python_modules
#
#   Generated Wed Dec 16 17:21:42 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_install_python_modules_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_install_python_modules_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_install_python_modules

LArCellRec_tag = $(tag)

#cmt_local_tagfile_install_python_modules = $(LArCellRec_tag)_install_python_modules.make
cmt_local_tagfile_install_python_modules = $(bin)$(LArCellRec_tag)_install_python_modules.make

else

tags      = $(tag),$(CMTEXTRATAGS)

LArCellRec_tag = $(tag)

#cmt_local_tagfile_install_python_modules = $(LArCellRec_tag).make
cmt_local_tagfile_install_python_modules = $(bin)$(LArCellRec_tag).make

endif

include $(cmt_local_tagfile_install_python_modules)
#-include $(cmt_local_tagfile_install_python_modules)

ifdef cmt_install_python_modules_has_target_tag

cmt_final_setup_install_python_modules = $(bin)setup_install_python_modules.make
cmt_dependencies_in_install_python_modules = $(bin)dependencies_install_python_modules.in
#cmt_final_setup_install_python_modules = $(bin)LArCellRec_install_python_modulessetup.make
cmt_local_install_python_modules_makefile = $(bin)install_python_modules.make

else

cmt_final_setup_install_python_modules = $(bin)setup.make
cmt_dependencies_in_install_python_modules = $(bin)dependencies.in
#cmt_final_setup_install_python_modules = $(bin)LArCellRecsetup.make
cmt_local_install_python_modules_makefile = $(bin)install_python_modules.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)LArCellRecsetup.make

#install_python_modules :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'install_python_modules'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = install_python_modules/
#install_python_modules::
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

install_dir = ${installarea}/python/LArCellRec

install_python_modules :: install_python_modulesinstall ;

install :: install_python_modulesinstall ;

install_python_modulesclean :: install_python_modulesuninstall

uninstall :: install_python_modulesuninstall


# This is to avoid error in case there are no files to install
# Ideally, the fragment should not be used without files to install,
# and this line should be dropped then
install_python_modulesinstall :: ;

LArCollisionTimeGetter_py_dependencies = ../python/LArCollisionTimeGetter.py
LArCellDeadOTXCorrToolDefault_py_dependencies = ../python/LArCellDeadOTXCorrToolDefault.py
LArNoisyROFlags_py_dependencies = ../python/LArNoisyROFlags.py
LArNoisyROSummaryGetter_py_dependencies = ../python/LArNoisyROSummaryGetter.py
LArCellHVCorrDefault_py_dependencies = ../python/LArCellHVCorrDefault.py


install_python_modulesinstall :: ${install_dir}/LArCollisionTimeGetter.py ;

${install_dir}/LArCollisionTimeGetter.py :: ../python/LArCollisionTimeGetter.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../python/LArCollisionTimeGetter.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArCollisionTimeGetter.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../python/LArCollisionTimeGetter.py : ;

install_python_modulesuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../python/LArCollisionTimeGetter.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArCollisionTimeGetter.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_python_modulesinstall :: ${install_dir}/LArCellDeadOTXCorrToolDefault.py ;

${install_dir}/LArCellDeadOTXCorrToolDefault.py :: ../python/LArCellDeadOTXCorrToolDefault.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../python/LArCellDeadOTXCorrToolDefault.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArCellDeadOTXCorrToolDefault.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../python/LArCellDeadOTXCorrToolDefault.py : ;

install_python_modulesuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../python/LArCellDeadOTXCorrToolDefault.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArCellDeadOTXCorrToolDefault.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_python_modulesinstall :: ${install_dir}/LArNoisyROFlags.py ;

${install_dir}/LArNoisyROFlags.py :: ../python/LArNoisyROFlags.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../python/LArNoisyROFlags.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArNoisyROFlags.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../python/LArNoisyROFlags.py : ;

install_python_modulesuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../python/LArNoisyROFlags.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArNoisyROFlags.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_python_modulesinstall :: ${install_dir}/LArNoisyROSummaryGetter.py ;

${install_dir}/LArNoisyROSummaryGetter.py :: ../python/LArNoisyROSummaryGetter.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../python/LArNoisyROSummaryGetter.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArNoisyROSummaryGetter.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../python/LArNoisyROSummaryGetter.py : ;

install_python_modulesuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../python/LArNoisyROSummaryGetter.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArNoisyROSummaryGetter.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi


install_python_modulesinstall :: ${install_dir}/LArCellHVCorrDefault.py ;

${install_dir}/LArCellHVCorrDefault.py :: ../python/LArCellHVCorrDefault.py
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../python/LArCellHVCorrDefault.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$${d}" "LArCellHVCorrDefault.py" "$(install_dir)" "/cvmfs/atlas.cern.ch/repo/sw/software/x86_64-slc6-gcc48-opt/20.1.8/AtlasCore/20.1.8/External/ExternalPolicy/src/symlink.sh" "$($(package)_cmtpath)"; \
	fi

../python/LArCellHVCorrDefault.py : ;

install_python_modulesuninstall ::
	@if test ! "${installarea}" = ""; then \
	  d=`dirname ../python/LArCellHVCorrDefault.py`; \
	  d=`(cd $${d}; pwd)`; \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$${d}" "LArCellHVCorrDefault.py" "$(install_dir)" "$($(package)_cmtpath)"; \
	fi
#-- start of cleanup_header --------------

clean :: install_python_modulesclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(install_python_modules.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

install_python_modulesclean ::
#-- end of cleanup_header ---------------
