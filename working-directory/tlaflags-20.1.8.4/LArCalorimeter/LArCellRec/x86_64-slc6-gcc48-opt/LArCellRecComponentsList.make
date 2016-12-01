#-- start of make_header -----------------

#====================================
#  Document LArCellRecComponentsList
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

cmt_LArCellRecComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_LArCellRecComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_LArCellRecComponentsList

LArCellRec_tag = $(tag)

#cmt_local_tagfile_LArCellRecComponentsList = $(LArCellRec_tag)_LArCellRecComponentsList.make
cmt_local_tagfile_LArCellRecComponentsList = $(bin)$(LArCellRec_tag)_LArCellRecComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

LArCellRec_tag = $(tag)

#cmt_local_tagfile_LArCellRecComponentsList = $(LArCellRec_tag).make
cmt_local_tagfile_LArCellRecComponentsList = $(bin)$(LArCellRec_tag).make

endif

include $(cmt_local_tagfile_LArCellRecComponentsList)
#-include $(cmt_local_tagfile_LArCellRecComponentsList)

ifdef cmt_LArCellRecComponentsList_has_target_tag

cmt_final_setup_LArCellRecComponentsList = $(bin)setup_LArCellRecComponentsList.make
cmt_dependencies_in_LArCellRecComponentsList = $(bin)dependencies_LArCellRecComponentsList.in
#cmt_final_setup_LArCellRecComponentsList = $(bin)LArCellRec_LArCellRecComponentsListsetup.make
cmt_local_LArCellRecComponentsList_makefile = $(bin)LArCellRecComponentsList.make

else

cmt_final_setup_LArCellRecComponentsList = $(bin)setup.make
cmt_dependencies_in_LArCellRecComponentsList = $(bin)dependencies.in
#cmt_final_setup_LArCellRecComponentsList = $(bin)LArCellRecsetup.make
cmt_local_LArCellRecComponentsList_makefile = $(bin)LArCellRecComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)LArCellRecsetup.make

#LArCellRecComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'LArCellRecComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = LArCellRecComponentsList/
#LArCellRecComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = LArCellRec.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libLArCellRec.$(shlibsuffix)

LArCellRecComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: LArCellRecComponentsListinstall
LArCellRecComponentsListinstall :: LArCellRecComponentsList

uninstall :: LArCellRecComponentsListuninstall
LArCellRecComponentsListuninstall :: LArCellRecComponentsListclean

LArCellRecComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: LArCellRecComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(LArCellRecComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

LArCellRecComponentsListclean ::
#-- end of cleanup_header ---------------
