#-- start of make_header -----------------

#====================================
#  Document TileRecUtilsMergeComponentsList
#
#   Generated Wed Dec 16 17:55:51 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_TileRecUtilsMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TileRecUtilsMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_TileRecUtilsMergeComponentsList

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtilsMergeComponentsList = $(TileRecUtils_tag)_TileRecUtilsMergeComponentsList.make
cmt_local_tagfile_TileRecUtilsMergeComponentsList = $(bin)$(TileRecUtils_tag)_TileRecUtilsMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtilsMergeComponentsList = $(TileRecUtils_tag).make
cmt_local_tagfile_TileRecUtilsMergeComponentsList = $(bin)$(TileRecUtils_tag).make

endif

include $(cmt_local_tagfile_TileRecUtilsMergeComponentsList)
#-include $(cmt_local_tagfile_TileRecUtilsMergeComponentsList)

ifdef cmt_TileRecUtilsMergeComponentsList_has_target_tag

cmt_final_setup_TileRecUtilsMergeComponentsList = $(bin)setup_TileRecUtilsMergeComponentsList.make
cmt_dependencies_in_TileRecUtilsMergeComponentsList = $(bin)dependencies_TileRecUtilsMergeComponentsList.in
#cmt_final_setup_TileRecUtilsMergeComponentsList = $(bin)TileRecUtils_TileRecUtilsMergeComponentsListsetup.make
cmt_local_TileRecUtilsMergeComponentsList_makefile = $(bin)TileRecUtilsMergeComponentsList.make

else

cmt_final_setup_TileRecUtilsMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_TileRecUtilsMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_TileRecUtilsMergeComponentsList = $(bin)TileRecUtilssetup.make
cmt_local_TileRecUtilsMergeComponentsList_makefile = $(bin)TileRecUtilsMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)TileRecUtilssetup.make

#TileRecUtilsMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'TileRecUtilsMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = TileRecUtilsMergeComponentsList/
#TileRecUtilsMergeComponentsList::
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


.PHONY: TileRecUtilsMergeComponentsList TileRecUtilsMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/TileRecUtils.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

TileRecUtilsMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  TileRecUtilsMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

TileRecUtilsMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libTileRecUtils_so_dependencies = ../x86_64-slc6-gcc48-opt/libTileRecUtils.so
#-- start of cleanup_header --------------

clean :: TileRecUtilsMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(TileRecUtilsMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

TileRecUtilsMergeComponentsListclean ::
#-- end of cleanup_header ---------------
