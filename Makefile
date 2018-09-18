
# define some directories
BIN_DIR=$(CURDIR)/../_tools
SRC_DIR=$(CURDIR)/src
OUT_DIR=$(CURDIR)/bin

# This is where Make looks for the source files!
VPATH = $(SRC_DIR)

# find all files that end with .asm
#SRC       := $(foreach sdir,$(SRC_DIR),$(wildcard $(sdir)/*.asm))

# All asm files in this project, a change forces a remake. The first one has to be the main file
ASM_FILES= main.asm cf_driver.asm cli.asm commands.asm constants.asm sio_driver.asm string.asm

# arguments to TASM
TASM_ARGS = -80 -x -g0 -b -y 

# set path to folder with TAB-files for tasm
export TASMTABS=$(BIN_DIR)/tasm32/

# main compilation target, is dependent on all asm files
$(OUT_DIR)/main.bin: $(ASM_FILES)
	cd $(SRC_DIR) && $(BIN_DIR)\tasm32\tasm.exe $(TASM_ARGS) "$<" "$@" "$(basename $@).lst"


# target for uploading the file, depends on the generated .bin file
install: $(OUT_DIR)/main.bin
	
	java -Djava.library.path=$(BIN_DIR)\SerialUpload -jar $(BIN_DIR)\SerialUpload\SerialUpload.jar $<


.PHONY: install