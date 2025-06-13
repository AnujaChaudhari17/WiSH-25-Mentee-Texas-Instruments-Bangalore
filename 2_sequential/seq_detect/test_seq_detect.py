import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, FallingEdge


@cocotb.test()
async def test_seq_detect(dut):
    data_in = "01001110011011100110111100"
    dut.i_clk.value = 0
    dut.i_rstn.value = 0
    dut.i_data.value = 0

    data_detected= []
    await Timer(2, "ns")
    dut.i_rstn.value = 1
    cocotb.start_soon(Clock(dut.i_clk, 1, units="ns").start())
    for val in data_in:
        await FallingEdge(dut.i_clk)
        dut.i_data.value = int(val)
        data_detected.append(dut.o_detect.value.binstr)

    data_out=''.join(data_detected)
    moore_val= "00000000000000000000000010"
    mealy_val= "00000000000000000000000001"
    if data_out == moore_val:
        cocotb.log.info(f"detected in same cycle")
    elif data_out== mealy_val:
        cocotb.log.info(f"detected in next cycle")
    else:
        cocotb.log.info(f"not detected, data_out= {data_out}, data_in= {data_in}")
        assert False
    
    await FallingEdge(dut.i_clk)
