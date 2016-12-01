#-- start of make_header -----------------

#====================================
#  Document TileRecUtilsConfDbMerge
#
#   Generated Wed Dec 16 17:55:48 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_TileRecUtilsConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TileRecUtilsConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_TileRecUtilsConfDbMerge

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtilsConfDbMerge = $(TileRecUtils_tag)_TileRecUtilsConfDbMerge.make
cmt_local_tagfile_TileRecUtilsConfDbMerge = $(bin)$(TileRecUtils_tag)_TileRecUtilsConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtilsConfDbMerge = $(TileRecUtils_tag).make
cmt_local_tagfile_TileRecUtilsConfDbMerge = $(bin)$(TileRecUtils_tag).make

endif

include $(cmt_local_tagfile_TileRecUtilsConfDbMerge)
#-include $(cmt_local_tagfile_TileRecUtilsConfDbMerge)

ifdef cmt_TileRecUtilsConfDbMerge_has_target_tag

cmt_final_setup_TileRecUtilsConfDbMerge = $(bin)setup_TileRecUtilsConfDbMerge.make
cmt_dependencies_in_TileRecUtilsConfDbMerge = $(bin)dependencies_TileRecUtilsConfDbMerge.in
#cmt_final_setup_TileRecUtilsConfDbMerge = $(bin)TileRecUtils_TileRecUtilsConfDbMergesetup.make
cmt_local_TileRecUtilsConfDbMerge_makefile = $(bin)TileRecUtilsConfDbMerge.make

else

cmt_final_setup_TileRecUtilsConfDbMerge = $(bin)setup.make
cmt_dependencies_in_TileRecUtilsConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_TileRecUtilsConfDbMerge = $(bin)TileRecUtilssetup.make
cmt_local_TileRecUtilsConfDbMerge_makefile = $(bin)TileRecUtilsConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)TileRecUtilssetup.make

#TileRecUtilsConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'TileRecUtilsConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = TileRecUtilsConfDbMerge/
#TileRecUtilsConfDbMerge::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# File: cmt/fragments/merge_genconfDb_header
# Author: Sebastien Binet (binet@cern.ch)

# Makefile fragment to merge a <library>.confdb file into a single
# <project>.confdb file in the (lib) install area

.PHONY: TileRecUtilsConfDbMerge TileRecUtilsConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/TileCalorimeter/TileRecUtils/genConf/TileRecUtils/TileRecUtils.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

TileRecUtilsConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  TileRecUtilsConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

TileRecUtilsConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libTileRecUtils_so_dependencies = ../x86_64-slc6-gcc48-opt/libTileRecUtils.so
#-- start of cleanup_header --------------

clean :: TileRecUtilsConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(TileRecUtilsConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

TileRecUtilsConfDbMergeclean ::
#-- end of cleanup_header ---------------
