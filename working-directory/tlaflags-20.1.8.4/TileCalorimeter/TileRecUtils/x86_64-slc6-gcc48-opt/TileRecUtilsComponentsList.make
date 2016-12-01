#-- start of make_header -----------------

#====================================
#  Document TileRecUtilsComponentsList
#
#   Generated Wed Dec 16 17:55:50 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_TileRecUtilsComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TileRecUtilsComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_TileRecUtilsComponentsList

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtilsComponentsList = $(TileRecUtils_tag)_TileRecUtilsComponentsList.make
cmt_local_tagfile_TileRecUtilsComponentsList = $(bin)$(TileRecUtils_tag)_TileRecUtilsComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtilsComponentsList = $(TileRecUtils_tag).make
cmt_local_tagfile_TileRecUtilsComponentsList = $(bin)$(TileRecUtils_tag).make

endif

include $(cmt_local_tagfile_TileRecUtilsComponentsList)
#-include $(cmt_local_tagfile_TileRecUtilsComponentsList)

ifdef cmt_TileRecUtilsComponentsList_has_target_tag

cmt_final_setup_TileRecUtilsComponentsList = $(bin)setup_TileRecUtilsComponentsList.make
cmt_dependencies_in_TileRecUtilsComponentsList = $(bin)dependencies_TileRecUtilsComponentsList.in
#cmt_final_setup_TileRecUtilsComponentsList = $(bin)TileRecUtils_TileRecUtilsComponentsListsetup.make
cmt_local_TileRecUtilsComponentsList_makefile = $(bin)TileRecUtilsComponentsList.make

else

cmt_final_setup_TileRecUtilsComponentsList = $(bin)setup.make
cmt_dependencies_in_TileRecUtilsComponentsList = $(bin)dependencies.in
#cmt_final_setup_TileRecUtilsComponentsList = $(bin)TileRecUtilssetup.make
cmt_local_TileRecUtilsComponentsList_makefile = $(bin)TileRecUtilsComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)TileRecUtilssetup.make

#TileRecUtilsComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'TileRecUtilsComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = TileRecUtilsComponentsList/
#TileRecUtilsComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = TileRecUtils.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libTileRecUtils.$(shlibsuffix)

TileRecUtilsComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: TileRecUtilsComponentsListinstall
TileRecUtilsComponentsListinstall :: TileRecUtilsComponentsList

uninstall :: TileRecUtilsComponentsListuninstall
TileRecUtilsComponentsListuninstall :: TileRecUtilsComponentsListclean

TileRecUtilsComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: TileRecUtilsComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(TileRecUtilsComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

TileRecUtilsComponentsListclean ::
#-- end of cleanup_header ---------------
