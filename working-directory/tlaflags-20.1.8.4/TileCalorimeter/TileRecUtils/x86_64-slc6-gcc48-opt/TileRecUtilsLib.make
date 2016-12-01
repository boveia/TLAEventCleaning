#-- start of make_header -----------------

#====================================
#  Library TileRecUtilsLib
#
#   Generated Wed Dec 16 17:42:40 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_TileRecUtilsLib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_TileRecUtilsLib_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_TileRecUtilsLib

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtilsLib = $(TileRecUtils_tag)_TileRecUtilsLib.make
cmt_local_tagfile_TileRecUtilsLib = $(bin)$(TileRecUtils_tag)_TileRecUtilsLib.make

else

tags      = $(tag),$(CMTEXTRATAGS)

TileRecUtils_tag = $(tag)

#cmt_local_tagfile_TileRecUtilsLib = $(TileRecUtils_tag).make
cmt_local_tagfile_TileRecUtilsLib = $(bin)$(TileRecUtils_tag).make

endif

include $(cmt_local_tagfile_TileRecUtilsLib)
#-include $(cmt_local_tagfile_TileRecUtilsLib)

ifdef cmt_TileRecUtilsLib_has_target_tag

cmt_final_setup_TileRecUtilsLib = $(bin)setup_TileRecUtilsLib.make
cmt_dependencies_in_TileRecUtilsLib = $(bin)dependencies_TileRecUtilsLib.in
#cmt_final_setup_TileRecUtilsLib = $(bin)TileRecUtils_TileRecUtilsLibsetup.make
cmt_local_TileRecUtilsLib_makefile = $(bin)TileRecUtilsLib.make

else

cmt_final_setup_TileRecUtilsLib = $(bin)setup.make
cmt_dependencies_in_TileRecUtilsLib = $(bin)dependencies.in
#cmt_final_setup_TileRecUtilsLib = $(bin)TileRecUtilssetup.make
cmt_local_TileRecUtilsLib_makefile = $(bin)TileRecUtilsLib.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)TileRecUtilssetup.make

#TileRecUtilsLib :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'TileRecUtilsLib'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = TileRecUtilsLib/
#TileRecUtilsLib::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

TileRecUtilsLiblibname   = $(bin)$(library_prefix)TileRecUtilsLib$(library_suffix)
TileRecUtilsLiblib       = $(TileRecUtilsLiblibname).a
TileRecUtilsLibstamp     = $(bin)TileRecUtilsLib.stamp
TileRecUtilsLibshstamp   = $(bin)TileRecUtilsLib.shstamp

TileRecUtilsLib :: dirs  TileRecUtilsLibLIB
	$(echo) "TileRecUtilsLib ok"

#-- end of libary_header ----------------
#-- start of library_no_static ------

#TileRecUtilsLibLIB :: $(TileRecUtilsLiblib) $(TileRecUtilsLibshstamp)
TileRecUtilsLibLIB :: $(TileRecUtilsLibshstamp)
	$(echo) "TileRecUtilsLib : library ok"

$(TileRecUtilsLiblib) :: $(bin)TileRawChannelBuilderMF.o $(bin)TileBeamInfoProvider.o $(bin)TileRawChannelBuilderFitFilter.o $(bin)TileRawChannelMaker.o $(bin)TileRawChannelVerify.o $(bin)TileFitter.o $(bin)TileRawChannelNoiseFilter.o $(bin)TileCellMaskingTool.o $(bin)TileCellBuilder.o $(bin)TileFilterResult.o $(bin)TileCellNoiseFilter.o $(bin)TileFilterTester.o $(bin)TileRawChannelBuilderOpt2Filter.o $(bin)TileRawChannelBuilderFlatFilter.o $(bin)TileRawChannelBuilderFitFilterCool.o $(bin)TileRawChannelBuilderManyAmps.o $(bin)TileRawChannelBuilder.o $(bin)TileCellFakeProb.o $(bin)TileCorrelation.o $(bin)TileFilterManager.o $(bin)TileTowerBuilderTool.o $(bin)TileRawCorrelatedNoise.o $(bin)TileRawChannelBuilderOptFilter.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(TileRecUtilsLiblib) $?
	$(lib_silent) $(ranlib) $(TileRecUtilsLiblib)
	$(lib_silent) cat /dev/null >$(TileRecUtilsLibstamp)

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

$(TileRecUtilsLiblibname).$(shlibsuffix) :: $(bin)TileRawChannelBuilderMF.o $(bin)TileBeamInfoProvider.o $(bin)TileRawChannelBuilderFitFilter.o $(bin)TileRawChannelMaker.o $(bin)TileRawChannelVerify.o $(bin)TileFitter.o $(bin)TileRawChannelNoiseFilter.o $(bin)TileCellMaskingTool.o $(bin)TileCellBuilder.o $(bin)TileFilterResult.o $(bin)TileCellNoiseFilter.o $(bin)TileFilterTester.o $(bin)TileRawChannelBuilderOpt2Filter.o $(bin)TileRawChannelBuilderFlatFilter.o $(bin)TileRawChannelBuilderFitFilterCool.o $(bin)TileRawChannelBuilderManyAmps.o $(bin)TileRawChannelBuilder.o $(bin)TileCellFakeProb.o $(bin)TileCorrelation.o $(bin)TileFilterManager.o $(bin)TileTowerBuilderTool.o $(bin)TileRawCorrelatedNoise.o $(bin)TileRawChannelBuilderOptFilter.o $(use_requirements) $(TileRecUtilsLibstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)TileRawChannelBuilderMF.o $(bin)TileBeamInfoProvider.o $(bin)TileRawChannelBuilderFitFilter.o $(bin)TileRawChannelMaker.o $(bin)TileRawChannelVerify.o $(bin)TileFitter.o $(bin)TileRawChannelNoiseFilter.o $(bin)TileCellMaskingTool.o $(bin)TileCellBuilder.o $(bin)TileFilterResult.o $(bin)TileCellNoiseFilter.o $(bin)TileFilterTester.o $(bin)TileRawChannelBuilderOpt2Filter.o $(bin)TileRawChannelBuilderFlatFilter.o $(bin)TileRawChannelBuilderFitFilterCool.o $(bin)TileRawChannelBuilderManyAmps.o $(bin)TileRawChannelBuilder.o $(bin)TileCellFakeProb.o $(bin)TileCorrelation.o $(bin)TileFilterManager.o $(bin)TileTowerBuilderTool.o $(bin)TileRawCorrelatedNoise.o $(bin)TileRawChannelBuilderOptFilter.o $(TileRecUtilsLib_shlibflags)
	$(lib_silent) cat /dev/null >$(TileRecUtilsLibstamp) && \
	  cat /dev/null >$(TileRecUtilsLibshstamp)

$(TileRecUtilsLibshstamp) :: $(TileRecUtilsLiblibname).$(shlibsuffix)
	$(lib_silent) if test -f $(TileRecUtilsLiblibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(TileRecUtilsLibstamp) && \
	  cat /dev/null >$(TileRecUtilsLibshstamp) ; fi

TileRecUtilsLibclean ::
	$(cleanup_echo) objects TileRecUtilsLib
	$(cleanup_silent) /bin/rm -f $(bin)TileRawChannelBuilderMF.o $(bin)TileBeamInfoProvider.o $(bin)TileRawChannelBuilderFitFilter.o $(bin)TileRawChannelMaker.o $(bin)TileRawChannelVerify.o $(bin)TileFitter.o $(bin)TileRawChannelNoiseFilter.o $(bin)TileCellMaskingTool.o $(bin)TileCellBuilder.o $(bin)TileFilterResult.o $(bin)TileCellNoiseFilter.o $(bin)TileFilterTester.o $(bin)TileRawChannelBuilderOpt2Filter.o $(bin)TileRawChannelBuilderFlatFilter.o $(bin)TileRawChannelBuilderFitFilterCool.o $(bin)TileRawChannelBuilderManyAmps.o $(bin)TileRawChannelBuilder.o $(bin)TileCellFakeProb.o $(bin)TileCorrelation.o $(bin)TileFilterManager.o $(bin)TileTowerBuilderTool.o $(bin)TileRawCorrelatedNoise.o $(bin)TileRawChannelBuilderOptFilter.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)TileRawChannelBuilderMF.o $(bin)TileBeamInfoProvider.o $(bin)TileRawChannelBuilderFitFilter.o $(bin)TileRawChannelMaker.o $(bin)TileRawChannelVerify.o $(bin)TileFitter.o $(bin)TileRawChannelNoiseFilter.o $(bin)TileCellMaskingTool.o $(bin)TileCellBuilder.o $(bin)TileFilterResult.o $(bin)TileCellNoiseFilter.o $(bin)TileFilterTester.o $(bin)TileRawChannelBuilderOpt2Filter.o $(bin)TileRawChannelBuilderFlatFilter.o $(bin)TileRawChannelBuilderFitFilterCool.o $(bin)TileRawChannelBuilderManyAmps.o $(bin)TileRawChannelBuilder.o $(bin)TileCellFakeProb.o $(bin)TileCorrelation.o $(bin)TileFilterManager.o $(bin)TileTowerBuilderTool.o $(bin)TileRawCorrelatedNoise.o $(bin)TileRawChannelBuilderOptFilter.o) $(patsubst %.o,%.dep,$(bin)TileRawChannelBuilderMF.o $(bin)TileBeamInfoProvider.o $(bin)TileRawChannelBuilderFitFilter.o $(bin)TileRawChannelMaker.o $(bin)TileRawChannelVerify.o $(bin)TileFitter.o $(bin)TileRawChannelNoiseFilter.o $(bin)TileCellMaskingTool.o $(bin)TileCellBuilder.o $(bin)TileFilterResult.o $(bin)TileCellNoiseFilter.o $(bin)TileFilterTester.o $(bin)TileRawChannelBuilderOpt2Filter.o $(bin)TileRawChannelBuilderFlatFilter.o $(bin)TileRawChannelBuilderFitFilterCool.o $(bin)TileRawChannelBuilderManyAmps.o $(bin)TileRawChannelBuilder.o $(bin)TileCellFakeProb.o $(bin)TileCorrelation.o $(bin)TileFilterManager.o $(bin)TileTowerBuilderTool.o $(bin)TileRawCorrelatedNoise.o $(bin)TileRawChannelBuilderOptFilter.o) $(patsubst %.o,%.d.stamp,$(bin)TileRawChannelBuilderMF.o $(bin)TileBeamInfoProvider.o $(bin)TileRawChannelBuilderFitFilter.o $(bin)TileRawChannelMaker.o $(bin)TileRawChannelVerify.o $(bin)TileFitter.o $(bin)TileRawChannelNoiseFilter.o $(bin)TileCellMaskingTool.o $(bin)TileCellBuilder.o $(bin)TileFilterResult.o $(bin)TileCellNoiseFilter.o $(bin)TileFilterTester.o $(bin)TileRawChannelBuilderOpt2Filter.o $(bin)TileRawChannelBuilderFlatFilter.o $(bin)TileRawChannelBuilderFitFilterCool.o $(bin)TileRawChannelBuilderManyAmps.o $(bin)TileRawChannelBuilder.o $(bin)TileCellFakeProb.o $(bin)TileCorrelation.o $(bin)TileFilterManager.o $(bin)TileTowerBuilderTool.o $(bin)TileRawCorrelatedNoise.o $(bin)TileRawChannelBuilderOptFilter.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf TileRecUtilsLib_deps TileRecUtilsLib_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
TileRecUtilsLibinstallname = $(library_prefix)TileRecUtilsLib$(library_suffix).$(shlibsuffix)

TileRecUtilsLib :: TileRecUtilsLibinstall ;

install :: TileRecUtilsLibinstall ;

TileRecUtilsLibinstall :: $(install_dir)/$(TileRecUtilsLibinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(TileRecUtilsLibinstallname) :: $(bin)$(TileRecUtilsLibinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(TileRecUtilsLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##TileRecUtilsLibclean :: TileRecUtilsLibuninstall

uninstall :: TileRecUtilsLibuninstall ;

TileRecUtilsLibuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(TileRecUtilsLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRawChannelBuilderMF.d

$(bin)$(binobj)TileRawChannelBuilderMF.d :

$(bin)$(binobj)TileRawChannelBuilderMF.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileRawChannelBuilderMF.o : $(src)TileRawChannelBuilderMF.cxx
	$(cpp_echo) $(src)TileRawChannelBuilderMF.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderMF_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderMF_cppflags) $(TileRawChannelBuilderMF_cxx_cppflags)  $(src)TileRawChannelBuilderMF.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileRawChannelBuilderMF_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileRawChannelBuilderMF.cxx

$(bin)$(binobj)TileRawChannelBuilderMF.o : $(TileRawChannelBuilderMF_cxx_dependencies)
	$(cpp_echo) $(src)TileRawChannelBuilderMF.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderMF_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderMF_cppflags) $(TileRawChannelBuilderMF_cxx_cppflags)  $(src)TileRawChannelBuilderMF.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileBeamInfoProvider.d

$(bin)$(binobj)TileBeamInfoProvider.d :

$(bin)$(binobj)TileBeamInfoProvider.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileBeamInfoProvider.o : $(src)TileBeamInfoProvider.cxx
	$(cpp_echo) $(src)TileBeamInfoProvider.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileBeamInfoProvider_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileBeamInfoProvider_cppflags) $(TileBeamInfoProvider_cxx_cppflags)  $(src)TileBeamInfoProvider.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileBeamInfoProvider_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileBeamInfoProvider.cxx

$(bin)$(binobj)TileBeamInfoProvider.o : $(TileBeamInfoProvider_cxx_dependencies)
	$(cpp_echo) $(src)TileBeamInfoProvider.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileBeamInfoProvider_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileBeamInfoProvider_cppflags) $(TileBeamInfoProvider_cxx_cppflags)  $(src)TileBeamInfoProvider.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRawChannelBuilderFitFilter.d

$(bin)$(binobj)TileRawChannelBuilderFitFilter.d :

$(bin)$(binobj)TileRawChannelBuilderFitFilter.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileRawChannelBuilderFitFilter.o : $(src)TileRawChannelBuilderFitFilter.cxx
	$(cpp_echo) $(src)TileRawChannelBuilderFitFilter.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderFitFilter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderFitFilter_cppflags) $(TileRawChannelBuilderFitFilter_cxx_cppflags)  $(src)TileRawChannelBuilderFitFilter.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileRawChannelBuilderFitFilter_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileRawChannelBuilderFitFilter.cxx

$(bin)$(binobj)TileRawChannelBuilderFitFilter.o : $(TileRawChannelBuilderFitFilter_cxx_dependencies)
	$(cpp_echo) $(src)TileRawChannelBuilderFitFilter.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderFitFilter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderFitFilter_cppflags) $(TileRawChannelBuilderFitFilter_cxx_cppflags)  $(src)TileRawChannelBuilderFitFilter.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRawChannelMaker.d

$(bin)$(binobj)TileRawChannelMaker.d :

$(bin)$(binobj)TileRawChannelMaker.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileRawChannelMaker.o : $(src)TileRawChannelMaker.cxx
	$(cpp_echo) $(src)TileRawChannelMaker.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelMaker_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelMaker_cppflags) $(TileRawChannelMaker_cxx_cppflags)  $(src)TileRawChannelMaker.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileRawChannelMaker_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileRawChannelMaker.cxx

$(bin)$(binobj)TileRawChannelMaker.o : $(TileRawChannelMaker_cxx_dependencies)
	$(cpp_echo) $(src)TileRawChannelMaker.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelMaker_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelMaker_cppflags) $(TileRawChannelMaker_cxx_cppflags)  $(src)TileRawChannelMaker.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRawChannelVerify.d

$(bin)$(binobj)TileRawChannelVerify.d :

$(bin)$(binobj)TileRawChannelVerify.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileRawChannelVerify.o : $(src)TileRawChannelVerify.cxx
	$(cpp_echo) $(src)TileRawChannelVerify.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelVerify_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelVerify_cppflags) $(TileRawChannelVerify_cxx_cppflags)  $(src)TileRawChannelVerify.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileRawChannelVerify_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileRawChannelVerify.cxx

$(bin)$(binobj)TileRawChannelVerify.o : $(TileRawChannelVerify_cxx_dependencies)
	$(cpp_echo) $(src)TileRawChannelVerify.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelVerify_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelVerify_cppflags) $(TileRawChannelVerify_cxx_cppflags)  $(src)TileRawChannelVerify.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileFitter.d

$(bin)$(binobj)TileFitter.d :

$(bin)$(binobj)TileFitter.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileFitter.o : $(src)TileFitter.cxx
	$(cpp_echo) $(src)TileFitter.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileFitter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileFitter_cppflags) $(TileFitter_cxx_cppflags)  $(src)TileFitter.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileFitter_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileFitter.cxx

$(bin)$(binobj)TileFitter.o : $(TileFitter_cxx_dependencies)
	$(cpp_echo) $(src)TileFitter.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileFitter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileFitter_cppflags) $(TileFitter_cxx_cppflags)  $(src)TileFitter.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRawChannelNoiseFilter.d

$(bin)$(binobj)TileRawChannelNoiseFilter.d :

$(bin)$(binobj)TileRawChannelNoiseFilter.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileRawChannelNoiseFilter.o : $(src)TileRawChannelNoiseFilter.cxx
	$(cpp_echo) $(src)TileRawChannelNoiseFilter.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelNoiseFilter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelNoiseFilter_cppflags) $(TileRawChannelNoiseFilter_cxx_cppflags)  $(src)TileRawChannelNoiseFilter.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileRawChannelNoiseFilter_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileRawChannelNoiseFilter.cxx

$(bin)$(binobj)TileRawChannelNoiseFilter.o : $(TileRawChannelNoiseFilter_cxx_dependencies)
	$(cpp_echo) $(src)TileRawChannelNoiseFilter.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelNoiseFilter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelNoiseFilter_cppflags) $(TileRawChannelNoiseFilter_cxx_cppflags)  $(src)TileRawChannelNoiseFilter.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileCellMaskingTool.d

$(bin)$(binobj)TileCellMaskingTool.d :

$(bin)$(binobj)TileCellMaskingTool.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileCellMaskingTool.o : $(src)TileCellMaskingTool.cxx
	$(cpp_echo) $(src)TileCellMaskingTool.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileCellMaskingTool_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileCellMaskingTool_cppflags) $(TileCellMaskingTool_cxx_cppflags)  $(src)TileCellMaskingTool.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileCellMaskingTool_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileCellMaskingTool.cxx

$(bin)$(binobj)TileCellMaskingTool.o : $(TileCellMaskingTool_cxx_dependencies)
	$(cpp_echo) $(src)TileCellMaskingTool.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileCellMaskingTool_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileCellMaskingTool_cppflags) $(TileCellMaskingTool_cxx_cppflags)  $(src)TileCellMaskingTool.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileCellBuilder.d

$(bin)$(binobj)TileCellBuilder.d :

$(bin)$(binobj)TileCellBuilder.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileCellBuilder.o : $(src)TileCellBuilder.cxx
	$(cpp_echo) $(src)TileCellBuilder.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileCellBuilder_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileCellBuilder_cppflags) $(TileCellBuilder_cxx_cppflags)  $(src)TileCellBuilder.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileCellBuilder_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileCellBuilder.cxx

$(bin)$(binobj)TileCellBuilder.o : $(TileCellBuilder_cxx_dependencies)
	$(cpp_echo) $(src)TileCellBuilder.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileCellBuilder_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileCellBuilder_cppflags) $(TileCellBuilder_cxx_cppflags)  $(src)TileCellBuilder.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileFilterResult.d

$(bin)$(binobj)TileFilterResult.d :

$(bin)$(binobj)TileFilterResult.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileFilterResult.o : $(src)TileFilterResult.cxx
	$(cpp_echo) $(src)TileFilterResult.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileFilterResult_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileFilterResult_cppflags) $(TileFilterResult_cxx_cppflags)  $(src)TileFilterResult.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileFilterResult_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileFilterResult.cxx

$(bin)$(binobj)TileFilterResult.o : $(TileFilterResult_cxx_dependencies)
	$(cpp_echo) $(src)TileFilterResult.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileFilterResult_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileFilterResult_cppflags) $(TileFilterResult_cxx_cppflags)  $(src)TileFilterResult.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileCellNoiseFilter.d

$(bin)$(binobj)TileCellNoiseFilter.d :

$(bin)$(binobj)TileCellNoiseFilter.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileCellNoiseFilter.o : $(src)TileCellNoiseFilter.cxx
	$(cpp_echo) $(src)TileCellNoiseFilter.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileCellNoiseFilter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileCellNoiseFilter_cppflags) $(TileCellNoiseFilter_cxx_cppflags)  $(src)TileCellNoiseFilter.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileCellNoiseFilter_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileCellNoiseFilter.cxx

$(bin)$(binobj)TileCellNoiseFilter.o : $(TileCellNoiseFilter_cxx_dependencies)
	$(cpp_echo) $(src)TileCellNoiseFilter.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileCellNoiseFilter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileCellNoiseFilter_cppflags) $(TileCellNoiseFilter_cxx_cppflags)  $(src)TileCellNoiseFilter.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileFilterTester.d

$(bin)$(binobj)TileFilterTester.d :

$(bin)$(binobj)TileFilterTester.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileFilterTester.o : $(src)TileFilterTester.cxx
	$(cpp_echo) $(src)TileFilterTester.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileFilterTester_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileFilterTester_cppflags) $(TileFilterTester_cxx_cppflags)  $(src)TileFilterTester.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileFilterTester_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileFilterTester.cxx

$(bin)$(binobj)TileFilterTester.o : $(TileFilterTester_cxx_dependencies)
	$(cpp_echo) $(src)TileFilterTester.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileFilterTester_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileFilterTester_cppflags) $(TileFilterTester_cxx_cppflags)  $(src)TileFilterTester.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRawChannelBuilderOpt2Filter.d

$(bin)$(binobj)TileRawChannelBuilderOpt2Filter.d :

$(bin)$(binobj)TileRawChannelBuilderOpt2Filter.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileRawChannelBuilderOpt2Filter.o : $(src)TileRawChannelBuilderOpt2Filter.cxx
	$(cpp_echo) $(src)TileRawChannelBuilderOpt2Filter.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderOpt2Filter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderOpt2Filter_cppflags) $(TileRawChannelBuilderOpt2Filter_cxx_cppflags)  $(src)TileRawChannelBuilderOpt2Filter.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileRawChannelBuilderOpt2Filter_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileRawChannelBuilderOpt2Filter.cxx

$(bin)$(binobj)TileRawChannelBuilderOpt2Filter.o : $(TileRawChannelBuilderOpt2Filter_cxx_dependencies)
	$(cpp_echo) $(src)TileRawChannelBuilderOpt2Filter.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderOpt2Filter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderOpt2Filter_cppflags) $(TileRawChannelBuilderOpt2Filter_cxx_cppflags)  $(src)TileRawChannelBuilderOpt2Filter.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRawChannelBuilderFlatFilter.d

$(bin)$(binobj)TileRawChannelBuilderFlatFilter.d :

$(bin)$(binobj)TileRawChannelBuilderFlatFilter.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileRawChannelBuilderFlatFilter.o : $(src)TileRawChannelBuilderFlatFilter.cxx
	$(cpp_echo) $(src)TileRawChannelBuilderFlatFilter.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderFlatFilter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderFlatFilter_cppflags) $(TileRawChannelBuilderFlatFilter_cxx_cppflags)  $(src)TileRawChannelBuilderFlatFilter.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileRawChannelBuilderFlatFilter_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileRawChannelBuilderFlatFilter.cxx

$(bin)$(binobj)TileRawChannelBuilderFlatFilter.o : $(TileRawChannelBuilderFlatFilter_cxx_dependencies)
	$(cpp_echo) $(src)TileRawChannelBuilderFlatFilter.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderFlatFilter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderFlatFilter_cppflags) $(TileRawChannelBuilderFlatFilter_cxx_cppflags)  $(src)TileRawChannelBuilderFlatFilter.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRawChannelBuilderFitFilterCool.d

$(bin)$(binobj)TileRawChannelBuilderFitFilterCool.d :

$(bin)$(binobj)TileRawChannelBuilderFitFilterCool.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileRawChannelBuilderFitFilterCool.o : $(src)TileRawChannelBuilderFitFilterCool.cxx
	$(cpp_echo) $(src)TileRawChannelBuilderFitFilterCool.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderFitFilterCool_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderFitFilterCool_cppflags) $(TileRawChannelBuilderFitFilterCool_cxx_cppflags)  $(src)TileRawChannelBuilderFitFilterCool.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileRawChannelBuilderFitFilterCool_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileRawChannelBuilderFitFilterCool.cxx

$(bin)$(binobj)TileRawChannelBuilderFitFilterCool.o : $(TileRawChannelBuilderFitFilterCool_cxx_dependencies)
	$(cpp_echo) $(src)TileRawChannelBuilderFitFilterCool.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderFitFilterCool_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderFitFilterCool_cppflags) $(TileRawChannelBuilderFitFilterCool_cxx_cppflags)  $(src)TileRawChannelBuilderFitFilterCool.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRawChannelBuilderManyAmps.d

$(bin)$(binobj)TileRawChannelBuilderManyAmps.d :

$(bin)$(binobj)TileRawChannelBuilderManyAmps.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileRawChannelBuilderManyAmps.o : $(src)TileRawChannelBuilderManyAmps.cxx
	$(cpp_echo) $(src)TileRawChannelBuilderManyAmps.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderManyAmps_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderManyAmps_cppflags) $(TileRawChannelBuilderManyAmps_cxx_cppflags)  $(src)TileRawChannelBuilderManyAmps.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileRawChannelBuilderManyAmps_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileRawChannelBuilderManyAmps.cxx

$(bin)$(binobj)TileRawChannelBuilderManyAmps.o : $(TileRawChannelBuilderManyAmps_cxx_dependencies)
	$(cpp_echo) $(src)TileRawChannelBuilderManyAmps.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderManyAmps_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderManyAmps_cppflags) $(TileRawChannelBuilderManyAmps_cxx_cppflags)  $(src)TileRawChannelBuilderManyAmps.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRawChannelBuilder.d

$(bin)$(binobj)TileRawChannelBuilder.d :

$(bin)$(binobj)TileRawChannelBuilder.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileRawChannelBuilder.o : $(src)TileRawChannelBuilder.cxx
	$(cpp_echo) $(src)TileRawChannelBuilder.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilder_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilder_cppflags) $(TileRawChannelBuilder_cxx_cppflags)  $(src)TileRawChannelBuilder.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileRawChannelBuilder_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileRawChannelBuilder.cxx

$(bin)$(binobj)TileRawChannelBuilder.o : $(TileRawChannelBuilder_cxx_dependencies)
	$(cpp_echo) $(src)TileRawChannelBuilder.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilder_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilder_cppflags) $(TileRawChannelBuilder_cxx_cppflags)  $(src)TileRawChannelBuilder.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileCellFakeProb.d

$(bin)$(binobj)TileCellFakeProb.d :

$(bin)$(binobj)TileCellFakeProb.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileCellFakeProb.o : $(src)TileCellFakeProb.cxx
	$(cpp_echo) $(src)TileCellFakeProb.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileCellFakeProb_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileCellFakeProb_cppflags) $(TileCellFakeProb_cxx_cppflags)  $(src)TileCellFakeProb.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileCellFakeProb_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileCellFakeProb.cxx

$(bin)$(binobj)TileCellFakeProb.o : $(TileCellFakeProb_cxx_dependencies)
	$(cpp_echo) $(src)TileCellFakeProb.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileCellFakeProb_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileCellFakeProb_cppflags) $(TileCellFakeProb_cxx_cppflags)  $(src)TileCellFakeProb.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileCorrelation.d

$(bin)$(binobj)TileCorrelation.d :

$(bin)$(binobj)TileCorrelation.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileCorrelation.o : $(src)TileCorrelation.cxx
	$(cpp_echo) $(src)TileCorrelation.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileCorrelation_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileCorrelation_cppflags) $(TileCorrelation_cxx_cppflags)  $(src)TileCorrelation.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileCorrelation_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileCorrelation.cxx

$(bin)$(binobj)TileCorrelation.o : $(TileCorrelation_cxx_dependencies)
	$(cpp_echo) $(src)TileCorrelation.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileCorrelation_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileCorrelation_cppflags) $(TileCorrelation_cxx_cppflags)  $(src)TileCorrelation.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileFilterManager.d

$(bin)$(binobj)TileFilterManager.d :

$(bin)$(binobj)TileFilterManager.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileFilterManager.o : $(src)TileFilterManager.cxx
	$(cpp_echo) $(src)TileFilterManager.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileFilterManager_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileFilterManager_cppflags) $(TileFilterManager_cxx_cppflags)  $(src)TileFilterManager.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileFilterManager_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileFilterManager.cxx

$(bin)$(binobj)TileFilterManager.o : $(TileFilterManager_cxx_dependencies)
	$(cpp_echo) $(src)TileFilterManager.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileFilterManager_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileFilterManager_cppflags) $(TileFilterManager_cxx_cppflags)  $(src)TileFilterManager.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileTowerBuilderTool.d

$(bin)$(binobj)TileTowerBuilderTool.d :

$(bin)$(binobj)TileTowerBuilderTool.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileTowerBuilderTool.o : $(src)TileTowerBuilderTool.cxx
	$(cpp_echo) $(src)TileTowerBuilderTool.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileTowerBuilderTool_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileTowerBuilderTool_cppflags) $(TileTowerBuilderTool_cxx_cppflags)  $(src)TileTowerBuilderTool.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileTowerBuilderTool_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileTowerBuilderTool.cxx

$(bin)$(binobj)TileTowerBuilderTool.o : $(TileTowerBuilderTool_cxx_dependencies)
	$(cpp_echo) $(src)TileTowerBuilderTool.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileTowerBuilderTool_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileTowerBuilderTool_cppflags) $(TileTowerBuilderTool_cxx_cppflags)  $(src)TileTowerBuilderTool.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRawCorrelatedNoise.d

$(bin)$(binobj)TileRawCorrelatedNoise.d :

$(bin)$(binobj)TileRawCorrelatedNoise.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileRawCorrelatedNoise.o : $(src)TileRawCorrelatedNoise.cxx
	$(cpp_echo) $(src)TileRawCorrelatedNoise.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawCorrelatedNoise_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawCorrelatedNoise_cppflags) $(TileRawCorrelatedNoise_cxx_cppflags)  $(src)TileRawCorrelatedNoise.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileRawCorrelatedNoise_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileRawCorrelatedNoise.cxx

$(bin)$(binobj)TileRawCorrelatedNoise.o : $(TileRawCorrelatedNoise_cxx_dependencies)
	$(cpp_echo) $(src)TileRawCorrelatedNoise.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawCorrelatedNoise_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawCorrelatedNoise_cppflags) $(TileRawCorrelatedNoise_cxx_cppflags)  $(src)TileRawCorrelatedNoise.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),TileRecUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TileRawChannelBuilderOptFilter.d

$(bin)$(binobj)TileRawChannelBuilderOptFilter.d :

$(bin)$(binobj)TileRawChannelBuilderOptFilter.o : $(cmt_final_setup_TileRecUtilsLib)

$(bin)$(binobj)TileRawChannelBuilderOptFilter.o : $(src)TileRawChannelBuilderOptFilter.cxx
	$(cpp_echo) $(src)TileRawChannelBuilderOptFilter.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderOptFilter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderOptFilter_cppflags) $(TileRawChannelBuilderOptFilter_cxx_cppflags)  $(src)TileRawChannelBuilderOptFilter.cxx
endif
endif

else
$(bin)TileRecUtilsLib_dependencies.make : $(TileRawChannelBuilderOptFilter_cxx_dependencies)

$(bin)TileRecUtilsLib_dependencies.make : $(src)TileRawChannelBuilderOptFilter.cxx

$(bin)$(binobj)TileRawChannelBuilderOptFilter.o : $(TileRawChannelBuilderOptFilter_cxx_dependencies)
	$(cpp_echo) $(src)TileRawChannelBuilderOptFilter.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(TileRecUtilsLib_pp_cppflags) $(lib_TileRecUtilsLib_pp_cppflags) $(TileRawChannelBuilderOptFilter_pp_cppflags) $(use_cppflags) $(TileRecUtilsLib_cppflags) $(lib_TileRecUtilsLib_cppflags) $(TileRawChannelBuilderOptFilter_cppflags) $(TileRawChannelBuilderOptFilter_cxx_cppflags)  $(src)TileRawChannelBuilderOptFilter.cxx

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: TileRecUtilsLibclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(TileRecUtilsLib.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

TileRecUtilsLibclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library TileRecUtilsLib
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)TileRecUtilsLib$(library_suffix).a $(library_prefix)TileRecUtilsLib$(library_suffix).$(shlibsuffix) TileRecUtilsLib.stamp TileRecUtilsLib.shstamp
#-- end of cleanup_library ---------------
