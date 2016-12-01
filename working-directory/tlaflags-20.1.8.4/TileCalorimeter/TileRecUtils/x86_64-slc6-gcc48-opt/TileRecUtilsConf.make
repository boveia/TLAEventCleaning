#-- start of make_header -----------------

#====================================
#  Document TileRecUtilsConf
#
#   Generated Wed Dec 16 17:55:45 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_TileRecUtilsConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TileRecUtilsConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_TileRecUtilsConf

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtilsConf = $(TileRecUtils_tag)_TileRecUtilsConf.make
cmt_local_tagfile_TileRecUtilsConf = $(bin)$(TileRecUtils_tag)_TileRecUtilsConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtilsConf = $(TileRecUtils_tag).make
cmt_local_tagfile_TileRecUtilsConf = $(bin)$(TileRecUtils_tag).make

endif

include $(cmt_local_tagfile_TileRecUtilsConf)
#-include $(cmt_local_tagfile_TileRecUtilsConf)

ifdef cmt_TileRecUtilsConf_has_target_tag

cmt_final_setup_TileRecUtilsConf = $(bin)setup_TileRecUtilsConf.make
cmt_dependencies_in_TileRecUtilsConf = $(bin)dependencies_TileRecUtilsConf.in
#cmt_final_setup_TileRecUtilsConf = $(bin)TileRecUtils_TileRecUtilsConfsetup.make
cmt_local_TileRecUtilsConf_makefile = $(bin)TileRecUtilsConf.make

else

cmt_final_setup_TileRecUtilsConf = $(bin)setup.make
cmt_dependencies_in_TileRecUtilsConf = $(bin)dependencies.in
#cmt_final_setup_TileRecUtilsConf = $(bin)TileRecUtilssetup.make
cmt_local_TileRecUtilsConf_makefile = $(bin)TileRecUtilsConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)TileRecUtilssetup.make

#TileRecUtilsConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'TileRecUtilsConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = TileRecUtilsConf/
#TileRecUtilsConf::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# File: cmt/fragments/genconfig_header
# Author: Wim Lavrijsen (WLavrijsen@lbl.gov)

# Use genconf.exe to create configurables python modules, then have the
# normal python install procedure take over.

.PHONY: TileRecUtilsConf TileRecUtilsConfclean

confpy  := TileRecUtilsConf.py
conflib := $(bin)$(library_prefix)TileRecUtils.$(shlibsuffix)
confdb  := TileRecUtils.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

TileRecUtilsConf :: TileRecUtilsConfinstall

install :: TileRecUtilsConfinstall

TileRecUtilsConfinstall : /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter/TileRecUtils/genConf/TileRecUtils/$(confpy)
	@echo "Installing /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter/TileRecUtils/genConf/TileRecUtils in /afs/cern.ch/work/b/boveia/tlaflags-20.1.8.4/InstallArea/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter/TileRecUtils/genConf/TileRecUtils /afs/cern.ch/work/b/boveia/tlaflags-20.1.8.4/InstallArea/python ; \

/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter/TileRecUtils/genConf/TileRecUtils/$(confpy) : $(conflib) /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter/TileRecUtils/genConf/TileRecUtils
	$(genconf_silent) $(genconfig_cmd)   -o /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter/TileRecUtils/genConf/TileRecUtils -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)TileRecUtils.$(shlibsuffix)

/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter/TileRecUtils/genConf/TileRecUtils:
	@ if [ ! -d /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter/TileRecUtils/genConf/TileRecUtils ] ; then mkdir -p /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter/TileRecUtils/genConf/TileRecUtils ; fi ;

TileRecUtilsConfclean :: TileRecUtilsConfuninstall
	$(cleanup_silent) $(remove_command) /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter/TileRecUtils/genConf/TileRecUtils/$(confpy) /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter/TileRecUtils/genConf/TileRecUtils/$(confdb)

uninstall :: TileRecUtilsConfuninstall

TileRecUtilsConfuninstall ::
	@$(uninstall_command) /afs/cern.ch/work/b/boveia/tlaflags-20.1.8.4/InstallArea/python
libTileRecUtils_so_dependencies = ../x86_64-slc6-gcc48-opt/libTileRecUtils.so
#-- start of cleanup_header --------------

clean :: TileRecUtilsConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(TileRecUtilsConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

TileRecUtilsConfclean ::
#-- end of cleanup_header ---------------
