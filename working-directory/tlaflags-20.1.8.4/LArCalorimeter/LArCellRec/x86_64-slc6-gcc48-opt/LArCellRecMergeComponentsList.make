#-- start of make_header -----------------

#====================================
#  Document LArCellRecMergeComponentsList
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

cmt_LArCellRecMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_LArCellRecMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_LArCellRecMergeComponentsList

LArCellRec_tag = $(tag)

#cmt_local_tagfile_LArCellRecMergeComponentsList = $(LArCellRec_tag)_LArCellRecMergeComponentsList.make
cmt_local_tagfile_LArCellRecMergeComponentsList = $(bin)$(LArCellRec_tag)_LArCellRecMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

LArCellRec_tag = $(tag)

#cmt_local_tagfile_LArCellRecMergeComponentsList = $(LArCellRec_tag).make
cmt_local_tagfile_LArCellRecMergeComponentsList = $(bin)$(LArCellRec_tag).make

endif

include $(cmt_local_tagfile_LArCellRecMergeComponentsList)
#-include $(cmt_local_tagfile_LArCellRecMergeComponentsList)

ifdef cmt_LArCellRecMergeComponentsList_has_target_tag

cmt_final_setup_LArCellRecMergeComponentsList = $(bin)setup_LArCellRecMergeComponentsList.make
cmt_dependencies_in_LArCellRecMergeComponentsList = $(bin)dependencies_LArCellRecMergeComponentsList.in
#cmt_final_setup_LArCellRecMergeComponentsList = $(bin)LArCellRec_LArCellRecMergeComponentsListsetup.make
cmt_local_LArCellRecMergeComponentsList_makefile = $(bin)LArCellRecMergeComponentsList.make

else

cmt_final_setup_LArCellRecMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_LArCellRecMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_LArCellRecMergeComponentsList = $(bin)LArCellRecsetup.make
cmt_local_LArCellRecMergeComponentsList_makefile = $(bin)LArCellRecMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)LArCellRecsetup.make

#LArCellRecMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'LArCellRecMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = LArCellRecMergeComponentsList/
#LArCellRecMergeComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# File: cmt/fragments/merge_componentslist_header
# Author: Sebastien Binet (binet@cern.ch)

# Makefile fragment to merge a <library>.components file into a single
# <project>.components file in the (lib) install area
# If no InstallArea is present the fragment is dummy


.PHONY: LArCellRecMergeComponentsList LArCellRecMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/LArCellRec.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

LArCellRecMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  LArCellRecMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

LArCellRecMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libLArCellRec_so_dependencies = ../x86_64-slc6-gcc48-opt/libLArCellRec.so
#-- start of cleanup_header --------------

clean :: LArCellRecMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(LArCellRecMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

LArCellRecMergeComponentsListclean ::
#-- end of cleanup_header ---------------
