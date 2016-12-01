#-- start of make_header -----------------

#====================================
#  Library TileRecUtils
#
#   Generated Wed Dec 16 17:55:24 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_TileRecUtils_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TileRecUtils_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_TileRecUtils

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtils = $(TileRecUtils_tag)_TileRecUtils.make
cmt_local_tagfile_TileRecUtils = $(bin)$(TileRecUtils_tag)_TileRecUtils.make

else

tags      = $(tag),$(CMTEXTRATAGS)

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtils = $(TileRecUtils_tag).make
cmt_local_tagfile_TileRecUtils = $(bin)$(TileRecUtils_tag).make

endif

include $(cmt_local_tagfile_TileRecUtils)
#-include $(cmt_local_tagfile_TileRecUtils)

ifdef cmt_TileRecUtils_has_target_tag

cmt_final_setup_TileRecUtils = $(bin)setup_TileRecUtils.make
cmt_dependencies_in_TileRecUtils = $(bin)dependencies_TileRecUtils.in
#cmt_final_setup_TileRecUtils = $(bin)TileRecUtils_TileRecUtilssetup.make
cmt_local_TileRecUtils_makefile = $(bin)TileRecUtils.make

else

cmt_final_setup_TileRecUtils = $(bin)setup.make
cmt_dependencies_in_TileRecUtils = $(bin)dependencies.in
#cmt_final_setup_TileRecUtils = $(bin)TileRecUtilssetup.make
cmt_local_TileRecUtils_makefile = $(bin)TileRecUtils.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)TileRecUtilssetup.make

#TileRecUtils :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'TileRecUtils'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = TileRecUtils/
#TileRecUtils::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

TileRecUtilslibname   = $(bin)$(library_prefix)TileRecUtils$(library_suffix)
TileRecUtilslib       = $(TileRecUtilslibname).a
TileRecUtilsstamp     = $(bin)TileRecUtils.stamp
TileRecUtilsshstamp   = $(bin)TileRecUtils.shstamp

TileRecUtils :: dirs  TileRecUtilsLIB
	$(echo) "TileRecUtils ok"

#-- end of libary_header ----------------
#-- start of library_no_static ------

#TileRecUtilsLIB :: $(TileRecUtilslib) $(TileRecUtilsshstamp)
TileRecUtilsLIB :: $(TileRecUtilsshstamp)
	$(echo) "TileRecUtils : library ok"

$(TileRecUtilslib) :: $(bin)TileRecUtils_entries.o $(bin)TileRecUtils_load.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(TileRecUtilslib) $?
	$(lib_silent) $(ranlib) $(TileRecUtilslib)
	$(lib_silent) cat /dev/null >$(TileRecUtilsstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

#
# We add one level of dependency upon the true shared library 
# (rather than simply upon the stamp file)
# this is for cases where the shared library has not been built
# while the stamp was created (error??) 
#

$(TileRecUtilslibname).$(shlibsuffix) :: $(bin)TileRecUtils_entries.o $(bin)TileRecUtils_load.o $(use_requirements) $(TileRecUtilsstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)TileRecUtils_entries.o $(bin)TileRecUtils_load.o $(TileRecUtils_shlibflags)
	$(lib_silent) cat /dev/null >$(TileRecUtilsstamp) && \
	  cat /dev/null >$(TileRecUtilsshstamp)

$(TileRecUtilsshstamp) :: $(TileRecUtilslibname).$(shlibsuffix)
	$(lib_silent) if test -f $(TileRecUtilslibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(TileRecUtilsstamp) && \
	  cat /dev/null >$(TileRecUtilsshstamp) ; fi

TileRecUtilsclean ::
	$(cleanup_echo) objects TileRecUtils
	$(cleanup_silent) /bin/rm -f $(bin)TileRecUtils_entries.o $(bin)TileRecUtils_load.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)TileRecUtils_entries.o $(bin)TileRecUtils_load.o) $(patsubst %.o,%.dep,$(bin)TileRecUtils_entries.o $(bin)TileRecUtils_load.o) $(patsubst %.o,%.d.stamp,$(bin)TileRecUtils_entries.o $(bin)TileRecUtils_load.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf TileRecUtils_deps TileRecUtils_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
TileRecUtilsinstallname = $(library_prefix)TileRecUtils$(library_suffix).$(shlibsuffix)

TileRecUtils :: TileRecUtilsinstall ;

install :: TileRecUtilsinstall ;

TileRecUtilsinstall :: $(install_dir)/$(TileRecUtilsinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(TileRecUtilsinstallname) :: $(bin)$(TileRecUtilsinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(TileRecUtilsinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##TileRecUtilsclean :: TileRecUtilsuninstall

uninstall :: TileRecUtilsuninstall ;

TileRecUtilsuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(TileRecUtilsinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRecUtils_entries.d

$(bin)$(binobj)TileRecUtils_entries.d :

$(bin)$(binobj)TileRecUtils_entries.o : $(cmt_final_setup_TileRecUtils)

$(bin)$(binobj)TileRecUtils_entries.o : $(src)components/TileRecUtils_entries.cxx
	$(cpp_echo) $(src)components/TileRecUtils_entries.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtils_pp_cppflags) $(lib_TileRecUtils_pp_cppflags) $(TileRecUtils_entries_pp_cppflags) $(use_cppflags) $(TileRecUtils_cppflags) $(lib_TileRecUtils_cppflags) $(TileRecUtils_entries_cppflags) $(TileRecUtils_entries_cxx_cppflags) -I../src/components $(src)components/TileRecUtils_entries.cxx
endif
endif

else
$(bin)TileRecUtils_dependencies.make : $(TileRecUtils_entries_cxx_dependencies)

$(bin)TileRecUtils_dependencies.make : $(src)components/TileRecUtils_entries.cxx

$(bin)$(binobj)TileRecUtils_entries.o : $(TileRecUtils_entries_cxx_dependencies)
	$(cpp_echo) $(src)components/TileRecUtils_entries.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtils_pp_cppflags) $(lib_TileRecUtils_pp_cppflags) $(TileRecUtils_entries_pp_cppflags) $(use_cppflags) $(TileRecUtils_cppflags) $(lib_TileRecUtils_cppflags) $(TileRecUtils_entries_cppflags) $(TileRecUtils_entries_cxx_cppflags) -I../src/components $(src)components/TileRecUtils_entries.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRecUtils_load.d

$(bin)$(binobj)TileRecUtils_load.d :

$(bin)$(binobj)TileRecUtils_load.o : $(cmt_final_setup_TileRecUtils)

$(bin)$(binobj)TileRecUtils_load.o : $(src)components/TileRecUtils_load.cxx
	$(cpp_echo) $(src)components/TileRecUtils_load.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtils_pp_cppflags) $(lib_TileRecUtils_pp_cppflags) $(TileRecUtils_load_pp_cppflags) $(use_cppflags) $(TileRecUtils_cppflags) $(lib_TileRecUtils_cppflags) $(TileRecUtils_load_cppflags) $(TileRecUtils_load_cxx_cppflags) -I../src/components $(src)components/TileRecUtils_load.cxx
endif
endif

else
$(bin)TileRecUtils_dependencies.make : $(TileRecUtils_load_cxx_dependencies)

$(bin)TileRecUtils_dependencies.make : $(src)components/TileRecUtils_load.cxx

$(bin)$(binobj)TileRecUtils_load.o : $(TileRecUtils_load_cxx_dependencies)
	$(cpp_echo) $(src)components/TileRecUtils_load.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtils_pp_cppflags) $(lib_TileRecUtils_pp_cppflags) $(TileRecUtils_load_pp_cppflags) $(use_cppflags) $(TileRecUtils_cppflags) $(lib_TileRecUtils_cppflags) $(TileRecUtils_load_cppflags) $(TileRecUtils_load_cxx_cppflags) -I../src/components $(src)components/TileRecUtils_load.cxx

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: TileRecUtilsclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(TileRecUtils.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

TileRecUtilsclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library TileRecUtils
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)TileRecUtils$(library_suffix).a $(library_prefix)TileRecUtils$(library_suffix).$(shlibsuffix) TileRecUtils.stamp TileRecUtils.shstamp
#-- end of cleanup_library ---------------
