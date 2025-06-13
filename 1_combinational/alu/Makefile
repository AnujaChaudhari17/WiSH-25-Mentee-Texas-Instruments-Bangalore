SIM = icarus
TOPLEVEL_LANG = verilog
ifeq ($(CORE),1)
	top = alu_core
	VERILOG_SOURCES = alu_core.sv 
else
	top = alu
	VERILOG_SOURCES = alu.sv alu_core.sv
endif

TOPLEVEL = $(top)
MODULE = test_$(top)
include $(shell cocotb-config --makefiles)/Makefile.sim
