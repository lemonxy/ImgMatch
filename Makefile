
#ROOT_SRC_DIR=$(CURDIR)
#ROOT_SRC_DIR=$(dir $(realpath $(lastword $(MAKEFILE_LIST))))


include ./defines.mk

ifneq (,$(findstring OCVIMAGE, $(IMAGEIMP)))
    USE_OPENCV=1
endif

ifneq (,$(findstring 1, $(USE_OPENCV)))
    ifneq (,$(OPENCVINC))
        CPPFLAGS+=-I$(OPENCVINC)
    endif

    ifneq (,$(OPENCVLIB))
        LDFLAGS+=-L$(OPENCVLIB)
    endif

    LDLIBS+=-lopencv_core$(OPENCVVER) -lopencv_highgui$(OPENCVVER) -lopencv_ml$(OPENCVVER) -lopencv_imgproc$(OPENCVVER)
endif

CPPFLAGS+=-D$(IMAGEIMP)

export USE_OPENCV
export OPENCVLIB
export OPENCVINC
export OPENCVVER
export IMAGEIMP

export CPPFLAGS
export CXXFLAGS
export LDFLAGS
export LDLIBS

export COREDIR=core
export UIDIR=qtui
export BINDIR=bin
export BUILDDIR=build


ALLDIRS=$(COREDIR) $(UIDIR)


.PHONY: $(ALLDIRS) all clean


all: $(ALLDIRS)


$(COREDIR):
	$(MAKE) -C $@


$(UIDIR):
ifneq (,$(findstring qt, $(UIDIR)))
	cd $(UIDIR); qmake CONFIG+=$(IMAGEIMP); $(MAKE)
else
	$(error Don't know how to make UIDIR = $(UIDIR))
endif


clean:
	-@for dir in $(ALLDIRS); do $(MAKE) -C $$dir $@; done
#	-@for dir in $(ALLDIRS); do ( cd $$dir; $(MAKE) $@ ); done
