SIM = icarus
TOPLEVEL_LANG = verilog

VER_DIR = ../ver

ifeq ($(MAKECMDGOALS), )
ifndef tname
$(error $$tname must be defined. Use `make tname=<testcase_name>`)
endif
endif

top = $(tname)
ifeq ($(top), alu)
	tops = $(VER_DIR)/alu.sv $(VER_DIR)/alu_core.sv
else
	tops = $(VER_DIR)/$(top).sv
endif
VERILOG_SOURCES = $(VER_DIR)/processor_defines.sv $(tops)

TOPLEVEL = $(top)
MODULE = test_$(top)
COMPILE_ARGS += -I $(VER_DIR)
WAVES = 1
include $(shell cocotb-config --makefiles)/Makefile.sim

.PHONY: ${SIM_BUILD}/sim.vvp ${SIM_BUILD}/cocotb_iverilog_dump.v
