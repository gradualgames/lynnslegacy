## change To teh location of yor FeerBASIC compiilar!
###########################################################################################


    FBC := fbc


###########################################################################################




## flags
###########################################################################################


ifdef debug
    llflags += -g


endif

ifdef profile
    llflags += -profile


endif
    

###########################################################################################




## headers...
###########################################################################################

    
    main_headers += ../headers\replacer\replacer_declares.bi
    
    utility_headers += ../headers\utility.bi 
    
    
    
    main_headers += $(utility_headers)


###########################################################################################




## set up targets
###########################################################################################

    target_exe := replacer.exe

    com_srcpath := ../com
    com_sources += utility.bas
    com_sources += lists.bas
    com_sources += xml.bas
    
    
    unique_sources = parser_code.bas
    
    
    objpath := obj
    
    com_objects := $(patsubst %.bas,$(objpath)/%.o,$(com_sources)) 
    unique_objects := $(patsubst %.bas,$(objpath)/%.o,$(unique_sources)) 
    
    objects = $(com_objects) $(unique_objects)

###########################################################################################




## compile
###########################################################################################


$(objpath)/%.o : $(com_srcpath)/%.bas $(main_headers)
	$(FBC) $(llflags) -c $< -o $@
    
$(objpath)/%.o : %.bas $(main_headers)
	$(FBC) $(llflags) -c $< -o $@

    
../../$(target_exe): replacer.bas $(objects)
	$(FBC) $(llflags) replacer.bas $(objects) -x ../../$(target_exe)


###########################################################################################








###########################################################################################

.PHONY : clean
clean:
	rm -f $(objects)
	rm -f ../../$(target_exe)     
