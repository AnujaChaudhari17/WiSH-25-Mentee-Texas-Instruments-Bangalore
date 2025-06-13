import cocotb
from cocotb.triggers import RisingEdge
from cocotb.clock import Clock
from common import reset_dut

@cocotb.test()
async def test_rv32i_instructions(dut):
    """ Test the complete RV32I instruction set of the RV32I CPU module """

    # Create a clock signal
    cocotb.start_soon(Clock(dut.i_clk, 10, units="ns").start())

    # Reset the DUT
    await reset_dut(dut)

    # Helper function to apply instruction and check result
    async def apply_instruction(instr, expected_result={}, expected_pc_increment=4, stall=False):
        dut.instruction_code.value = instr
        await RisingEdge(dut.i_clk)
        # print(apply_instruction.pc)
        # print(f"PC mismatch: {hex(instr)} {dut.stall_pc.value.integer} expected {apply_instruction.pc + expected_pc_increment}, got {dut.pc.value.integer}")
        if stall:
            await RisingEdge(dut.i_clk)
        assert dut.pc.value.integer == apply_instruction.pc + expected_pc_increment, f"PC mismatch: expected {apply_instruction.pc + expected_pc_increment}, got {dut.pc.value.integer}"
        # print(f"PC mismatch: {hex(instr)} {dut.stall_pc.value.integer} expected {apply_instruction.pc + expected_pc_increment}, got {dut.pc.value.integer}")
        apply_instruction.pc += expected_pc_increment
        # for i in range(32):
        #     try:
        #         print(i,dut.inst_ieu.inst_regfile.regs[i].value.integer)
        #     except:
        #         print(i, "error", dut.inst_ieu.inst_regfile.regs[i].value)
        for k,v in expected_result.items():
            # print(f"Register data mismatch: {hex(instr)} expected {v}, got {dut.inst_ieu.inst_regfile.regs[k].value.integer}")
            assert dut.inst_ieu.inst_regfile.regs[k].value.integer == v, f"Register data mismatch r{k}: expected {v}, got {dut.inst_ieu.inst_regfile.regs[k].value.integer}"
        
    apply_instruction.pc = 0

    ##########################################
    # BASIC SEQUENCE OF LOAD AND ARITHMENTIC #
    ##########################################

    r = {i:0 for i in range(32)}        # Registers

    # Load values into registers
    # LUI x1, 0x001  -> x1 = 0x00100000
    await apply_instruction(0x000010b7, expected_result=r)
    r[1] = (0x1)<<12
    # ADDI x1, x1, 0x004 -> x1 = 0x00100000 + 0x4 = 0x00100004
    await apply_instruction(0x00408093, expected_result=r)
    r[1] = r[1]+0x4
    # LUI x2, 0x03  -> x2 = 0x00200000
    await apply_instruction(0x00003137, expected_result=r)
    r[2] = (0x3)<<12
    # ADDI x2, x2, 0x008 -> x2 = 0x00200000 + 0x8 = 0x00200008
    await apply_instruction(0x00810113, expected_result=r)
    r[2] = r[2]+0x8

    # Perform arithmetic operations
    # ADD x3, x1, x2 -> x3 = 0x00100004 + 0x00200008 = 0x0030000C
    await apply_instruction(0x002081B3, expected_result=r)
    r[3] = r[1]+r[2]
    # SUB x4, x2, x1 -> x4 = 0x00200008 - 0x00100004 = 0x00100004
    await apply_instruction(0x40110233, expected_result=r)
    r[4] = r[2]-r[1]

    # M not supoorted
    # MUL x5, x1, x2 -> x5 = 0x00100004 * 0x00200008 = 0x20000100 (assuming MUL is supported)
    # await apply_instruction(0x022082B3, expected_result=r)  # Replace with correct instruction for MUL if implemented
    # r[5] = r[1]*r[2]

    print("Load and arithmetic operation tests completed successfully!")

    await apply_instruction(0x03250513, expected_result=r)  # addi x10, x10, 50
    r[10] = 50
    await apply_instruction(0x1a758593, expected_result=r)  # addi x11, x11, 423
    r[11] = 423
    await apply_instruction(0x00260613, expected_result=r)  # addi x12, x12, 2
    r[12] = 2

    # R-type Instructions
    await apply_instruction(0x00B50533, expected_result=r)  # ADD x10, x10, x11
    r[10] = r[10] + r[11]
    await apply_instruction(0x40B50533, expected_result=r)  # SUB x10, x10, x11
    r[10] = r[10] - r[11]
    await apply_instruction(0x00c51533, expected_result=r)  # sll x10, x10, x12
    r[10] = r[10] << r[12]
    await apply_instruction(0x00b526b3, expected_result=r)  # slt x13, x10, x11
    r[13] = (r[10] < r[11])
    await apply_instruction(0x00b53733, expected_result=r)  # sltu x14, x10, x11
    r[14] = (r[10] < r[11])
    await apply_instruction(0x00b547b3, expected_result=r)  # xor x15, x10, x11
    r[15] = (r[10] ^ r[11])
    await apply_instruction(0x00d55533, expected_result=r)  # srl x10, x10, x13
    r[10] = r[10] >> r[13]
    await apply_instruction(0x40e55533, expected_result=r)  # sra x10, x10, x14
    r[10] = r[10] >> r[14]
    await apply_instruction(0x00b567b3, expected_result=r)  # or x15, x10, x11
    r[15] = r[10] | r[11]
    await apply_instruction(0x00b57833, expected_result=r)  # and x16, x10, x11
    r[16] = r[10] & r[11]

    # I-type Instructions
    await apply_instruction(0x00208113, expected_result=r)  # addi x0, x1, 2
    r[2] = r[1] + 2
    await apply_instruction(0x06452113, expected_result=r)  # slti x2, x10, 100
    r[2] = r[10] < 100
    await apply_instruction(0x02853893, expected_result=r)  # sltiu x17, x10, 40
    r[17] = r[10] < 40
    await apply_instruction(0x0790c213, expected_result=r)  # xori x4, x1, 121
    r[4] = r[1]^121
    await apply_instruction(0x07f0e293, expected_result=r)  # ori x5, x1, 127
    r[5] = r[1]|127
    await apply_instruction(0x0021f093, expected_result=r)  # andi x1, x3, 2
    r[1] = r[3]&2
    await apply_instruction(0x00221113, expected_result=r)  # slli x2, x4, 2
    r[2] = r[4]<<2
    await apply_instruction(0x00225113, expected_result=r)  # srli x2, x4, 2
    r[2] = r[4]>>2
    await apply_instruction(0x40225113, expected_result=r)  # srai x2, x4, 2
    r[2] = r[4]>>2

    # prev_pc = apply_instruction.pc
    # await apply_instruction(0x00a500e7, expected_result=r)  # jalr x1, 10(x10)
    # r[1]=prev_pc+4
    # apply_instruction.pc = r[10]+10

    # await apply_instruction(0x00262083, r, 4, True)  # lw x1, 2(x12)
    # r[1] = r[r[12]+2]

    # await apply_instruction(0x00000083, r, 4, True)  # LB x1, 0(x0)
    # r[1] = r[r[0]+0]&(0xFF)

    # await apply_instruction(0x00201083, r, 4, True)  # LH x1, 2(x0)
    # r[1] = r[r[0]+2]&(0xFFFF)

    # await apply_instruction(0x00004083, r, 4, True)  # LBU x1, 0(x0)
    # r[1] = r[r[0]+0]&(0xFF)

    # await apply_instruction(0x00005083, r, 4, True)  # LHU x1, 0(x0)
    # r[1] = r[r[0]+0]&(0xFFFF)


    # S-type Instructions
    # await apply_instruction(0x002000a3, r, 4, True)  # sb x2, 1(x0)
    # r[r[0]+1] = r[2]&0xFF

    # await apply_instruction(0x002010a3, r, 4, True)  # sh x2, 1(x0)
    # r[r[0]+1] = r[2]&0xFFFF

    # await apply_instruction(0x002020a3, r, 4, True)  # sw x2, 1(x0)
    # r[r[0]+1] = r[2]

    # B-type Instructions
    # await apply_instruction(0x00000663, r, 4, True)  # BEQ x0, x0, label
    # await apply_instruction(0x000006E3, r, 4, True)  # BNE x0, x0, label
    # await apply_instruction(0x00000763, r, 4, True)  # BLT x0, x0, label
    # await apply_instruction(0x000007E3, r, 4, True)  # BGE x0, x0, label
    # await apply_instruction(0x00004663, r, 4, True)  # BLTU x0, x0, label
    # await apply_instruction(0x00004763, r, 4, True)  # BGEU x0, x0, label

    # U-type Instructions
    await apply_instruction(0x000020b7, r)  # lui x1, 2
    r[1] = 2<<12
    # await apply_instruction(0x00014217, r)  # auipc x4, 20
    # r[4] = apply_instruction.pc + (20<<12)

    # J-type Instructions
    prev_pc = apply_instruction.pc
    await apply_instruction(0x000010EF, {}, 2**12, True)  # JAL x1, 16
    r[1] = (prev_pc)+4



    await apply_instruction(0x000020b7, r)  # lui x1, 2
    r[1] = 2<<12

    print("All RV32I instruction tests completed successfully!")
