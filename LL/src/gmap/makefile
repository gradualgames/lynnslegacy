## change To the location of your FreeBASIC compiler!
###########################################################################################
## http://i2.photobucket.com/albums/y17/rojodiablo07/964F.jpg

    FBC := fbc


###########################################################################################

## flags
###########################################################################################

llflags = -d __gMap__=-1
llflags += -d ll_minimal=-1

#exx_err := 1

ifdef debug
    llflags += -g
  console = 1

endif

ifdef e_err
  llflags += -e

endif

ifdef ex_err
  llflags += -ex
  console = 1

endif

ifdef exx_err
  llflags += -exx
  console = 1

endif

ifdef profile
    llflags += -profile

endif

ifndef console
  llflags += -s gui
  
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
    ll_headers += ../headers/ll/global_structures.bi
    ll_headers += ../headers/ll/gfx.bi
    
    gmap_headers += ../headers/gmap/headers.bi
    gmap_headers += ../headers/gmap/gmap_macros.bi
    gmap_headers += ../headers/gmap/gmap_structs.bi
    
    common_headers += ../headers/utility.bi 
    common_headers += ../headers/lists.bi 
    common_headers += ../headers/xml.bi 
    common_headers += ../headers/vfile.bi 
    common_headers += ../headers/zlibFB.bi 
    
    
    all_headers += $(ll_headers) $(common_headers) $(object_headers) $(gmap_headers)


###########################################################################################

## set up targets
###########################################################################################

    ll_exe := gmap.exe
    
    
    com_srcpath := ../com
    generic_srcpath := ../generic
    
    
    com_sources += ll_build.bas 

    com_sources += engine--images.bas
    com_sources += engine--object_XML.bas
    com_sources += engine--object.bas
    com_sources += engine--etc.bas

    com_sources += binary_objects.bas 
    com_sources += gfx.bas
    com_sources += lists.bas
    com_sources += matrices.bas
    com_sources += utility.bas 
    com_sources += vfile.bas 
    com_sources += xml.bas
    com_sources += zFB.bas


    unique_sources += gMap_gfx.bas
    unique_sources += text_controls.bas 
    unique_sources += gmap_engine.bas 
    unique_sources += gmap_states.bas 
    unique_sources += box_handling.bas
    
    
    generic_sources += fb_Global.bas
    
    
    objpath := obj
    

    com_objects := $(patsubst %.bas,$(objpath)/%.o,$(com_sources)) 
    unique_objects := $(patsubst %.bas,$(objpath)/%.o,$(unique_sources)) 

    generic_objects := $(patsubst %.bas,$(objpath)/%.o,$(generic_sources)) 
    
    ll_objects = $(com_objects) $(unique_objects) $(generic_objects)

###########################################################################################

## compile
###########################################################################################

$(objpath)/%.o : $(generic_srcpath)/%.bas $(all_headers)
	$(FBC) $(llflags) -c $< -o $@
    
$(objpath)/%.o : $(com_srcpath)/%.bas $(all_headers)
	$(FBC) $(llflags) -c $< -o $@
    
$(objpath)/%.o : %.bas $(all_headers)
	$(FBC) $(llflags) -c $< -o $@

    
../../$(ll_exe): gmap.bas $(ll_objects)
	$(FBC) $(llflags) gmap.bas $(ll_objects) -x ../../$(ll_exe)


###########################################################################################

###########################################################################################

.PHONY : clean
clean:
	rm -f $(ll_objects)
	rm -f ../../$(ll_exe)     
