#-- start of make_header -----------------

#====================================
#  Document LArCellRecConf
#
#   Generated Wed Dec 16 17:28:53 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_LArCellRecConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_LArCellRecConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_LArCellRecConf

LArCellRec_tag = $(tag)

#cmt_local_tagfile_LArCellRecConf = $(LArCellRec_tag)_LArCellRecConf.make
cmt_local_tagfile_LArCellRecConf = $(bin)$(LArCellRec_tag)_LArCellRecConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

LArCellRec_tag = $(tag)

#cmt_local_tagfile_LArCellRecConf = $(LArCellRec_tag).make
cmt_local_tagfile_LArCellRecConf = $(bin)$(LArCellRec_tag).make

endif

include $(cmt_local_tagfile_LArCellRecConf)
#-include $(cmt_local_tagfile_LArCellRecConf)

ifdef cmt_LArCellRecConf_has_target_tag

cmt_final_setup_LArCellRecConf = $(bin)setup_LArCellRecConf.make
cmt_dependencies_in_LArCellRecConf = $(bin)dependencies_LArCellRecConf.in
#cmt_final_setup_LArCellRecConf = $(bin)LArCellRec_LArCellRecConfsetup.make
cmt_local_LArCellRecConf_makefile = $(bin)LArCellRecConf.make

else

cmt_final_setup_LArCellRecConf = $(bin)setup.make
cmt_dependencies_in_LArCellRecConf = $(bin)dependencies.in
#cmt_final_setup_LArCellRecConf = $(bin)LArCellRecsetup.make
cmt_local_LArCellRecConf_makefile = $(bin)LArCellRecConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)LArCellRecsetup.make

#LArCellRecConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'LArCellRecConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = LArCellRecConf/
#LArCellRecConf::
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

.PHONY: LArCellRecConf LArCellRecConfclean

confpy  := LArCellRecConf.py
conflib := $(bin)$(library_prefix)LArCellRec.$(shlibsuffix)
confdb  := LArCellRec.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

LArCellRecConf :: LArCellRecConfinstall

install :: LArCellRecConfinstall

LArCellRecConfinstall : /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter/LArCellRec/genConf/LArCellRec/$(confpy)
	@echo "Installing /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter/LArCellRec/genConf/LArCellRec in /afs/cern.ch/work/b/boveia/tlaflags-20.1.8.4/InstallArea/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter/LArCellRec/genConf/LArCellRec /afs/cern.ch/work/b/boveia/tlaflags-20.1.8.4/InstallArea/python ; \

/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter/LArCellRec/genConf/LArCellRec/$(confpy) : $(conflib) /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter/LArCellRec/genConf/LArCellRec
	$(genconf_silent) $(genconfig_cmd)   -o /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter/LArCellRec/genConf/LArCellRec -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)LArCellRec.$(shlibsuffix)

/afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter/LArCellRec/genConf/LArCellRec:
	@ if [ ! -d /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter/LArCellRec/genConf/LArCellRec ] ; then mkdir -p /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter/LArCellRec/genConf/LArCellRec ; fi ;

LArCellRecConfclean :: LArCellRecConfuninstall
	$(cleanup_silent) $(remove_command) /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter/LArCellRec/genConf/LArCellRec/$(confpy) /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter/LArCellRec/genConf/LArCellRec/$(confdb)

uninstall :: LArCellRecConfuninstall

LArCellRecConfuninstall ::
	@$(uninstall_command) /afs/cern.ch/work/b/boveia/tlaflags-20.1.8.4/InstallArea/python
libLArCellRec_so_dependencies = ../x86_64-slc6-gcc48-opt/libLArCellRec.so
#-- start of cleanup_header --------------

clean :: LArCellRecConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(LArCellRecConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

LArCellRecConfclean ::
#-- end of cleanup_header ---------------
