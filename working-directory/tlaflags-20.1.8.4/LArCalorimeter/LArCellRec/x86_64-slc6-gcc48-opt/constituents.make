
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

LArCellRec_tag = $(tag)

#cmt_local_tagfile = $(LArCellRec_tag).make
cmt_local_tagfile = $(bin)$(LArCellRec_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)LArCellRecsetup.make
cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)$(package)setup.make

cmt_build_library_linksstamp = $(bin)cmt_build_library_links.stamp
#--------------------------------------------------------

#cmt_lock_setup = /tmp/lock$(cmt_lock_pid).make
#cmt_temp_tag = /tmp/tag$(cmt_lock_pid).make

#first :: $(cmt_local_tagfile)
#	@echo $(cmt_local_tagfile) ok
#ifndef QUICK
#first :: $(cmt_final_setup) ;
#else
#first :: ;
#endif

##	@bin=`$(cmtexe) show macro_value bin`

#$(cmt_local_tagfile) : $(cmt_lock_setup)
#	@echo "#CMT> Error: $@: No such file" >&2; exit 1
#$(cmt_local_tagfile) :
#	@echo "#CMT> Warning: $@: No such file" >&2; exit
#	@echo "#CMT> Info: $@: No need to rebuild file" >&2; exit

#$(cmt_final_setup) : $(cmt_local_tagfile) 
#	$(echo) "(constituents.make) Rebuilding $@"
#	@if test ! -d $(@D); then $(mkdir) -p $(@D); fi; \
#	  if test -f $(cmt_local_setup); then /bin/rm -f $(cmt_local_setup); fi; \
#	  trap '/bin/rm -f $(cmt_local_setup)' 0 1 2 15; \
#	  $(cmtexe) -tag=$(tags) show setup >>$(cmt_local_setup); \
#	  if test ! -f $@; then \
#	    mv $(cmt_local_setup) $@; \
#	  else \
#	    if /usr/bin/diff $(cmt_local_setup) $@ >/dev/null ; then \
#	      : ; \
#	    else \
#	      mv $(cmt_local_setup) $@; \
#	    fi; \
#	  fi

#	@/bin/echo $@ ok   

#config :: checkuses
#	@exit 0
#checkuses : ;

env.make ::
	printenv >env.make.tmp; $(cmtexe) check files env.make.tmp env.make

ifndef QUICK
all :: build_library_links ;
else
all :: $(cmt_build_library_linksstamp) ;
endif

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

dirs :: requirements
	@if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi
#	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
#	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

#requirements :
#	@if test ! -r requirements ; then echo "No requirements file" ; fi

build_library_links : dirs
	$(echo) "(constituents.make) Rebuilding library links"; \
	 $(build_library_links)
#	if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi; \
#	$(build_library_links)

$(cmt_build_library_linksstamp) : $(cmt_final_setup) $(cmt_local_tagfile) $(bin)library_links.in
	$(echo) "(constituents.make) Rebuilding library links"; \
	 $(build_library_links) -f=$(bin)library_links.in -without_cmt
	$(silent) \touch $@

ifndef PEDANTIC
.DEFAULT ::
#.DEFAULT :
	$(echo) "(constituents.make) $@: No rule for such target" >&2
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of constituents_header ------
#-- start of group ------

all_groups :: all

all :: $(all_dependencies)  $(all_pre_constituents) $(all_constituents)  $(all_post_constituents)
	$(echo) "all ok."

#	@/bin/echo " all ok."

clean :: allclean

allclean ::  $(all_constituentsclean)
	$(echo) $(all_constituentsclean)
	$(echo) "allclean ok."

#	@echo $(all_constituentsclean)
#	@/bin/echo " allclean ok."

#-- end of group ------
#-- start of group ------

all_groups :: cmt_actions

cmt_actions :: $(cmt_actions_dependencies)  $(cmt_actions_pre_constituents) $(cmt_actions_constituents)  $(cmt_actions_post_constituents)
	$(echo) "cmt_actions ok."

#	@/bin/echo " cmt_actions ok."

clean :: allclean

cmt_actionsclean ::  $(cmt_actions_constituentsclean)
	$(echo) $(cmt_actions_constituentsclean)
	$(echo) "cmt_actionsclean ok."

#	@echo $(cmt_actions_constituentsclean)
#	@/bin/echo " cmt_actionsclean ok."

#-- end of group ------
#-- start of group ------

all_groups :: rulechecker

rulechecker :: $(rulechecker_dependencies)  $(rulechecker_pre_constituents) $(rulechecker_constituents)  $(rulechecker_post_constituents)
	$(echo) "rulechecker ok."

#	@/bin/echo " rulechecker ok."

clean :: allclean

rulecheckerclean ::  $(rulechecker_constituentsclean)
	$(echo) $(rulechecker_constituentsclean)
	$(echo) "rulecheckerclean ok."

#	@echo $(rulechecker_constituentsclean)
#	@/bin/echo " rulecheckerclean ok."

#-- end of group ------
#-- start of constituent ------

cmt_LArCellRec_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_LArCellRec_has_target_tag

cmt_local_tagfile_LArCellRec = $(bin)$(LArCellRec_tag)_LArCellRec.make
cmt_final_setup_LArCellRec = $(bin)setup_LArCellRec.make
cmt_local_LArCellRec_makefile = $(bin)LArCellRec.make

LArCellRec_extratags = -tag_add=target_LArCellRec

else

cmt_local_tagfile_LArCellRec = $(bin)$(LArCellRec_tag).make
cmt_final_setup_LArCellRec = $(bin)setup.make
cmt_local_LArCellRec_makefile = $(bin)LArCellRec.make

endif

not_LArCellRec_dependencies = { n=0; for p in $?; do m=0; for d in $(LArCellRec_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
LArCellRecdirs :
	@if test ! -d $(bin)LArCellRec; then $(mkdir) -p $(bin)LArCellRec; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)LArCellRec
else
LArCellRecdirs : ;
endif

ifdef cmt_LArCellRec_has_target_tag

ifndef QUICK
$(cmt_local_LArCellRec_makefile) : $(LArCellRec_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRec.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRec_extratags) build constituent_config -out=$(cmt_local_LArCellRec_makefile) LArCellRec
else
$(cmt_local_LArCellRec_makefile) : $(LArCellRec_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRec) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRec) ] || \
	  $(not_LArCellRec_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRec.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRec_extratags) build constituent_config -out=$(cmt_local_LArCellRec_makefile) LArCellRec; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_LArCellRec_makefile) : $(LArCellRec_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRec.make"; \
	  $(cmtexe) -f=$(bin)LArCellRec.in -tag=$(tags) $(LArCellRec_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRec_makefile) LArCellRec
else
$(cmt_local_LArCellRec_makefile) : $(LArCellRec_dependencies) $(cmt_build_library_linksstamp) $(bin)LArCellRec.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRec) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRec) ] || \
	  $(not_LArCellRec_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRec.make"; \
	  $(cmtexe) -f=$(bin)LArCellRec.in -tag=$(tags) $(LArCellRec_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRec_makefile) LArCellRec; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(LArCellRec_extratags) build constituent_makefile -out=$(cmt_local_LArCellRec_makefile) LArCellRec

LArCellRec :: $(LArCellRec_dependencies) $(cmt_local_LArCellRec_makefile) dirs LArCellRecdirs
	$(echo) "(constituents.make) Starting LArCellRec"
	@if test -f $(cmt_local_LArCellRec_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_makefile) LArCellRec; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRec_makefile) LArCellRec
	$(echo) "(constituents.make) LArCellRec done"

clean :: LArCellRecclean ;

LArCellRecclean :: $(LArCellRecclean_dependencies) ##$(cmt_local_LArCellRec_makefile)
	$(echo) "(constituents.make) Starting LArCellRecclean"
	@-if test -f $(cmt_local_LArCellRec_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_makefile) LArCellRecclean; \
	fi
	$(echo) "(constituents.make) LArCellRecclean done"
#	@-$(MAKE) -f $(cmt_local_LArCellRec_makefile) LArCellRecclean

##	  /bin/rm -f $(cmt_local_LArCellRec_makefile) $(bin)LArCellRec_dependencies.make

install :: LArCellRecinstall ;

LArCellRecinstall :: $(LArCellRec_dependencies) $(cmt_local_LArCellRec_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_LArCellRec_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_LArCellRec_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : LArCellRecuninstall

$(foreach d,$(LArCellRec_dependencies),$(eval $(d)uninstall_dependencies += LArCellRecuninstall))

LArCellRecuninstall : $(LArCellRecuninstall_dependencies) ##$(cmt_local_LArCellRec_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_LArCellRec_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRec_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: LArCellRecuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ LArCellRec"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ LArCellRec done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_LArCellRecConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_LArCellRecConf_has_target_tag

cmt_local_tagfile_LArCellRecConf = $(bin)$(LArCellRec_tag)_LArCellRecConf.make
cmt_final_setup_LArCellRecConf = $(bin)setup_LArCellRecConf.make
cmt_local_LArCellRecConf_makefile = $(bin)LArCellRecConf.make

LArCellRecConf_extratags = -tag_add=target_LArCellRecConf

else

cmt_local_tagfile_LArCellRecConf = $(bin)$(LArCellRec_tag).make
cmt_final_setup_LArCellRecConf = $(bin)setup.make
cmt_local_LArCellRecConf_makefile = $(bin)LArCellRecConf.make

endif

not_LArCellRecConf_dependencies = { n=0; for p in $?; do m=0; for d in $(LArCellRecConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
LArCellRecConfdirs :
	@if test ! -d $(bin)LArCellRecConf; then $(mkdir) -p $(bin)LArCellRecConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)LArCellRecConf
else
LArCellRecConfdirs : ;
endif

ifdef cmt_LArCellRecConf_has_target_tag

ifndef QUICK
$(cmt_local_LArCellRecConf_makefile) : $(LArCellRecConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRecConf.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRecConf_extratags) build constituent_config -out=$(cmt_local_LArCellRecConf_makefile) LArCellRecConf
else
$(cmt_local_LArCellRecConf_makefile) : $(LArCellRecConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRecConf) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRecConf) ] || \
	  $(not_LArCellRecConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRecConf.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRecConf_extratags) build constituent_config -out=$(cmt_local_LArCellRecConf_makefile) LArCellRecConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_LArCellRecConf_makefile) : $(LArCellRecConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRecConf.make"; \
	  $(cmtexe) -f=$(bin)LArCellRecConf.in -tag=$(tags) $(LArCellRecConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRecConf_makefile) LArCellRecConf
else
$(cmt_local_LArCellRecConf_makefile) : $(LArCellRecConf_dependencies) $(cmt_build_library_linksstamp) $(bin)LArCellRecConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRecConf) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRecConf) ] || \
	  $(not_LArCellRecConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRecConf.make"; \
	  $(cmtexe) -f=$(bin)LArCellRecConf.in -tag=$(tags) $(LArCellRecConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRecConf_makefile) LArCellRecConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(LArCellRecConf_extratags) build constituent_makefile -out=$(cmt_local_LArCellRecConf_makefile) LArCellRecConf

LArCellRecConf :: $(LArCellRecConf_dependencies) $(cmt_local_LArCellRecConf_makefile) dirs LArCellRecConfdirs
	$(echo) "(constituents.make) Starting LArCellRecConf"
	@if test -f $(cmt_local_LArCellRecConf_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecConf_makefile) LArCellRecConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRecConf_makefile) LArCellRecConf
	$(echo) "(constituents.make) LArCellRecConf done"

clean :: LArCellRecConfclean ;

LArCellRecConfclean :: $(LArCellRecConfclean_dependencies) ##$(cmt_local_LArCellRecConf_makefile)
	$(echo) "(constituents.make) Starting LArCellRecConfclean"
	@-if test -f $(cmt_local_LArCellRecConf_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecConf_makefile) LArCellRecConfclean; \
	fi
	$(echo) "(constituents.make) LArCellRecConfclean done"
#	@-$(MAKE) -f $(cmt_local_LArCellRecConf_makefile) LArCellRecConfclean

##	  /bin/rm -f $(cmt_local_LArCellRecConf_makefile) $(bin)LArCellRecConf_dependencies.make

install :: LArCellRecConfinstall ;

LArCellRecConfinstall :: $(LArCellRecConf_dependencies) $(cmt_local_LArCellRecConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_LArCellRecConf_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_LArCellRecConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : LArCellRecConfuninstall

$(foreach d,$(LArCellRecConf_dependencies),$(eval $(d)uninstall_dependencies += LArCellRecConfuninstall))

LArCellRecConfuninstall : $(LArCellRecConfuninstall_dependencies) ##$(cmt_local_LArCellRecConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_LArCellRecConf_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRecConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: LArCellRecConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ LArCellRecConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ LArCellRecConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_LArCellRec_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_LArCellRec_python_init_has_target_tag

cmt_local_tagfile_LArCellRec_python_init = $(bin)$(LArCellRec_tag)_LArCellRec_python_init.make
cmt_final_setup_LArCellRec_python_init = $(bin)setup_LArCellRec_python_init.make
cmt_local_LArCellRec_python_init_makefile = $(bin)LArCellRec_python_init.make

LArCellRec_python_init_extratags = -tag_add=target_LArCellRec_python_init

else

cmt_local_tagfile_LArCellRec_python_init = $(bin)$(LArCellRec_tag).make
cmt_final_setup_LArCellRec_python_init = $(bin)setup.make
cmt_local_LArCellRec_python_init_makefile = $(bin)LArCellRec_python_init.make

endif

not_LArCellRec_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(LArCellRec_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
LArCellRec_python_initdirs :
	@if test ! -d $(bin)LArCellRec_python_init; then $(mkdir) -p $(bin)LArCellRec_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)LArCellRec_python_init
else
LArCellRec_python_initdirs : ;
endif

ifdef cmt_LArCellRec_python_init_has_target_tag

ifndef QUICK
$(cmt_local_LArCellRec_python_init_makefile) : $(LArCellRec_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRec_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRec_python_init_extratags) build constituent_config -out=$(cmt_local_LArCellRec_python_init_makefile) LArCellRec_python_init
else
$(cmt_local_LArCellRec_python_init_makefile) : $(LArCellRec_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRec_python_init) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRec_python_init) ] || \
	  $(not_LArCellRec_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRec_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRec_python_init_extratags) build constituent_config -out=$(cmt_local_LArCellRec_python_init_makefile) LArCellRec_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_LArCellRec_python_init_makefile) : $(LArCellRec_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRec_python_init.make"; \
	  $(cmtexe) -f=$(bin)LArCellRec_python_init.in -tag=$(tags) $(LArCellRec_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRec_python_init_makefile) LArCellRec_python_init
else
$(cmt_local_LArCellRec_python_init_makefile) : $(LArCellRec_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)LArCellRec_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRec_python_init) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRec_python_init) ] || \
	  $(not_LArCellRec_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRec_python_init.make"; \
	  $(cmtexe) -f=$(bin)LArCellRec_python_init.in -tag=$(tags) $(LArCellRec_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRec_python_init_makefile) LArCellRec_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(LArCellRec_python_init_extratags) build constituent_makefile -out=$(cmt_local_LArCellRec_python_init_makefile) LArCellRec_python_init

LArCellRec_python_init :: $(LArCellRec_python_init_dependencies) $(cmt_local_LArCellRec_python_init_makefile) dirs LArCellRec_python_initdirs
	$(echo) "(constituents.make) Starting LArCellRec_python_init"
	@if test -f $(cmt_local_LArCellRec_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_python_init_makefile) LArCellRec_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRec_python_init_makefile) LArCellRec_python_init
	$(echo) "(constituents.make) LArCellRec_python_init done"

clean :: LArCellRec_python_initclean ;

LArCellRec_python_initclean :: $(LArCellRec_python_initclean_dependencies) ##$(cmt_local_LArCellRec_python_init_makefile)
	$(echo) "(constituents.make) Starting LArCellRec_python_initclean"
	@-if test -f $(cmt_local_LArCellRec_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_python_init_makefile) LArCellRec_python_initclean; \
	fi
	$(echo) "(constituents.make) LArCellRec_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_LArCellRec_python_init_makefile) LArCellRec_python_initclean

##	  /bin/rm -f $(cmt_local_LArCellRec_python_init_makefile) $(bin)LArCellRec_python_init_dependencies.make

install :: LArCellRec_python_initinstall ;

LArCellRec_python_initinstall :: $(LArCellRec_python_init_dependencies) $(cmt_local_LArCellRec_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_LArCellRec_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_LArCellRec_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : LArCellRec_python_inituninstall

$(foreach d,$(LArCellRec_python_init_dependencies),$(eval $(d)uninstall_dependencies += LArCellRec_python_inituninstall))

LArCellRec_python_inituninstall : $(LArCellRec_python_inituninstall_dependencies) ##$(cmt_local_LArCellRec_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_LArCellRec_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRec_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: LArCellRec_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ LArCellRec_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ LArCellRec_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_LArCellRecConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_LArCellRecConfDbMerge_has_target_tag

cmt_local_tagfile_LArCellRecConfDbMerge = $(bin)$(LArCellRec_tag)_LArCellRecConfDbMerge.make
cmt_final_setup_LArCellRecConfDbMerge = $(bin)setup_LArCellRecConfDbMerge.make
cmt_local_LArCellRecConfDbMerge_makefile = $(bin)LArCellRecConfDbMerge.make

LArCellRecConfDbMerge_extratags = -tag_add=target_LArCellRecConfDbMerge

else

cmt_local_tagfile_LArCellRecConfDbMerge = $(bin)$(LArCellRec_tag).make
cmt_final_setup_LArCellRecConfDbMerge = $(bin)setup.make
cmt_local_LArCellRecConfDbMerge_makefile = $(bin)LArCellRecConfDbMerge.make

endif

not_LArCellRecConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(LArCellRecConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
LArCellRecConfDbMergedirs :
	@if test ! -d $(bin)LArCellRecConfDbMerge; then $(mkdir) -p $(bin)LArCellRecConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)LArCellRecConfDbMerge
else
LArCellRecConfDbMergedirs : ;
endif

ifdef cmt_LArCellRecConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_LArCellRecConfDbMerge_makefile) : $(LArCellRecConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRecConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRecConfDbMerge_extratags) build constituent_config -out=$(cmt_local_LArCellRecConfDbMerge_makefile) LArCellRecConfDbMerge
else
$(cmt_local_LArCellRecConfDbMerge_makefile) : $(LArCellRecConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRecConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRecConfDbMerge) ] || \
	  $(not_LArCellRecConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRecConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRecConfDbMerge_extratags) build constituent_config -out=$(cmt_local_LArCellRecConfDbMerge_makefile) LArCellRecConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_LArCellRecConfDbMerge_makefile) : $(LArCellRecConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRecConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)LArCellRecConfDbMerge.in -tag=$(tags) $(LArCellRecConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRecConfDbMerge_makefile) LArCellRecConfDbMerge
else
$(cmt_local_LArCellRecConfDbMerge_makefile) : $(LArCellRecConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)LArCellRecConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRecConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRecConfDbMerge) ] || \
	  $(not_LArCellRecConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRecConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)LArCellRecConfDbMerge.in -tag=$(tags) $(LArCellRecConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRecConfDbMerge_makefile) LArCellRecConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(LArCellRecConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_LArCellRecConfDbMerge_makefile) LArCellRecConfDbMerge

LArCellRecConfDbMerge :: $(LArCellRecConfDbMerge_dependencies) $(cmt_local_LArCellRecConfDbMerge_makefile) dirs LArCellRecConfDbMergedirs
	$(echo) "(constituents.make) Starting LArCellRecConfDbMerge"
	@if test -f $(cmt_local_LArCellRecConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecConfDbMerge_makefile) LArCellRecConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRecConfDbMerge_makefile) LArCellRecConfDbMerge
	$(echo) "(constituents.make) LArCellRecConfDbMerge done"

clean :: LArCellRecConfDbMergeclean ;

LArCellRecConfDbMergeclean :: $(LArCellRecConfDbMergeclean_dependencies) ##$(cmt_local_LArCellRecConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting LArCellRecConfDbMergeclean"
	@-if test -f $(cmt_local_LArCellRecConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecConfDbMerge_makefile) LArCellRecConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) LArCellRecConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_LArCellRecConfDbMerge_makefile) LArCellRecConfDbMergeclean

##	  /bin/rm -f $(cmt_local_LArCellRecConfDbMerge_makefile) $(bin)LArCellRecConfDbMerge_dependencies.make

install :: LArCellRecConfDbMergeinstall ;

LArCellRecConfDbMergeinstall :: $(LArCellRecConfDbMerge_dependencies) $(cmt_local_LArCellRecConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_LArCellRecConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_LArCellRecConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : LArCellRecConfDbMergeuninstall

$(foreach d,$(LArCellRecConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += LArCellRecConfDbMergeuninstall))

LArCellRecConfDbMergeuninstall : $(LArCellRecConfDbMergeuninstall_dependencies) ##$(cmt_local_LArCellRecConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_LArCellRecConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRecConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: LArCellRecConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ LArCellRecConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ LArCellRecConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_LArCellRecComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_LArCellRecComponentsList_has_target_tag

cmt_local_tagfile_LArCellRecComponentsList = $(bin)$(LArCellRec_tag)_LArCellRecComponentsList.make
cmt_final_setup_LArCellRecComponentsList = $(bin)setup_LArCellRecComponentsList.make
cmt_local_LArCellRecComponentsList_makefile = $(bin)LArCellRecComponentsList.make

LArCellRecComponentsList_extratags = -tag_add=target_LArCellRecComponentsList

else

cmt_local_tagfile_LArCellRecComponentsList = $(bin)$(LArCellRec_tag).make
cmt_final_setup_LArCellRecComponentsList = $(bin)setup.make
cmt_local_LArCellRecComponentsList_makefile = $(bin)LArCellRecComponentsList.make

endif

not_LArCellRecComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(LArCellRecComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
LArCellRecComponentsListdirs :
	@if test ! -d $(bin)LArCellRecComponentsList; then $(mkdir) -p $(bin)LArCellRecComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)LArCellRecComponentsList
else
LArCellRecComponentsListdirs : ;
endif

ifdef cmt_LArCellRecComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_LArCellRecComponentsList_makefile) : $(LArCellRecComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRecComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRecComponentsList_extratags) build constituent_config -out=$(cmt_local_LArCellRecComponentsList_makefile) LArCellRecComponentsList
else
$(cmt_local_LArCellRecComponentsList_makefile) : $(LArCellRecComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRecComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRecComponentsList) ] || \
	  $(not_LArCellRecComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRecComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRecComponentsList_extratags) build constituent_config -out=$(cmt_local_LArCellRecComponentsList_makefile) LArCellRecComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_LArCellRecComponentsList_makefile) : $(LArCellRecComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRecComponentsList.make"; \
	  $(cmtexe) -f=$(bin)LArCellRecComponentsList.in -tag=$(tags) $(LArCellRecComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRecComponentsList_makefile) LArCellRecComponentsList
else
$(cmt_local_LArCellRecComponentsList_makefile) : $(LArCellRecComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)LArCellRecComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRecComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRecComponentsList) ] || \
	  $(not_LArCellRecComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRecComponentsList.make"; \
	  $(cmtexe) -f=$(bin)LArCellRecComponentsList.in -tag=$(tags) $(LArCellRecComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRecComponentsList_makefile) LArCellRecComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(LArCellRecComponentsList_extratags) build constituent_makefile -out=$(cmt_local_LArCellRecComponentsList_makefile) LArCellRecComponentsList

LArCellRecComponentsList :: $(LArCellRecComponentsList_dependencies) $(cmt_local_LArCellRecComponentsList_makefile) dirs LArCellRecComponentsListdirs
	$(echo) "(constituents.make) Starting LArCellRecComponentsList"
	@if test -f $(cmt_local_LArCellRecComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecComponentsList_makefile) LArCellRecComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRecComponentsList_makefile) LArCellRecComponentsList
	$(echo) "(constituents.make) LArCellRecComponentsList done"

clean :: LArCellRecComponentsListclean ;

LArCellRecComponentsListclean :: $(LArCellRecComponentsListclean_dependencies) ##$(cmt_local_LArCellRecComponentsList_makefile)
	$(echo) "(constituents.make) Starting LArCellRecComponentsListclean"
	@-if test -f $(cmt_local_LArCellRecComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecComponentsList_makefile) LArCellRecComponentsListclean; \
	fi
	$(echo) "(constituents.make) LArCellRecComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_LArCellRecComponentsList_makefile) LArCellRecComponentsListclean

##	  /bin/rm -f $(cmt_local_LArCellRecComponentsList_makefile) $(bin)LArCellRecComponentsList_dependencies.make

install :: LArCellRecComponentsListinstall ;

LArCellRecComponentsListinstall :: $(LArCellRecComponentsList_dependencies) $(cmt_local_LArCellRecComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_LArCellRecComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_LArCellRecComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : LArCellRecComponentsListuninstall

$(foreach d,$(LArCellRecComponentsList_dependencies),$(eval $(d)uninstall_dependencies += LArCellRecComponentsListuninstall))

LArCellRecComponentsListuninstall : $(LArCellRecComponentsListuninstall_dependencies) ##$(cmt_local_LArCellRecComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_LArCellRecComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRecComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: LArCellRecComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ LArCellRecComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ LArCellRecComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_LArCellRecMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_LArCellRecMergeComponentsList_has_target_tag

cmt_local_tagfile_LArCellRecMergeComponentsList = $(bin)$(LArCellRec_tag)_LArCellRecMergeComponentsList.make
cmt_final_setup_LArCellRecMergeComponentsList = $(bin)setup_LArCellRecMergeComponentsList.make
cmt_local_LArCellRecMergeComponentsList_makefile = $(bin)LArCellRecMergeComponentsList.make

LArCellRecMergeComponentsList_extratags = -tag_add=target_LArCellRecMergeComponentsList

else

cmt_local_tagfile_LArCellRecMergeComponentsList = $(bin)$(LArCellRec_tag).make
cmt_final_setup_LArCellRecMergeComponentsList = $(bin)setup.make
cmt_local_LArCellRecMergeComponentsList_makefile = $(bin)LArCellRecMergeComponentsList.make

endif

not_LArCellRecMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(LArCellRecMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
LArCellRecMergeComponentsListdirs :
	@if test ! -d $(bin)LArCellRecMergeComponentsList; then $(mkdir) -p $(bin)LArCellRecMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)LArCellRecMergeComponentsList
else
LArCellRecMergeComponentsListdirs : ;
endif

ifdef cmt_LArCellRecMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_LArCellRecMergeComponentsList_makefile) : $(LArCellRecMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRecMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRecMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_LArCellRecMergeComponentsList_makefile) LArCellRecMergeComponentsList
else
$(cmt_local_LArCellRecMergeComponentsList_makefile) : $(LArCellRecMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRecMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRecMergeComponentsList) ] || \
	  $(not_LArCellRecMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRecMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRecMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_LArCellRecMergeComponentsList_makefile) LArCellRecMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_LArCellRecMergeComponentsList_makefile) : $(LArCellRecMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRecMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)LArCellRecMergeComponentsList.in -tag=$(tags) $(LArCellRecMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRecMergeComponentsList_makefile) LArCellRecMergeComponentsList
else
$(cmt_local_LArCellRecMergeComponentsList_makefile) : $(LArCellRecMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)LArCellRecMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRecMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRecMergeComponentsList) ] || \
	  $(not_LArCellRecMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRecMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)LArCellRecMergeComponentsList.in -tag=$(tags) $(LArCellRecMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRecMergeComponentsList_makefile) LArCellRecMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(LArCellRecMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_LArCellRecMergeComponentsList_makefile) LArCellRecMergeComponentsList

LArCellRecMergeComponentsList :: $(LArCellRecMergeComponentsList_dependencies) $(cmt_local_LArCellRecMergeComponentsList_makefile) dirs LArCellRecMergeComponentsListdirs
	$(echo) "(constituents.make) Starting LArCellRecMergeComponentsList"
	@if test -f $(cmt_local_LArCellRecMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecMergeComponentsList_makefile) LArCellRecMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRecMergeComponentsList_makefile) LArCellRecMergeComponentsList
	$(echo) "(constituents.make) LArCellRecMergeComponentsList done"

clean :: LArCellRecMergeComponentsListclean ;

LArCellRecMergeComponentsListclean :: $(LArCellRecMergeComponentsListclean_dependencies) ##$(cmt_local_LArCellRecMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting LArCellRecMergeComponentsListclean"
	@-if test -f $(cmt_local_LArCellRecMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecMergeComponentsList_makefile) LArCellRecMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) LArCellRecMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_LArCellRecMergeComponentsList_makefile) LArCellRecMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_LArCellRecMergeComponentsList_makefile) $(bin)LArCellRecMergeComponentsList_dependencies.make

install :: LArCellRecMergeComponentsListinstall ;

LArCellRecMergeComponentsListinstall :: $(LArCellRecMergeComponentsList_dependencies) $(cmt_local_LArCellRecMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_LArCellRecMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_LArCellRecMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : LArCellRecMergeComponentsListuninstall

$(foreach d,$(LArCellRecMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += LArCellRecMergeComponentsListuninstall))

LArCellRecMergeComponentsListuninstall : $(LArCellRecMergeComponentsListuninstall_dependencies) ##$(cmt_local_LArCellRecMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_LArCellRecMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRecMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: LArCellRecMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ LArCellRecMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ LArCellRecMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_LArCellRec_optdebug_library_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_LArCellRec_optdebug_library_has_target_tag

cmt_local_tagfile_LArCellRec_optdebug_library = $(bin)$(LArCellRec_tag)_LArCellRec_optdebug_library.make
cmt_final_setup_LArCellRec_optdebug_library = $(bin)setup_LArCellRec_optdebug_library.make
cmt_local_LArCellRec_optdebug_library_makefile = $(bin)LArCellRec_optdebug_library.make

LArCellRec_optdebug_library_extratags = -tag_add=target_LArCellRec_optdebug_library

else

cmt_local_tagfile_LArCellRec_optdebug_library = $(bin)$(LArCellRec_tag).make
cmt_final_setup_LArCellRec_optdebug_library = $(bin)setup.make
cmt_local_LArCellRec_optdebug_library_makefile = $(bin)LArCellRec_optdebug_library.make

endif

not_LArCellRec_optdebug_library_dependencies = { n=0; for p in $?; do m=0; for d in $(LArCellRec_optdebug_library_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
LArCellRec_optdebug_librarydirs :
	@if test ! -d $(bin)LArCellRec_optdebug_library; then $(mkdir) -p $(bin)LArCellRec_optdebug_library; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)LArCellRec_optdebug_library
else
LArCellRec_optdebug_librarydirs : ;
endif

ifdef cmt_LArCellRec_optdebug_library_has_target_tag

ifndef QUICK
$(cmt_local_LArCellRec_optdebug_library_makefile) : $(LArCellRec_optdebug_library_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRec_optdebug_library.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRec_optdebug_library_extratags) build constituent_config -out=$(cmt_local_LArCellRec_optdebug_library_makefile) LArCellRec_optdebug_library
else
$(cmt_local_LArCellRec_optdebug_library_makefile) : $(LArCellRec_optdebug_library_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRec_optdebug_library) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRec_optdebug_library) ] || \
	  $(not_LArCellRec_optdebug_library_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRec_optdebug_library.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRec_optdebug_library_extratags) build constituent_config -out=$(cmt_local_LArCellRec_optdebug_library_makefile) LArCellRec_optdebug_library; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_LArCellRec_optdebug_library_makefile) : $(LArCellRec_optdebug_library_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRec_optdebug_library.make"; \
	  $(cmtexe) -f=$(bin)LArCellRec_optdebug_library.in -tag=$(tags) $(LArCellRec_optdebug_library_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRec_optdebug_library_makefile) LArCellRec_optdebug_library
else
$(cmt_local_LArCellRec_optdebug_library_makefile) : $(LArCellRec_optdebug_library_dependencies) $(cmt_build_library_linksstamp) $(bin)LArCellRec_optdebug_library.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRec_optdebug_library) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRec_optdebug_library) ] || \
	  $(not_LArCellRec_optdebug_library_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRec_optdebug_library.make"; \
	  $(cmtexe) -f=$(bin)LArCellRec_optdebug_library.in -tag=$(tags) $(LArCellRec_optdebug_library_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRec_optdebug_library_makefile) LArCellRec_optdebug_library; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(LArCellRec_optdebug_library_extratags) build constituent_makefile -out=$(cmt_local_LArCellRec_optdebug_library_makefile) LArCellRec_optdebug_library

LArCellRec_optdebug_library :: $(LArCellRec_optdebug_library_dependencies) $(cmt_local_LArCellRec_optdebug_library_makefile) dirs LArCellRec_optdebug_librarydirs
	$(echo) "(constituents.make) Starting LArCellRec_optdebug_library"
	@if test -f $(cmt_local_LArCellRec_optdebug_library_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_optdebug_library_makefile) LArCellRec_optdebug_library; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRec_optdebug_library_makefile) LArCellRec_optdebug_library
	$(echo) "(constituents.make) LArCellRec_optdebug_library done"

clean :: LArCellRec_optdebug_libraryclean ;

LArCellRec_optdebug_libraryclean :: $(LArCellRec_optdebug_libraryclean_dependencies) ##$(cmt_local_LArCellRec_optdebug_library_makefile)
	$(echo) "(constituents.make) Starting LArCellRec_optdebug_libraryclean"
	@-if test -f $(cmt_local_LArCellRec_optdebug_library_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_optdebug_library_makefile) LArCellRec_optdebug_libraryclean; \
	fi
	$(echo) "(constituents.make) LArCellRec_optdebug_libraryclean done"
#	@-$(MAKE) -f $(cmt_local_LArCellRec_optdebug_library_makefile) LArCellRec_optdebug_libraryclean

##	  /bin/rm -f $(cmt_local_LArCellRec_optdebug_library_makefile) $(bin)LArCellRec_optdebug_library_dependencies.make

install :: LArCellRec_optdebug_libraryinstall ;

LArCellRec_optdebug_libraryinstall :: $(LArCellRec_optdebug_library_dependencies) $(cmt_local_LArCellRec_optdebug_library_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_LArCellRec_optdebug_library_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_optdebug_library_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_LArCellRec_optdebug_library_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : LArCellRec_optdebug_libraryuninstall

$(foreach d,$(LArCellRec_optdebug_library_dependencies),$(eval $(d)uninstall_dependencies += LArCellRec_optdebug_libraryuninstall))

LArCellRec_optdebug_libraryuninstall : $(LArCellRec_optdebug_libraryuninstall_dependencies) ##$(cmt_local_LArCellRec_optdebug_library_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_LArCellRec_optdebug_library_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_optdebug_library_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRec_optdebug_library_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: LArCellRec_optdebug_libraryuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ LArCellRec_optdebug_library"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ LArCellRec_optdebug_library done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_LArCellRecCLIDDB_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_LArCellRecCLIDDB_has_target_tag

cmt_local_tagfile_LArCellRecCLIDDB = $(bin)$(LArCellRec_tag)_LArCellRecCLIDDB.make
cmt_final_setup_LArCellRecCLIDDB = $(bin)setup_LArCellRecCLIDDB.make
cmt_local_LArCellRecCLIDDB_makefile = $(bin)LArCellRecCLIDDB.make

LArCellRecCLIDDB_extratags = -tag_add=target_LArCellRecCLIDDB

else

cmt_local_tagfile_LArCellRecCLIDDB = $(bin)$(LArCellRec_tag).make
cmt_final_setup_LArCellRecCLIDDB = $(bin)setup.make
cmt_local_LArCellRecCLIDDB_makefile = $(bin)LArCellRecCLIDDB.make

endif

not_LArCellRecCLIDDB_dependencies = { n=0; for p in $?; do m=0; for d in $(LArCellRecCLIDDB_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
LArCellRecCLIDDBdirs :
	@if test ! -d $(bin)LArCellRecCLIDDB; then $(mkdir) -p $(bin)LArCellRecCLIDDB; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)LArCellRecCLIDDB
else
LArCellRecCLIDDBdirs : ;
endif

ifdef cmt_LArCellRecCLIDDB_has_target_tag

ifndef QUICK
$(cmt_local_LArCellRecCLIDDB_makefile) : $(LArCellRecCLIDDB_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRecCLIDDB.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRecCLIDDB_extratags) build constituent_config -out=$(cmt_local_LArCellRecCLIDDB_makefile) LArCellRecCLIDDB
else
$(cmt_local_LArCellRecCLIDDB_makefile) : $(LArCellRecCLIDDB_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRecCLIDDB) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRecCLIDDB) ] || \
	  $(not_LArCellRecCLIDDB_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRecCLIDDB.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRecCLIDDB_extratags) build constituent_config -out=$(cmt_local_LArCellRecCLIDDB_makefile) LArCellRecCLIDDB; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_LArCellRecCLIDDB_makefile) : $(LArCellRecCLIDDB_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRecCLIDDB.make"; \
	  $(cmtexe) -f=$(bin)LArCellRecCLIDDB.in -tag=$(tags) $(LArCellRecCLIDDB_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRecCLIDDB_makefile) LArCellRecCLIDDB
else
$(cmt_local_LArCellRecCLIDDB_makefile) : $(LArCellRecCLIDDB_dependencies) $(cmt_build_library_linksstamp) $(bin)LArCellRecCLIDDB.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRecCLIDDB) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRecCLIDDB) ] || \
	  $(not_LArCellRecCLIDDB_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRecCLIDDB.make"; \
	  $(cmtexe) -f=$(bin)LArCellRecCLIDDB.in -tag=$(tags) $(LArCellRecCLIDDB_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRecCLIDDB_makefile) LArCellRecCLIDDB; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(LArCellRecCLIDDB_extratags) build constituent_makefile -out=$(cmt_local_LArCellRecCLIDDB_makefile) LArCellRecCLIDDB

LArCellRecCLIDDB :: $(LArCellRecCLIDDB_dependencies) $(cmt_local_LArCellRecCLIDDB_makefile) dirs LArCellRecCLIDDBdirs
	$(echo) "(constituents.make) Starting LArCellRecCLIDDB"
	@if test -f $(cmt_local_LArCellRecCLIDDB_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecCLIDDB_makefile) LArCellRecCLIDDB; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRecCLIDDB_makefile) LArCellRecCLIDDB
	$(echo) "(constituents.make) LArCellRecCLIDDB done"

clean :: LArCellRecCLIDDBclean ;

LArCellRecCLIDDBclean :: $(LArCellRecCLIDDBclean_dependencies) ##$(cmt_local_LArCellRecCLIDDB_makefile)
	$(echo) "(constituents.make) Starting LArCellRecCLIDDBclean"
	@-if test -f $(cmt_local_LArCellRecCLIDDB_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecCLIDDB_makefile) LArCellRecCLIDDBclean; \
	fi
	$(echo) "(constituents.make) LArCellRecCLIDDBclean done"
#	@-$(MAKE) -f $(cmt_local_LArCellRecCLIDDB_makefile) LArCellRecCLIDDBclean

##	  /bin/rm -f $(cmt_local_LArCellRecCLIDDB_makefile) $(bin)LArCellRecCLIDDB_dependencies.make

install :: LArCellRecCLIDDBinstall ;

LArCellRecCLIDDBinstall :: $(LArCellRecCLIDDB_dependencies) $(cmt_local_LArCellRecCLIDDB_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_LArCellRecCLIDDB_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecCLIDDB_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_LArCellRecCLIDDB_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : LArCellRecCLIDDBuninstall

$(foreach d,$(LArCellRecCLIDDB_dependencies),$(eval $(d)uninstall_dependencies += LArCellRecCLIDDBuninstall))

LArCellRecCLIDDBuninstall : $(LArCellRecCLIDDBuninstall_dependencies) ##$(cmt_local_LArCellRecCLIDDB_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_LArCellRecCLIDDB_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecCLIDDB_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRecCLIDDB_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: LArCellRecCLIDDBuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ LArCellRecCLIDDB"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ LArCellRecCLIDDB done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_joboptions_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_joboptions_has_target_tag

cmt_local_tagfile_install_joboptions = $(bin)$(LArCellRec_tag)_install_joboptions.make
cmt_final_setup_install_joboptions = $(bin)setup_install_joboptions.make
cmt_local_install_joboptions_makefile = $(bin)install_joboptions.make

install_joboptions_extratags = -tag_add=target_install_joboptions

else

cmt_local_tagfile_install_joboptions = $(bin)$(LArCellRec_tag).make
cmt_final_setup_install_joboptions = $(bin)setup.make
cmt_local_install_joboptions_makefile = $(bin)install_joboptions.make

endif

not_install_joboptions_dependencies = { n=0; for p in $?; do m=0; for d in $(install_joboptions_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_joboptionsdirs :
	@if test ! -d $(bin)install_joboptions; then $(mkdir) -p $(bin)install_joboptions; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_joboptions
else
install_joboptionsdirs : ;
endif

ifdef cmt_install_joboptions_has_target_tag

ifndef QUICK
$(cmt_local_install_joboptions_makefile) : $(install_joboptions_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_joboptions.make"; \
	  $(cmtexe) -tag=$(tags) $(install_joboptions_extratags) build constituent_config -out=$(cmt_local_install_joboptions_makefile) install_joboptions
else
$(cmt_local_install_joboptions_makefile) : $(install_joboptions_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_joboptions) ] || \
	  [ ! -f $(cmt_final_setup_install_joboptions) ] || \
	  $(not_install_joboptions_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_joboptions.make"; \
	  $(cmtexe) -tag=$(tags) $(install_joboptions_extratags) build constituent_config -out=$(cmt_local_install_joboptions_makefile) install_joboptions; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_joboptions_makefile) : $(install_joboptions_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_joboptions.make"; \
	  $(cmtexe) -f=$(bin)install_joboptions.in -tag=$(tags) $(install_joboptions_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_joboptions_makefile) install_joboptions
else
$(cmt_local_install_joboptions_makefile) : $(install_joboptions_dependencies) $(cmt_build_library_linksstamp) $(bin)install_joboptions.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_joboptions) ] || \
	  [ ! -f $(cmt_final_setup_install_joboptions) ] || \
	  $(not_install_joboptions_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_joboptions.make"; \
	  $(cmtexe) -f=$(bin)install_joboptions.in -tag=$(tags) $(install_joboptions_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_joboptions_makefile) install_joboptions; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_joboptions_extratags) build constituent_makefile -out=$(cmt_local_install_joboptions_makefile) install_joboptions

install_joboptions :: $(install_joboptions_dependencies) $(cmt_local_install_joboptions_makefile) dirs install_joboptionsdirs
	$(echo) "(constituents.make) Starting install_joboptions"
	@if test -f $(cmt_local_install_joboptions_makefile); then \
	  $(MAKE) -f $(cmt_local_install_joboptions_makefile) install_joboptions; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_joboptions_makefile) install_joboptions
	$(echo) "(constituents.make) install_joboptions done"

clean :: install_joboptionsclean ;

install_joboptionsclean :: $(install_joboptionsclean_dependencies) ##$(cmt_local_install_joboptions_makefile)
	$(echo) "(constituents.make) Starting install_joboptionsclean"
	@-if test -f $(cmt_local_install_joboptions_makefile); then \
	  $(MAKE) -f $(cmt_local_install_joboptions_makefile) install_joboptionsclean; \
	fi
	$(echo) "(constituents.make) install_joboptionsclean done"
#	@-$(MAKE) -f $(cmt_local_install_joboptions_makefile) install_joboptionsclean

##	  /bin/rm -f $(cmt_local_install_joboptions_makefile) $(bin)install_joboptions_dependencies.make

install :: install_joboptionsinstall ;

install_joboptionsinstall :: $(install_joboptions_dependencies) $(cmt_local_install_joboptions_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_joboptions_makefile); then \
	  $(MAKE) -f $(cmt_local_install_joboptions_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_joboptions_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_joboptionsuninstall

$(foreach d,$(install_joboptions_dependencies),$(eval $(d)uninstall_dependencies += install_joboptionsuninstall))

install_joboptionsuninstall : $(install_joboptionsuninstall_dependencies) ##$(cmt_local_install_joboptions_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_joboptions_makefile); then \
	  $(MAKE) -f $(cmt_local_install_joboptions_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_joboptions_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_joboptionsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_joboptions"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_joboptions done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_python_modules_has_target_tag

cmt_local_tagfile_install_python_modules = $(bin)$(LArCellRec_tag)_install_python_modules.make
cmt_final_setup_install_python_modules = $(bin)setup_install_python_modules.make
cmt_local_install_python_modules_makefile = $(bin)install_python_modules.make

install_python_modules_extratags = -tag_add=target_install_python_modules

else

cmt_local_tagfile_install_python_modules = $(bin)$(LArCellRec_tag).make
cmt_final_setup_install_python_modules = $(bin)setup.make
cmt_local_install_python_modules_makefile = $(bin)install_python_modules.make

endif

not_install_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(install_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_python_modulesdirs :
	@if test ! -d $(bin)install_python_modules; then $(mkdir) -p $(bin)install_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_python_modules
else
install_python_modulesdirs : ;
endif

ifdef cmt_install_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_install_python_modules_makefile) : $(install_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(install_python_modules_extratags) build constituent_config -out=$(cmt_local_install_python_modules_makefile) install_python_modules
else
$(cmt_local_install_python_modules_makefile) : $(install_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_install_python_modules) ] || \
	  $(not_install_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(install_python_modules_extratags) build constituent_config -out=$(cmt_local_install_python_modules_makefile) install_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_python_modules_makefile) : $(install_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_python_modules.make"; \
	  $(cmtexe) -f=$(bin)install_python_modules.in -tag=$(tags) $(install_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_python_modules_makefile) install_python_modules
else
$(cmt_local_install_python_modules_makefile) : $(install_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)install_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_install_python_modules) ] || \
	  $(not_install_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_python_modules.make"; \
	  $(cmtexe) -f=$(bin)install_python_modules.in -tag=$(tags) $(install_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_python_modules_makefile) install_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_python_modules_extratags) build constituent_makefile -out=$(cmt_local_install_python_modules_makefile) install_python_modules

install_python_modules :: $(install_python_modules_dependencies) $(cmt_local_install_python_modules_makefile) dirs install_python_modulesdirs
	$(echo) "(constituents.make) Starting install_python_modules"
	@if test -f $(cmt_local_install_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_install_python_modules_makefile) install_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_python_modules_makefile) install_python_modules
	$(echo) "(constituents.make) install_python_modules done"

clean :: install_python_modulesclean ;

install_python_modulesclean :: $(install_python_modulesclean_dependencies) ##$(cmt_local_install_python_modules_makefile)
	$(echo) "(constituents.make) Starting install_python_modulesclean"
	@-if test -f $(cmt_local_install_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_install_python_modules_makefile) install_python_modulesclean; \
	fi
	$(echo) "(constituents.make) install_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_install_python_modules_makefile) install_python_modulesclean

##	  /bin/rm -f $(cmt_local_install_python_modules_makefile) $(bin)install_python_modules_dependencies.make

install :: install_python_modulesinstall ;

install_python_modulesinstall :: $(install_python_modules_dependencies) $(cmt_local_install_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_install_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_python_modulesuninstall

$(foreach d,$(install_python_modules_dependencies),$(eval $(d)uninstall_dependencies += install_python_modulesuninstall))

install_python_modulesuninstall : $(install_python_modulesuninstall_dependencies) ##$(cmt_local_install_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_install_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_LArCellRecrchk_has_target_tag = 1

#--------------------------------------

ifdef cmt_LArCellRecrchk_has_target_tag

cmt_local_tagfile_LArCellRecrchk = $(bin)$(LArCellRec_tag)_LArCellRecrchk.make
cmt_final_setup_LArCellRecrchk = $(bin)setup_LArCellRecrchk.make
cmt_local_LArCellRecrchk_makefile = $(bin)LArCellRecrchk.make

LArCellRecrchk_extratags = -tag_add=target_LArCellRecrchk

else

cmt_local_tagfile_LArCellRecrchk = $(bin)$(LArCellRec_tag).make
cmt_final_setup_LArCellRecrchk = $(bin)setup.make
cmt_local_LArCellRecrchk_makefile = $(bin)LArCellRecrchk.make

endif

not_LArCellRecrchk_dependencies = { n=0; for p in $?; do m=0; for d in $(LArCellRecrchk_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
LArCellRecrchkdirs :
	@if test ! -d $(bin)LArCellRecrchk; then $(mkdir) -p $(bin)LArCellRecrchk; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)LArCellRecrchk
else
LArCellRecrchkdirs : ;
endif

ifdef cmt_LArCellRecrchk_has_target_tag

ifndef QUICK
$(cmt_local_LArCellRecrchk_makefile) : $(LArCellRecrchk_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRecrchk.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRecrchk_extratags) build constituent_config -out=$(cmt_local_LArCellRecrchk_makefile) LArCellRecrchk
else
$(cmt_local_LArCellRecrchk_makefile) : $(LArCellRecrchk_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRecrchk) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRecrchk) ] || \
	  $(not_LArCellRecrchk_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRecrchk.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRecrchk_extratags) build constituent_config -out=$(cmt_local_LArCellRecrchk_makefile) LArCellRecrchk; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_LArCellRecrchk_makefile) : $(LArCellRecrchk_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRecrchk.make"; \
	  $(cmtexe) -f=$(bin)LArCellRecrchk.in -tag=$(tags) $(LArCellRecrchk_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRecrchk_makefile) LArCellRecrchk
else
$(cmt_local_LArCellRecrchk_makefile) : $(LArCellRecrchk_dependencies) $(cmt_build_library_linksstamp) $(bin)LArCellRecrchk.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRecrchk) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRecrchk) ] || \
	  $(not_LArCellRecrchk_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRecrchk.make"; \
	  $(cmtexe) -f=$(bin)LArCellRecrchk.in -tag=$(tags) $(LArCellRecrchk_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRecrchk_makefile) LArCellRecrchk; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(LArCellRecrchk_extratags) build constituent_makefile -out=$(cmt_local_LArCellRecrchk_makefile) LArCellRecrchk

LArCellRecrchk :: $(LArCellRecrchk_dependencies) $(cmt_local_LArCellRecrchk_makefile) dirs LArCellRecrchkdirs
	$(echo) "(constituents.make) Starting LArCellRecrchk"
	@if test -f $(cmt_local_LArCellRecrchk_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecrchk_makefile) LArCellRecrchk; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRecrchk_makefile) LArCellRecrchk
	$(echo) "(constituents.make) LArCellRecrchk done"

clean :: LArCellRecrchkclean ;

LArCellRecrchkclean :: $(LArCellRecrchkclean_dependencies) ##$(cmt_local_LArCellRecrchk_makefile)
	$(echo) "(constituents.make) Starting LArCellRecrchkclean"
	@-if test -f $(cmt_local_LArCellRecrchk_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecrchk_makefile) LArCellRecrchkclean; \
	fi
	$(echo) "(constituents.make) LArCellRecrchkclean done"
#	@-$(MAKE) -f $(cmt_local_LArCellRecrchk_makefile) LArCellRecrchkclean

##	  /bin/rm -f $(cmt_local_LArCellRecrchk_makefile) $(bin)LArCellRecrchk_dependencies.make

install :: LArCellRecrchkinstall ;

LArCellRecrchkinstall :: $(LArCellRecrchk_dependencies) $(cmt_local_LArCellRecrchk_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_LArCellRecrchk_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecrchk_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_LArCellRecrchk_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : LArCellRecrchkuninstall

$(foreach d,$(LArCellRecrchk_dependencies),$(eval $(d)uninstall_dependencies += LArCellRecrchkuninstall))

LArCellRecrchkuninstall : $(LArCellRecrchkuninstall_dependencies) ##$(cmt_local_LArCellRecrchk_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_LArCellRecrchk_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRecrchk_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRecrchk_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: LArCellRecrchkuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ LArCellRecrchk"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ LArCellRecrchk done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_root_include_path_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_root_include_path_has_target_tag

cmt_local_tagfile_install_root_include_path = $(bin)$(LArCellRec_tag)_install_root_include_path.make
cmt_final_setup_install_root_include_path = $(bin)setup_install_root_include_path.make
cmt_local_install_root_include_path_makefile = $(bin)install_root_include_path.make

install_root_include_path_extratags = -tag_add=target_install_root_include_path

else

cmt_local_tagfile_install_root_include_path = $(bin)$(LArCellRec_tag).make
cmt_final_setup_install_root_include_path = $(bin)setup.make
cmt_local_install_root_include_path_makefile = $(bin)install_root_include_path.make

endif

not_install_root_include_path_dependencies = { n=0; for p in $?; do m=0; for d in $(install_root_include_path_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_root_include_pathdirs :
	@if test ! -d $(bin)install_root_include_path; then $(mkdir) -p $(bin)install_root_include_path; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_root_include_path
else
install_root_include_pathdirs : ;
endif

ifdef cmt_install_root_include_path_has_target_tag

ifndef QUICK
$(cmt_local_install_root_include_path_makefile) : $(install_root_include_path_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_root_include_path.make"; \
	  $(cmtexe) -tag=$(tags) $(install_root_include_path_extratags) build constituent_config -out=$(cmt_local_install_root_include_path_makefile) install_root_include_path
else
$(cmt_local_install_root_include_path_makefile) : $(install_root_include_path_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_root_include_path) ] || \
	  [ ! -f $(cmt_final_setup_install_root_include_path) ] || \
	  $(not_install_root_include_path_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_root_include_path.make"; \
	  $(cmtexe) -tag=$(tags) $(install_root_include_path_extratags) build constituent_config -out=$(cmt_local_install_root_include_path_makefile) install_root_include_path; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_root_include_path_makefile) : $(install_root_include_path_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_root_include_path.make"; \
	  $(cmtexe) -f=$(bin)install_root_include_path.in -tag=$(tags) $(install_root_include_path_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_root_include_path_makefile) install_root_include_path
else
$(cmt_local_install_root_include_path_makefile) : $(install_root_include_path_dependencies) $(cmt_build_library_linksstamp) $(bin)install_root_include_path.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_root_include_path) ] || \
	  [ ! -f $(cmt_final_setup_install_root_include_path) ] || \
	  $(not_install_root_include_path_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_root_include_path.make"; \
	  $(cmtexe) -f=$(bin)install_root_include_path.in -tag=$(tags) $(install_root_include_path_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_root_include_path_makefile) install_root_include_path; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_root_include_path_extratags) build constituent_makefile -out=$(cmt_local_install_root_include_path_makefile) install_root_include_path

install_root_include_path :: $(install_root_include_path_dependencies) $(cmt_local_install_root_include_path_makefile) dirs install_root_include_pathdirs
	$(echo) "(constituents.make) Starting install_root_include_path"
	@if test -f $(cmt_local_install_root_include_path_makefile); then \
	  $(MAKE) -f $(cmt_local_install_root_include_path_makefile) install_root_include_path; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_root_include_path_makefile) install_root_include_path
	$(echo) "(constituents.make) install_root_include_path done"

clean :: install_root_include_pathclean ;

install_root_include_pathclean :: $(install_root_include_pathclean_dependencies) ##$(cmt_local_install_root_include_path_makefile)
	$(echo) "(constituents.make) Starting install_root_include_pathclean"
	@-if test -f $(cmt_local_install_root_include_path_makefile); then \
	  $(MAKE) -f $(cmt_local_install_root_include_path_makefile) install_root_include_pathclean; \
	fi
	$(echo) "(constituents.make) install_root_include_pathclean done"
#	@-$(MAKE) -f $(cmt_local_install_root_include_path_makefile) install_root_include_pathclean

##	  /bin/rm -f $(cmt_local_install_root_include_path_makefile) $(bin)install_root_include_path_dependencies.make

install :: install_root_include_pathinstall ;

install_root_include_pathinstall :: $(install_root_include_path_dependencies) $(cmt_local_install_root_include_path_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_root_include_path_makefile); then \
	  $(MAKE) -f $(cmt_local_install_root_include_path_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_root_include_path_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_root_include_pathuninstall

$(foreach d,$(install_root_include_path_dependencies),$(eval $(d)uninstall_dependencies += install_root_include_pathuninstall))

install_root_include_pathuninstall : $(install_root_include_pathuninstall_dependencies) ##$(cmt_local_install_root_include_path_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_root_include_path_makefile); then \
	  $(MAKE) -f $(cmt_local_install_root_include_path_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_root_include_path_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_root_include_pathuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_root_include_path"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_root_include_path done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(LArCellRec_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(LArCellRec_tag).make
cmt_final_setup_install_includes = $(bin)setup.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

endif

not_install_includes_dependencies = { n=0; for p in $?; do m=0; for d in $(install_includes_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_includesdirs :
	@if test ! -d $(bin)install_includes; then $(mkdir) -p $(bin)install_includes; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_includes
else
install_includesdirs : ;
endif

ifdef cmt_install_includes_has_target_tag

ifndef QUICK
$(cmt_local_install_includes_makefile) : $(install_includes_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_includes.make"; \
	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) build constituent_config -out=$(cmt_local_install_includes_makefile) install_includes
else
$(cmt_local_install_includes_makefile) : $(install_includes_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_includes) ] || \
	  [ ! -f $(cmt_final_setup_install_includes) ] || \
	  $(not_install_includes_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_includes.make"; \
	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) build constituent_config -out=$(cmt_local_install_includes_makefile) install_includes; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_includes_makefile) : $(install_includes_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_includes.make"; \
	  $(cmtexe) -f=$(bin)install_includes.in -tag=$(tags) $(install_includes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_includes_makefile) install_includes
else
$(cmt_local_install_includes_makefile) : $(install_includes_dependencies) $(cmt_build_library_linksstamp) $(bin)install_includes.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_includes) ] || \
	  [ ! -f $(cmt_final_setup_install_includes) ] || \
	  $(not_install_includes_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_includes.make"; \
	  $(cmtexe) -f=$(bin)install_includes.in -tag=$(tags) $(install_includes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_includes_makefile) install_includes; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) build constituent_makefile -out=$(cmt_local_install_includes_makefile) install_includes

install_includes :: $(install_includes_dependencies) $(cmt_local_install_includes_makefile) dirs install_includesdirs
	$(echo) "(constituents.make) Starting install_includes"
	@if test -f $(cmt_local_install_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_includes_makefile) install_includes; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_includes_makefile) install_includes
	$(echo) "(constituents.make) install_includes done"

clean :: install_includesclean ;

install_includesclean :: $(install_includesclean_dependencies) ##$(cmt_local_install_includes_makefile)
	$(echo) "(constituents.make) Starting install_includesclean"
	@-if test -f $(cmt_local_install_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_includes_makefile) install_includesclean; \
	fi
	$(echo) "(constituents.make) install_includesclean done"
#	@-$(MAKE) -f $(cmt_local_install_includes_makefile) install_includesclean

##	  /bin/rm -f $(cmt_local_install_includes_makefile) $(bin)install_includes_dependencies.make

install :: install_includesinstall ;

install_includesinstall :: $(install_includes_dependencies) $(cmt_local_install_includes_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_includes_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_includes_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_includesuninstall

$(foreach d,$(install_includes_dependencies),$(eval $(d)uninstall_dependencies += install_includesuninstall))

install_includesuninstall : $(install_includesuninstall_dependencies) ##$(cmt_local_install_includes_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_includes_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_includes_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_includesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_includes"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_includes done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(LArCellRec_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(LArCellRec_tag).make
cmt_final_setup_make = $(bin)setup.make
cmt_local_make_makefile = $(bin)make.make

endif

not_make_dependencies = { n=0; for p in $?; do m=0; for d in $(make_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
makedirs :
	@if test ! -d $(bin)make; then $(mkdir) -p $(bin)make; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)make
else
makedirs : ;
endif

ifdef cmt_make_has_target_tag

ifndef QUICK
$(cmt_local_make_makefile) : $(make_dependencies) build_library_links
	$(echo) "(constituents.make) Building make.make"; \
	  $(cmtexe) -tag=$(tags) $(make_extratags) build constituent_config -out=$(cmt_local_make_makefile) make
else
$(cmt_local_make_makefile) : $(make_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_make) ] || \
	  [ ! -f $(cmt_final_setup_make) ] || \
	  $(not_make_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building make.make"; \
	  $(cmtexe) -tag=$(tags) $(make_extratags) build constituent_config -out=$(cmt_local_make_makefile) make; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_make_makefile) : $(make_dependencies) build_library_links
	$(echo) "(constituents.make) Building make.make"; \
	  $(cmtexe) -f=$(bin)make.in -tag=$(tags) $(make_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_make_makefile) make
else
$(cmt_local_make_makefile) : $(make_dependencies) $(cmt_build_library_linksstamp) $(bin)make.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_make) ] || \
	  [ ! -f $(cmt_final_setup_make) ] || \
	  $(not_make_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building make.make"; \
	  $(cmtexe) -f=$(bin)make.in -tag=$(tags) $(make_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_make_makefile) make; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(make_extratags) build constituent_makefile -out=$(cmt_local_make_makefile) make

make :: $(make_dependencies) $(cmt_local_make_makefile) dirs makedirs
	$(echo) "(constituents.make) Starting make"
	@if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) make; \
	  fi
#	@$(MAKE) -f $(cmt_local_make_makefile) make
	$(echo) "(constituents.make) make done"

clean :: makeclean ;

makeclean :: $(makeclean_dependencies) ##$(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting makeclean"
	@-if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) makeclean; \
	fi
	$(echo) "(constituents.make) makeclean done"
#	@-$(MAKE) -f $(cmt_local_make_makefile) makeclean

##	  /bin/rm -f $(cmt_local_make_makefile) $(bin)make_dependencies.make

install :: makeinstall ;

makeinstall :: $(make_dependencies) $(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_make_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : makeuninstall

$(foreach d,$(make_dependencies),$(eval $(d)uninstall_dependencies += makeuninstall))

makeuninstall : $(makeuninstall_dependencies) ##$(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_make_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: makeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ make"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ make done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_CompilePython_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_CompilePython_has_target_tag

cmt_local_tagfile_CompilePython = $(bin)$(LArCellRec_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(LArCellRec_tag).make
cmt_final_setup_CompilePython = $(bin)setup.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

endif

not_CompilePython_dependencies = { n=0; for p in $?; do m=0; for d in $(CompilePython_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
CompilePythondirs :
	@if test ! -d $(bin)CompilePython; then $(mkdir) -p $(bin)CompilePython; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)CompilePython
else
CompilePythondirs : ;
endif

ifdef cmt_CompilePython_has_target_tag

ifndef QUICK
$(cmt_local_CompilePython_makefile) : $(CompilePython_dependencies) build_library_links
	$(echo) "(constituents.make) Building CompilePython.make"; \
	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) build constituent_config -out=$(cmt_local_CompilePython_makefile) CompilePython
else
$(cmt_local_CompilePython_makefile) : $(CompilePython_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CompilePython) ] || \
	  [ ! -f $(cmt_final_setup_CompilePython) ] || \
	  $(not_CompilePython_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CompilePython.make"; \
	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) build constituent_config -out=$(cmt_local_CompilePython_makefile) CompilePython; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_CompilePython_makefile) : $(CompilePython_dependencies) build_library_links
	$(echo) "(constituents.make) Building CompilePython.make"; \
	  $(cmtexe) -f=$(bin)CompilePython.in -tag=$(tags) $(CompilePython_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CompilePython_makefile) CompilePython
else
$(cmt_local_CompilePython_makefile) : $(CompilePython_dependencies) $(cmt_build_library_linksstamp) $(bin)CompilePython.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CompilePython) ] || \
	  [ ! -f $(cmt_final_setup_CompilePython) ] || \
	  $(not_CompilePython_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CompilePython.make"; \
	  $(cmtexe) -f=$(bin)CompilePython.in -tag=$(tags) $(CompilePython_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CompilePython_makefile) CompilePython; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) build constituent_makefile -out=$(cmt_local_CompilePython_makefile) CompilePython

CompilePython :: $(CompilePython_dependencies) $(cmt_local_CompilePython_makefile) dirs CompilePythondirs
	$(echo) "(constituents.make) Starting CompilePython"
	@if test -f $(cmt_local_CompilePython_makefile); then \
	  $(MAKE) -f $(cmt_local_CompilePython_makefile) CompilePython; \
	  fi
#	@$(MAKE) -f $(cmt_local_CompilePython_makefile) CompilePython
	$(echo) "(constituents.make) CompilePython done"

clean :: CompilePythonclean ;

CompilePythonclean :: $(CompilePythonclean_dependencies) ##$(cmt_local_CompilePython_makefile)
	$(echo) "(constituents.make) Starting CompilePythonclean"
	@-if test -f $(cmt_local_CompilePython_makefile); then \
	  $(MAKE) -f $(cmt_local_CompilePython_makefile) CompilePythonclean; \
	fi
	$(echo) "(constituents.make) CompilePythonclean done"
#	@-$(MAKE) -f $(cmt_local_CompilePython_makefile) CompilePythonclean

##	  /bin/rm -f $(cmt_local_CompilePython_makefile) $(bin)CompilePython_dependencies.make

install :: CompilePythoninstall ;

CompilePythoninstall :: $(CompilePython_dependencies) $(cmt_local_CompilePython_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_CompilePython_makefile); then \
	  $(MAKE) -f $(cmt_local_CompilePython_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_CompilePython_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : CompilePythonuninstall

$(foreach d,$(CompilePython_dependencies),$(eval $(d)uninstall_dependencies += CompilePythonuninstall))

CompilePythonuninstall : $(CompilePythonuninstall_dependencies) ##$(cmt_local_CompilePython_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_CompilePython_makefile); then \
	  $(MAKE) -f $(cmt_local_CompilePython_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_CompilePython_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: CompilePythonuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ CompilePython"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ CompilePython done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_qmtest_run_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_qmtest_run_has_target_tag

cmt_local_tagfile_qmtest_run = $(bin)$(LArCellRec_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(LArCellRec_tag).make
cmt_final_setup_qmtest_run = $(bin)setup.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

endif

not_qmtest_run_dependencies = { n=0; for p in $?; do m=0; for d in $(qmtest_run_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
qmtest_rundirs :
	@if test ! -d $(bin)qmtest_run; then $(mkdir) -p $(bin)qmtest_run; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)qmtest_run
else
qmtest_rundirs : ;
endif

ifdef cmt_qmtest_run_has_target_tag

ifndef QUICK
$(cmt_local_qmtest_run_makefile) : $(qmtest_run_dependencies) build_library_links
	$(echo) "(constituents.make) Building qmtest_run.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) build constituent_config -out=$(cmt_local_qmtest_run_makefile) qmtest_run
else
$(cmt_local_qmtest_run_makefile) : $(qmtest_run_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_qmtest_run) ] || \
	  [ ! -f $(cmt_final_setup_qmtest_run) ] || \
	  $(not_qmtest_run_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building qmtest_run.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) build constituent_config -out=$(cmt_local_qmtest_run_makefile) qmtest_run; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_qmtest_run_makefile) : $(qmtest_run_dependencies) build_library_links
	$(echo) "(constituents.make) Building qmtest_run.make"; \
	  $(cmtexe) -f=$(bin)qmtest_run.in -tag=$(tags) $(qmtest_run_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_qmtest_run_makefile) qmtest_run
else
$(cmt_local_qmtest_run_makefile) : $(qmtest_run_dependencies) $(cmt_build_library_linksstamp) $(bin)qmtest_run.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_qmtest_run) ] || \
	  [ ! -f $(cmt_final_setup_qmtest_run) ] || \
	  $(not_qmtest_run_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building qmtest_run.make"; \
	  $(cmtexe) -f=$(bin)qmtest_run.in -tag=$(tags) $(qmtest_run_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_qmtest_run_makefile) qmtest_run; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) build constituent_makefile -out=$(cmt_local_qmtest_run_makefile) qmtest_run

qmtest_run :: $(qmtest_run_dependencies) $(cmt_local_qmtest_run_makefile) dirs qmtest_rundirs
	$(echo) "(constituents.make) Starting qmtest_run"
	@if test -f $(cmt_local_qmtest_run_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_run_makefile) qmtest_run; \
	  fi
#	@$(MAKE) -f $(cmt_local_qmtest_run_makefile) qmtest_run
	$(echo) "(constituents.make) qmtest_run done"

clean :: qmtest_runclean ;

qmtest_runclean :: $(qmtest_runclean_dependencies) ##$(cmt_local_qmtest_run_makefile)
	$(echo) "(constituents.make) Starting qmtest_runclean"
	@-if test -f $(cmt_local_qmtest_run_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_run_makefile) qmtest_runclean; \
	fi
	$(echo) "(constituents.make) qmtest_runclean done"
#	@-$(MAKE) -f $(cmt_local_qmtest_run_makefile) qmtest_runclean

##	  /bin/rm -f $(cmt_local_qmtest_run_makefile) $(bin)qmtest_run_dependencies.make

install :: qmtest_runinstall ;

qmtest_runinstall :: $(qmtest_run_dependencies) $(cmt_local_qmtest_run_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_qmtest_run_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_run_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_qmtest_run_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : qmtest_rununinstall

$(foreach d,$(qmtest_run_dependencies),$(eval $(d)uninstall_dependencies += qmtest_rununinstall))

qmtest_rununinstall : $(qmtest_rununinstall_dependencies) ##$(cmt_local_qmtest_run_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_qmtest_run_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_run_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_qmtest_run_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: qmtest_rununinstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ qmtest_run"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ qmtest_run done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_qmtest_summarize_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_qmtest_summarize_has_target_tag

cmt_local_tagfile_qmtest_summarize = $(bin)$(LArCellRec_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(LArCellRec_tag).make
cmt_final_setup_qmtest_summarize = $(bin)setup.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

endif

not_qmtest_summarize_dependencies = { n=0; for p in $?; do m=0; for d in $(qmtest_summarize_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
qmtest_summarizedirs :
	@if test ! -d $(bin)qmtest_summarize; then $(mkdir) -p $(bin)qmtest_summarize; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)qmtest_summarize
else
qmtest_summarizedirs : ;
endif

ifdef cmt_qmtest_summarize_has_target_tag

ifndef QUICK
$(cmt_local_qmtest_summarize_makefile) : $(qmtest_summarize_dependencies) build_library_links
	$(echo) "(constituents.make) Building qmtest_summarize.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) build constituent_config -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize
else
$(cmt_local_qmtest_summarize_makefile) : $(qmtest_summarize_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_qmtest_summarize) ] || \
	  [ ! -f $(cmt_final_setup_qmtest_summarize) ] || \
	  $(not_qmtest_summarize_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building qmtest_summarize.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) build constituent_config -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_qmtest_summarize_makefile) : $(qmtest_summarize_dependencies) build_library_links
	$(echo) "(constituents.make) Building qmtest_summarize.make"; \
	  $(cmtexe) -f=$(bin)qmtest_summarize.in -tag=$(tags) $(qmtest_summarize_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize
else
$(cmt_local_qmtest_summarize_makefile) : $(qmtest_summarize_dependencies) $(cmt_build_library_linksstamp) $(bin)qmtest_summarize.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_qmtest_summarize) ] || \
	  [ ! -f $(cmt_final_setup_qmtest_summarize) ] || \
	  $(not_qmtest_summarize_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building qmtest_summarize.make"; \
	  $(cmtexe) -f=$(bin)qmtest_summarize.in -tag=$(tags) $(qmtest_summarize_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) build constituent_makefile -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize

qmtest_summarize :: $(qmtest_summarize_dependencies) $(cmt_local_qmtest_summarize_makefile) dirs qmtest_summarizedirs
	$(echo) "(constituents.make) Starting qmtest_summarize"
	@if test -f $(cmt_local_qmtest_summarize_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_summarize_makefile) qmtest_summarize; \
	  fi
#	@$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) qmtest_summarize
	$(echo) "(constituents.make) qmtest_summarize done"

clean :: qmtest_summarizeclean ;

qmtest_summarizeclean :: $(qmtest_summarizeclean_dependencies) ##$(cmt_local_qmtest_summarize_makefile)
	$(echo) "(constituents.make) Starting qmtest_summarizeclean"
	@-if test -f $(cmt_local_qmtest_summarize_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_summarize_makefile) qmtest_summarizeclean; \
	fi
	$(echo) "(constituents.make) qmtest_summarizeclean done"
#	@-$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) qmtest_summarizeclean

##	  /bin/rm -f $(cmt_local_qmtest_summarize_makefile) $(bin)qmtest_summarize_dependencies.make

install :: qmtest_summarizeinstall ;

qmtest_summarizeinstall :: $(qmtest_summarize_dependencies) $(cmt_local_qmtest_summarize_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_qmtest_summarize_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_summarize_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : qmtest_summarizeuninstall

$(foreach d,$(qmtest_summarize_dependencies),$(eval $(d)uninstall_dependencies += qmtest_summarizeuninstall))

qmtest_summarizeuninstall : $(qmtest_summarizeuninstall_dependencies) ##$(cmt_local_qmtest_summarize_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_qmtest_summarize_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_summarize_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: qmtest_summarizeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ qmtest_summarize"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ qmtest_summarize done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_TestPackage_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_TestPackage_has_target_tag

cmt_local_tagfile_TestPackage = $(bin)$(LArCellRec_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(LArCellRec_tag).make
cmt_final_setup_TestPackage = $(bin)setup.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

endif

not_TestPackage_dependencies = { n=0; for p in $?; do m=0; for d in $(TestPackage_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
TestPackagedirs :
	@if test ! -d $(bin)TestPackage; then $(mkdir) -p $(bin)TestPackage; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)TestPackage
else
TestPackagedirs : ;
endif

ifdef cmt_TestPackage_has_target_tag

ifndef QUICK
$(cmt_local_TestPackage_makefile) : $(TestPackage_dependencies) build_library_links
	$(echo) "(constituents.make) Building TestPackage.make"; \
	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) build constituent_config -out=$(cmt_local_TestPackage_makefile) TestPackage
else
$(cmt_local_TestPackage_makefile) : $(TestPackage_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_TestPackage) ] || \
	  [ ! -f $(cmt_final_setup_TestPackage) ] || \
	  $(not_TestPackage_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building TestPackage.make"; \
	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) build constituent_config -out=$(cmt_local_TestPackage_makefile) TestPackage; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_TestPackage_makefile) : $(TestPackage_dependencies) build_library_links
	$(echo) "(constituents.make) Building TestPackage.make"; \
	  $(cmtexe) -f=$(bin)TestPackage.in -tag=$(tags) $(TestPackage_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_TestPackage_makefile) TestPackage
else
$(cmt_local_TestPackage_makefile) : $(TestPackage_dependencies) $(cmt_build_library_linksstamp) $(bin)TestPackage.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_TestPackage) ] || \
	  [ ! -f $(cmt_final_setup_TestPackage) ] || \
	  $(not_TestPackage_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building TestPackage.make"; \
	  $(cmtexe) -f=$(bin)TestPackage.in -tag=$(tags) $(TestPackage_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_TestPackage_makefile) TestPackage; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) build constituent_makefile -out=$(cmt_local_TestPackage_makefile) TestPackage

TestPackage :: $(TestPackage_dependencies) $(cmt_local_TestPackage_makefile) dirs TestPackagedirs
	$(echo) "(constituents.make) Starting TestPackage"
	@if test -f $(cmt_local_TestPackage_makefile); then \
	  $(MAKE) -f $(cmt_local_TestPackage_makefile) TestPackage; \
	  fi
#	@$(MAKE) -f $(cmt_local_TestPackage_makefile) TestPackage
	$(echo) "(constituents.make) TestPackage done"

clean :: TestPackageclean ;

TestPackageclean :: $(TestPackageclean_dependencies) ##$(cmt_local_TestPackage_makefile)
	$(echo) "(constituents.make) Starting TestPackageclean"
	@-if test -f $(cmt_local_TestPackage_makefile); then \
	  $(MAKE) -f $(cmt_local_TestPackage_makefile) TestPackageclean; \
	fi
	$(echo) "(constituents.make) TestPackageclean done"
#	@-$(MAKE) -f $(cmt_local_TestPackage_makefile) TestPackageclean

##	  /bin/rm -f $(cmt_local_TestPackage_makefile) $(bin)TestPackage_dependencies.make

install :: TestPackageinstall ;

TestPackageinstall :: $(TestPackage_dependencies) $(cmt_local_TestPackage_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_TestPackage_makefile); then \
	  $(MAKE) -f $(cmt_local_TestPackage_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_TestPackage_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : TestPackageuninstall

$(foreach d,$(TestPackage_dependencies),$(eval $(d)uninstall_dependencies += TestPackageuninstall))

TestPackageuninstall : $(TestPackageuninstall_dependencies) ##$(cmt_local_TestPackage_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_TestPackage_makefile); then \
	  $(MAKE) -f $(cmt_local_TestPackage_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_TestPackage_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: TestPackageuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ TestPackage"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ TestPackage done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_TestProject_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_TestProject_has_target_tag

cmt_local_tagfile_TestProject = $(bin)$(LArCellRec_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(LArCellRec_tag).make
cmt_final_setup_TestProject = $(bin)setup.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

endif

not_TestProject_dependencies = { n=0; for p in $?; do m=0; for d in $(TestProject_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
TestProjectdirs :
	@if test ! -d $(bin)TestProject; then $(mkdir) -p $(bin)TestProject; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)TestProject
else
TestProjectdirs : ;
endif

ifdef cmt_TestProject_has_target_tag

ifndef QUICK
$(cmt_local_TestProject_makefile) : $(TestProject_dependencies) build_library_links
	$(echo) "(constituents.make) Building TestProject.make"; \
	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) build constituent_config -out=$(cmt_local_TestProject_makefile) TestProject
else
$(cmt_local_TestProject_makefile) : $(TestProject_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_TestProject) ] || \
	  [ ! -f $(cmt_final_setup_TestProject) ] || \
	  $(not_TestProject_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building TestProject.make"; \
	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) build constituent_config -out=$(cmt_local_TestProject_makefile) TestProject; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_TestProject_makefile) : $(TestProject_dependencies) build_library_links
	$(echo) "(constituents.make) Building TestProject.make"; \
	  $(cmtexe) -f=$(bin)TestProject.in -tag=$(tags) $(TestProject_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_TestProject_makefile) TestProject
else
$(cmt_local_TestProject_makefile) : $(TestProject_dependencies) $(cmt_build_library_linksstamp) $(bin)TestProject.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_TestProject) ] || \
	  [ ! -f $(cmt_final_setup_TestProject) ] || \
	  $(not_TestProject_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building TestProject.make"; \
	  $(cmtexe) -f=$(bin)TestProject.in -tag=$(tags) $(TestProject_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_TestProject_makefile) TestProject; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) build constituent_makefile -out=$(cmt_local_TestProject_makefile) TestProject

TestProject :: $(TestProject_dependencies) $(cmt_local_TestProject_makefile) dirs TestProjectdirs
	$(echo) "(constituents.make) Starting TestProject"
	@if test -f $(cmt_local_TestProject_makefile); then \
	  $(MAKE) -f $(cmt_local_TestProject_makefile) TestProject; \
	  fi
#	@$(MAKE) -f $(cmt_local_TestProject_makefile) TestProject
	$(echo) "(constituents.make) TestProject done"

clean :: TestProjectclean ;

TestProjectclean :: $(TestProjectclean_dependencies) ##$(cmt_local_TestProject_makefile)
	$(echo) "(constituents.make) Starting TestProjectclean"
	@-if test -f $(cmt_local_TestProject_makefile); then \
	  $(MAKE) -f $(cmt_local_TestProject_makefile) TestProjectclean; \
	fi
	$(echo) "(constituents.make) TestProjectclean done"
#	@-$(MAKE) -f $(cmt_local_TestProject_makefile) TestProjectclean

##	  /bin/rm -f $(cmt_local_TestProject_makefile) $(bin)TestProject_dependencies.make

install :: TestProjectinstall ;

TestProjectinstall :: $(TestProject_dependencies) $(cmt_local_TestProject_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_TestProject_makefile); then \
	  $(MAKE) -f $(cmt_local_TestProject_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_TestProject_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : TestProjectuninstall

$(foreach d,$(TestProject_dependencies),$(eval $(d)uninstall_dependencies += TestProjectuninstall))

TestProjectuninstall : $(TestProjectuninstall_dependencies) ##$(cmt_local_TestProject_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_TestProject_makefile); then \
	  $(MAKE) -f $(cmt_local_TestProject_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_TestProject_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: TestProjectuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ TestProject"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ TestProject done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_new_rootsys_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_new_rootsys_has_target_tag

cmt_local_tagfile_new_rootsys = $(bin)$(LArCellRec_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(LArCellRec_tag).make
cmt_final_setup_new_rootsys = $(bin)setup.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

endif

not_new_rootsys_dependencies = { n=0; for p in $?; do m=0; for d in $(new_rootsys_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
new_rootsysdirs :
	@if test ! -d $(bin)new_rootsys; then $(mkdir) -p $(bin)new_rootsys; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)new_rootsys
else
new_rootsysdirs : ;
endif

ifdef cmt_new_rootsys_has_target_tag

ifndef QUICK
$(cmt_local_new_rootsys_makefile) : $(new_rootsys_dependencies) build_library_links
	$(echo) "(constituents.make) Building new_rootsys.make"; \
	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) build constituent_config -out=$(cmt_local_new_rootsys_makefile) new_rootsys
else
$(cmt_local_new_rootsys_makefile) : $(new_rootsys_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_new_rootsys) ] || \
	  [ ! -f $(cmt_final_setup_new_rootsys) ] || \
	  $(not_new_rootsys_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building new_rootsys.make"; \
	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) build constituent_config -out=$(cmt_local_new_rootsys_makefile) new_rootsys; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_new_rootsys_makefile) : $(new_rootsys_dependencies) build_library_links
	$(echo) "(constituents.make) Building new_rootsys.make"; \
	  $(cmtexe) -f=$(bin)new_rootsys.in -tag=$(tags) $(new_rootsys_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_new_rootsys_makefile) new_rootsys
else
$(cmt_local_new_rootsys_makefile) : $(new_rootsys_dependencies) $(cmt_build_library_linksstamp) $(bin)new_rootsys.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_new_rootsys) ] || \
	  [ ! -f $(cmt_final_setup_new_rootsys) ] || \
	  $(not_new_rootsys_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building new_rootsys.make"; \
	  $(cmtexe) -f=$(bin)new_rootsys.in -tag=$(tags) $(new_rootsys_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_new_rootsys_makefile) new_rootsys; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) build constituent_makefile -out=$(cmt_local_new_rootsys_makefile) new_rootsys

new_rootsys :: $(new_rootsys_dependencies) $(cmt_local_new_rootsys_makefile) dirs new_rootsysdirs
	$(echo) "(constituents.make) Starting new_rootsys"
	@if test -f $(cmt_local_new_rootsys_makefile); then \
	  $(MAKE) -f $(cmt_local_new_rootsys_makefile) new_rootsys; \
	  fi
#	@$(MAKE) -f $(cmt_local_new_rootsys_makefile) new_rootsys
	$(echo) "(constituents.make) new_rootsys done"

clean :: new_rootsysclean ;

new_rootsysclean :: $(new_rootsysclean_dependencies) ##$(cmt_local_new_rootsys_makefile)
	$(echo) "(constituents.make) Starting new_rootsysclean"
	@-if test -f $(cmt_local_new_rootsys_makefile); then \
	  $(MAKE) -f $(cmt_local_new_rootsys_makefile) new_rootsysclean; \
	fi
	$(echo) "(constituents.make) new_rootsysclean done"
#	@-$(MAKE) -f $(cmt_local_new_rootsys_makefile) new_rootsysclean

##	  /bin/rm -f $(cmt_local_new_rootsys_makefile) $(bin)new_rootsys_dependencies.make

install :: new_rootsysinstall ;

new_rootsysinstall :: $(new_rootsys_dependencies) $(cmt_local_new_rootsys_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_new_rootsys_makefile); then \
	  $(MAKE) -f $(cmt_local_new_rootsys_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_new_rootsys_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : new_rootsysuninstall

$(foreach d,$(new_rootsys_dependencies),$(eval $(d)uninstall_dependencies += new_rootsysuninstall))

new_rootsysuninstall : $(new_rootsysuninstall_dependencies) ##$(cmt_local_new_rootsys_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_new_rootsys_makefile); then \
	  $(MAKE) -f $(cmt_local_new_rootsys_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_new_rootsys_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: new_rootsysuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ new_rootsys"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ new_rootsys done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_doxygen_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_doxygen_has_target_tag

cmt_local_tagfile_doxygen = $(bin)$(LArCellRec_tag)_doxygen.make
cmt_final_setup_doxygen = $(bin)setup_doxygen.make
cmt_local_doxygen_makefile = $(bin)doxygen.make

doxygen_extratags = -tag_add=target_doxygen

else

cmt_local_tagfile_doxygen = $(bin)$(LArCellRec_tag).make
cmt_final_setup_doxygen = $(bin)setup.make
cmt_local_doxygen_makefile = $(bin)doxygen.make

endif

not_doxygen_dependencies = { n=0; for p in $?; do m=0; for d in $(doxygen_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
doxygendirs :
	@if test ! -d $(bin)doxygen; then $(mkdir) -p $(bin)doxygen; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)doxygen
else
doxygendirs : ;
endif

ifdef cmt_doxygen_has_target_tag

ifndef QUICK
$(cmt_local_doxygen_makefile) : $(doxygen_dependencies) build_library_links
	$(echo) "(constituents.make) Building doxygen.make"; \
	  $(cmtexe) -tag=$(tags) $(doxygen_extratags) build constituent_config -out=$(cmt_local_doxygen_makefile) doxygen
else
$(cmt_local_doxygen_makefile) : $(doxygen_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_doxygen) ] || \
	  [ ! -f $(cmt_final_setup_doxygen) ] || \
	  $(not_doxygen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building doxygen.make"; \
	  $(cmtexe) -tag=$(tags) $(doxygen_extratags) build constituent_config -out=$(cmt_local_doxygen_makefile) doxygen; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_doxygen_makefile) : $(doxygen_dependencies) build_library_links
	$(echo) "(constituents.make) Building doxygen.make"; \
	  $(cmtexe) -f=$(bin)doxygen.in -tag=$(tags) $(doxygen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_doxygen_makefile) doxygen
else
$(cmt_local_doxygen_makefile) : $(doxygen_dependencies) $(cmt_build_library_linksstamp) $(bin)doxygen.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_doxygen) ] || \
	  [ ! -f $(cmt_final_setup_doxygen) ] || \
	  $(not_doxygen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building doxygen.make"; \
	  $(cmtexe) -f=$(bin)doxygen.in -tag=$(tags) $(doxygen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_doxygen_makefile) doxygen; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(doxygen_extratags) build constituent_makefile -out=$(cmt_local_doxygen_makefile) doxygen

doxygen :: $(doxygen_dependencies) $(cmt_local_doxygen_makefile) dirs doxygendirs
	$(echo) "(constituents.make) Starting doxygen"
	@if test -f $(cmt_local_doxygen_makefile); then \
	  $(MAKE) -f $(cmt_local_doxygen_makefile) doxygen; \
	  fi
#	@$(MAKE) -f $(cmt_local_doxygen_makefile) doxygen
	$(echo) "(constituents.make) doxygen done"

clean :: doxygenclean ;

doxygenclean :: $(doxygenclean_dependencies) ##$(cmt_local_doxygen_makefile)
	$(echo) "(constituents.make) Starting doxygenclean"
	@-if test -f $(cmt_local_doxygen_makefile); then \
	  $(MAKE) -f $(cmt_local_doxygen_makefile) doxygenclean; \
	fi
	$(echo) "(constituents.make) doxygenclean done"
#	@-$(MAKE) -f $(cmt_local_doxygen_makefile) doxygenclean

##	  /bin/rm -f $(cmt_local_doxygen_makefile) $(bin)doxygen_dependencies.make

install :: doxygeninstall ;

doxygeninstall :: $(doxygen_dependencies) $(cmt_local_doxygen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_doxygen_makefile); then \
	  $(MAKE) -f $(cmt_local_doxygen_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_doxygen_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : doxygenuninstall

$(foreach d,$(doxygen_dependencies),$(eval $(d)uninstall_dependencies += doxygenuninstall))

doxygenuninstall : $(doxygenuninstall_dependencies) ##$(cmt_local_doxygen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_doxygen_makefile); then \
	  $(MAKE) -f $(cmt_local_doxygen_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_doxygen_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: doxygenuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ doxygen"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ doxygen done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_post_install_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_post_install_has_target_tag

cmt_local_tagfile_post_install = $(bin)$(LArCellRec_tag)_post_install.make
cmt_final_setup_post_install = $(bin)setup_post_install.make
cmt_local_post_install_makefile = $(bin)post_install.make

post_install_extratags = -tag_add=target_post_install

else

cmt_local_tagfile_post_install = $(bin)$(LArCellRec_tag).make
cmt_final_setup_post_install = $(bin)setup.make
cmt_local_post_install_makefile = $(bin)post_install.make

endif

not_post_install_dependencies = { n=0; for p in $?; do m=0; for d in $(post_install_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
post_installdirs :
	@if test ! -d $(bin)post_install; then $(mkdir) -p $(bin)post_install; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)post_install
else
post_installdirs : ;
endif

ifdef cmt_post_install_has_target_tag

ifndef QUICK
$(cmt_local_post_install_makefile) : $(post_install_dependencies) build_library_links
	$(echo) "(constituents.make) Building post_install.make"; \
	  $(cmtexe) -tag=$(tags) $(post_install_extratags) build constituent_config -out=$(cmt_local_post_install_makefile) post_install
else
$(cmt_local_post_install_makefile) : $(post_install_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_post_install) ] || \
	  [ ! -f $(cmt_final_setup_post_install) ] || \
	  $(not_post_install_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building post_install.make"; \
	  $(cmtexe) -tag=$(tags) $(post_install_extratags) build constituent_config -out=$(cmt_local_post_install_makefile) post_install; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_post_install_makefile) : $(post_install_dependencies) build_library_links
	$(echo) "(constituents.make) Building post_install.make"; \
	  $(cmtexe) -f=$(bin)post_install.in -tag=$(tags) $(post_install_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_post_install_makefile) post_install
else
$(cmt_local_post_install_makefile) : $(post_install_dependencies) $(cmt_build_library_linksstamp) $(bin)post_install.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_post_install) ] || \
	  [ ! -f $(cmt_final_setup_post_install) ] || \
	  $(not_post_install_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building post_install.make"; \
	  $(cmtexe) -f=$(bin)post_install.in -tag=$(tags) $(post_install_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_post_install_makefile) post_install; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(post_install_extratags) build constituent_makefile -out=$(cmt_local_post_install_makefile) post_install

post_install :: $(post_install_dependencies) $(cmt_local_post_install_makefile) dirs post_installdirs
	$(echo) "(constituents.make) Starting post_install"
	@if test -f $(cmt_local_post_install_makefile); then \
	  $(MAKE) -f $(cmt_local_post_install_makefile) post_install; \
	  fi
#	@$(MAKE) -f $(cmt_local_post_install_makefile) post_install
	$(echo) "(constituents.make) post_install done"

clean :: post_installclean ;

post_installclean :: $(post_installclean_dependencies) ##$(cmt_local_post_install_makefile)
	$(echo) "(constituents.make) Starting post_installclean"
	@-if test -f $(cmt_local_post_install_makefile); then \
	  $(MAKE) -f $(cmt_local_post_install_makefile) post_installclean; \
	fi
	$(echo) "(constituents.make) post_installclean done"
#	@-$(MAKE) -f $(cmt_local_post_install_makefile) post_installclean

##	  /bin/rm -f $(cmt_local_post_install_makefile) $(bin)post_install_dependencies.make

install :: post_installinstall ;

post_installinstall :: $(post_install_dependencies) $(cmt_local_post_install_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_post_install_makefile); then \
	  $(MAKE) -f $(cmt_local_post_install_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_post_install_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : post_installuninstall

$(foreach d,$(post_install_dependencies),$(eval $(d)uninstall_dependencies += post_installuninstall))

post_installuninstall : $(post_installuninstall_dependencies) ##$(cmt_local_post_install_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_post_install_makefile); then \
	  $(MAKE) -f $(cmt_local_post_install_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_post_install_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: post_installuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ post_install"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ post_install done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_post_merge_rootmap_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_post_merge_rootmap_has_target_tag

cmt_local_tagfile_post_merge_rootmap = $(bin)$(LArCellRec_tag)_post_merge_rootmap.make
cmt_final_setup_post_merge_rootmap = $(bin)setup_post_merge_rootmap.make
cmt_local_post_merge_rootmap_makefile = $(bin)post_merge_rootmap.make

post_merge_rootmap_extratags = -tag_add=target_post_merge_rootmap

else

cmt_local_tagfile_post_merge_rootmap = $(bin)$(LArCellRec_tag).make
cmt_final_setup_post_merge_rootmap = $(bin)setup.make
cmt_local_post_merge_rootmap_makefile = $(bin)post_merge_rootmap.make

endif

not_post_merge_rootmap_dependencies = { n=0; for p in $?; do m=0; for d in $(post_merge_rootmap_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
post_merge_rootmapdirs :
	@if test ! -d $(bin)post_merge_rootmap; then $(mkdir) -p $(bin)post_merge_rootmap; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)post_merge_rootmap
else
post_merge_rootmapdirs : ;
endif

ifdef cmt_post_merge_rootmap_has_target_tag

ifndef QUICK
$(cmt_local_post_merge_rootmap_makefile) : $(post_merge_rootmap_dependencies) build_library_links
	$(echo) "(constituents.make) Building post_merge_rootmap.make"; \
	  $(cmtexe) -tag=$(tags) $(post_merge_rootmap_extratags) build constituent_config -out=$(cmt_local_post_merge_rootmap_makefile) post_merge_rootmap
else
$(cmt_local_post_merge_rootmap_makefile) : $(post_merge_rootmap_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_post_merge_rootmap) ] || \
	  [ ! -f $(cmt_final_setup_post_merge_rootmap) ] || \
	  $(not_post_merge_rootmap_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building post_merge_rootmap.make"; \
	  $(cmtexe) -tag=$(tags) $(post_merge_rootmap_extratags) build constituent_config -out=$(cmt_local_post_merge_rootmap_makefile) post_merge_rootmap; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_post_merge_rootmap_makefile) : $(post_merge_rootmap_dependencies) build_library_links
	$(echo) "(constituents.make) Building post_merge_rootmap.make"; \
	  $(cmtexe) -f=$(bin)post_merge_rootmap.in -tag=$(tags) $(post_merge_rootmap_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_post_merge_rootmap_makefile) post_merge_rootmap
else
$(cmt_local_post_merge_rootmap_makefile) : $(post_merge_rootmap_dependencies) $(cmt_build_library_linksstamp) $(bin)post_merge_rootmap.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_post_merge_rootmap) ] || \
	  [ ! -f $(cmt_final_setup_post_merge_rootmap) ] || \
	  $(not_post_merge_rootmap_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building post_merge_rootmap.make"; \
	  $(cmtexe) -f=$(bin)post_merge_rootmap.in -tag=$(tags) $(post_merge_rootmap_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_post_merge_rootmap_makefile) post_merge_rootmap; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(post_merge_rootmap_extratags) build constituent_makefile -out=$(cmt_local_post_merge_rootmap_makefile) post_merge_rootmap

post_merge_rootmap :: $(post_merge_rootmap_dependencies) $(cmt_local_post_merge_rootmap_makefile) dirs post_merge_rootmapdirs
	$(echo) "(constituents.make) Starting post_merge_rootmap"
	@if test -f $(cmt_local_post_merge_rootmap_makefile); then \
	  $(MAKE) -f $(cmt_local_post_merge_rootmap_makefile) post_merge_rootmap; \
	  fi
#	@$(MAKE) -f $(cmt_local_post_merge_rootmap_makefile) post_merge_rootmap
	$(echo) "(constituents.make) post_merge_rootmap done"

clean :: post_merge_rootmapclean ;

post_merge_rootmapclean :: $(post_merge_rootmapclean_dependencies) ##$(cmt_local_post_merge_rootmap_makefile)
	$(echo) "(constituents.make) Starting post_merge_rootmapclean"
	@-if test -f $(cmt_local_post_merge_rootmap_makefile); then \
	  $(MAKE) -f $(cmt_local_post_merge_rootmap_makefile) post_merge_rootmapclean; \
	fi
	$(echo) "(constituents.make) post_merge_rootmapclean done"
#	@-$(MAKE) -f $(cmt_local_post_merge_rootmap_makefile) post_merge_rootmapclean

##	  /bin/rm -f $(cmt_local_post_merge_rootmap_makefile) $(bin)post_merge_rootmap_dependencies.make

install :: post_merge_rootmapinstall ;

post_merge_rootmapinstall :: $(post_merge_rootmap_dependencies) $(cmt_local_post_merge_rootmap_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_post_merge_rootmap_makefile); then \
	  $(MAKE) -f $(cmt_local_post_merge_rootmap_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_post_merge_rootmap_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : post_merge_rootmapuninstall

$(foreach d,$(post_merge_rootmap_dependencies),$(eval $(d)uninstall_dependencies += post_merge_rootmapuninstall))

post_merge_rootmapuninstall : $(post_merge_rootmapuninstall_dependencies) ##$(cmt_local_post_merge_rootmap_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_post_merge_rootmap_makefile); then \
	  $(MAKE) -f $(cmt_local_post_merge_rootmap_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_post_merge_rootmap_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: post_merge_rootmapuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ post_merge_rootmap"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ post_merge_rootmap done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_post_merge_genconfdb_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_post_merge_genconfdb_has_target_tag

cmt_local_tagfile_post_merge_genconfdb = $(bin)$(LArCellRec_tag)_post_merge_genconfdb.make
cmt_final_setup_post_merge_genconfdb = $(bin)setup_post_merge_genconfdb.make
cmt_local_post_merge_genconfdb_makefile = $(bin)post_merge_genconfdb.make

post_merge_genconfdb_extratags = -tag_add=target_post_merge_genconfdb

else

cmt_local_tagfile_post_merge_genconfdb = $(bin)$(LArCellRec_tag).make
cmt_final_setup_post_merge_genconfdb = $(bin)setup.make
cmt_local_post_merge_genconfdb_makefile = $(bin)post_merge_genconfdb.make

endif

not_post_merge_genconfdb_dependencies = { n=0; for p in $?; do m=0; for d in $(post_merge_genconfdb_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
post_merge_genconfdbdirs :
	@if test ! -d $(bin)post_merge_genconfdb; then $(mkdir) -p $(bin)post_merge_genconfdb; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)post_merge_genconfdb
else
post_merge_genconfdbdirs : ;
endif

ifdef cmt_post_merge_genconfdb_has_target_tag

ifndef QUICK
$(cmt_local_post_merge_genconfdb_makefile) : $(post_merge_genconfdb_dependencies) build_library_links
	$(echo) "(constituents.make) Building post_merge_genconfdb.make"; \
	  $(cmtexe) -tag=$(tags) $(post_merge_genconfdb_extratags) build constituent_config -out=$(cmt_local_post_merge_genconfdb_makefile) post_merge_genconfdb
else
$(cmt_local_post_merge_genconfdb_makefile) : $(post_merge_genconfdb_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_post_merge_genconfdb) ] || \
	  [ ! -f $(cmt_final_setup_post_merge_genconfdb) ] || \
	  $(not_post_merge_genconfdb_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building post_merge_genconfdb.make"; \
	  $(cmtexe) -tag=$(tags) $(post_merge_genconfdb_extratags) build constituent_config -out=$(cmt_local_post_merge_genconfdb_makefile) post_merge_genconfdb; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_post_merge_genconfdb_makefile) : $(post_merge_genconfdb_dependencies) build_library_links
	$(echo) "(constituents.make) Building post_merge_genconfdb.make"; \
	  $(cmtexe) -f=$(bin)post_merge_genconfdb.in -tag=$(tags) $(post_merge_genconfdb_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_post_merge_genconfdb_makefile) post_merge_genconfdb
else
$(cmt_local_post_merge_genconfdb_makefile) : $(post_merge_genconfdb_dependencies) $(cmt_build_library_linksstamp) $(bin)post_merge_genconfdb.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_post_merge_genconfdb) ] || \
	  [ ! -f $(cmt_final_setup_post_merge_genconfdb) ] || \
	  $(not_post_merge_genconfdb_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building post_merge_genconfdb.make"; \
	  $(cmtexe) -f=$(bin)post_merge_genconfdb.in -tag=$(tags) $(post_merge_genconfdb_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_post_merge_genconfdb_makefile) post_merge_genconfdb; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(post_merge_genconfdb_extratags) build constituent_makefile -out=$(cmt_local_post_merge_genconfdb_makefile) post_merge_genconfdb

post_merge_genconfdb :: $(post_merge_genconfdb_dependencies) $(cmt_local_post_merge_genconfdb_makefile) dirs post_merge_genconfdbdirs
	$(echo) "(constituents.make) Starting post_merge_genconfdb"
	@if test -f $(cmt_local_post_merge_genconfdb_makefile); then \
	  $(MAKE) -f $(cmt_local_post_merge_genconfdb_makefile) post_merge_genconfdb; \
	  fi
#	@$(MAKE) -f $(cmt_local_post_merge_genconfdb_makefile) post_merge_genconfdb
	$(echo) "(constituents.make) post_merge_genconfdb done"

clean :: post_merge_genconfdbclean ;

post_merge_genconfdbclean :: $(post_merge_genconfdbclean_dependencies) ##$(cmt_local_post_merge_genconfdb_makefile)
	$(echo) "(constituents.make) Starting post_merge_genconfdbclean"
	@-if test -f $(cmt_local_post_merge_genconfdb_makefile); then \
	  $(MAKE) -f $(cmt_local_post_merge_genconfdb_makefile) post_merge_genconfdbclean; \
	fi
	$(echo) "(constituents.make) post_merge_genconfdbclean done"
#	@-$(MAKE) -f $(cmt_local_post_merge_genconfdb_makefile) post_merge_genconfdbclean

##	  /bin/rm -f $(cmt_local_post_merge_genconfdb_makefile) $(bin)post_merge_genconfdb_dependencies.make

install :: post_merge_genconfdbinstall ;

post_merge_genconfdbinstall :: $(post_merge_genconfdb_dependencies) $(cmt_local_post_merge_genconfdb_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_post_merge_genconfdb_makefile); then \
	  $(MAKE) -f $(cmt_local_post_merge_genconfdb_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_post_merge_genconfdb_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : post_merge_genconfdbuninstall

$(foreach d,$(post_merge_genconfdb_dependencies),$(eval $(d)uninstall_dependencies += post_merge_genconfdbuninstall))

post_merge_genconfdbuninstall : $(post_merge_genconfdbuninstall_dependencies) ##$(cmt_local_post_merge_genconfdb_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_post_merge_genconfdb_makefile); then \
	  $(MAKE) -f $(cmt_local_post_merge_genconfdb_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_post_merge_genconfdb_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: post_merge_genconfdbuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ post_merge_genconfdb"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ post_merge_genconfdb done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_post_build_tpcnvdb_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_post_build_tpcnvdb_has_target_tag

cmt_local_tagfile_post_build_tpcnvdb = $(bin)$(LArCellRec_tag)_post_build_tpcnvdb.make
cmt_final_setup_post_build_tpcnvdb = $(bin)setup_post_build_tpcnvdb.make
cmt_local_post_build_tpcnvdb_makefile = $(bin)post_build_tpcnvdb.make

post_build_tpcnvdb_extratags = -tag_add=target_post_build_tpcnvdb

else

cmt_local_tagfile_post_build_tpcnvdb = $(bin)$(LArCellRec_tag).make
cmt_final_setup_post_build_tpcnvdb = $(bin)setup.make
cmt_local_post_build_tpcnvdb_makefile = $(bin)post_build_tpcnvdb.make

endif

not_post_build_tpcnvdb_dependencies = { n=0; for p in $?; do m=0; for d in $(post_build_tpcnvdb_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
post_build_tpcnvdbdirs :
	@if test ! -d $(bin)post_build_tpcnvdb; then $(mkdir) -p $(bin)post_build_tpcnvdb; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)post_build_tpcnvdb
else
post_build_tpcnvdbdirs : ;
endif

ifdef cmt_post_build_tpcnvdb_has_target_tag

ifndef QUICK
$(cmt_local_post_build_tpcnvdb_makefile) : $(post_build_tpcnvdb_dependencies) build_library_links
	$(echo) "(constituents.make) Building post_build_tpcnvdb.make"; \
	  $(cmtexe) -tag=$(tags) $(post_build_tpcnvdb_extratags) build constituent_config -out=$(cmt_local_post_build_tpcnvdb_makefile) post_build_tpcnvdb
else
$(cmt_local_post_build_tpcnvdb_makefile) : $(post_build_tpcnvdb_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_post_build_tpcnvdb) ] || \
	  [ ! -f $(cmt_final_setup_post_build_tpcnvdb) ] || \
	  $(not_post_build_tpcnvdb_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building post_build_tpcnvdb.make"; \
	  $(cmtexe) -tag=$(tags) $(post_build_tpcnvdb_extratags) build constituent_config -out=$(cmt_local_post_build_tpcnvdb_makefile) post_build_tpcnvdb; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_post_build_tpcnvdb_makefile) : $(post_build_tpcnvdb_dependencies) build_library_links
	$(echo) "(constituents.make) Building post_build_tpcnvdb.make"; \
	  $(cmtexe) -f=$(bin)post_build_tpcnvdb.in -tag=$(tags) $(post_build_tpcnvdb_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_post_build_tpcnvdb_makefile) post_build_tpcnvdb
else
$(cmt_local_post_build_tpcnvdb_makefile) : $(post_build_tpcnvdb_dependencies) $(cmt_build_library_linksstamp) $(bin)post_build_tpcnvdb.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_post_build_tpcnvdb) ] || \
	  [ ! -f $(cmt_final_setup_post_build_tpcnvdb) ] || \
	  $(not_post_build_tpcnvdb_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building post_build_tpcnvdb.make"; \
	  $(cmtexe) -f=$(bin)post_build_tpcnvdb.in -tag=$(tags) $(post_build_tpcnvdb_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_post_build_tpcnvdb_makefile) post_build_tpcnvdb; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(post_build_tpcnvdb_extratags) build constituent_makefile -out=$(cmt_local_post_build_tpcnvdb_makefile) post_build_tpcnvdb

post_build_tpcnvdb :: $(post_build_tpcnvdb_dependencies) $(cmt_local_post_build_tpcnvdb_makefile) dirs post_build_tpcnvdbdirs
	$(echo) "(constituents.make) Starting post_build_tpcnvdb"
	@if test -f $(cmt_local_post_build_tpcnvdb_makefile); then \
	  $(MAKE) -f $(cmt_local_post_build_tpcnvdb_makefile) post_build_tpcnvdb; \
	  fi
#	@$(MAKE) -f $(cmt_local_post_build_tpcnvdb_makefile) post_build_tpcnvdb
	$(echo) "(constituents.make) post_build_tpcnvdb done"

clean :: post_build_tpcnvdbclean ;

post_build_tpcnvdbclean :: $(post_build_tpcnvdbclean_dependencies) ##$(cmt_local_post_build_tpcnvdb_makefile)
	$(echo) "(constituents.make) Starting post_build_tpcnvdbclean"
	@-if test -f $(cmt_local_post_build_tpcnvdb_makefile); then \
	  $(MAKE) -f $(cmt_local_post_build_tpcnvdb_makefile) post_build_tpcnvdbclean; \
	fi
	$(echo) "(constituents.make) post_build_tpcnvdbclean done"
#	@-$(MAKE) -f $(cmt_local_post_build_tpcnvdb_makefile) post_build_tpcnvdbclean

##	  /bin/rm -f $(cmt_local_post_build_tpcnvdb_makefile) $(bin)post_build_tpcnvdb_dependencies.make

install :: post_build_tpcnvdbinstall ;

post_build_tpcnvdbinstall :: $(post_build_tpcnvdb_dependencies) $(cmt_local_post_build_tpcnvdb_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_post_build_tpcnvdb_makefile); then \
	  $(MAKE) -f $(cmt_local_post_build_tpcnvdb_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_post_build_tpcnvdb_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : post_build_tpcnvdbuninstall

$(foreach d,$(post_build_tpcnvdb_dependencies),$(eval $(d)uninstall_dependencies += post_build_tpcnvdbuninstall))

post_build_tpcnvdbuninstall : $(post_build_tpcnvdbuninstall_dependencies) ##$(cmt_local_post_build_tpcnvdb_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_post_build_tpcnvdb_makefile); then \
	  $(MAKE) -f $(cmt_local_post_build_tpcnvdb_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_post_build_tpcnvdb_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: post_build_tpcnvdbuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ post_build_tpcnvdb"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ post_build_tpcnvdb done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_all_post_constituents_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_all_post_constituents_has_target_tag

cmt_local_tagfile_all_post_constituents = $(bin)$(LArCellRec_tag)_all_post_constituents.make
cmt_final_setup_all_post_constituents = $(bin)setup_all_post_constituents.make
cmt_local_all_post_constituents_makefile = $(bin)all_post_constituents.make

all_post_constituents_extratags = -tag_add=target_all_post_constituents

else

cmt_local_tagfile_all_post_constituents = $(bin)$(LArCellRec_tag).make
cmt_final_setup_all_post_constituents = $(bin)setup.make
cmt_local_all_post_constituents_makefile = $(bin)all_post_constituents.make

endif

not_all_post_constituents_dependencies = { n=0; for p in $?; do m=0; for d in $(all_post_constituents_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
all_post_constituentsdirs :
	@if test ! -d $(bin)all_post_constituents; then $(mkdir) -p $(bin)all_post_constituents; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)all_post_constituents
else
all_post_constituentsdirs : ;
endif

ifdef cmt_all_post_constituents_has_target_tag

ifndef QUICK
$(cmt_local_all_post_constituents_makefile) : $(all_post_constituents_dependencies) build_library_links
	$(echo) "(constituents.make) Building all_post_constituents.make"; \
	  $(cmtexe) -tag=$(tags) $(all_post_constituents_extratags) build constituent_config -out=$(cmt_local_all_post_constituents_makefile) all_post_constituents
else
$(cmt_local_all_post_constituents_makefile) : $(all_post_constituents_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_all_post_constituents) ] || \
	  [ ! -f $(cmt_final_setup_all_post_constituents) ] || \
	  $(not_all_post_constituents_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building all_post_constituents.make"; \
	  $(cmtexe) -tag=$(tags) $(all_post_constituents_extratags) build constituent_config -out=$(cmt_local_all_post_constituents_makefile) all_post_constituents; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_all_post_constituents_makefile) : $(all_post_constituents_dependencies) build_library_links
	$(echo) "(constituents.make) Building all_post_constituents.make"; \
	  $(cmtexe) -f=$(bin)all_post_constituents.in -tag=$(tags) $(all_post_constituents_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_all_post_constituents_makefile) all_post_constituents
else
$(cmt_local_all_post_constituents_makefile) : $(all_post_constituents_dependencies) $(cmt_build_library_linksstamp) $(bin)all_post_constituents.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_all_post_constituents) ] || \
	  [ ! -f $(cmt_final_setup_all_post_constituents) ] || \
	  $(not_all_post_constituents_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building all_post_constituents.make"; \
	  $(cmtexe) -f=$(bin)all_post_constituents.in -tag=$(tags) $(all_post_constituents_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_all_post_constituents_makefile) all_post_constituents; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(all_post_constituents_extratags) build constituent_makefile -out=$(cmt_local_all_post_constituents_makefile) all_post_constituents

all_post_constituents :: $(all_post_constituents_dependencies) $(cmt_local_all_post_constituents_makefile) dirs all_post_constituentsdirs
	$(echo) "(constituents.make) Starting all_post_constituents"
	@if test -f $(cmt_local_all_post_constituents_makefile); then \
	  $(MAKE) -f $(cmt_local_all_post_constituents_makefile) all_post_constituents; \
	  fi
#	@$(MAKE) -f $(cmt_local_all_post_constituents_makefile) all_post_constituents
	$(echo) "(constituents.make) all_post_constituents done"

clean :: all_post_constituentsclean ;

all_post_constituentsclean :: $(all_post_constituentsclean_dependencies) ##$(cmt_local_all_post_constituents_makefile)
	$(echo) "(constituents.make) Starting all_post_constituentsclean"
	@-if test -f $(cmt_local_all_post_constituents_makefile); then \
	  $(MAKE) -f $(cmt_local_all_post_constituents_makefile) all_post_constituentsclean; \
	fi
	$(echo) "(constituents.make) all_post_constituentsclean done"
#	@-$(MAKE) -f $(cmt_local_all_post_constituents_makefile) all_post_constituentsclean

##	  /bin/rm -f $(cmt_local_all_post_constituents_makefile) $(bin)all_post_constituents_dependencies.make

install :: all_post_constituentsinstall ;

all_post_constituentsinstall :: $(all_post_constituents_dependencies) $(cmt_local_all_post_constituents_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_all_post_constituents_makefile); then \
	  $(MAKE) -f $(cmt_local_all_post_constituents_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_all_post_constituents_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : all_post_constituentsuninstall

$(foreach d,$(all_post_constituents_dependencies),$(eval $(d)uninstall_dependencies += all_post_constituentsuninstall))

all_post_constituentsuninstall : $(all_post_constituentsuninstall_dependencies) ##$(cmt_local_all_post_constituents_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_all_post_constituents_makefile); then \
	  $(MAKE) -f $(cmt_local_all_post_constituents_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_all_post_constituents_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: all_post_constituentsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ all_post_constituents"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ all_post_constituents done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_checkreq_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_checkreq_has_target_tag

cmt_local_tagfile_checkreq = $(bin)$(LArCellRec_tag)_checkreq.make
cmt_final_setup_checkreq = $(bin)setup_checkreq.make
cmt_local_checkreq_makefile = $(bin)checkreq.make

checkreq_extratags = -tag_add=target_checkreq

else

cmt_local_tagfile_checkreq = $(bin)$(LArCellRec_tag).make
cmt_final_setup_checkreq = $(bin)setup.make
cmt_local_checkreq_makefile = $(bin)checkreq.make

endif

not_checkreq_dependencies = { n=0; for p in $?; do m=0; for d in $(checkreq_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
checkreqdirs :
	@if test ! -d $(bin)checkreq; then $(mkdir) -p $(bin)checkreq; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)checkreq
else
checkreqdirs : ;
endif

ifdef cmt_checkreq_has_target_tag

ifndef QUICK
$(cmt_local_checkreq_makefile) : $(checkreq_dependencies) build_library_links
	$(echo) "(constituents.make) Building checkreq.make"; \
	  $(cmtexe) -tag=$(tags) $(checkreq_extratags) build constituent_config -out=$(cmt_local_checkreq_makefile) checkreq
else
$(cmt_local_checkreq_makefile) : $(checkreq_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_checkreq) ] || \
	  [ ! -f $(cmt_final_setup_checkreq) ] || \
	  $(not_checkreq_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building checkreq.make"; \
	  $(cmtexe) -tag=$(tags) $(checkreq_extratags) build constituent_config -out=$(cmt_local_checkreq_makefile) checkreq; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_checkreq_makefile) : $(checkreq_dependencies) build_library_links
	$(echo) "(constituents.make) Building checkreq.make"; \
	  $(cmtexe) -f=$(bin)checkreq.in -tag=$(tags) $(checkreq_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_checkreq_makefile) checkreq
else
$(cmt_local_checkreq_makefile) : $(checkreq_dependencies) $(cmt_build_library_linksstamp) $(bin)checkreq.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_checkreq) ] || \
	  [ ! -f $(cmt_final_setup_checkreq) ] || \
	  $(not_checkreq_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building checkreq.make"; \
	  $(cmtexe) -f=$(bin)checkreq.in -tag=$(tags) $(checkreq_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_checkreq_makefile) checkreq; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(checkreq_extratags) build constituent_makefile -out=$(cmt_local_checkreq_makefile) checkreq

checkreq :: $(checkreq_dependencies) $(cmt_local_checkreq_makefile) dirs checkreqdirs
	$(echo) "(constituents.make) Starting checkreq"
	@if test -f $(cmt_local_checkreq_makefile); then \
	  $(MAKE) -f $(cmt_local_checkreq_makefile) checkreq; \
	  fi
#	@$(MAKE) -f $(cmt_local_checkreq_makefile) checkreq
	$(echo) "(constituents.make) checkreq done"

clean :: checkreqclean ;

checkreqclean :: $(checkreqclean_dependencies) ##$(cmt_local_checkreq_makefile)
	$(echo) "(constituents.make) Starting checkreqclean"
	@-if test -f $(cmt_local_checkreq_makefile); then \
	  $(MAKE) -f $(cmt_local_checkreq_makefile) checkreqclean; \
	fi
	$(echo) "(constituents.make) checkreqclean done"
#	@-$(MAKE) -f $(cmt_local_checkreq_makefile) checkreqclean

##	  /bin/rm -f $(cmt_local_checkreq_makefile) $(bin)checkreq_dependencies.make

install :: checkreqinstall ;

checkreqinstall :: $(checkreq_dependencies) $(cmt_local_checkreq_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_checkreq_makefile); then \
	  $(MAKE) -f $(cmt_local_checkreq_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_checkreq_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : checkrequninstall

$(foreach d,$(checkreq_dependencies),$(eval $(d)uninstall_dependencies += checkrequninstall))

checkrequninstall : $(checkrequninstall_dependencies) ##$(cmt_local_checkreq_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_checkreq_makefile); then \
	  $(MAKE) -f $(cmt_local_checkreq_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_checkreq_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: checkrequninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ checkreq"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ checkreq done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_LArCellRec_NICOS_Fix_debuginfo_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_LArCellRec_NICOS_Fix_debuginfo_has_target_tag

cmt_local_tagfile_LArCellRec_NICOS_Fix_debuginfo = $(bin)$(LArCellRec_tag)_LArCellRec_NICOS_Fix_debuginfo.make
cmt_final_setup_LArCellRec_NICOS_Fix_debuginfo = $(bin)setup_LArCellRec_NICOS_Fix_debuginfo.make
cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile = $(bin)LArCellRec_NICOS_Fix_debuginfo.make

LArCellRec_NICOS_Fix_debuginfo_extratags = -tag_add=target_LArCellRec_NICOS_Fix_debuginfo

else

cmt_local_tagfile_LArCellRec_NICOS_Fix_debuginfo = $(bin)$(LArCellRec_tag).make
cmt_final_setup_LArCellRec_NICOS_Fix_debuginfo = $(bin)setup.make
cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile = $(bin)LArCellRec_NICOS_Fix_debuginfo.make

endif

not_LArCellRec_NICOS_Fix_debuginfo_dependencies = { n=0; for p in $?; do m=0; for d in $(LArCellRec_NICOS_Fix_debuginfo_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
LArCellRec_NICOS_Fix_debuginfodirs :
	@if test ! -d $(bin)LArCellRec_NICOS_Fix_debuginfo; then $(mkdir) -p $(bin)LArCellRec_NICOS_Fix_debuginfo; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)LArCellRec_NICOS_Fix_debuginfo
else
LArCellRec_NICOS_Fix_debuginfodirs : ;
endif

ifdef cmt_LArCellRec_NICOS_Fix_debuginfo_has_target_tag

ifndef QUICK
$(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) : $(LArCellRec_NICOS_Fix_debuginfo_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRec_NICOS_Fix_debuginfo.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRec_NICOS_Fix_debuginfo_extratags) build constituent_config -out=$(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) LArCellRec_NICOS_Fix_debuginfo
else
$(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) : $(LArCellRec_NICOS_Fix_debuginfo_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRec_NICOS_Fix_debuginfo) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRec_NICOS_Fix_debuginfo) ] || \
	  $(not_LArCellRec_NICOS_Fix_debuginfo_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRec_NICOS_Fix_debuginfo.make"; \
	  $(cmtexe) -tag=$(tags) $(LArCellRec_NICOS_Fix_debuginfo_extratags) build constituent_config -out=$(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) LArCellRec_NICOS_Fix_debuginfo; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) : $(LArCellRec_NICOS_Fix_debuginfo_dependencies) build_library_links
	$(echo) "(constituents.make) Building LArCellRec_NICOS_Fix_debuginfo.make"; \
	  $(cmtexe) -f=$(bin)LArCellRec_NICOS_Fix_debuginfo.in -tag=$(tags) $(LArCellRec_NICOS_Fix_debuginfo_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) LArCellRec_NICOS_Fix_debuginfo
else
$(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) : $(LArCellRec_NICOS_Fix_debuginfo_dependencies) $(cmt_build_library_linksstamp) $(bin)LArCellRec_NICOS_Fix_debuginfo.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_LArCellRec_NICOS_Fix_debuginfo) ] || \
	  [ ! -f $(cmt_final_setup_LArCellRec_NICOS_Fix_debuginfo) ] || \
	  $(not_LArCellRec_NICOS_Fix_debuginfo_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building LArCellRec_NICOS_Fix_debuginfo.make"; \
	  $(cmtexe) -f=$(bin)LArCellRec_NICOS_Fix_debuginfo.in -tag=$(tags) $(LArCellRec_NICOS_Fix_debuginfo_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) LArCellRec_NICOS_Fix_debuginfo; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(LArCellRec_NICOS_Fix_debuginfo_extratags) build constituent_makefile -out=$(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) LArCellRec_NICOS_Fix_debuginfo

LArCellRec_NICOS_Fix_debuginfo :: $(LArCellRec_NICOS_Fix_debuginfo_dependencies) $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) dirs LArCellRec_NICOS_Fix_debuginfodirs
	$(echo) "(constituents.make) Starting LArCellRec_NICOS_Fix_debuginfo"
	@if test -f $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) LArCellRec_NICOS_Fix_debuginfo; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) LArCellRec_NICOS_Fix_debuginfo
	$(echo) "(constituents.make) LArCellRec_NICOS_Fix_debuginfo done"

clean :: LArCellRec_NICOS_Fix_debuginfoclean ;

LArCellRec_NICOS_Fix_debuginfoclean :: $(LArCellRec_NICOS_Fix_debuginfoclean_dependencies) ##$(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile)
	$(echo) "(constituents.make) Starting LArCellRec_NICOS_Fix_debuginfoclean"
	@-if test -f $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) LArCellRec_NICOS_Fix_debuginfoclean; \
	fi
	$(echo) "(constituents.make) LArCellRec_NICOS_Fix_debuginfoclean done"
#	@-$(MAKE) -f $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) LArCellRec_NICOS_Fix_debuginfoclean

##	  /bin/rm -f $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) $(bin)LArCellRec_NICOS_Fix_debuginfo_dependencies.make

install :: LArCellRec_NICOS_Fix_debuginfoinstall ;

LArCellRec_NICOS_Fix_debuginfoinstall :: $(LArCellRec_NICOS_Fix_debuginfo_dependencies) $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : LArCellRec_NICOS_Fix_debuginfouninstall

$(foreach d,$(LArCellRec_NICOS_Fix_debuginfo_dependencies),$(eval $(d)uninstall_dependencies += LArCellRec_NICOS_Fix_debuginfouninstall))

LArCellRec_NICOS_Fix_debuginfouninstall : $(LArCellRec_NICOS_Fix_debuginfouninstall_dependencies) ##$(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile); then \
	  $(MAKE) -f $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_LArCellRec_NICOS_Fix_debuginfo_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: LArCellRec_NICOS_Fix_debuginfouninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ LArCellRec_NICOS_Fix_debuginfo"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ LArCellRec_NICOS_Fix_debuginfo done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_check_install_joboptions_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_check_install_joboptions_has_target_tag

cmt_local_tagfile_check_install_joboptions = $(bin)$(LArCellRec_tag)_check_install_joboptions.make
cmt_final_setup_check_install_joboptions = $(bin)setup_check_install_joboptions.make
cmt_local_check_install_joboptions_makefile = $(bin)check_install_joboptions.make

check_install_joboptions_extratags = -tag_add=target_check_install_joboptions

else

cmt_local_tagfile_check_install_joboptions = $(bin)$(LArCellRec_tag).make
cmt_final_setup_check_install_joboptions = $(bin)setup.make
cmt_local_check_install_joboptions_makefile = $(bin)check_install_joboptions.make

endif

not_check_install_joboptions_dependencies = { n=0; for p in $?; do m=0; for d in $(check_install_joboptions_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
check_install_joboptionsdirs :
	@if test ! -d $(bin)check_install_joboptions; then $(mkdir) -p $(bin)check_install_joboptions; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)check_install_joboptions
else
check_install_joboptionsdirs : ;
endif

ifdef cmt_check_install_joboptions_has_target_tag

ifndef QUICK
$(cmt_local_check_install_joboptions_makefile) : $(check_install_joboptions_dependencies) build_library_links
	$(echo) "(constituents.make) Building check_install_joboptions.make"; \
	  $(cmtexe) -tag=$(tags) $(check_install_joboptions_extratags) build constituent_config -out=$(cmt_local_check_install_joboptions_makefile) check_install_joboptions
else
$(cmt_local_check_install_joboptions_makefile) : $(check_install_joboptions_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_check_install_joboptions) ] || \
	  [ ! -f $(cmt_final_setup_check_install_joboptions) ] || \
	  $(not_check_install_joboptions_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building check_install_joboptions.make"; \
	  $(cmtexe) -tag=$(tags) $(check_install_joboptions_extratags) build constituent_config -out=$(cmt_local_check_install_joboptions_makefile) check_install_joboptions; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_check_install_joboptions_makefile) : $(check_install_joboptions_dependencies) build_library_links
	$(echo) "(constituents.make) Building check_install_joboptions.make"; \
	  $(cmtexe) -f=$(bin)check_install_joboptions.in -tag=$(tags) $(check_install_joboptions_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_check_install_joboptions_makefile) check_install_joboptions
else
$(cmt_local_check_install_joboptions_makefile) : $(check_install_joboptions_dependencies) $(cmt_build_library_linksstamp) $(bin)check_install_joboptions.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_check_install_joboptions) ] || \
	  [ ! -f $(cmt_final_setup_check_install_joboptions) ] || \
	  $(not_check_install_joboptions_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building check_install_joboptions.make"; \
	  $(cmtexe) -f=$(bin)check_install_joboptions.in -tag=$(tags) $(check_install_joboptions_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_check_install_joboptions_makefile) check_install_joboptions; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(check_install_joboptions_extratags) build constituent_makefile -out=$(cmt_local_check_install_joboptions_makefile) check_install_joboptions

check_install_joboptions :: $(check_install_joboptions_dependencies) $(cmt_local_check_install_joboptions_makefile) dirs check_install_joboptionsdirs
	$(echo) "(constituents.make) Starting check_install_joboptions"
	@if test -f $(cmt_local_check_install_joboptions_makefile); then \
	  $(MAKE) -f $(cmt_local_check_install_joboptions_makefile) check_install_joboptions; \
	  fi
#	@$(MAKE) -f $(cmt_local_check_install_joboptions_makefile) check_install_joboptions
	$(echo) "(constituents.make) check_install_joboptions done"

clean :: check_install_joboptionsclean ;

check_install_joboptionsclean :: $(check_install_joboptionsclean_dependencies) ##$(cmt_local_check_install_joboptions_makefile)
	$(echo) "(constituents.make) Starting check_install_joboptionsclean"
	@-if test -f $(cmt_local_check_install_joboptions_makefile); then \
	  $(MAKE) -f $(cmt_local_check_install_joboptions_makefile) check_install_joboptionsclean; \
	fi
	$(echo) "(constituents.make) check_install_joboptionsclean done"
#	@-$(MAKE) -f $(cmt_local_check_install_joboptions_makefile) check_install_joboptionsclean

##	  /bin/rm -f $(cmt_local_check_install_joboptions_makefile) $(bin)check_install_joboptions_dependencies.make

install :: check_install_joboptionsinstall ;

check_install_joboptionsinstall :: $(check_install_joboptions_dependencies) $(cmt_local_check_install_joboptions_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_check_install_joboptions_makefile); then \
	  $(MAKE) -f $(cmt_local_check_install_joboptions_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_check_install_joboptions_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : check_install_joboptionsuninstall

$(foreach d,$(check_install_joboptions_dependencies),$(eval $(d)uninstall_dependencies += check_install_joboptionsuninstall))

check_install_joboptionsuninstall : $(check_install_joboptionsuninstall_dependencies) ##$(cmt_local_check_install_joboptions_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_check_install_joboptions_makefile); then \
	  $(MAKE) -f $(cmt_local_check_install_joboptions_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_check_install_joboptions_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: check_install_joboptionsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ check_install_joboptions"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ check_install_joboptions done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_check_install_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_check_install_python_modules_has_target_tag

cmt_local_tagfile_check_install_python_modules = $(bin)$(LArCellRec_tag)_check_install_python_modules.make
cmt_final_setup_check_install_python_modules = $(bin)setup_check_install_python_modules.make
cmt_local_check_install_python_modules_makefile = $(bin)check_install_python_modules.make

check_install_python_modules_extratags = -tag_add=target_check_install_python_modules

else

cmt_local_tagfile_check_install_python_modules = $(bin)$(LArCellRec_tag).make
cmt_final_setup_check_install_python_modules = $(bin)setup.make
cmt_local_check_install_python_modules_makefile = $(bin)check_install_python_modules.make

endif

not_check_install_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(check_install_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
check_install_python_modulesdirs :
	@if test ! -d $(bin)check_install_python_modules; then $(mkdir) -p $(bin)check_install_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)check_install_python_modules
else
check_install_python_modulesdirs : ;
endif

ifdef cmt_check_install_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_check_install_python_modules_makefile) : $(check_install_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building check_install_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(check_install_python_modules_extratags) build constituent_config -out=$(cmt_local_check_install_python_modules_makefile) check_install_python_modules
else
$(cmt_local_check_install_python_modules_makefile) : $(check_install_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_check_install_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_check_install_python_modules) ] || \
	  $(not_check_install_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building check_install_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(check_install_python_modules_extratags) build constituent_config -out=$(cmt_local_check_install_python_modules_makefile) check_install_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_check_install_python_modules_makefile) : $(check_install_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building check_install_python_modules.make"; \
	  $(cmtexe) -f=$(bin)check_install_python_modules.in -tag=$(tags) $(check_install_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_check_install_python_modules_makefile) check_install_python_modules
else
$(cmt_local_check_install_python_modules_makefile) : $(check_install_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)check_install_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_check_install_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_check_install_python_modules) ] || \
	  $(not_check_install_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building check_install_python_modules.make"; \
	  $(cmtexe) -f=$(bin)check_install_python_modules.in -tag=$(tags) $(check_install_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_check_install_python_modules_makefile) check_install_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(check_install_python_modules_extratags) build constituent_makefile -out=$(cmt_local_check_install_python_modules_makefile) check_install_python_modules

check_install_python_modules :: $(check_install_python_modules_dependencies) $(cmt_local_check_install_python_modules_makefile) dirs check_install_python_modulesdirs
	$(echo) "(constituents.make) Starting check_install_python_modules"
	@if test -f $(cmt_local_check_install_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_check_install_python_modules_makefile) check_install_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_check_install_python_modules_makefile) check_install_python_modules
	$(echo) "(constituents.make) check_install_python_modules done"

clean :: check_install_python_modulesclean ;

check_install_python_modulesclean :: $(check_install_python_modulesclean_dependencies) ##$(cmt_local_check_install_python_modules_makefile)
	$(echo) "(constituents.make) Starting check_install_python_modulesclean"
	@-if test -f $(cmt_local_check_install_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_check_install_python_modules_makefile) check_install_python_modulesclean; \
	fi
	$(echo) "(constituents.make) check_install_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_check_install_python_modules_makefile) check_install_python_modulesclean

##	  /bin/rm -f $(cmt_local_check_install_python_modules_makefile) $(bin)check_install_python_modules_dependencies.make

install :: check_install_python_modulesinstall ;

check_install_python_modulesinstall :: $(check_install_python_modules_dependencies) $(cmt_local_check_install_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_check_install_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_check_install_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_check_install_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : check_install_python_modulesuninstall

$(foreach d,$(check_install_python_modules_dependencies),$(eval $(d)uninstall_dependencies += check_install_python_modulesuninstall))

check_install_python_modulesuninstall : $(check_install_python_modulesuninstall_dependencies) ##$(cmt_local_check_install_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_check_install_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_check_install_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_check_install_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: check_install_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ check_install_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ check_install_python_modules done"
endif

#-- end of constituent ------
#-- start of constituents_trailer ------

uninstall : remove_library_links ;
clean ::
	$(cleanup_echo) $(cmt_build_library_linksstamp)
	-$(cleanup_silent) \rm -f $(cmt_build_library_linksstamp)
#clean :: remove_library_links

remove_library_links ::
ifndef QUICK
	$(echo) "(constituents.make) Removing library links"; \
	  $(remove_library_links)
else
	$(echo) "(constituents.make) Removing library links"; \
	  $(remove_library_links) -f=$(bin)library_links.in -without_cmt
endif

#-- end of constituents_trailer ------
