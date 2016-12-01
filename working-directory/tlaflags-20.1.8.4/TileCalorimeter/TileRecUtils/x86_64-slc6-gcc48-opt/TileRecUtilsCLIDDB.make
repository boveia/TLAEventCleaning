#-- start of make_header -----------------

#====================================
#  Document TileRecUtilsCLIDDB
#
#   Generated Wed Dec 16 17:55:49 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_TileRecUtilsCLIDDB_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TileRecUtilsCLIDDB_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_TileRecUtilsCLIDDB

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtilsCLIDDB = $(TileRecUtils_tag)_TileRecUtilsCLIDDB.make
cmt_local_tagfile_TileRecUtilsCLIDDB = $(bin)$(TileRecUtils_tag)_TileRecUtilsCLIDDB.make

else

tags      = $(tag),$(CMTEXTRATAGS)

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtilsCLIDDB = $(TileRecUtils_tag).make
cmt_local_tagfile_TileRecUtilsCLIDDB = $(bin)$(TileRecUtils_tag).make

endif

include $(cmt_local_tagfile_TileRecUtilsCLIDDB)
#-include $(cmt_local_tagfile_TileRecUtilsCLIDDB)

ifdef cmt_TileRecUtilsCLIDDB_has_target_tag

cmt_final_setup_TileRecUtilsCLIDDB = $(bin)setup_TileRecUtilsCLIDDB.make
cmt_dependencies_in_TileRecUtilsCLIDDB = $(bin)dependencies_TileRecUtilsCLIDDB.in
#cmt_final_setup_TileRecUtilsCLIDDB = $(bin)TileRecUtils_TileRecUtilsCLIDDBsetup.make
cmt_local_TileRecUtilsCLIDDB_makefile = $(bin)TileRecUtilsCLIDDB.make

else

cmt_final_setup_TileRecUtilsCLIDDB = $(bin)setup.make
cmt_dependencies_in_TileRecUtilsCLIDDB = $(bin)dependencies.in
#cmt_final_setup_TileRecUtilsCLIDDB = $(bin)TileRecUtilssetup.make
cmt_local_TileRecUtilsCLIDDB_makefile = $(bin)TileRecUtilsCLIDDB.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)TileRecUtilssetup.make

#TileRecUtilsCLIDDB :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'TileRecUtilsCLIDDB'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = TileRecUtilsCLIDDB/
#TileRecUtilsCLIDDB::
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

.PHONY: TileRecUtilsCLIDDB TileRecUtilsCLIDDBclean

outname := clid.db
cliddb  := TileRecUtils_$(outname)
instdir := $(CMTINSTALLAREA)/share
result  := $(instdir)/$(cliddb)
product := $(instdir)/$(outname)
conflib := $(bin)$(library_prefix)TileRecUtils.$(shlibsuffix)

TileRecUtilsCLIDDB :: $(result)

$(instdir) :
	$(mkdir) -p $(instdir)

$(result) : $(conflib) $(product)
	@$(genCLIDDB_cmd) -p TileRecUtils -i$(product) -o $(result)

$(product) : $(instdir)
	touch $(product)

TileRecUtilsCLIDDBclean ::
	$(cleanup_silent) $(uninstall_command) $(product) $(result)
	$(cleanup_silent) $(cmt_uninstallarea_command) $(product) $(result)

#-- start of cleanup_header --------------

clean :: TileRecUtilsCLIDDBclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(TileRecUtilsCLIDDB.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

TileRecUtilsCLIDDBclean ::
#-- end of cleanup_header ---------------
