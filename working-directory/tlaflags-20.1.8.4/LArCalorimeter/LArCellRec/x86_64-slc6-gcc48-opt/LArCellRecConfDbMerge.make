#-- start of make_header -----------------

#====================================
#  Document LArCellRecConfDbMerge
#
#   Generated Wed Dec 16 17:28:54 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_LArCellRecConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_LArCellRecConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_LArCellRecConfDbMerge

LArCellRec_tag = $(tag)

#cmt_local_tagfile_LArCellRecConfDbMerge = $(LArCellRec_tag)_LArCellRecConfDbMerge.make
cmt_local_tagfile_LArCellRecConfDbMerge = $(bin)$(LArCellRec_tag)_LArCellRecConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

LArCellRec_tag = $(tag)

#cmt_local_tagfile_LArCellRecConfDbMerge = $(LArCellRec_tag).make
cmt_local_tagfile_LArCellRecConfDbMerge = $(bin)$(LArCellRec_tag).make

endif

include $(cmt_local_tagfile_LArCellRecConfDbMerge)
#-include $(cmt_local_tagfile_LArCellRecConfDbMerge)

ifdef cmt_LArCellRecConfDbMerge_has_target_tag

cmt_final_setup_LArCellRecConfDbMerge = $(bin)setup_LArCellRecConfDbMerge.make
cmt_dependencies_in_LArCellRecConfDbMerge = $(bin)dependencies_LArCellRecConfDbMerge.in
#cmt_final_setup_LArCellRecConfDbMerge = $(bin)LArCellRec_LArCellRecConfDbMergesetup.make
cmt_local_LArCellRecConfDbMerge_makefile = $(bin)LArCellRecConfDbMerge.make

else

cmt_final_setup_LArCellRecConfDbMerge = $(bin)setup.make
cmt_dependencies_in_LArCellRecConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_LArCellRecConfDbMerge = $(bin)LArCellRecsetup.make
cmt_local_LArCellRecConfDbMerge_makefile = $(bin)LArCellRecConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)LArCellRecsetup.make

#LArCellRecConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'LArCellRecConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = LArCellRecConfDbMerge/
#LArCellRecConfDbMerge::
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

.PHONY: LArCellRecConfDbMerge LArCellRecConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /afs/cern.ch/user/b/boveia/work/tlaflags-20.1.8.4/LArCalorimeter/LArCellRec/genConf/LArCellRec/LArCellRec.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

LArCellRecConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  LArCellRecConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

LArCellRecConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libLArCellRec_so_dependencies = ../x86_64-slc6-gcc48-opt/libLArCellRec.so
#-- start of cleanup_header --------------

clean :: LArCellRecConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(LArCellRecConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

LArCellRecConfDbMergeclean ::
#-- end of cleanup_header ---------------
