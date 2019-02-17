## change To teh location of yor FeerBASIC compiilar!
###########################################################################################


    FBC := fbc


###########################################################################################




## flags
###########################################################################################


ifdef debug
    llflags += -g -exx


endif

ifdef profile
    llflags += -profile


endif

    

###########################################################################################




## headers...
###########################################################################################

    
#    ll_headers += ../headers\ll\headers.bi
    
#      ll_headers += ../headers\ll\macros.bi
#      ll_headers += ../headers\ll\engine_enums.bi
#      ll_headers += ../headers\ll\general_structures.bi
#      ll_headers += ../headers\ll\image_structures.bi
#      ll_headers += ../headers\ll\sequence_structures.bi
#      ll_headers += ../headers\ll\object_structures.bi
#      ll_headers += ../headers\ll\map_structures.bi
#      ll_headers += ../headers\ll\lynn_structures.bi
#      ll_headers += ../headers\ll\box_structures.bi
#      ll_headers += ../headers\ll\global_structures.bi
    
    
#    object_headers = 
    
#    utility_headers += ../headers\utility.bi 
#    utility_headers += ../headers\lists.bi 
#    utility_headers += ../headers\xml.bi 
    
    
    
#    all_headers += $(ll_headers) $(utility_headers) $(object_headers)


###########################################################################################




## set up targets
###########################################################################################

    ll_exe += counter.exe

    com_srcpath := ../com
#    com_sources += ll_build.bas 
#    com_sources += utility.bas 

#    com_sources += object_control.bas engine_code.bas binary_objects.bas
#    
#    com_sources += object_modification.bas object_move.bas object_time.bas object_sound.bas object_states.bas
#    com_sources += object_boss.bas object_gfx.bas object_etc.bas
#    
#    
#    com_sources += gfx.bas
    com_sources += lists.bas
#    com_sources += xml.bas
    
    
    objpath := obj
    
    com_objects := $(patsubst %.bas,$(objpath)/%.o,$(com_sources)) 

    
    ll_objects = $(com_objects) 

###########################################################################################




## compile
###########################################################################################


$(objpath)/%.o : $(com_srcpath)/%.bas $(all_headers)
	$(FBC) $(llflags) -c $< -o $@
    
$(objpath)/%.o : %.bas $(all_headers)
	$(FBC) $(llflags) -c $< -o $@

    
../../$(ll_exe): counter.bas $(ll_objects)
	$(FBC) $(llflags) counter.bas $(ll_objects) -x ../../$(ll_exe)


###########################################################################################








###########################################################################################

.PHONY : clean
clean:
	rm -f $(ll_objects)
	rm -f ../../$(ll_exe)     
