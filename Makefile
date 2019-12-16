CC=gcc
AR=ar
STRIP=strip

INCLUDE=include
SRC=src
OBJ=obj

DEPLOY=deploy
TEST=test
BSDIFF_STATIC=libbsdiff.a
BSDIFF_SHARED=libbsdiff.so
BSDIFF_TEST=bstest
LIBS=-lbz2
CFLAGS=-I$(INCLUDE) -fPIC

BSDIFF_OBJ:= $(OBJ)/bsdiff.o \
			 $(OBJ)/bspatch.o

$(OBJ)/%.o: $(SRC)/%.c
	$(CC) -c -o $@ $< $(CFLAGS)

libbsdiff: $(BSDIFF_OBJ)
		   mkdir -p $(OBJ)
		   mkdir -p $(DEPLOY)
		   $(AR) rcs $(DEPLOY)/$(BSDIFF_STATIC) $(BSDIFF_OBJ)
		   $(CC) -shared -o $(DEPLOY)/$(BSDIFF_SHARED) $(BSDIFF_OBJ) $(CFLAGS) $(LIBS)

bstest: $(BSDIFF_OBJ)
	$(CC) -o $(DEPLOY)/$(BSDIFF_TEST) $(TEST)/$(BSDIFF_TEST).c -I$(INCLUDE) -L$(DEPLOY) -lbsdiff

run:
	@export LD_LIBRARY_PATH=$(PWD)/$(DEPLOY)
	@$(DEPLOY)/$(BSDIFF_TEST)

.PHONY: clean

clean:
	rm -f $(DEPLOY)/* $(OBJ)/*
