# Build the Fortran programs
include make.flags

BIN=bin
EXEC=exec
SRC=src
FDEPENDS = $(SRC)/mercury.inc $(SRC)/swift.inc .obj/yorp_module.o

# --- Help
help:
	@echo
	@echo 'Supported Makefile invocations:'
	@echo 'make build	- Build the Fortran programs as needed'
	@echo 'make unbuild	- Remove all Fortran program executables'
	@echo

# --- Build Fortran programs
build:	$(BIN)/close6 $(BIN)/element6 $(BIN)/mercury6 $(BIN)/mercury6_yorp

$(BIN)/close6:	$(FDEPENDS) $(SRC)/close6.for
	$(FORTRAN) $(FFLAGS) -o $(BIN)/close6 $(SRC)/close6.for

$(BIN)/element6:	$(FDEPENDS) $(SRC)/element6.for
	$(FORTRAN) $(FFLAGS) -o $(BIN)/element6 $(SRC)/element6.for

$(BIN)/mercury6:	$(FDEPENDS) $(SRC)/mercury6_2.for
	$(FORTRAN) $(FFLAGS) -o $(BIN)/mercury6 $(SRC)/mercury6_2.for

$(BIN)/mercury6_yorp:	$(FDEPENDS) $(SRC)/mercury6_2_yorp.for 
	$(FORTRAN) $(FFLAGS) -o $(BIN)/mercury6_yorp $(SRC)/mercury6_2_yorp.for .obj/yorp_module.o

.obj/yorp_module.o: src/yorp_module.f90 
	$(FORTRAN) $(FFLAGS) -c $< -o $@

# --- Remove executable files
unbuild:
	rm -f $(BIN)/element6 $(BIN)/close6 $(BIN)/mercury6 $(BIN)/mercury6_yorp
	rm -f .mod/* .obj/*
