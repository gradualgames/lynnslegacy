## '' change to the location of your FreeBASIC compiler #####################################


    FBC := fbc


###########################################################################################




## flags  #################################################################################


llflags += -d ll_main=-1
llflags += -maxerr inf


ifdef full
    ll_audio = 1

endif

ifdef fulldebug
    debug = 1
    exx_err = 1
    
    -d LL_OBJECTLOADPROGRESS=-1
    -d LL_LOGMAPLOADPROGRESS=-1
    -d LL_LOGROOMCHANGE=-1
    -d LL_LOGRoomEnemySetup=-1

endif

ifdef err
    llflags += -e


endif

ifdef ex_err
    llflags += -ex


endif

ifdef exx_err
    llflags += -exx


endif

ifdef debug
    llflags += -g


endif

ifdef trace
    llflags += -d __trace__=-1


endif

ifdef profile
    llflags += -profile


endif
    
ifdef ll_audio
    llflags += -d ll_audio=-1


endif
    
ifndef console
  ifndef debug
    ifndef exx_err
      ifndef ex_err
        ifndef err

          llflags += -s gui
          
        endif
      
      endif
      
    endif
    
  endif

endif
    
ifdef catch_err
    errtrap += > trap_error.txt


endif
    

###########################################################################################




## headers...
###########################################################################################

    
    ll_headers += ../headers/ll/headers.bi
    
      ll_headers += ../headers/ll/macros.bi
      ll_headers += ../headers/ll/engine_enums.bi
      ll_headers += ../headers/ll/image_structures.bi
      ll_headers += ../headers/ll/sequence_structures.bi
      ll_headers += ../headers/ll/object_structures.bi
      ll_headers += ../headers/ll/map_structures.bi
      ll_headers += ../headers/ll/lynn_structures.bi
      ll_headers += ../headers/ll/box_structures.bi
      ll_headers += ../headers/ll/ll_declares.bi
      ll_headers += ../headers/ll/global_structures.bi
      ll_headers += ../headers/ll/gfx.bi

      ll_headers += ../generic/fb_Global.bi
    
      ifdef ll_audio
        ll_headers += ../headers/ll/audio.bi
        
      endif
    
    object_headers += ../headers/ll/object_control.bi 
    object_headers += ../headers/ll/constants.bi 
    
    utility_headers += ../headers/utility.bi 
    utility_headers += ../headers/xml.bi 
    utility_headers += ../headers/lists.bi 
    utility_headers += ../headers/matrices.bi 
    
    utility_headers += ../headers/vfile.bi 
    utility_headers += ../headers/zlibFB.bi 
    
    
    all_headers += $(ll_headers) $(utility_headers) $(object_headers)


###########################################################################################




## set up targets
###########################################################################################

    ll_exe := ll.exe

    com_srcpath := ../com
    com_sources += ll_build.bas utility.bas object_control.bas binary_objects.bas vfile.bas zFB.bas
    

    com_sources += object_modification.bas object_move.bas object_time.bas object_sound.bas object_states.bas
    com_sources += object_boss.bas object_etc.bas
    
    com_sources += gfx.bas
    com_sources += engine--gfx_LL.bas

    com_sources += object--gfx.bas
    com_sources += object--gfx_animation.bas
    com_sources += object--gfx_frame.bas
    com_sources += object--gfx_palette.bas

    com_sources += engine--object.bas
    com_sources += engine--object_damage.bas
    com_sources += engine--object_XML.bas

    com_sources += engine--LL.bas
    com_sources += engine--images.bas
    com_sources += engine--etc.bas
    
    com_sources += xml.bas
    com_sources += lists.bas
    com_sources += matrices.bas

    gen_srcpath := ../generic
    com_sources += fb_Global.bas

      ifdef ll_audio
        unique_sources += audio.bas
        
      endif
    
    objpath := obj
    
    gen_objects := $(patsubst %.bas,$(objpath)/%.o,$(gen_sources)) 
    com_objects := $(patsubst %.bas,$(objpath)/%.o,$(com_sources)) 
    unique_objects := $(patsubst %.bas,$(objpath)/%.o,$(unique_sources)) 


    
    ll_objects = $(com_objects) $(unique_objects) $(gen_objects)

###########################################################################################




## compile
###########################################################################################


$(objpath)/%.o : $(gen_srcpath)/%.bas $(all_headers)
	$(FBC) $(llflags) -c $< -o $@ 

$(objpath)/%.o : $(com_srcpath)/%.bas $(all_headers)
	$(FBC) $(llflags) -c $< -o $@ 
    
$(objpath)/%.o : %.bas $(all_headers)
	$(FBC) $(llflags) -c $< -o $@ 

    
../../$(ll_exe): ll.bas $(ll_objects)
	$(FBC) $(llflags) ll.bas $(ll_objects) -x ../../$(ll_exe) ll.rc


###########################################################################################








###########################################################################################

.PHONY : clean
clean:
	rm -f $(ll_objects)
	rm -f ../../$(ll_exe)     
