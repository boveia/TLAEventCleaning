#-- start of make_header -----------------

#====================================
#  Library LArCellRec
#
#   Generated Wed Dec 16 17:21:42 2015  by boveia
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_LArCellRec_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_LArCellRec_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_LArCellRec

LArCellRec_tag = $(tag)

#cmt_local_tagfile_LArCellRec = $(LArCellRec_tag)_LArCellRec.make
cmt_local_tagfile_LArCellRec = $(bin)$(LArCellRec_tag)_LArCellRec.make

else

tags      = $(tag),$(CMTEXTRATAGS)

LArCellRec_tag = $(tag)

#cmt_local_tagfile_LArCellRec = $(LArCellRec_tag).make
cmt_local_tagfile_LArCellRec = $(bin)$(LArCellRec_tag).make

endif

include $(cmt_local_tagfile_LArCellRec)
#-include $(cmt_local_tagfile_LArCellRec)

ifdef cmt_LArCellRec_has_target_tag

cmt_final_setup_LArCellRec = $(bin)setup_LArCellRec.make
cmt_dependencies_in_LArCellRec = $(bin)dependencies_LArCellRec.in
#cmt_final_setup_LArCellRec = $(bin)LArCellRec_LArCellRecsetup.make
cmt_local_LArCellRec_makefile = $(bin)LArCellRec.make

else

cmt_final_setup_LArCellRec = $(bin)setup.make
cmt_dependencies_in_LArCellRec = $(bin)dependencies.in
#cmt_final_setup_LArCellRec = $(bin)LArCellRecsetup.make
cmt_local_LArCellRec_makefile = $(bin)LArCellRec.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)LArCellRecsetup.make

#LArCellRec :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'LArCellRec'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = LArCellRec/
#LArCellRec::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

LArCellReclibname   = $(bin)$(library_prefix)LArCellRec$(library_suffix)
LArCellReclib       = $(LArCellReclibname).a
LArCellRecstamp     = $(bin)LArCellRec.stamp
LArCellRecshstamp   = $(bin)LArCellRec.shstamp

LArCellRec :: dirs  LArCellRecLIB
	$(echo) "LArCellRec ok"

#-- end of libary_header ----------------
#-- start of library_no_static ------

#LArCellRecLIB :: $(LArCellReclib) $(LArCellRecshstamp)
LArCellRecLIB :: $(LArCellRecshstamp)
	$(echo) "LArCellRec : library ok"

$(LArCellReclib) :: $(bin)LArG3Escale.o $(bin)LArCellDeadOTXCorr.o $(bin)LArG3Escale_TDR.o $(bin)LArCollisionTimeAlg.o $(bin)LArNoisyROAlg.o $(bin)LArNonLinearity.o $(bin)LArCellBuilderFromLArRawChannelTool.o $(bin)LArCellEmMiscalib.o $(bin)LArBadFebMaskingTool.o $(bin)LArTimeVetoAlg.o $(bin)LArCellRecalibration.o $(bin)LArCellHVCorr.o $(bin)LArCellGainPathology.o $(bin)LArCellNoiseMaskingTool.o $(bin)LArNoisyROTool.o $(bin)LArCellBuilderFromLArHitTool.o $(bin)LArCellRescaler.o $(bin)LArCellMaskingTool.o $(bin)LArCellMerger.o $(bin)LArCellRec_load.o $(bin)LArCellRec_entries.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(LArCellReclib) $?
	$(lib_silent) $(ranlib) $(LArCellReclib)
	$(lib_silent) cat /dev/null >$(LArCellRecstamp)

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

$(LArCellReclibname).$(shlibsuffix) :: $(bin)LArG3Escale.o $(bin)LArCellDeadOTXCorr.o $(bin)LArG3Escale_TDR.o $(bin)LArCollisionTimeAlg.o $(bin)LArNoisyROAlg.o $(bin)LArNonLinearity.o $(bin)LArCellBuilderFromLArRawChannelTool.o $(bin)LArCellEmMiscalib.o $(bin)LArBadFebMaskingTool.o $(bin)LArTimeVetoAlg.o $(bin)LArCellRecalibration.o $(bin)LArCellHVCorr.o $(bin)LArCellGainPathology.o $(bin)LArCellNoiseMaskingTool.o $(bin)LArNoisyROTool.o $(bin)LArCellBuilderFromLArHitTool.o $(bin)LArCellRescaler.o $(bin)LArCellMaskingTool.o $(bin)LArCellMerger.o $(bin)LArCellRec_load.o $(bin)LArCellRec_entries.o $(use_requirements) $(LArCellRecstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)LArG3Escale.o $(bin)LArCellDeadOTXCorr.o $(bin)LArG3Escale_TDR.o $(bin)LArCollisionTimeAlg.o $(bin)LArNoisyROAlg.o $(bin)LArNonLinearity.o $(bin)LArCellBuilderFromLArRawChannelTool.o $(bin)LArCellEmMiscalib.o $(bin)LArBadFebMaskingTool.o $(bin)LArTimeVetoAlg.o $(bin)LArCellRecalibration.o $(bin)LArCellHVCorr.o $(bin)LArCellGainPathology.o $(bin)LArCellNoiseMaskingTool.o $(bin)LArNoisyROTool.o $(bin)LArCellBuilderFromLArHitTool.o $(bin)LArCellRescaler.o $(bin)LArCellMaskingTool.o $(bin)LArCellMerger.o $(bin)LArCellRec_load.o $(bin)LArCellRec_entries.o $(LArCellRec_shlibflags)
	$(lib_silent) cat /dev/null >$(LArCellRecstamp) && \
	  cat /dev/null >$(LArCellRecshstamp)

$(LArCellRecshstamp) :: $(LArCellReclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(LArCellReclibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(LArCellRecstamp) && \
	  cat /dev/null >$(LArCellRecshstamp) ; fi

LArCellRecclean ::
	$(cleanup_echo) objects LArCellRec
	$(cleanup_silent) /bin/rm -f $(bin)LArG3Escale.o $(bin)LArCellDeadOTXCorr.o $(bin)LArG3Escale_TDR.o $(bin)LArCollisionTimeAlg.o $(bin)LArNoisyROAlg.o $(bin)LArNonLinearity.o $(bin)LArCellBuilderFromLArRawChannelTool.o $(bin)LArCellEmMiscalib.o $(bin)LArBadFebMaskingTool.o $(bin)LArTimeVetoAlg.o $(bin)LArCellRecalibration.o $(bin)LArCellHVCorr.o $(bin)LArCellGainPathology.o $(bin)LArCellNoiseMaskingTool.o $(bin)LArNoisyROTool.o $(bin)LArCellBuilderFromLArHitTool.o $(bin)LArCellRescaler.o $(bin)LArCellMaskingTool.o $(bin)LArCellMerger.o $(bin)LArCellRec_load.o $(bin)LArCellRec_entries.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)LArG3Escale.o $(bin)LArCellDeadOTXCorr.o $(bin)LArG3Escale_TDR.o $(bin)LArCollisionTimeAlg.o $(bin)LArNoisyROAlg.o $(bin)LArNonLinearity.o $(bin)LArCellBuilderFromLArRawChannelTool.o $(bin)LArCellEmMiscalib.o $(bin)LArBadFebMaskingTool.o $(bin)LArTimeVetoAlg.o $(bin)LArCellRecalibration.o $(bin)LArCellHVCorr.o $(bin)LArCellGainPathology.o $(bin)LArCellNoiseMaskingTool.o $(bin)LArNoisyROTool.o $(bin)LArCellBuilderFromLArHitTool.o $(bin)LArCellRescaler.o $(bin)LArCellMaskingTool.o $(bin)LArCellMerger.o $(bin)LArCellRec_load.o $(bin)LArCellRec_entries.o) $(patsubst %.o,%.dep,$(bin)LArG3Escale.o $(bin)LArCellDeadOTXCorr.o $(bin)LArG3Escale_TDR.o $(bin)LArCollisionTimeAlg.o $(bin)LArNoisyROAlg.o $(bin)LArNonLinearity.o $(bin)LArCellBuilderFromLArRawChannelTool.o $(bin)LArCellEmMiscalib.o $(bin)LArBadFebMaskingTool.o $(bin)LArTimeVetoAlg.o $(bin)LArCellRecalibration.o $(bin)LArCellHVCorr.o $(bin)LArCellGainPathology.o $(bin)LArCellNoiseMaskingTool.o $(bin)LArNoisyROTool.o $(bin)LArCellBuilderFromLArHitTool.o $(bin)LArCellRescaler.o $(bin)LArCellMaskingTool.o $(bin)LArCellMerger.o $(bin)LArCellRec_load.o $(bin)LArCellRec_entries.o) $(patsubst %.o,%.d.stamp,$(bin)LArG3Escale.o $(bin)LArCellDeadOTXCorr.o $(bin)LArG3Escale_TDR.o $(bin)LArCollisionTimeAlg.o $(bin)LArNoisyROAlg.o $(bin)LArNonLinearity.o $(bin)LArCellBuilderFromLArRawChannelTool.o $(bin)LArCellEmMiscalib.o $(bin)LArBadFebMaskingTool.o $(bin)LArTimeVetoAlg.o $(bin)LArCellRecalibration.o $(bin)LArCellHVCorr.o $(bin)LArCellGainPathology.o $(bin)LArCellNoiseMaskingTool.o $(bin)LArNoisyROTool.o $(bin)LArCellBuilderFromLArHitTool.o $(bin)LArCellRescaler.o $(bin)LArCellMaskingTool.o $(bin)LArCellMerger.o $(bin)LArCellRec_load.o $(bin)LArCellRec_entries.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf LArCellRec_deps LArCellRec_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
LArCellRecinstallname = $(library_prefix)LArCellRec$(library_suffix).$(shlibsuffix)

LArCellRec :: LArCellRecinstall ;

install :: LArCellRecinstall ;

LArCellRecinstall :: $(install_dir)/$(LArCellRecinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(LArCellRecinstallname) :: $(bin)$(LArCellRecinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(LArCellRecinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##LArCellRecclean :: LArCellRecuninstall

uninstall :: LArCellRecuninstall ;

LArCellRecuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(LArCellRecinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArG3Escale.d

$(bin)$(binobj)LArG3Escale.d :

$(bin)$(binobj)LArG3Escale.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArG3Escale.o : $(src)LArG3Escale.cxx
	$(cpp_echo) $(src)LArG3Escale.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArG3Escale_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArG3Escale_cppflags) $(LArG3Escale_cxx_cppflags)  $(src)LArG3Escale.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArG3Escale_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArG3Escale.cxx

$(bin)$(binobj)LArG3Escale.o : $(LArG3Escale_cxx_dependencies)
	$(cpp_echo) $(src)LArG3Escale.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArG3Escale_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArG3Escale_cppflags) $(LArG3Escale_cxx_cppflags)  $(src)LArG3Escale.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCellDeadOTXCorr.d

$(bin)$(binobj)LArCellDeadOTXCorr.d :

$(bin)$(binobj)LArCellDeadOTXCorr.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCellDeadOTXCorr.o : $(src)LArCellDeadOTXCorr.cxx
	$(cpp_echo) $(src)LArCellDeadOTXCorr.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellDeadOTXCorr_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellDeadOTXCorr_cppflags) $(LArCellDeadOTXCorr_cxx_cppflags)  $(src)LArCellDeadOTXCorr.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCellDeadOTXCorr_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArCellDeadOTXCorr.cxx

$(bin)$(binobj)LArCellDeadOTXCorr.o : $(LArCellDeadOTXCorr_cxx_dependencies)
	$(cpp_echo) $(src)LArCellDeadOTXCorr.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellDeadOTXCorr_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellDeadOTXCorr_cppflags) $(LArCellDeadOTXCorr_cxx_cppflags)  $(src)LArCellDeadOTXCorr.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArG3Escale_TDR.d

$(bin)$(binobj)LArG3Escale_TDR.d :

$(bin)$(binobj)LArG3Escale_TDR.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArG3Escale_TDR.o : $(src)LArG3Escale_TDR.cxx
	$(cpp_echo) $(src)LArG3Escale_TDR.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArG3Escale_TDR_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArG3Escale_TDR_cppflags) $(LArG3Escale_TDR_cxx_cppflags)  $(src)LArG3Escale_TDR.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArG3Escale_TDR_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArG3Escale_TDR.cxx

$(bin)$(binobj)LArG3Escale_TDR.o : $(LArG3Escale_TDR_cxx_dependencies)
	$(cpp_echo) $(src)LArG3Escale_TDR.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArG3Escale_TDR_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArG3Escale_TDR_cppflags) $(LArG3Escale_TDR_cxx_cppflags)  $(src)LArG3Escale_TDR.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCollisionTimeAlg.d

$(bin)$(binobj)LArCollisionTimeAlg.d :

$(bin)$(binobj)LArCollisionTimeAlg.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCollisionTimeAlg.o : $(src)LArCollisionTimeAlg.cxx
	$(cpp_echo) $(src)LArCollisionTimeAlg.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCollisionTimeAlg_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCollisionTimeAlg_cppflags) $(LArCollisionTimeAlg_cxx_cppflags)  $(src)LArCollisionTimeAlg.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCollisionTimeAlg_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArCollisionTimeAlg.cxx

$(bin)$(binobj)LArCollisionTimeAlg.o : $(LArCollisionTimeAlg_cxx_dependencies)
	$(cpp_echo) $(src)LArCollisionTimeAlg.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCollisionTimeAlg_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCollisionTimeAlg_cppflags) $(LArCollisionTimeAlg_cxx_cppflags)  $(src)LArCollisionTimeAlg.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArNoisyROAlg.d

$(bin)$(binobj)LArNoisyROAlg.d :

$(bin)$(binobj)LArNoisyROAlg.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArNoisyROAlg.o : $(src)LArNoisyROAlg.cxx
	$(cpp_echo) $(src)LArNoisyROAlg.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArNoisyROAlg_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArNoisyROAlg_cppflags) $(LArNoisyROAlg_cxx_cppflags)  $(src)LArNoisyROAlg.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArNoisyROAlg_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArNoisyROAlg.cxx

$(bin)$(binobj)LArNoisyROAlg.o : $(LArNoisyROAlg_cxx_dependencies)
	$(cpp_echo) $(src)LArNoisyROAlg.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArNoisyROAlg_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArNoisyROAlg_cppflags) $(LArNoisyROAlg_cxx_cppflags)  $(src)LArNoisyROAlg.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArNonLinearity.d

$(bin)$(binobj)LArNonLinearity.d :

$(bin)$(binobj)LArNonLinearity.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArNonLinearity.o : $(src)LArNonLinearity.cxx
	$(cpp_echo) $(src)LArNonLinearity.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArNonLinearity_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArNonLinearity_cppflags) $(LArNonLinearity_cxx_cppflags)  $(src)LArNonLinearity.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArNonLinearity_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArNonLinearity.cxx

$(bin)$(binobj)LArNonLinearity.o : $(LArNonLinearity_cxx_dependencies)
	$(cpp_echo) $(src)LArNonLinearity.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArNonLinearity_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArNonLinearity_cppflags) $(LArNonLinearity_cxx_cppflags)  $(src)LArNonLinearity.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCellBuilderFromLArRawChannelTool.d

$(bin)$(binobj)LArCellBuilderFromLArRawChannelTool.d :

$(bin)$(binobj)LArCellBuilderFromLArRawChannelTool.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCellBuilderFromLArRawChannelTool.o : $(src)LArCellBuilderFromLArRawChannelTool.cxx
	$(cpp_echo) $(src)LArCellBuilderFromLArRawChannelTool.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellBuilderFromLArRawChannelTool_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellBuilderFromLArRawChannelTool_cppflags) $(LArCellBuilderFromLArRawChannelTool_cxx_cppflags)  $(src)LArCellBuilderFromLArRawChannelTool.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCellBuilderFromLArRawChannelTool_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArCellBuilderFromLArRawChannelTool.cxx

$(bin)$(binobj)LArCellBuilderFromLArRawChannelTool.o : $(LArCellBuilderFromLArRawChannelTool_cxx_dependencies)
	$(cpp_echo) $(src)LArCellBuilderFromLArRawChannelTool.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellBuilderFromLArRawChannelTool_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellBuilderFromLArRawChannelTool_cppflags) $(LArCellBuilderFromLArRawChannelTool_cxx_cppflags)  $(src)LArCellBuilderFromLArRawChannelTool.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCellEmMiscalib.d

$(bin)$(binobj)LArCellEmMiscalib.d :

$(bin)$(binobj)LArCellEmMiscalib.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCellEmMiscalib.o : $(src)LArCellEmMiscalib.cxx
	$(cpp_echo) $(src)LArCellEmMiscalib.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellEmMiscalib_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellEmMiscalib_cppflags) $(LArCellEmMiscalib_cxx_cppflags)  $(src)LArCellEmMiscalib.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCellEmMiscalib_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArCellEmMiscalib.cxx

$(bin)$(binobj)LArCellEmMiscalib.o : $(LArCellEmMiscalib_cxx_dependencies)
	$(cpp_echo) $(src)LArCellEmMiscalib.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellEmMiscalib_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellEmMiscalib_cppflags) $(LArCellEmMiscalib_cxx_cppflags)  $(src)LArCellEmMiscalib.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArBadFebMaskingTool.d

$(bin)$(binobj)LArBadFebMaskingTool.d :

$(bin)$(binobj)LArBadFebMaskingTool.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArBadFebMaskingTool.o : $(src)LArBadFebMaskingTool.cxx
	$(cpp_echo) $(src)LArBadFebMaskingTool.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArBadFebMaskingTool_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArBadFebMaskingTool_cppflags) $(LArBadFebMaskingTool_cxx_cppflags)  $(src)LArBadFebMaskingTool.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArBadFebMaskingTool_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArBadFebMaskingTool.cxx

$(bin)$(binobj)LArBadFebMaskingTool.o : $(LArBadFebMaskingTool_cxx_dependencies)
	$(cpp_echo) $(src)LArBadFebMaskingTool.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArBadFebMaskingTool_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArBadFebMaskingTool_cppflags) $(LArBadFebMaskingTool_cxx_cppflags)  $(src)LArBadFebMaskingTool.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArTimeVetoAlg.d

$(bin)$(binobj)LArTimeVetoAlg.d :

$(bin)$(binobj)LArTimeVetoAlg.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArTimeVetoAlg.o : $(src)LArTimeVetoAlg.cxx
	$(cpp_echo) $(src)LArTimeVetoAlg.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArTimeVetoAlg_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArTimeVetoAlg_cppflags) $(LArTimeVetoAlg_cxx_cppflags)  $(src)LArTimeVetoAlg.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArTimeVetoAlg_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArTimeVetoAlg.cxx

$(bin)$(binobj)LArTimeVetoAlg.o : $(LArTimeVetoAlg_cxx_dependencies)
	$(cpp_echo) $(src)LArTimeVetoAlg.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArTimeVetoAlg_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArTimeVetoAlg_cppflags) $(LArTimeVetoAlg_cxx_cppflags)  $(src)LArTimeVetoAlg.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCellRecalibration.d

$(bin)$(binobj)LArCellRecalibration.d :

$(bin)$(binobj)LArCellRecalibration.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCellRecalibration.o : $(src)LArCellRecalibration.cxx
	$(cpp_echo) $(src)LArCellRecalibration.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellRecalibration_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellRecalibration_cppflags) $(LArCellRecalibration_cxx_cppflags)  $(src)LArCellRecalibration.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCellRecalibration_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArCellRecalibration.cxx

$(bin)$(binobj)LArCellRecalibration.o : $(LArCellRecalibration_cxx_dependencies)
	$(cpp_echo) $(src)LArCellRecalibration.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellRecalibration_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellRecalibration_cppflags) $(LArCellRecalibration_cxx_cppflags)  $(src)LArCellRecalibration.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCellHVCorr.d

$(bin)$(binobj)LArCellHVCorr.d :

$(bin)$(binobj)LArCellHVCorr.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCellHVCorr.o : $(src)LArCellHVCorr.cxx
	$(cpp_echo) $(src)LArCellHVCorr.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellHVCorr_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellHVCorr_cppflags) $(LArCellHVCorr_cxx_cppflags)  $(src)LArCellHVCorr.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCellHVCorr_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArCellHVCorr.cxx

$(bin)$(binobj)LArCellHVCorr.o : $(LArCellHVCorr_cxx_dependencies)
	$(cpp_echo) $(src)LArCellHVCorr.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellHVCorr_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellHVCorr_cppflags) $(LArCellHVCorr_cxx_cppflags)  $(src)LArCellHVCorr.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCellGainPathology.d

$(bin)$(binobj)LArCellGainPathology.d :

$(bin)$(binobj)LArCellGainPathology.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCellGainPathology.o : $(src)LArCellGainPathology.cxx
	$(cpp_echo) $(src)LArCellGainPathology.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellGainPathology_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellGainPathology_cppflags) $(LArCellGainPathology_cxx_cppflags)  $(src)LArCellGainPathology.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCellGainPathology_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArCellGainPathology.cxx

$(bin)$(binobj)LArCellGainPathology.o : $(LArCellGainPathology_cxx_dependencies)
	$(cpp_echo) $(src)LArCellGainPathology.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellGainPathology_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellGainPathology_cppflags) $(LArCellGainPathology_cxx_cppflags)  $(src)LArCellGainPathology.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCellNoiseMaskingTool.d

$(bin)$(binobj)LArCellNoiseMaskingTool.d :

$(bin)$(binobj)LArCellNoiseMaskingTool.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCellNoiseMaskingTool.o : $(src)LArCellNoiseMaskingTool.cxx
	$(cpp_echo) $(src)LArCellNoiseMaskingTool.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellNoiseMaskingTool_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellNoiseMaskingTool_cppflags) $(LArCellNoiseMaskingTool_cxx_cppflags)  $(src)LArCellNoiseMaskingTool.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCellNoiseMaskingTool_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArCellNoiseMaskingTool.cxx

$(bin)$(binobj)LArCellNoiseMaskingTool.o : $(LArCellNoiseMaskingTool_cxx_dependencies)
	$(cpp_echo) $(src)LArCellNoiseMaskingTool.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellNoiseMaskingTool_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellNoiseMaskingTool_cppflags) $(LArCellNoiseMaskingTool_cxx_cppflags)  $(src)LArCellNoiseMaskingTool.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArNoisyROTool.d

$(bin)$(binobj)LArNoisyROTool.d :

$(bin)$(binobj)LArNoisyROTool.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArNoisyROTool.o : $(src)LArNoisyROTool.cxx
	$(cpp_echo) $(src)LArNoisyROTool.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArNoisyROTool_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArNoisyROTool_cppflags) $(LArNoisyROTool_cxx_cppflags)  $(src)LArNoisyROTool.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArNoisyROTool_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArNoisyROTool.cxx

$(bin)$(binobj)LArNoisyROTool.o : $(LArNoisyROTool_cxx_dependencies)
	$(cpp_echo) $(src)LArNoisyROTool.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArNoisyROTool_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArNoisyROTool_cppflags) $(LArNoisyROTool_cxx_cppflags)  $(src)LArNoisyROTool.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCellBuilderFromLArHitTool.d

$(bin)$(binobj)LArCellBuilderFromLArHitTool.d :

$(bin)$(binobj)LArCellBuilderFromLArHitTool.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCellBuilderFromLArHitTool.o : $(src)LArCellBuilderFromLArHitTool.cxx
	$(cpp_echo) $(src)LArCellBuilderFromLArHitTool.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellBuilderFromLArHitTool_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellBuilderFromLArHitTool_cppflags) $(LArCellBuilderFromLArHitTool_cxx_cppflags)  $(src)LArCellBuilderFromLArHitTool.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCellBuilderFromLArHitTool_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArCellBuilderFromLArHitTool.cxx

$(bin)$(binobj)LArCellBuilderFromLArHitTool.o : $(LArCellBuilderFromLArHitTool_cxx_dependencies)
	$(cpp_echo) $(src)LArCellBuilderFromLArHitTool.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellBuilderFromLArHitTool_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellBuilderFromLArHitTool_cppflags) $(LArCellBuilderFromLArHitTool_cxx_cppflags)  $(src)LArCellBuilderFromLArHitTool.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCellRescaler.d

$(bin)$(binobj)LArCellRescaler.d :

$(bin)$(binobj)LArCellRescaler.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCellRescaler.o : $(src)LArCellRescaler.cxx
	$(cpp_echo) $(src)LArCellRescaler.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellRescaler_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellRescaler_cppflags) $(LArCellRescaler_cxx_cppflags)  $(src)LArCellRescaler.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCellRescaler_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArCellRescaler.cxx

$(bin)$(binobj)LArCellRescaler.o : $(LArCellRescaler_cxx_dependencies)
	$(cpp_echo) $(src)LArCellRescaler.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellRescaler_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellRescaler_cppflags) $(LArCellRescaler_cxx_cppflags)  $(src)LArCellRescaler.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCellMaskingTool.d

$(bin)$(binobj)LArCellMaskingTool.d :

$(bin)$(binobj)LArCellMaskingTool.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCellMaskingTool.o : $(src)LArCellMaskingTool.cxx
	$(cpp_echo) $(src)LArCellMaskingTool.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellMaskingTool_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellMaskingTool_cppflags) $(LArCellMaskingTool_cxx_cppflags)  $(src)LArCellMaskingTool.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCellMaskingTool_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArCellMaskingTool.cxx

$(bin)$(binobj)LArCellMaskingTool.o : $(LArCellMaskingTool_cxx_dependencies)
	$(cpp_echo) $(src)LArCellMaskingTool.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellMaskingTool_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellMaskingTool_cppflags) $(LArCellMaskingTool_cxx_cppflags)  $(src)LArCellMaskingTool.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCellMerger.d

$(bin)$(binobj)LArCellMerger.d :

$(bin)$(binobj)LArCellMerger.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCellMerger.o : $(src)LArCellMerger.cxx
	$(cpp_echo) $(src)LArCellMerger.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellMerger_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellMerger_cppflags) $(LArCellMerger_cxx_cppflags)  $(src)LArCellMerger.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCellMerger_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)LArCellMerger.cxx

$(bin)$(binobj)LArCellMerger.o : $(LArCellMerger_cxx_dependencies)
	$(cpp_echo) $(src)LArCellMerger.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellMerger_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellMerger_cppflags) $(LArCellMerger_cxx_cppflags)  $(src)LArCellMerger.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCellRec_load.d

$(bin)$(binobj)LArCellRec_load.d :

$(bin)$(binobj)LArCellRec_load.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCellRec_load.o : $(src)components/LArCellRec_load.cxx
	$(cpp_echo) $(src)components/LArCellRec_load.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellRec_load_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellRec_load_cppflags) $(LArCellRec_load_cxx_cppflags) -I../src/components $(src)components/LArCellRec_load.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCellRec_load_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)components/LArCellRec_load.cxx

$(bin)$(binobj)LArCellRec_load.o : $(LArCellRec_load_cxx_dependencies)
	$(cpp_echo) $(src)components/LArCellRec_load.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellRec_load_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellRec_load_cppflags) $(LArCellRec_load_cxx_cppflags) -I../src/components $(src)components/LArCellRec_load.cxx

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),LArCellRecclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LArCellRec_entries.d

$(bin)$(binobj)LArCellRec_entries.d :

$(bin)$(binobj)LArCellRec_entries.o : $(cmt_final_setup_LArCellRec)

$(bin)$(binobj)LArCellRec_entries.o : $(src)components/LArCellRec_entries.cxx
	$(cpp_echo) $(src)components/LArCellRec_entries.cxx
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellRec_entries_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellRec_entries_cppflags) $(LArCellRec_entries_cxx_cppflags) -I../src/components $(src)components/LArCellRec_entries.cxx
endif
endif

else
$(bin)LArCellRec_dependencies.make : $(LArCellRec_entries_cxx_dependencies)

$(bin)LArCellRec_dependencies.make : $(src)components/LArCellRec_entries.cxx

$(bin)$(binobj)LArCellRec_entries.o : $(LArCellRec_entries_cxx_dependencies)
	$(cpp_echo) $(src)components/LArCellRec_entries.cxx
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(LArCellRec_pp_cppflags) $(lib_LArCellRec_pp_cppflags) $(LArCellRec_entries_pp_cppflags) $(use_cppflags) $(LArCellRec_cppflags) $(lib_LArCellRec_cppflags) $(LArCellRec_entries_cppflags) $(LArCellRec_entries_cxx_cppflags) -I../src/components $(src)components/LArCellRec_entries.cxx

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: LArCellRecclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(LArCellRec.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

LArCellRecclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library LArCellRec
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)LArCellRec$(library_suffix).a $(library_prefix)LArCellRec$(library_suffix).$(shlibsuffix) LArCellRec.stamp LArCellRec.shstamp
#-- end of cleanup_library ---------------
