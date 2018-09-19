
# define the main file to compile (this file then includes all other files)
SRC_MAIN := main.asm

# arguments for TASM
TASM_ARGS = -80 -x -g0 -b -y 

# define some directories
TOOL_DIR=$(CURDIR)/../_tools
SRC_DIR=$(CURDIR)/src
OUT_DIR=$(CURDIR)/out

# This is where Make looks for the source files!
VPATH = $(SRC_DIR)

# find all files that end with .asm
SRC_FILES := $(foreach sdir,$(SRC_DIR),$(wildcard $(sdir)/*.asm))

# remove the main source file from the list
SRC_FILES := $(filter-out $(SRC_DIR)/$(SRC_MAIN),$(SRC_FILES))

# set path to folder with TAB-files for tasm
export TASMTABS=$(TOOL_DIR)/tasm32/

# main compilation target, is dependent on all asm files and the output directory
$(OUT_DIR)/main.bin: $(SRC_MAIN) $(SRC_FILES) $(OUT_DIR)
	cd $(SRC_DIR) && $(TOOL_DIR)\tasm32\tasm.exe $(TASM_ARGS) "$<" "$@" "$(basename $@).lst"

# target for creating the output directory if not found
$(OUT_DIR):
	mkdir "$(OUT_DIR)"

# target for uploading the file, depends on the generated .bin file
install: $(OUT_DIR)/main.bin
	java -Djava.library.path=$(TOOL_DIR)\SerialUpload -jar $(TOOL_DIR)\SerialUpload\SerialUpload.jar $<

# this removes the output files
clean:
	del /S /Q /F "$(OUT_DIR)\*"

.PHONY: clean install