#-- start of make_header -----------------

#====================================
#  Document LArCellRecCLIDDB
#
#   Generated Wed Dec 16 17:28:50 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_LArCellRecCLIDDB_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_LArCellRecCLIDDB_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_LArCellRecCLIDDB

LArCellRec_tag = $(tag)

#cmt_local_tagfile_LArCellRecCLIDDB = $(LArCellRec_tag)_LArCellRecCLIDDB.make
cmt_local_tagfile_LArCellRecCLIDDB = $(bin)$(LArCellRec_tag)_LArCellRecCLIDDB.make

else

tags      = $(tag),$(CMTEXTRATAGS)

LArCellRec_tag = $(tag)

#cmt_local_tagfile_LArCellRecCLIDDB = $(LArCellRec_tag).make
cmt_local_tagfile_LArCellRecCLIDDB = $(bin)$(LArCellRec_tag).make

endif

include $(cmt_local_tagfile_LArCellRecCLIDDB)
#-include $(cmt_local_tagfile_LArCellRecCLIDDB)

ifdef cmt_LArCellRecCLIDDB_has_target_tag

cmt_final_setup_LArCellRecCLIDDB = $(bin)setup_LArCellRecCLIDDB.make
cmt_dependencies_in_LArCellRecCLIDDB = $(bin)dependencies_LArCellRecCLIDDB.in
#cmt_final_setup_LArCellRecCLIDDB = $(bin)LArCellRec_LArCellRecCLIDDBsetup.make
cmt_local_LArCellRecCLIDDB_makefile = $(bin)LArCellRecCLIDDB.make

else

cmt_final_setup_LArCellRecCLIDDB = $(bin)setup.make
cmt_dependencies_in_LArCellRecCLIDDB = $(bin)dependencies.in
#cmt_final_setup_LArCellRecCLIDDB = $(bin)LArCellRecsetup.make
cmt_local_LArCellRecCLIDDB_makefile = $(bin)LArCellRecCLIDDB.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)LArCellRecsetup.make

#LArCellRecCLIDDB :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'LArCellRecCLIDDB'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = LArCellRecCLIDDB/
#LArCellRecCLIDDB::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# File: cmt/fragments/genCLIDDB_header
# Author: Paolo Calafiura
# derived from genconf_header

# Use genCLIDDB_cmd to create package clid.db files

.PHONY: LArCellRecCLIDDB LArCellRecCLIDDBclean

outname := clid.db
cliddb  := LArCellRec_$(outname)
instdir := $(CMTINSTALLAREA)/share
result  := $(instdir)/$(cliddb)
product := $(instdir)/$(outname)
conflib := $(bin)$(library_prefix)LArCellRec.$(shlibsuffix)

LArCellRecCLIDDB :: $(result)

$(instdir) :
	$(mkdir) -p $(instdir)

$(result) : $(conflib) $(product)
	@$(genCLIDDB_cmd) -p LArCellRec -i$(product) -o $(result)

$(product) : $(instdir)
	touch $(product)

LArCellRecCLIDDBclean ::
	$(cleanup_silent) $(uninstall_command) $(product) $(result)
	$(cleanup_silent) $(cmt_uninstallarea_command) $(product) $(result)

#-- start of cleanup_header --------------

clean :: LArCellRecCLIDDBclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(LArCellRecCLIDDB.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

LArCellRecCLIDDBclean ::
#-- end of cleanup_header ---------------
