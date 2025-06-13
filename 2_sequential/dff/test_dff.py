import cocotb
from cocotb.clock import Clock
from cocotb.triggers import Timer, FallingEdge


@cocotb.test()
async def test_dff(dut):
    dut.i_clk.value = 0
    dut.i_rstn.value = 0
    dut.i_d.value = 0

    await Timer(2, "ns")
    dut.i_rstn.value = 1

    cocotb.start_soon(Clock(dut.i_clk, 1, units="ns").start())

    vals = "101101"
    q=[]
    for val in vals:
        await FallingEdge(dut.i_clk)
        dut.i_d.value =int(val)
        q.append(dut.o_q.value.binstr)
    

    
    await FallingEdge(dut.i_clk)
    q.append(dut.o_q.value.binstr)
    q=q[1:]
    q_out= ''.join(q)
    assert q_out==vals

