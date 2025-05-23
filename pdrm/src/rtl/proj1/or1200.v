//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's definitions                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Defines for the OR1200 core                                 ////
////                                                              ////
////  To Do:                                                      ////
////   - add parameters that are missing                          ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_defines.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, bugs fixed. 

//
// Dump VCD
//
//`define OR1200_VCD_DUMP

//
// Generate debug messages during simulation
//
//`define OR1200_VERBOSE

`define OR1200_ASIC
////////////////////////////////////////////////////////
//
// Typical configuration for an ASIC
//
`ifdef OR1200_ASIC

//
// Target ASIC memories
//
//`define OR1200_ARTISAN_SSP
//`define OR1200_ARTISAN_SDP
//`define OR1200_ARTISAN_STP
//`define OR1200_VIRTUALSILICON_SSP
//`define OR1200_VIRTUALSILICON_STP_T1
//`define OR1200_VIRTUALSILICON_STP_T2
//`define OR1200_GF_ARM_28SLP

//
// Do not implement Data cache
//
`define OR1200_NO_DC

//
// Do not implement Insn cache
//
`define OR1200_NO_IC

//
// Do not implement Data MMU
//
`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
`define OR1200_NO_IMMU

//
// Select between ASIC optimized and generic multiplier
//
`define OR1200_ASIC_MULTP2_32X32
//`define OR1200_GENERIC_MULTP2_32X32

//
// Size/type of insn/data cache if implemented
//
// `define OR1200_IC_1W_512B
// `define OR1200_IC_1W_4KB
`define OR1200_IC_1W_8KB
// `define OR1200_DC_1W_4KB
`define OR1200_DC_1W_8KB

`else


/////////////////////////////////////////////////////////
//
// Typical configuration for an FPGA
//

//
// Target FPGA memories
//
//`define OR1200_ALTERA_LPM
//`define OR1200_XILINX_RAMB16
//`define OR1200_XILINX_RAMB4
//`define OR1200_XILINX_RAM32X1D
//`define OR1200_USE_RAM16X1D_FOR_RAM32X1D
// Generic models should infer RAM blocks at synthesis time (not only effects 
// single port ram.)
`define OR1200_GENERIC

//
// Do not implement Data cache
//
//`define OR1200_NO_DC

//
// Do not implement Insn cache
//
//`define OR1200_NO_IC

//
// Do not implement Data MMU
//
//`define OR1200_NO_DMMU

//
// Do not implement Insn MMU
//
//`define OR1200_NO_IMMU

//
// Select between ASIC and generic multiplier
//
// (Generic seems to trigger a bug in the Cadence Ncsim simulator)
//
//`define OR1200_ASIC_MULTP2_32X32
`define OR1200_GENERIC_MULTP2_32X32

//
// Size/type of insn/data cache if implemented
// (consider available FPGA memory resources)
//
//`define OR1200_IC_1W_512B
//`define OR1200_IC_1W_4KB
`define OR1200_IC_1W_8KB
//`define OR1200_DC_1W_4KB
`define OR1200_DC_1W_8KB

`endif


//////////////////////////////////////////////////////////
//
// Do not change below unless you know what you are doing
//

//
// Reset active low
//
//`define OR1200_RST_ACT_LOW

//
// Enable RAM BIST
//
// At the moment this only works for Virtual Silicon
// single port RAMs. For other RAMs it has not effect.
// Special wrapper for VS RAMs needs to be provided
// with scan flops to facilitate bist scan.
//
//`define OR1200_BIST

//
// Register OR1200 WISHBONE outputs
// (must be defined/enabled)
//
`define OR1200_REGISTERED_OUTPUTS

//
// Register OR1200 WISHBONE inputs
//
// (must be undefined/disabled)
//
//`define OR1200_REGISTERED_INPUTS

//
// Disable bursts if they are not supported by the
// memory subsystem (only affect cache line fill)
//
//`define OR1200_NO_BURSTS
//

//
// WISHBONE retry counter range
//
// 2^value range for retry counter. Retry counter
// is activated whenever *wb_rty_i is asserted and
// until retry counter expires, corresponding
// WISHBONE interface is deactivated.
//
// To disable retry counters and *wb_rty_i all together,
// undefine this macro.
//
//`define OR1200_WB_RETRY 7

//
// WISHBONE Consecutive Address Burst
//
// This was used prior to WISHBONE B3 specification
// to identify bursts. It is no longer needed but
// remains enabled for compatibility with old designs.
//
// To remove *wb_cab_o ports undefine this macro.
//
//`define OR1200_WB_CAB

//
// WISHBONE B3 compatible interface
//
// This follows the WISHBONE B3 specification.
// It is not enabled by default because most
// designs still don't use WB b3.
//
// To enable *wb_cti_o/*wb_bte_o ports,
// define this macro.
//
`define OR1200_WB_B3

//
// LOG all WISHBONE accesses
//
`define OR1200_LOG_WB_ACCESS

//
// Enable additional synthesis directives if using
// _Synopsys_ synthesis tool
//
//`define OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES

//
// Enables default statement in some case blocks
// and disables Synopsys synthesis directive full_case
//
// By default it is enabled. When disabled it
// can increase clock frequency.
//
`define OR1200_CASE_DEFAULT

//
// Operand width / register file address width
//
// (DO NOT CHANGE)
//
`define OR1200_OPERAND_WIDTH		32
`define OR1200_REGFILE_ADDR_WIDTH	5

//
// l.add/l.addi/l.and and optional l.addc/l.addic
// also set (compare) flag when result of their
// operation equals zero
//
// At the time of writing this, default or32
// C/C++ compiler doesn't generate code that
// would benefit from this optimization.
//
// By default this optimization is disabled to
// save area.
//
//`define OR1200_ADDITIONAL_FLAG_MODIFIERS

//
// Implement l.addc/l.addic instructions
//
// By default implementation of l.addc/l.addic
// instructions is enabled in case you need them.
// If you don't use them, then disable implementation
// to save area.
//
//`define OR1200_IMPL_ADDC

//
// Implement l.sub instruction
//
// By default implementation of l.sub instructions
// is enabled to be compliant with the simulator.
// If you don't use carry bit, then disable
// implementation to save area.
//
`define OR1200_IMPL_SUB

//
// Implement carry bit SR[CY]
//
//
// By default implementation of SR[CY] is enabled
// to be compliant with the simulator. However SR[CY]
// is explicitly only used by l.addc/l.addic/l.sub
// instructions and if these three insns are not
// implemented there is not much point having SR[CY].
//
//`define OR1200_IMPL_CY

//
// Implement rotate in the ALU
//
// At the time of writing this, or32
// C/C++ compiler doesn't generate rotate
// instructions. However or32 assembler
// can assemble code that uses rotate insn.
// This means that rotate instructions
// must be used manually inserted.
//
// By default implementation of rotate
// is disabled to save area and increase
// clock frequency.
//
//`define OR1200_IMPL_ALU_ROTATE

//
// Type of ALU compare to implement
//
// Try either one to find what yields
// higher clock frequencyin your case.
//
//`define OR1200_IMPL_ALU_COMP1
`define OR1200_IMPL_ALU_COMP2

//
// Implement Find First/Last '1'
//
`define OR1200_IMPL_ALU_FFL1

//
// Implement multiplier
//
// By default multiplier is implemented
//
`define OR1200_MULT_IMPLEMENTED

//
// Implement multiply-and-accumulate
//
// By default MAC is implemented. To
// implement MAC, multiplier needs to be
// implemented.
//
`define OR1200_MAC_IMPLEMENTED

//
// Implement optional l.div/l.divu instructions
//
// By default divide instructions are not implemented
// to save area and increase clock frequency. or32 C/C++
// compiler can use soft library for division.
//
// To implement divide, both multiplier and MAC needs to be implemented.
//
`define OR1200_DIV_IMPLEMENTED

//
// Low power, slower multiplier
//
// Select between low-power (larger) multiplier
// and faster multiplier. The actual difference
// is only AND logic that prevents distribution
// of operands into the multiplier when instruction
// in execution is not multiply instruction
//
//`define OR1200_LOWPWR_MULT

//
// Implement HW Single Precision FPU
//
`define OR1200_FPU_IMPLEMENTED
//

//
// Clock ratio RISC clock versus WB clock
//
// If you plan to run WB:RISC clock fixed to 1:1, disable
// both defines
//
// For WB:RISC 1:2 or 1:1, enable OR1200_CLKDIV_2_SUPPORTED
// and use clmode to set ratio
//
// For WB:RISC 1:4, 1:2 or 1:1, enable both defines and use
// clmode to set ratio
//
//`define OR1200_CLKDIV_2_SUPPORTED
//`define OR1200_CLKDIV_4_SUPPORTED

//
// Type of register file RAM
//
// Memory macro w/ two ports (see or1200_tpram_32x32.v)
//`define OR1200_RFRAM_TWOPORT
//
// Memory macro dual port (see or1200_dpram.v)
//`define OR1200_RFRAM_DUALPORT

//
// Generic (flip-flop based) register file (see or1200_rfram_generic.v)
`define OR1200_RFRAM_GENERIC
//  Generic register file supports - 16 registers 
//`ifdef OR1200_RFRAM_GENERIC
//    `define OR1200_RFRAM_16REG
//`endif

//
// Type of mem2reg aligner to implement.
//
// Once OR1200_IMPL_MEM2REG2 yielded faster
// circuit, however with today tools it will
// most probably give you slower circuit.
//
`define OR1200_IMPL_MEM2REG1
//`define OR1200_IMPL_MEM2REG2

//
// Reset value and event
//
`ifdef OR1200_RST_ACT_LOW
  `define OR1200_RST_VALUE      (1'b0)
  `define OR1200_RST_EVENT      negedge
`else
  `define OR1200_RST_VALUE      (1'b1)
  `define OR1200_RST_EVENT      posedge
`endif

//
// ALUOPs
//
`define OR1200_ALUOP_WIDTH	4
`define OR1200_ALUOP_NOP	4'd4
/* Order defined by arith insns that have two source operands both in regs
   (see binutils/include/opcode/or32.h) */
`define OR1200_ALUOP_ADD	4'd0
`define OR1200_ALUOP_ADDC	4'd1
`define OR1200_ALUOP_SUB	4'd2
`define OR1200_ALUOP_AND	4'd3
`define OR1200_ALUOP_OR		4'd4
`define OR1200_ALUOP_XOR	4'd5
`define OR1200_ALUOP_MUL	4'd6
`define OR1200_ALUOP_CUST5	4'd7
`define OR1200_ALUOP_SHROT	4'd8
`define OR1200_ALUOP_DIV	4'd9
`define OR1200_ALUOP_DIVU	4'd10
/* Order not specifically defined. */
`define OR1200_ALUOP_IMM	4'd11
`define OR1200_ALUOP_MOVHI	4'd12
`define OR1200_ALUOP_COMP	4'd13
`define OR1200_ALUOP_MTSR	4'd14
`define OR1200_ALUOP_MFSR	4'd15
`define OR1200_ALUOP_CMOV	4'd14
`define OR1200_ALUOP_FFL1	4'd15


// ALU instructions second opcode field (previously multicycle field in 
// machine word)
`define OR1200_ALUOP2_POS		9:8
`define OR1200_ALUOP2_WIDTH	2


//
// MACOPs
//
`define OR1200_MACOP_WIDTH	3
`define OR1200_MACOP_NOP	3'b000
`define OR1200_MACOP_MAC	3'b001
`define OR1200_MACOP_MSB	3'b010

//
// Shift/rotate ops
//
`define OR1200_SHROTOP_WIDTH	2
`define OR1200_SHROTOP_NOP	2'd0
`define OR1200_SHROTOP_SLL	2'd0
`define OR1200_SHROTOP_SRL	2'd1
`define OR1200_SHROTOP_SRA	2'd2
`define OR1200_SHROTOP_ROR	2'd3

// Execution cycles per instruction
`define OR1200_MULTICYCLE_WIDTH	3
`define OR1200_ONE_CYCLE		3'd0
`define OR1200_TWO_CYCLES		3'd1

// Execution control which will "wait on" a module to finish
`define OR1200_WAIT_ON_WIDTH 2
`define OR1200_WAIT_ON_FPU `OR1200_WAIT_ON_WIDTH'd1
`define OR1200_WAIT_ON_MTSPR `OR1200_WAIT_ON_WIDTH'd2

// Operand MUX selects
`define OR1200_SEL_WIDTH		2
`define OR1200_SEL_RF			2'd0
`define OR1200_SEL_IMM			2'd1
`define OR1200_SEL_EX_FORW		2'd2
`define OR1200_SEL_WB_FORW		2'd3

//
// BRANCHOPs
//
`define OR1200_BRANCHOP_WIDTH		3
`define OR1200_BRANCHOP_NOP		3'd0
`define OR1200_BRANCHOP_J		3'd1
`define OR1200_BRANCHOP_JR		3'd2
`define OR1200_BRANCHOP_BAL		3'd3
`define OR1200_BRANCHOP_BF		3'd4
`define OR1200_BRANCHOP_BNF		3'd5
`define OR1200_BRANCHOP_RFE		3'd6

//
// LSUOPs
//
// Bit 0: sign extend
// Bits 1-2: 00 doubleword, 01 byte, 10 halfword, 11 singleword
// Bit 3: 0 load, 1 store
`define OR1200_LSUOP_WIDTH		4
`define OR1200_LSUOP_NOP		4'b0000
`define OR1200_LSUOP_LBZ		4'b0010
`define OR1200_LSUOP_LBS		4'b0011
`define OR1200_LSUOP_LHZ		4'b0100
`define OR1200_LSUOP_LHS		4'b0101
`define OR1200_LSUOP_LWZ		4'b0110
`define OR1200_LSUOP_LWS		4'b0111
`define OR1200_LSUOP_LD			4'b0001
`define OR1200_LSUOP_SD			4'b1000
`define OR1200_LSUOP_SB			4'b1010
`define OR1200_LSUOP_SH			4'b1100
`define OR1200_LSUOP_SW			4'b1110

// Number of bits of load/store EA precalculated in ID stage
// for balancing ID and EX stages.
//
// Valid range: 2,3,...,30,31
`define OR1200_LSUEA_PRECALC		2

// FETCHOPs
`define OR1200_FETCHOP_WIDTH		1
`define OR1200_FETCHOP_NOP		1'b0
`define OR1200_FETCHOP_LW		1'b1

//
// Register File Write-Back OPs
//
// Bit 0: register file write enable
// Bits 3-1: write-back mux selects
//
`define OR1200_RFWBOP_WIDTH		4
`define OR1200_RFWBOP_NOP		4'b0000
`define OR1200_RFWBOP_ALU		3'b000
`define OR1200_RFWBOP_LSU		3'b001
`define OR1200_RFWBOP_SPRS		3'b010
`define OR1200_RFWBOP_LR		3'b011
`define OR1200_RFWBOP_FPU		3'b100

// Compare instructions
`define OR1200_COP_SFEQ       3'b000
`define OR1200_COP_SFNE       3'b001
`define OR1200_COP_SFGT       3'b010
`define OR1200_COP_SFGE       3'b011
`define OR1200_COP_SFLT       3'b100
`define OR1200_COP_SFLE       3'b101
`define OR1200_COP_X          3'b111
`define OR1200_SIGNED_COMPARE 'd3
`define OR1200_COMPOP_WIDTH	4

//
// FP OPs
//
// MSbit indicates FPU operation valid
//
`define OR1200_FPUOP_WIDTH	8
// FPU unit from Usselman takes 5 cycles from decode, so 4 ex. cycles
`define OR1200_FPUOP_CYCLES 3'd4
// FP instruction is double precision if bit 4 is set. We're a 32-bit 
// implementation thus do not support double precision FP 
`define OR1200_FPUOP_DOUBLE_BIT 4
`define OR1200_FPUOP_ADD  8'b0000_0000
`define OR1200_FPUOP_SUB  8'b0000_0001
`define OR1200_FPUOP_MUL  8'b0000_0010
`define OR1200_FPUOP_DIV  8'b0000_0011
`define OR1200_FPUOP_ITOF 8'b0000_0100
`define OR1200_FPUOP_FTOI 8'b0000_0101
`define OR1200_FPUOP_REM  8'b0000_0110
`define OR1200_FPUOP_RESERVED  8'b0000_0111
// FP Compare instructions
`define OR1200_FPCOP_SFEQ 8'b0000_1000
`define OR1200_FPCOP_SFNE 8'b0000_1001
`define OR1200_FPCOP_SFGT 8'b0000_1010
`define OR1200_FPCOP_SFGE 8'b0000_1011
`define OR1200_FPCOP_SFLT 8'b0000_1100
`define OR1200_FPCOP_SFLE 8'b0000_1101

//
// TAGs for instruction bus
//
`define OR1200_ITAG_IDLE	4'h0	// idle bus
`define	OR1200_ITAG_NI		4'h1	// normal insn
`define OR1200_ITAG_BE		4'hb	// Bus error exception
`define OR1200_ITAG_PE		4'hc	// Page fault exception
`define OR1200_ITAG_TE		4'hd	// TLB miss exception

//
// TAGs for data bus
//
`define OR1200_DTAG_IDLE	4'h0	// idle bus
`define	OR1200_DTAG_ND		4'h1	// normal data
`define OR1200_DTAG_AE		4'ha	// Alignment exception
`define OR1200_DTAG_BE		4'hb	// Bus error exception
`define OR1200_DTAG_PE		4'hc	// Page fault exception
`define OR1200_DTAG_TE		4'hd	// TLB miss exception


//////////////////////////////////////////////
//
// ORBIS32 ISA specifics
//

// SHROT_OP position in machine word
`define OR1200_SHROTOP_POS		7:6

//
// Instruction opcode groups (basic)
//
`define OR1200_OR32_J                 6'b000000
`define OR1200_OR32_JAL               6'b000001
`define OR1200_OR32_BNF               6'b000011
`define OR1200_OR32_BF                6'b000100
`define OR1200_OR32_NOP               6'b000101
`define OR1200_OR32_MOVHI             6'b000110
`define OR1200_OR32_XSYNC             6'b001000
`define OR1200_OR32_RFE               6'b001001
/* */
`define OR1200_OR32_JR                6'b010001
`define OR1200_OR32_JALR              6'b010010
`define OR1200_OR32_MACI              6'b010011
/* */
`define OR1200_OR32_LWZ               6'b100001
`define OR1200_OR32_LBZ               6'b100011
`define OR1200_OR32_LBS               6'b100100
`define OR1200_OR32_LHZ               6'b100101
`define OR1200_OR32_LHS               6'b100110
`define OR1200_OR32_ADDI              6'b100111
`define OR1200_OR32_ADDIC             6'b101000
`define OR1200_OR32_ANDI              6'b101001
`define OR1200_OR32_ORI               6'b101010
`define OR1200_OR32_XORI              6'b101011
`define OR1200_OR32_MULI              6'b101100
`define OR1200_OR32_MFSPR             6'b101101
`define OR1200_OR32_SH_ROTI 	      6'b101110
`define OR1200_OR32_SFXXI             6'b101111
/* */
`define OR1200_OR32_MTSPR             6'b110000
`define OR1200_OR32_MACMSB            6'b110001
`define OR1200_OR32_FLOAT             6'b110010
/* */
`define OR1200_OR32_SW                6'b110101
`define OR1200_OR32_SB                6'b110110
`define OR1200_OR32_SH                6'b110111
`define OR1200_OR32_ALU               6'b111000
`define OR1200_OR32_SFXX              6'b111001
//`define OR1200_OR32_CUST5             6'b111100


/////////////////////////////////////////////////////
//
// Exceptions
//

//
// Exception vectors per OR1K architecture:
// 0xPPPPP100 - reset
// 0xPPPPP200 - bus error
// ... etc
// where P represents exception prefix.
//
// Exception vectors can be customized as per
// the following formula:
// 0xPPPPPNVV - exception N
//
// P represents exception prefix
// N represents exception N
// VV represents length of the individual vector space,
//   usually it is 8 bits wide and starts with all bits zero
//

//
// PPPPP and VV parts
//
// Sum of these two defines needs to be 28
//
`define OR1200_EXCEPT_EPH0_P    20'h00000
`define OR1200_EXCEPT_EPH1_P    20'hF0000
`define OR1200_EXCEPT_V		    8'h00

//
// N part width
//
`define OR1200_EXCEPT_WIDTH 4

//
// Definition of exception vectors
//
// To avoid implementation of a certain exception,
// simply comment out corresponding line
//
`define OR1200_EXCEPT_UNUSED		`OR1200_EXCEPT_WIDTH'hf
`define OR1200_EXCEPT_TRAP		`OR1200_EXCEPT_WIDTH'he
`define OR1200_EXCEPT_FLOAT		`OR1200_EXCEPT_WIDTH'hd
`define OR1200_EXCEPT_SYSCALL		`OR1200_EXCEPT_WIDTH'hc
`define OR1200_EXCEPT_RANGE		`OR1200_EXCEPT_WIDTH'hb
`define OR1200_EXCEPT_ITLBMISS		`OR1200_EXCEPT_WIDTH'ha
`define OR1200_EXCEPT_DTLBMISS		`OR1200_EXCEPT_WIDTH'h9
`define OR1200_EXCEPT_INT		`OR1200_EXCEPT_WIDTH'h8
`define OR1200_EXCEPT_ILLEGAL		`OR1200_EXCEPT_WIDTH'h7
`define OR1200_EXCEPT_ALIGN		`OR1200_EXCEPT_WIDTH'h6
`define OR1200_EXCEPT_TICK		`OR1200_EXCEPT_WIDTH'h5
`define OR1200_EXCEPT_IPF		`OR1200_EXCEPT_WIDTH'h4
`define OR1200_EXCEPT_DPF		`OR1200_EXCEPT_WIDTH'h3
`define OR1200_EXCEPT_BUSERR		`OR1200_EXCEPT_WIDTH'h2
`define OR1200_EXCEPT_RESET		`OR1200_EXCEPT_WIDTH'h1
`define OR1200_EXCEPT_NONE		`OR1200_EXCEPT_WIDTH'h0


/////////////////////////////////////////////////////
//
// SPR groups
//

// Bits that define the group
`define OR1200_SPR_GROUP_BITS	15:11

// Width of the group bits
`define OR1200_SPR_GROUP_WIDTH 	5

// Bits that define offset inside the group
`define OR1200_SPR_OFS_BITS 10:0

// List of groups
`define OR1200_SPR_GROUP_SYS	5'd00
`define OR1200_SPR_GROUP_DMMU	5'd01
`define OR1200_SPR_GROUP_IMMU	5'd02
`define OR1200_SPR_GROUP_DC	5'd03
`define OR1200_SPR_GROUP_IC	5'd04
`define OR1200_SPR_GROUP_MAC	5'd05
`define OR1200_SPR_GROUP_DU	5'd06
`define OR1200_SPR_GROUP_PM	5'd08
`define OR1200_SPR_GROUP_PIC	5'd09
`define OR1200_SPR_GROUP_TT	5'd10
`define OR1200_SPR_GROUP_FPU    5'd11

/////////////////////////////////////////////////////
//
// System group
//

//
// System registers
//
`define OR1200_SPR_CFGR		7'd0
`define OR1200_SPR_RF		6'd32	// 1024 >> 5
`define OR1200_SPR_NPC		11'd16
`define OR1200_SPR_SR		11'd17
`define OR1200_SPR_PPC		11'd18
`define OR1200_SPR_FPCSR        11'd20
`define OR1200_SPR_EPCR		11'd32
`define OR1200_SPR_EEAR		11'd48
`define OR1200_SPR_ESR		11'd64

//
// SR bits
//
`define OR1200_SR_WIDTH 17
`define OR1200_SR_SM   0
`define OR1200_SR_TEE  1
`define OR1200_SR_IEE  2
`define OR1200_SR_DCE  3
`define OR1200_SR_ICE  4
`define OR1200_SR_DME  5
`define OR1200_SR_IME  6
`define OR1200_SR_LEE  7
`define OR1200_SR_CE   8
`define OR1200_SR_F    9
`define OR1200_SR_CY   10	// Unused
`define OR1200_SR_OV   11	// Unused
`define OR1200_SR_OVE  12	// Unused
`define OR1200_SR_DSX  13	// Unused
`define OR1200_SR_EPH  14
`define OR1200_SR_FO   15
`define OR1200_SR_TED  16
`define OR1200_SR_CID  31:28	// Unimplemented

//
// Bits that define offset inside the group
//
`define OR1200_SPROFS_BITS 10:0

//
// Default Exception Prefix
//
// 1'b0 - OR1200_EXCEPT_EPH0_P (0x0000_0000)
// 1'b1 - OR1200_EXCEPT_EPH1_P (0xF000_0000)
//
`define OR1200_SR_EPH_DEF	1'b0


//
// FPCSR bits
//
`define OR1200_FPCSR_WIDTH 12
`define OR1200_FPCSR_FPEE  0
`define OR1200_FPCSR_RM    2:1
`define OR1200_FPCSR_OVF   3
`define OR1200_FPCSR_UNF   4
`define OR1200_FPCSR_SNF   5
`define OR1200_FPCSR_QNF   6
`define OR1200_FPCSR_ZF    7
`define OR1200_FPCSR_IXF   8
`define OR1200_FPCSR_IVF   9
`define OR1200_FPCSR_INF   10
`define OR1200_FPCSR_DZF   11
`define OR1200_FPCSR_RES   31:12

/////////////////////////////////////////////////////
//
// Power Management (PM)
//

// Define it if you want PM implemented
//`define OR1200_PM_IMPLEMENTED

// Bit positions inside PMR (don't change)
`define OR1200_PM_PMR_SDF 3:0
`define OR1200_PM_PMR_DME 4
`define OR1200_PM_PMR_SME 5
`define OR1200_PM_PMR_DCGE 6
`define OR1200_PM_PMR_UNUSED 31:7

// PMR offset inside PM group of registers
`define OR1200_PM_OFS_PMR 11'b0

// PM group
`define OR1200_SPRGRP_PM 5'd8

// Define if PMR can be read/written at any address inside PM group
`define OR1200_PM_PARTIAL_DECODING

// Define if reading PMR is allowed
`define OR1200_PM_READREGS

// Define if unused PMR bits should be zero
`define OR1200_PM_UNUSED_ZERO


/////////////////////////////////////////////////////
//
// Debug Unit (DU)
//

// Define it if you want DU implemented
`define OR1200_DU_IMPLEMENTED

//
// Define if you want HW Breakpoints
// (if HW breakpoints are not implemented
// only default software trapping is
// possible with l.trap insn - this is
// however already enough for use
// with or32 gdb)
//
//`define OR1200_DU_HWBKPTS

// Number of DVR/DCR pairs if HW breakpoints enabled
//	Comment / uncomment DU_DVRn / DU_DCRn pairs bellow according to this number ! 
//	DU_DVR0..DU_DVR7 should be uncommented for 8 DU_DVRDCR_PAIRS 
`define OR1200_DU_DVRDCR_PAIRS 8

// Define if you want trace buffer
//	(for now only available for Xilinx Virtex FPGAs)
//`define OR1200_DU_TB_IMPLEMENTED


//
// Address offsets of DU registers inside DU group
//
// To not implement a register, doq not define its address
//
`ifdef OR1200_DU_HWBKPTS
`define OR1200_DU_DVR0		11'd0
`define OR1200_DU_DVR1		11'd1
`define OR1200_DU_DVR2		11'd2
`define OR1200_DU_DVR3		11'd3
`define OR1200_DU_DVR4		11'd4
`define OR1200_DU_DVR5		11'd5
`define OR1200_DU_DVR6		11'd6
`define OR1200_DU_DVR7		11'd7
`define OR1200_DU_DCR0		11'd8
`define OR1200_DU_DCR1		11'd9
`define OR1200_DU_DCR2		11'd10
`define OR1200_DU_DCR3		11'd11
`define OR1200_DU_DCR4		11'd12
`define OR1200_DU_DCR5		11'd13
`define OR1200_DU_DCR6		11'd14
`define OR1200_DU_DCR7		11'd15
`endif
`define OR1200_DU_DMR1		11'd16
`ifdef OR1200_DU_HWBKPTS
`define OR1200_DU_DMR2		11'd17
`define OR1200_DU_DWCR0		11'd18
`define OR1200_DU_DWCR1		11'd19
`endif
`define OR1200_DU_DSR		11'd20
`define OR1200_DU_DRR		11'd21
`ifdef OR1200_DU_TB_IMPLEMENTED
`define OR1200_DU_TBADR		11'h0ff
`define OR1200_DU_TBIA		11'h1??
`define OR1200_DU_TBIM		11'h2??
`define OR1200_DU_TBAR		11'h3??
`define OR1200_DU_TBTS		11'h4??
`endif

// Position of offset bits inside SPR address
`define OR1200_DUOFS_BITS	10:0

// DCR bits
`define OR1200_DU_DCR_DP	0
`define OR1200_DU_DCR_CC	3:1
`define OR1200_DU_DCR_SC	4
`define OR1200_DU_DCR_CT	7:5

// DMR1 bits
`define OR1200_DU_DMR1_CW0	1:0
`define OR1200_DU_DMR1_CW1	3:2
`define OR1200_DU_DMR1_CW2	5:4
`define OR1200_DU_DMR1_CW3	7:6
`define OR1200_DU_DMR1_CW4	9:8
`define OR1200_DU_DMR1_CW5	11:10
`define OR1200_DU_DMR1_CW6	13:12
`define OR1200_DU_DMR1_CW7	15:14
`define OR1200_DU_DMR1_CW8	17:16
`define OR1200_DU_DMR1_CW9	19:18
`define OR1200_DU_DMR1_CW10	21:20
`define OR1200_DU_DMR1_ST	22
`define OR1200_DU_DMR1_BT	23
`define OR1200_DU_DMR1_DXFW	24
`define OR1200_DU_DMR1_ETE	25

// DMR2 bits
`define OR1200_DU_DMR2_WCE0	0
`define OR1200_DU_DMR2_WCE1	1
`define OR1200_DU_DMR2_AWTC	12:2
`define OR1200_DU_DMR2_WGB	23:13

// DWCR bits
`define OR1200_DU_DWCR_COUNT	15:0
`define OR1200_DU_DWCR_MATCH	31:16

// DSR bits
`define OR1200_DU_DSR_WIDTH	14
`define OR1200_DU_DSR_RSTE	0
`define OR1200_DU_DSR_BUSEE	1
`define OR1200_DU_DSR_DPFE	2
`define OR1200_DU_DSR_IPFE	3
`define OR1200_DU_DSR_TTE	4
`define OR1200_DU_DSR_AE	5
`define OR1200_DU_DSR_IIE	6
`define OR1200_DU_DSR_IE	7
`define OR1200_DU_DSR_DME	8
`define OR1200_DU_DSR_IME	9
`define OR1200_DU_DSR_RE	10
`define OR1200_DU_DSR_SCE	11
`define OR1200_DU_DSR_FPE	12
`define OR1200_DU_DSR_TE	13

// DRR bits
`define OR1200_DU_DRR_RSTE	0
`define OR1200_DU_DRR_BUSEE	1
`define OR1200_DU_DRR_DPFE	2
`define OR1200_DU_DRR_IPFE	3
`define OR1200_DU_DRR_TTE	4
`define OR1200_DU_DRR_AE	5
`define OR1200_DU_DRR_IIE	6
`define OR1200_DU_DRR_IE	7
`define OR1200_DU_DRR_DME	8
`define OR1200_DU_DRR_IME	9
`define OR1200_DU_DRR_RE	10
`define OR1200_DU_DRR_SCE	11
`define OR1200_DU_DRR_FPE	12
`define OR1200_DU_DRR_TE	13

// Define if reading DU regs is allowed
`define OR1200_DU_READREGS

// Define if unused DU registers bits should be zero
`define OR1200_DU_UNUSED_ZERO

// Define if IF/LSU status is not needed by devel i/f
`define OR1200_DU_STATUS_UNIMPLEMENTED

/////////////////////////////////////////////////////
//
// Programmable Interrupt Controller (PIC)
//

// Define it if you want PIC implemented
`define OR1200_PIC_IMPLEMENTED

// Define number of interrupt inputs (2-31)
`define OR1200_PIC_INTS 31

// Address offsets of PIC registers inside PIC group
`define OR1200_PIC_OFS_PICMR 2'd0
`define OR1200_PIC_OFS_PICSR 2'd2

// Position of offset bits inside SPR address
`define OR1200_PICOFS_BITS 1:0

// Define if you want these PIC registers to be implemented
`define OR1200_PIC_PICMR
`define OR1200_PIC_PICSR

// Define if reading PIC registers is allowed
`define OR1200_PIC_READREGS

// Define if unused PIC register bits should be zero
`define OR1200_PIC_UNUSED_ZERO


/////////////////////////////////////////////////////
//
// Tick Timer (TT)
//

// Define it if you want TT implemented
`define OR1200_TT_IMPLEMENTED

// Address offsets of TT registers inside TT group
`define OR1200_TT_OFS_TTMR 1'd0
`define OR1200_TT_OFS_TTCR 1'd1

// Position of offset bits inside SPR group
`define OR1200_TTOFS_BITS 0

// Define if you want these TT registers to be implemented
`define OR1200_TT_TTMR
`define OR1200_TT_TTCR

// TTMR bits
`define OR1200_TT_TTMR_TP 27:0
`define OR1200_TT_TTMR_IP 28
`define OR1200_TT_TTMR_IE 29
`define OR1200_TT_TTMR_M 31:30

// Define if reading TT registers is allowed
`define OR1200_TT_READREGS


//////////////////////////////////////////////
//
// MAC
//
`define OR1200_MAC_ADDR		0	// MACLO 0xxxxxxxx1, MACHI 0xxxxxxxx0
`define OR1200_MAC_SPR_WE		// Define if MACLO/MACHI are SPR writable

//
// Shift {MACHI,MACLO} into destination register when executing l.macrc
//
// According to architecture manual there is no shift, so default value is 0.
// However the implementation has deviated in this from the arch manual and had
// hard coded shift by 28 bits which is a useful optimization for MP3 decoding 
// (if using libmad fixed point library). Shifts are no longer default setup, 
// but if you need to remain backward compatible, define your shift bits, which
// were normally
// dest_GPR = {MACHI,MACLO}[59:28]
`define OR1200_MAC_SHIFTBY	0	// 0 = According to arch manual, 28 = obsolete backward compatibility


//////////////////////////////////////////////
//
// Data MMU (DMMU)
//

//
// Address that selects between TLB TR and MR
//
`define OR1200_DTLB_TM_ADDR	7

//
// DTLBMR fields
//
`define	OR1200_DTLBMR_V_BITS	0
`define	OR1200_DTLBMR_CID_BITS	4:1
`define	OR1200_DTLBMR_RES_BITS	11:5
`define OR1200_DTLBMR_VPN_BITS	31:13

//
// DTLBTR fields
//
`define	OR1200_DTLBTR_CC_BITS	0
`define	OR1200_DTLBTR_CI_BITS	1
`define	OR1200_DTLBTR_WBC_BITS	2
`define	OR1200_DTLBTR_WOM_BITS	3
`define	OR1200_DTLBTR_A_BITS	4
`define	OR1200_DTLBTR_D_BITS	5
`define	OR1200_DTLBTR_URE_BITS	6
`define	OR1200_DTLBTR_UWE_BITS	7
`define	OR1200_DTLBTR_SRE_BITS	8
`define	OR1200_DTLBTR_SWE_BITS	9
`define	OR1200_DTLBTR_RES_BITS	11:10
`define OR1200_DTLBTR_PPN_BITS	31:13

//
// DTLB configuration
//
`define	OR1200_DMMU_PS		13					// 13 for 8KB page size
`define	OR1200_DTLB_INDXW	6					// 6 for 64 entry DTLB	7 for 128 entries
`define OR1200_DTLB_INDXL	`OR1200_DMMU_PS				// 13			13
`define OR1200_DTLB_INDXH	`OR1200_DMMU_PS+`OR1200_DTLB_INDXW-1	// 18			19
`define	OR1200_DTLB_INDX	`OR1200_DTLB_INDXH:`OR1200_DTLB_INDXL	// 18:13		19:13
`define OR1200_DTLB_TAGW	32-`OR1200_DTLB_INDXW-`OR1200_DMMU_PS	// 13			12
`define OR1200_DTLB_TAGL	`OR1200_DTLB_INDXH+1			// 19			20
`define	OR1200_DTLB_TAG		31:`OR1200_DTLB_TAGL			// 31:19		31:20
`define	OR1200_DTLBMRW		`OR1200_DTLB_TAGW+1			// +1 because of V bit
`define	OR1200_DTLBTRW		32-`OR1200_DMMU_PS+5			// +5 because of protection bits and CI

//
// Cache inhibit while DMMU is not enabled/implemented
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!dcpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!dcpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	dcpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	dcpu_adr_i[31]
// cached 0GB-4GB			1'b0
//
`define OR1200_DMMU_CI			dcpu_adr_i[31]


//////////////////////////////////////////////
//
// Insn MMU (IMMU)
//

//
// Address that selects between TLB TR and MR
//
`define OR1200_ITLB_TM_ADDR	7

//
// ITLBMR fields
//
`define	OR1200_ITLBMR_V_BITS	0
`define	OR1200_ITLBMR_CID_BITS	4:1
`define	OR1200_ITLBMR_RES_BITS	11:5
`define OR1200_ITLBMR_VPN_BITS	31:13

//
// ITLBTR fields
//
`define	OR1200_ITLBTR_CC_BITS	0
`define	OR1200_ITLBTR_CI_BITS	1
`define	OR1200_ITLBTR_WBC_BITS	2
`define	OR1200_ITLBTR_WOM_BITS	3
`define	OR1200_ITLBTR_A_BITS	4
`define	OR1200_ITLBTR_D_BITS	5
`define	OR1200_ITLBTR_SXE_BITS	6
`define	OR1200_ITLBTR_UXE_BITS	7
`define	OR1200_ITLBTR_RES_BITS	11:8
`define OR1200_ITLBTR_PPN_BITS	31:13

//
// ITLB configuration
//
`define	OR1200_IMMU_PS		13					// 13 for 8KB page size
`define	OR1200_ITLB_INDXW	6					// 6 for 64 entry ITLB	7 for 128 entries
`define OR1200_ITLB_INDXL	`OR1200_IMMU_PS				// 13			13
`define OR1200_ITLB_INDXH	`OR1200_IMMU_PS+`OR1200_ITLB_INDXW-1	// 18			19
`define	OR1200_ITLB_INDX	`OR1200_ITLB_INDXH:`OR1200_ITLB_INDXL	// 18:13		19:13
`define OR1200_ITLB_TAGW	32-`OR1200_ITLB_INDXW-`OR1200_IMMU_PS	// 13			12
`define OR1200_ITLB_TAGL	`OR1200_ITLB_INDXH+1			// 19			20
`define	OR1200_ITLB_TAG		31:`OR1200_ITLB_TAGL			// 31:19		31:20
`define	OR1200_ITLBMRW		`OR1200_ITLB_TAGW+1			// +1 because of V bit
`define	OR1200_ITLBTRW		32-`OR1200_IMMU_PS+3			// +3 because of protection bits and CI

//
// Cache inhibit while IMMU is not enabled/implemented
// Note: all combinations that use icpu_adr_i cause async loop
//
// cache inhibited 0GB-4GB		1'b1
// cache inhibited 0GB-2GB		!icpu_adr_i[31]
// cache inhibited 0GB-1GB 2GB-3GB	!icpu_adr_i[30]
// cache inhibited 1GB-2GB 3GB-4GB	icpu_adr_i[30]
// cache inhibited 2GB-4GB (default)	icpu_adr_i[31]
// cached 0GB-4GB			1'b0
//
`define OR1200_IMMU_CI			1'b0


/////////////////////////////////////////////////
//
// Insn cache (IC)
//

// 3 for 8 bytes, 4 for 16 bytes etc
`define OR1200_ICLS		4

//
// IC configurations
//
`ifdef OR1200_IC_1W_512B
`define OR1200_ICSIZE   9     // 512
`define OR1200_ICINDX   `OR1200_ICSIZE-2 // 7
`define OR1200_ICINDXH  `OR1200_ICSIZE-1 // 8
`define OR1200_ICTAGL   `OR1200_ICINDXH+1 // 9
`define OR1200_ICTAG    `OR1200_ICSIZE-`OR1200_ICLS // 5
`define OR1200_ICTAG_W  24
`endif
`ifdef OR1200_IC_1W_4KB
`define OR1200_ICSIZE			12			// 4096
`define OR1200_ICINDX			`OR1200_ICSIZE-2	// 10
`define OR1200_ICINDXH			`OR1200_ICSIZE-1	// 11
`define OR1200_ICTAGL			`OR1200_ICINDXH+1	// 12
`define	OR1200_ICTAG			`OR1200_ICSIZE-`OR1200_ICLS	// 8
`define	OR1200_ICTAG_W			21
`endif
`ifdef OR1200_IC_1W_8KB
`define OR1200_ICSIZE			13			// 8192
`define OR1200_ICINDX			`OR1200_ICSIZE-2	// 11
`define OR1200_ICINDXH			`OR1200_ICSIZE-1	// 12
`define OR1200_ICTAGL			`OR1200_ICINDXH+1	// 13
`define	OR1200_ICTAG			`OR1200_ICSIZE-`OR1200_ICLS	// 9
`define	OR1200_ICTAG_W			20
`endif


/////////////////////////////////////////////////
//
// Data cache (DC)
//

// 3 for 8 bytes, 4 for 16 bytes etc
`define OR1200_DCLS		4

// Define to enable default behavior of cache as write through
// Turning this off enabled write back statergy
//
`define OR1200_DC_WRITETHROUGH

// Define to enable stores from the stack not doing writethrough.
// EXPERIMENTAL
//`define OR1200_DC_NOSTACKWRITETHROUGH

// Data cache SPR definitions
`define OR1200_SPRGRP_DC_ADR_WIDTH 3
// Data cache group SPR addresses
`define OR1200_SPRGRP_DC_DCCR		3'd0 // Not implemented
`define OR1200_SPRGRP_DC_DCBPR		3'd1 // Not implemented
`define OR1200_SPRGRP_DC_DCBFR		3'd2
`define OR1200_SPRGRP_DC_DCBIR		3'd3
`define OR1200_SPRGRP_DC_DCBWR		3'd4 // Not implemented
`define OR1200_SPRGRP_DC_DCBLR		3'd5 // Not implemented

//
// DC configurations
//
`ifdef OR1200_DC_1W_4KB
`define OR1200_DCSIZE			12			// 4096
`define OR1200_DCINDX			`OR1200_DCSIZE-2	// 10
`define OR1200_DCINDXH			`OR1200_DCSIZE-1	// 11
`define OR1200_DCTAGL			`OR1200_DCINDXH+1	// 12
`define	OR1200_DCTAG			`OR1200_DCSIZE-`OR1200_DCLS	// 8
`define	OR1200_DCTAG_W			21
`endif
`ifdef OR1200_DC_1W_8KB
`define OR1200_DCSIZE			13			// 8192
`define OR1200_DCINDX			`OR1200_DCSIZE-2	// 11
`define OR1200_DCINDXH			`OR1200_DCSIZE-1	// 12
`define OR1200_DCTAGL			`OR1200_DCINDXH+1	// 13
`define	OR1200_DCTAG			`OR1200_DCSIZE-`OR1200_DCLS	// 9
`define	OR1200_DCTAG_W			20
`endif


/////////////////////////////////////////////////
//
// Store buffer (SB)
//

//
// Store buffer
//
// It will improve performance by "caching" CPU stores
// using store buffer. This is most important for function
// prologues because DC can only work in write though mode
// and all stores would have to complete external WB writes
// to memory.
// Store buffer is between DC and data BIU.
// All stores will be stored into store buffer and immediately
// completed by the CPU, even though actual external writes
// will be performed later. As a consequence store buffer masks
// all data bus errors related to stores (data bus errors
// related to loads are delivered normally).
// All pending CPU loads will wait until store buffer is empty to
// ensure strict memory model. Right now this is necessary because
// we don't make destinction between cached and cache inhibited
// address space, so we simply empty store buffer until loads
// can begin.
//
// It makes design a bit bigger, depending what is the number of
// entries in SB FIFO. Number of entries can be changed further
// down.
//
//`define OR1200_SB_IMPLEMENTED

//
// Number of store buffer entries
//
// Verified number of entries are 4 and 8 entries
// (2 and 3 for OR1200_SB_LOG). OR1200_SB_ENTRIES must
// always match 2**OR1200_SB_LOG.
// To disable store buffer, undefine
// OR1200_SB_IMPLEMENTED.
//
`define OR1200_SB_LOG		2	// 2 or 3
`define OR1200_SB_ENTRIES	4	// 4 or 8


/////////////////////////////////////////////////
//
// Quick Embedded Memory (QMEM)
//

//
// Quick Embedded Memory
//
// Instantiation of dedicated insn/data memory (RAM or ROM).
// Insn fetch has effective throughput 1insn / clock cycle.
// Data load takes two clock cycles / access, data store
// takes 1 clock cycle / access (if there is no insn fetch)).
// Memory instantiation is shared between insn and data,
// meaning if insn fetch are performed, data load/store
// performance will be lower.
//
// Main reason for QMEM is to put some time critical functions
// into this memory and to have predictable and fast access
// to these functions. (soft fpu, context switch, exception
// handlers, stack, etc)
//
// It makes design a bit bigger and slower. QMEM sits behind
// IMMU/DMMU so all addresses are physical (so the MMUs can be
// used with QMEM and QMEM is seen by the CPU just like any other
// memory in the system). IC/DC are sitting behind QMEM so the
// whole design timing might be worse with QMEM implemented.
//
//`define OR1200_QMEM_IMPLEMENTED

//
// Base address and mask of QMEM
//
// Base address defines first address of QMEM. Mask defines
// QMEM range in address space. Actual size of QMEM is however
// determined with instantiated RAM/ROM. However bigger
// mask will reserve more address space for QMEM, but also
// make design faster, while more tight mask will take
// less address space but also make design slower. If
// instantiated RAM/ROM is smaller than space reserved with
// the mask, instatiated RAM/ROM will also be shadowed
// at higher addresses in reserved space.
//
`define OR1200_QMEM_IADDR	32'h0080_0000
`define OR1200_QMEM_IMASK	32'hfff0_0000 // Max QMEM size 1MB
`define OR1200_QMEM_DADDR	32'h0080_0000
`define OR1200_QMEM_DMASK	32'hfff0_0000 // Max QMEM size 1MB

//
// QMEM interface byte-select capability
//
// To enable qmem_sel* ports, define this macro.
//
//`define OR1200_QMEM_BSEL

//
// QMEM interface acknowledge
//
// To enable qmem_ack port, define this macro.
//
//`define OR1200_QMEM_ACK

/////////////////////////////////////////////////////
//
// VR, UPR and Configuration Registers
//
//
// VR, UPR and configuration registers are optional. If 
// implemented, operating system can automatically figure
// out how to use the processor because it knows 
// what units are available in the processor and how they
// are configured.
//
// This section must be last in or1200_defines.v file so
// that all units are already configured and thus
// configuration registers are properly set.
// 

// Define if you want configuration registers implemented
`define OR1200_CFGR_IMPLEMENTED

// Define if you want full address decode inside SYS group
`define OR1200_SYS_FULL_DECODE

// Offsets of VR, UPR and CFGR registers
`define OR1200_SPRGRP_SYS_VR		4'h0
`define OR1200_SPRGRP_SYS_UPR		4'h1
`define OR1200_SPRGRP_SYS_CPUCFGR	4'h2
`define OR1200_SPRGRP_SYS_DMMUCFGR	4'h3
`define OR1200_SPRGRP_SYS_IMMUCFGR	4'h4
`define OR1200_SPRGRP_SYS_DCCFGR	4'h5
`define OR1200_SPRGRP_SYS_ICCFGR	4'h6
`define OR1200_SPRGRP_SYS_DCFGR	4'h7

// VR fields
`define OR1200_VR_REV_BITS		5:0
`define OR1200_VR_RES1_BITS		15:6
`define OR1200_VR_CFG_BITS		23:16
`define OR1200_VR_VER_BITS		31:24

// VR values
`define OR1200_VR_REV			6'h08
`define OR1200_VR_RES1			10'h000
`define OR1200_VR_CFG			8'h00
`define OR1200_VR_VER			8'h12

// UPR fields
`define OR1200_UPR_UP_BITS		0
`define OR1200_UPR_DCP_BITS		1
`define OR1200_UPR_ICP_BITS		2
`define OR1200_UPR_DMP_BITS		3
`define OR1200_UPR_IMP_BITS		4
`define OR1200_UPR_MP_BITS		5
`define OR1200_UPR_DUP_BITS		6
`define OR1200_UPR_PCUP_BITS		7
`define OR1200_UPR_PMP_BITS		8
`define OR1200_UPR_PICP_BITS		9
`define OR1200_UPR_TTP_BITS		10
`define OR1200_UPR_FPP_BITS		11
`define OR1200_UPR_RES1_BITS		23:12
`define OR1200_UPR_CUP_BITS		31:24

// UPR values
`define OR1200_UPR_UP			1'b1
`ifdef OR1200_NO_DC
`define OR1200_UPR_DCP			1'b0
`else
`define OR1200_UPR_DCP			1'b1
`endif
`ifdef OR1200_NO_IC
`define OR1200_UPR_ICP			1'b0
`else
`define OR1200_UPR_ICP			1'b1
`endif
`ifdef OR1200_NO_DMMU
`define OR1200_UPR_DMP			1'b0
`else
`define OR1200_UPR_DMP			1'b1
`endif
`ifdef OR1200_NO_IMMU
`define OR1200_UPR_IMP			1'b0
`else
`define OR1200_UPR_IMP			1'b1
`endif
`ifdef OR1200_MAC_IMPLEMENTED
`define OR1200_UPR_MP			1'b1
`else
`define OR1200_UPR_MP			1'b0
`endif
`ifdef OR1200_DU_IMPLEMENTED
`define OR1200_UPR_DUP			1'b1
`else
`define OR1200_UPR_DUP			1'b0
`endif
`define OR1200_UPR_PCUP			1'b0	// Performance counters not present
`ifdef OR1200_PM_IMPLEMENTED
`define OR1200_UPR_PMP			1'b1
`else
`define OR1200_UPR_PMP			1'b0
`endif
`ifdef OR1200_PIC_IMPLEMENTED
`define OR1200_UPR_PICP			1'b1
`else
`define OR1200_UPR_PICP			1'b0
`endif
`ifdef OR1200_TT_IMPLEMENTED
`define OR1200_UPR_TTP			1'b1
`else
`define OR1200_UPR_TTP			1'b0
`endif
`ifdef OR1200_FPU_IMPLEMENTED
`define OR1200_UPR_FPP			1'b1
`else
`define OR1200_UPR_FPP			1'b0
`endif
`define OR1200_UPR_RES1			12'h000
`define OR1200_UPR_CUP			8'h00

// CPUCFGR fields
`define OR1200_CPUCFGR_NSGF_BITS	3:0
`define OR1200_CPUCFGR_HGF_BITS     4
`define OR1200_CPUCFGR_OB32S_BITS	5
`define OR1200_CPUCFGR_OB64S_BITS	6
`define OR1200_CPUCFGR_OF32S_BITS	7
`define OR1200_CPUCFGR_OF64S_BITS	8
`define OR1200_CPUCFGR_OV64S_BITS	9
`define OR1200_CPUCFGR_RES1_BITS	31:10

// CPUCFGR values
`define OR1200_CPUCFGR_NSGF		    4'h0
`ifdef OR1200_RFRAM_16REG
    `define OR1200_CPUCFGR_HGF  		1'b1
`else
    `define OR1200_CPUCFGR_HGF  		1'b0
`endif
`define OR1200_CPUCFGR_OB32S		1'b1
`define OR1200_CPUCFGR_OB64S		1'b0
`ifdef OR1200_FPU_IMPLEMENTED
 `define OR1200_CPUCFGR_OF32S		1'b1
`else
 `define OR1200_CPUCFGR_OF32S		1'b0
`endif

`define OR1200_CPUCFGR_OF64S		1'b0
`define OR1200_CPUCFGR_OV64S		1'b0
`define OR1200_CPUCFGR_RES1		22'h000000

// DMMUCFGR fields
`define OR1200_DMMUCFGR_NTW_BITS	1:0
`define OR1200_DMMUCFGR_NTS_BITS	4:2
`define OR1200_DMMUCFGR_NAE_BITS	7:5
`define OR1200_DMMUCFGR_CRI_BITS	8
`define OR1200_DMMUCFGR_PRI_BITS	9
`define OR1200_DMMUCFGR_TEIRI_BITS	10
`define OR1200_DMMUCFGR_HTR_BITS	11
`define OR1200_DMMUCFGR_RES1_BITS	31:12

// DMMUCFGR values
`ifdef OR1200_NO_DMMU
`define OR1200_DMMUCFGR_NTW		2'h0	// Irrelevant
`define OR1200_DMMUCFGR_NTS		3'h0	// Irrelevant
`define OR1200_DMMUCFGR_NAE		3'h0	// Irrelevant
`define OR1200_DMMUCFGR_CRI		1'b0	// Irrelevant
`define OR1200_DMMUCFGR_PRI		1'b0	// Irrelevant
`define OR1200_DMMUCFGR_TEIRI		1'b0	// Irrelevant
`define OR1200_DMMUCFGR_HTR		1'b0	// Irrelevant
`define OR1200_DMMUCFGR_RES1		20'h00000
`else
`define OR1200_DMMUCFGR_NTW		2'h0	// 1 TLB way
`define OR1200_DMMUCFGR_NTS 3'h`OR1200_DTLB_INDXW	// Num TLB sets
`define OR1200_DMMUCFGR_NAE		3'h0	// No ATB entries
`define OR1200_DMMUCFGR_CRI		1'b0	// No control register
`define OR1200_DMMUCFGR_PRI		1'b0	// No protection reg
`define OR1200_DMMUCFGR_TEIRI		1'b1	// TLB entry inv reg impl.
`define OR1200_DMMUCFGR_HTR		1'b0	// No HW TLB reload
`define OR1200_DMMUCFGR_RES1		20'h00000
`endif

// IMMUCFGR fields
`define OR1200_IMMUCFGR_NTW_BITS	1:0
`define OR1200_IMMUCFGR_NTS_BITS	4:2
`define OR1200_IMMUCFGR_NAE_BITS	7:5
`define OR1200_IMMUCFGR_CRI_BITS	8
`define OR1200_IMMUCFGR_PRI_BITS	9
`define OR1200_IMMUCFGR_TEIRI_BITS	10
`define OR1200_IMMUCFGR_HTR_BITS	11
`define OR1200_IMMUCFGR_RES1_BITS	31:12

// IMMUCFGR values
`ifdef OR1200_NO_IMMU
`define OR1200_IMMUCFGR_NTW		2'h0	// Irrelevant
`define OR1200_IMMUCFGR_NTS		3'h0	// Irrelevant
`define OR1200_IMMUCFGR_NAE		3'h0	// Irrelevant
`define OR1200_IMMUCFGR_CRI		1'b0	// Irrelevant
`define OR1200_IMMUCFGR_PRI		1'b0	// Irrelevant
`define OR1200_IMMUCFGR_TEIRI		1'b0	// Irrelevant
`define OR1200_IMMUCFGR_HTR		1'b0	// Irrelevant
`define OR1200_IMMUCFGR_RES1		20'h00000
`else
`define OR1200_IMMUCFGR_NTW		2'h0	// 1 TLB way
`define OR1200_IMMUCFGR_NTS 3'h`OR1200_ITLB_INDXW	// Num TLB sets
`define OR1200_IMMUCFGR_NAE		3'h0	// No ATB entry
`define OR1200_IMMUCFGR_CRI		1'b0	// No control reg
`define OR1200_IMMUCFGR_PRI		1'b0	// No protection reg
`define OR1200_IMMUCFGR_TEIRI		1'b1	// TLB entry inv reg impl
`define OR1200_IMMUCFGR_HTR		1'b0	// No HW TLB reload
`define OR1200_IMMUCFGR_RES1		20'h00000
`endif

// DCCFGR fields
`define OR1200_DCCFGR_NCW_BITS		2:0
`define OR1200_DCCFGR_NCS_BITS		6:3
`define OR1200_DCCFGR_CBS_BITS		7
`define OR1200_DCCFGR_CWS_BITS		8
`define OR1200_DCCFGR_CCRI_BITS		9
`define OR1200_DCCFGR_CBIRI_BITS	10
`define OR1200_DCCFGR_CBPRI_BITS	11
`define OR1200_DCCFGR_CBLRI_BITS	12
`define OR1200_DCCFGR_CBFRI_BITS	13
`define OR1200_DCCFGR_CBWBRI_BITS	14
`define OR1200_DCCFGR_RES1_BITS	31:15

// DCCFGR values
`ifdef OR1200_NO_DC
`define OR1200_DCCFGR_NCW		3'h0	// Irrelevant
`define OR1200_DCCFGR_NCS		4'h0	// Irrelevant
`define OR1200_DCCFGR_CBS		1'b0	// Irrelevant
`define OR1200_DCCFGR_CWS		1'b0	// Irrelevant
`define OR1200_DCCFGR_CCRI		1'b0	// Irrelevant
`define OR1200_DCCFGR_CBIRI		1'b0	// Irrelevant
`define OR1200_DCCFGR_CBPRI		1'b0	// Irrelevant
`define OR1200_DCCFGR_CBLRI		1'b0	// Irrelevant
`define OR1200_DCCFGR_CBFRI		1'b0	// Irrelevant
`define OR1200_DCCFGR_CBWBRI		1'b0	// Irrelevant
`define OR1200_DCCFGR_RES1		17'h00000
`else
`define OR1200_DCCFGR_NCW		3'h0	// 1 cache way
`define OR1200_DCCFGR_NCS (`OR1200_DCTAG)	// Num cache sets
`define OR1200_DCCFGR_CBS `OR1200_DCLS==4 ? 1'b0 : 1'b1 // 16 byte cache block
`ifdef OR1200_DC_WRITETHROUGH
 `define OR1200_DCCFGR_CWS		1'b0	// Write-through strategy
`else
 `define OR1200_DCCFGR_CWS		1'b1	// Write-back strategy
`endif
`define OR1200_DCCFGR_CCRI		1'b1	// Cache control reg impl.
`define OR1200_DCCFGR_CBIRI		1'b1	// Cache block inv reg impl.
`define OR1200_DCCFGR_CBPRI		1'b0	// Cache block prefetch reg not impl.
`define OR1200_DCCFGR_CBLRI		1'b0	// Cache block lock reg not impl.
`define OR1200_DCCFGR_CBFRI		1'b1	// Cache block flush reg impl.
`ifdef OR1200_DC_WRITETHROUGH
 `define OR1200_DCCFGR_CBWBRI		1'b0	// Cache block WB reg not impl.
`else
 `define OR1200_DCCFGR_CBWBRI		1'b1	// Cache block WB reg impl.
`endif
`define OR1200_DCCFGR_RES1		17'h00000
`endif

// ICCFGR fields
`define OR1200_ICCFGR_NCW_BITS		2:0
`define OR1200_ICCFGR_NCS_BITS		6:3
`define OR1200_ICCFGR_CBS_BITS		7
`define OR1200_ICCFGR_CWS_BITS		8
`define OR1200_ICCFGR_CCRI_BITS		9
`define OR1200_ICCFGR_CBIRI_BITS	10
`define OR1200_ICCFGR_CBPRI_BITS	11
`define OR1200_ICCFGR_CBLRI_BITS	12
`define OR1200_ICCFGR_CBFRI_BITS	13
`define OR1200_ICCFGR_CBWBRI_BITS	14
`define OR1200_ICCFGR_RES1_BITS	31:15

// ICCFGR values
`ifdef OR1200_NO_IC
`define OR1200_ICCFGR_NCW		3'h0	// Irrelevant
`define OR1200_ICCFGR_NCS 		4'h0	// Irrelevant
`define OR1200_ICCFGR_CBS 		1'b0	// Irrelevant
`define OR1200_ICCFGR_CWS		1'b0	// Irrelevant
`define OR1200_ICCFGR_CCRI		1'b0	// Irrelevant
`define OR1200_ICCFGR_CBIRI		1'b0	// Irrelevant
`define OR1200_ICCFGR_CBPRI		1'b0	// Irrelevant
`define OR1200_ICCFGR_CBLRI		1'b0	// Irrelevant
`define OR1200_ICCFGR_CBFRI		1'b0	// Irrelevant
`define OR1200_ICCFGR_CBWBRI		1'b0	// Irrelevant
`define OR1200_ICCFGR_RES1		17'h00000
`else
`define OR1200_ICCFGR_NCW		3'h0	// 1 cache way
`define OR1200_ICCFGR_NCS (`OR1200_ICTAG)	// Num cache sets
`define OR1200_ICCFGR_CBS `OR1200_ICLS==4 ? 1'b0: 1'b1	// 16 byte cache block
`define OR1200_ICCFGR_CWS		1'b0	// Irrelevant
`define OR1200_ICCFGR_CCRI		1'b1	// Cache control reg impl.
`define OR1200_ICCFGR_CBIRI		1'b1	// Cache block inv reg impl.
`define OR1200_ICCFGR_CBPRI		1'b0	// Cache block prefetch reg not impl.
`define OR1200_ICCFGR_CBLRI		1'b0	// Cache block lock reg not impl.
`define OR1200_ICCFGR_CBFRI		1'b1	// Cache block flush reg impl.
`define OR1200_ICCFGR_CBWBRI		1'b0	// Irrelevant
`define OR1200_ICCFGR_RES1		17'h00000
`endif

// DCFGR fields
`define OR1200_DCFGR_NDP_BITS		3:0
`define OR1200_DCFGR_WPCI_BITS		4
`define OR1200_DCFGR_RES1_BITS		31:5

// DCFGR values
`ifdef OR1200_DU_HWBKPTS
`define OR1200_DCFGR_NDP		4'h`OR1200_DU_DVRDCR_PAIRS // # of DVR/DCR pairs
`ifdef OR1200_DU_DWCR0
`define OR1200_DCFGR_WPCI		1'b1
`else
`define OR1200_DCFGR_WPCI		1'b0	// WP counters not impl.
`endif
`else
`define OR1200_DCFGR_NDP		4'h0	// Zero DVR/DCR pairs
`define OR1200_DCFGR_WPCI		1'b0	// WP counters not impl.
`endif
`define OR1200_DCFGR_RES1		27'd0

///////////////////////////////////////////////////////////////////////////////
// Boot Address Selection                                                    //
// This only changes where the initial reset occurs. EPH setting is still    //
// used to determine where vectors are located.                              //
///////////////////////////////////////////////////////////////////////////////
 // Boot from 0xf0000100
//`define OR1200_BOOT_PCREG_DEFAULT 30'h3c00003f
//`define OR1200_BOOT_ADR 32'hf0000100
// Boot from 0x100
 `define OR1200_BOOT_PCREG_DEFAULT 30'h0000003f
 `define OR1200_BOOT_ADR 32'h00000100


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's ALU                                                ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  ALU                                                         ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_alu.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, flags are corrected. 

// synopsys translate_off
// synopsys translate_on

module or1200_alu(
	a, b, mult_mac_result, macrc_op,
	alu_op, alu_op2, shrot_op, comp_op,
	cust5_op, cust5_limm,
	result, flagforw, flag_we,
	cyforw, cy_we, carry, flag
);

parameter width = `OR1200_OPERAND_WIDTH;

//
// I/O
//
input	[width-1:0]		a;
input	[width-1:0]		b;
input	[width-1:0]		mult_mac_result;
input				macrc_op;
input	[`OR1200_ALUOP_WIDTH-1:0]	alu_op;
input	[`OR1200_ALUOP2_WIDTH-1:0]	alu_op2;
input	[`OR1200_SHROTOP_WIDTH-1:0]	shrot_op;
input	[`OR1200_COMPOP_WIDTH-1:0]	comp_op;
input	[4:0]			cust5_op;
input	[5:0]			cust5_limm;
output	[width-1:0]		result;
output				flagforw;
output				flag_we;
output				cyforw;
output				cy_we;
input				carry;
input         flag;

//
// Internal wires and regs
//
reg	[width-1:0]		result;
reg	[width-1:0]		shifted_rotated;
reg	[width-1:0]		result_cust5;
reg				flagforw;
reg				flagcomp;
reg				flag_we;
reg				cy_we;
wire	[width-1:0]		comp_a;
wire	[width-1:0]		comp_b;
`ifdef OR1200_IMPL_ALU_COMP1
wire				a_eq_b;
wire				a_lt_b;
`endif
wire	[width-1:0]		result_sum;
`ifdef OR1200_IMPL_ADDC
wire	[width-1:0]		result_csum;
wire				cy_csum;
`endif
wire	[width-1:0]		result_and;
wire				cy_sum;
`ifdef OR1200_IMPL_SUB
wire				cy_sub;
`endif
reg				cyforw;

//
// Combinatorial logic
//
assign comp_a = {a[width-1] ^ comp_op[3] , a[width-2:0]};
assign comp_b = {b[width-1] ^ comp_op[3] , b[width-2:0]};
`ifdef OR1200_IMPL_ALU_COMP1
assign a_eq_b = (comp_a == comp_b);
assign a_lt_b = (comp_a < comp_b);
`endif
`ifdef OR1200_IMPL_SUB
assign cy_sub = a < b;
`endif
assign {cy_sum, result_sum} = a + b;
`ifdef OR1200_IMPL_ADDC
assign {cy_csum, result_csum} = a + b + {`OR1200_OPERAND_WIDTH'd0, carry};
`endif
assign result_and = a & b;

//
// Simulation check for bad ALU behavior
//
`ifdef OR1200_WARNINGS
// synopsys translate_off
always @(result) begin
	if (result === 32'bx)
		$display("%t: WARNING: 32'bx detected on ALU result bus. Please check !", $time);
end
// synopsys translate_on
`endif

//
// Central part of the ALU
//
always @(alu_op or alu_op2 or a or b or result_sum or result_and or macrc_op
	 or shifted_rotated or mult_mac_result or flag or result_cust5 or carry
`ifdef OR1200_IMPL_ADDC
         or result_csum
`endif
) begin
`ifdef OR1200_CASE_DEFAULT
	casez (alu_op)		// synopsys parallel_case
`else
	casez (alu_op)		// synopsys full_case parallel_case
`endif
`ifdef OR1200_IMPL_ALU_FFL1	  
		`OR1200_ALUOP_FFL1: begin
`ifdef OR1200_CASE_DEFAULT
		   casez (alu_op2) // synopsys parallel_case
`else
		   casez (alu_op2) // synopsys full_case parallel_case
`endif
		     0: begin // FF1
			result = a[0] ? 1 : a[1] ? 2 : a[2] ? 3 : a[3] ? 4 : a[4] ? 5 : a[5] ? 6 : a[6] ? 7 : a[7] ? 8 : a[8] ? 9 : a[9] ? 10 : a[10] ? 11 : a[11] ? 12 : a[12] ? 13 : a[13] ? 14 : a[14] ? 15 : a[15] ? 16 : a[16] ? 17 : a[17] ? 18 : a[18] ? 19 : a[19] ? 20 : a[20] ? 21 : a[21] ? 22 : a[22] ? 23 : a[23] ? 24 : a[24] ? 25 : a[25] ? 26 : a[26] ? 27 : a[27] ? 28 : a[28] ? 29 : a[29] ? 30 : a[30] ? 31 : a[31] ? 32 : 0;
		     end
		     default: begin // FL1
			result = a[31] ? 32 : a[30] ? 31 : a[29] ? 30 : a[28] ? 29 : a[27] ? 28 : a[26] ? 27 : a[25] ? 26 : a[24] ? 25 : a[23] ? 24 : a[22] ? 23 : a[21] ? 22 : a[20] ? 21 : a[19] ? 20 : a[18] ? 19 : a[17] ? 18 : a[16] ? 17 : a[15] ? 16 : a[14] ? 15 : a[13] ? 14 : a[12] ? 13 : a[11] ? 12 : a[10] ? 11 : a[9] ? 10 : a[8] ? 9 : a[7] ? 8 : a[6] ? 7 : a[5] ? 6 : a[4] ? 5 : a[3] ? 4 : a[2] ? 3 : a[1] ? 2 : a[0] ? 1 : 0 ;
		     end
		   endcase // casez (alu_op2)
		end // case: `OR1200_ALUOP_FFL1
`endif	  
		`OR1200_ALUOP_CUST5 : begin 
				result = result_cust5;
		end
		`OR1200_ALUOP_SHROT : begin 
				result = shifted_rotated;
		end
		`OR1200_ALUOP_ADD : begin
				result = result_sum;
		end
`ifdef OR1200_IMPL_ADDC
		`OR1200_ALUOP_ADDC : begin
				result = result_csum;
		end
`endif
`ifdef OR1200_IMPL_SUB
		`OR1200_ALUOP_SUB : begin
				result = a - b;
		end
`endif
		`OR1200_ALUOP_XOR : begin
				result = a ^ b;
		end
		`OR1200_ALUOP_OR  : begin
				result = a | b;
		end
		`OR1200_ALUOP_IMM : begin
				result = b;
		end
		`OR1200_ALUOP_MOVHI : begin
				if (macrc_op) begin
					result = mult_mac_result;
				end
				else begin
					result = b << 16;
				end
		end
`ifdef OR1200_MULT_IMPLEMENTED
`ifdef OR1200_DIV_IMPLEMENTED
		`OR1200_ALUOP_DIV,
		`OR1200_ALUOP_DIVU,
`endif
		`OR1200_ALUOP_MUL : begin
				result = mult_mac_result;
		end
`endif
		`OR1200_ALUOP_CMOV: begin
			result = flag ? a : b;
		end

`ifdef OR1200_CASE_DEFAULT
		default: begin
`else
		`OR1200_ALUOP_COMP, `OR1200_ALUOP_AND: begin
`endif
			result=result_and;
		end 
	endcase
end

//
// l.cust5 custom instructions
//
// Examples for move byte, set bit and clear bit
//
always @(cust5_op or cust5_limm or a or b) begin
	casez (cust5_op)		// synopsys parallel_case
		5'h1 : begin 
			casez (cust5_limm[1:0])
				2'h0: result_cust5 = {a[31:8], b[7:0]};
				2'h1: result_cust5 = {a[31:16], b[7:0], a[7:0]};
				2'h2: result_cust5 = {a[31:24], b[7:0], a[15:0]};
				2'h3: result_cust5 = {b[7:0], a[23:0]};
			endcase
		end
		5'h2 :
			result_cust5 = a | (1 << cust5_limm);
		5'h3 :
			result_cust5 = a & (32'hffffffff ^ (1 << cust5_limm));
//
// *** Put here new l.cust5 custom instructions ***
//
		default: begin
			result_cust5 = a;
		end
	endcase
end

//
// Generate flag and flag write enable
//
always @(alu_op or result_sum or result_and or flagcomp
`ifdef OR1200_IMPL_ADDC
         or result_csum
`endif
) begin
	casez (alu_op)		// synopsys parallel_case
`ifdef OR1200_ADDITIONAL_FLAG_MODIFIERS
		`OR1200_ALUOP_ADD : begin
			flagforw = (result_sum == 32'h0000_0000);
			flag_we = 1'b1;
		end
`ifdef OR1200_IMPL_ADDC
		`OR1200_ALUOP_ADDC : begin
			flagforw = (result_csum == 32'h0000_0000);
			flag_we = 1'b1;
		end
`endif
		`OR1200_ALUOP_AND: begin
			flagforw = (result_and == 32'h0000_0000);
			flag_we = 1'b1;
		end
`endif
		`OR1200_ALUOP_COMP: begin
			flagforw = flagcomp;
			flag_we = 1'b1;
		end
		default: begin
			flagforw = flagcomp;
			flag_we = 1'b0;
		end
	endcase
end

//
// Generate SR[CY] write enable
//
always @(alu_op or cy_sum
`ifdef OR1200_IMPL_CY
`ifdef OR1200_IMPL_ADDC
	or cy_csum
`endif
`ifdef OR1200_IMPL_SUB
	or cy_sub
`endif
`endif
) begin
	casez (alu_op)		// synopsys parallel_case
`ifdef OR1200_IMPL_CY
		`OR1200_ALUOP_ADD : begin
			cyforw = cy_sum;
			cy_we = 1'b1;
		end
`ifdef OR1200_IMPL_ADDC
		`OR1200_ALUOP_ADDC: begin
			cyforw = cy_csum;
			cy_we = 1'b1;
		end
`endif
`ifdef OR1200_IMPL_SUB
		`OR1200_ALUOP_SUB: begin
			cyforw = cy_sub;
			cy_we = 1'b1;
		end
`endif
`endif
		default: begin
			cyforw = 1'b0;
			cy_we = 1'b0;
		end
	endcase
end

//
// Shifts and rotation
//
always @(shrot_op or a or b) begin
	case (shrot_op)		// synopsys parallel_case
	`OR1200_SHROTOP_SLL :
				shifted_rotated = (a << b[4:0]);
		`OR1200_SHROTOP_SRL :
				shifted_rotated = (a >> b[4:0]);

`ifdef OR1200_IMPL_ALU_ROTATE
		`OR1200_SHROTOP_ROR :
				shifted_rotated = (a << (6'd32-{1'b0, b[4:0]})) | (a >> b[4:0]);
`endif
		default:
				shifted_rotated = ({32{a[31]}} << (6'd32-{1'b0, b[4:0]})) | a >> b[4:0];
	endcase
end

//
// First type of compare implementation
//
`ifdef OR1200_IMPL_ALU_COMP1
always @(comp_op or a_eq_b or a_lt_b) begin
	case(comp_op[2:0])	// synopsys parallel_case
		`OR1200_COP_SFEQ:
			flagcomp = a_eq_b;
		`OR1200_COP_SFNE:
			flagcomp = ~a_eq_b;
		`OR1200_COP_SFGT:
			flagcomp = ~(a_eq_b | a_lt_b);
		`OR1200_COP_SFGE:
			flagcomp = ~a_lt_b;
		`OR1200_COP_SFLT:
			flagcomp = a_lt_b;
		`OR1200_COP_SFLE:
			flagcomp = a_eq_b | a_lt_b;
		default:
			flagcomp = 1'b0;
	endcase
end
`endif

//
// Second type of compare implementation
//
`ifdef OR1200_IMPL_ALU_COMP2
always @(comp_op or comp_a or comp_b) begin
	case(comp_op[2:0])	// synopsys parallel_case
		`OR1200_COP_SFEQ:
			flagcomp = (comp_a == comp_b);
		`OR1200_COP_SFNE:
			flagcomp = (comp_a != comp_b);
		`OR1200_COP_SFGT:
			flagcomp = (comp_a > comp_b);
		`OR1200_COP_SFGE:
			flagcomp = (comp_a >= comp_b);
		`OR1200_COP_SFLT:
			flagcomp = (comp_a < comp_b);
		`OR1200_COP_SFLE:
			flagcomp = (comp_a <= comp_b);
		default:
			flagcomp = 1'b0;
	endcase
end
`endif

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's 32x32 multiply for ASIC                            ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  32x32 multiply for ASIC                                     ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_amultp2_32x32.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 

// synopsys translate_off
// synopsys translate_on

`ifdef OR1200_ASIC_MULTP2_32X32

module PP_LOW ( ONEPOS, ONENEG, TWONEG, INA, INB, PPBIT );
input  ONEPOS;
input  ONENEG;
input  TWONEG;
input  INA;
input  INB;
output PPBIT;
   assign PPBIT = (ONEPOS & INA) | (ONENEG & INB) | TWONEG;
endmodule


module PP_MIDDLE ( ONEPOS, ONENEG, TWOPOS, TWONEG, INA, INB, INC, IND, PPBIT );
input  ONEPOS;
input  ONENEG;
input  TWOPOS;
input  TWONEG;
input  INA;
input  INB;
input  INC;
input  IND;
output PPBIT;
   assign PPBIT =  ~ (( ~ (INA & TWOPOS)) & ( ~ (INB & TWONEG)) & ( ~ (INC & ONEPOS)) & ( ~ (IND & ONENEG)));
endmodule


module PP_HIGH ( ONEPOS, ONENEG, TWOPOS, TWONEG, INA, INB, PPBIT );
input  ONEPOS;
input  ONENEG;
input  TWOPOS;
input  TWONEG;
input  INA;
input  INB;
output PPBIT;
   assign PPBIT =  ~ ((INA & ONEPOS) | (INB & ONENEG) | (INA & TWOPOS) | (INB & TWONEG));
endmodule


module R_GATE ( INA, INB, INC, PPBIT );
input  INA;
input  INB;
input  INC;
output PPBIT;
   assign PPBIT = ( ~ (INA & INB)) & INC;
endmodule


module DECODER ( INA, INB, INC, TWOPOS, TWONEG, ONEPOS, ONENEG );
input  INA;
input  INB;
input  INC;
output TWOPOS;
output TWONEG;
output ONEPOS;
output ONENEG;
   assign TWOPOS =  ~ ( ~ (INA & INB & ( ~ INC)));
   assign TWONEG =  ~ ( ~ (( ~ INA) & ( ~ INB) & INC));
   assign ONEPOS = (( ~ INA) & INB & ( ~ INC)) | (( ~ INC) & ( ~ INB) & INA);
   assign ONENEG = (INA & ( ~ INB) & INC) | (INC & INB & ( ~ INA));
endmodule


module BOOTHCODER_33_32 ( OPA, OPB, SUMMAND );
input  [0:32] OPA;
input  [0:31] OPB;
output [0:575] SUMMAND;
   wire [0:32] INV_MULTIPLICAND;
   wire [0:63] INT_MULTIPLIER;
   wire LOGIC_ONE, LOGIC_ZERO;
   assign LOGIC_ONE = 1;
   assign LOGIC_ZERO = 0;
   DECODER DEC_0 (.INA (LOGIC_ZERO) , .INB (OPB[0]) , .INC (OPB[1]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) );
   assign INV_MULTIPLICAND[0] =  ~ OPA[0];
   PP_LOW PPL_0 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[0]) );
   R_GATE RGATE_0 (.INA (LOGIC_ZERO) , .INB (OPB[0]) , .INC (OPB[1]) , .PPBIT (SUMMAND[1]) );
   assign INV_MULTIPLICAND[1] =  ~ OPA[1];
   PP_MIDDLE PPM_0 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[2]) );
   assign INV_MULTIPLICAND[2] =  ~ OPA[2];
   PP_MIDDLE PPM_1 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[3]) );
   assign INV_MULTIPLICAND[3] =  ~ OPA[3];
   PP_MIDDLE PPM_2 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[6]) );
   assign INV_MULTIPLICAND[4] =  ~ OPA[4];
   PP_MIDDLE PPM_3 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[8]) );
   assign INV_MULTIPLICAND[5] =  ~ OPA[5];
   PP_MIDDLE PPM_4 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[12]) );
   assign INV_MULTIPLICAND[6] =  ~ OPA[6];
   PP_MIDDLE PPM_5 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[15]) );
   assign INV_MULTIPLICAND[7] =  ~ OPA[7];
   PP_MIDDLE PPM_6 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[20]) );
   assign INV_MULTIPLICAND[8] =  ~ OPA[8];
   PP_MIDDLE PPM_7 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[24]) );
   assign INV_MULTIPLICAND[9] =  ~ OPA[9];
   PP_MIDDLE PPM_8 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[30]) );
   assign INV_MULTIPLICAND[10] =  ~ OPA[10];
   PP_MIDDLE PPM_9 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[35]) );
   assign INV_MULTIPLICAND[11] =  ~ OPA[11];
   PP_MIDDLE PPM_10 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[42]) );
   assign INV_MULTIPLICAND[12] =  ~ OPA[12];
   PP_MIDDLE PPM_11 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[48]) );
   assign INV_MULTIPLICAND[13] =  ~ OPA[13];
   PP_MIDDLE PPM_12 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[56]) );
   assign INV_MULTIPLICAND[14] =  ~ OPA[14];
   PP_MIDDLE PPM_13 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[63]) );
   assign INV_MULTIPLICAND[15] =  ~ OPA[15];
   PP_MIDDLE PPM_14 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[72]) );
   assign INV_MULTIPLICAND[16] =  ~ OPA[16];
   PP_MIDDLE PPM_15 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[80]) );
   assign INV_MULTIPLICAND[17] =  ~ OPA[17];
   PP_MIDDLE PPM_16 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[90]) );
   assign INV_MULTIPLICAND[18] =  ~ OPA[18];
   PP_MIDDLE PPM_17 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[99]) );
   assign INV_MULTIPLICAND[19] =  ~ OPA[19];
   PP_MIDDLE PPM_18 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[110]) );
   assign INV_MULTIPLICAND[20] =  ~ OPA[20];
   PP_MIDDLE PPM_19 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[120]) );
   assign INV_MULTIPLICAND[21] =  ~ OPA[21];
   PP_MIDDLE PPM_20 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[132]) );
   assign INV_MULTIPLICAND[22] =  ~ OPA[22];
   PP_MIDDLE PPM_21 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[143]) );
   assign INV_MULTIPLICAND[23] =  ~ OPA[23];
   PP_MIDDLE PPM_22 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[156]) );
   assign INV_MULTIPLICAND[24] =  ~ OPA[24];
   PP_MIDDLE PPM_23 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[168]) );
   assign INV_MULTIPLICAND[25] =  ~ OPA[25];
   PP_MIDDLE PPM_24 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[182]) );
   assign INV_MULTIPLICAND[26] =  ~ OPA[26];
   PP_MIDDLE PPM_25 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[195]) );
   assign INV_MULTIPLICAND[27] =  ~ OPA[27];
   PP_MIDDLE PPM_26 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[210]) );
   assign INV_MULTIPLICAND[28] =  ~ OPA[28];
   PP_MIDDLE PPM_27 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[224]) );
   assign INV_MULTIPLICAND[29] =  ~ OPA[29];
   PP_MIDDLE PPM_28 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[240]) );
   assign INV_MULTIPLICAND[30] =  ~ OPA[30];
   PP_MIDDLE PPM_29 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[255]) );
   assign INV_MULTIPLICAND[31] =  ~ OPA[31];
   PP_MIDDLE PPM_30 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[272]) );
   assign INV_MULTIPLICAND[32] =  ~ OPA[32];
   PP_MIDDLE PPM_31 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[288]) );
   PP_HIGH PPH_0 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[0]) , .TWONEG (INT_MULTIPLIER[1]) , .ONEPOS (INT_MULTIPLIER[2]) , .ONENEG (INT_MULTIPLIER[3]) , .PPBIT (SUMMAND[304]) );
   assign SUMMAND[305] = 1;
   DECODER DEC_1 (.INA (OPB[1]) , .INB (OPB[2]) , .INC (OPB[3]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) );
   PP_LOW PPL_1 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[4]) );
   R_GATE RGATE_1 (.INA (OPB[1]) , .INB (OPB[2]) , .INC (OPB[3]) , .PPBIT (SUMMAND[5]) );
   PP_MIDDLE PPM_32 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[7]) );
   PP_MIDDLE PPM_33 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[9]) );
   PP_MIDDLE PPM_34 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[13]) );
   PP_MIDDLE PPM_35 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[16]) );
   PP_MIDDLE PPM_36 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[21]) );
   PP_MIDDLE PPM_37 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[25]) );
   PP_MIDDLE PPM_38 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[31]) );
   PP_MIDDLE PPM_39 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[36]) );
   PP_MIDDLE PPM_40 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[43]) );
   PP_MIDDLE PPM_41 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[49]) );
   PP_MIDDLE PPM_42 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[57]) );
   PP_MIDDLE PPM_43 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[64]) );
   PP_MIDDLE PPM_44 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[73]) );
   PP_MIDDLE PPM_45 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[81]) );
   PP_MIDDLE PPM_46 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[91]) );
   PP_MIDDLE PPM_47 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[100]) );
   PP_MIDDLE PPM_48 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[111]) );
   PP_MIDDLE PPM_49 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[121]) );
   PP_MIDDLE PPM_50 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[133]) );
   PP_MIDDLE PPM_51 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[144]) );
   PP_MIDDLE PPM_52 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[157]) );
   PP_MIDDLE PPM_53 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[169]) );
   PP_MIDDLE PPM_54 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[183]) );
   PP_MIDDLE PPM_55 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[196]) );
   PP_MIDDLE PPM_56 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[211]) );
   PP_MIDDLE PPM_57 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[225]) );
   PP_MIDDLE PPM_58 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[241]) );
   PP_MIDDLE PPM_59 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[256]) );
   PP_MIDDLE PPM_60 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[273]) );
   PP_MIDDLE PPM_61 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[289]) );
   PP_MIDDLE PPM_62 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[306]) );
   PP_MIDDLE PPM_63 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[321]) );
   assign SUMMAND[322] = LOGIC_ONE;
   PP_HIGH PPH_1 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[4]) , .TWONEG (INT_MULTIPLIER[5]) , .ONEPOS (INT_MULTIPLIER[6]) , .ONENEG (INT_MULTIPLIER[7]) , .PPBIT (SUMMAND[337]) );
   DECODER DEC_2 (.INA (OPB[3]) , .INB (OPB[4]) , .INC (OPB[5]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) );
   PP_LOW PPL_2 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[10]) );
   R_GATE RGATE_2 (.INA (OPB[3]) , .INB (OPB[4]) , .INC (OPB[5]) , .PPBIT (SUMMAND[11]) );
   PP_MIDDLE PPM_64 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[14]) );
   PP_MIDDLE PPM_65 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[17]) );
   PP_MIDDLE PPM_66 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[22]) );
   PP_MIDDLE PPM_67 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[26]) );
   PP_MIDDLE PPM_68 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[32]) );
   PP_MIDDLE PPM_69 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[37]) );
   PP_MIDDLE PPM_70 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[44]) );
   PP_MIDDLE PPM_71 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[50]) );
   PP_MIDDLE PPM_72 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[58]) );
   PP_MIDDLE PPM_73 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[65]) );
   PP_MIDDLE PPM_74 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[74]) );
   PP_MIDDLE PPM_75 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[82]) );
   PP_MIDDLE PPM_76 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[92]) );
   PP_MIDDLE PPM_77 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[101]) );
   PP_MIDDLE PPM_78 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[112]) );
   PP_MIDDLE PPM_79 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[122]) );
   PP_MIDDLE PPM_80 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[134]) );
   PP_MIDDLE PPM_81 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[145]) );
   PP_MIDDLE PPM_82 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[158]) );
   PP_MIDDLE PPM_83 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[170]) );
   PP_MIDDLE PPM_84 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[184]) );
   PP_MIDDLE PPM_85 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[197]) );
   PP_MIDDLE PPM_86 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[212]) );
   PP_MIDDLE PPM_87 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[226]) );
   PP_MIDDLE PPM_88 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[242]) );
   PP_MIDDLE PPM_89 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[257]) );
   PP_MIDDLE PPM_90 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[274]) );
   PP_MIDDLE PPM_91 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[290]) );
   PP_MIDDLE PPM_92 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[307]) );
   PP_MIDDLE PPM_93 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[323]) );
   PP_MIDDLE PPM_94 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[338]) );
   PP_MIDDLE PPM_95 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[352]) );
   assign SUMMAND[353] = LOGIC_ONE;
   PP_HIGH PPH_2 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[8]) , .TWONEG (INT_MULTIPLIER[9]) , .ONEPOS (INT_MULTIPLIER[10]) , .ONENEG (INT_MULTIPLIER[11]) , .PPBIT (SUMMAND[367]) );
   DECODER DEC_3 (.INA (OPB[5]) , .INB (OPB[6]) , .INC (OPB[7]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) );
   PP_LOW PPL_3 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[18]) );
   R_GATE RGATE_3 (.INA (OPB[5]) , .INB (OPB[6]) , .INC (OPB[7]) , .PPBIT (SUMMAND[19]) );
   PP_MIDDLE PPM_96 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[23]) );
   PP_MIDDLE PPM_97 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[27]) );
   PP_MIDDLE PPM_98 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[33]) );
   PP_MIDDLE PPM_99 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[38]) );
   PP_MIDDLE PPM_100 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[45]) );
   PP_MIDDLE PPM_101 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[51]) );
   PP_MIDDLE PPM_102 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[59]) );
   PP_MIDDLE PPM_103 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[66]) );
   PP_MIDDLE PPM_104 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[75]) );
   PP_MIDDLE PPM_105 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[83]) );
   PP_MIDDLE PPM_106 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[93]) );
   PP_MIDDLE PPM_107 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[102]) );
   PP_MIDDLE PPM_108 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[113]) );
   PP_MIDDLE PPM_109 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[123]) );
   PP_MIDDLE PPM_110 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[135]) );
   PP_MIDDLE PPM_111 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[146]) );
   PP_MIDDLE PPM_112 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[159]) );
   PP_MIDDLE PPM_113 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[171]) );
   PP_MIDDLE PPM_114 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[185]) );
   PP_MIDDLE PPM_115 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[198]) );
   PP_MIDDLE PPM_116 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[213]) );
   PP_MIDDLE PPM_117 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[227]) );
   PP_MIDDLE PPM_118 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[243]) );
   PP_MIDDLE PPM_119 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[258]) );
   PP_MIDDLE PPM_120 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[275]) );
   PP_MIDDLE PPM_121 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[291]) );
   PP_MIDDLE PPM_122 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[308]) );
   PP_MIDDLE PPM_123 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[324]) );
   PP_MIDDLE PPM_124 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[339]) );
   PP_MIDDLE PPM_125 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[354]) );
   PP_MIDDLE PPM_126 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[368]) );
   PP_MIDDLE PPM_127 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[381]) );
   assign SUMMAND[382] = LOGIC_ONE;
   PP_HIGH PPH_3 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[12]) , .TWONEG (INT_MULTIPLIER[13]) , .ONEPOS (INT_MULTIPLIER[14]) , .ONENEG (INT_MULTIPLIER[15]) , .PPBIT (SUMMAND[395]) );
   DECODER DEC_4 (.INA (OPB[7]) , .INB (OPB[8]) , .INC (OPB[9]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) );
   PP_LOW PPL_4 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[28]) );
   R_GATE RGATE_4 (.INA (OPB[7]) , .INB (OPB[8]) , .INC (OPB[9]) , .PPBIT (SUMMAND[29]) );
   PP_MIDDLE PPM_128 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[34]) );
   PP_MIDDLE PPM_129 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[39]) );
   PP_MIDDLE PPM_130 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[46]) );
   PP_MIDDLE PPM_131 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[52]) );
   PP_MIDDLE PPM_132 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[60]) );
   PP_MIDDLE PPM_133 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[67]) );
   PP_MIDDLE PPM_134 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[76]) );
   PP_MIDDLE PPM_135 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[84]) );
   PP_MIDDLE PPM_136 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[94]) );
   PP_MIDDLE PPM_137 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[103]) );
   PP_MIDDLE PPM_138 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[114]) );
   PP_MIDDLE PPM_139 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[124]) );
   PP_MIDDLE PPM_140 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[136]) );
   PP_MIDDLE PPM_141 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[147]) );
   PP_MIDDLE PPM_142 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[160]) );
   PP_MIDDLE PPM_143 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[172]) );
   PP_MIDDLE PPM_144 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[186]) );
   PP_MIDDLE PPM_145 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[199]) );
   PP_MIDDLE PPM_146 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[214]) );
   PP_MIDDLE PPM_147 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[228]) );
   PP_MIDDLE PPM_148 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[244]) );
   PP_MIDDLE PPM_149 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[259]) );
   PP_MIDDLE PPM_150 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[276]) );
   PP_MIDDLE PPM_151 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[292]) );
   PP_MIDDLE PPM_152 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[309]) );
   PP_MIDDLE PPM_153 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[325]) );
   PP_MIDDLE PPM_154 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[340]) );
   PP_MIDDLE PPM_155 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[355]) );
   PP_MIDDLE PPM_156 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[369]) );
   PP_MIDDLE PPM_157 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[383]) );
   PP_MIDDLE PPM_158 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[396]) );
   PP_MIDDLE PPM_159 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[408]) );
   assign SUMMAND[409] = LOGIC_ONE;
   PP_HIGH PPH_4 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[16]) , .TWONEG (INT_MULTIPLIER[17]) , .ONEPOS (INT_MULTIPLIER[18]) , .ONENEG (INT_MULTIPLIER[19]) , .PPBIT (SUMMAND[421]) );
   DECODER DEC_5 (.INA (OPB[9]) , .INB (OPB[10]) , .INC (OPB[11]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) );
   PP_LOW PPL_5 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[40]) );
   R_GATE RGATE_5 (.INA (OPB[9]) , .INB (OPB[10]) , .INC (OPB[11]) , .PPBIT (SUMMAND[41]) );
   PP_MIDDLE PPM_160 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[47]) );
   PP_MIDDLE PPM_161 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[53]) );
   PP_MIDDLE PPM_162 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[61]) );
   PP_MIDDLE PPM_163 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[68]) );
   PP_MIDDLE PPM_164 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[77]) );
   PP_MIDDLE PPM_165 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[85]) );
   PP_MIDDLE PPM_166 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[95]) );
   PP_MIDDLE PPM_167 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[104]) );
   PP_MIDDLE PPM_168 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[115]) );
   PP_MIDDLE PPM_169 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[125]) );
   PP_MIDDLE PPM_170 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[137]) );
   PP_MIDDLE PPM_171 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[148]) );
   PP_MIDDLE PPM_172 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[161]) );
   PP_MIDDLE PPM_173 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[173]) );
   PP_MIDDLE PPM_174 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[187]) );
   PP_MIDDLE PPM_175 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[200]) );
   PP_MIDDLE PPM_176 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[215]) );
   PP_MIDDLE PPM_177 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[229]) );
   PP_MIDDLE PPM_178 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[245]) );
   PP_MIDDLE PPM_179 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[260]) );
   PP_MIDDLE PPM_180 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[277]) );
   PP_MIDDLE PPM_181 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[293]) );
   PP_MIDDLE PPM_182 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[310]) );
   PP_MIDDLE PPM_183 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[326]) );
   PP_MIDDLE PPM_184 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[341]) );
   PP_MIDDLE PPM_185 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[356]) );
   PP_MIDDLE PPM_186 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[370]) );
   PP_MIDDLE PPM_187 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[384]) );
   PP_MIDDLE PPM_188 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[397]) );
   PP_MIDDLE PPM_189 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[410]) );
   PP_MIDDLE PPM_190 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[422]) );
   PP_MIDDLE PPM_191 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[433]) );
   assign SUMMAND[434] = LOGIC_ONE;
   PP_HIGH PPH_5 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[20]) , .TWONEG (INT_MULTIPLIER[21]) , .ONEPOS (INT_MULTIPLIER[22]) , .ONENEG (INT_MULTIPLIER[23]) , .PPBIT (SUMMAND[445]) );
   DECODER DEC_6 (.INA (OPB[11]) , .INB (OPB[12]) , .INC (OPB[13]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) );
   PP_LOW PPL_6 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[54]) );
   R_GATE RGATE_6 (.INA (OPB[11]) , .INB (OPB[12]) , .INC (OPB[13]) , .PPBIT (SUMMAND[55]) );
   PP_MIDDLE PPM_192 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[62]) );
   PP_MIDDLE PPM_193 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[69]) );
   PP_MIDDLE PPM_194 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[78]) );
   PP_MIDDLE PPM_195 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[86]) );
   PP_MIDDLE PPM_196 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[96]) );
   PP_MIDDLE PPM_197 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[105]) );
   PP_MIDDLE PPM_198 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[116]) );
   PP_MIDDLE PPM_199 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[126]) );
   PP_MIDDLE PPM_200 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[138]) );
   PP_MIDDLE PPM_201 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[149]) );
   PP_MIDDLE PPM_202 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[162]) );
   PP_MIDDLE PPM_203 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[174]) );
   PP_MIDDLE PPM_204 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[188]) );
   PP_MIDDLE PPM_205 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[201]) );
   PP_MIDDLE PPM_206 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[216]) );
   PP_MIDDLE PPM_207 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[230]) );
   PP_MIDDLE PPM_208 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[246]) );
   PP_MIDDLE PPM_209 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[261]) );
   PP_MIDDLE PPM_210 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[278]) );
   PP_MIDDLE PPM_211 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[294]) );
   PP_MIDDLE PPM_212 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[311]) );
   PP_MIDDLE PPM_213 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[327]) );
   PP_MIDDLE PPM_214 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[342]) );
   PP_MIDDLE PPM_215 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[357]) );
   PP_MIDDLE PPM_216 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[371]) );
   PP_MIDDLE PPM_217 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[385]) );
   PP_MIDDLE PPM_218 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[398]) );
   PP_MIDDLE PPM_219 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[411]) );
   PP_MIDDLE PPM_220 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[423]) );
   PP_MIDDLE PPM_221 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[435]) );
   PP_MIDDLE PPM_222 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[446]) );
   PP_MIDDLE PPM_223 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[456]) );
   assign SUMMAND[457] = LOGIC_ONE;
   PP_HIGH PPH_6 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[24]) , .TWONEG (INT_MULTIPLIER[25]) , .ONEPOS (INT_MULTIPLIER[26]) , .ONENEG (INT_MULTIPLIER[27]) , .PPBIT (SUMMAND[467]) );
   DECODER DEC_7 (.INA (OPB[13]) , .INB (OPB[14]) , .INC (OPB[15]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) );
   PP_LOW PPL_7 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[70]) );
   R_GATE RGATE_7 (.INA (OPB[13]) , .INB (OPB[14]) , .INC (OPB[15]) , .PPBIT (SUMMAND[71]) );
   PP_MIDDLE PPM_224 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[79]) );
   PP_MIDDLE PPM_225 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[87]) );
   PP_MIDDLE PPM_226 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[97]) );
   PP_MIDDLE PPM_227 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[106]) );
   PP_MIDDLE PPM_228 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[117]) );
   PP_MIDDLE PPM_229 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[127]) );
   PP_MIDDLE PPM_230 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[139]) );
   PP_MIDDLE PPM_231 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[150]) );
   PP_MIDDLE PPM_232 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[163]) );
   PP_MIDDLE PPM_233 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[175]) );
   PP_MIDDLE PPM_234 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[189]) );
   PP_MIDDLE PPM_235 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[202]) );
   PP_MIDDLE PPM_236 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[217]) );
   PP_MIDDLE PPM_237 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[231]) );
   PP_MIDDLE PPM_238 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[247]) );
   PP_MIDDLE PPM_239 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[262]) );
   PP_MIDDLE PPM_240 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[279]) );
   PP_MIDDLE PPM_241 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[295]) );
   PP_MIDDLE PPM_242 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[312]) );
   PP_MIDDLE PPM_243 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[328]) );
   PP_MIDDLE PPM_244 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[343]) );
   PP_MIDDLE PPM_245 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[358]) );
   PP_MIDDLE PPM_246 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[372]) );
   PP_MIDDLE PPM_247 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[386]) );
   PP_MIDDLE PPM_248 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[399]) );
   PP_MIDDLE PPM_249 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[412]) );
   PP_MIDDLE PPM_250 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[424]) );
   PP_MIDDLE PPM_251 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[436]) );
   PP_MIDDLE PPM_252 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[447]) );
   PP_MIDDLE PPM_253 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[458]) );
   PP_MIDDLE PPM_254 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[468]) );
   PP_MIDDLE PPM_255 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[477]) );
   assign SUMMAND[478] = LOGIC_ONE;
   PP_HIGH PPH_7 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[28]) , .TWONEG (INT_MULTIPLIER[29]) , .ONEPOS (INT_MULTIPLIER[30]) , .ONENEG (INT_MULTIPLIER[31]) , .PPBIT (SUMMAND[487]) );
   DECODER DEC_8 (.INA (OPB[15]) , .INB (OPB[16]) , .INC (OPB[17]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) );
   PP_LOW PPL_8 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[88]) );
   R_GATE RGATE_8 (.INA (OPB[15]) , .INB (OPB[16]) , .INC (OPB[17]) , .PPBIT (SUMMAND[89]) );
   PP_MIDDLE PPM_256 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[98]) );
   PP_MIDDLE PPM_257 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[107]) );
   PP_MIDDLE PPM_258 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[118]) );
   PP_MIDDLE PPM_259 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[128]) );
   PP_MIDDLE PPM_260 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[140]) );
   PP_MIDDLE PPM_261 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[151]) );
   PP_MIDDLE PPM_262 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[164]) );
   PP_MIDDLE PPM_263 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[176]) );
   PP_MIDDLE PPM_264 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[190]) );
   PP_MIDDLE PPM_265 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[203]) );
   PP_MIDDLE PPM_266 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[218]) );
   PP_MIDDLE PPM_267 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[232]) );
   PP_MIDDLE PPM_268 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[248]) );
   PP_MIDDLE PPM_269 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[263]) );
   PP_MIDDLE PPM_270 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[280]) );
   PP_MIDDLE PPM_271 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[296]) );
   PP_MIDDLE PPM_272 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[313]) );
   PP_MIDDLE PPM_273 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[329]) );
   PP_MIDDLE PPM_274 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[344]) );
   PP_MIDDLE PPM_275 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[359]) );
   PP_MIDDLE PPM_276 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[373]) );
   PP_MIDDLE PPM_277 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[387]) );
   PP_MIDDLE PPM_278 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[400]) );
   PP_MIDDLE PPM_279 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[413]) );
   PP_MIDDLE PPM_280 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[425]) );
   PP_MIDDLE PPM_281 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[437]) );
   PP_MIDDLE PPM_282 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[448]) );
   PP_MIDDLE PPM_283 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[459]) );
   PP_MIDDLE PPM_284 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[469]) );
   PP_MIDDLE PPM_285 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[479]) );
   PP_MIDDLE PPM_286 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[488]) );
   PP_MIDDLE PPM_287 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[496]) );
   assign SUMMAND[497] = LOGIC_ONE;
   PP_HIGH PPH_8 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[32]) , .TWONEG (INT_MULTIPLIER[33]) , .ONEPOS (INT_MULTIPLIER[34]) , .ONENEG (INT_MULTIPLIER[35]) , .PPBIT (SUMMAND[505]) );
   DECODER DEC_9 (.INA (OPB[17]) , .INB (OPB[18]) , .INC (OPB[19]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) );
   PP_LOW PPL_9 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[108]) );
   R_GATE RGATE_9 (.INA (OPB[17]) , .INB (OPB[18]) , .INC (OPB[19]) , .PPBIT (SUMMAND[109]) );
   PP_MIDDLE PPM_288 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[119]) );
   PP_MIDDLE PPM_289 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[129]) );
   PP_MIDDLE PPM_290 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[141]) );
   PP_MIDDLE PPM_291 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[152]) );
   PP_MIDDLE PPM_292 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[165]) );
   PP_MIDDLE PPM_293 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[177]) );
   PP_MIDDLE PPM_294 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[191]) );
   PP_MIDDLE PPM_295 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[204]) );
   PP_MIDDLE PPM_296 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[219]) );
   PP_MIDDLE PPM_297 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[233]) );
   PP_MIDDLE PPM_298 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[249]) );
   PP_MIDDLE PPM_299 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[264]) );
   PP_MIDDLE PPM_300 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[281]) );
   PP_MIDDLE PPM_301 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[297]) );
   PP_MIDDLE PPM_302 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[314]) );
   PP_MIDDLE PPM_303 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[330]) );
   PP_MIDDLE PPM_304 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[345]) );
   PP_MIDDLE PPM_305 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[360]) );
   PP_MIDDLE PPM_306 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[374]) );
   PP_MIDDLE PPM_307 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[388]) );
   PP_MIDDLE PPM_308 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[401]) );
   PP_MIDDLE PPM_309 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[414]) );
   PP_MIDDLE PPM_310 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[426]) );
   PP_MIDDLE PPM_311 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[438]) );
   PP_MIDDLE PPM_312 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[449]) );
   PP_MIDDLE PPM_313 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[460]) );
   PP_MIDDLE PPM_314 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[470]) );
   PP_MIDDLE PPM_315 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[480]) );
   PP_MIDDLE PPM_316 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[489]) );
   PP_MIDDLE PPM_317 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[498]) );
   PP_MIDDLE PPM_318 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[506]) );
   PP_MIDDLE PPM_319 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[513]) );
   assign SUMMAND[514] = LOGIC_ONE;
   PP_HIGH PPH_9 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[36]) , .TWONEG (INT_MULTIPLIER[37]) , .ONEPOS (INT_MULTIPLIER[38]) , .ONENEG (INT_MULTIPLIER[39]) , .PPBIT (SUMMAND[521]) );
   DECODER DEC_10 (.INA (OPB[19]) , .INB (OPB[20]) , .INC (OPB[21]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) );
   PP_LOW PPL_10 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[130]) );
   R_GATE RGATE_10 (.INA (OPB[19]) , .INB (OPB[20]) , .INC (OPB[21]) , .PPBIT (SUMMAND[131]) );
   PP_MIDDLE PPM_320 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[142]) );
   PP_MIDDLE PPM_321 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[153]) );
   PP_MIDDLE PPM_322 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[166]) );
   PP_MIDDLE PPM_323 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[178]) );
   PP_MIDDLE PPM_324 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[192]) );
   PP_MIDDLE PPM_325 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[205]) );
   PP_MIDDLE PPM_326 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[220]) );
   PP_MIDDLE PPM_327 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[234]) );
   PP_MIDDLE PPM_328 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[250]) );
   PP_MIDDLE PPM_329 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[265]) );
   PP_MIDDLE PPM_330 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[282]) );
   PP_MIDDLE PPM_331 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[298]) );
   PP_MIDDLE PPM_332 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[315]) );
   PP_MIDDLE PPM_333 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[331]) );
   PP_MIDDLE PPM_334 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[346]) );
   PP_MIDDLE PPM_335 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[361]) );
   PP_MIDDLE PPM_336 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[375]) );
   PP_MIDDLE PPM_337 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[389]) );
   PP_MIDDLE PPM_338 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[402]) );
   PP_MIDDLE PPM_339 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[415]) );
   PP_MIDDLE PPM_340 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[427]) );
   PP_MIDDLE PPM_341 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[439]) );
   PP_MIDDLE PPM_342 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[450]) );
   PP_MIDDLE PPM_343 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[461]) );
   PP_MIDDLE PPM_344 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[471]) );
   PP_MIDDLE PPM_345 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[481]) );
   PP_MIDDLE PPM_346 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[490]) );
   PP_MIDDLE PPM_347 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[499]) );
   PP_MIDDLE PPM_348 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[507]) );
   PP_MIDDLE PPM_349 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[515]) );
   PP_MIDDLE PPM_350 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[522]) );
   PP_MIDDLE PPM_351 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[528]) );
   assign SUMMAND[529] = LOGIC_ONE;
   PP_HIGH PPH_10 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[40]) , .TWONEG (INT_MULTIPLIER[41]) , .ONEPOS (INT_MULTIPLIER[42]) , .ONENEG (INT_MULTIPLIER[43]) , .PPBIT (SUMMAND[535]) );
   DECODER DEC_11 (.INA (OPB[21]) , .INB (OPB[22]) , .INC (OPB[23]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) );
   PP_LOW PPL_11 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[154]) );
   R_GATE RGATE_11 (.INA (OPB[21]) , .INB (OPB[22]) , .INC (OPB[23]) , .PPBIT (SUMMAND[155]) );
   PP_MIDDLE PPM_352 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[167]) );
   PP_MIDDLE PPM_353 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[179]) );
   PP_MIDDLE PPM_354 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[193]) );
   PP_MIDDLE PPM_355 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[206]) );
   PP_MIDDLE PPM_356 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[221]) );
   PP_MIDDLE PPM_357 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[235]) );
   PP_MIDDLE PPM_358 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[251]) );
   PP_MIDDLE PPM_359 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[266]) );
   PP_MIDDLE PPM_360 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[283]) );
   PP_MIDDLE PPM_361 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[299]) );
   PP_MIDDLE PPM_362 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[316]) );
   PP_MIDDLE PPM_363 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[332]) );
   PP_MIDDLE PPM_364 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[347]) );
   PP_MIDDLE PPM_365 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[362]) );
   PP_MIDDLE PPM_366 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[376]) );
   PP_MIDDLE PPM_367 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[390]) );
   PP_MIDDLE PPM_368 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[403]) );
   PP_MIDDLE PPM_369 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[416]) );
   PP_MIDDLE PPM_370 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[428]) );
   PP_MIDDLE PPM_371 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[440]) );
   PP_MIDDLE PPM_372 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[451]) );
   PP_MIDDLE PPM_373 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[462]) );
   PP_MIDDLE PPM_374 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[472]) );
   PP_MIDDLE PPM_375 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[482]) );
   PP_MIDDLE PPM_376 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[491]) );
   PP_MIDDLE PPM_377 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[500]) );
   PP_MIDDLE PPM_378 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[508]) );
   PP_MIDDLE PPM_379 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[516]) );
   PP_MIDDLE PPM_380 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[523]) );
   PP_MIDDLE PPM_381 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[530]) );
   PP_MIDDLE PPM_382 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[536]) );
   PP_MIDDLE PPM_383 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[541]) );
   assign SUMMAND[542] = LOGIC_ONE;
   PP_HIGH PPH_11 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[44]) , .TWONEG (INT_MULTIPLIER[45]) , .ONEPOS (INT_MULTIPLIER[46]) , .ONENEG (INT_MULTIPLIER[47]) , .PPBIT (SUMMAND[547]) );
   DECODER DEC_12 (.INA (OPB[23]) , .INB (OPB[24]) , .INC (OPB[25]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) );
   PP_LOW PPL_12 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[180]) );
   R_GATE RGATE_12 (.INA (OPB[23]) , .INB (OPB[24]) , .INC (OPB[25]) , .PPBIT (SUMMAND[181]) );
   PP_MIDDLE PPM_384 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[194]) );
   PP_MIDDLE PPM_385 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[207]) );
   PP_MIDDLE PPM_386 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[222]) );
   PP_MIDDLE PPM_387 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[236]) );
   PP_MIDDLE PPM_388 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[252]) );
   PP_MIDDLE PPM_389 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[267]) );
   PP_MIDDLE PPM_390 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[284]) );
   PP_MIDDLE PPM_391 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[300]) );
   PP_MIDDLE PPM_392 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[317]) );
   PP_MIDDLE PPM_393 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[333]) );
   PP_MIDDLE PPM_394 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[348]) );
   PP_MIDDLE PPM_395 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[363]) );
   PP_MIDDLE PPM_396 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[377]) );
   PP_MIDDLE PPM_397 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[391]) );
   PP_MIDDLE PPM_398 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[404]) );
   PP_MIDDLE PPM_399 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[417]) );
   PP_MIDDLE PPM_400 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[429]) );
   PP_MIDDLE PPM_401 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[441]) );
   PP_MIDDLE PPM_402 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[452]) );
   PP_MIDDLE PPM_403 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[463]) );
   PP_MIDDLE PPM_404 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[473]) );
   PP_MIDDLE PPM_405 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[483]) );
   PP_MIDDLE PPM_406 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[492]) );
   PP_MIDDLE PPM_407 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[501]) );
   PP_MIDDLE PPM_408 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[509]) );
   PP_MIDDLE PPM_409 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[517]) );
   PP_MIDDLE PPM_410 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[524]) );
   PP_MIDDLE PPM_411 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[531]) );
   PP_MIDDLE PPM_412 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[537]) );
   PP_MIDDLE PPM_413 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[543]) );
   PP_MIDDLE PPM_414 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[548]) );
   PP_MIDDLE PPM_415 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[552]) );
   assign SUMMAND[553] = LOGIC_ONE;
   PP_HIGH PPH_12 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[48]) , .TWONEG (INT_MULTIPLIER[49]) , .ONEPOS (INT_MULTIPLIER[50]) , .ONENEG (INT_MULTIPLIER[51]) , .PPBIT (SUMMAND[557]) );
   DECODER DEC_13 (.INA (OPB[25]) , .INB (OPB[26]) , .INC (OPB[27]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) );
   PP_LOW PPL_13 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[208]) );
   R_GATE RGATE_13 (.INA (OPB[25]) , .INB (OPB[26]) , .INC (OPB[27]) , .PPBIT (SUMMAND[209]) );
   PP_MIDDLE PPM_416 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[223]) );
   PP_MIDDLE PPM_417 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[237]) );
   PP_MIDDLE PPM_418 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[253]) );
   PP_MIDDLE PPM_419 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[268]) );
   PP_MIDDLE PPM_420 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[285]) );
   PP_MIDDLE PPM_421 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[301]) );
   PP_MIDDLE PPM_422 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[318]) );
   PP_MIDDLE PPM_423 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[334]) );
   PP_MIDDLE PPM_424 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[349]) );
   PP_MIDDLE PPM_425 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[364]) );
   PP_MIDDLE PPM_426 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[378]) );
   PP_MIDDLE PPM_427 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[392]) );
   PP_MIDDLE PPM_428 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[405]) );
   PP_MIDDLE PPM_429 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[418]) );
   PP_MIDDLE PPM_430 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[430]) );
   PP_MIDDLE PPM_431 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[442]) );
   PP_MIDDLE PPM_432 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[453]) );
   PP_MIDDLE PPM_433 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[464]) );
   PP_MIDDLE PPM_434 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[474]) );
   PP_MIDDLE PPM_435 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[484]) );
   PP_MIDDLE PPM_436 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[493]) );
   PP_MIDDLE PPM_437 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[502]) );
   PP_MIDDLE PPM_438 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[510]) );
   PP_MIDDLE PPM_439 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[518]) );
   PP_MIDDLE PPM_440 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[525]) );
   PP_MIDDLE PPM_441 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[532]) );
   PP_MIDDLE PPM_442 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[538]) );
   PP_MIDDLE PPM_443 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[544]) );
   PP_MIDDLE PPM_444 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[549]) );
   PP_MIDDLE PPM_445 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[554]) );
   PP_MIDDLE PPM_446 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[558]) );
   PP_MIDDLE PPM_447 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[561]) );
   assign SUMMAND[562] = LOGIC_ONE;
   PP_HIGH PPH_13 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[52]) , .TWONEG (INT_MULTIPLIER[53]) , .ONEPOS (INT_MULTIPLIER[54]) , .ONENEG (INT_MULTIPLIER[55]) , .PPBIT (SUMMAND[565]) );
   DECODER DEC_14 (.INA (OPB[27]) , .INB (OPB[28]) , .INC (OPB[29]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) );
   PP_LOW PPL_14 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[238]) );
   R_GATE RGATE_14 (.INA (OPB[27]) , .INB (OPB[28]) , .INC (OPB[29]) , .PPBIT (SUMMAND[239]) );
   PP_MIDDLE PPM_448 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[254]) );
   PP_MIDDLE PPM_449 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[269]) );
   PP_MIDDLE PPM_450 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[286]) );
   PP_MIDDLE PPM_451 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[302]) );
   PP_MIDDLE PPM_452 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[319]) );
   PP_MIDDLE PPM_453 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[335]) );
   PP_MIDDLE PPM_454 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[350]) );
   PP_MIDDLE PPM_455 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[365]) );
   PP_MIDDLE PPM_456 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[379]) );
   PP_MIDDLE PPM_457 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[393]) );
   PP_MIDDLE PPM_458 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[406]) );
   PP_MIDDLE PPM_459 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[419]) );
   PP_MIDDLE PPM_460 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[431]) );
   PP_MIDDLE PPM_461 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[443]) );
   PP_MIDDLE PPM_462 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[454]) );
   PP_MIDDLE PPM_463 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[465]) );
   PP_MIDDLE PPM_464 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[475]) );
   PP_MIDDLE PPM_465 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[485]) );
   PP_MIDDLE PPM_466 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[494]) );
   PP_MIDDLE PPM_467 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[503]) );
   PP_MIDDLE PPM_468 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[511]) );
   PP_MIDDLE PPM_469 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[519]) );
   PP_MIDDLE PPM_470 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[526]) );
   PP_MIDDLE PPM_471 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[533]) );
   PP_MIDDLE PPM_472 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[539]) );
   PP_MIDDLE PPM_473 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[545]) );
   PP_MIDDLE PPM_474 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[550]) );
   PP_MIDDLE PPM_475 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[555]) );
   PP_MIDDLE PPM_476 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[559]) );
   PP_MIDDLE PPM_477 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[563]) );
   PP_MIDDLE PPM_478 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[566]) );
   PP_MIDDLE PPM_479 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[568]) );
   assign SUMMAND[569] = LOGIC_ONE;
   PP_HIGH PPH_14 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[56]) , .TWONEG (INT_MULTIPLIER[57]) , .ONEPOS (INT_MULTIPLIER[58]) , .ONENEG (INT_MULTIPLIER[59]) , .PPBIT (SUMMAND[571]) );
   DECODER DEC_15 (.INA (OPB[29]) , .INB (OPB[30]) , .INC (OPB[31]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) );
   PP_LOW PPL_15 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[270]) );
   R_GATE RGATE_15 (.INA (OPB[29]) , .INB (OPB[30]) , .INC (OPB[31]) , .PPBIT (SUMMAND[271]) );
   PP_MIDDLE PPM_480 (.INA (OPA[0]) , .INB (INV_MULTIPLICAND[0]) , .INC (OPA[1]) , .IND (INV_MULTIPLICAND[1]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[287]) );
   PP_MIDDLE PPM_481 (.INA (OPA[1]) , .INB (INV_MULTIPLICAND[1]) , .INC (OPA[2]) , .IND (INV_MULTIPLICAND[2]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[303]) );
   PP_MIDDLE PPM_482 (.INA (OPA[2]) , .INB (INV_MULTIPLICAND[2]) , .INC (OPA[3]) , .IND (INV_MULTIPLICAND[3]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[320]) );
   PP_MIDDLE PPM_483 (.INA (OPA[3]) , .INB (INV_MULTIPLICAND[3]) , .INC (OPA[4]) , .IND (INV_MULTIPLICAND[4]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[336]) );
   PP_MIDDLE PPM_484 (.INA (OPA[4]) , .INB (INV_MULTIPLICAND[4]) , .INC (OPA[5]) , .IND (INV_MULTIPLICAND[5]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[351]) );
   PP_MIDDLE PPM_485 (.INA (OPA[5]) , .INB (INV_MULTIPLICAND[5]) , .INC (OPA[6]) , .IND (INV_MULTIPLICAND[6]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[366]) );
   PP_MIDDLE PPM_486 (.INA (OPA[6]) , .INB (INV_MULTIPLICAND[6]) , .INC (OPA[7]) , .IND (INV_MULTIPLICAND[7]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[380]) );
   PP_MIDDLE PPM_487 (.INA (OPA[7]) , .INB (INV_MULTIPLICAND[7]) , .INC (OPA[8]) , .IND (INV_MULTIPLICAND[8]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[394]) );
   PP_MIDDLE PPM_488 (.INA (OPA[8]) , .INB (INV_MULTIPLICAND[8]) , .INC (OPA[9]) , .IND (INV_MULTIPLICAND[9]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[407]) );
   PP_MIDDLE PPM_489 (.INA (OPA[9]) , .INB (INV_MULTIPLICAND[9]) , .INC (OPA[10]) , .IND (INV_MULTIPLICAND[10]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[420]) );
   PP_MIDDLE PPM_490 (.INA (OPA[10]) , .INB (INV_MULTIPLICAND[10]) , .INC (OPA[11]) , .IND (INV_MULTIPLICAND[11]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[432]) );
   PP_MIDDLE PPM_491 (.INA (OPA[11]) , .INB (INV_MULTIPLICAND[11]) , .INC (OPA[12]) , .IND (INV_MULTIPLICAND[12]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[444]) );
   PP_MIDDLE PPM_492 (.INA (OPA[12]) , .INB (INV_MULTIPLICAND[12]) , .INC (OPA[13]) , .IND (INV_MULTIPLICAND[13]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[455]) );
   PP_MIDDLE PPM_493 (.INA (OPA[13]) , .INB (INV_MULTIPLICAND[13]) , .INC (OPA[14]) , .IND (INV_MULTIPLICAND[14]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[466]) );
   PP_MIDDLE PPM_494 (.INA (OPA[14]) , .INB (INV_MULTIPLICAND[14]) , .INC (OPA[15]) , .IND (INV_MULTIPLICAND[15]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[476]) );
   PP_MIDDLE PPM_495 (.INA (OPA[15]) , .INB (INV_MULTIPLICAND[15]) , .INC (OPA[16]) , .IND (INV_MULTIPLICAND[16]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[486]) );
   PP_MIDDLE PPM_496 (.INA (OPA[16]) , .INB (INV_MULTIPLICAND[16]) , .INC (OPA[17]) , .IND (INV_MULTIPLICAND[17]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[495]) );
   PP_MIDDLE PPM_497 (.INA (OPA[17]) , .INB (INV_MULTIPLICAND[17]) , .INC (OPA[18]) , .IND (INV_MULTIPLICAND[18]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[504]) );
   PP_MIDDLE PPM_498 (.INA (OPA[18]) , .INB (INV_MULTIPLICAND[18]) , .INC (OPA[19]) , .IND (INV_MULTIPLICAND[19]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[512]) );
   PP_MIDDLE PPM_499 (.INA (OPA[19]) , .INB (INV_MULTIPLICAND[19]) , .INC (OPA[20]) , .IND (INV_MULTIPLICAND[20]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[520]) );
   PP_MIDDLE PPM_500 (.INA (OPA[20]) , .INB (INV_MULTIPLICAND[20]) , .INC (OPA[21]) , .IND (INV_MULTIPLICAND[21]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[527]) );
   PP_MIDDLE PPM_501 (.INA (OPA[21]) , .INB (INV_MULTIPLICAND[21]) , .INC (OPA[22]) , .IND (INV_MULTIPLICAND[22]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[534]) );
   PP_MIDDLE PPM_502 (.INA (OPA[22]) , .INB (INV_MULTIPLICAND[22]) , .INC (OPA[23]) , .IND (INV_MULTIPLICAND[23]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[540]) );
   PP_MIDDLE PPM_503 (.INA (OPA[23]) , .INB (INV_MULTIPLICAND[23]) , .INC (OPA[24]) , .IND (INV_MULTIPLICAND[24]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[546]) );
   PP_MIDDLE PPM_504 (.INA (OPA[24]) , .INB (INV_MULTIPLICAND[24]) , .INC (OPA[25]) , .IND (INV_MULTIPLICAND[25]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[551]) );
   PP_MIDDLE PPM_505 (.INA (OPA[25]) , .INB (INV_MULTIPLICAND[25]) , .INC (OPA[26]) , .IND (INV_MULTIPLICAND[26]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[556]) );
   PP_MIDDLE PPM_506 (.INA (OPA[26]) , .INB (INV_MULTIPLICAND[26]) , .INC (OPA[27]) , .IND (INV_MULTIPLICAND[27]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[560]) );
   PP_MIDDLE PPM_507 (.INA (OPA[27]) , .INB (INV_MULTIPLICAND[27]) , .INC (OPA[28]) , .IND (INV_MULTIPLICAND[28]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[564]) );
   PP_MIDDLE PPM_508 (.INA (OPA[28]) , .INB (INV_MULTIPLICAND[28]) , .INC (OPA[29]) , .IND (INV_MULTIPLICAND[29]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[567]) );
   PP_MIDDLE PPM_509 (.INA (OPA[29]) , .INB (INV_MULTIPLICAND[29]) , .INC (OPA[30]) , .IND (INV_MULTIPLICAND[30]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[570]) );
   PP_MIDDLE PPM_510 (.INA (OPA[30]) , .INB (INV_MULTIPLICAND[30]) , .INC (OPA[31]) , .IND (INV_MULTIPLICAND[31]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[572]) );
   PP_MIDDLE PPM_511 (.INA (OPA[31]) , .INB (INV_MULTIPLICAND[31]) , .INC (OPA[32]) , .IND (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[573]) );
   assign SUMMAND[574] = LOGIC_ONE;
   PP_HIGH PPH_15 (.INA (OPA[32]) , .INB (INV_MULTIPLICAND[32]) , .TWOPOS (INT_MULTIPLIER[60]) , .TWONEG (INT_MULTIPLIER[61]) , .ONEPOS (INT_MULTIPLIER[62]) , .ONENEG (INT_MULTIPLIER[63]) , .PPBIT (SUMMAND[575]) );
endmodule


module FULL_ADDER ( DATA_A, DATA_B, DATA_C, SAVE, CARRY );
input  DATA_A;
input  DATA_B;
input  DATA_C;
output SAVE;
output CARRY;
   wire TMP;
   assign TMP = DATA_A ^ DATA_B;
   assign SAVE = TMP ^ DATA_C;
   assign CARRY =  ~ (( ~ (TMP & DATA_C)) & ( ~ (DATA_A & DATA_B)));
endmodule


module HALF_ADDER ( DATA_A, DATA_B, SAVE, CARRY );
input  DATA_A;
input  DATA_B;
output SAVE;
output CARRY;
   assign SAVE = DATA_A ^ DATA_B;
   assign CARRY = DATA_A & DATA_B;
endmodule


module FLIPFLOP ( DIN, RST, CLK, DOUT );
input  DIN;
input  RST;
input  CLK;
output DOUT;
   reg DOUT_reg;
   always @ (  posedge CLK ) begin
      if (RST == `OR1200_RST_VALUE)
        DOUT_reg <= 1'b0;
      else
        DOUT_reg <=  DIN;
   end
   assign DOUT = DOUT_reg;
endmodule


module WALLACE_33_32 ( SUMMAND, RST, CLK, CARRY, SUM );
input  [0:575] SUMMAND;
input  RST;
input  CLK;
output [0:62] CARRY;
output [0:63] SUM;
   wire [0:7] LATCHED_PP;
   wire [0:523] INT_CARRY;
   wire [0:669] INT_SUM;
   HALF_ADDER HA_0 (.DATA_A (SUMMAND[0]) , .DATA_B (SUMMAND[1]) , .SAVE (INT_SUM[0]) , .CARRY (INT_CARRY[0]) );
   FLIPFLOP LA_0 (.DIN (INT_SUM[0]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[0]) );
   FLIPFLOP LA_1 (.DIN (INT_CARRY[0]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[0]) );
   assign INT_SUM[1] = SUMMAND[2];
   assign CARRY[1] = 0;
   FLIPFLOP LA_2 (.DIN (INT_SUM[1]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[1]) );
   FULL_ADDER FA_0 (.DATA_A (SUMMAND[3]) , .DATA_B (SUMMAND[4]) , .DATA_C (SUMMAND[5]) , .SAVE (INT_SUM[2]) , .CARRY (INT_CARRY[1]) );
   FLIPFLOP LA_3 (.DIN (INT_SUM[2]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[2]) );
   FLIPFLOP LA_4 (.DIN (INT_CARRY[1]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[2]) );
   HALF_ADDER HA_1 (.DATA_A (SUMMAND[6]) , .DATA_B (SUMMAND[7]) , .SAVE (INT_SUM[3]) , .CARRY (INT_CARRY[2]) );
   FLIPFLOP LA_5 (.DIN (INT_SUM[3]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[3]) );
   FLIPFLOP LA_6 (.DIN (INT_CARRY[2]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[3]) );
   FULL_ADDER FA_1 (.DATA_A (SUMMAND[8]) , .DATA_B (SUMMAND[9]) , .DATA_C (SUMMAND[10]) , .SAVE (INT_SUM[4]) , .CARRY (INT_CARRY[4]) );
   assign INT_SUM[5] = SUMMAND[11];
   HALF_ADDER HA_2 (.DATA_A (INT_SUM[4]) , .DATA_B (INT_SUM[5]) , .SAVE (INT_SUM[6]) , .CARRY (INT_CARRY[3]) );
   FLIPFLOP LA_7 (.DIN (INT_SUM[6]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[4]) );
   FLIPFLOP LA_8 (.DIN (INT_CARRY[3]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[4]) );
   FULL_ADDER FA_2 (.DATA_A (SUMMAND[12]) , .DATA_B (SUMMAND[13]) , .DATA_C (SUMMAND[14]) , .SAVE (INT_SUM[7]) , .CARRY (INT_CARRY[6]) );
   HALF_ADDER HA_3 (.DATA_A (INT_SUM[7]) , .DATA_B (INT_CARRY[4]) , .SAVE (INT_SUM[8]) , .CARRY (INT_CARRY[5]) );
   FLIPFLOP LA_9 (.DIN (INT_SUM[8]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[5]) );
   FLIPFLOP LA_10 (.DIN (INT_CARRY[5]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[5]) );
   FULL_ADDER FA_3 (.DATA_A (SUMMAND[15]) , .DATA_B (SUMMAND[16]) , .DATA_C (SUMMAND[17]) , .SAVE (INT_SUM[9]) , .CARRY (INT_CARRY[8]) );
   HALF_ADDER HA_4 (.DATA_A (SUMMAND[18]) , .DATA_B (SUMMAND[19]) , .SAVE (INT_SUM[10]) , .CARRY (INT_CARRY[9]) );
   FULL_ADDER FA_4 (.DATA_A (INT_SUM[9]) , .DATA_B (INT_SUM[10]) , .DATA_C (INT_CARRY[6]) , .SAVE (INT_SUM[11]) , .CARRY (INT_CARRY[7]) );
   FLIPFLOP LA_11 (.DIN (INT_SUM[11]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[6]) );
   FLIPFLOP LA_12 (.DIN (INT_CARRY[7]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[6]) );
   FULL_ADDER FA_5 (.DATA_A (SUMMAND[20]) , .DATA_B (SUMMAND[21]) , .DATA_C (SUMMAND[22]) , .SAVE (INT_SUM[12]) , .CARRY (INT_CARRY[11]) );
   assign INT_SUM[13] = SUMMAND[23];
   FULL_ADDER FA_6 (.DATA_A (INT_SUM[12]) , .DATA_B (INT_SUM[13]) , .DATA_C (INT_CARRY[8]) , .SAVE (INT_SUM[14]) , .CARRY (INT_CARRY[12]) );
   assign INT_SUM[15] = INT_CARRY[9];
   HALF_ADDER HA_5 (.DATA_A (INT_SUM[14]) , .DATA_B (INT_SUM[15]) , .SAVE (INT_SUM[16]) , .CARRY (INT_CARRY[10]) );
   FLIPFLOP LA_13 (.DIN (INT_SUM[16]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[7]) );
   FLIPFLOP LA_14 (.DIN (INT_CARRY[10]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[7]) );
   FULL_ADDER FA_7 (.DATA_A (SUMMAND[24]) , .DATA_B (SUMMAND[25]) , .DATA_C (SUMMAND[26]) , .SAVE (INT_SUM[17]) , .CARRY (INT_CARRY[14]) );
   FULL_ADDER FA_8 (.DATA_A (SUMMAND[27]) , .DATA_B (SUMMAND[28]) , .DATA_C (SUMMAND[29]) , .SAVE (INT_SUM[18]) , .CARRY (INT_CARRY[15]) );
   FULL_ADDER FA_9 (.DATA_A (INT_SUM[17]) , .DATA_B (INT_SUM[18]) , .DATA_C (INT_CARRY[11]) , .SAVE (INT_SUM[19]) , .CARRY (INT_CARRY[16]) );
   HALF_ADDER HA_6 (.DATA_A (INT_SUM[19]) , .DATA_B (INT_CARRY[12]) , .SAVE (INT_SUM[20]) , .CARRY (INT_CARRY[13]) );
   FLIPFLOP LA_15 (.DIN (INT_SUM[20]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[8]) );
   FLIPFLOP LA_16 (.DIN (INT_CARRY[13]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[8]) );
   FULL_ADDER FA_10 (.DATA_A (SUMMAND[30]) , .DATA_B (SUMMAND[31]) , .DATA_C (SUMMAND[32]) , .SAVE (INT_SUM[21]) , .CARRY (INT_CARRY[18]) );
   HALF_ADDER HA_7 (.DATA_A (SUMMAND[33]) , .DATA_B (SUMMAND[34]) , .SAVE (INT_SUM[22]) , .CARRY (INT_CARRY[19]) );
   FULL_ADDER FA_11 (.DATA_A (INT_SUM[21]) , .DATA_B (INT_SUM[22]) , .DATA_C (INT_CARRY[14]) , .SAVE (INT_SUM[23]) , .CARRY (INT_CARRY[20]) );
   assign INT_SUM[24] = INT_CARRY[15];
   FULL_ADDER FA_12 (.DATA_A (INT_SUM[23]) , .DATA_B (INT_SUM[24]) , .DATA_C (INT_CARRY[16]) , .SAVE (INT_SUM[25]) , .CARRY (INT_CARRY[17]) );
   FLIPFLOP LA_17 (.DIN (INT_SUM[25]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[9]) );
   FLIPFLOP LA_18 (.DIN (INT_CARRY[17]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[9]) );
   FULL_ADDER FA_13 (.DATA_A (SUMMAND[35]) , .DATA_B (SUMMAND[36]) , .DATA_C (SUMMAND[37]) , .SAVE (INT_SUM[26]) , .CARRY (INT_CARRY[22]) );
   FULL_ADDER FA_14 (.DATA_A (SUMMAND[38]) , .DATA_B (SUMMAND[39]) , .DATA_C (SUMMAND[40]) , .SAVE (INT_SUM[27]) , .CARRY (INT_CARRY[23]) );
   assign INT_SUM[28] = SUMMAND[41];
   FULL_ADDER FA_15 (.DATA_A (INT_SUM[26]) , .DATA_B (INT_SUM[27]) , .DATA_C (INT_SUM[28]) , .SAVE (INT_SUM[29]) , .CARRY (INT_CARRY[24]) );
   HALF_ADDER HA_8 (.DATA_A (INT_CARRY[18]) , .DATA_B (INT_CARRY[19]) , .SAVE (INT_SUM[30]) , .CARRY (INT_CARRY[25]) );
   FULL_ADDER FA_16 (.DATA_A (INT_SUM[29]) , .DATA_B (INT_SUM[30]) , .DATA_C (INT_CARRY[20]) , .SAVE (INT_SUM[31]) , .CARRY (INT_CARRY[21]) );
   FLIPFLOP LA_19 (.DIN (INT_SUM[31]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[10]) );
   FLIPFLOP LA_20 (.DIN (INT_CARRY[21]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[10]) );
   FULL_ADDER FA_17 (.DATA_A (SUMMAND[42]) , .DATA_B (SUMMAND[43]) , .DATA_C (SUMMAND[44]) , .SAVE (INT_SUM[32]) , .CARRY (INT_CARRY[27]) );
   FULL_ADDER FA_18 (.DATA_A (SUMMAND[45]) , .DATA_B (SUMMAND[46]) , .DATA_C (SUMMAND[47]) , .SAVE (INT_SUM[33]) , .CARRY (INT_CARRY[28]) );
   FULL_ADDER FA_19 (.DATA_A (INT_SUM[32]) , .DATA_B (INT_SUM[33]) , .DATA_C (INT_CARRY[22]) , .SAVE (INT_SUM[34]) , .CARRY (INT_CARRY[29]) );
   assign INT_SUM[35] = INT_CARRY[23];
   FULL_ADDER FA_20 (.DATA_A (INT_SUM[34]) , .DATA_B (INT_SUM[35]) , .DATA_C (INT_CARRY[24]) , .SAVE (INT_SUM[36]) , .CARRY (INT_CARRY[30]) );
   assign INT_SUM[37] = INT_CARRY[25];
   HALF_ADDER HA_9 (.DATA_A (INT_SUM[36]) , .DATA_B (INT_SUM[37]) , .SAVE (INT_SUM[38]) , .CARRY (INT_CARRY[26]) );
   FLIPFLOP LA_21 (.DIN (INT_SUM[38]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[11]) );
   FLIPFLOP LA_22 (.DIN (INT_CARRY[26]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[11]) );
   FULL_ADDER FA_21 (.DATA_A (SUMMAND[48]) , .DATA_B (SUMMAND[49]) , .DATA_C (SUMMAND[50]) , .SAVE (INT_SUM[39]) , .CARRY (INT_CARRY[32]) );
   FULL_ADDER FA_22 (.DATA_A (SUMMAND[51]) , .DATA_B (SUMMAND[52]) , .DATA_C (SUMMAND[53]) , .SAVE (INT_SUM[40]) , .CARRY (INT_CARRY[33]) );
   assign INT_SUM[41] = SUMMAND[54];
   assign INT_SUM[42] = SUMMAND[55];
   FULL_ADDER FA_23 (.DATA_A (INT_SUM[39]) , .DATA_B (INT_SUM[40]) , .DATA_C (INT_SUM[41]) , .SAVE (INT_SUM[43]) , .CARRY (INT_CARRY[34]) );
   FULL_ADDER FA_24 (.DATA_A (INT_SUM[42]) , .DATA_B (INT_CARRY[27]) , .DATA_C (INT_CARRY[28]) , .SAVE (INT_SUM[44]) , .CARRY (INT_CARRY[35]) );
   FULL_ADDER FA_25 (.DATA_A (INT_SUM[43]) , .DATA_B (INT_SUM[44]) , .DATA_C (INT_CARRY[29]) , .SAVE (INT_SUM[45]) , .CARRY (INT_CARRY[36]) );
   HALF_ADDER HA_10 (.DATA_A (INT_SUM[45]) , .DATA_B (INT_CARRY[30]) , .SAVE (INT_SUM[46]) , .CARRY (INT_CARRY[31]) );
   FLIPFLOP LA_23 (.DIN (INT_SUM[46]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[12]) );
   FLIPFLOP LA_24 (.DIN (INT_CARRY[31]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[12]) );
   FULL_ADDER FA_26 (.DATA_A (SUMMAND[56]) , .DATA_B (SUMMAND[57]) , .DATA_C (SUMMAND[58]) , .SAVE (INT_SUM[47]) , .CARRY (INT_CARRY[38]) );
   FULL_ADDER FA_27 (.DATA_A (SUMMAND[59]) , .DATA_B (SUMMAND[60]) , .DATA_C (SUMMAND[61]) , .SAVE (INT_SUM[48]) , .CARRY (INT_CARRY[39]) );
   assign INT_SUM[49] = SUMMAND[62];
   FULL_ADDER FA_28 (.DATA_A (INT_SUM[47]) , .DATA_B (INT_SUM[48]) , .DATA_C (INT_SUM[49]) , .SAVE (INT_SUM[50]) , .CARRY (INT_CARRY[40]) );
   HALF_ADDER HA_11 (.DATA_A (INT_CARRY[32]) , .DATA_B (INT_CARRY[33]) , .SAVE (INT_SUM[51]) , .CARRY (INT_CARRY[41]) );
   FULL_ADDER FA_29 (.DATA_A (INT_SUM[50]) , .DATA_B (INT_SUM[51]) , .DATA_C (INT_CARRY[34]) , .SAVE (INT_SUM[52]) , .CARRY (INT_CARRY[42]) );
   assign INT_SUM[53] = INT_CARRY[35];
   FULL_ADDER FA_30 (.DATA_A (INT_SUM[52]) , .DATA_B (INT_SUM[53]) , .DATA_C (INT_CARRY[36]) , .SAVE (INT_SUM[54]) , .CARRY (INT_CARRY[37]) );
   FLIPFLOP LA_25 (.DIN (INT_SUM[54]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[13]) );
   FLIPFLOP LA_26 (.DIN (INT_CARRY[37]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[13]) );
   FULL_ADDER FA_31 (.DATA_A (SUMMAND[63]) , .DATA_B (SUMMAND[64]) , .DATA_C (SUMMAND[65]) , .SAVE (INT_SUM[55]) , .CARRY (INT_CARRY[44]) );
   FULL_ADDER FA_32 (.DATA_A (SUMMAND[66]) , .DATA_B (SUMMAND[67]) , .DATA_C (SUMMAND[68]) , .SAVE (INT_SUM[56]) , .CARRY (INT_CARRY[45]) );
   FULL_ADDER FA_33 (.DATA_A (SUMMAND[69]) , .DATA_B (SUMMAND[70]) , .DATA_C (SUMMAND[71]) , .SAVE (INT_SUM[57]) , .CARRY (INT_CARRY[46]) );
   FULL_ADDER FA_34 (.DATA_A (INT_SUM[55]) , .DATA_B (INT_SUM[56]) , .DATA_C (INT_SUM[57]) , .SAVE (INT_SUM[58]) , .CARRY (INT_CARRY[47]) );
   HALF_ADDER HA_12 (.DATA_A (INT_CARRY[38]) , .DATA_B (INT_CARRY[39]) , .SAVE (INT_SUM[59]) , .CARRY (INT_CARRY[48]) );
   FULL_ADDER FA_35 (.DATA_A (INT_SUM[58]) , .DATA_B (INT_SUM[59]) , .DATA_C (INT_CARRY[40]) , .SAVE (INT_SUM[60]) , .CARRY (INT_CARRY[49]) );
   assign INT_SUM[61] = INT_CARRY[41];
   FULL_ADDER FA_36 (.DATA_A (INT_SUM[60]) , .DATA_B (INT_SUM[61]) , .DATA_C (INT_CARRY[42]) , .SAVE (INT_SUM[62]) , .CARRY (INT_CARRY[43]) );
   FLIPFLOP LA_27 (.DIN (INT_SUM[62]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[14]) );
   FLIPFLOP LA_28 (.DIN (INT_CARRY[43]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[14]) );
   FULL_ADDER FA_37 (.DATA_A (SUMMAND[72]) , .DATA_B (SUMMAND[73]) , .DATA_C (SUMMAND[74]) , .SAVE (INT_SUM[63]) , .CARRY (INT_CARRY[51]) );
   FULL_ADDER FA_38 (.DATA_A (SUMMAND[75]) , .DATA_B (SUMMAND[76]) , .DATA_C (SUMMAND[77]) , .SAVE (INT_SUM[64]) , .CARRY (INT_CARRY[52]) );
   HALF_ADDER HA_13 (.DATA_A (SUMMAND[78]) , .DATA_B (SUMMAND[79]) , .SAVE (INT_SUM[65]) , .CARRY (INT_CARRY[53]) );
   FULL_ADDER FA_39 (.DATA_A (INT_SUM[63]) , .DATA_B (INT_SUM[64]) , .DATA_C (INT_SUM[65]) , .SAVE (INT_SUM[66]) , .CARRY (INT_CARRY[54]) );
   FULL_ADDER FA_40 (.DATA_A (INT_CARRY[44]) , .DATA_B (INT_CARRY[45]) , .DATA_C (INT_CARRY[46]) , .SAVE (INT_SUM[67]) , .CARRY (INT_CARRY[55]) );
   FULL_ADDER FA_41 (.DATA_A (INT_SUM[66]) , .DATA_B (INT_SUM[67]) , .DATA_C (INT_CARRY[47]) , .SAVE (INT_SUM[68]) , .CARRY (INT_CARRY[56]) );
   assign INT_SUM[69] = INT_CARRY[48];
   FULL_ADDER FA_42 (.DATA_A (INT_SUM[68]) , .DATA_B (INT_SUM[69]) , .DATA_C (INT_CARRY[49]) , .SAVE (INT_SUM[70]) , .CARRY (INT_CARRY[50]) );
   FLIPFLOP LA_29 (.DIN (INT_SUM[70]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[15]) );
   FLIPFLOP LA_30 (.DIN (INT_CARRY[50]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[15]) );
   FULL_ADDER FA_43 (.DATA_A (SUMMAND[80]) , .DATA_B (SUMMAND[81]) , .DATA_C (SUMMAND[82]) , .SAVE (INT_SUM[71]) , .CARRY (INT_CARRY[58]) );
   FULL_ADDER FA_44 (.DATA_A (SUMMAND[83]) , .DATA_B (SUMMAND[84]) , .DATA_C (SUMMAND[85]) , .SAVE (INT_SUM[72]) , .CARRY (INT_CARRY[59]) );
   FULL_ADDER FA_45 (.DATA_A (SUMMAND[86]) , .DATA_B (SUMMAND[87]) , .DATA_C (SUMMAND[88]) , .SAVE (INT_SUM[73]) , .CARRY (INT_CARRY[60]) );
   assign INT_SUM[74] = SUMMAND[89];
   FULL_ADDER FA_46 (.DATA_A (INT_SUM[71]) , .DATA_B (INT_SUM[72]) , .DATA_C (INT_SUM[73]) , .SAVE (INT_SUM[75]) , .CARRY (INT_CARRY[61]) );
   FULL_ADDER FA_47 (.DATA_A (INT_SUM[74]) , .DATA_B (INT_CARRY[51]) , .DATA_C (INT_CARRY[52]) , .SAVE (INT_SUM[76]) , .CARRY (INT_CARRY[62]) );
   assign INT_SUM[77] = INT_CARRY[53];
   FULL_ADDER FA_48 (.DATA_A (INT_SUM[75]) , .DATA_B (INT_SUM[76]) , .DATA_C (INT_SUM[77]) , .SAVE (INT_SUM[78]) , .CARRY (INT_CARRY[63]) );
   HALF_ADDER HA_14 (.DATA_A (INT_CARRY[54]) , .DATA_B (INT_CARRY[55]) , .SAVE (INT_SUM[79]) , .CARRY (INT_CARRY[64]) );
   FULL_ADDER FA_49 (.DATA_A (INT_SUM[78]) , .DATA_B (INT_SUM[79]) , .DATA_C (INT_CARRY[56]) , .SAVE (INT_SUM[80]) , .CARRY (INT_CARRY[57]) );
   FLIPFLOP LA_31 (.DIN (INT_SUM[80]) , .RST(RST), .CLK (CLK) , .DOUT (SUM[16]) );
   FLIPFLOP LA_32 (.DIN (INT_CARRY[57]) , .RST(RST), .CLK (CLK) , .DOUT (CARRY[16]) );
   FULL_ADDER FA_50 (.DATA_A (SUMMAND[90]) , .DATA_B (SUMMAND[91]) , .DATA_C (SUMMAND[92]) , .SAVE (INT_SUM[81]) , .CARRY (INT_CARRY[65]) );
   FULL_ADDER FA_51 (.DATA_A (SUMMAND[93]) , .DATA_B (SUMMAND[94]) , .DATA_C (SUMMAND[95]) , .SAVE (INT_SUM[82]) , .CARRY (INT_CARRY[66]) );
   FULL_ADDER FA_52 (.DATA_A (SUMMAND[96]) , .DATA_B (SUMMAND[97]) , .DATA_C (SUMMAND[98]) , .SAVE (INT_SUM[83]) , .CARRY (INT_CARRY[67]) );
   FULL_ADDER FA_53 (.DATA_A (INT_SUM[81]) , .DATA_B (INT_SUM[82]) , .DATA_C (INT_SUM[83]) , .SAVE (INT_SUM[84]) , .CARRY (INT_CARRY[68]) );
   FULL_ADDER FA_54 (.DATA_A (INT_CARRY[58]) , .DATA_B (INT_CARRY[59]) , .DATA_C (INT_CARRY[60]) , .SAVE (INT_SUM[85]) , .CARRY (INT_CARRY[69]) );
   FULL_ADDER FA_55 (.DATA_A (INT_SUM[84]) , .DATA_B (INT_SUM[85]) , .DATA_C (INT_CARRY[61]) , .SAVE (INT_SUM[86]) , .CARRY (INT_CARRY[70]) );
   assign INT_SUM[87] = INT_CARRY[62];
   FULL_ADDER FA_56 (.DATA_A (INT_SUM[86]) , .DATA_B (INT_SUM[87]) , .DATA_C (INT_CARRY[63]) , .SAVE (INT_SUM[88]) , .CARRY (INT_CARRY[71]) );
   assign INT_SUM[90] = INT_CARRY[64];
   FLIPFLOP LA_33 (.DIN (INT_SUM[88]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[89]) );
   FLIPFLOP LA_34 (.DIN (INT_SUM[90]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[91]) );
   HALF_ADDER HA_15 (.DATA_A (INT_SUM[89]) , .DATA_B (INT_SUM[91]) , .SAVE (SUM[17]) , .CARRY (CARRY[17]) );
   FULL_ADDER FA_57 (.DATA_A (SUMMAND[99]) , .DATA_B (SUMMAND[100]) , .DATA_C (SUMMAND[101]) , .SAVE (INT_SUM[92]) , .CARRY (INT_CARRY[73]) );
   FULL_ADDER FA_58 (.DATA_A (SUMMAND[102]) , .DATA_B (SUMMAND[103]) , .DATA_C (SUMMAND[104]) , .SAVE (INT_SUM[93]) , .CARRY (INT_CARRY[74]) );
   FULL_ADDER FA_59 (.DATA_A (SUMMAND[105]) , .DATA_B (SUMMAND[106]) , .DATA_C (SUMMAND[107]) , .SAVE (INT_SUM[94]) , .CARRY (INT_CARRY[75]) );
   assign INT_SUM[95] = SUMMAND[108];
   assign INT_SUM[96] = SUMMAND[109];
   FULL_ADDER FA_60 (.DATA_A (INT_SUM[92]) , .DATA_B (INT_SUM[93]) , .DATA_C (INT_SUM[94]) , .SAVE (INT_SUM[97]) , .CARRY (INT_CARRY[76]) );
   FULL_ADDER FA_61 (.DATA_A (INT_SUM[95]) , .DATA_B (INT_SUM[96]) , .DATA_C (INT_CARRY[65]) , .SAVE (INT_SUM[98]) , .CARRY (INT_CARRY[77]) );
   assign INT_SUM[99] = INT_CARRY[66];
   assign INT_SUM[100] = INT_CARRY[67];
   FULL_ADDER FA_62 (.DATA_A (INT_SUM[97]) , .DATA_B (INT_SUM[98]) , .DATA_C (INT_SUM[99]) , .SAVE (INT_SUM[101]) , .CARRY (INT_CARRY[78]) );
   FULL_ADDER FA_63 (.DATA_A (INT_SUM[100]) , .DATA_B (INT_CARRY[68]) , .DATA_C (INT_CARRY[69]) , .SAVE (INT_SUM[102]) , .CARRY (INT_CARRY[79]) );
   FULL_ADDER FA_64 (.DATA_A (INT_SUM[101]) , .DATA_B (INT_SUM[102]) , .DATA_C (INT_CARRY[70]) , .SAVE (INT_SUM[103]) , .CARRY (INT_CARRY[80]) );
   FLIPFLOP LA_35 (.DIN (INT_SUM[103]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[104]) );
   FLIPFLOP LA_36 (.DIN (INT_CARRY[71]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[72]) );
   HALF_ADDER HA_16 (.DATA_A (INT_SUM[104]) , .DATA_B (INT_CARRY[72]) , .SAVE (SUM[18]) , .CARRY (CARRY[18]) );
   FULL_ADDER FA_65 (.DATA_A (SUMMAND[110]) , .DATA_B (SUMMAND[111]) , .DATA_C (SUMMAND[112]) , .SAVE (INT_SUM[105]) , .CARRY (INT_CARRY[82]) );
   FULL_ADDER FA_66 (.DATA_A (SUMMAND[113]) , .DATA_B (SUMMAND[114]) , .DATA_C (SUMMAND[115]) , .SAVE (INT_SUM[106]) , .CARRY (INT_CARRY[83]) );
   FULL_ADDER FA_67 (.DATA_A (SUMMAND[116]) , .DATA_B (SUMMAND[117]) , .DATA_C (SUMMAND[118]) , .SAVE (INT_SUM[107]) , .CARRY (INT_CARRY[84]) );
   assign INT_SUM[108] = SUMMAND[119];
   FULL_ADDER FA_68 (.DATA_A (INT_SUM[105]) , .DATA_B (INT_SUM[106]) , .DATA_C (INT_SUM[107]) , .SAVE (INT_SUM[109]) , .CARRY (INT_CARRY[85]) );
   FULL_ADDER FA_69 (.DATA_A (INT_SUM[108]) , .DATA_B (INT_CARRY[73]) , .DATA_C (INT_CARRY[74]) , .SAVE (INT_SUM[110]) , .CARRY (INT_CARRY[86]) );
   assign INT_SUM[111] = INT_CARRY[75];
   FULL_ADDER FA_70 (.DATA_A (INT_SUM[109]) , .DATA_B (INT_SUM[110]) , .DATA_C (INT_SUM[111]) , .SAVE (INT_SUM[112]) , .CARRY (INT_CARRY[87]) );
   HALF_ADDER HA_17 (.DATA_A (INT_CARRY[76]) , .DATA_B (INT_CARRY[77]) , .SAVE (INT_SUM[113]) , .CARRY (INT_CARRY[88]) );
   FULL_ADDER FA_71 (.DATA_A (INT_SUM[112]) , .DATA_B (INT_SUM[113]) , .DATA_C (INT_CARRY[78]) , .SAVE (INT_SUM[114]) , .CARRY (INT_CARRY[89]) );
   assign INT_SUM[116] = INT_CARRY[79];
   FLIPFLOP LA_37 (.DIN (INT_SUM[114]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[115]) );
   FLIPFLOP LA_38 (.DIN (INT_SUM[116]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[117]) );
   FLIPFLOP LA_39 (.DIN (INT_CARRY[80]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[81]) );
   FULL_ADDER FA_72 (.DATA_A (INT_SUM[115]) , .DATA_B (INT_SUM[117]) , .DATA_C (INT_CARRY[81]) , .SAVE (SUM[19]) , .CARRY (CARRY[19]) );
   FULL_ADDER FA_73 (.DATA_A (SUMMAND[120]) , .DATA_B (SUMMAND[121]) , .DATA_C (SUMMAND[122]) , .SAVE (INT_SUM[118]) , .CARRY (INT_CARRY[91]) );
   FULL_ADDER FA_74 (.DATA_A (SUMMAND[123]) , .DATA_B (SUMMAND[124]) , .DATA_C (SUMMAND[125]) , .SAVE (INT_SUM[119]) , .CARRY (INT_CARRY[92]) );
   FULL_ADDER FA_75 (.DATA_A (SUMMAND[126]) , .DATA_B (SUMMAND[127]) , .DATA_C (SUMMAND[128]) , .SAVE (INT_SUM[120]) , .CARRY (INT_CARRY[93]) );
   FULL_ADDER FA_76 (.DATA_A (SUMMAND[129]) , .DATA_B (SUMMAND[130]) , .DATA_C (SUMMAND[131]) , .SAVE (INT_SUM[121]) , .CARRY (INT_CARRY[94]) );
   FULL_ADDER FA_77 (.DATA_A (INT_SUM[118]) , .DATA_B (INT_SUM[119]) , .DATA_C (INT_SUM[120]) , .SAVE (INT_SUM[122]) , .CARRY (INT_CARRY[95]) );
   FULL_ADDER FA_78 (.DATA_A (INT_SUM[121]) , .DATA_B (INT_CARRY[82]) , .DATA_C (INT_CARRY[83]) , .SAVE (INT_SUM[123]) , .CARRY (INT_CARRY[96]) );
   assign INT_SUM[124] = INT_CARRY[84];
   FULL_ADDER FA_79 (.DATA_A (INT_SUM[122]) , .DATA_B (INT_SUM[123]) , .DATA_C (INT_SUM[124]) , .SAVE (INT_SUM[125]) , .CARRY (INT_CARRY[97]) );
   HALF_ADDER HA_18 (.DATA_A (INT_CARRY[85]) , .DATA_B (INT_CARRY[86]) , .SAVE (INT_SUM[126]) , .CARRY (INT_CARRY[98]) );
   FULL_ADDER FA_80 (.DATA_A (INT_SUM[125]) , .DATA_B (INT_SUM[126]) , .DATA_C (INT_CARRY[87]) , .SAVE (INT_SUM[127]) , .CARRY (INT_CARRY[99]) );
   assign INT_SUM[129] = INT_CARRY[88];
   FLIPFLOP LA_40 (.DIN (INT_SUM[127]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[128]) );
   FLIPFLOP LA_41 (.DIN (INT_SUM[129]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[130]) );
   FLIPFLOP LA_42 (.DIN (INT_CARRY[89]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[90]) );
   FULL_ADDER FA_81 (.DATA_A (INT_SUM[128]) , .DATA_B (INT_SUM[130]) , .DATA_C (INT_CARRY[90]) , .SAVE (SUM[20]) , .CARRY (CARRY[20]) );
   FULL_ADDER FA_82 (.DATA_A (SUMMAND[132]) , .DATA_B (SUMMAND[133]) , .DATA_C (SUMMAND[134]) , .SAVE (INT_SUM[131]) , .CARRY (INT_CARRY[101]) );
   FULL_ADDER FA_83 (.DATA_A (SUMMAND[135]) , .DATA_B (SUMMAND[136]) , .DATA_C (SUMMAND[137]) , .SAVE (INT_SUM[132]) , .CARRY (INT_CARRY[102]) );
   FULL_ADDER FA_84 (.DATA_A (SUMMAND[138]) , .DATA_B (SUMMAND[139]) , .DATA_C (SUMMAND[140]) , .SAVE (INT_SUM[133]) , .CARRY (INT_CARRY[103]) );
   assign INT_SUM[134] = SUMMAND[141];
   assign INT_SUM[135] = SUMMAND[142];
   FULL_ADDER FA_85 (.DATA_A (INT_SUM[131]) , .DATA_B (INT_SUM[132]) , .DATA_C (INT_SUM[133]) , .SAVE (INT_SUM[136]) , .CARRY (INT_CARRY[104]) );
   FULL_ADDER FA_86 (.DATA_A (INT_SUM[134]) , .DATA_B (INT_SUM[135]) , .DATA_C (INT_CARRY[91]) , .SAVE (INT_SUM[137]) , .CARRY (INT_CARRY[105]) );
   FULL_ADDER FA_87 (.DATA_A (INT_CARRY[92]) , .DATA_B (INT_CARRY[93]) , .DATA_C (INT_CARRY[94]) , .SAVE (INT_SUM[138]) , .CARRY (INT_CARRY[106]) );
   FULL_ADDER FA_88 (.DATA_A (INT_SUM[136]) , .DATA_B (INT_SUM[137]) , .DATA_C (INT_SUM[138]) , .SAVE (INT_SUM[139]) , .CARRY (INT_CARRY[107]) );
   HALF_ADDER HA_19 (.DATA_A (INT_CARRY[95]) , .DATA_B (INT_CARRY[96]) , .SAVE (INT_SUM[140]) , .CARRY (INT_CARRY[108]) );
   FULL_ADDER FA_89 (.DATA_A (INT_SUM[139]) , .DATA_B (INT_SUM[140]) , .DATA_C (INT_CARRY[97]) , .SAVE (INT_SUM[141]) , .CARRY (INT_CARRY[109]) );
   assign INT_SUM[143] = INT_CARRY[98];
   FLIPFLOP LA_43 (.DIN (INT_SUM[141]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[142]) );
   FLIPFLOP LA_44 (.DIN (INT_SUM[143]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[144]) );
   FLIPFLOP LA_45 (.DIN (INT_CARRY[99]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[100]) );
   FULL_ADDER FA_90 (.DATA_A (INT_SUM[142]) , .DATA_B (INT_SUM[144]) , .DATA_C (INT_CARRY[100]) , .SAVE (SUM[21]) , .CARRY (CARRY[21]) );
   FULL_ADDER FA_91 (.DATA_A (SUMMAND[143]) , .DATA_B (SUMMAND[144]) , .DATA_C (SUMMAND[145]) , .SAVE (INT_SUM[145]) , .CARRY (INT_CARRY[111]) );
   FULL_ADDER FA_92 (.DATA_A (SUMMAND[146]) , .DATA_B (SUMMAND[147]) , .DATA_C (SUMMAND[148]) , .SAVE (INT_SUM[146]) , .CARRY (INT_CARRY[112]) );
   FULL_ADDER FA_93 (.DATA_A (SUMMAND[149]) , .DATA_B (SUMMAND[150]) , .DATA_C (SUMMAND[151]) , .SAVE (INT_SUM[147]) , .CARRY (INT_CARRY[113]) );
   FULL_ADDER FA_94 (.DATA_A (SUMMAND[152]) , .DATA_B (SUMMAND[153]) , .DATA_C (SUMMAND[154]) , .SAVE (INT_SUM[148]) , .CARRY (INT_CARRY[114]) );
   assign INT_SUM[149] = SUMMAND[155];
   FULL_ADDER FA_95 (.DATA_A (INT_SUM[145]) , .DATA_B (INT_SUM[146]) , .DATA_C (INT_SUM[147]) , .SAVE (INT_SUM[150]) , .CARRY (INT_CARRY[115]) );
   FULL_ADDER FA_96 (.DATA_A (INT_SUM[148]) , .DATA_B (INT_SUM[149]) , .DATA_C (INT_CARRY[101]) , .SAVE (INT_SUM[151]) , .CARRY (INT_CARRY[116]) );
   HALF_ADDER HA_20 (.DATA_A (INT_CARRY[102]) , .DATA_B (INT_CARRY[103]) , .SAVE (INT_SUM[152]) , .CARRY (INT_CARRY[117]) );
   FULL_ADDER FA_97 (.DATA_A (INT_SUM[150]) , .DATA_B (INT_SUM[151]) , .DATA_C (INT_SUM[152]) , .SAVE (INT_SUM[153]) , .CARRY (INT_CARRY[118]) );
   FULL_ADDER FA_98 (.DATA_A (INT_CARRY[104]) , .DATA_B (INT_CARRY[105]) , .DATA_C (INT_CARRY[106]) , .SAVE (INT_SUM[154]) , .CARRY (INT_CARRY[119]) );
   FULL_ADDER FA_99 (.DATA_A (INT_SUM[153]) , .DATA_B (INT_SUM[154]) , .DATA_C (INT_CARRY[107]) , .SAVE (INT_SUM[155]) , .CARRY (INT_CARRY[120]) );
   assign INT_SUM[157] = INT_CARRY[108];
   FLIPFLOP LA_46 (.DIN (INT_SUM[155]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[156]) );
   FLIPFLOP LA_47 (.DIN (INT_SUM[157]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[158]) );
   FLIPFLOP LA_48 (.DIN (INT_CARRY[109]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[110]) );
   FULL_ADDER FA_100 (.DATA_A (INT_SUM[156]) , .DATA_B (INT_SUM[158]) , .DATA_C (INT_CARRY[110]) , .SAVE (SUM[22]) , .CARRY (CARRY[22]) );
   FULL_ADDER FA_101 (.DATA_A (SUMMAND[156]) , .DATA_B (SUMMAND[157]) , .DATA_C (SUMMAND[158]) , .SAVE (INT_SUM[159]) , .CARRY (INT_CARRY[122]) );
   FULL_ADDER FA_102 (.DATA_A (SUMMAND[159]) , .DATA_B (SUMMAND[160]) , .DATA_C (SUMMAND[161]) , .SAVE (INT_SUM[160]) , .CARRY (INT_CARRY[123]) );
   FULL_ADDER FA_103 (.DATA_A (SUMMAND[162]) , .DATA_B (SUMMAND[163]) , .DATA_C (SUMMAND[164]) , .SAVE (INT_SUM[161]) , .CARRY (INT_CARRY[124]) );
   FULL_ADDER FA_104 (.DATA_A (SUMMAND[165]) , .DATA_B (SUMMAND[166]) , .DATA_C (SUMMAND[167]) , .SAVE (INT_SUM[162]) , .CARRY (INT_CARRY[125]) );
   FULL_ADDER FA_105 (.DATA_A (INT_SUM[159]) , .DATA_B (INT_SUM[160]) , .DATA_C (INT_SUM[161]) , .SAVE (INT_SUM[163]) , .CARRY (INT_CARRY[126]) );
   FULL_ADDER FA_106 (.DATA_A (INT_SUM[162]) , .DATA_B (INT_CARRY[111]) , .DATA_C (INT_CARRY[112]) , .SAVE (INT_SUM[164]) , .CARRY (INT_CARRY[127]) );
   HALF_ADDER HA_21 (.DATA_A (INT_CARRY[113]) , .DATA_B (INT_CARRY[114]) , .SAVE (INT_SUM[165]) , .CARRY (INT_CARRY[128]) );
   FULL_ADDER FA_107 (.DATA_A (INT_SUM[163]) , .DATA_B (INT_SUM[164]) , .DATA_C (INT_SUM[165]) , .SAVE (INT_SUM[166]) , .CARRY (INT_CARRY[129]) );
   FULL_ADDER FA_108 (.DATA_A (INT_CARRY[115]) , .DATA_B (INT_CARRY[116]) , .DATA_C (INT_CARRY[117]) , .SAVE (INT_SUM[167]) , .CARRY (INT_CARRY[130]) );
   FULL_ADDER FA_109 (.DATA_A (INT_SUM[166]) , .DATA_B (INT_SUM[167]) , .DATA_C (INT_CARRY[118]) , .SAVE (INT_SUM[168]) , .CARRY (INT_CARRY[131]) );
   assign INT_SUM[170] = INT_CARRY[119];
   FLIPFLOP LA_49 (.DIN (INT_SUM[168]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[169]) );
   FLIPFLOP LA_50 (.DIN (INT_SUM[170]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[171]) );
   FLIPFLOP LA_51 (.DIN (INT_CARRY[120]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[121]) );
   FULL_ADDER FA_110 (.DATA_A (INT_SUM[169]) , .DATA_B (INT_SUM[171]) , .DATA_C (INT_CARRY[121]) , .SAVE (SUM[23]) , .CARRY (CARRY[23]) );
   FULL_ADDER FA_111 (.DATA_A (SUMMAND[168]) , .DATA_B (SUMMAND[169]) , .DATA_C (SUMMAND[170]) , .SAVE (INT_SUM[172]) , .CARRY (INT_CARRY[133]) );
   FULL_ADDER FA_112 (.DATA_A (SUMMAND[171]) , .DATA_B (SUMMAND[172]) , .DATA_C (SUMMAND[173]) , .SAVE (INT_SUM[173]) , .CARRY (INT_CARRY[134]) );
   FULL_ADDER FA_113 (.DATA_A (SUMMAND[174]) , .DATA_B (SUMMAND[175]) , .DATA_C (SUMMAND[176]) , .SAVE (INT_SUM[174]) , .CARRY (INT_CARRY[135]) );
   FULL_ADDER FA_114 (.DATA_A (SUMMAND[177]) , .DATA_B (SUMMAND[178]) , .DATA_C (SUMMAND[179]) , .SAVE (INT_SUM[175]) , .CARRY (INT_CARRY[136]) );
   HALF_ADDER HA_22 (.DATA_A (SUMMAND[180]) , .DATA_B (SUMMAND[181]) , .SAVE (INT_SUM[176]) , .CARRY (INT_CARRY[137]) );
   FULL_ADDER FA_115 (.DATA_A (INT_SUM[172]) , .DATA_B (INT_SUM[173]) , .DATA_C (INT_SUM[174]) , .SAVE (INT_SUM[177]) , .CARRY (INT_CARRY[138]) );
   FULL_ADDER FA_116 (.DATA_A (INT_SUM[175]) , .DATA_B (INT_SUM[176]) , .DATA_C (INT_CARRY[122]) , .SAVE (INT_SUM[178]) , .CARRY (INT_CARRY[139]) );
   FULL_ADDER FA_117 (.DATA_A (INT_CARRY[123]) , .DATA_B (INT_CARRY[124]) , .DATA_C (INT_CARRY[125]) , .SAVE (INT_SUM[179]) , .CARRY (INT_CARRY[140]) );
   FULL_ADDER FA_118 (.DATA_A (INT_SUM[177]) , .DATA_B (INT_SUM[178]) , .DATA_C (INT_SUM[179]) , .SAVE (INT_SUM[180]) , .CARRY (INT_CARRY[141]) );
   FULL_ADDER FA_119 (.DATA_A (INT_CARRY[126]) , .DATA_B (INT_CARRY[127]) , .DATA_C (INT_CARRY[128]) , .SAVE (INT_SUM[181]) , .CARRY (INT_CARRY[142]) );
   FULL_ADDER FA_120 (.DATA_A (INT_SUM[180]) , .DATA_B (INT_SUM[181]) , .DATA_C (INT_CARRY[129]) , .SAVE (INT_SUM[182]) , .CARRY (INT_CARRY[143]) );
   assign INT_SUM[184] = INT_CARRY[130];
   FLIPFLOP LA_52 (.DIN (INT_SUM[182]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[183]) );
   FLIPFLOP LA_53 (.DIN (INT_SUM[184]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[185]) );
   FLIPFLOP LA_54 (.DIN (INT_CARRY[131]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[132]) );
   FULL_ADDER FA_121 (.DATA_A (INT_SUM[183]) , .DATA_B (INT_SUM[185]) , .DATA_C (INT_CARRY[132]) , .SAVE (SUM[24]) , .CARRY (CARRY[24]) );
   FULL_ADDER FA_122 (.DATA_A (SUMMAND[182]) , .DATA_B (SUMMAND[183]) , .DATA_C (SUMMAND[184]) , .SAVE (INT_SUM[186]) , .CARRY (INT_CARRY[145]) );
   FULL_ADDER FA_123 (.DATA_A (SUMMAND[185]) , .DATA_B (SUMMAND[186]) , .DATA_C (SUMMAND[187]) , .SAVE (INT_SUM[187]) , .CARRY (INT_CARRY[146]) );
   FULL_ADDER FA_124 (.DATA_A (SUMMAND[188]) , .DATA_B (SUMMAND[189]) , .DATA_C (SUMMAND[190]) , .SAVE (INT_SUM[188]) , .CARRY (INT_CARRY[147]) );
   FULL_ADDER FA_125 (.DATA_A (SUMMAND[191]) , .DATA_B (SUMMAND[192]) , .DATA_C (SUMMAND[193]) , .SAVE (INT_SUM[189]) , .CARRY (INT_CARRY[148]) );
   assign INT_SUM[190] = SUMMAND[194];
   FULL_ADDER FA_126 (.DATA_A (INT_SUM[186]) , .DATA_B (INT_SUM[187]) , .DATA_C (INT_SUM[188]) , .SAVE (INT_SUM[191]) , .CARRY (INT_CARRY[149]) );
   FULL_ADDER FA_127 (.DATA_A (INT_SUM[189]) , .DATA_B (INT_SUM[190]) , .DATA_C (INT_CARRY[133]) , .SAVE (INT_SUM[192]) , .CARRY (INT_CARRY[150]) );
   FULL_ADDER FA_128 (.DATA_A (INT_CARRY[134]) , .DATA_B (INT_CARRY[135]) , .DATA_C (INT_CARRY[136]) , .SAVE (INT_SUM[193]) , .CARRY (INT_CARRY[151]) );
   assign INT_SUM[194] = INT_CARRY[137];
   FULL_ADDER FA_129 (.DATA_A (INT_SUM[191]) , .DATA_B (INT_SUM[192]) , .DATA_C (INT_SUM[193]) , .SAVE (INT_SUM[195]) , .CARRY (INT_CARRY[152]) );
   FULL_ADDER FA_130 (.DATA_A (INT_SUM[194]) , .DATA_B (INT_CARRY[138]) , .DATA_C (INT_CARRY[139]) , .SAVE (INT_SUM[196]) , .CARRY (INT_CARRY[153]) );
   assign INT_SUM[197] = INT_CARRY[140];
   FULL_ADDER FA_131 (.DATA_A (INT_SUM[195]) , .DATA_B (INT_SUM[196]) , .DATA_C (INT_SUM[197]) , .SAVE (INT_SUM[198]) , .CARRY (INT_CARRY[154]) );
   HALF_ADDER HA_23 (.DATA_A (INT_CARRY[141]) , .DATA_B (INT_CARRY[142]) , .SAVE (INT_SUM[200]) , .CARRY (INT_CARRY[156]) );
   FLIPFLOP LA_55 (.DIN (INT_SUM[198]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[199]) );
   FLIPFLOP LA_56 (.DIN (INT_SUM[200]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[201]) );
   FLIPFLOP LA_57 (.DIN (INT_CARRY[143]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[144]) );
   FULL_ADDER FA_132 (.DATA_A (INT_SUM[199]) , .DATA_B (INT_SUM[201]) , .DATA_C (INT_CARRY[144]) , .SAVE (SUM[25]) , .CARRY (CARRY[25]) );
   FULL_ADDER FA_133 (.DATA_A (SUMMAND[195]) , .DATA_B (SUMMAND[196]) , .DATA_C (SUMMAND[197]) , .SAVE (INT_SUM[202]) , .CARRY (INT_CARRY[158]) );
   FULL_ADDER FA_134 (.DATA_A (SUMMAND[198]) , .DATA_B (SUMMAND[199]) , .DATA_C (SUMMAND[200]) , .SAVE (INT_SUM[203]) , .CARRY (INT_CARRY[159]) );
   FULL_ADDER FA_135 (.DATA_A (SUMMAND[201]) , .DATA_B (SUMMAND[202]) , .DATA_C (SUMMAND[203]) , .SAVE (INT_SUM[204]) , .CARRY (INT_CARRY[160]) );
   FULL_ADDER FA_136 (.DATA_A (SUMMAND[204]) , .DATA_B (SUMMAND[205]) , .DATA_C (SUMMAND[206]) , .SAVE (INT_SUM[205]) , .CARRY (INT_CARRY[161]) );
   FULL_ADDER FA_137 (.DATA_A (SUMMAND[207]) , .DATA_B (SUMMAND[208]) , .DATA_C (SUMMAND[209]) , .SAVE (INT_SUM[206]) , .CARRY (INT_CARRY[162]) );
   FULL_ADDER FA_138 (.DATA_A (INT_SUM[202]) , .DATA_B (INT_SUM[203]) , .DATA_C (INT_SUM[204]) , .SAVE (INT_SUM[207]) , .CARRY (INT_CARRY[163]) );
   FULL_ADDER FA_139 (.DATA_A (INT_SUM[205]) , .DATA_B (INT_SUM[206]) , .DATA_C (INT_CARRY[145]) , .SAVE (INT_SUM[208]) , .CARRY (INT_CARRY[164]) );
   FULL_ADDER FA_140 (.DATA_A (INT_CARRY[146]) , .DATA_B (INT_CARRY[147]) , .DATA_C (INT_CARRY[148]) , .SAVE (INT_SUM[209]) , .CARRY (INT_CARRY[165]) );
   FULL_ADDER FA_141 (.DATA_A (INT_SUM[207]) , .DATA_B (INT_SUM[208]) , .DATA_C (INT_SUM[209]) , .SAVE (INT_SUM[210]) , .CARRY (INT_CARRY[166]) );
   FULL_ADDER FA_142 (.DATA_A (INT_CARRY[149]) , .DATA_B (INT_CARRY[150]) , .DATA_C (INT_CARRY[151]) , .SAVE (INT_SUM[211]) , .CARRY (INT_CARRY[167]) );
   FULL_ADDER FA_143 (.DATA_A (INT_SUM[210]) , .DATA_B (INT_SUM[211]) , .DATA_C (INT_CARRY[152]) , .SAVE (INT_SUM[212]) , .CARRY (INT_CARRY[168]) );
   assign INT_SUM[214] = INT_CARRY[153];
   FLIPFLOP LA_58 (.DIN (INT_SUM[212]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[213]) );
   FLIPFLOP LA_59 (.DIN (INT_SUM[214]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[215]) );
   FLIPFLOP LA_60 (.DIN (INT_CARRY[154]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[155]) );
   FULL_ADDER FA_144 (.DATA_A (INT_SUM[213]) , .DATA_B (INT_SUM[215]) , .DATA_C (INT_CARRY[155]) , .SAVE (INT_SUM[216]) , .CARRY (INT_CARRY[170]) );
   FLIPFLOP LA_61 (.DIN (INT_CARRY[156]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[157]) );
   assign INT_SUM[217] = INT_CARRY[157];
   HALF_ADDER HA_24 (.DATA_A (INT_SUM[216]) , .DATA_B (INT_SUM[217]) , .SAVE (SUM[26]) , .CARRY (CARRY[26]) );
   FULL_ADDER FA_145 (.DATA_A (SUMMAND[210]) , .DATA_B (SUMMAND[211]) , .DATA_C (SUMMAND[212]) , .SAVE (INT_SUM[218]) , .CARRY (INT_CARRY[171]) );
   FULL_ADDER FA_146 (.DATA_A (SUMMAND[213]) , .DATA_B (SUMMAND[214]) , .DATA_C (SUMMAND[215]) , .SAVE (INT_SUM[219]) , .CARRY (INT_CARRY[172]) );
   FULL_ADDER FA_147 (.DATA_A (SUMMAND[216]) , .DATA_B (SUMMAND[217]) , .DATA_C (SUMMAND[218]) , .SAVE (INT_SUM[220]) , .CARRY (INT_CARRY[173]) );
   FULL_ADDER FA_148 (.DATA_A (SUMMAND[219]) , .DATA_B (SUMMAND[220]) , .DATA_C (SUMMAND[221]) , .SAVE (INT_SUM[221]) , .CARRY (INT_CARRY[174]) );
   HALF_ADDER HA_25 (.DATA_A (SUMMAND[222]) , .DATA_B (SUMMAND[223]) , .SAVE (INT_SUM[222]) , .CARRY (INT_CARRY[175]) );
   FULL_ADDER FA_149 (.DATA_A (INT_SUM[218]) , .DATA_B (INT_SUM[219]) , .DATA_C (INT_SUM[220]) , .SAVE (INT_SUM[223]) , .CARRY (INT_CARRY[176]) );
   FULL_ADDER FA_150 (.DATA_A (INT_SUM[221]) , .DATA_B (INT_SUM[222]) , .DATA_C (INT_CARRY[158]) , .SAVE (INT_SUM[224]) , .CARRY (INT_CARRY[177]) );
   FULL_ADDER FA_151 (.DATA_A (INT_CARRY[159]) , .DATA_B (INT_CARRY[160]) , .DATA_C (INT_CARRY[161]) , .SAVE (INT_SUM[225]) , .CARRY (INT_CARRY[178]) );
   assign INT_SUM[226] = INT_CARRY[162];
   FULL_ADDER FA_152 (.DATA_A (INT_SUM[223]) , .DATA_B (INT_SUM[224]) , .DATA_C (INT_SUM[225]) , .SAVE (INT_SUM[227]) , .CARRY (INT_CARRY[179]) );
   FULL_ADDER FA_153 (.DATA_A (INT_SUM[226]) , .DATA_B (INT_CARRY[163]) , .DATA_C (INT_CARRY[164]) , .SAVE (INT_SUM[228]) , .CARRY (INT_CARRY[180]) );
   assign INT_SUM[229] = INT_CARRY[165];
   FULL_ADDER FA_154 (.DATA_A (INT_SUM[227]) , .DATA_B (INT_SUM[228]) , .DATA_C (INT_SUM[229]) , .SAVE (INT_SUM[230]) , .CARRY (INT_CARRY[181]) );
   assign INT_SUM[232] = INT_CARRY[166];
   assign INT_SUM[234] = INT_CARRY[167];
   FLIPFLOP LA_62 (.DIN (INT_SUM[230]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[231]) );
   FLIPFLOP LA_63 (.DIN (INT_SUM[232]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[233]) );
   FLIPFLOP LA_64 (.DIN (INT_SUM[234]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[235]) );
   FULL_ADDER FA_155 (.DATA_A (INT_SUM[231]) , .DATA_B (INT_SUM[233]) , .DATA_C (INT_SUM[235]) , .SAVE (INT_SUM[236]) , .CARRY (INT_CARRY[183]) );
   FLIPFLOP LA_65 (.DIN (INT_CARRY[168]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[169]) );
   assign INT_SUM[237] = INT_CARRY[169];
   FULL_ADDER FA_156 (.DATA_A (INT_SUM[236]) , .DATA_B (INT_SUM[237]) , .DATA_C (INT_CARRY[170]) , .SAVE (SUM[27]) , .CARRY (CARRY[27]) );
   FULL_ADDER FA_157 (.DATA_A (SUMMAND[224]) , .DATA_B (SUMMAND[225]) , .DATA_C (SUMMAND[226]) , .SAVE (INT_SUM[238]) , .CARRY (INT_CARRY[184]) );
   FULL_ADDER FA_158 (.DATA_A (SUMMAND[227]) , .DATA_B (SUMMAND[228]) , .DATA_C (SUMMAND[229]) , .SAVE (INT_SUM[239]) , .CARRY (INT_CARRY[185]) );
   FULL_ADDER FA_159 (.DATA_A (SUMMAND[230]) , .DATA_B (SUMMAND[231]) , .DATA_C (SUMMAND[232]) , .SAVE (INT_SUM[240]) , .CARRY (INT_CARRY[186]) );
   FULL_ADDER FA_160 (.DATA_A (SUMMAND[233]) , .DATA_B (SUMMAND[234]) , .DATA_C (SUMMAND[235]) , .SAVE (INT_SUM[241]) , .CARRY (INT_CARRY[187]) );
   FULL_ADDER FA_161 (.DATA_A (SUMMAND[236]) , .DATA_B (SUMMAND[237]) , .DATA_C (SUMMAND[238]) , .SAVE (INT_SUM[242]) , .CARRY (INT_CARRY[188]) );
   assign INT_SUM[243] = SUMMAND[239];
   FULL_ADDER FA_162 (.DATA_A (INT_SUM[238]) , .DATA_B (INT_SUM[239]) , .DATA_C (INT_SUM[240]) , .SAVE (INT_SUM[244]) , .CARRY (INT_CARRY[189]) );
   FULL_ADDER FA_163 (.DATA_A (INT_SUM[241]) , .DATA_B (INT_SUM[242]) , .DATA_C (INT_SUM[243]) , .SAVE (INT_SUM[245]) , .CARRY (INT_CARRY[190]) );
   FULL_ADDER FA_164 (.DATA_A (INT_CARRY[171]) , .DATA_B (INT_CARRY[172]) , .DATA_C (INT_CARRY[173]) , .SAVE (INT_SUM[246]) , .CARRY (INT_CARRY[191]) );
   assign INT_SUM[247] = INT_CARRY[174];
   assign INT_SUM[248] = INT_CARRY[175];
   FULL_ADDER FA_165 (.DATA_A (INT_SUM[244]) , .DATA_B (INT_SUM[245]) , .DATA_C (INT_SUM[246]) , .SAVE (INT_SUM[249]) , .CARRY (INT_CARRY[192]) );
   FULL_ADDER FA_166 (.DATA_A (INT_SUM[247]) , .DATA_B (INT_SUM[248]) , .DATA_C (INT_CARRY[176]) , .SAVE (INT_SUM[250]) , .CARRY (INT_CARRY[193]) );
   assign INT_SUM[251] = INT_CARRY[177];
   assign INT_SUM[252] = INT_CARRY[178];
   FULL_ADDER FA_167 (.DATA_A (INT_SUM[249]) , .DATA_B (INT_SUM[250]) , .DATA_C (INT_SUM[251]) , .SAVE (INT_SUM[253]) , .CARRY (INT_CARRY[194]) );
   FULL_ADDER FA_168 (.DATA_A (INT_SUM[252]) , .DATA_B (INT_CARRY[179]) , .DATA_C (INT_CARRY[180]) , .SAVE (INT_SUM[255]) , .CARRY (INT_CARRY[196]) );
   FLIPFLOP LA_66 (.DIN (INT_SUM[253]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[254]) );
   FLIPFLOP LA_67 (.DIN (INT_SUM[255]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[256]) );
   FLIPFLOP LA_68 (.DIN (INT_CARRY[181]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[182]) );
   FULL_ADDER FA_169 (.DATA_A (INT_SUM[254]) , .DATA_B (INT_SUM[256]) , .DATA_C (INT_CARRY[182]) , .SAVE (INT_SUM[257]) , .CARRY (INT_CARRY[198]) );
   HALF_ADDER HA_26 (.DATA_A (INT_SUM[257]) , .DATA_B (INT_CARRY[183]) , .SAVE (SUM[28]) , .CARRY (CARRY[28]) );
   FULL_ADDER FA_170 (.DATA_A (SUMMAND[240]) , .DATA_B (SUMMAND[241]) , .DATA_C (SUMMAND[242]) , .SAVE (INT_SUM[258]) , .CARRY (INT_CARRY[199]) );
   FULL_ADDER FA_171 (.DATA_A (SUMMAND[243]) , .DATA_B (SUMMAND[244]) , .DATA_C (SUMMAND[245]) , .SAVE (INT_SUM[259]) , .CARRY (INT_CARRY[200]) );
   FULL_ADDER FA_172 (.DATA_A (SUMMAND[246]) , .DATA_B (SUMMAND[247]) , .DATA_C (SUMMAND[248]) , .SAVE (INT_SUM[260]) , .CARRY (INT_CARRY[201]) );
   FULL_ADDER FA_173 (.DATA_A (SUMMAND[249]) , .DATA_B (SUMMAND[250]) , .DATA_C (SUMMAND[251]) , .SAVE (INT_SUM[261]) , .CARRY (INT_CARRY[202]) );
   FULL_ADDER FA_174 (.DATA_A (SUMMAND[252]) , .DATA_B (SUMMAND[253]) , .DATA_C (SUMMAND[254]) , .SAVE (INT_SUM[262]) , .CARRY (INT_CARRY[203]) );
   FULL_ADDER FA_175 (.DATA_A (INT_SUM[258]) , .DATA_B (INT_SUM[259]) , .DATA_C (INT_SUM[260]) , .SAVE (INT_SUM[263]) , .CARRY (INT_CARRY[204]) );
   FULL_ADDER FA_176 (.DATA_A (INT_SUM[261]) , .DATA_B (INT_SUM[262]) , .DATA_C (INT_CARRY[184]) , .SAVE (INT_SUM[264]) , .CARRY (INT_CARRY[205]) );
   FULL_ADDER FA_177 (.DATA_A (INT_CARRY[185]) , .DATA_B (INT_CARRY[186]) , .DATA_C (INT_CARRY[187]) , .SAVE (INT_SUM[265]) , .CARRY (INT_CARRY[206]) );
   assign INT_SUM[266] = INT_CARRY[188];
   FULL_ADDER FA_178 (.DATA_A (INT_SUM[263]) , .DATA_B (INT_SUM[264]) , .DATA_C (INT_SUM[265]) , .SAVE (INT_SUM[267]) , .CARRY (INT_CARRY[207]) );
   FULL_ADDER FA_179 (.DATA_A (INT_SUM[266]) , .DATA_B (INT_CARRY[189]) , .DATA_C (INT_CARRY[190]) , .SAVE (INT_SUM[268]) , .CARRY (INT_CARRY[208]) );
   assign INT_SUM[269] = INT_CARRY[191];
   FULL_ADDER FA_180 (.DATA_A (INT_SUM[267]) , .DATA_B (INT_SUM[268]) , .DATA_C (INT_SUM[269]) , .SAVE (INT_SUM[270]) , .CARRY (INT_CARRY[209]) );
   HALF_ADDER HA_27 (.DATA_A (INT_CARRY[192]) , .DATA_B (INT_CARRY[193]) , .SAVE (INT_SUM[272]) , .CARRY (INT_CARRY[211]) );
   FLIPFLOP LA_69 (.DIN (INT_SUM[270]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[271]) );
   FLIPFLOP LA_70 (.DIN (INT_SUM[272]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[273]) );
   FLIPFLOP LA_71 (.DIN (INT_CARRY[194]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[195]) );
   FULL_ADDER FA_181 (.DATA_A (INT_SUM[271]) , .DATA_B (INT_SUM[273]) , .DATA_C (INT_CARRY[195]) , .SAVE (INT_SUM[274]) , .CARRY (INT_CARRY[213]) );
   FLIPFLOP LA_72 (.DIN (INT_CARRY[196]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[197]) );
   assign INT_SUM[275] = INT_CARRY[197];
   FULL_ADDER FA_182 (.DATA_A (INT_SUM[274]) , .DATA_B (INT_SUM[275]) , .DATA_C (INT_CARRY[198]) , .SAVE (SUM[29]) , .CARRY (CARRY[29]) );
   FULL_ADDER FA_183 (.DATA_A (SUMMAND[255]) , .DATA_B (SUMMAND[256]) , .DATA_C (SUMMAND[257]) , .SAVE (INT_SUM[276]) , .CARRY (INT_CARRY[214]) );
   FULL_ADDER FA_184 (.DATA_A (SUMMAND[258]) , .DATA_B (SUMMAND[259]) , .DATA_C (SUMMAND[260]) , .SAVE (INT_SUM[277]) , .CARRY (INT_CARRY[215]) );
   FULL_ADDER FA_185 (.DATA_A (SUMMAND[261]) , .DATA_B (SUMMAND[262]) , .DATA_C (SUMMAND[263]) , .SAVE (INT_SUM[278]) , .CARRY (INT_CARRY[216]) );
   FULL_ADDER FA_186 (.DATA_A (SUMMAND[264]) , .DATA_B (SUMMAND[265]) , .DATA_C (SUMMAND[266]) , .SAVE (INT_SUM[279]) , .CARRY (INT_CARRY[217]) );
   FULL_ADDER FA_187 (.DATA_A (SUMMAND[267]) , .DATA_B (SUMMAND[268]) , .DATA_C (SUMMAND[269]) , .SAVE (INT_SUM[280]) , .CARRY (INT_CARRY[218]) );
   assign INT_SUM[281] = SUMMAND[270];
   assign INT_SUM[282] = SUMMAND[271];
   FULL_ADDER FA_188 (.DATA_A (INT_SUM[276]) , .DATA_B (INT_SUM[277]) , .DATA_C (INT_SUM[278]) , .SAVE (INT_SUM[283]) , .CARRY (INT_CARRY[219]) );
   FULL_ADDER FA_189 (.DATA_A (INT_SUM[279]) , .DATA_B (INT_SUM[280]) , .DATA_C (INT_SUM[281]) , .SAVE (INT_SUM[284]) , .CARRY (INT_CARRY[220]) );
   FULL_ADDER FA_190 (.DATA_A (INT_SUM[282]) , .DATA_B (INT_CARRY[199]) , .DATA_C (INT_CARRY[200]) , .SAVE (INT_SUM[285]) , .CARRY (INT_CARRY[221]) );
   FULL_ADDER FA_191 (.DATA_A (INT_CARRY[201]) , .DATA_B (INT_CARRY[202]) , .DATA_C (INT_CARRY[203]) , .SAVE (INT_SUM[286]) , .CARRY (INT_CARRY[222]) );
   FULL_ADDER FA_192 (.DATA_A (INT_SUM[283]) , .DATA_B (INT_SUM[284]) , .DATA_C (INT_SUM[285]) , .SAVE (INT_SUM[287]) , .CARRY (INT_CARRY[223]) );
   FULL_ADDER FA_193 (.DATA_A (INT_SUM[286]) , .DATA_B (INT_CARRY[204]) , .DATA_C (INT_CARRY[205]) , .SAVE (INT_SUM[288]) , .CARRY (INT_CARRY[224]) );
   assign INT_SUM[289] = INT_CARRY[206];
   FULL_ADDER FA_194 (.DATA_A (INT_SUM[287]) , .DATA_B (INT_SUM[288]) , .DATA_C (INT_SUM[289]) , .SAVE (INT_SUM[290]) , .CARRY (INT_CARRY[225]) );
   HALF_ADDER HA_28 (.DATA_A (INT_CARRY[207]) , .DATA_B (INT_CARRY[208]) , .SAVE (INT_SUM[292]) , .CARRY (INT_CARRY[227]) );
   FLIPFLOP LA_73 (.DIN (INT_SUM[290]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[291]) );
   FLIPFLOP LA_74 (.DIN (INT_SUM[292]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[293]) );
   FLIPFLOP LA_75 (.DIN (INT_CARRY[209]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[210]) );
   FULL_ADDER FA_195 (.DATA_A (INT_SUM[291]) , .DATA_B (INT_SUM[293]) , .DATA_C (INT_CARRY[210]) , .SAVE (INT_SUM[294]) , .CARRY (INT_CARRY[229]) );
   FLIPFLOP LA_76 (.DIN (INT_CARRY[211]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[212]) );
   assign INT_SUM[295] = INT_CARRY[212];
   FULL_ADDER FA_196 (.DATA_A (INT_SUM[294]) , .DATA_B (INT_SUM[295]) , .DATA_C (INT_CARRY[213]) , .SAVE (SUM[30]) , .CARRY (CARRY[30]) );
   FULL_ADDER FA_197 (.DATA_A (SUMMAND[272]) , .DATA_B (SUMMAND[273]) , .DATA_C (SUMMAND[274]) , .SAVE (INT_SUM[296]) , .CARRY (INT_CARRY[230]) );
   FULL_ADDER FA_198 (.DATA_A (SUMMAND[275]) , .DATA_B (SUMMAND[276]) , .DATA_C (SUMMAND[277]) , .SAVE (INT_SUM[297]) , .CARRY (INT_CARRY[231]) );
   FULL_ADDER FA_199 (.DATA_A (SUMMAND[278]) , .DATA_B (SUMMAND[279]) , .DATA_C (SUMMAND[280]) , .SAVE (INT_SUM[298]) , .CARRY (INT_CARRY[232]) );
   FULL_ADDER FA_200 (.DATA_A (SUMMAND[281]) , .DATA_B (SUMMAND[282]) , .DATA_C (SUMMAND[283]) , .SAVE (INT_SUM[299]) , .CARRY (INT_CARRY[233]) );
   FULL_ADDER FA_201 (.DATA_A (SUMMAND[284]) , .DATA_B (SUMMAND[285]) , .DATA_C (SUMMAND[286]) , .SAVE (INT_SUM[300]) , .CARRY (INT_CARRY[234]) );
   assign INT_SUM[301] = SUMMAND[287];
   FULL_ADDER FA_202 (.DATA_A (INT_SUM[296]) , .DATA_B (INT_SUM[297]) , .DATA_C (INT_SUM[298]) , .SAVE (INT_SUM[302]) , .CARRY (INT_CARRY[235]) );
   FULL_ADDER FA_203 (.DATA_A (INT_SUM[299]) , .DATA_B (INT_SUM[300]) , .DATA_C (INT_SUM[301]) , .SAVE (INT_SUM[303]) , .CARRY (INT_CARRY[236]) );
   FULL_ADDER FA_204 (.DATA_A (INT_CARRY[214]) , .DATA_B (INT_CARRY[215]) , .DATA_C (INT_CARRY[216]) , .SAVE (INT_SUM[304]) , .CARRY (INT_CARRY[237]) );
   assign INT_SUM[305] = INT_CARRY[217];
   assign INT_SUM[306] = INT_CARRY[218];
   FULL_ADDER FA_205 (.DATA_A (INT_SUM[302]) , .DATA_B (INT_SUM[303]) , .DATA_C (INT_SUM[304]) , .SAVE (INT_SUM[307]) , .CARRY (INT_CARRY[238]) );
   FULL_ADDER FA_206 (.DATA_A (INT_SUM[305]) , .DATA_B (INT_SUM[306]) , .DATA_C (INT_CARRY[219]) , .SAVE (INT_SUM[308]) , .CARRY (INT_CARRY[239]) );
   FULL_ADDER FA_207 (.DATA_A (INT_CARRY[220]) , .DATA_B (INT_CARRY[221]) , .DATA_C (INT_CARRY[222]) , .SAVE (INT_SUM[309]) , .CARRY (INT_CARRY[240]) );
   FULL_ADDER FA_208 (.DATA_A (INT_SUM[307]) , .DATA_B (INT_SUM[308]) , .DATA_C (INT_SUM[309]) , .SAVE (INT_SUM[310]) , .CARRY (INT_CARRY[241]) );
   HALF_ADDER HA_29 (.DATA_A (INT_CARRY[223]) , .DATA_B (INT_CARRY[224]) , .SAVE (INT_SUM[312]) , .CARRY (INT_CARRY[243]) );
   FLIPFLOP LA_77 (.DIN (INT_SUM[310]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[311]) );
   FLIPFLOP LA_78 (.DIN (INT_SUM[312]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[313]) );
   FLIPFLOP LA_79 (.DIN (INT_CARRY[225]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[226]) );
   FULL_ADDER FA_209 (.DATA_A (INT_SUM[311]) , .DATA_B (INT_SUM[313]) , .DATA_C (INT_CARRY[226]) , .SAVE (INT_SUM[314]) , .CARRY (INT_CARRY[245]) );
   FLIPFLOP LA_80 (.DIN (INT_CARRY[227]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[228]) );
   assign INT_SUM[315] = INT_CARRY[228];
   FULL_ADDER FA_210 (.DATA_A (INT_SUM[314]) , .DATA_B (INT_SUM[315]) , .DATA_C (INT_CARRY[229]) , .SAVE (SUM[31]) , .CARRY (CARRY[31]) );
   FULL_ADDER FA_211 (.DATA_A (SUMMAND[288]) , .DATA_B (SUMMAND[289]) , .DATA_C (SUMMAND[290]) , .SAVE (INT_SUM[316]) , .CARRY (INT_CARRY[246]) );
   FULL_ADDER FA_212 (.DATA_A (SUMMAND[291]) , .DATA_B (SUMMAND[292]) , .DATA_C (SUMMAND[293]) , .SAVE (INT_SUM[317]) , .CARRY (INT_CARRY[247]) );
   FULL_ADDER FA_213 (.DATA_A (SUMMAND[294]) , .DATA_B (SUMMAND[295]) , .DATA_C (SUMMAND[296]) , .SAVE (INT_SUM[318]) , .CARRY (INT_CARRY[248]) );
   FULL_ADDER FA_214 (.DATA_A (SUMMAND[297]) , .DATA_B (SUMMAND[298]) , .DATA_C (SUMMAND[299]) , .SAVE (INT_SUM[319]) , .CARRY (INT_CARRY[249]) );
   FULL_ADDER FA_215 (.DATA_A (SUMMAND[300]) , .DATA_B (SUMMAND[301]) , .DATA_C (SUMMAND[302]) , .SAVE (INT_SUM[320]) , .CARRY (INT_CARRY[250]) );
   assign INT_SUM[321] = SUMMAND[303];
   FULL_ADDER FA_216 (.DATA_A (INT_SUM[316]) , .DATA_B (INT_SUM[317]) , .DATA_C (INT_SUM[318]) , .SAVE (INT_SUM[322]) , .CARRY (INT_CARRY[251]) );
   FULL_ADDER FA_217 (.DATA_A (INT_SUM[319]) , .DATA_B (INT_SUM[320]) , .DATA_C (INT_SUM[321]) , .SAVE (INT_SUM[323]) , .CARRY (INT_CARRY[252]) );
   FULL_ADDER FA_218 (.DATA_A (INT_CARRY[230]) , .DATA_B (INT_CARRY[231]) , .DATA_C (INT_CARRY[232]) , .SAVE (INT_SUM[324]) , .CARRY (INT_CARRY[253]) );
   HALF_ADDER HA_30 (.DATA_A (INT_CARRY[233]) , .DATA_B (INT_CARRY[234]) , .SAVE (INT_SUM[325]) , .CARRY (INT_CARRY[254]) );
   FULL_ADDER FA_219 (.DATA_A (INT_SUM[322]) , .DATA_B (INT_SUM[323]) , .DATA_C (INT_SUM[324]) , .SAVE (INT_SUM[326]) , .CARRY (INT_CARRY[255]) );
   FULL_ADDER FA_220 (.DATA_A (INT_SUM[325]) , .DATA_B (INT_CARRY[235]) , .DATA_C (INT_CARRY[236]) , .SAVE (INT_SUM[327]) , .CARRY (INT_CARRY[256]) );
   assign INT_SUM[328] = INT_CARRY[237];
   FULL_ADDER FA_221 (.DATA_A (INT_SUM[326]) , .DATA_B (INT_SUM[327]) , .DATA_C (INT_SUM[328]) , .SAVE (INT_SUM[329]) , .CARRY (INT_CARRY[257]) );
   FULL_ADDER FA_222 (.DATA_A (INT_CARRY[238]) , .DATA_B (INT_CARRY[239]) , .DATA_C (INT_CARRY[240]) , .SAVE (INT_SUM[331]) , .CARRY (INT_CARRY[259]) );
   FLIPFLOP LA_81 (.DIN (INT_SUM[329]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[330]) );
   FLIPFLOP LA_82 (.DIN (INT_SUM[331]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[332]) );
   FLIPFLOP LA_83 (.DIN (INT_CARRY[241]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[242]) );
   FULL_ADDER FA_223 (.DATA_A (INT_SUM[330]) , .DATA_B (INT_SUM[332]) , .DATA_C (INT_CARRY[242]) , .SAVE (INT_SUM[333]) , .CARRY (INT_CARRY[261]) );
   FLIPFLOP LA_84 (.DIN (INT_CARRY[243]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[244]) );
   assign INT_SUM[334] = INT_CARRY[244];
   FULL_ADDER FA_224 (.DATA_A (INT_SUM[333]) , .DATA_B (INT_SUM[334]) , .DATA_C (INT_CARRY[245]) , .SAVE (SUM[32]) , .CARRY (CARRY[32]) );
   FULL_ADDER FA_225 (.DATA_A (SUMMAND[304]) , .DATA_B (SUMMAND[305]) , .DATA_C (SUMMAND[306]) , .SAVE (INT_SUM[335]) , .CARRY (INT_CARRY[262]) );
   FULL_ADDER FA_226 (.DATA_A (SUMMAND[307]) , .DATA_B (SUMMAND[308]) , .DATA_C (SUMMAND[309]) , .SAVE (INT_SUM[336]) , .CARRY (INT_CARRY[263]) );
   FULL_ADDER FA_227 (.DATA_A (SUMMAND[310]) , .DATA_B (SUMMAND[311]) , .DATA_C (SUMMAND[312]) , .SAVE (INT_SUM[337]) , .CARRY (INT_CARRY[264]) );
   FULL_ADDER FA_228 (.DATA_A (SUMMAND[313]) , .DATA_B (SUMMAND[314]) , .DATA_C (SUMMAND[315]) , .SAVE (INT_SUM[338]) , .CARRY (INT_CARRY[265]) );
   FULL_ADDER FA_229 (.DATA_A (SUMMAND[316]) , .DATA_B (SUMMAND[317]) , .DATA_C (SUMMAND[318]) , .SAVE (INT_SUM[339]) , .CARRY (INT_CARRY[266]) );
   assign INT_SUM[340] = SUMMAND[319];
   assign INT_SUM[341] = SUMMAND[320];
   FULL_ADDER FA_230 (.DATA_A (INT_SUM[335]) , .DATA_B (INT_SUM[336]) , .DATA_C (INT_SUM[337]) , .SAVE (INT_SUM[342]) , .CARRY (INT_CARRY[267]) );
   FULL_ADDER FA_231 (.DATA_A (INT_SUM[338]) , .DATA_B (INT_SUM[339]) , .DATA_C (INT_SUM[340]) , .SAVE (INT_SUM[343]) , .CARRY (INT_CARRY[268]) );
   FULL_ADDER FA_232 (.DATA_A (INT_SUM[341]) , .DATA_B (INT_CARRY[246]) , .DATA_C (INT_CARRY[247]) , .SAVE (INT_SUM[344]) , .CARRY (INT_CARRY[269]) );
   FULL_ADDER FA_233 (.DATA_A (INT_CARRY[248]) , .DATA_B (INT_CARRY[249]) , .DATA_C (INT_CARRY[250]) , .SAVE (INT_SUM[345]) , .CARRY (INT_CARRY[270]) );
   FULL_ADDER FA_234 (.DATA_A (INT_SUM[342]) , .DATA_B (INT_SUM[343]) , .DATA_C (INT_SUM[344]) , .SAVE (INT_SUM[346]) , .CARRY (INT_CARRY[271]) );
   FULL_ADDER FA_235 (.DATA_A (INT_SUM[345]) , .DATA_B (INT_CARRY[251]) , .DATA_C (INT_CARRY[252]) , .SAVE (INT_SUM[347]) , .CARRY (INT_CARRY[272]) );
   assign INT_SUM[348] = INT_CARRY[253];
   assign INT_SUM[349] = INT_CARRY[254];
   FULL_ADDER FA_236 (.DATA_A (INT_SUM[346]) , .DATA_B (INT_SUM[347]) , .DATA_C (INT_SUM[348]) , .SAVE (INT_SUM[350]) , .CARRY (INT_CARRY[273]) );
   FULL_ADDER FA_237 (.DATA_A (INT_SUM[349]) , .DATA_B (INT_CARRY[255]) , .DATA_C (INT_CARRY[256]) , .SAVE (INT_SUM[352]) , .CARRY (INT_CARRY[275]) );
   FLIPFLOP LA_85 (.DIN (INT_SUM[350]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[351]) );
   FLIPFLOP LA_86 (.DIN (INT_SUM[352]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[353]) );
   FLIPFLOP LA_87 (.DIN (INT_CARRY[257]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[258]) );
   FULL_ADDER FA_238 (.DATA_A (INT_SUM[351]) , .DATA_B (INT_SUM[353]) , .DATA_C (INT_CARRY[258]) , .SAVE (INT_SUM[354]) , .CARRY (INT_CARRY[277]) );
   FLIPFLOP LA_88 (.DIN (INT_CARRY[259]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[260]) );
   assign INT_SUM[355] = INT_CARRY[260];
   FULL_ADDER FA_239 (.DATA_A (INT_SUM[354]) , .DATA_B (INT_SUM[355]) , .DATA_C (INT_CARRY[261]) , .SAVE (SUM[33]) , .CARRY (CARRY[33]) );
   FULL_ADDER FA_240 (.DATA_A (SUMMAND[321]) , .DATA_B (SUMMAND[322]) , .DATA_C (SUMMAND[323]) , .SAVE (INT_SUM[356]) , .CARRY (INT_CARRY[278]) );
   FULL_ADDER FA_241 (.DATA_A (SUMMAND[324]) , .DATA_B (SUMMAND[325]) , .DATA_C (SUMMAND[326]) , .SAVE (INT_SUM[357]) , .CARRY (INT_CARRY[279]) );
   FULL_ADDER FA_242 (.DATA_A (SUMMAND[327]) , .DATA_B (SUMMAND[328]) , .DATA_C (SUMMAND[329]) , .SAVE (INT_SUM[358]) , .CARRY (INT_CARRY[280]) );
   FULL_ADDER FA_243 (.DATA_A (SUMMAND[330]) , .DATA_B (SUMMAND[331]) , .DATA_C (SUMMAND[332]) , .SAVE (INT_SUM[359]) , .CARRY (INT_CARRY[281]) );
   FULL_ADDER FA_244 (.DATA_A (SUMMAND[333]) , .DATA_B (SUMMAND[334]) , .DATA_C (SUMMAND[335]) , .SAVE (INT_SUM[360]) , .CARRY (INT_CARRY[282]) );
   assign INT_SUM[361] = SUMMAND[336];
   FULL_ADDER FA_245 (.DATA_A (INT_SUM[356]) , .DATA_B (INT_SUM[357]) , .DATA_C (INT_SUM[358]) , .SAVE (INT_SUM[362]) , .CARRY (INT_CARRY[283]) );
   FULL_ADDER FA_246 (.DATA_A (INT_SUM[359]) , .DATA_B (INT_SUM[360]) , .DATA_C (INT_SUM[361]) , .SAVE (INT_SUM[363]) , .CARRY (INT_CARRY[284]) );
   FULL_ADDER FA_247 (.DATA_A (INT_CARRY[262]) , .DATA_B (INT_CARRY[263]) , .DATA_C (INT_CARRY[264]) , .SAVE (INT_SUM[364]) , .CARRY (INT_CARRY[285]) );
   assign INT_SUM[365] = INT_CARRY[265];
   assign INT_SUM[366] = INT_CARRY[266];
   FULL_ADDER FA_248 (.DATA_A (INT_SUM[362]) , .DATA_B (INT_SUM[363]) , .DATA_C (INT_SUM[364]) , .SAVE (INT_SUM[367]) , .CARRY (INT_CARRY[286]) );
   FULL_ADDER FA_249 (.DATA_A (INT_SUM[365]) , .DATA_B (INT_SUM[366]) , .DATA_C (INT_CARRY[267]) , .SAVE (INT_SUM[368]) , .CARRY (INT_CARRY[287]) );
   FULL_ADDER FA_250 (.DATA_A (INT_CARRY[268]) , .DATA_B (INT_CARRY[269]) , .DATA_C (INT_CARRY[270]) , .SAVE (INT_SUM[369]) , .CARRY (INT_CARRY[288]) );
   FULL_ADDER FA_251 (.DATA_A (INT_SUM[367]) , .DATA_B (INT_SUM[368]) , .DATA_C (INT_SUM[369]) , .SAVE (INT_SUM[370]) , .CARRY (INT_CARRY[289]) );
   HALF_ADDER HA_31 (.DATA_A (INT_CARRY[271]) , .DATA_B (INT_CARRY[272]) , .SAVE (INT_SUM[372]) , .CARRY (INT_CARRY[291]) );
   FLIPFLOP LA_89 (.DIN (INT_SUM[370]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[371]) );
   FLIPFLOP LA_90 (.DIN (INT_SUM[372]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[373]) );
   FLIPFLOP LA_91 (.DIN (INT_CARRY[273]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[274]) );
   FULL_ADDER FA_252 (.DATA_A (INT_SUM[371]) , .DATA_B (INT_SUM[373]) , .DATA_C (INT_CARRY[274]) , .SAVE (INT_SUM[374]) , .CARRY (INT_CARRY[293]) );
   FLIPFLOP LA_92 (.DIN (INT_CARRY[275]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[276]) );
   assign INT_SUM[375] = INT_CARRY[276];
   FULL_ADDER FA_253 (.DATA_A (INT_SUM[374]) , .DATA_B (INT_SUM[375]) , .DATA_C (INT_CARRY[277]) , .SAVE (SUM[34]) , .CARRY (CARRY[34]) );
   FULL_ADDER FA_254 (.DATA_A (SUMMAND[337]) , .DATA_B (SUMMAND[338]) , .DATA_C (SUMMAND[339]) , .SAVE (INT_SUM[376]) , .CARRY (INT_CARRY[294]) );
   FULL_ADDER FA_255 (.DATA_A (SUMMAND[340]) , .DATA_B (SUMMAND[341]) , .DATA_C (SUMMAND[342]) , .SAVE (INT_SUM[377]) , .CARRY (INT_CARRY[295]) );
   FULL_ADDER FA_256 (.DATA_A (SUMMAND[343]) , .DATA_B (SUMMAND[344]) , .DATA_C (SUMMAND[345]) , .SAVE (INT_SUM[378]) , .CARRY (INT_CARRY[296]) );
   FULL_ADDER FA_257 (.DATA_A (SUMMAND[346]) , .DATA_B (SUMMAND[347]) , .DATA_C (SUMMAND[348]) , .SAVE (INT_SUM[379]) , .CARRY (INT_CARRY[297]) );
   FULL_ADDER FA_258 (.DATA_A (SUMMAND[349]) , .DATA_B (SUMMAND[350]) , .DATA_C (SUMMAND[351]) , .SAVE (INT_SUM[380]) , .CARRY (INT_CARRY[298]) );
   FULL_ADDER FA_259 (.DATA_A (INT_SUM[376]) , .DATA_B (INT_SUM[377]) , .DATA_C (INT_SUM[378]) , .SAVE (INT_SUM[381]) , .CARRY (INT_CARRY[299]) );
   FULL_ADDER FA_260 (.DATA_A (INT_SUM[379]) , .DATA_B (INT_SUM[380]) , .DATA_C (INT_CARRY[278]) , .SAVE (INT_SUM[382]) , .CARRY (INT_CARRY[300]) );
   FULL_ADDER FA_261 (.DATA_A (INT_CARRY[279]) , .DATA_B (INT_CARRY[280]) , .DATA_C (INT_CARRY[281]) , .SAVE (INT_SUM[383]) , .CARRY (INT_CARRY[301]) );
   assign INT_SUM[384] = INT_CARRY[282];
   FULL_ADDER FA_262 (.DATA_A (INT_SUM[381]) , .DATA_B (INT_SUM[382]) , .DATA_C (INT_SUM[383]) , .SAVE (INT_SUM[385]) , .CARRY (INT_CARRY[302]) );
   FULL_ADDER FA_263 (.DATA_A (INT_SUM[384]) , .DATA_B (INT_CARRY[283]) , .DATA_C (INT_CARRY[284]) , .SAVE (INT_SUM[386]) , .CARRY (INT_CARRY[303]) );
   assign INT_SUM[387] = INT_CARRY[285];
   FULL_ADDER FA_264 (.DATA_A (INT_SUM[385]) , .DATA_B (INT_SUM[386]) , .DATA_C (INT_SUM[387]) , .SAVE (INT_SUM[388]) , .CARRY (INT_CARRY[304]) );
   FULL_ADDER FA_265 (.DATA_A (INT_CARRY[286]) , .DATA_B (INT_CARRY[287]) , .DATA_C (INT_CARRY[288]) , .SAVE (INT_SUM[390]) , .CARRY (INT_CARRY[306]) );
   FLIPFLOP LA_93 (.DIN (INT_SUM[388]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[389]) );
   FLIPFLOP LA_94 (.DIN (INT_SUM[390]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[391]) );
   FLIPFLOP LA_95 (.DIN (INT_CARRY[289]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[290]) );
   FULL_ADDER FA_266 (.DATA_A (INT_SUM[389]) , .DATA_B (INT_SUM[391]) , .DATA_C (INT_CARRY[290]) , .SAVE (INT_SUM[392]) , .CARRY (INT_CARRY[308]) );
   FLIPFLOP LA_96 (.DIN (INT_CARRY[291]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[292]) );
   assign INT_SUM[393] = INT_CARRY[292];
   FULL_ADDER FA_267 (.DATA_A (INT_SUM[392]) , .DATA_B (INT_SUM[393]) , .DATA_C (INT_CARRY[293]) , .SAVE (SUM[35]) , .CARRY (CARRY[35]) );
   FULL_ADDER FA_268 (.DATA_A (SUMMAND[352]) , .DATA_B (SUMMAND[353]) , .DATA_C (SUMMAND[354]) , .SAVE (INT_SUM[394]) , .CARRY (INT_CARRY[309]) );
   FULL_ADDER FA_269 (.DATA_A (SUMMAND[355]) , .DATA_B (SUMMAND[356]) , .DATA_C (SUMMAND[357]) , .SAVE (INT_SUM[395]) , .CARRY (INT_CARRY[310]) );
   FULL_ADDER FA_270 (.DATA_A (SUMMAND[358]) , .DATA_B (SUMMAND[359]) , .DATA_C (SUMMAND[360]) , .SAVE (INT_SUM[396]) , .CARRY (INT_CARRY[311]) );
   FULL_ADDER FA_271 (.DATA_A (SUMMAND[361]) , .DATA_B (SUMMAND[362]) , .DATA_C (SUMMAND[363]) , .SAVE (INT_SUM[397]) , .CARRY (INT_CARRY[312]) );
   FULL_ADDER FA_272 (.DATA_A (SUMMAND[364]) , .DATA_B (SUMMAND[365]) , .DATA_C (SUMMAND[366]) , .SAVE (INT_SUM[398]) , .CARRY (INT_CARRY[313]) );
   FULL_ADDER FA_273 (.DATA_A (INT_SUM[394]) , .DATA_B (INT_SUM[395]) , .DATA_C (INT_SUM[396]) , .SAVE (INT_SUM[399]) , .CARRY (INT_CARRY[314]) );
   FULL_ADDER FA_274 (.DATA_A (INT_SUM[397]) , .DATA_B (INT_SUM[398]) , .DATA_C (INT_CARRY[294]) , .SAVE (INT_SUM[400]) , .CARRY (INT_CARRY[315]) );
   FULL_ADDER FA_275 (.DATA_A (INT_CARRY[295]) , .DATA_B (INT_CARRY[296]) , .DATA_C (INT_CARRY[297]) , .SAVE (INT_SUM[401]) , .CARRY (INT_CARRY[316]) );
   assign INT_SUM[402] = INT_CARRY[298];
   FULL_ADDER FA_276 (.DATA_A (INT_SUM[399]) , .DATA_B (INT_SUM[400]) , .DATA_C (INT_SUM[401]) , .SAVE (INT_SUM[403]) , .CARRY (INT_CARRY[317]) );
   FULL_ADDER FA_277 (.DATA_A (INT_SUM[402]) , .DATA_B (INT_CARRY[299]) , .DATA_C (INT_CARRY[300]) , .SAVE (INT_SUM[404]) , .CARRY (INT_CARRY[318]) );
   assign INT_SUM[405] = INT_CARRY[301];
   FULL_ADDER FA_278 (.DATA_A (INT_SUM[403]) , .DATA_B (INT_SUM[404]) , .DATA_C (INT_SUM[405]) , .SAVE (INT_SUM[406]) , .CARRY (INT_CARRY[319]) );
   HALF_ADDER HA_32 (.DATA_A (INT_CARRY[302]) , .DATA_B (INT_CARRY[303]) , .SAVE (INT_SUM[408]) , .CARRY (INT_CARRY[321]) );
   FLIPFLOP LA_97 (.DIN (INT_SUM[406]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[407]) );
   FLIPFLOP LA_98 (.DIN (INT_SUM[408]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[409]) );
   FLIPFLOP LA_99 (.DIN (INT_CARRY[304]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[305]) );
   FULL_ADDER FA_279 (.DATA_A (INT_SUM[407]) , .DATA_B (INT_SUM[409]) , .DATA_C (INT_CARRY[305]) , .SAVE (INT_SUM[410]) , .CARRY (INT_CARRY[323]) );
   FLIPFLOP LA_100 (.DIN (INT_CARRY[306]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[307]) );
   assign INT_SUM[411] = INT_CARRY[307];
   FULL_ADDER FA_280 (.DATA_A (INT_SUM[410]) , .DATA_B (INT_SUM[411]) , .DATA_C (INT_CARRY[308]) , .SAVE (SUM[36]) , .CARRY (CARRY[36]) );
   FULL_ADDER FA_281 (.DATA_A (SUMMAND[367]) , .DATA_B (SUMMAND[368]) , .DATA_C (SUMMAND[369]) , .SAVE (INT_SUM[412]) , .CARRY (INT_CARRY[324]) );
   FULL_ADDER FA_282 (.DATA_A (SUMMAND[370]) , .DATA_B (SUMMAND[371]) , .DATA_C (SUMMAND[372]) , .SAVE (INT_SUM[413]) , .CARRY (INT_CARRY[325]) );
   FULL_ADDER FA_283 (.DATA_A (SUMMAND[373]) , .DATA_B (SUMMAND[374]) , .DATA_C (SUMMAND[375]) , .SAVE (INT_SUM[414]) , .CARRY (INT_CARRY[326]) );
   FULL_ADDER FA_284 (.DATA_A (SUMMAND[376]) , .DATA_B (SUMMAND[377]) , .DATA_C (SUMMAND[378]) , .SAVE (INT_SUM[415]) , .CARRY (INT_CARRY[327]) );
   HALF_ADDER HA_33 (.DATA_A (SUMMAND[379]) , .DATA_B (SUMMAND[380]) , .SAVE (INT_SUM[416]) , .CARRY (INT_CARRY[328]) );
   FULL_ADDER FA_285 (.DATA_A (INT_SUM[412]) , .DATA_B (INT_SUM[413]) , .DATA_C (INT_SUM[414]) , .SAVE (INT_SUM[417]) , .CARRY (INT_CARRY[329]) );
   FULL_ADDER FA_286 (.DATA_A (INT_SUM[415]) , .DATA_B (INT_SUM[416]) , .DATA_C (INT_CARRY[309]) , .SAVE (INT_SUM[418]) , .CARRY (INT_CARRY[330]) );
   FULL_ADDER FA_287 (.DATA_A (INT_CARRY[310]) , .DATA_B (INT_CARRY[311]) , .DATA_C (INT_CARRY[312]) , .SAVE (INT_SUM[419]) , .CARRY (INT_CARRY[331]) );
   assign INT_SUM[420] = INT_CARRY[313];
   FULL_ADDER FA_288 (.DATA_A (INT_SUM[417]) , .DATA_B (INT_SUM[418]) , .DATA_C (INT_SUM[419]) , .SAVE (INT_SUM[421]) , .CARRY (INT_CARRY[332]) );
   FULL_ADDER FA_289 (.DATA_A (INT_SUM[420]) , .DATA_B (INT_CARRY[314]) , .DATA_C (INT_CARRY[315]) , .SAVE (INT_SUM[422]) , .CARRY (INT_CARRY[333]) );
   assign INT_SUM[423] = INT_CARRY[316];
   FULL_ADDER FA_290 (.DATA_A (INT_SUM[421]) , .DATA_B (INT_SUM[422]) , .DATA_C (INT_SUM[423]) , .SAVE (INT_SUM[424]) , .CARRY (INT_CARRY[334]) );
   HALF_ADDER HA_34 (.DATA_A (INT_CARRY[317]) , .DATA_B (INT_CARRY[318]) , .SAVE (INT_SUM[426]) , .CARRY (INT_CARRY[336]) );
   FLIPFLOP LA_101 (.DIN (INT_SUM[424]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[425]) );
   FLIPFLOP LA_102 (.DIN (INT_SUM[426]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[427]) );
   FLIPFLOP LA_103 (.DIN (INT_CARRY[319]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[320]) );
   FULL_ADDER FA_291 (.DATA_A (INT_SUM[425]) , .DATA_B (INT_SUM[427]) , .DATA_C (INT_CARRY[320]) , .SAVE (INT_SUM[428]) , .CARRY (INT_CARRY[338]) );
   FLIPFLOP LA_104 (.DIN (INT_CARRY[321]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[322]) );
   assign INT_SUM[429] = INT_CARRY[322];
   FULL_ADDER FA_292 (.DATA_A (INT_SUM[428]) , .DATA_B (INT_SUM[429]) , .DATA_C (INT_CARRY[323]) , .SAVE (SUM[37]) , .CARRY (CARRY[37]) );
   FULL_ADDER FA_293 (.DATA_A (SUMMAND[381]) , .DATA_B (SUMMAND[382]) , .DATA_C (SUMMAND[383]) , .SAVE (INT_SUM[430]) , .CARRY (INT_CARRY[339]) );
   FULL_ADDER FA_294 (.DATA_A (SUMMAND[384]) , .DATA_B (SUMMAND[385]) , .DATA_C (SUMMAND[386]) , .SAVE (INT_SUM[431]) , .CARRY (INT_CARRY[340]) );
   FULL_ADDER FA_295 (.DATA_A (SUMMAND[387]) , .DATA_B (SUMMAND[388]) , .DATA_C (SUMMAND[389]) , .SAVE (INT_SUM[432]) , .CARRY (INT_CARRY[341]) );
   FULL_ADDER FA_296 (.DATA_A (SUMMAND[390]) , .DATA_B (SUMMAND[391]) , .DATA_C (SUMMAND[392]) , .SAVE (INT_SUM[433]) , .CARRY (INT_CARRY[342]) );
   HALF_ADDER HA_35 (.DATA_A (SUMMAND[393]) , .DATA_B (SUMMAND[394]) , .SAVE (INT_SUM[434]) , .CARRY (INT_CARRY[343]) );
   FULL_ADDER FA_297 (.DATA_A (INT_SUM[430]) , .DATA_B (INT_SUM[431]) , .DATA_C (INT_SUM[432]) , .SAVE (INT_SUM[435]) , .CARRY (INT_CARRY[344]) );
   FULL_ADDER FA_298 (.DATA_A (INT_SUM[433]) , .DATA_B (INT_SUM[434]) , .DATA_C (INT_CARRY[324]) , .SAVE (INT_SUM[436]) , .CARRY (INT_CARRY[345]) );
   FULL_ADDER FA_299 (.DATA_A (INT_CARRY[325]) , .DATA_B (INT_CARRY[326]) , .DATA_C (INT_CARRY[327]) , .SAVE (INT_SUM[437]) , .CARRY (INT_CARRY[346]) );
   assign INT_SUM[438] = INT_CARRY[328];
   FULL_ADDER FA_300 (.DATA_A (INT_SUM[435]) , .DATA_B (INT_SUM[436]) , .DATA_C (INT_SUM[437]) , .SAVE (INT_SUM[439]) , .CARRY (INT_CARRY[347]) );
   FULL_ADDER FA_301 (.DATA_A (INT_SUM[438]) , .DATA_B (INT_CARRY[329]) , .DATA_C (INT_CARRY[330]) , .SAVE (INT_SUM[440]) , .CARRY (INT_CARRY[348]) );
   assign INT_SUM[441] = INT_CARRY[331];
   FULL_ADDER FA_302 (.DATA_A (INT_SUM[439]) , .DATA_B (INT_SUM[440]) , .DATA_C (INT_SUM[441]) , .SAVE (INT_SUM[442]) , .CARRY (INT_CARRY[349]) );
   HALF_ADDER HA_36 (.DATA_A (INT_CARRY[332]) , .DATA_B (INT_CARRY[333]) , .SAVE (INT_SUM[444]) , .CARRY (INT_CARRY[351]) );
   FLIPFLOP LA_105 (.DIN (INT_SUM[442]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[443]) );
   FLIPFLOP LA_106 (.DIN (INT_SUM[444]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[445]) );
   FLIPFLOP LA_107 (.DIN (INT_CARRY[334]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[335]) );
   FULL_ADDER FA_303 (.DATA_A (INT_SUM[443]) , .DATA_B (INT_SUM[445]) , .DATA_C (INT_CARRY[335]) , .SAVE (INT_SUM[446]) , .CARRY (INT_CARRY[353]) );
   FLIPFLOP LA_108 (.DIN (INT_CARRY[336]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[337]) );
   assign INT_SUM[447] = INT_CARRY[337];
   FULL_ADDER FA_304 (.DATA_A (INT_SUM[446]) , .DATA_B (INT_SUM[447]) , .DATA_C (INT_CARRY[338]) , .SAVE (SUM[38]) , .CARRY (CARRY[38]) );
   FULL_ADDER FA_305 (.DATA_A (SUMMAND[395]) , .DATA_B (SUMMAND[396]) , .DATA_C (SUMMAND[397]) , .SAVE (INT_SUM[448]) , .CARRY (INT_CARRY[354]) );
   FULL_ADDER FA_306 (.DATA_A (SUMMAND[398]) , .DATA_B (SUMMAND[399]) , .DATA_C (SUMMAND[400]) , .SAVE (INT_SUM[449]) , .CARRY (INT_CARRY[355]) );
   FULL_ADDER FA_307 (.DATA_A (SUMMAND[401]) , .DATA_B (SUMMAND[402]) , .DATA_C (SUMMAND[403]) , .SAVE (INT_SUM[450]) , .CARRY (INT_CARRY[356]) );
   FULL_ADDER FA_308 (.DATA_A (SUMMAND[404]) , .DATA_B (SUMMAND[405]) , .DATA_C (SUMMAND[406]) , .SAVE (INT_SUM[451]) , .CARRY (INT_CARRY[357]) );
   assign INT_SUM[452] = SUMMAND[407];
   FULL_ADDER FA_309 (.DATA_A (INT_SUM[448]) , .DATA_B (INT_SUM[449]) , .DATA_C (INT_SUM[450]) , .SAVE (INT_SUM[453]) , .CARRY (INT_CARRY[358]) );
   FULL_ADDER FA_310 (.DATA_A (INT_SUM[451]) , .DATA_B (INT_SUM[452]) , .DATA_C (INT_CARRY[339]) , .SAVE (INT_SUM[454]) , .CARRY (INT_CARRY[359]) );
   FULL_ADDER FA_311 (.DATA_A (INT_CARRY[340]) , .DATA_B (INT_CARRY[341]) , .DATA_C (INT_CARRY[342]) , .SAVE (INT_SUM[455]) , .CARRY (INT_CARRY[360]) );
   assign INT_SUM[456] = INT_CARRY[343];
   FULL_ADDER FA_312 (.DATA_A (INT_SUM[453]) , .DATA_B (INT_SUM[454]) , .DATA_C (INT_SUM[455]) , .SAVE (INT_SUM[457]) , .CARRY (INT_CARRY[361]) );
   FULL_ADDER FA_313 (.DATA_A (INT_SUM[456]) , .DATA_B (INT_CARRY[344]) , .DATA_C (INT_CARRY[345]) , .SAVE (INT_SUM[458]) , .CARRY (INT_CARRY[362]) );
   assign INT_SUM[459] = INT_CARRY[346];
   FULL_ADDER FA_314 (.DATA_A (INT_SUM[457]) , .DATA_B (INT_SUM[458]) , .DATA_C (INT_SUM[459]) , .SAVE (INT_SUM[460]) , .CARRY (INT_CARRY[363]) );
   HALF_ADDER HA_37 (.DATA_A (INT_CARRY[347]) , .DATA_B (INT_CARRY[348]) , .SAVE (INT_SUM[462]) , .CARRY (INT_CARRY[365]) );
   FLIPFLOP LA_109 (.DIN (INT_SUM[460]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[461]) );
   FLIPFLOP LA_110 (.DIN (INT_SUM[462]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[463]) );
   FLIPFLOP LA_111 (.DIN (INT_CARRY[349]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[350]) );
   FULL_ADDER FA_315 (.DATA_A (INT_SUM[461]) , .DATA_B (INT_SUM[463]) , .DATA_C (INT_CARRY[350]) , .SAVE (INT_SUM[464]) , .CARRY (INT_CARRY[367]) );
   FLIPFLOP LA_112 (.DIN (INT_CARRY[351]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[352]) );
   assign INT_SUM[465] = INT_CARRY[352];
   FULL_ADDER FA_316 (.DATA_A (INT_SUM[464]) , .DATA_B (INT_SUM[465]) , .DATA_C (INT_CARRY[353]) , .SAVE (SUM[39]) , .CARRY (CARRY[39]) );
   FULL_ADDER FA_317 (.DATA_A (SUMMAND[408]) , .DATA_B (SUMMAND[409]) , .DATA_C (SUMMAND[410]) , .SAVE (INT_SUM[466]) , .CARRY (INT_CARRY[368]) );
   FULL_ADDER FA_318 (.DATA_A (SUMMAND[411]) , .DATA_B (SUMMAND[412]) , .DATA_C (SUMMAND[413]) , .SAVE (INT_SUM[467]) , .CARRY (INT_CARRY[369]) );
   FULL_ADDER FA_319 (.DATA_A (SUMMAND[414]) , .DATA_B (SUMMAND[415]) , .DATA_C (SUMMAND[416]) , .SAVE (INT_SUM[468]) , .CARRY (INT_CARRY[370]) );
   FULL_ADDER FA_320 (.DATA_A (SUMMAND[417]) , .DATA_B (SUMMAND[418]) , .DATA_C (SUMMAND[419]) , .SAVE (INT_SUM[469]) , .CARRY (INT_CARRY[371]) );
   FULL_ADDER FA_321 (.DATA_A (SUMMAND[420]) , .DATA_B (INT_CARRY[354]) , .DATA_C (INT_CARRY[355]) , .SAVE (INT_SUM[470]) , .CARRY (INT_CARRY[372]) );
   assign INT_SUM[471] = INT_CARRY[356];
   assign INT_SUM[472] = INT_CARRY[357];
   FULL_ADDER FA_322 (.DATA_A (INT_SUM[466]) , .DATA_B (INT_SUM[467]) , .DATA_C (INT_SUM[468]) , .SAVE (INT_SUM[473]) , .CARRY (INT_CARRY[373]) );
   FULL_ADDER FA_323 (.DATA_A (INT_SUM[469]) , .DATA_B (INT_SUM[470]) , .DATA_C (INT_SUM[471]) , .SAVE (INT_SUM[474]) , .CARRY (INT_CARRY[374]) );
   FULL_ADDER FA_324 (.DATA_A (INT_SUM[472]) , .DATA_B (INT_CARRY[358]) , .DATA_C (INT_CARRY[359]) , .SAVE (INT_SUM[475]) , .CARRY (INT_CARRY[375]) );
   assign INT_SUM[476] = INT_CARRY[360];
   FULL_ADDER FA_325 (.DATA_A (INT_SUM[473]) , .DATA_B (INT_SUM[474]) , .DATA_C (INT_SUM[475]) , .SAVE (INT_SUM[477]) , .CARRY (INT_CARRY[376]) );
   FULL_ADDER FA_326 (.DATA_A (INT_SUM[476]) , .DATA_B (INT_CARRY[361]) , .DATA_C (INT_CARRY[362]) , .SAVE (INT_SUM[479]) , .CARRY (INT_CARRY[378]) );
   FLIPFLOP LA_113 (.DIN (INT_SUM[477]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[478]) );
   FLIPFLOP LA_114 (.DIN (INT_SUM[479]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[480]) );
   FLIPFLOP LA_115 (.DIN (INT_CARRY[363]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[364]) );
   FULL_ADDER FA_327 (.DATA_A (INT_SUM[478]) , .DATA_B (INT_SUM[480]) , .DATA_C (INT_CARRY[364]) , .SAVE (INT_SUM[481]) , .CARRY (INT_CARRY[380]) );
   FLIPFLOP LA_116 (.DIN (INT_CARRY[365]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[366]) );
   assign INT_SUM[482] = INT_CARRY[366];
   FULL_ADDER FA_328 (.DATA_A (INT_SUM[481]) , .DATA_B (INT_SUM[482]) , .DATA_C (INT_CARRY[367]) , .SAVE (SUM[40]) , .CARRY (CARRY[40]) );
   FULL_ADDER FA_329 (.DATA_A (SUMMAND[421]) , .DATA_B (SUMMAND[422]) , .DATA_C (SUMMAND[423]) , .SAVE (INT_SUM[483]) , .CARRY (INT_CARRY[381]) );
   FULL_ADDER FA_330 (.DATA_A (SUMMAND[424]) , .DATA_B (SUMMAND[425]) , .DATA_C (SUMMAND[426]) , .SAVE (INT_SUM[484]) , .CARRY (INT_CARRY[382]) );
   FULL_ADDER FA_331 (.DATA_A (SUMMAND[427]) , .DATA_B (SUMMAND[428]) , .DATA_C (SUMMAND[429]) , .SAVE (INT_SUM[485]) , .CARRY (INT_CARRY[383]) );
   FULL_ADDER FA_332 (.DATA_A (SUMMAND[430]) , .DATA_B (SUMMAND[431]) , .DATA_C (SUMMAND[432]) , .SAVE (INT_SUM[486]) , .CARRY (INT_CARRY[384]) );
   FULL_ADDER FA_333 (.DATA_A (INT_SUM[483]) , .DATA_B (INT_SUM[484]) , .DATA_C (INT_SUM[485]) , .SAVE (INT_SUM[487]) , .CARRY (INT_CARRY[385]) );
   FULL_ADDER FA_334 (.DATA_A (INT_SUM[486]) , .DATA_B (INT_CARRY[368]) , .DATA_C (INT_CARRY[369]) , .SAVE (INT_SUM[488]) , .CARRY (INT_CARRY[386]) );
   FULL_ADDER FA_335 (.DATA_A (INT_CARRY[370]) , .DATA_B (INT_CARRY[371]) , .DATA_C (INT_CARRY[372]) , .SAVE (INT_SUM[489]) , .CARRY (INT_CARRY[387]) );
   FULL_ADDER FA_336 (.DATA_A (INT_SUM[487]) , .DATA_B (INT_SUM[488]) , .DATA_C (INT_SUM[489]) , .SAVE (INT_SUM[490]) , .CARRY (INT_CARRY[388]) );
   FULL_ADDER FA_337 (.DATA_A (INT_CARRY[373]) , .DATA_B (INT_CARRY[374]) , .DATA_C (INT_CARRY[375]) , .SAVE (INT_SUM[492]) , .CARRY (INT_CARRY[390]) );
   FLIPFLOP LA_117 (.DIN (INT_SUM[490]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[491]) );
   FLIPFLOP LA_118 (.DIN (INT_SUM[492]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[493]) );
   FLIPFLOP LA_119 (.DIN (INT_CARRY[376]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[377]) );
   FULL_ADDER FA_338 (.DATA_A (INT_SUM[491]) , .DATA_B (INT_SUM[493]) , .DATA_C (INT_CARRY[377]) , .SAVE (INT_SUM[494]) , .CARRY (INT_CARRY[392]) );
   FLIPFLOP LA_120 (.DIN (INT_CARRY[378]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[379]) );
   assign INT_SUM[495] = INT_CARRY[379];
   FULL_ADDER FA_339 (.DATA_A (INT_SUM[494]) , .DATA_B (INT_SUM[495]) , .DATA_C (INT_CARRY[380]) , .SAVE (SUM[41]) , .CARRY (CARRY[41]) );
   FULL_ADDER FA_340 (.DATA_A (SUMMAND[433]) , .DATA_B (SUMMAND[434]) , .DATA_C (SUMMAND[435]) , .SAVE (INT_SUM[496]) , .CARRY (INT_CARRY[393]) );
   FULL_ADDER FA_341 (.DATA_A (SUMMAND[436]) , .DATA_B (SUMMAND[437]) , .DATA_C (SUMMAND[438]) , .SAVE (INT_SUM[497]) , .CARRY (INT_CARRY[394]) );
   FULL_ADDER FA_342 (.DATA_A (SUMMAND[439]) , .DATA_B (SUMMAND[440]) , .DATA_C (SUMMAND[441]) , .SAVE (INT_SUM[498]) , .CARRY (INT_CARRY[395]) );
   FULL_ADDER FA_343 (.DATA_A (SUMMAND[442]) , .DATA_B (SUMMAND[443]) , .DATA_C (SUMMAND[444]) , .SAVE (INT_SUM[499]) , .CARRY (INT_CARRY[396]) );
   FULL_ADDER FA_344 (.DATA_A (INT_SUM[496]) , .DATA_B (INT_SUM[497]) , .DATA_C (INT_SUM[498]) , .SAVE (INT_SUM[500]) , .CARRY (INT_CARRY[397]) );
   FULL_ADDER FA_345 (.DATA_A (INT_SUM[499]) , .DATA_B (INT_CARRY[381]) , .DATA_C (INT_CARRY[382]) , .SAVE (INT_SUM[501]) , .CARRY (INT_CARRY[398]) );
   HALF_ADDER HA_38 (.DATA_A (INT_CARRY[383]) , .DATA_B (INT_CARRY[384]) , .SAVE (INT_SUM[502]) , .CARRY (INT_CARRY[399]) );
   FULL_ADDER FA_346 (.DATA_A (INT_SUM[500]) , .DATA_B (INT_SUM[501]) , .DATA_C (INT_SUM[502]) , .SAVE (INT_SUM[503]) , .CARRY (INT_CARRY[400]) );
   FULL_ADDER FA_347 (.DATA_A (INT_CARRY[385]) , .DATA_B (INT_CARRY[386]) , .DATA_C (INT_CARRY[387]) , .SAVE (INT_SUM[505]) , .CARRY (INT_CARRY[402]) );
   FLIPFLOP LA_121 (.DIN (INT_SUM[503]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[504]) );
   FLIPFLOP LA_122 (.DIN (INT_SUM[505]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[506]) );
   FLIPFLOP LA_123 (.DIN (INT_CARRY[388]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[389]) );
   FULL_ADDER FA_348 (.DATA_A (INT_SUM[504]) , .DATA_B (INT_SUM[506]) , .DATA_C (INT_CARRY[389]) , .SAVE (INT_SUM[507]) , .CARRY (INT_CARRY[404]) );
   FLIPFLOP LA_124 (.DIN (INT_CARRY[390]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[391]) );
   assign INT_SUM[508] = INT_CARRY[391];
   FULL_ADDER FA_349 (.DATA_A (INT_SUM[507]) , .DATA_B (INT_SUM[508]) , .DATA_C (INT_CARRY[392]) , .SAVE (SUM[42]) , .CARRY (CARRY[42]) );
   FULL_ADDER FA_350 (.DATA_A (SUMMAND[445]) , .DATA_B (SUMMAND[446]) , .DATA_C (SUMMAND[447]) , .SAVE (INT_SUM[509]) , .CARRY (INT_CARRY[405]) );
   FULL_ADDER FA_351 (.DATA_A (SUMMAND[448]) , .DATA_B (SUMMAND[449]) , .DATA_C (SUMMAND[450]) , .SAVE (INT_SUM[510]) , .CARRY (INT_CARRY[406]) );
   FULL_ADDER FA_352 (.DATA_A (SUMMAND[451]) , .DATA_B (SUMMAND[452]) , .DATA_C (SUMMAND[453]) , .SAVE (INT_SUM[511]) , .CARRY (INT_CARRY[407]) );
   assign INT_SUM[512] = SUMMAND[454];
   assign INT_SUM[513] = SUMMAND[455];
   FULL_ADDER FA_353 (.DATA_A (INT_SUM[509]) , .DATA_B (INT_SUM[510]) , .DATA_C (INT_SUM[511]) , .SAVE (INT_SUM[514]) , .CARRY (INT_CARRY[408]) );
   FULL_ADDER FA_354 (.DATA_A (INT_SUM[512]) , .DATA_B (INT_SUM[513]) , .DATA_C (INT_CARRY[393]) , .SAVE (INT_SUM[515]) , .CARRY (INT_CARRY[409]) );
   FULL_ADDER FA_355 (.DATA_A (INT_CARRY[394]) , .DATA_B (INT_CARRY[395]) , .DATA_C (INT_CARRY[396]) , .SAVE (INT_SUM[516]) , .CARRY (INT_CARRY[410]) );
   FULL_ADDER FA_356 (.DATA_A (INT_SUM[514]) , .DATA_B (INT_SUM[515]) , .DATA_C (INT_SUM[516]) , .SAVE (INT_SUM[517]) , .CARRY (INT_CARRY[411]) );
   FULL_ADDER FA_357 (.DATA_A (INT_CARRY[397]) , .DATA_B (INT_CARRY[398]) , .DATA_C (INT_CARRY[399]) , .SAVE (INT_SUM[519]) , .CARRY (INT_CARRY[413]) );
   FLIPFLOP LA_125 (.DIN (INT_SUM[517]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[518]) );
   FLIPFLOP LA_126 (.DIN (INT_SUM[519]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[520]) );
   FLIPFLOP LA_127 (.DIN (INT_CARRY[400]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[401]) );
   FULL_ADDER FA_358 (.DATA_A (INT_SUM[518]) , .DATA_B (INT_SUM[520]) , .DATA_C (INT_CARRY[401]) , .SAVE (INT_SUM[521]) , .CARRY (INT_CARRY[415]) );
   FLIPFLOP LA_128 (.DIN (INT_CARRY[402]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[403]) );
   assign INT_SUM[522] = INT_CARRY[403];
   FULL_ADDER FA_359 (.DATA_A (INT_SUM[521]) , .DATA_B (INT_SUM[522]) , .DATA_C (INT_CARRY[404]) , .SAVE (SUM[43]) , .CARRY (CARRY[43]) );
   FULL_ADDER FA_360 (.DATA_A (SUMMAND[456]) , .DATA_B (SUMMAND[457]) , .DATA_C (SUMMAND[458]) , .SAVE (INT_SUM[523]) , .CARRY (INT_CARRY[416]) );
   FULL_ADDER FA_361 (.DATA_A (SUMMAND[459]) , .DATA_B (SUMMAND[460]) , .DATA_C (SUMMAND[461]) , .SAVE (INT_SUM[524]) , .CARRY (INT_CARRY[417]) );
   FULL_ADDER FA_362 (.DATA_A (SUMMAND[462]) , .DATA_B (SUMMAND[463]) , .DATA_C (SUMMAND[464]) , .SAVE (INT_SUM[525]) , .CARRY (INT_CARRY[418]) );
   HALF_ADDER HA_39 (.DATA_A (SUMMAND[465]) , .DATA_B (SUMMAND[466]) , .SAVE (INT_SUM[526]) , .CARRY (INT_CARRY[419]) );
   FULL_ADDER FA_363 (.DATA_A (INT_SUM[523]) , .DATA_B (INT_SUM[524]) , .DATA_C (INT_SUM[525]) , .SAVE (INT_SUM[527]) , .CARRY (INT_CARRY[420]) );
   FULL_ADDER FA_364 (.DATA_A (INT_SUM[526]) , .DATA_B (INT_CARRY[405]) , .DATA_C (INT_CARRY[406]) , .SAVE (INT_SUM[528]) , .CARRY (INT_CARRY[421]) );
   assign INT_SUM[529] = INT_CARRY[407];
   FULL_ADDER FA_365 (.DATA_A (INT_SUM[527]) , .DATA_B (INT_SUM[528]) , .DATA_C (INT_SUM[529]) , .SAVE (INT_SUM[530]) , .CARRY (INT_CARRY[422]) );
   FULL_ADDER FA_366 (.DATA_A (INT_CARRY[408]) , .DATA_B (INT_CARRY[409]) , .DATA_C (INT_CARRY[410]) , .SAVE (INT_SUM[532]) , .CARRY (INT_CARRY[424]) );
   FLIPFLOP LA_129 (.DIN (INT_SUM[530]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[531]) );
   FLIPFLOP LA_130 (.DIN (INT_SUM[532]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[533]) );
   FLIPFLOP LA_131 (.DIN (INT_CARRY[411]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[412]) );
   FULL_ADDER FA_367 (.DATA_A (INT_SUM[531]) , .DATA_B (INT_SUM[533]) , .DATA_C (INT_CARRY[412]) , .SAVE (INT_SUM[534]) , .CARRY (INT_CARRY[426]) );
   FLIPFLOP LA_132 (.DIN (INT_CARRY[413]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[414]) );
   assign INT_SUM[535] = INT_CARRY[414];
   FULL_ADDER FA_368 (.DATA_A (INT_SUM[534]) , .DATA_B (INT_SUM[535]) , .DATA_C (INT_CARRY[415]) , .SAVE (SUM[44]) , .CARRY (CARRY[44]) );
   FULL_ADDER FA_369 (.DATA_A (SUMMAND[467]) , .DATA_B (SUMMAND[468]) , .DATA_C (SUMMAND[469]) , .SAVE (INT_SUM[536]) , .CARRY (INT_CARRY[427]) );
   FULL_ADDER FA_370 (.DATA_A (SUMMAND[470]) , .DATA_B (SUMMAND[471]) , .DATA_C (SUMMAND[472]) , .SAVE (INT_SUM[537]) , .CARRY (INT_CARRY[428]) );
   FULL_ADDER FA_371 (.DATA_A (SUMMAND[473]) , .DATA_B (SUMMAND[474]) , .DATA_C (SUMMAND[475]) , .SAVE (INT_SUM[538]) , .CARRY (INT_CARRY[429]) );
   assign INT_SUM[539] = SUMMAND[476];
   FULL_ADDER FA_372 (.DATA_A (INT_SUM[536]) , .DATA_B (INT_SUM[537]) , .DATA_C (INT_SUM[538]) , .SAVE (INT_SUM[540]) , .CARRY (INT_CARRY[430]) );
   FULL_ADDER FA_373 (.DATA_A (INT_SUM[539]) , .DATA_B (INT_CARRY[416]) , .DATA_C (INT_CARRY[417]) , .SAVE (INT_SUM[541]) , .CARRY (INT_CARRY[431]) );
   assign INT_SUM[542] = INT_CARRY[418];
   assign INT_SUM[543] = INT_CARRY[419];
   FULL_ADDER FA_374 (.DATA_A (INT_SUM[540]) , .DATA_B (INT_SUM[541]) , .DATA_C (INT_SUM[542]) , .SAVE (INT_SUM[544]) , .CARRY (INT_CARRY[432]) );
   FULL_ADDER FA_375 (.DATA_A (INT_SUM[543]) , .DATA_B (INT_CARRY[420]) , .DATA_C (INT_CARRY[421]) , .SAVE (INT_SUM[546]) , .CARRY (INT_CARRY[434]) );
   FLIPFLOP LA_133 (.DIN (INT_SUM[544]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[545]) );
   FLIPFLOP LA_134 (.DIN (INT_SUM[546]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[547]) );
   FLIPFLOP LA_135 (.DIN (INT_CARRY[422]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[423]) );
   FULL_ADDER FA_376 (.DATA_A (INT_SUM[545]) , .DATA_B (INT_SUM[547]) , .DATA_C (INT_CARRY[423]) , .SAVE (INT_SUM[548]) , .CARRY (INT_CARRY[436]) );
   FLIPFLOP LA_136 (.DIN (INT_CARRY[424]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[425]) );
   assign INT_SUM[549] = INT_CARRY[425];
   FULL_ADDER FA_377 (.DATA_A (INT_SUM[548]) , .DATA_B (INT_SUM[549]) , .DATA_C (INT_CARRY[426]) , .SAVE (SUM[45]) , .CARRY (CARRY[45]) );
   FULL_ADDER FA_378 (.DATA_A (SUMMAND[477]) , .DATA_B (SUMMAND[478]) , .DATA_C (SUMMAND[479]) , .SAVE (INT_SUM[550]) , .CARRY (INT_CARRY[437]) );
   FULL_ADDER FA_379 (.DATA_A (SUMMAND[480]) , .DATA_B (SUMMAND[481]) , .DATA_C (SUMMAND[482]) , .SAVE (INT_SUM[551]) , .CARRY (INT_CARRY[438]) );
   FULL_ADDER FA_380 (.DATA_A (SUMMAND[483]) , .DATA_B (SUMMAND[484]) , .DATA_C (SUMMAND[485]) , .SAVE (INT_SUM[552]) , .CARRY (INT_CARRY[439]) );
   assign INT_SUM[553] = SUMMAND[486];
   FULL_ADDER FA_381 (.DATA_A (INT_SUM[550]) , .DATA_B (INT_SUM[551]) , .DATA_C (INT_SUM[552]) , .SAVE (INT_SUM[554]) , .CARRY (INT_CARRY[440]) );
   FULL_ADDER FA_382 (.DATA_A (INT_SUM[553]) , .DATA_B (INT_CARRY[427]) , .DATA_C (INT_CARRY[428]) , .SAVE (INT_SUM[555]) , .CARRY (INT_CARRY[441]) );
   assign INT_SUM[556] = INT_CARRY[429];
   FULL_ADDER FA_383 (.DATA_A (INT_SUM[554]) , .DATA_B (INT_SUM[555]) , .DATA_C (INT_SUM[556]) , .SAVE (INT_SUM[557]) , .CARRY (INT_CARRY[442]) );
   HALF_ADDER HA_40 (.DATA_A (INT_CARRY[430]) , .DATA_B (INT_CARRY[431]) , .SAVE (INT_SUM[559]) , .CARRY (INT_CARRY[444]) );
   FLIPFLOP LA_137 (.DIN (INT_SUM[557]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[558]) );
   FLIPFLOP LA_138 (.DIN (INT_SUM[559]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[560]) );
   FLIPFLOP LA_139 (.DIN (INT_CARRY[432]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[433]) );
   FULL_ADDER FA_384 (.DATA_A (INT_SUM[558]) , .DATA_B (INT_SUM[560]) , .DATA_C (INT_CARRY[433]) , .SAVE (INT_SUM[561]) , .CARRY (INT_CARRY[446]) );
   FLIPFLOP LA_140 (.DIN (INT_CARRY[434]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[435]) );
   assign INT_SUM[562] = INT_CARRY[435];
   FULL_ADDER FA_385 (.DATA_A (INT_SUM[561]) , .DATA_B (INT_SUM[562]) , .DATA_C (INT_CARRY[436]) , .SAVE (SUM[46]) , .CARRY (CARRY[46]) );
   FULL_ADDER FA_386 (.DATA_A (SUMMAND[487]) , .DATA_B (SUMMAND[488]) , .DATA_C (SUMMAND[489]) , .SAVE (INT_SUM[563]) , .CARRY (INT_CARRY[447]) );
   FULL_ADDER FA_387 (.DATA_A (SUMMAND[490]) , .DATA_B (SUMMAND[491]) , .DATA_C (SUMMAND[492]) , .SAVE (INT_SUM[564]) , .CARRY (INT_CARRY[448]) );
   FULL_ADDER FA_388 (.DATA_A (SUMMAND[493]) , .DATA_B (SUMMAND[494]) , .DATA_C (SUMMAND[495]) , .SAVE (INT_SUM[565]) , .CARRY (INT_CARRY[449]) );
   FULL_ADDER FA_389 (.DATA_A (INT_SUM[563]) , .DATA_B (INT_SUM[564]) , .DATA_C (INT_SUM[565]) , .SAVE (INT_SUM[566]) , .CARRY (INT_CARRY[450]) );
   FULL_ADDER FA_390 (.DATA_A (INT_CARRY[437]) , .DATA_B (INT_CARRY[438]) , .DATA_C (INT_CARRY[439]) , .SAVE (INT_SUM[567]) , .CARRY (INT_CARRY[451]) );
   FULL_ADDER FA_391 (.DATA_A (INT_SUM[566]) , .DATA_B (INT_SUM[567]) , .DATA_C (INT_CARRY[440]) , .SAVE (INT_SUM[568]) , .CARRY (INT_CARRY[452]) );
   assign INT_SUM[570] = INT_CARRY[441];
   FLIPFLOP LA_141 (.DIN (INT_SUM[568]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[569]) );
   FLIPFLOP LA_142 (.DIN (INT_SUM[570]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[571]) );
   FLIPFLOP LA_143 (.DIN (INT_CARRY[442]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[443]) );
   FULL_ADDER FA_392 (.DATA_A (INT_SUM[569]) , .DATA_B (INT_SUM[571]) , .DATA_C (INT_CARRY[443]) , .SAVE (INT_SUM[572]) , .CARRY (INT_CARRY[454]) );
   FLIPFLOP LA_144 (.DIN (INT_CARRY[444]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[445]) );
   assign INT_SUM[573] = INT_CARRY[445];
   FULL_ADDER FA_393 (.DATA_A (INT_SUM[572]) , .DATA_B (INT_SUM[573]) , .DATA_C (INT_CARRY[446]) , .SAVE (SUM[47]) , .CARRY (CARRY[47]) );
   FULL_ADDER FA_394 (.DATA_A (SUMMAND[496]) , .DATA_B (SUMMAND[497]) , .DATA_C (SUMMAND[498]) , .SAVE (INT_SUM[574]) , .CARRY (INT_CARRY[455]) );
   FULL_ADDER FA_395 (.DATA_A (SUMMAND[499]) , .DATA_B (SUMMAND[500]) , .DATA_C (SUMMAND[501]) , .SAVE (INT_SUM[575]) , .CARRY (INT_CARRY[456]) );
   FULL_ADDER FA_396 (.DATA_A (SUMMAND[502]) , .DATA_B (SUMMAND[503]) , .DATA_C (SUMMAND[504]) , .SAVE (INT_SUM[576]) , .CARRY (INT_CARRY[457]) );
   FULL_ADDER FA_397 (.DATA_A (INT_SUM[574]) , .DATA_B (INT_SUM[575]) , .DATA_C (INT_SUM[576]) , .SAVE (INT_SUM[577]) , .CARRY (INT_CARRY[458]) );
   FULL_ADDER FA_398 (.DATA_A (INT_CARRY[447]) , .DATA_B (INT_CARRY[448]) , .DATA_C (INT_CARRY[449]) , .SAVE (INT_SUM[578]) , .CARRY (INT_CARRY[459]) );
   FULL_ADDER FA_399 (.DATA_A (INT_SUM[577]) , .DATA_B (INT_SUM[578]) , .DATA_C (INT_CARRY[450]) , .SAVE (INT_SUM[579]) , .CARRY (INT_CARRY[460]) );
   assign INT_SUM[581] = INT_CARRY[451];
   FLIPFLOP LA_145 (.DIN (INT_SUM[579]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[580]) );
   FLIPFLOP LA_146 (.DIN (INT_SUM[581]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[582]) );
   FLIPFLOP LA_147 (.DIN (INT_CARRY[452]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[453]) );
   FULL_ADDER FA_400 (.DATA_A (INT_SUM[580]) , .DATA_B (INT_SUM[582]) , .DATA_C (INT_CARRY[453]) , .SAVE (INT_SUM[583]) , .CARRY (INT_CARRY[462]) );
   HALF_ADDER HA_41 (.DATA_A (INT_SUM[583]) , .DATA_B (INT_CARRY[454]) , .SAVE (SUM[48]) , .CARRY (CARRY[48]) );
   FULL_ADDER FA_401 (.DATA_A (SUMMAND[505]) , .DATA_B (SUMMAND[506]) , .DATA_C (SUMMAND[507]) , .SAVE (INT_SUM[584]) , .CARRY (INT_CARRY[463]) );
   FULL_ADDER FA_402 (.DATA_A (SUMMAND[508]) , .DATA_B (SUMMAND[509]) , .DATA_C (SUMMAND[510]) , .SAVE (INT_SUM[585]) , .CARRY (INT_CARRY[464]) );
   FULL_ADDER FA_403 (.DATA_A (SUMMAND[511]) , .DATA_B (SUMMAND[512]) , .DATA_C (INT_CARRY[455]) , .SAVE (INT_SUM[586]) , .CARRY (INT_CARRY[465]) );
   HALF_ADDER HA_42 (.DATA_A (INT_CARRY[456]) , .DATA_B (INT_CARRY[457]) , .SAVE (INT_SUM[587]) , .CARRY (INT_CARRY[466]) );
   FULL_ADDER FA_404 (.DATA_A (INT_SUM[584]) , .DATA_B (INT_SUM[585]) , .DATA_C (INT_SUM[586]) , .SAVE (INT_SUM[588]) , .CARRY (INT_CARRY[467]) );
   FULL_ADDER FA_405 (.DATA_A (INT_SUM[587]) , .DATA_B (INT_CARRY[458]) , .DATA_C (INT_CARRY[459]) , .SAVE (INT_SUM[590]) , .CARRY (INT_CARRY[469]) );
   FLIPFLOP LA_148 (.DIN (INT_SUM[588]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[589]) );
   FLIPFLOP LA_149 (.DIN (INT_SUM[590]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[591]) );
   FLIPFLOP LA_150 (.DIN (INT_CARRY[460]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[461]) );
   FULL_ADDER FA_406 (.DATA_A (INT_SUM[589]) , .DATA_B (INT_SUM[591]) , .DATA_C (INT_CARRY[461]) , .SAVE (INT_SUM[592]) , .CARRY (INT_CARRY[471]) );
   HALF_ADDER HA_43 (.DATA_A (INT_SUM[592]) , .DATA_B (INT_CARRY[462]) , .SAVE (SUM[49]) , .CARRY (CARRY[49]) );
   FULL_ADDER FA_407 (.DATA_A (SUMMAND[513]) , .DATA_B (SUMMAND[514]) , .DATA_C (SUMMAND[515]) , .SAVE (INT_SUM[593]) , .CARRY (INT_CARRY[472]) );
   FULL_ADDER FA_408 (.DATA_A (SUMMAND[516]) , .DATA_B (SUMMAND[517]) , .DATA_C (SUMMAND[518]) , .SAVE (INT_SUM[594]) , .CARRY (INT_CARRY[473]) );
   assign INT_SUM[595] = SUMMAND[519];
   assign INT_SUM[596] = SUMMAND[520];
   FULL_ADDER FA_409 (.DATA_A (INT_SUM[593]) , .DATA_B (INT_SUM[594]) , .DATA_C (INT_SUM[595]) , .SAVE (INT_SUM[597]) , .CARRY (INT_CARRY[474]) );
   assign INT_SUM[598] = INT_SUM[596];
   FULL_ADDER FA_410 (.DATA_A (INT_SUM[597]) , .DATA_B (INT_SUM[598]) , .DATA_C (INT_CARRY[463]) , .SAVE (INT_SUM[599]) , .CARRY (INT_CARRY[475]) );
   FULL_ADDER FA_411 (.DATA_A (INT_CARRY[464]) , .DATA_B (INT_CARRY[465]) , .DATA_C (INT_CARRY[466]) , .SAVE (INT_SUM[601]) , .CARRY (INT_CARRY[477]) );
   FLIPFLOP LA_151 (.DIN (INT_SUM[599]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[600]) );
   FLIPFLOP LA_152 (.DIN (INT_SUM[601]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[602]) );
   FLIPFLOP LA_153 (.DIN (INT_CARRY[467]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[468]) );
   FULL_ADDER FA_412 (.DATA_A (INT_SUM[600]) , .DATA_B (INT_SUM[602]) , .DATA_C (INT_CARRY[468]) , .SAVE (INT_SUM[603]) , .CARRY (INT_CARRY[479]) );
   FLIPFLOP LA_154 (.DIN (INT_CARRY[469]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[470]) );
   assign INT_SUM[604] = INT_CARRY[470];
   FULL_ADDER FA_413 (.DATA_A (INT_SUM[603]) , .DATA_B (INT_SUM[604]) , .DATA_C (INT_CARRY[471]) , .SAVE (SUM[50]) , .CARRY (CARRY[50]) );
   FULL_ADDER FA_414 (.DATA_A (SUMMAND[521]) , .DATA_B (SUMMAND[522]) , .DATA_C (SUMMAND[523]) , .SAVE (INT_SUM[605]) , .CARRY (INT_CARRY[480]) );
   FULL_ADDER FA_415 (.DATA_A (SUMMAND[524]) , .DATA_B (SUMMAND[525]) , .DATA_C (SUMMAND[526]) , .SAVE (INT_SUM[606]) , .CARRY (INT_CARRY[481]) );
   FULL_ADDER FA_416 (.DATA_A (SUMMAND[527]) , .DATA_B (INT_CARRY[472]) , .DATA_C (INT_CARRY[473]) , .SAVE (INT_SUM[607]) , .CARRY (INT_CARRY[482]) );
   FULL_ADDER FA_417 (.DATA_A (INT_SUM[605]) , .DATA_B (INT_SUM[606]) , .DATA_C (INT_SUM[607]) , .SAVE (INT_SUM[608]) , .CARRY (INT_CARRY[483]) );
   assign INT_SUM[610] = INT_CARRY[474];
   FLIPFLOP LA_155 (.DIN (INT_SUM[608]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[609]) );
   FLIPFLOP LA_156 (.DIN (INT_SUM[610]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[611]) );
   FLIPFLOP LA_157 (.DIN (INT_CARRY[475]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[476]) );
   FULL_ADDER FA_418 (.DATA_A (INT_SUM[609]) , .DATA_B (INT_SUM[611]) , .DATA_C (INT_CARRY[476]) , .SAVE (INT_SUM[612]) , .CARRY (INT_CARRY[485]) );
   FLIPFLOP LA_158 (.DIN (INT_CARRY[477]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[478]) );
   assign INT_SUM[613] = INT_CARRY[478];
   FULL_ADDER FA_419 (.DATA_A (INT_SUM[612]) , .DATA_B (INT_SUM[613]) , .DATA_C (INT_CARRY[479]) , .SAVE (SUM[51]) , .CARRY (CARRY[51]) );
   FULL_ADDER FA_420 (.DATA_A (SUMMAND[528]) , .DATA_B (SUMMAND[529]) , .DATA_C (SUMMAND[530]) , .SAVE (INT_SUM[614]) , .CARRY (INT_CARRY[486]) );
   FULL_ADDER FA_421 (.DATA_A (SUMMAND[531]) , .DATA_B (SUMMAND[532]) , .DATA_C (SUMMAND[533]) , .SAVE (INT_SUM[615]) , .CARRY (INT_CARRY[487]) );
   assign INT_SUM[616] = SUMMAND[534];
   FULL_ADDER FA_422 (.DATA_A (INT_SUM[614]) , .DATA_B (INT_SUM[615]) , .DATA_C (INT_SUM[616]) , .SAVE (INT_SUM[617]) , .CARRY (INT_CARRY[488]) );
   FULL_ADDER FA_423 (.DATA_A (INT_CARRY[480]) , .DATA_B (INT_CARRY[481]) , .DATA_C (INT_CARRY[482]) , .SAVE (INT_SUM[619]) , .CARRY (INT_CARRY[490]) );
   FLIPFLOP LA_159 (.DIN (INT_SUM[617]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[618]) );
   FLIPFLOP LA_160 (.DIN (INT_SUM[619]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[620]) );
   FLIPFLOP LA_161 (.DIN (INT_CARRY[483]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[484]) );
   FULL_ADDER FA_424 (.DATA_A (INT_SUM[618]) , .DATA_B (INT_SUM[620]) , .DATA_C (INT_CARRY[484]) , .SAVE (INT_SUM[621]) , .CARRY (INT_CARRY[492]) );
   HALF_ADDER HA_44 (.DATA_A (INT_SUM[621]) , .DATA_B (INT_CARRY[485]) , .SAVE (SUM[52]) , .CARRY (CARRY[52]) );
   FULL_ADDER FA_425 (.DATA_A (SUMMAND[535]) , .DATA_B (SUMMAND[536]) , .DATA_C (SUMMAND[537]) , .SAVE (INT_SUM[622]) , .CARRY (INT_CARRY[493]) );
   FULL_ADDER FA_426 (.DATA_A (SUMMAND[538]) , .DATA_B (SUMMAND[539]) , .DATA_C (SUMMAND[540]) , .SAVE (INT_SUM[623]) , .CARRY (INT_CARRY[494]) );
   FULL_ADDER FA_427 (.DATA_A (INT_SUM[622]) , .DATA_B (INT_SUM[623]) , .DATA_C (INT_CARRY[486]) , .SAVE (INT_SUM[624]) , .CARRY (INT_CARRY[495]) );
   assign INT_SUM[626] = INT_CARRY[487];
   FLIPFLOP LA_162 (.DIN (INT_SUM[624]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[625]) );
   FLIPFLOP LA_163 (.DIN (INT_SUM[626]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[627]) );
   FLIPFLOP LA_164 (.DIN (INT_CARRY[488]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[489]) );
   FULL_ADDER FA_428 (.DATA_A (INT_SUM[625]) , .DATA_B (INT_SUM[627]) , .DATA_C (INT_CARRY[489]) , .SAVE (INT_SUM[628]) , .CARRY (INT_CARRY[497]) );
   FLIPFLOP LA_165 (.DIN (INT_CARRY[490]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[491]) );
   assign INT_SUM[629] = INT_CARRY[491];
   FULL_ADDER FA_429 (.DATA_A (INT_SUM[628]) , .DATA_B (INT_SUM[629]) , .DATA_C (INT_CARRY[492]) , .SAVE (SUM[53]) , .CARRY (CARRY[53]) );
   FULL_ADDER FA_430 (.DATA_A (SUMMAND[541]) , .DATA_B (SUMMAND[542]) , .DATA_C (SUMMAND[543]) , .SAVE (INT_SUM[630]) , .CARRY (INT_CARRY[498]) );
   FULL_ADDER FA_431 (.DATA_A (SUMMAND[544]) , .DATA_B (SUMMAND[545]) , .DATA_C (SUMMAND[546]) , .SAVE (INT_SUM[631]) , .CARRY (INT_CARRY[499]) );
   FULL_ADDER FA_432 (.DATA_A (INT_SUM[630]) , .DATA_B (INT_SUM[631]) , .DATA_C (INT_CARRY[493]) , .SAVE (INT_SUM[632]) , .CARRY (INT_CARRY[500]) );
   assign INT_SUM[634] = INT_CARRY[494];
   FLIPFLOP LA_166 (.DIN (INT_SUM[632]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[633]) );
   FLIPFLOP LA_167 (.DIN (INT_SUM[634]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[635]) );
   FLIPFLOP LA_168 (.DIN (INT_CARRY[495]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[496]) );
   FULL_ADDER FA_433 (.DATA_A (INT_SUM[633]) , .DATA_B (INT_SUM[635]) , .DATA_C (INT_CARRY[496]) , .SAVE (INT_SUM[636]) , .CARRY (INT_CARRY[502]) );
   HALF_ADDER HA_45 (.DATA_A (INT_SUM[636]) , .DATA_B (INT_CARRY[497]) , .SAVE (SUM[54]) , .CARRY (CARRY[54]) );
   FULL_ADDER FA_434 (.DATA_A (SUMMAND[547]) , .DATA_B (SUMMAND[548]) , .DATA_C (SUMMAND[549]) , .SAVE (INT_SUM[637]) , .CARRY (INT_CARRY[503]) );
   HALF_ADDER HA_46 (.DATA_A (SUMMAND[550]) , .DATA_B (SUMMAND[551]) , .SAVE (INT_SUM[638]) , .CARRY (INT_CARRY[504]) );
   FULL_ADDER FA_435 (.DATA_A (INT_SUM[637]) , .DATA_B (INT_SUM[638]) , .DATA_C (INT_CARRY[498]) , .SAVE (INT_SUM[639]) , .CARRY (INT_CARRY[505]) );
   assign INT_SUM[641] = INT_CARRY[499];
   FLIPFLOP LA_169 (.DIN (INT_SUM[639]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[640]) );
   FLIPFLOP LA_170 (.DIN (INT_SUM[641]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[642]) );
   FLIPFLOP LA_171 (.DIN (INT_CARRY[500]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[501]) );
   FULL_ADDER FA_436 (.DATA_A (INT_SUM[640]) , .DATA_B (INT_SUM[642]) , .DATA_C (INT_CARRY[501]) , .SAVE (INT_SUM[643]) , .CARRY (INT_CARRY[507]) );
   HALF_ADDER HA_47 (.DATA_A (INT_SUM[643]) , .DATA_B (INT_CARRY[502]) , .SAVE (SUM[55]) , .CARRY (CARRY[55]) );
   FULL_ADDER FA_437 (.DATA_A (SUMMAND[552]) , .DATA_B (SUMMAND[553]) , .DATA_C (SUMMAND[554]) , .SAVE (INT_SUM[644]) , .CARRY (INT_CARRY[508]) );
   HALF_ADDER HA_48 (.DATA_A (SUMMAND[555]) , .DATA_B (SUMMAND[556]) , .SAVE (INT_SUM[645]) , .CARRY (INT_CARRY[509]) );
   FULL_ADDER FA_438 (.DATA_A (INT_SUM[644]) , .DATA_B (INT_SUM[645]) , .DATA_C (INT_CARRY[503]) , .SAVE (INT_SUM[646]) , .CARRY (INT_CARRY[510]) );
   assign INT_SUM[648] = INT_CARRY[504];
   FLIPFLOP LA_172 (.DIN (INT_SUM[646]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[647]) );
   FLIPFLOP LA_173 (.DIN (INT_SUM[648]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[649]) );
   FLIPFLOP LA_174 (.DIN (INT_CARRY[505]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[506]) );
   FULL_ADDER FA_439 (.DATA_A (INT_SUM[647]) , .DATA_B (INT_SUM[649]) , .DATA_C (INT_CARRY[506]) , .SAVE (INT_SUM[650]) , .CARRY (INT_CARRY[512]) );
   HALF_ADDER HA_49 (.DATA_A (INT_SUM[650]) , .DATA_B (INT_CARRY[507]) , .SAVE (SUM[56]) , .CARRY (CARRY[56]) );
   FULL_ADDER FA_440 (.DATA_A (SUMMAND[557]) , .DATA_B (SUMMAND[558]) , .DATA_C (SUMMAND[559]) , .SAVE (INT_SUM[651]) , .CARRY (INT_CARRY[513]) );
   FULL_ADDER FA_441 (.DATA_A (SUMMAND[560]) , .DATA_B (INT_CARRY[508]) , .DATA_C (INT_CARRY[509]) , .SAVE (INT_SUM[653]) , .CARRY (INT_CARRY[515]) );
   FLIPFLOP LA_175 (.DIN (INT_SUM[651]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[652]) );
   FLIPFLOP LA_176 (.DIN (INT_SUM[653]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[654]) );
   FLIPFLOP LA_177 (.DIN (INT_CARRY[510]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[511]) );
   FULL_ADDER FA_442 (.DATA_A (INT_SUM[652]) , .DATA_B (INT_SUM[654]) , .DATA_C (INT_CARRY[511]) , .SAVE (INT_SUM[655]) , .CARRY (INT_CARRY[517]) );
   HALF_ADDER HA_50 (.DATA_A (INT_SUM[655]) , .DATA_B (INT_CARRY[512]) , .SAVE (SUM[57]) , .CARRY (CARRY[57]) );
   FULL_ADDER FA_443 (.DATA_A (SUMMAND[561]) , .DATA_B (SUMMAND[562]) , .DATA_C (SUMMAND[563]) , .SAVE (INT_SUM[656]) , .CARRY (INT_CARRY[518]) );
   assign INT_SUM[658] = SUMMAND[564];
   FLIPFLOP LA_178 (.DIN (INT_SUM[656]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[657]) );
   FLIPFLOP LA_179 (.DIN (INT_SUM[658]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[659]) );
   FLIPFLOP LA_180 (.DIN (INT_CARRY[513]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[514]) );
   FULL_ADDER FA_444 (.DATA_A (INT_SUM[657]) , .DATA_B (INT_SUM[659]) , .DATA_C (INT_CARRY[514]) , .SAVE (INT_SUM[660]) , .CARRY (INT_CARRY[520]) );
   FLIPFLOP LA_181 (.DIN (INT_CARRY[515]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[516]) );
   assign INT_SUM[661] = INT_CARRY[516];
   FULL_ADDER FA_445 (.DATA_A (INT_SUM[660]) , .DATA_B (INT_SUM[661]) , .DATA_C (INT_CARRY[517]) , .SAVE (SUM[58]) , .CARRY (CARRY[58]) );
   FULL_ADDER FA_446 (.DATA_A (SUMMAND[565]) , .DATA_B (SUMMAND[566]) , .DATA_C (SUMMAND[567]) , .SAVE (INT_SUM[662]) , .CARRY (INT_CARRY[521]) );
   FLIPFLOP LA_182 (.DIN (INT_SUM[662]) , .RST(RST), .CLK (CLK) , .DOUT (INT_SUM[663]) );
   assign INT_SUM[664] = INT_SUM[663];
   FLIPFLOP LA_183 (.DIN (INT_CARRY[518]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[519]) );
   assign INT_SUM[665] = INT_CARRY[519];
   FULL_ADDER FA_447 (.DATA_A (INT_SUM[664]) , .DATA_B (INT_SUM[665]) , .DATA_C (INT_CARRY[520]) , .SAVE (SUM[59]) , .CARRY (CARRY[59]) );
   FLIPFLOP LA_184 (.DIN (SUMMAND[568]) , .RST(RST), .CLK (CLK) , .DOUT (LATCHED_PP[0]) );
   FLIPFLOP LA_185 (.DIN (SUMMAND[569]) , .RST(RST), .CLK (CLK) , .DOUT (LATCHED_PP[1]) );
   FLIPFLOP LA_186 (.DIN (SUMMAND[570]) , .RST(RST), .CLK (CLK) , .DOUT (LATCHED_PP[2]) );
   FULL_ADDER FA_448 (.DATA_A (LATCHED_PP[0]) , .DATA_B (LATCHED_PP[1]) , .DATA_C (LATCHED_PP[2]) , .SAVE (INT_SUM[666]) , .CARRY (INT_CARRY[523]) );
   FLIPFLOP LA_187 (.DIN (INT_CARRY[521]) , .RST(RST), .CLK (CLK) , .DOUT (INT_CARRY[522]) );
   assign INT_SUM[667] = INT_CARRY[522];
   HALF_ADDER HA_51 (.DATA_A (INT_SUM[666]) , .DATA_B (INT_SUM[667]) , .SAVE (SUM[60]) , .CARRY (CARRY[60]) );
   FLIPFLOP LA_188 (.DIN (SUMMAND[571]) , .RST(RST), .CLK (CLK) , .DOUT (LATCHED_PP[3]) );
   assign INT_SUM[668] = LATCHED_PP[3];
   FLIPFLOP LA_189 (.DIN (SUMMAND[572]) , .RST(RST), .CLK (CLK) , .DOUT (LATCHED_PP[4]) );
   assign INT_SUM[669] = LATCHED_PP[4];
   FULL_ADDER FA_449 (.DATA_A (INT_SUM[668]) , .DATA_B (INT_SUM[669]) , .DATA_C (INT_CARRY[523]) , .SAVE (SUM[61]) , .CARRY (CARRY[61]) );
   FLIPFLOP LA_190 (.DIN (SUMMAND[573]) , .RST(RST), .CLK (CLK) , .DOUT (LATCHED_PP[5]) );
   FLIPFLOP LA_191 (.DIN (SUMMAND[574]) , .RST(RST), .CLK (CLK) , .DOUT (LATCHED_PP[6]) );
   HALF_ADDER HA_52 (.DATA_A (LATCHED_PP[5]) , .DATA_B (LATCHED_PP[6]) , .SAVE (SUM[62]) , .CARRY (CARRY[62]) );
   FLIPFLOP LA_192 (.DIN (SUMMAND[575]) , .RST(RST), .CLK (CLK) , .DOUT (LATCHED_PP[7]) );
   assign SUM[63] = LATCHED_PP[7];
endmodule


module INVBLOCK ( GIN, PHI, GOUT );
input  GIN;
input  PHI;
output GOUT;
   assign GOUT =  ~ GIN;
endmodule


module XXOR1 ( A, B, GIN, PHI, SUM );
input  A;
input  B;
input  GIN;
input  PHI;
output SUM;
   assign SUM = ( ~ (A ^ B)) ^ GIN;
endmodule


module BLOCK0 ( A, B, PHI, POUT, GOUT );
input  A;
input  B;
input  PHI;
output POUT;
output GOUT;
   assign POUT =  ~ (A | B);
   assign GOUT =  ~ (A & B);
endmodule


module BLOCK1 ( PIN1, PIN2, GIN1, GIN2, PHI, POUT, GOUT );
input  PIN1;
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output POUT;
output GOUT;
   assign POUT =  ~ (PIN1 | PIN2);
   assign GOUT =  ~ (GIN2 & (PIN2 | GIN1));
endmodule


module BLOCK2 ( PIN1, PIN2, GIN1, GIN2, PHI, POUT, GOUT );
input  PIN1;
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output POUT;
output GOUT;
   assign POUT =  ~ (PIN1 & PIN2);
   assign GOUT =  ~ (GIN2 | (PIN2 & GIN1));
endmodule


module BLOCK1A ( PIN2, GIN1, GIN2, PHI, GOUT );
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output GOUT;
   assign GOUT =  ~ (GIN2 & (PIN2 | GIN1));
endmodule


module BLOCK2A ( PIN2, GIN1, GIN2, PHI, GOUT );
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output GOUT;
   assign GOUT =  ~ (GIN2 | (PIN2 & GIN1));
endmodule


module PRESTAGE_64 ( A, B, CIN, PHI, POUT, GOUT );
input  [0:63] A;
input  [0:63] B;
input  CIN;
input  PHI;
output [0:63] POUT;
output [0:64] GOUT;
   BLOCK0 U10 (A[0] , B[0] , PHI , POUT[0] , GOUT[1] );
   BLOCK0 U11 (A[1] , B[1] , PHI , POUT[1] , GOUT[2] );
   BLOCK0 U12 (A[2] , B[2] , PHI , POUT[2] , GOUT[3] );
   BLOCK0 U13 (A[3] , B[3] , PHI , POUT[3] , GOUT[4] );
   BLOCK0 U14 (A[4] , B[4] , PHI , POUT[4] , GOUT[5] );
   BLOCK0 U15 (A[5] , B[5] , PHI , POUT[5] , GOUT[6] );
   BLOCK0 U16 (A[6] , B[6] , PHI , POUT[6] , GOUT[7] );
   BLOCK0 U17 (A[7] , B[7] , PHI , POUT[7] , GOUT[8] );
   BLOCK0 U18 (A[8] , B[8] , PHI , POUT[8] , GOUT[9] );
   BLOCK0 U19 (A[9] , B[9] , PHI , POUT[9] , GOUT[10] );
   BLOCK0 U110 (A[10] , B[10] , PHI , POUT[10] , GOUT[11] );
   BLOCK0 U111 (A[11] , B[11] , PHI , POUT[11] , GOUT[12] );
   BLOCK0 U112 (A[12] , B[12] , PHI , POUT[12] , GOUT[13] );
   BLOCK0 U113 (A[13] , B[13] , PHI , POUT[13] , GOUT[14] );
   BLOCK0 U114 (A[14] , B[14] , PHI , POUT[14] , GOUT[15] );
   BLOCK0 U115 (A[15] , B[15] , PHI , POUT[15] , GOUT[16] );
   BLOCK0 U116 (A[16] , B[16] , PHI , POUT[16] , GOUT[17] );
   BLOCK0 U117 (A[17] , B[17] , PHI , POUT[17] , GOUT[18] );
   BLOCK0 U118 (A[18] , B[18] , PHI , POUT[18] , GOUT[19] );
   BLOCK0 U119 (A[19] , B[19] , PHI , POUT[19] , GOUT[20] );
   BLOCK0 U120 (A[20] , B[20] , PHI , POUT[20] , GOUT[21] );
   BLOCK0 U121 (A[21] , B[21] , PHI , POUT[21] , GOUT[22] );
   BLOCK0 U122 (A[22] , B[22] , PHI , POUT[22] , GOUT[23] );
   BLOCK0 U123 (A[23] , B[23] , PHI , POUT[23] , GOUT[24] );
   BLOCK0 U124 (A[24] , B[24] , PHI , POUT[24] , GOUT[25] );
   BLOCK0 U125 (A[25] , B[25] , PHI , POUT[25] , GOUT[26] );
   BLOCK0 U126 (A[26] , B[26] , PHI , POUT[26] , GOUT[27] );
   BLOCK0 U127 (A[27] , B[27] , PHI , POUT[27] , GOUT[28] );
   BLOCK0 U128 (A[28] , B[28] , PHI , POUT[28] , GOUT[29] );
   BLOCK0 U129 (A[29] , B[29] , PHI , POUT[29] , GOUT[30] );
   BLOCK0 U130 (A[30] , B[30] , PHI , POUT[30] , GOUT[31] );
   BLOCK0 U131 (A[31] , B[31] , PHI , POUT[31] , GOUT[32] );
   BLOCK0 U132 (A[32] , B[32] , PHI , POUT[32] , GOUT[33] );
   BLOCK0 U133 (A[33] , B[33] , PHI , POUT[33] , GOUT[34] );
   BLOCK0 U134 (A[34] , B[34] , PHI , POUT[34] , GOUT[35] );
   BLOCK0 U135 (A[35] , B[35] , PHI , POUT[35] , GOUT[36] );
   BLOCK0 U136 (A[36] , B[36] , PHI , POUT[36] , GOUT[37] );
   BLOCK0 U137 (A[37] , B[37] , PHI , POUT[37] , GOUT[38] );
   BLOCK0 U138 (A[38] , B[38] , PHI , POUT[38] , GOUT[39] );
   BLOCK0 U139 (A[39] , B[39] , PHI , POUT[39] , GOUT[40] );
   BLOCK0 U140 (A[40] , B[40] , PHI , POUT[40] , GOUT[41] );
   BLOCK0 U141 (A[41] , B[41] , PHI , POUT[41] , GOUT[42] );
   BLOCK0 U142 (A[42] , B[42] , PHI , POUT[42] , GOUT[43] );
   BLOCK0 U143 (A[43] , B[43] , PHI , POUT[43] , GOUT[44] );
   BLOCK0 U144 (A[44] , B[44] , PHI , POUT[44] , GOUT[45] );
   BLOCK0 U145 (A[45] , B[45] , PHI , POUT[45] , GOUT[46] );
   BLOCK0 U146 (A[46] , B[46] , PHI , POUT[46] , GOUT[47] );
   BLOCK0 U147 (A[47] , B[47] , PHI , POUT[47] , GOUT[48] );
   BLOCK0 U148 (A[48] , B[48] , PHI , POUT[48] , GOUT[49] );
   BLOCK0 U149 (A[49] , B[49] , PHI , POUT[49] , GOUT[50] );
   BLOCK0 U150 (A[50] , B[50] , PHI , POUT[50] , GOUT[51] );
   BLOCK0 U151 (A[51] , B[51] , PHI , POUT[51] , GOUT[52] );
   BLOCK0 U152 (A[52] , B[52] , PHI , POUT[52] , GOUT[53] );
   BLOCK0 U153 (A[53] , B[53] , PHI , POUT[53] , GOUT[54] );
   BLOCK0 U154 (A[54] , B[54] , PHI , POUT[54] , GOUT[55] );
   BLOCK0 U155 (A[55] , B[55] , PHI , POUT[55] , GOUT[56] );
   BLOCK0 U156 (A[56] , B[56] , PHI , POUT[56] , GOUT[57] );
   BLOCK0 U157 (A[57] , B[57] , PHI , POUT[57] , GOUT[58] );
   BLOCK0 U158 (A[58] , B[58] , PHI , POUT[58] , GOUT[59] );
   BLOCK0 U159 (A[59] , B[59] , PHI , POUT[59] , GOUT[60] );
   BLOCK0 U160 (A[60] , B[60] , PHI , POUT[60] , GOUT[61] );
   BLOCK0 U161 (A[61] , B[61] , PHI , POUT[61] , GOUT[62] );
   BLOCK0 U162 (A[62] , B[62] , PHI , POUT[62] , GOUT[63] );
   BLOCK0 U163 (A[63] , B[63] , PHI , POUT[63] , GOUT[64] );
   INVBLOCK U2 (CIN , PHI , GOUT[0] );
endmodule


module DBLC_0_64 ( PIN, GIN, PHI, POUT, GOUT );
input  [0:63] PIN;
input  [0:64] GIN;
input  PHI;
output [0:62] POUT;
output [0:64] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   BLOCK1A U21 (PIN[0] , GIN[0] , GIN[1] , PHI , GOUT[1] );
   BLOCK1 U32 (PIN[0] , PIN[1] , GIN[1] , GIN[2] , PHI , POUT[0] , GOUT[2] );
   BLOCK1 U33 (PIN[1] , PIN[2] , GIN[2] , GIN[3] , PHI , POUT[1] , GOUT[3] );
   BLOCK1 U34 (PIN[2] , PIN[3] , GIN[3] , GIN[4] , PHI , POUT[2] , GOUT[4] );
   BLOCK1 U35 (PIN[3] , PIN[4] , GIN[4] , GIN[5] , PHI , POUT[3] , GOUT[5] );
   BLOCK1 U36 (PIN[4] , PIN[5] , GIN[5] , GIN[6] , PHI , POUT[4] , GOUT[6] );
   BLOCK1 U37 (PIN[5] , PIN[6] , GIN[6] , GIN[7] , PHI , POUT[5] , GOUT[7] );
   BLOCK1 U38 (PIN[6] , PIN[7] , GIN[7] , GIN[8] , PHI , POUT[6] , GOUT[8] );
   BLOCK1 U39 (PIN[7] , PIN[8] , GIN[8] , GIN[9] , PHI , POUT[7] , GOUT[9] );
   BLOCK1 U310 (PIN[8] , PIN[9] , GIN[9] , GIN[10] , PHI , POUT[8] , GOUT[10] );
   BLOCK1 U311 (PIN[9] , PIN[10] , GIN[10] , GIN[11] , PHI , POUT[9] , GOUT[11] );
   BLOCK1 U312 (PIN[10] , PIN[11] , GIN[11] , GIN[12] , PHI , POUT[10] , GOUT[12] );
   BLOCK1 U313 (PIN[11] , PIN[12] , GIN[12] , GIN[13] , PHI , POUT[11] , GOUT[13] );
   BLOCK1 U314 (PIN[12] , PIN[13] , GIN[13] , GIN[14] , PHI , POUT[12] , GOUT[14] );
   BLOCK1 U315 (PIN[13] , PIN[14] , GIN[14] , GIN[15] , PHI , POUT[13] , GOUT[15] );
   BLOCK1 U316 (PIN[14] , PIN[15] , GIN[15] , GIN[16] , PHI , POUT[14] , GOUT[16] );
   BLOCK1 U317 (PIN[15] , PIN[16] , GIN[16] , GIN[17] , PHI , POUT[15] , GOUT[17] );
   BLOCK1 U318 (PIN[16] , PIN[17] , GIN[17] , GIN[18] , PHI , POUT[16] , GOUT[18] );
   BLOCK1 U319 (PIN[17] , PIN[18] , GIN[18] , GIN[19] , PHI , POUT[17] , GOUT[19] );
   BLOCK1 U320 (PIN[18] , PIN[19] , GIN[19] , GIN[20] , PHI , POUT[18] , GOUT[20] );
   BLOCK1 U321 (PIN[19] , PIN[20] , GIN[20] , GIN[21] , PHI , POUT[19] , GOUT[21] );
   BLOCK1 U322 (PIN[20] , PIN[21] , GIN[21] , GIN[22] , PHI , POUT[20] , GOUT[22] );
   BLOCK1 U323 (PIN[21] , PIN[22] , GIN[22] , GIN[23] , PHI , POUT[21] , GOUT[23] );
   BLOCK1 U324 (PIN[22] , PIN[23] , GIN[23] , GIN[24] , PHI , POUT[22] , GOUT[24] );
   BLOCK1 U325 (PIN[23] , PIN[24] , GIN[24] , GIN[25] , PHI , POUT[23] , GOUT[25] );
   BLOCK1 U326 (PIN[24] , PIN[25] , GIN[25] , GIN[26] , PHI , POUT[24] , GOUT[26] );
   BLOCK1 U327 (PIN[25] , PIN[26] , GIN[26] , GIN[27] , PHI , POUT[25] , GOUT[27] );
   BLOCK1 U328 (PIN[26] , PIN[27] , GIN[27] , GIN[28] , PHI , POUT[26] , GOUT[28] );
   BLOCK1 U329 (PIN[27] , PIN[28] , GIN[28] , GIN[29] , PHI , POUT[27] , GOUT[29] );
   BLOCK1 U330 (PIN[28] , PIN[29] , GIN[29] , GIN[30] , PHI , POUT[28] , GOUT[30] );
   BLOCK1 U331 (PIN[29] , PIN[30] , GIN[30] , GIN[31] , PHI , POUT[29] , GOUT[31] );
   BLOCK1 U332 (PIN[30] , PIN[31] , GIN[31] , GIN[32] , PHI , POUT[30] , GOUT[32] );
   BLOCK1 U333 (PIN[31] , PIN[32] , GIN[32] , GIN[33] , PHI , POUT[31] , GOUT[33] );
   BLOCK1 U334 (PIN[32] , PIN[33] , GIN[33] , GIN[34] , PHI , POUT[32] , GOUT[34] );
   BLOCK1 U335 (PIN[33] , PIN[34] , GIN[34] , GIN[35] , PHI , POUT[33] , GOUT[35] );
   BLOCK1 U336 (PIN[34] , PIN[35] , GIN[35] , GIN[36] , PHI , POUT[34] , GOUT[36] );
   BLOCK1 U337 (PIN[35] , PIN[36] , GIN[36] , GIN[37] , PHI , POUT[35] , GOUT[37] );
   BLOCK1 U338 (PIN[36] , PIN[37] , GIN[37] , GIN[38] , PHI , POUT[36] , GOUT[38] );
   BLOCK1 U339 (PIN[37] , PIN[38] , GIN[38] , GIN[39] , PHI , POUT[37] , GOUT[39] );
   BLOCK1 U340 (PIN[38] , PIN[39] , GIN[39] , GIN[40] , PHI , POUT[38] , GOUT[40] );
   BLOCK1 U341 (PIN[39] , PIN[40] , GIN[40] , GIN[41] , PHI , POUT[39] , GOUT[41] );
   BLOCK1 U342 (PIN[40] , PIN[41] , GIN[41] , GIN[42] , PHI , POUT[40] , GOUT[42] );
   BLOCK1 U343 (PIN[41] , PIN[42] , GIN[42] , GIN[43] , PHI , POUT[41] , GOUT[43] );
   BLOCK1 U344 (PIN[42] , PIN[43] , GIN[43] , GIN[44] , PHI , POUT[42] , GOUT[44] );
   BLOCK1 U345 (PIN[43] , PIN[44] , GIN[44] , GIN[45] , PHI , POUT[43] , GOUT[45] );
   BLOCK1 U346 (PIN[44] , PIN[45] , GIN[45] , GIN[46] , PHI , POUT[44] , GOUT[46] );
   BLOCK1 U347 (PIN[45] , PIN[46] , GIN[46] , GIN[47] , PHI , POUT[45] , GOUT[47] );
   BLOCK1 U348 (PIN[46] , PIN[47] , GIN[47] , GIN[48] , PHI , POUT[46] , GOUT[48] );
   BLOCK1 U349 (PIN[47] , PIN[48] , GIN[48] , GIN[49] , PHI , POUT[47] , GOUT[49] );
   BLOCK1 U350 (PIN[48] , PIN[49] , GIN[49] , GIN[50] , PHI , POUT[48] , GOUT[50] );
   BLOCK1 U351 (PIN[49] , PIN[50] , GIN[50] , GIN[51] , PHI , POUT[49] , GOUT[51] );
   BLOCK1 U352 (PIN[50] , PIN[51] , GIN[51] , GIN[52] , PHI , POUT[50] , GOUT[52] );
   BLOCK1 U353 (PIN[51] , PIN[52] , GIN[52] , GIN[53] , PHI , POUT[51] , GOUT[53] );
   BLOCK1 U354 (PIN[52] , PIN[53] , GIN[53] , GIN[54] , PHI , POUT[52] , GOUT[54] );
   BLOCK1 U355 (PIN[53] , PIN[54] , GIN[54] , GIN[55] , PHI , POUT[53] , GOUT[55] );
   BLOCK1 U356 (PIN[54] , PIN[55] , GIN[55] , GIN[56] , PHI , POUT[54] , GOUT[56] );
   BLOCK1 U357 (PIN[55] , PIN[56] , GIN[56] , GIN[57] , PHI , POUT[55] , GOUT[57] );
   BLOCK1 U358 (PIN[56] , PIN[57] , GIN[57] , GIN[58] , PHI , POUT[56] , GOUT[58] );
   BLOCK1 U359 (PIN[57] , PIN[58] , GIN[58] , GIN[59] , PHI , POUT[57] , GOUT[59] );
   BLOCK1 U360 (PIN[58] , PIN[59] , GIN[59] , GIN[60] , PHI , POUT[58] , GOUT[60] );
   BLOCK1 U361 (PIN[59] , PIN[60] , GIN[60] , GIN[61] , PHI , POUT[59] , GOUT[61] );
   BLOCK1 U362 (PIN[60] , PIN[61] , GIN[61] , GIN[62] , PHI , POUT[60] , GOUT[62] );
   BLOCK1 U363 (PIN[61] , PIN[62] , GIN[62] , GIN[63] , PHI , POUT[61] , GOUT[63] );
   BLOCK1 U364 (PIN[62] , PIN[63] , GIN[63] , GIN[64] , PHI , POUT[62] , GOUT[64] );
endmodule


module DBLC_1_64 ( PIN, GIN, PHI, POUT, GOUT );
input  [0:62] PIN;
input  [0:64] GIN;
input  PHI;
output [0:60] POUT;
output [0:64] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   BLOCK2A U22 (PIN[0] , GIN[0] , GIN[2] , PHI , GOUT[2] );
   BLOCK2A U23 (PIN[1] , GIN[1] , GIN[3] , PHI , GOUT[3] );
   BLOCK2 U34 (PIN[0] , PIN[2] , GIN[2] , GIN[4] , PHI , POUT[0] , GOUT[4] );
   BLOCK2 U35 (PIN[1] , PIN[3] , GIN[3] , GIN[5] , PHI , POUT[1] , GOUT[5] );
   BLOCK2 U36 (PIN[2] , PIN[4] , GIN[4] , GIN[6] , PHI , POUT[2] , GOUT[6] );
   BLOCK2 U37 (PIN[3] , PIN[5] , GIN[5] , GIN[7] , PHI , POUT[3] , GOUT[7] );
   BLOCK2 U38 (PIN[4] , PIN[6] , GIN[6] , GIN[8] , PHI , POUT[4] , GOUT[8] );
   BLOCK2 U39 (PIN[5] , PIN[7] , GIN[7] , GIN[9] , PHI , POUT[5] , GOUT[9] );
   BLOCK2 U310 (PIN[6] , PIN[8] , GIN[8] , GIN[10] , PHI , POUT[6] , GOUT[10] );
   BLOCK2 U311 (PIN[7] , PIN[9] , GIN[9] , GIN[11] , PHI , POUT[7] , GOUT[11] );
   BLOCK2 U312 (PIN[8] , PIN[10] , GIN[10] , GIN[12] , PHI , POUT[8] , GOUT[12] );
   BLOCK2 U313 (PIN[9] , PIN[11] , GIN[11] , GIN[13] , PHI , POUT[9] , GOUT[13] );
   BLOCK2 U314 (PIN[10] , PIN[12] , GIN[12] , GIN[14] , PHI , POUT[10] , GOUT[14] );
   BLOCK2 U315 (PIN[11] , PIN[13] , GIN[13] , GIN[15] , PHI , POUT[11] , GOUT[15] );
   BLOCK2 U316 (PIN[12] , PIN[14] , GIN[14] , GIN[16] , PHI , POUT[12] , GOUT[16] );
   BLOCK2 U317 (PIN[13] , PIN[15] , GIN[15] , GIN[17] , PHI , POUT[13] , GOUT[17] );
   BLOCK2 U318 (PIN[14] , PIN[16] , GIN[16] , GIN[18] , PHI , POUT[14] , GOUT[18] );
   BLOCK2 U319 (PIN[15] , PIN[17] , GIN[17] , GIN[19] , PHI , POUT[15] , GOUT[19] );
   BLOCK2 U320 (PIN[16] , PIN[18] , GIN[18] , GIN[20] , PHI , POUT[16] , GOUT[20] );
   BLOCK2 U321 (PIN[17] , PIN[19] , GIN[19] , GIN[21] , PHI , POUT[17] , GOUT[21] );
   BLOCK2 U322 (PIN[18] , PIN[20] , GIN[20] , GIN[22] , PHI , POUT[18] , GOUT[22] );
   BLOCK2 U323 (PIN[19] , PIN[21] , GIN[21] , GIN[23] , PHI , POUT[19] , GOUT[23] );
   BLOCK2 U324 (PIN[20] , PIN[22] , GIN[22] , GIN[24] , PHI , POUT[20] , GOUT[24] );
   BLOCK2 U325 (PIN[21] , PIN[23] , GIN[23] , GIN[25] , PHI , POUT[21] , GOUT[25] );
   BLOCK2 U326 (PIN[22] , PIN[24] , GIN[24] , GIN[26] , PHI , POUT[22] , GOUT[26] );
   BLOCK2 U327 (PIN[23] , PIN[25] , GIN[25] , GIN[27] , PHI , POUT[23] , GOUT[27] );
   BLOCK2 U328 (PIN[24] , PIN[26] , GIN[26] , GIN[28] , PHI , POUT[24] , GOUT[28] );
   BLOCK2 U329 (PIN[25] , PIN[27] , GIN[27] , GIN[29] , PHI , POUT[25] , GOUT[29] );
   BLOCK2 U330 (PIN[26] , PIN[28] , GIN[28] , GIN[30] , PHI , POUT[26] , GOUT[30] );
   BLOCK2 U331 (PIN[27] , PIN[29] , GIN[29] , GIN[31] , PHI , POUT[27] , GOUT[31] );
   BLOCK2 U332 (PIN[28] , PIN[30] , GIN[30] , GIN[32] , PHI , POUT[28] , GOUT[32] );
   BLOCK2 U333 (PIN[29] , PIN[31] , GIN[31] , GIN[33] , PHI , POUT[29] , GOUT[33] );
   BLOCK2 U334 (PIN[30] , PIN[32] , GIN[32] , GIN[34] , PHI , POUT[30] , GOUT[34] );
   BLOCK2 U335 (PIN[31] , PIN[33] , GIN[33] , GIN[35] , PHI , POUT[31] , GOUT[35] );
   BLOCK2 U336 (PIN[32] , PIN[34] , GIN[34] , GIN[36] , PHI , POUT[32] , GOUT[36] );
   BLOCK2 U337 (PIN[33] , PIN[35] , GIN[35] , GIN[37] , PHI , POUT[33] , GOUT[37] );
   BLOCK2 U338 (PIN[34] , PIN[36] , GIN[36] , GIN[38] , PHI , POUT[34] , GOUT[38] );
   BLOCK2 U339 (PIN[35] , PIN[37] , GIN[37] , GIN[39] , PHI , POUT[35] , GOUT[39] );
   BLOCK2 U340 (PIN[36] , PIN[38] , GIN[38] , GIN[40] , PHI , POUT[36] , GOUT[40] );
   BLOCK2 U341 (PIN[37] , PIN[39] , GIN[39] , GIN[41] , PHI , POUT[37] , GOUT[41] );
   BLOCK2 U342 (PIN[38] , PIN[40] , GIN[40] , GIN[42] , PHI , POUT[38] , GOUT[42] );
   BLOCK2 U343 (PIN[39] , PIN[41] , GIN[41] , GIN[43] , PHI , POUT[39] , GOUT[43] );
   BLOCK2 U344 (PIN[40] , PIN[42] , GIN[42] , GIN[44] , PHI , POUT[40] , GOUT[44] );
   BLOCK2 U345 (PIN[41] , PIN[43] , GIN[43] , GIN[45] , PHI , POUT[41] , GOUT[45] );
   BLOCK2 U346 (PIN[42] , PIN[44] , GIN[44] , GIN[46] , PHI , POUT[42] , GOUT[46] );
   BLOCK2 U347 (PIN[43] , PIN[45] , GIN[45] , GIN[47] , PHI , POUT[43] , GOUT[47] );
   BLOCK2 U348 (PIN[44] , PIN[46] , GIN[46] , GIN[48] , PHI , POUT[44] , GOUT[48] );
   BLOCK2 U349 (PIN[45] , PIN[47] , GIN[47] , GIN[49] , PHI , POUT[45] , GOUT[49] );
   BLOCK2 U350 (PIN[46] , PIN[48] , GIN[48] , GIN[50] , PHI , POUT[46] , GOUT[50] );
   BLOCK2 U351 (PIN[47] , PIN[49] , GIN[49] , GIN[51] , PHI , POUT[47] , GOUT[51] );
   BLOCK2 U352 (PIN[48] , PIN[50] , GIN[50] , GIN[52] , PHI , POUT[48] , GOUT[52] );
   BLOCK2 U353 (PIN[49] , PIN[51] , GIN[51] , GIN[53] , PHI , POUT[49] , GOUT[53] );
   BLOCK2 U354 (PIN[50] , PIN[52] , GIN[52] , GIN[54] , PHI , POUT[50] , GOUT[54] );
   BLOCK2 U355 (PIN[51] , PIN[53] , GIN[53] , GIN[55] , PHI , POUT[51] , GOUT[55] );
   BLOCK2 U356 (PIN[52] , PIN[54] , GIN[54] , GIN[56] , PHI , POUT[52] , GOUT[56] );
   BLOCK2 U357 (PIN[53] , PIN[55] , GIN[55] , GIN[57] , PHI , POUT[53] , GOUT[57] );
   BLOCK2 U358 (PIN[54] , PIN[56] , GIN[56] , GIN[58] , PHI , POUT[54] , GOUT[58] );
   BLOCK2 U359 (PIN[55] , PIN[57] , GIN[57] , GIN[59] , PHI , POUT[55] , GOUT[59] );
   BLOCK2 U360 (PIN[56] , PIN[58] , GIN[58] , GIN[60] , PHI , POUT[56] , GOUT[60] );
   BLOCK2 U361 (PIN[57] , PIN[59] , GIN[59] , GIN[61] , PHI , POUT[57] , GOUT[61] );
   BLOCK2 U362 (PIN[58] , PIN[60] , GIN[60] , GIN[62] , PHI , POUT[58] , GOUT[62] );
   BLOCK2 U363 (PIN[59] , PIN[61] , GIN[61] , GIN[63] , PHI , POUT[59] , GOUT[63] );
   BLOCK2 U364 (PIN[60] , PIN[62] , GIN[62] , GIN[64] , PHI , POUT[60] , GOUT[64] );
endmodule


module DBLC_2_64 ( PIN, GIN, PHI, POUT, GOUT );
input  [0:60] PIN;
input  [0:64] GIN;
input  PHI;
output [0:56] POUT;
output [0:64] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   INVBLOCK U12 (GIN[2] , PHI , GOUT[2] );
   INVBLOCK U13 (GIN[3] , PHI , GOUT[3] );
   BLOCK1A U24 (PIN[0] , GIN[0] , GIN[4] , PHI , GOUT[4] );
   BLOCK1A U25 (PIN[1] , GIN[1] , GIN[5] , PHI , GOUT[5] );
   BLOCK1A U26 (PIN[2] , GIN[2] , GIN[6] , PHI , GOUT[6] );
   BLOCK1A U27 (PIN[3] , GIN[3] , GIN[7] , PHI , GOUT[7] );
   BLOCK1 U38 (PIN[0] , PIN[4] , GIN[4] , GIN[8] , PHI , POUT[0] , GOUT[8] );
   BLOCK1 U39 (PIN[1] , PIN[5] , GIN[5] , GIN[9] , PHI , POUT[1] , GOUT[9] );
   BLOCK1 U310 (PIN[2] , PIN[6] , GIN[6] , GIN[10] , PHI , POUT[2] , GOUT[10] );
   BLOCK1 U311 (PIN[3] , PIN[7] , GIN[7] , GIN[11] , PHI , POUT[3] , GOUT[11] );
   BLOCK1 U312 (PIN[4] , PIN[8] , GIN[8] , GIN[12] , PHI , POUT[4] , GOUT[12] );
   BLOCK1 U313 (PIN[5] , PIN[9] , GIN[9] , GIN[13] , PHI , POUT[5] , GOUT[13] );
   BLOCK1 U314 (PIN[6] , PIN[10] , GIN[10] , GIN[14] , PHI , POUT[6] , GOUT[14] );
   BLOCK1 U315 (PIN[7] , PIN[11] , GIN[11] , GIN[15] , PHI , POUT[7] , GOUT[15] );
   BLOCK1 U316 (PIN[8] , PIN[12] , GIN[12] , GIN[16] , PHI , POUT[8] , GOUT[16] );
   BLOCK1 U317 (PIN[9] , PIN[13] , GIN[13] , GIN[17] , PHI , POUT[9] , GOUT[17] );
   BLOCK1 U318 (PIN[10] , PIN[14] , GIN[14] , GIN[18] , PHI , POUT[10] , GOUT[18] );
   BLOCK1 U319 (PIN[11] , PIN[15] , GIN[15] , GIN[19] , PHI , POUT[11] , GOUT[19] );
   BLOCK1 U320 (PIN[12] , PIN[16] , GIN[16] , GIN[20] , PHI , POUT[12] , GOUT[20] );
   BLOCK1 U321 (PIN[13] , PIN[17] , GIN[17] , GIN[21] , PHI , POUT[13] , GOUT[21] );
   BLOCK1 U322 (PIN[14] , PIN[18] , GIN[18] , GIN[22] , PHI , POUT[14] , GOUT[22] );
   BLOCK1 U323 (PIN[15] , PIN[19] , GIN[19] , GIN[23] , PHI , POUT[15] , GOUT[23] );
   BLOCK1 U324 (PIN[16] , PIN[20] , GIN[20] , GIN[24] , PHI , POUT[16] , GOUT[24] );
   BLOCK1 U325 (PIN[17] , PIN[21] , GIN[21] , GIN[25] , PHI , POUT[17] , GOUT[25] );
   BLOCK1 U326 (PIN[18] , PIN[22] , GIN[22] , GIN[26] , PHI , POUT[18] , GOUT[26] );
   BLOCK1 U327 (PIN[19] , PIN[23] , GIN[23] , GIN[27] , PHI , POUT[19] , GOUT[27] );
   BLOCK1 U328 (PIN[20] , PIN[24] , GIN[24] , GIN[28] , PHI , POUT[20] , GOUT[28] );
   BLOCK1 U329 (PIN[21] , PIN[25] , GIN[25] , GIN[29] , PHI , POUT[21] , GOUT[29] );
   BLOCK1 U330 (PIN[22] , PIN[26] , GIN[26] , GIN[30] , PHI , POUT[22] , GOUT[30] );
   BLOCK1 U331 (PIN[23] , PIN[27] , GIN[27] , GIN[31] , PHI , POUT[23] , GOUT[31] );
   BLOCK1 U332 (PIN[24] , PIN[28] , GIN[28] , GIN[32] , PHI , POUT[24] , GOUT[32] );
   BLOCK1 U333 (PIN[25] , PIN[29] , GIN[29] , GIN[33] , PHI , POUT[25] , GOUT[33] );
   BLOCK1 U334 (PIN[26] , PIN[30] , GIN[30] , GIN[34] , PHI , POUT[26] , GOUT[34] );
   BLOCK1 U335 (PIN[27] , PIN[31] , GIN[31] , GIN[35] , PHI , POUT[27] , GOUT[35] );
   BLOCK1 U336 (PIN[28] , PIN[32] , GIN[32] , GIN[36] , PHI , POUT[28] , GOUT[36] );
   BLOCK1 U337 (PIN[29] , PIN[33] , GIN[33] , GIN[37] , PHI , POUT[29] , GOUT[37] );
   BLOCK1 U338 (PIN[30] , PIN[34] , GIN[34] , GIN[38] , PHI , POUT[30] , GOUT[38] );
   BLOCK1 U339 (PIN[31] , PIN[35] , GIN[35] , GIN[39] , PHI , POUT[31] , GOUT[39] );
   BLOCK1 U340 (PIN[32] , PIN[36] , GIN[36] , GIN[40] , PHI , POUT[32] , GOUT[40] );
   BLOCK1 U341 (PIN[33] , PIN[37] , GIN[37] , GIN[41] , PHI , POUT[33] , GOUT[41] );
   BLOCK1 U342 (PIN[34] , PIN[38] , GIN[38] , GIN[42] , PHI , POUT[34] , GOUT[42] );
   BLOCK1 U343 (PIN[35] , PIN[39] , GIN[39] , GIN[43] , PHI , POUT[35] , GOUT[43] );
   BLOCK1 U344 (PIN[36] , PIN[40] , GIN[40] , GIN[44] , PHI , POUT[36] , GOUT[44] );
   BLOCK1 U345 (PIN[37] , PIN[41] , GIN[41] , GIN[45] , PHI , POUT[37] , GOUT[45] );
   BLOCK1 U346 (PIN[38] , PIN[42] , GIN[42] , GIN[46] , PHI , POUT[38] , GOUT[46] );
   BLOCK1 U347 (PIN[39] , PIN[43] , GIN[43] , GIN[47] , PHI , POUT[39] , GOUT[47] );
   BLOCK1 U348 (PIN[40] , PIN[44] , GIN[44] , GIN[48] , PHI , POUT[40] , GOUT[48] );
   BLOCK1 U349 (PIN[41] , PIN[45] , GIN[45] , GIN[49] , PHI , POUT[41] , GOUT[49] );
   BLOCK1 U350 (PIN[42] , PIN[46] , GIN[46] , GIN[50] , PHI , POUT[42] , GOUT[50] );
   BLOCK1 U351 (PIN[43] , PIN[47] , GIN[47] , GIN[51] , PHI , POUT[43] , GOUT[51] );
   BLOCK1 U352 (PIN[44] , PIN[48] , GIN[48] , GIN[52] , PHI , POUT[44] , GOUT[52] );
   BLOCK1 U353 (PIN[45] , PIN[49] , GIN[49] , GIN[53] , PHI , POUT[45] , GOUT[53] );
   BLOCK1 U354 (PIN[46] , PIN[50] , GIN[50] , GIN[54] , PHI , POUT[46] , GOUT[54] );
   BLOCK1 U355 (PIN[47] , PIN[51] , GIN[51] , GIN[55] , PHI , POUT[47] , GOUT[55] );
   BLOCK1 U356 (PIN[48] , PIN[52] , GIN[52] , GIN[56] , PHI , POUT[48] , GOUT[56] );
   BLOCK1 U357 (PIN[49] , PIN[53] , GIN[53] , GIN[57] , PHI , POUT[49] , GOUT[57] );
   BLOCK1 U358 (PIN[50] , PIN[54] , GIN[54] , GIN[58] , PHI , POUT[50] , GOUT[58] );
   BLOCK1 U359 (PIN[51] , PIN[55] , GIN[55] , GIN[59] , PHI , POUT[51] , GOUT[59] );
   BLOCK1 U360 (PIN[52] , PIN[56] , GIN[56] , GIN[60] , PHI , POUT[52] , GOUT[60] );
   BLOCK1 U361 (PIN[53] , PIN[57] , GIN[57] , GIN[61] , PHI , POUT[53] , GOUT[61] );
   BLOCK1 U362 (PIN[54] , PIN[58] , GIN[58] , GIN[62] , PHI , POUT[54] , GOUT[62] );
   BLOCK1 U363 (PIN[55] , PIN[59] , GIN[59] , GIN[63] , PHI , POUT[55] , GOUT[63] );
   BLOCK1 U364 (PIN[56] , PIN[60] , GIN[60] , GIN[64] , PHI , POUT[56] , GOUT[64] );
endmodule


module DBLC_3_64 ( PIN, GIN, PHI, POUT, GOUT );
input  [0:56] PIN;
input  [0:64] GIN;
input  PHI;
output [0:48] POUT;
output [0:64] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   INVBLOCK U12 (GIN[2] , PHI , GOUT[2] );
   INVBLOCK U13 (GIN[3] , PHI , GOUT[3] );
   INVBLOCK U14 (GIN[4] , PHI , GOUT[4] );
   INVBLOCK U15 (GIN[5] , PHI , GOUT[5] );
   INVBLOCK U16 (GIN[6] , PHI , GOUT[6] );
   INVBLOCK U17 (GIN[7] , PHI , GOUT[7] );
   BLOCK2A U28 (PIN[0] , GIN[0] , GIN[8] , PHI , GOUT[8] );
   BLOCK2A U29 (PIN[1] , GIN[1] , GIN[9] , PHI , GOUT[9] );
   BLOCK2A U210 (PIN[2] , GIN[2] , GIN[10] , PHI , GOUT[10] );
   BLOCK2A U211 (PIN[3] , GIN[3] , GIN[11] , PHI , GOUT[11] );
   BLOCK2A U212 (PIN[4] , GIN[4] , GIN[12] , PHI , GOUT[12] );
   BLOCK2A U213 (PIN[5] , GIN[5] , GIN[13] , PHI , GOUT[13] );
   BLOCK2A U214 (PIN[6] , GIN[6] , GIN[14] , PHI , GOUT[14] );
   BLOCK2A U215 (PIN[7] , GIN[7] , GIN[15] , PHI , GOUT[15] );
   BLOCK2 U316 (PIN[0] , PIN[8] , GIN[8] , GIN[16] , PHI , POUT[0] , GOUT[16] );
   BLOCK2 U317 (PIN[1] , PIN[9] , GIN[9] , GIN[17] , PHI , POUT[1] , GOUT[17] );
   BLOCK2 U318 (PIN[2] , PIN[10] , GIN[10] , GIN[18] , PHI , POUT[2] , GOUT[18] );
   BLOCK2 U319 (PIN[3] , PIN[11] , GIN[11] , GIN[19] , PHI , POUT[3] , GOUT[19] );
   BLOCK2 U320 (PIN[4] , PIN[12] , GIN[12] , GIN[20] , PHI , POUT[4] , GOUT[20] );
   BLOCK2 U321 (PIN[5] , PIN[13] , GIN[13] , GIN[21] , PHI , POUT[5] , GOUT[21] );
   BLOCK2 U322 (PIN[6] , PIN[14] , GIN[14] , GIN[22] , PHI , POUT[6] , GOUT[22] );
   BLOCK2 U323 (PIN[7] , PIN[15] , GIN[15] , GIN[23] , PHI , POUT[7] , GOUT[23] );
   BLOCK2 U324 (PIN[8] , PIN[16] , GIN[16] , GIN[24] , PHI , POUT[8] , GOUT[24] );
   BLOCK2 U325 (PIN[9] , PIN[17] , GIN[17] , GIN[25] , PHI , POUT[9] , GOUT[25] );
   BLOCK2 U326 (PIN[10] , PIN[18] , GIN[18] , GIN[26] , PHI , POUT[10] , GOUT[26] );
   BLOCK2 U327 (PIN[11] , PIN[19] , GIN[19] , GIN[27] , PHI , POUT[11] , GOUT[27] );
   BLOCK2 U328 (PIN[12] , PIN[20] , GIN[20] , GIN[28] , PHI , POUT[12] , GOUT[28] );
   BLOCK2 U329 (PIN[13] , PIN[21] , GIN[21] , GIN[29] , PHI , POUT[13] , GOUT[29] );
   BLOCK2 U330 (PIN[14] , PIN[22] , GIN[22] , GIN[30] , PHI , POUT[14] , GOUT[30] );
   BLOCK2 U331 (PIN[15] , PIN[23] , GIN[23] , GIN[31] , PHI , POUT[15] , GOUT[31] );
   BLOCK2 U332 (PIN[16] , PIN[24] , GIN[24] , GIN[32] , PHI , POUT[16] , GOUT[32] );
   BLOCK2 U333 (PIN[17] , PIN[25] , GIN[25] , GIN[33] , PHI , POUT[17] , GOUT[33] );
   BLOCK2 U334 (PIN[18] , PIN[26] , GIN[26] , GIN[34] , PHI , POUT[18] , GOUT[34] );
   BLOCK2 U335 (PIN[19] , PIN[27] , GIN[27] , GIN[35] , PHI , POUT[19] , GOUT[35] );
   BLOCK2 U336 (PIN[20] , PIN[28] , GIN[28] , GIN[36] , PHI , POUT[20] , GOUT[36] );
   BLOCK2 U337 (PIN[21] , PIN[29] , GIN[29] , GIN[37] , PHI , POUT[21] , GOUT[37] );
   BLOCK2 U338 (PIN[22] , PIN[30] , GIN[30] , GIN[38] , PHI , POUT[22] , GOUT[38] );
   BLOCK2 U339 (PIN[23] , PIN[31] , GIN[31] , GIN[39] , PHI , POUT[23] , GOUT[39] );
   BLOCK2 U340 (PIN[24] , PIN[32] , GIN[32] , GIN[40] , PHI , POUT[24] , GOUT[40] );
   BLOCK2 U341 (PIN[25] , PIN[33] , GIN[33] , GIN[41] , PHI , POUT[25] , GOUT[41] );
   BLOCK2 U342 (PIN[26] , PIN[34] , GIN[34] , GIN[42] , PHI , POUT[26] , GOUT[42] );
   BLOCK2 U343 (PIN[27] , PIN[35] , GIN[35] , GIN[43] , PHI , POUT[27] , GOUT[43] );
   BLOCK2 U344 (PIN[28] , PIN[36] , GIN[36] , GIN[44] , PHI , POUT[28] , GOUT[44] );
   BLOCK2 U345 (PIN[29] , PIN[37] , GIN[37] , GIN[45] , PHI , POUT[29] , GOUT[45] );
   BLOCK2 U346 (PIN[30] , PIN[38] , GIN[38] , GIN[46] , PHI , POUT[30] , GOUT[46] );
   BLOCK2 U347 (PIN[31] , PIN[39] , GIN[39] , GIN[47] , PHI , POUT[31] , GOUT[47] );
   BLOCK2 U348 (PIN[32] , PIN[40] , GIN[40] , GIN[48] , PHI , POUT[32] , GOUT[48] );
   BLOCK2 U349 (PIN[33] , PIN[41] , GIN[41] , GIN[49] , PHI , POUT[33] , GOUT[49] );
   BLOCK2 U350 (PIN[34] , PIN[42] , GIN[42] , GIN[50] , PHI , POUT[34] , GOUT[50] );
   BLOCK2 U351 (PIN[35] , PIN[43] , GIN[43] , GIN[51] , PHI , POUT[35] , GOUT[51] );
   BLOCK2 U352 (PIN[36] , PIN[44] , GIN[44] , GIN[52] , PHI , POUT[36] , GOUT[52] );
   BLOCK2 U353 (PIN[37] , PIN[45] , GIN[45] , GIN[53] , PHI , POUT[37] , GOUT[53] );
   BLOCK2 U354 (PIN[38] , PIN[46] , GIN[46] , GIN[54] , PHI , POUT[38] , GOUT[54] );
   BLOCK2 U355 (PIN[39] , PIN[47] , GIN[47] , GIN[55] , PHI , POUT[39] , GOUT[55] );
   BLOCK2 U356 (PIN[40] , PIN[48] , GIN[48] , GIN[56] , PHI , POUT[40] , GOUT[56] );
   BLOCK2 U357 (PIN[41] , PIN[49] , GIN[49] , GIN[57] , PHI , POUT[41] , GOUT[57] );
   BLOCK2 U358 (PIN[42] , PIN[50] , GIN[50] , GIN[58] , PHI , POUT[42] , GOUT[58] );
   BLOCK2 U359 (PIN[43] , PIN[51] , GIN[51] , GIN[59] , PHI , POUT[43] , GOUT[59] );
   BLOCK2 U360 (PIN[44] , PIN[52] , GIN[52] , GIN[60] , PHI , POUT[44] , GOUT[60] );
   BLOCK2 U361 (PIN[45] , PIN[53] , GIN[53] , GIN[61] , PHI , POUT[45] , GOUT[61] );
   BLOCK2 U362 (PIN[46] , PIN[54] , GIN[54] , GIN[62] , PHI , POUT[46] , GOUT[62] );
   BLOCK2 U363 (PIN[47] , PIN[55] , GIN[55] , GIN[63] , PHI , POUT[47] , GOUT[63] );
   BLOCK2 U364 (PIN[48] , PIN[56] , GIN[56] , GIN[64] , PHI , POUT[48] , GOUT[64] );
endmodule


module DBLC_4_64 ( PIN, GIN, PHI, POUT, GOUT );
input  [0:48] PIN;
input  [0:64] GIN;
input  PHI;
output [0:32] POUT;
output [0:64] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   INVBLOCK U12 (GIN[2] , PHI , GOUT[2] );
   INVBLOCK U13 (GIN[3] , PHI , GOUT[3] );
   INVBLOCK U14 (GIN[4] , PHI , GOUT[4] );
   INVBLOCK U15 (GIN[5] , PHI , GOUT[5] );
   INVBLOCK U16 (GIN[6] , PHI , GOUT[6] );
   INVBLOCK U17 (GIN[7] , PHI , GOUT[7] );
   INVBLOCK U18 (GIN[8] , PHI , GOUT[8] );
   INVBLOCK U19 (GIN[9] , PHI , GOUT[9] );
   INVBLOCK U110 (GIN[10] , PHI , GOUT[10] );
   INVBLOCK U111 (GIN[11] , PHI , GOUT[11] );
   INVBLOCK U112 (GIN[12] , PHI , GOUT[12] );
   INVBLOCK U113 (GIN[13] , PHI , GOUT[13] );
   INVBLOCK U114 (GIN[14] , PHI , GOUT[14] );
   INVBLOCK U115 (GIN[15] , PHI , GOUT[15] );
   BLOCK1A U216 (PIN[0] , GIN[0] , GIN[16] , PHI , GOUT[16] );
   BLOCK1A U217 (PIN[1] , GIN[1] , GIN[17] , PHI , GOUT[17] );
   BLOCK1A U218 (PIN[2] , GIN[2] , GIN[18] , PHI , GOUT[18] );
   BLOCK1A U219 (PIN[3] , GIN[3] , GIN[19] , PHI , GOUT[19] );
   BLOCK1A U220 (PIN[4] , GIN[4] , GIN[20] , PHI , GOUT[20] );
   BLOCK1A U221 (PIN[5] , GIN[5] , GIN[21] , PHI , GOUT[21] );
   BLOCK1A U222 (PIN[6] , GIN[6] , GIN[22] , PHI , GOUT[22] );
   BLOCK1A U223 (PIN[7] , GIN[7] , GIN[23] , PHI , GOUT[23] );
   BLOCK1A U224 (PIN[8] , GIN[8] , GIN[24] , PHI , GOUT[24] );
   BLOCK1A U225 (PIN[9] , GIN[9] , GIN[25] , PHI , GOUT[25] );
   BLOCK1A U226 (PIN[10] , GIN[10] , GIN[26] , PHI , GOUT[26] );
   BLOCK1A U227 (PIN[11] , GIN[11] , GIN[27] , PHI , GOUT[27] );
   BLOCK1A U228 (PIN[12] , GIN[12] , GIN[28] , PHI , GOUT[28] );
   BLOCK1A U229 (PIN[13] , GIN[13] , GIN[29] , PHI , GOUT[29] );
   BLOCK1A U230 (PIN[14] , GIN[14] , GIN[30] , PHI , GOUT[30] );
   BLOCK1A U231 (PIN[15] , GIN[15] , GIN[31] , PHI , GOUT[31] );
   BLOCK1 U332 (PIN[0] , PIN[16] , GIN[16] , GIN[32] , PHI , POUT[0] , GOUT[32] );
   BLOCK1 U333 (PIN[1] , PIN[17] , GIN[17] , GIN[33] , PHI , POUT[1] , GOUT[33] );
   BLOCK1 U334 (PIN[2] , PIN[18] , GIN[18] , GIN[34] , PHI , POUT[2] , GOUT[34] );
   BLOCK1 U335 (PIN[3] , PIN[19] , GIN[19] , GIN[35] , PHI , POUT[3] , GOUT[35] );
   BLOCK1 U336 (PIN[4] , PIN[20] , GIN[20] , GIN[36] , PHI , POUT[4] , GOUT[36] );
   BLOCK1 U337 (PIN[5] , PIN[21] , GIN[21] , GIN[37] , PHI , POUT[5] , GOUT[37] );
   BLOCK1 U338 (PIN[6] , PIN[22] , GIN[22] , GIN[38] , PHI , POUT[6] , GOUT[38] );
   BLOCK1 U339 (PIN[7] , PIN[23] , GIN[23] , GIN[39] , PHI , POUT[7] , GOUT[39] );
   BLOCK1 U340 (PIN[8] , PIN[24] , GIN[24] , GIN[40] , PHI , POUT[8] , GOUT[40] );
   BLOCK1 U341 (PIN[9] , PIN[25] , GIN[25] , GIN[41] , PHI , POUT[9] , GOUT[41] );
   BLOCK1 U342 (PIN[10] , PIN[26] , GIN[26] , GIN[42] , PHI , POUT[10] , GOUT[42] );
   BLOCK1 U343 (PIN[11] , PIN[27] , GIN[27] , GIN[43] , PHI , POUT[11] , GOUT[43] );
   BLOCK1 U344 (PIN[12] , PIN[28] , GIN[28] , GIN[44] , PHI , POUT[12] , GOUT[44] );
   BLOCK1 U345 (PIN[13] , PIN[29] , GIN[29] , GIN[45] , PHI , POUT[13] , GOUT[45] );
   BLOCK1 U346 (PIN[14] , PIN[30] , GIN[30] , GIN[46] , PHI , POUT[14] , GOUT[46] );
   BLOCK1 U347 (PIN[15] , PIN[31] , GIN[31] , GIN[47] , PHI , POUT[15] , GOUT[47] );
   BLOCK1 U348 (PIN[16] , PIN[32] , GIN[32] , GIN[48] , PHI , POUT[16] , GOUT[48] );
   BLOCK1 U349 (PIN[17] , PIN[33] , GIN[33] , GIN[49] , PHI , POUT[17] , GOUT[49] );
   BLOCK1 U350 (PIN[18] , PIN[34] , GIN[34] , GIN[50] , PHI , POUT[18] , GOUT[50] );
   BLOCK1 U351 (PIN[19] , PIN[35] , GIN[35] , GIN[51] , PHI , POUT[19] , GOUT[51] );
   BLOCK1 U352 (PIN[20] , PIN[36] , GIN[36] , GIN[52] , PHI , POUT[20] , GOUT[52] );
   BLOCK1 U353 (PIN[21] , PIN[37] , GIN[37] , GIN[53] , PHI , POUT[21] , GOUT[53] );
   BLOCK1 U354 (PIN[22] , PIN[38] , GIN[38] , GIN[54] , PHI , POUT[22] , GOUT[54] );
   BLOCK1 U355 (PIN[23] , PIN[39] , GIN[39] , GIN[55] , PHI , POUT[23] , GOUT[55] );
   BLOCK1 U356 (PIN[24] , PIN[40] , GIN[40] , GIN[56] , PHI , POUT[24] , GOUT[56] );
   BLOCK1 U357 (PIN[25] , PIN[41] , GIN[41] , GIN[57] , PHI , POUT[25] , GOUT[57] );
   BLOCK1 U358 (PIN[26] , PIN[42] , GIN[42] , GIN[58] , PHI , POUT[26] , GOUT[58] );
   BLOCK1 U359 (PIN[27] , PIN[43] , GIN[43] , GIN[59] , PHI , POUT[27] , GOUT[59] );
   BLOCK1 U360 (PIN[28] , PIN[44] , GIN[44] , GIN[60] , PHI , POUT[28] , GOUT[60] );
   BLOCK1 U361 (PIN[29] , PIN[45] , GIN[45] , GIN[61] , PHI , POUT[29] , GOUT[61] );
   BLOCK1 U362 (PIN[30] , PIN[46] , GIN[46] , GIN[62] , PHI , POUT[30] , GOUT[62] );
   BLOCK1 U363 (PIN[31] , PIN[47] , GIN[47] , GIN[63] , PHI , POUT[31] , GOUT[63] );
   BLOCK1 U364 (PIN[32] , PIN[48] , GIN[48] , GIN[64] , PHI , POUT[32] , GOUT[64] );
endmodule


module DBLC_5_64 ( PIN, GIN, PHI, POUT, GOUT );
input  [0:32] PIN;
input  [0:64] GIN;
input  PHI;
output [0:0] POUT;
output [0:64] GOUT;
   INVBLOCK U10 (GIN[0] , PHI , GOUT[0] );
   INVBLOCK U11 (GIN[1] , PHI , GOUT[1] );
   INVBLOCK U12 (GIN[2] , PHI , GOUT[2] );
   INVBLOCK U13 (GIN[3] , PHI , GOUT[3] );
   INVBLOCK U14 (GIN[4] , PHI , GOUT[4] );
   INVBLOCK U15 (GIN[5] , PHI , GOUT[5] );
   INVBLOCK U16 (GIN[6] , PHI , GOUT[6] );
   INVBLOCK U17 (GIN[7] , PHI , GOUT[7] );
   INVBLOCK U18 (GIN[8] , PHI , GOUT[8] );
   INVBLOCK U19 (GIN[9] , PHI , GOUT[9] );
   INVBLOCK U110 (GIN[10] , PHI , GOUT[10] );
   INVBLOCK U111 (GIN[11] , PHI , GOUT[11] );
   INVBLOCK U112 (GIN[12] , PHI , GOUT[12] );
   INVBLOCK U113 (GIN[13] , PHI , GOUT[13] );
   INVBLOCK U114 (GIN[14] , PHI , GOUT[14] );
   INVBLOCK U115 (GIN[15] , PHI , GOUT[15] );
   INVBLOCK U116 (GIN[16] , PHI , GOUT[16] );
   INVBLOCK U117 (GIN[17] , PHI , GOUT[17] );
   INVBLOCK U118 (GIN[18] , PHI , GOUT[18] );
   INVBLOCK U119 (GIN[19] , PHI , GOUT[19] );
   INVBLOCK U120 (GIN[20] , PHI , GOUT[20] );
   INVBLOCK U121 (GIN[21] , PHI , GOUT[21] );
   INVBLOCK U122 (GIN[22] , PHI , GOUT[22] );
   INVBLOCK U123 (GIN[23] , PHI , GOUT[23] );
   INVBLOCK U124 (GIN[24] , PHI , GOUT[24] );
   INVBLOCK U125 (GIN[25] , PHI , GOUT[25] );
   INVBLOCK U126 (GIN[26] , PHI , GOUT[26] );
   INVBLOCK U127 (GIN[27] , PHI , GOUT[27] );
   INVBLOCK U128 (GIN[28] , PHI , GOUT[28] );
   INVBLOCK U129 (GIN[29] , PHI , GOUT[29] );
   INVBLOCK U130 (GIN[30] , PHI , GOUT[30] );
   INVBLOCK U131 (GIN[31] , PHI , GOUT[31] );
   BLOCK2A U232 (PIN[0] , GIN[0] , GIN[32] , PHI , GOUT[32] );
   BLOCK2A U233 (PIN[1] , GIN[1] , GIN[33] , PHI , GOUT[33] );
   BLOCK2A U234 (PIN[2] , GIN[2] , GIN[34] , PHI , GOUT[34] );
   BLOCK2A U235 (PIN[3] , GIN[3] , GIN[35] , PHI , GOUT[35] );
   BLOCK2A U236 (PIN[4] , GIN[4] , GIN[36] , PHI , GOUT[36] );
   BLOCK2A U237 (PIN[5] , GIN[5] , GIN[37] , PHI , GOUT[37] );
   BLOCK2A U238 (PIN[6] , GIN[6] , GIN[38] , PHI , GOUT[38] );
   BLOCK2A U239 (PIN[7] , GIN[7] , GIN[39] , PHI , GOUT[39] );
   BLOCK2A U240 (PIN[8] , GIN[8] , GIN[40] , PHI , GOUT[40] );
   BLOCK2A U241 (PIN[9] , GIN[9] , GIN[41] , PHI , GOUT[41] );
   BLOCK2A U242 (PIN[10] , GIN[10] , GIN[42] , PHI , GOUT[42] );
   BLOCK2A U243 (PIN[11] , GIN[11] , GIN[43] , PHI , GOUT[43] );
   BLOCK2A U244 (PIN[12] , GIN[12] , GIN[44] , PHI , GOUT[44] );
   BLOCK2A U245 (PIN[13] , GIN[13] , GIN[45] , PHI , GOUT[45] );
   BLOCK2A U246 (PIN[14] , GIN[14] , GIN[46] , PHI , GOUT[46] );
   BLOCK2A U247 (PIN[15] , GIN[15] , GIN[47] , PHI , GOUT[47] );
   BLOCK2A U248 (PIN[16] , GIN[16] , GIN[48] , PHI , GOUT[48] );
   BLOCK2A U249 (PIN[17] , GIN[17] , GIN[49] , PHI , GOUT[49] );
   BLOCK2A U250 (PIN[18] , GIN[18] , GIN[50] , PHI , GOUT[50] );
   BLOCK2A U251 (PIN[19] , GIN[19] , GIN[51] , PHI , GOUT[51] );
   BLOCK2A U252 (PIN[20] , GIN[20] , GIN[52] , PHI , GOUT[52] );
   BLOCK2A U253 (PIN[21] , GIN[21] , GIN[53] , PHI , GOUT[53] );
   BLOCK2A U254 (PIN[22] , GIN[22] , GIN[54] , PHI , GOUT[54] );
   BLOCK2A U255 (PIN[23] , GIN[23] , GIN[55] , PHI , GOUT[55] );
   BLOCK2A U256 (PIN[24] , GIN[24] , GIN[56] , PHI , GOUT[56] );
   BLOCK2A U257 (PIN[25] , GIN[25] , GIN[57] , PHI , GOUT[57] );
   BLOCK2A U258 (PIN[26] , GIN[26] , GIN[58] , PHI , GOUT[58] );
   BLOCK2A U259 (PIN[27] , GIN[27] , GIN[59] , PHI , GOUT[59] );
   BLOCK2A U260 (PIN[28] , GIN[28] , GIN[60] , PHI , GOUT[60] );
   BLOCK2A U261 (PIN[29] , GIN[29] , GIN[61] , PHI , GOUT[61] );
   BLOCK2A U262 (PIN[30] , GIN[30] , GIN[62] , PHI , GOUT[62] );
   BLOCK2A U263 (PIN[31] , GIN[31] , GIN[63] , PHI , GOUT[63] );
   BLOCK2 U364 (PIN[0] , PIN[32] , GIN[32] , GIN[64] , PHI , POUT[0] , GOUT[64] );
endmodule


module XORSTAGE_64 ( A, B, PBIT, PHI, CARRY, SUM, COUT );
input  [0:63] A;
input  [0:63] B;
input  PBIT;
input  PHI;
input  [0:64] CARRY;
output [0:63] SUM;
output COUT;
   XXOR1 U20 (A[0] , B[0] , CARRY[0] , PHI , SUM[0] );
   XXOR1 U21 (A[1] , B[1] , CARRY[1] , PHI , SUM[1] );
   XXOR1 U22 (A[2] , B[2] , CARRY[2] , PHI , SUM[2] );
   XXOR1 U23 (A[3] , B[3] , CARRY[3] , PHI , SUM[3] );
   XXOR1 U24 (A[4] , B[4] , CARRY[4] , PHI , SUM[4] );
   XXOR1 U25 (A[5] , B[5] , CARRY[5] , PHI , SUM[5] );
   XXOR1 U26 (A[6] , B[6] , CARRY[6] , PHI , SUM[6] );
   XXOR1 U27 (A[7] , B[7] , CARRY[7] , PHI , SUM[7] );
   XXOR1 U28 (A[8] , B[8] , CARRY[8] , PHI , SUM[8] );
   XXOR1 U29 (A[9] , B[9] , CARRY[9] , PHI , SUM[9] );
   XXOR1 U210 (A[10] , B[10] , CARRY[10] , PHI , SUM[10] );
   XXOR1 U211 (A[11] , B[11] , CARRY[11] , PHI , SUM[11] );
   XXOR1 U212 (A[12] , B[12] , CARRY[12] , PHI , SUM[12] );
   XXOR1 U213 (A[13] , B[13] , CARRY[13] , PHI , SUM[13] );
   XXOR1 U214 (A[14] , B[14] , CARRY[14] , PHI , SUM[14] );
   XXOR1 U215 (A[15] , B[15] , CARRY[15] , PHI , SUM[15] );
   XXOR1 U216 (A[16] , B[16] , CARRY[16] , PHI , SUM[16] );
   XXOR1 U217 (A[17] , B[17] , CARRY[17] , PHI , SUM[17] );
   XXOR1 U218 (A[18] , B[18] , CARRY[18] , PHI , SUM[18] );
   XXOR1 U219 (A[19] , B[19] , CARRY[19] , PHI , SUM[19] );
   XXOR1 U220 (A[20] , B[20] , CARRY[20] , PHI , SUM[20] );
   XXOR1 U221 (A[21] , B[21] , CARRY[21] , PHI , SUM[21] );
   XXOR1 U222 (A[22] , B[22] , CARRY[22] , PHI , SUM[22] );
   XXOR1 U223 (A[23] , B[23] , CARRY[23] , PHI , SUM[23] );
   XXOR1 U224 (A[24] , B[24] , CARRY[24] , PHI , SUM[24] );
   XXOR1 U225 (A[25] , B[25] , CARRY[25] , PHI , SUM[25] );
   XXOR1 U226 (A[26] , B[26] , CARRY[26] , PHI , SUM[26] );
   XXOR1 U227 (A[27] , B[27] , CARRY[27] , PHI , SUM[27] );
   XXOR1 U228 (A[28] , B[28] , CARRY[28] , PHI , SUM[28] );
   XXOR1 U229 (A[29] , B[29] , CARRY[29] , PHI , SUM[29] );
   XXOR1 U230 (A[30] , B[30] , CARRY[30] , PHI , SUM[30] );
   XXOR1 U231 (A[31] , B[31] , CARRY[31] , PHI , SUM[31] );
   XXOR1 U232 (A[32] , B[32] , CARRY[32] , PHI , SUM[32] );
   XXOR1 U233 (A[33] , B[33] , CARRY[33] , PHI , SUM[33] );
   XXOR1 U234 (A[34] , B[34] , CARRY[34] , PHI , SUM[34] );
   XXOR1 U235 (A[35] , B[35] , CARRY[35] , PHI , SUM[35] );
   XXOR1 U236 (A[36] , B[36] , CARRY[36] , PHI , SUM[36] );
   XXOR1 U237 (A[37] , B[37] , CARRY[37] , PHI , SUM[37] );
   XXOR1 U238 (A[38] , B[38] , CARRY[38] , PHI , SUM[38] );
   XXOR1 U239 (A[39] , B[39] , CARRY[39] , PHI , SUM[39] );
   XXOR1 U240 (A[40] , B[40] , CARRY[40] , PHI , SUM[40] );
   XXOR1 U241 (A[41] , B[41] , CARRY[41] , PHI , SUM[41] );
   XXOR1 U242 (A[42] , B[42] , CARRY[42] , PHI , SUM[42] );
   XXOR1 U243 (A[43] , B[43] , CARRY[43] , PHI , SUM[43] );
   XXOR1 U244 (A[44] , B[44] , CARRY[44] , PHI , SUM[44] );
   XXOR1 U245 (A[45] , B[45] , CARRY[45] , PHI , SUM[45] );
   XXOR1 U246 (A[46] , B[46] , CARRY[46] , PHI , SUM[46] );
   XXOR1 U247 (A[47] , B[47] , CARRY[47] , PHI , SUM[47] );
   XXOR1 U248 (A[48] , B[48] , CARRY[48] , PHI , SUM[48] );
   XXOR1 U249 (A[49] , B[49] , CARRY[49] , PHI , SUM[49] );
   XXOR1 U250 (A[50] , B[50] , CARRY[50] , PHI , SUM[50] );
   XXOR1 U251 (A[51] , B[51] , CARRY[51] , PHI , SUM[51] );
   XXOR1 U252 (A[52] , B[52] , CARRY[52] , PHI , SUM[52] );
   XXOR1 U253 (A[53] , B[53] , CARRY[53] , PHI , SUM[53] );
   XXOR1 U254 (A[54] , B[54] , CARRY[54] , PHI , SUM[54] );
   XXOR1 U255 (A[55] , B[55] , CARRY[55] , PHI , SUM[55] );
   XXOR1 U256 (A[56] , B[56] , CARRY[56] , PHI , SUM[56] );
   XXOR1 U257 (A[57] , B[57] , CARRY[57] , PHI , SUM[57] );
   XXOR1 U258 (A[58] , B[58] , CARRY[58] , PHI , SUM[58] );
   XXOR1 U259 (A[59] , B[59] , CARRY[59] , PHI , SUM[59] );
   XXOR1 U260 (A[60] , B[60] , CARRY[60] , PHI , SUM[60] );
   XXOR1 U261 (A[61] , B[61] , CARRY[61] , PHI , SUM[61] );
   XXOR1 U262 (A[62] , B[62] , CARRY[62] , PHI , SUM[62] );
   XXOR1 U263 (A[63] , B[63] , CARRY[63] , PHI , SUM[63] );
   BLOCK1A U1 (PBIT , CARRY[0] , CARRY[64] , PHI , COUT );
endmodule


module DBLCTREE_64 ( PIN, GIN, PHI, GOUT, POUT );
input  [0:63] PIN;
input  [0:64] GIN;
input  PHI;
output [0:64] GOUT;
output [0:0] POUT;
   wire [0:62] INTPROP_0;
   wire [0:64] INTGEN_0;
   wire [0:60] INTPROP_1;
   wire [0:64] INTGEN_1;
   wire [0:56] INTPROP_2;
   wire [0:64] INTGEN_2;
   wire [0:48] INTPROP_3;
   wire [0:64] INTGEN_3;
   wire [0:32] INTPROP_4;
   wire [0:64] INTGEN_4;
   DBLC_0_64 U_0 (.PIN(PIN) , .GIN(GIN) , .PHI(PHI) , .POUT(INTPROP_0) , .GOUT(INTGEN_0) );
   DBLC_1_64 U_1 (.PIN(INTPROP_0) , .GIN(INTGEN_0) , .PHI(PHI) , .POUT(INTPROP_1) , .GOUT(INTGEN_1) );
   DBLC_2_64 U_2 (.PIN(INTPROP_1) , .GIN(INTGEN_1) , .PHI(PHI) , .POUT(INTPROP_2) , .GOUT(INTGEN_2) );
   DBLC_3_64 U_3 (.PIN(INTPROP_2) , .GIN(INTGEN_2) , .PHI(PHI) , .POUT(INTPROP_3) , .GOUT(INTGEN_3) );
   DBLC_4_64 U_4 (.PIN(INTPROP_3) , .GIN(INTGEN_3) , .PHI(PHI) , .POUT(INTPROP_4) , .GOUT(INTGEN_4) );
   DBLC_5_64 U_5 (.PIN(INTPROP_4) , .GIN(INTGEN_4) , .PHI(PHI) , .POUT(POUT) , .GOUT(GOUT) );
endmodule


module DBLCADDER_64_64 ( OPA, OPB, CIN, PHI, SUM, COUT );
input  [0:63] OPA;
input  [0:63] OPB;
input  CIN;
input  PHI;
output [0:63] SUM;
output COUT;
   wire [0:63] INTPROP;
   wire [0:64] INTGEN;
   wire [0:0] PBIT;
   wire [0:64] CARRY;
   PRESTAGE_64 U1 (OPA , OPB , CIN , PHI , INTPROP , INTGEN );
   DBLCTREE_64 U2 (INTPROP , INTGEN , PHI , CARRY , PBIT );
   XORSTAGE_64 U3 (OPA[0:63] , OPB[0:63] , PBIT[0] , PHI , CARRY[0:64] , SUM , COUT );
endmodule


module MULTIPLIER_33_32 ( MULTIPLICAND, MULTIPLIER, RST, CLK, PHI, RESULT );
input  [0:32] MULTIPLICAND;
input  [0:31] MULTIPLIER;
input  RST;
input  CLK;
input  PHI;
output [0:63] RESULT;
   wire [0:575] PPBIT;
   wire [0:64] INT_CARRY;
   wire [0:63] INT_SUM;
   wire LOGIC_ZERO;
   wire [0:63] ARESULT;
   reg [0:63] RESULT;
   assign LOGIC_ZERO = 0;
   BOOTHCODER_33_32 B (.OPA(MULTIPLICAND[0:32]) , .OPB(MULTIPLIER[0:31]) , .SUMMAND(PPBIT[0:575]) );
   WALLACE_33_32 W (.SUMMAND(PPBIT[0:575]) , .RST(RST), .CLK (CLK) , .CARRY(INT_CARRY[1:63]) , .SUM(INT_SUM[0:63]) );
   assign INT_CARRY[0] = LOGIC_ZERO;
   DBLCADDER_64_64 D (.OPA(INT_SUM[0:63]) , .OPB(INT_CARRY[0:63]) , .CIN (LOGIC_ZERO) , .PHI (PHI) , .SUM(ARESULT[0:63]), .COUT() );
   always @(posedge CLK )
     if (RST == `OR1200_RST_VALUE)
	RESULT <=  64'h0000_0000_0000_0000;
     else
	RESULT <= ARESULT;
endmodule


// 32x32 multiplier, no input/output registers
// Registers inside Wallace trees every 8 full adder levels,
// with first pipeline after level 4

module or1200_amultp2_32x32 ( X, Y, RST, CLK, P );
input  [31:0] X;
input  [31:0] Y;
input  RST;
input  CLK;
output [63:0] P;
   wire [0:32] A;
   wire [0:31] B;
   wire [0:63] Q;
   assign A[0] = X[0];
   assign A[1] = X[1];
   assign A[2] = X[2];
   assign A[3] = X[3];
   assign A[4] = X[4];
   assign A[5] = X[5];
   assign A[6] = X[6];
   assign A[7] = X[7];
   assign A[8] = X[8];
   assign A[9] = X[9];
   assign A[10] = X[10];
   assign A[11] = X[11];
   assign A[12] = X[12];
   assign A[13] = X[13];
   assign A[14] = X[14];
   assign A[15] = X[15];
   assign A[16] = X[16];
   assign A[17] = X[17];
   assign A[18] = X[18];
   assign A[19] = X[19];
   assign A[20] = X[20];
   assign A[21] = X[21];
   assign A[22] = X[22];
   assign A[23] = X[23];
   assign A[24] = X[24];
   assign A[25] = X[25];
   assign A[26] = X[26];
   assign A[27] = X[27];
   assign A[28] = X[28];
   assign A[29] = X[29];
   assign A[30] = X[30];
   assign A[31] = X[31];
   assign A[32] = X[31];
   assign B[0] = Y[0];
   assign B[1] = Y[1];
   assign B[2] = Y[2];
   assign B[3] = Y[3];
   assign B[4] = Y[4];
   assign B[5] = Y[5];
   assign B[6] = Y[6];
   assign B[7] = Y[7];
   assign B[8] = Y[8];
   assign B[9] = Y[9];
   assign B[10] = Y[10];
   assign B[11] = Y[11];
   assign B[12] = Y[12];
   assign B[13] = Y[13];
   assign B[14] = Y[14];
   assign B[15] = Y[15];
   assign B[16] = Y[16];
   assign B[17] = Y[17];
   assign B[18] = Y[18];
   assign B[19] = Y[19];
   assign B[20] = Y[20];
   assign B[21] = Y[21];
   assign B[22] = Y[22];
   assign B[23] = Y[23];
   assign B[24] = Y[24];
   assign B[25] = Y[25];
   assign B[26] = Y[26];
   assign B[27] = Y[27];
   assign B[28] = Y[28];
   assign B[29] = Y[29];
   assign B[30] = Y[30];
   assign B[31] = Y[31];
   assign P[0] = Q[0];
   assign P[1] = Q[1];
   assign P[2] = Q[2];
   assign P[3] = Q[3];
   assign P[4] = Q[4];
   assign P[5] = Q[5];
   assign P[6] = Q[6];
   assign P[7] = Q[7];
   assign P[8] = Q[8];
   assign P[9] = Q[9];
   assign P[10] = Q[10];
   assign P[11] = Q[11];
   assign P[12] = Q[12];
   assign P[13] = Q[13];
   assign P[14] = Q[14];
   assign P[15] = Q[15];
   assign P[16] = Q[16];
   assign P[17] = Q[17];
   assign P[18] = Q[18];
   assign P[19] = Q[19];
   assign P[20] = Q[20];
   assign P[21] = Q[21];
   assign P[22] = Q[22];
   assign P[23] = Q[23];
   assign P[24] = Q[24];
   assign P[25] = Q[25];
   assign P[26] = Q[26];
   assign P[27] = Q[27];
   assign P[28] = Q[28];
   assign P[29] = Q[29];
   assign P[30] = Q[30];
   assign P[31] = Q[31];
   assign P[32] = Q[32];
   assign P[33] = Q[33];
   assign P[34] = Q[34];
   assign P[35] = Q[35];
   assign P[36] = Q[36];
   assign P[37] = Q[37];
   assign P[38] = Q[38];
   assign P[39] = Q[39];
   assign P[40] = Q[40];
   assign P[41] = Q[41];
   assign P[42] = Q[42];
   assign P[43] = Q[43];
   assign P[44] = Q[44];
   assign P[45] = Q[45];
   assign P[46] = Q[46];
   assign P[47] = Q[47];
   assign P[48] = Q[48];
   assign P[49] = Q[49];
   assign P[50] = Q[50];
   assign P[51] = Q[51];
   assign P[52] = Q[52];
   assign P[53] = Q[53];
   assign P[54] = Q[54];
   assign P[55] = Q[55];
   assign P[56] = Q[56];
   assign P[57] = Q[57];
   assign P[58] = Q[58];
   assign P[59] = Q[59];
   assign P[60] = Q[60];
   assign P[61] = Q[61];
   assign P[62] = Q[62];
   assign P[63] = Q[63];
   MULTIPLIER_33_32 U1 (.MULTIPLICAND(A) , .MULTIPLIER(B) , .RST(RST), .CLK(CLK) , .PHI(1'b0) , .RESULT(Q) );
endmodule

`endif


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's VR, UPR and Configuration Registers                ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  According to OR1K architectural and OR1200 specifications.  ////
////                                                              ////
////  To Do:                                                      ////
////   - done                                                     ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//
// $Log: or1200_cfgr.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 

// synopsys translate_off
// synopsys translate_on

module or1200_cfgr(
		   // RISC Internal Interface
		   spr_addr, spr_dat_o
		   );

   //
   // RISC Internal Interface
   //
   input	[31:0]	spr_addr;	// SPR Address
   output [31:0] 	spr_dat_o;	// SPR Read Data

   //
   // Internal wires & registers
   //
   reg [31:0] 		spr_dat_o;	// SPR Read Data

`ifdef OR1200_CFGR_IMPLEMENTED

   //
   // Implementation of VR, UPR and configuration registers
   //
   always @(spr_addr)
 `ifdef OR1200_SYS_FULL_DECODE
     if (~|spr_addr[31:4])
 `endif
       case(spr_addr[3:0])		// synopsys parallel_case
	 `OR1200_SPRGRP_SYS_VR: begin
	    spr_dat_o[`OR1200_VR_REV_BITS] = `OR1200_VR_REV;
	    spr_dat_o[`OR1200_VR_RES1_BITS] = `OR1200_VR_RES1;
	    spr_dat_o[`OR1200_VR_CFG_BITS] = `OR1200_VR_CFG;
	    spr_dat_o[`OR1200_VR_VER_BITS] = `OR1200_VR_VER;
	 end
	 `OR1200_SPRGRP_SYS_UPR: begin
	    spr_dat_o[`OR1200_UPR_UP_BITS] = `OR1200_UPR_UP;
	    spr_dat_o[`OR1200_UPR_DCP_BITS] = `OR1200_UPR_DCP;
	    spr_dat_o[`OR1200_UPR_ICP_BITS] = `OR1200_UPR_ICP;
	    spr_dat_o[`OR1200_UPR_DMP_BITS] = `OR1200_UPR_DMP;
	    spr_dat_o[`OR1200_UPR_IMP_BITS] = `OR1200_UPR_IMP;
	    spr_dat_o[`OR1200_UPR_MP_BITS] = `OR1200_UPR_MP;
	    spr_dat_o[`OR1200_UPR_DUP_BITS] = `OR1200_UPR_DUP;
	    spr_dat_o[`OR1200_UPR_PCUP_BITS] = `OR1200_UPR_PCUP;
	    spr_dat_o[`OR1200_UPR_PMP_BITS] = `OR1200_UPR_PMP;
	    spr_dat_o[`OR1200_UPR_PICP_BITS] = `OR1200_UPR_PICP;
	    spr_dat_o[`OR1200_UPR_TTP_BITS] = `OR1200_UPR_TTP;
	    spr_dat_o[`OR1200_UPR_FPP_BITS] = `OR1200_UPR_FPP;
	    spr_dat_o[`OR1200_UPR_RES1_BITS] = `OR1200_UPR_RES1;
	    spr_dat_o[`OR1200_UPR_CUP_BITS] = `OR1200_UPR_CUP;
	 end
	 `OR1200_SPRGRP_SYS_CPUCFGR: begin
	    spr_dat_o[`OR1200_CPUCFGR_NSGF_BITS] = `OR1200_CPUCFGR_NSGF;
	    spr_dat_o[`OR1200_CPUCFGR_HGF_BITS] = `OR1200_CPUCFGR_HGF;
	    spr_dat_o[`OR1200_CPUCFGR_OB32S_BITS] = `OR1200_CPUCFGR_OB32S;
	    spr_dat_o[`OR1200_CPUCFGR_OB64S_BITS] = `OR1200_CPUCFGR_OB64S;
	    spr_dat_o[`OR1200_CPUCFGR_OF32S_BITS] = `OR1200_CPUCFGR_OF32S;
	    spr_dat_o[`OR1200_CPUCFGR_OF64S_BITS] = `OR1200_CPUCFGR_OF64S;
	    spr_dat_o[`OR1200_CPUCFGR_OV64S_BITS] = `OR1200_CPUCFGR_OV64S;
	    spr_dat_o[`OR1200_CPUCFGR_RES1_BITS] = `OR1200_CPUCFGR_RES1;
	 end
	 `OR1200_SPRGRP_SYS_DMMUCFGR: begin
	    spr_dat_o[`OR1200_DMMUCFGR_NTW_BITS] = `OR1200_DMMUCFGR_NTW;
	    spr_dat_o[`OR1200_DMMUCFGR_NTS_BITS] = `OR1200_DMMUCFGR_NTS;
	    spr_dat_o[`OR1200_DMMUCFGR_NAE_BITS] = `OR1200_DMMUCFGR_NAE;
	    spr_dat_o[`OR1200_DMMUCFGR_CRI_BITS] = `OR1200_DMMUCFGR_CRI;
	    spr_dat_o[`OR1200_DMMUCFGR_PRI_BITS] = `OR1200_DMMUCFGR_PRI;
	    spr_dat_o[`OR1200_DMMUCFGR_TEIRI_BITS] = `OR1200_DMMUCFGR_TEIRI;
	    spr_dat_o[`OR1200_DMMUCFGR_HTR_BITS] = `OR1200_DMMUCFGR_HTR;
	    spr_dat_o[`OR1200_DMMUCFGR_RES1_BITS] = `OR1200_DMMUCFGR_RES1;
	 end
	 `OR1200_SPRGRP_SYS_IMMUCFGR: begin
	    spr_dat_o[`OR1200_IMMUCFGR_NTW_BITS] = `OR1200_IMMUCFGR_NTW;
	    spr_dat_o[`OR1200_IMMUCFGR_NTS_BITS] = `OR1200_IMMUCFGR_NTS;
	    spr_dat_o[`OR1200_IMMUCFGR_NAE_BITS] = `OR1200_IMMUCFGR_NAE;
	    spr_dat_o[`OR1200_IMMUCFGR_CRI_BITS] = `OR1200_IMMUCFGR_CRI;
	    spr_dat_o[`OR1200_IMMUCFGR_PRI_BITS] = `OR1200_IMMUCFGR_PRI;
	    spr_dat_o[`OR1200_IMMUCFGR_TEIRI_BITS] = `OR1200_IMMUCFGR_TEIRI;
	    spr_dat_o[`OR1200_IMMUCFGR_HTR_BITS] = `OR1200_IMMUCFGR_HTR;
	    spr_dat_o[`OR1200_IMMUCFGR_RES1_BITS] = `OR1200_IMMUCFGR_RES1;
	 end
	 `OR1200_SPRGRP_SYS_DCCFGR: begin
	    spr_dat_o[`OR1200_DCCFGR_NCW_BITS] = `OR1200_DCCFGR_NCW;
	    spr_dat_o[`OR1200_DCCFGR_NCS_BITS] = `OR1200_DCCFGR_NCS;
	    spr_dat_o[`OR1200_DCCFGR_CBS_BITS] = `OR1200_DCCFGR_CBS;
	    spr_dat_o[`OR1200_DCCFGR_CWS_BITS] = `OR1200_DCCFGR_CWS;
	    spr_dat_o[`OR1200_DCCFGR_CCRI_BITS] = `OR1200_DCCFGR_CCRI;
	    spr_dat_o[`OR1200_DCCFGR_CBIRI_BITS] = `OR1200_DCCFGR_CBIRI;
	    spr_dat_o[`OR1200_DCCFGR_CBPRI_BITS] = `OR1200_DCCFGR_CBPRI;
	    spr_dat_o[`OR1200_DCCFGR_CBLRI_BITS] = `OR1200_DCCFGR_CBLRI;
	    spr_dat_o[`OR1200_DCCFGR_CBFRI_BITS] = `OR1200_DCCFGR_CBFRI;
	    spr_dat_o[`OR1200_DCCFGR_CBWBRI_BITS] = `OR1200_DCCFGR_CBWBRI;
	    spr_dat_o[`OR1200_DCCFGR_RES1_BITS] = `OR1200_DCCFGR_RES1;
	 end
	 `OR1200_SPRGRP_SYS_ICCFGR: begin
	    spr_dat_o[`OR1200_ICCFGR_NCW_BITS] = `OR1200_ICCFGR_NCW;
	    spr_dat_o[`OR1200_ICCFGR_NCS_BITS] = `OR1200_ICCFGR_NCS;
	    spr_dat_o[`OR1200_ICCFGR_CBS_BITS] = `OR1200_ICCFGR_CBS;
	    spr_dat_o[`OR1200_ICCFGR_CWS_BITS] = `OR1200_ICCFGR_CWS;
	    spr_dat_o[`OR1200_ICCFGR_CCRI_BITS] = `OR1200_ICCFGR_CCRI;
	    spr_dat_o[`OR1200_ICCFGR_CBIRI_BITS] = `OR1200_ICCFGR_CBIRI;
	    spr_dat_o[`OR1200_ICCFGR_CBPRI_BITS] = `OR1200_ICCFGR_CBPRI;
	    spr_dat_o[`OR1200_ICCFGR_CBLRI_BITS] = `OR1200_ICCFGR_CBLRI;
	    spr_dat_o[`OR1200_ICCFGR_CBFRI_BITS] = `OR1200_ICCFGR_CBFRI;
	    spr_dat_o[`OR1200_ICCFGR_CBWBRI_BITS] = `OR1200_ICCFGR_CBWBRI;
	    spr_dat_o[`OR1200_ICCFGR_RES1_BITS] = `OR1200_ICCFGR_RES1;
	 end
	 `OR1200_SPRGRP_SYS_DCFGR: begin
	    spr_dat_o[`OR1200_DCFGR_NDP_BITS] = `OR1200_DCFGR_NDP;
	    spr_dat_o[`OR1200_DCFGR_WPCI_BITS] = `OR1200_DCFGR_WPCI;
	    spr_dat_o[`OR1200_DCFGR_RES1_BITS] = `OR1200_DCFGR_RES1;
	 end
	 default: spr_dat_o = 32'h0000_0000;
       endcase
 `ifdef OR1200_SYS_FULL_DECODE
     else
       spr_dat_o = 32'h0000_0000;
 `endif

`else

   //
   // When configuration registers are not implemented, only
   // implement VR and UPR
   //
   always @(spr_addr)
 `ifdef OR1200_SYS_FULL_DECODE
     if (spr_addr[31:4] == 28'h0)
 `endif
       case(spr_addr[3:0])
	 `OR1200_SPRGRP_SYS_VR: begin
	    spr_dat_o[`OR1200_VR_REV_BITS] = `OR1200_VR_REV;
	    spr_dat_o[`OR1200_VR_RES1_BITS] = `OR1200_VR_RES1;
	    spr_dat_o[`OR1200_VR_CFG_BITS] = `OR1200_VR_CFG;
	    spr_dat_o[`OR1200_VR_VER_BITS] = `OR1200_VR_VER;
	 end
	 `OR1200_SPRGRP_SYS_UPR: begin
	    spr_dat_o[`OR1200_UPR_UP_BITS] = `OR1200_UPR_UP;
	    spr_dat_o[`OR1200_UPR_DCP_BITS] = `OR1200_UPR_DCP;
	    spr_dat_o[`OR1200_UPR_ICP_BITS] = `OR1200_UPR_ICP;
	    spr_dat_o[`OR1200_UPR_DMP_BITS] = `OR1200_UPR_DMP;
	    spr_dat_o[`OR1200_UPR_IMP_BITS] = `OR1200_UPR_IMP;
	    spr_dat_o[`OR1200_UPR_MP_BITS] = `OR1200_UPR_MP;
	    spr_dat_o[`OR1200_UPR_DUP_BITS] = `OR1200_UPR_DUP;
	    spr_dat_o[`OR1200_UPR_PCUP_BITS] = `OR1200_UPR_PCUP;
	    spr_dat_o[`OR1200_UPR_PMP_BITS] = `OR1200_UPR_PMP;
	    spr_dat_o[`OR1200_UPR_PICP_BITS] = `OR1200_UPR_PICP;
	    spr_dat_o[`OR1200_UPR_TTP_BITS] = `OR1200_UPR_TTP;
	    spr_dat_o[`OR1200_UPR_RES1_BITS] = `OR1200_UPR_RES1;
	    spr_dat_o[`OR1200_UPR_CUP_BITS] = `OR1200_UPR_CUP;
	 end
	 default: spr_dat_o = 32'h0000_0000;
       endcase
 `ifdef OR1200_SYS_FULL_DECODE
     else
       spr_dat_o = 32'h0000_0000;
 `endif

`endif

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's CPU                                                ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Instantiation of internal CPU blocks. IFETCH, SPRS, FRZ,    ////
////  ALU, EXCEPT, ID, WBMUX, OPERANDMUX, RF etc.                 ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_cpu.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 

// synopsys translate_off
// synopsys translate_on

module or1200_cpu(
	// Clk & Rst
	clk, rst,

	// Insn interface
	ic_en,
	icpu_adr_o, icpu_cycstb_o, icpu_sel_o, icpu_tag_o,
	icpu_dat_i, icpu_ack_i, icpu_rty_i, icpu_err_i, icpu_adr_i, icpu_tag_i,
	immu_en,

	// Debug unit
	id_void, id_insn, ex_void, 
	ex_insn, ex_freeze, wb_insn, wb_freeze, id_pc, ex_pc, wb_pc, branch_op,
	spr_dat_npc, rf_dataw, ex_flushpipe, 
	du_stall, du_addr, du_dat_du, du_read, du_write, du_except_stop, 
	du_except_trig, du_dsr, du_dmr1, du_hwbkpt, du_hwbkpt_ls_r, du_dat_cpu,
	du_lsu_store_dat, du_lsu_load_dat, 
	abort_mvspr, abort_ex,
	
	// Data interface
	dc_en,
	dcpu_adr_o, dcpu_cycstb_o, dcpu_we_o, dcpu_sel_o, dcpu_tag_o, 
        dcpu_dat_o, dcpu_dat_i, dcpu_ack_i, dcpu_rty_i, dcpu_err_i, dcpu_tag_i,
	sb_en, dmmu_en, dc_no_writethrough,

	// SR Interface
	boot_adr_sel_i,

	// Interrupt & tick exceptions
	sig_int, sig_tick,

	// SPR interface
	supv, spr_addr, spr_dat_cpu, spr_dat_pic, spr_dat_tt, spr_dat_pm,
	spr_dat_dmmu, spr_dat_immu, spr_dat_du, spr_cs, spr_we, mtspr_dc_done
);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_REGFILE_ADDR_WIDTH;

//
// I/O ports
//

//
// Clk & Rst
//
input 				clk;
input 				rst;

//
// Insn (IC) interface
//
output				ic_en;
output	[31:0]			icpu_adr_o;
output				icpu_cycstb_o;
output	[3:0]			icpu_sel_o;
output	[3:0]			icpu_tag_o;
input	[31:0]			icpu_dat_i;
input				icpu_ack_i;
input				icpu_rty_i;
input				icpu_err_i;
input	[31:0]			icpu_adr_i;
input	[3:0]			icpu_tag_i;

//
// Insn (IMMU) interface
//
output				immu_en;

//
// Debug interface
//
output                          id_void;
output	[31:0]			id_insn;
output                          ex_void;
output	[31:0]			ex_insn;
output				ex_freeze;
output	[31:0]			wb_insn;
output				wb_freeze;
output	[31:0]			id_pc;
output	[31:0]			ex_pc;
output	[31:0]			wb_pc;
output                          ex_flushpipe;
output	[`OR1200_BRANCHOP_WIDTH-1:0]	branch_op;

input				du_stall;
input	[dw-1:0]		du_addr;
input	[dw-1:0]		du_dat_du;
input				du_read;
input				du_write;
input	[`OR1200_DU_DSR_WIDTH-1:0]	du_dsr;
input	[24:0]			du_dmr1;
input				du_hwbkpt;
input				du_hwbkpt_ls_r;
output	[13:0]			du_except_trig;
output	[13:0]			du_except_stop;
output	[dw-1:0]		du_dat_cpu;
output	[dw-1:0]		rf_dataw;
output	[dw-1:0]		du_lsu_store_dat;
output	[dw-1:0]		du_lsu_load_dat;

//
// Data (DC) interface
//
output	[31:0]			dcpu_adr_o;
output				dcpu_cycstb_o;
output				dcpu_we_o;
output	[3:0]			dcpu_sel_o;
output	[3:0]			dcpu_tag_o;
output	[31:0]			dcpu_dat_o;
input	[31:0]			dcpu_dat_i;
input				dcpu_ack_i;
input				dcpu_rty_i;
input				dcpu_err_i;
input	[3:0]			dcpu_tag_i;
output				dc_en;
output  			dc_no_writethrough;
   
//
// Data (DMMU) interface
//
output				sb_en;
output				dmmu_en;
output				abort_ex;
output				abort_mvspr;

//
// SR Interface 
//
input				boot_adr_sel_i;

//
// SPR interface
//
output				supv;
input	[dw-1:0]		spr_dat_pic;
input	[dw-1:0]		spr_dat_tt;
input	[dw-1:0]		spr_dat_pm;
input	[dw-1:0]		spr_dat_dmmu;
input	[dw-1:0]		spr_dat_immu;
input	[dw-1:0]		spr_dat_du;
output	[dw-1:0]		spr_addr;
output	[dw-1:0]		spr_dat_cpu;
output	[dw-1:0]		spr_dat_npc;
output	[31:0]			spr_cs;
output				spr_we;
input   			mtspr_dc_done;
   
//
// Interrupt exceptions
//
input				sig_int;
input				sig_tick;

//
// Internal wires
//
wire	[31:0]			if_insn;
wire				saving_if_insn;
wire	[31:0]			if_pc;
wire	[aw-1:0]		rf_addrw;
wire	[aw-1:0] 		rf_addra;
wire	[aw-1:0] 		rf_addrb;
wire				rf_rda;
wire				rf_rdb;
wire	[dw-1:0]		id_simm;
wire	[dw-1:2]		id_branch_addrtarget;
wire	[dw-1:2]		ex_branch_addrtarget;
wire	[`OR1200_ALUOP_WIDTH-1:0]	alu_op;
wire	[`OR1200_ALUOP2_WIDTH-1:0]	alu_op2;
wire	[`OR1200_SHROTOP_WIDTH-1:0]	shrot_op;
wire	[`OR1200_COMPOP_WIDTH-1:0]	comp_op;
wire	[`OR1200_BRANCHOP_WIDTH-1:0]	pre_branch_op;
wire	[`OR1200_BRANCHOP_WIDTH-1:0]	branch_op;
wire	[`OR1200_LSUOP_WIDTH-1:0]	id_lsu_op;
wire				genpc_freeze;
wire				if_freeze;
wire				id_freeze;
wire				ex_freeze;
wire				wb_freeze;
wire	[`OR1200_SEL_WIDTH-1:0]	sel_a;
wire	[`OR1200_SEL_WIDTH-1:0]	sel_b;
wire	[`OR1200_RFWBOP_WIDTH-1:0]	rfwb_op;
wire    [`OR1200_FPUOP_WIDTH-1:0]       fpu_op;
wire	[dw-1:0]		rf_dataw;
wire	[dw-1:0]		rf_dataa;
wire	[dw-1:0]		rf_datab;
wire	[dw-1:0]		muxed_a;
wire	[dw-1:0]		muxed_b;
wire	[dw-1:0]		wb_forw;
wire				wbforw_valid;
wire	[dw-1:0]		operand_a;
wire	[dw-1:0]		operand_b;
wire	[dw-1:0]		alu_dataout;
wire	[dw-1:0]		lsu_dataout;
wire	[dw-1:0]		sprs_dataout;
wire	[dw-1:0]		fpu_dataout;
wire     			fpu_done;
wire	[31:0]			ex_simm;
wire	[`OR1200_MULTICYCLE_WIDTH-1:0]	multicycle;
wire    [`OR1200_WAIT_ON_WIDTH-1:0]	wait_on;      
wire	[`OR1200_EXCEPT_WIDTH-1:0]	except_type;
wire	[4:0]			cust5_op;
wire	[5:0]			cust5_limm;
wire				if_flushpipe;
wire				id_flushpipe;
wire				ex_flushpipe;
wire				wb_flushpipe;
wire				extend_flush;
wire				ex_branch_taken;
wire				flag;
wire				flagforw;
wire				flag_we;
wire				flagforw_alu;   
wire				flag_we_alu;
wire				flagforw_fpu;
wire				flag_we_fpu;
wire				carry;
wire				cyforw;
wire				cy_we_alu;
wire				cy_we_rf;
wire				lsu_stall;
wire				epcr_we;
wire				eear_we;
wire				esr_we;
wire				pc_we;
wire	[31:0]			epcr;
wire	[31:0]			eear;
wire	[`OR1200_SR_WIDTH-1:0]	esr;
wire 	[`OR1200_FPCSR_WIDTH-1:0]       fpcsr;
wire 				fpcsr_we;   
wire				sr_we;
wire	[`OR1200_SR_WIDTH-1:0]	to_sr;
wire	[`OR1200_SR_WIDTH-1:0]	sr;
wire				except_flushpipe;
wire				except_start;
wire				except_started;
wire    			fpu_except_started;   
wire	[31:0]			wb_insn;
wire				sig_syscall;
wire				sig_trap;
wire				sig_fp;
wire	[31:0]			spr_dat_cfgr;
wire	[31:0]			spr_dat_rf;
wire    [31:0]                  spr_dat_npc;
wire	[31:0]			spr_dat_ppc;
wire	[31:0]			spr_dat_mac;
wire [31:0] 			spr_dat_fpu;
wire     			mtspr_done;
wire				force_dslot_fetch;
wire				no_more_dslot;
wire				ex_void;
wire				ex_spr_read;
wire				ex_spr_write;
wire				if_stall;
wire				id_macrc_op;
wire				ex_macrc_op;
wire	[`OR1200_MACOP_WIDTH-1:0] id_mac_op;
wire	[`OR1200_MACOP_WIDTH-1:0] mac_op;
wire	[31:0]			mult_mac_result;
wire				mac_stall;
wire	[13:0]			except_trig;
wire	[13:0]			except_stop;
wire				genpc_refetch;
wire				rfe;
wire				lsu_unstall;
wire				except_align;
wire				except_dtlbmiss;
wire				except_dmmufault;
wire				except_illegal;
wire				except_itlbmiss;
wire				except_immufault;
wire				except_ibuserr;
wire				except_dbuserr;
wire				abort_ex;
wire				abort_mvspr;

//
// Send exceptions to Debug Unit
//
assign du_except_trig = except_trig;
assign du_except_stop = except_stop;
assign du_lsu_store_dat = operand_b;
assign du_lsu_load_dat  = lsu_dataout;

//
// Data cache enable
//
`ifdef OR1200_NO_DC
assign dc_en = 1'b0;
`else
   assign dc_en = sr[`OR1200_SR_DCE];
`endif

//
// Instruction cache enable
//
`ifdef OR1200_NO_IC
assign ic_en = 1'b0;
`else
assign ic_en = sr[`OR1200_SR_ICE];
`endif

//
// SB enable
//
`ifdef OR1200_SB_IMPLEMENTED
//assign sb_en = sr[`OR1200_SR_SBE]; // SBE not defined  -- jb
`else
assign sb_en = 1'b0;
`endif

//
// DMMU enable
//
`ifdef OR1200_NO_DMMU
assign dmmu_en = 1'b0;
`else
assign dmmu_en = sr[`OR1200_SR_DME];
`endif

//
// IMMU enable
//
`ifdef OR1200_NO_IMMU
assign immu_en = 1'b0;
`else
assign immu_en = sr[`OR1200_SR_IME] & ~except_started;
`endif

//
// SUPV bit
//
assign supv = sr[`OR1200_SR_SM];

//
// FLAG write enable
//
assign flagforw = (flag_we_alu & flagforw_alu) | (flagforw_fpu & flag_we_fpu);
assign flag_we = (flag_we_alu | flag_we_fpu) & ~abort_mvspr;

//
//  Flag for any MTSPR instructions, that must block execution, to indicate done
//
assign mtspr_done = mtspr_dc_done;
   
   
//
// Instantiation of instruction fetch block
//
or1200_genpc or1200_genpc(
	.clk(clk),
	.rst(rst),
	.icpu_adr_o(icpu_adr_o),
	.icpu_cycstb_o(icpu_cycstb_o),
	.icpu_sel_o(icpu_sel_o),
	.icpu_tag_o(icpu_tag_o),
	.icpu_rty_i(icpu_rty_i),
	.icpu_adr_i(icpu_adr_i),

	.pre_branch_op(pre_branch_op),
	.branch_op(branch_op),
	.except_type(except_type),
	.except_start(except_start),
	.except_prefix(sr[`OR1200_SR_EPH]),
	.id_branch_addrtarget(id_branch_addrtarget),
	.ex_branch_addrtarget(ex_branch_addrtarget),
	.muxed_b(muxed_b),
	.operand_b(operand_b),
	.flag(flag),
	.flagforw(flagforw),
	.ex_branch_taken(ex_branch_taken),
	.epcr(epcr),
	.spr_dat_i(spr_dat_cpu),
	.spr_pc_we(pc_we),
	.genpc_refetch(genpc_refetch),
	.genpc_freeze(genpc_freeze),
	.no_more_dslot(no_more_dslot)
);

//
// Instantiation of instruction fetch block
//
or1200_if or1200_if(
	.clk(clk),
	.rst(rst),
	.icpu_dat_i(icpu_dat_i),
	.icpu_ack_i(icpu_ack_i),
	.icpu_err_i(icpu_err_i),
	.icpu_adr_i(icpu_adr_i),
	.icpu_tag_i(icpu_tag_i),

	.if_freeze(if_freeze),
	.if_insn(if_insn),
	.if_pc(if_pc),
	.saving_if_insn(saving_if_insn),
	.if_flushpipe(if_flushpipe),
	.if_stall(if_stall),
	.no_more_dslot(no_more_dslot),
	.genpc_refetch(genpc_refetch),
	.rfe(rfe),
	.except_itlbmiss(except_itlbmiss),
	.except_immufault(except_immufault),
	.except_ibuserr(except_ibuserr)
);

//
// Instantiation of instruction decode/control logic
//
or1200_ctrl or1200_ctrl(
	.clk(clk),
	.rst(rst),
	.id_freeze(id_freeze),
	.ex_freeze(ex_freeze),
	.wb_freeze(wb_freeze),
	.if_flushpipe(if_flushpipe),
	.id_flushpipe(id_flushpipe),
	.ex_flushpipe(ex_flushpipe),
	.wb_flushpipe(wb_flushpipe),
	.extend_flush(extend_flush),
	.except_flushpipe(except_flushpipe),
	.abort_mvspr(abort_mvspr),
	.if_insn(if_insn),
	.id_insn(id_insn),
	.ex_insn(ex_insn),
	.id_branch_op(pre_branch_op),
	.ex_branch_op(branch_op),
	.ex_branch_taken(ex_branch_taken),
	.rf_addra(rf_addra),
	.rf_addrb(rf_addrb),
	.rf_rda(rf_rda),
	.rf_rdb(rf_rdb),
	.alu_op(alu_op),
	.alu_op2(alu_op2),			
	.mac_op(mac_op),
	.shrot_op(shrot_op),
	.comp_op(comp_op),
	.rf_addrw(rf_addrw),
	.rfwb_op(rfwb_op),
	.fpu_op(fpu_op),			
	.pc_we(pc_we),
	.wb_insn(wb_insn),
	.id_simm(id_simm),
	.id_branch_addrtarget(id_branch_addrtarget),
	.ex_branch_addrtarget(ex_branch_addrtarget),
	.ex_simm(ex_simm),
	.sel_a(sel_a),
	.sel_b(sel_b),
	.id_lsu_op(id_lsu_op),
	.cust5_op(cust5_op),
	.cust5_limm(cust5_limm),
	.id_pc(id_pc),
	.ex_pc(ex_pc),
	.multicycle(multicycle),
        .wait_on(wait_on),			
	.wbforw_valid(wbforw_valid),
	.sig_syscall(sig_syscall),
	.sig_trap(sig_trap),
	.force_dslot_fetch(force_dslot_fetch),
	.no_more_dslot(no_more_dslot),
	.id_void(id_void),
	.ex_void(ex_void),
	.ex_spr_read(ex_spr_read),
	.ex_spr_write(ex_spr_write),
	.id_mac_op(id_mac_op),
	.id_macrc_op(id_macrc_op),
	.ex_macrc_op(ex_macrc_op),
	.rfe(rfe),
	.du_hwbkpt(du_hwbkpt),
	.except_illegal(except_illegal),
	.dc_no_writethrough(dc_no_writethrough)
);

//
// Instantiation of register file
//
or1200_rf or1200_rf(
	.clk(clk),
	.rst(rst),
	.cy_we_i(cy_we_alu),
	.cy_we_o(cy_we_rf),
	.supv(sr[`OR1200_SR_SM]),
	.wb_freeze(wb_freeze),
	.addrw(rf_addrw),
	.dataw(rf_dataw),
	.id_freeze(id_freeze),
	.we(rfwb_op[0]),
	.flushpipe(wb_flushpipe),
	.addra(rf_addra),
	.rda(rf_rda),
	.dataa(rf_dataa),
	.addrb(rf_addrb),
	.rdb(rf_rdb),
	.datab(rf_datab),
	.spr_cs(spr_cs[`OR1200_SPR_GROUP_SYS]),
	.spr_write(spr_we),
	.spr_addr(spr_addr),
	.spr_dat_i(spr_dat_cpu),
	.spr_dat_o(spr_dat_rf),
	.du_read(du_read)
);

//
// Instantiation of operand muxes
//
or1200_operandmuxes or1200_operandmuxes(
	.clk(clk),
	.rst(rst),
	.id_freeze(id_freeze),
	.ex_freeze(ex_freeze),
	.rf_dataa(rf_dataa),
	.rf_datab(rf_datab),
	.ex_forw(rf_dataw),
	.wb_forw(wb_forw),
	.simm(id_simm),
	.sel_a(sel_a),
	.sel_b(sel_b),
	.operand_a(operand_a),
	.operand_b(operand_b),
	.muxed_a(muxed_a),
	.muxed_b(muxed_b)
);

//
// Instantiation of CPU's ALU
//
or1200_alu or1200_alu(
	.a(operand_a),
	.b(operand_b),
	.mult_mac_result(mult_mac_result),
	.macrc_op(ex_macrc_op),
	.alu_op(alu_op),
	.alu_op2(alu_op2),		      
	.shrot_op(shrot_op),
	.comp_op(comp_op),
	.cust5_op(cust5_op),
	.cust5_limm(cust5_limm),
	.result(alu_dataout),
	.flagforw(flagforw_alu),
	.flag_we(flag_we_alu),
	.cyforw(cyforw),
	.cy_we(cy_we_alu),
	.flag(flag),
	.carry(carry)
);

   
//
// FPU's exception is being dealt with
//    
assign fpu_except_started = except_started && (except_type == `OR1200_EXCEPT_FLOAT);
   
//
// Instantiation of FPU
//
or1200_fpu or1200_fpu(
	.clk(clk),
	.rst(rst),
	.ex_freeze(ex_freeze),
	.a(operand_a),
	.b(operand_b),
	.fpu_op(fpu_op),
	.result(fpu_dataout),
	.done(fpu_done),
	.flagforw(flagforw_fpu),
	.flag_we(flag_we_fpu),
        .sig_fp(sig_fp),
	.except_started(fpu_except_started),
	.fpcsr_we(fpcsr_we),
	.fpcsr(fpcsr),		      
	.spr_cs(spr_cs[`OR1200_SPR_GROUP_FPU]),
	.spr_write(spr_we),
	.spr_addr(spr_addr),
	.spr_dat_i(spr_dat_cpu),
	.spr_dat_o(spr_dat_fpu)
);

   
//
// Instantiation of CPU's multiply unit
//
or1200_mult_mac or1200_mult_mac(
	.clk(clk),
	.rst(rst),
	.ex_freeze(ex_freeze),
	.id_macrc_op(id_macrc_op),
	.macrc_op(ex_macrc_op),
	.a(operand_a),
	.b(operand_b),
	.mac_op(mac_op),
	.alu_op(alu_op),
	.result(mult_mac_result),
	.mac_stall_r(mac_stall),
	.spr_cs(spr_cs[`OR1200_SPR_GROUP_MAC]),
	.spr_write(spr_we),
	.spr_addr(spr_addr),
	.spr_dat_i(spr_dat_cpu),
	.spr_dat_o(spr_dat_mac)
);

//
// Instantiation of CPU's SPRS block
//
or1200_sprs or1200_sprs(
	.clk(clk),
	.rst(rst),
	.addrbase(operand_a),
	.addrofs(ex_simm[15:0]),
	.dat_i(operand_b),
	.ex_spr_read(ex_spr_read),
	.ex_spr_write(ex_spr_write),
	.flagforw(flagforw),
	.flag_we(flag_we),
	.flag(flag),
	.cyforw(cyforw),
	.cy_we(cy_we_rf),
	.carry(carry),
	.to_wbmux(sprs_dataout),

	.du_addr(du_addr),
	.du_dat_du(du_dat_du),
	.du_read(du_read),
	.du_write(du_write),
	.du_dat_cpu(du_dat_cpu),
	.boot_adr_sel_i(boot_adr_sel_i),
	.spr_addr(spr_addr),
	.spr_dat_pic(spr_dat_pic),
	.spr_dat_tt(spr_dat_tt),
	.spr_dat_pm(spr_dat_pm),
	.spr_dat_cfgr(spr_dat_cfgr),
	.spr_dat_rf(spr_dat_rf),
	.spr_dat_npc(spr_dat_npc),
        .spr_dat_ppc(spr_dat_ppc),
	.spr_dat_mac(spr_dat_mac),
	.spr_dat_dmmu(spr_dat_dmmu),
	.spr_dat_immu(spr_dat_immu),
	.spr_dat_du(spr_dat_du),
	.spr_dat_o(spr_dat_cpu),
	.spr_cs(spr_cs),
	.spr_we(spr_we),

	.epcr_we(epcr_we),
	.eear_we(eear_we),
	.esr_we(esr_we),
	.pc_we(pc_we),
	.epcr(epcr),
	.eear(eear),
	.esr(esr),
	.except_started(except_started),

	.fpcsr(fpcsr),
	.fpcsr_we(fpcsr_we),			
	.spr_dat_fpu(spr_dat_fpu),
			
	.sr_we(sr_we),
	.to_sr(to_sr),
	.sr(sr),
	.branch_op(branch_op)
);

//
// Instantiation of load/store unit
//
or1200_lsu or1200_lsu(
	.clk(clk),
	.rst(rst),
	.id_addrbase(muxed_a),
	.id_addrofs(id_simm),
	.ex_addrbase(operand_a),
	.ex_addrofs(ex_simm),
	.id_lsu_op(id_lsu_op),
	.lsu_datain(operand_b),
	.lsu_dataout(lsu_dataout),
	.lsu_stall(lsu_stall),
	.lsu_unstall(lsu_unstall),
	.du_stall(du_stall),
	.except_align(except_align),
	.except_dtlbmiss(except_dtlbmiss),
	.except_dmmufault(except_dmmufault),
	.except_dbuserr(except_dbuserr),
	.id_freeze(id_freeze),
	.ex_freeze(ex_freeze),
	.flushpipe(ex_flushpipe),

	.dcpu_adr_o(dcpu_adr_o),
	.dcpu_cycstb_o(dcpu_cycstb_o),
	.dcpu_we_o(dcpu_we_o),
	.dcpu_sel_o(dcpu_sel_o),
	.dcpu_tag_o(dcpu_tag_o),
	.dcpu_dat_o(dcpu_dat_o),
	.dcpu_dat_i(dcpu_dat_i),
	.dcpu_ack_i(dcpu_ack_i),
	.dcpu_rty_i(dcpu_rty_i),
	.dcpu_err_i(dcpu_err_i),
	.dcpu_tag_i(dcpu_tag_i)
);

//
// Instantiation of write-back muxes
//
or1200_wbmux or1200_wbmux(
	.clk(clk),
	.rst(rst),
	.wb_freeze(wb_freeze),
	.rfwb_op(rfwb_op),
	.muxin_a(alu_dataout),
	.muxin_b(lsu_dataout),
	.muxin_c(sprs_dataout),
	.muxin_d(ex_pc),
        .muxin_e(fpu_dataout),
	.muxout(rf_dataw),
	.muxreg(wb_forw),
	.muxreg_valid(wbforw_valid)
);

//
// Instantiation of freeze logic
//
or1200_freeze or1200_freeze(
	.clk(clk),
	.rst(rst),
	.multicycle(multicycle),
        .wait_on(wait_on),
	.fpu_done(fpu_done),
	.mtspr_done(mtspr_done),
	.flushpipe(wb_flushpipe),
	.extend_flush(extend_flush),
	.lsu_stall(lsu_stall),
	.if_stall(if_stall),
	.lsu_unstall(lsu_unstall),
	.force_dslot_fetch(force_dslot_fetch),
	.abort_ex(abort_ex),
	.du_stall(du_stall),
	.mac_stall(mac_stall),
	.saving_if_insn(saving_if_insn),
	.genpc_freeze(genpc_freeze),
	.if_freeze(if_freeze),
	.id_freeze(id_freeze),
	.ex_freeze(ex_freeze),
	.wb_freeze(wb_freeze),
	.icpu_ack_i(icpu_ack_i),
	.icpu_err_i(icpu_err_i)
);

//
// Instantiation of exception block
//
or1200_except or1200_except(
	.clk(clk),
	.rst(rst),
	.sig_ibuserr(except_ibuserr),
	.sig_dbuserr(except_dbuserr),
	.sig_illegal(except_illegal),
	.sig_align(except_align),
	.sig_range(1'b0),
	.sig_dtlbmiss(except_dtlbmiss),
	.sig_dmmufault(except_dmmufault),
	.sig_int(sig_int),
	.sig_syscall(sig_syscall),
	.sig_trap(sig_trap),
	.sig_itlbmiss(except_itlbmiss),
	.sig_immufault(except_immufault),
	.sig_tick(sig_tick),
	.sig_fp(sig_fp),
	.fpcsr_fpee(fpcsr[`OR1200_FPCSR_FPEE]),
	.ex_branch_taken(ex_branch_taken),
	.icpu_ack_i(icpu_ack_i),
	.icpu_err_i(icpu_err_i),
	.dcpu_ack_i(dcpu_ack_i),
	.dcpu_err_i(dcpu_err_i),
	.genpc_freeze(genpc_freeze),
        .id_freeze(id_freeze),
        .ex_freeze(ex_freeze),
        .wb_freeze(wb_freeze),
	.if_stall(if_stall),
	.if_pc(if_pc),
	.id_pc(id_pc),
	.ex_pc(ex_pc),
	.wb_pc(wb_pc),
	.id_flushpipe(id_flushpipe),
	.ex_flushpipe(ex_flushpipe),
	.extend_flush(extend_flush),
	.except_flushpipe(except_flushpipe),
	.abort_mvspr(abort_mvspr),
	.except_type(except_type),
	.except_start(except_start),
	.except_started(except_started),
	.except_stop(except_stop),
	.except_trig(except_trig),
	.ex_void(ex_void),
	.spr_dat_ppc(spr_dat_ppc),
	.spr_dat_npc(spr_dat_npc),

	.datain(spr_dat_cpu),
	.branch_op(branch_op),
	.du_dsr(du_dsr),
	.du_dmr1(du_dmr1),
	.du_hwbkpt(du_hwbkpt),
	.du_hwbkpt_ls_r(du_hwbkpt_ls_r),
	.epcr_we(epcr_we),
	.eear_we(eear_we),
	.esr_we(esr_we),
	.pc_we(pc_we),
        .epcr(epcr),
	.eear(eear),
	.esr(esr),

	.lsu_addr(dcpu_adr_o),
	.sr_we(sr_we),
	.to_sr(to_sr),
	.sr(sr),
	.abort_ex(abort_ex)
);

//
// Instantiation of configuration registers
//
or1200_cfgr or1200_cfgr(
	.spr_addr(spr_addr),
	.spr_dat_o(spr_dat_cfgr)
);

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Instruction decode                                 ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Majority of instruction decoding is performed here.         ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//
// $Log: or1200_ctrl.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 

// synopsys translate_off
// synopsys translate_on

module or1200_ctrl
  (
   // Clock and reset
   clk, rst,
   
   // Internal i/f
   except_flushpipe, extend_flush, if_flushpipe, id_flushpipe, ex_flushpipe, 
   wb_flushpipe,
   id_freeze, ex_freeze, wb_freeze, if_insn, id_insn, ex_insn, abort_mvspr, 
   id_branch_op, ex_branch_op, ex_branch_taken, pc_we, 
   rf_addra, rf_addrb, rf_rda, rf_rdb, alu_op, alu_op2, mac_op, shrot_op,
   comp_op, rf_addrw, rfwb_op, fpu_op,
   wb_insn, id_simm, ex_simm, id_branch_addrtarget, ex_branch_addrtarget, sel_a,
   sel_b, id_lsu_op,
   cust5_op, cust5_limm, id_pc, ex_pc, du_hwbkpt, 
   multicycle, wait_on, wbforw_valid, sig_syscall, sig_trap,
   force_dslot_fetch, no_more_dslot, id_void, ex_void, ex_spr_read, 
   ex_spr_write, 
   id_mac_op, id_macrc_op, ex_macrc_op, rfe, except_illegal, dc_no_writethrough
   );

//
// I/O
//
input					clk;
input					rst;
input					id_freeze;
input					ex_freeze /* verilator public */;
input					wb_freeze /* verilator public */;
output					if_flushpipe;
output					id_flushpipe;
output					ex_flushpipe;
output					wb_flushpipe;
input					extend_flush;
input					except_flushpipe;
input                           abort_mvspr ;
input	[31:0]			if_insn;
output	[31:0]			id_insn;
output	[31:0]			ex_insn /* verilator public */;
output	[`OR1200_BRANCHOP_WIDTH-1:0]		ex_branch_op;
output	[`OR1200_BRANCHOP_WIDTH-1:0]		id_branch_op;
input						ex_branch_taken;
output	[`OR1200_REGFILE_ADDR_WIDTH-1:0]	rf_addrw;
output	[`OR1200_REGFILE_ADDR_WIDTH-1:0]	rf_addra;
output	[`OR1200_REGFILE_ADDR_WIDTH-1:0]	rf_addrb;
output					rf_rda;
output					rf_rdb;
output	[`OR1200_ALUOP_WIDTH-1:0]		alu_op;
output [`OR1200_ALUOP2_WIDTH-1:0] 		alu_op2;
output	[`OR1200_MACOP_WIDTH-1:0]		mac_op;
output	[`OR1200_SHROTOP_WIDTH-1:0]		shrot_op;
output	[`OR1200_RFWBOP_WIDTH-1:0]		rfwb_op;
output  [`OR1200_FPUOP_WIDTH-1:0] 		fpu_op;      
input					pc_we;
output	[31:0]				wb_insn;
output	[31:2]				id_branch_addrtarget;
output	[31:2]				ex_branch_addrtarget;
output	[`OR1200_SEL_WIDTH-1:0]		sel_a;
output	[`OR1200_SEL_WIDTH-1:0]		sel_b;
output	[`OR1200_LSUOP_WIDTH-1:0]		id_lsu_op;
output	[`OR1200_COMPOP_WIDTH-1:0]		comp_op;
output	[`OR1200_MULTICYCLE_WIDTH-1:0]		multicycle;
output  [`OR1200_WAIT_ON_WIDTH-1:0] 		wait_on;   
output	[4:0]				cust5_op;
output	[5:0]				cust5_limm;
input   [31:0]                          id_pc;
input   [31:0]                          ex_pc;
output	[31:0]				id_simm;
output	[31:0]				ex_simm;
input					wbforw_valid;
input					du_hwbkpt;
output					sig_syscall;
output					sig_trap;
output					force_dslot_fetch;
output					no_more_dslot;
output					id_void;
output					ex_void;
output					ex_spr_read;
output					ex_spr_write;
output	[`OR1200_MACOP_WIDTH-1:0]	id_mac_op;
output					id_macrc_op;
output					ex_macrc_op;
output					rfe;
output					except_illegal;
output  				dc_no_writethrough;
   
				
//
// Internal wires and regs
//
reg	[`OR1200_BRANCHOP_WIDTH-1:0]		id_branch_op;
reg	[`OR1200_BRANCHOP_WIDTH-1:0]		ex_branch_op;
reg	[`OR1200_ALUOP_WIDTH-1:0]		alu_op;
reg [`OR1200_ALUOP2_WIDTH-1:0]      		alu_op2;
wire					if_maci_op;
`ifdef OR1200_MAC_IMPLEMENTED
reg	[`OR1200_MACOP_WIDTH-1:0]		ex_mac_op;
reg	[`OR1200_MACOP_WIDTH-1:0]		id_mac_op;
wire	[`OR1200_MACOP_WIDTH-1:0]		mac_op;
reg					ex_macrc_op;
`else
wire	[`OR1200_MACOP_WIDTH-1:0]		mac_op;
wire					ex_macrc_op;
`endif
reg	[`OR1200_SHROTOP_WIDTH-1:0]		shrot_op;
reg	[31:0]				id_insn /* verilator public */;
reg	[31:0]				ex_insn /* verilator public */;
reg	[31:0]				wb_insn /* verilator public */;
reg	[`OR1200_REGFILE_ADDR_WIDTH-1:0]	rf_addrw;
reg	[`OR1200_REGFILE_ADDR_WIDTH-1:0]	wb_rfaddrw;
reg	[`OR1200_RFWBOP_WIDTH-1:0]		rfwb_op;
reg	[`OR1200_SEL_WIDTH-1:0]		sel_a;
reg	[`OR1200_SEL_WIDTH-1:0]		sel_b;
reg					sel_imm;
reg	[`OR1200_LSUOP_WIDTH-1:0]		id_lsu_op;
reg	[`OR1200_COMPOP_WIDTH-1:0]		comp_op;
reg	[`OR1200_MULTICYCLE_WIDTH-1:0]		multicycle;
reg     [`OR1200_WAIT_ON_WIDTH-1:0] 		wait_on;      
reg 	[31:0]				id_simm;
reg 	[31:0]				ex_simm;
reg					sig_syscall;
reg					sig_trap;
reg					except_illegal;
wire					id_void;
wire					ex_void;
wire                                    wb_void;
reg                                     ex_delayslot_dsi;
reg                                     ex_delayslot_nop;
reg					spr_read;
reg					spr_write;
reg     [31:2]				ex_branch_addrtarget;
`ifdef OR1200_DC_NOSTACKWRITETHROUGH
reg 					dc_no_writethrough;
`endif
   
//
// Register file read addresses
//
assign rf_addra = if_insn[20:16];
assign rf_addrb = if_insn[15:11];
assign rf_rda = if_insn[31] || if_maci_op;
assign rf_rdb = if_insn[30];

//
// Force fetch of delay slot instruction when jump/branch is preceeded by load/store
// instructions
//
assign force_dslot_fetch = 1'b0;
assign no_more_dslot = (|ex_branch_op & !id_void & ex_branch_taken) | (ex_branch_op == `OR1200_BRANCHOP_RFE);

assign id_void = (id_insn[31:26] == `OR1200_OR32_NOP) & id_insn[16];
assign ex_void = (ex_insn[31:26] == `OR1200_OR32_NOP) & ex_insn[16];
assign wb_void = (wb_insn[31:26] == `OR1200_OR32_NOP) & wb_insn[16];

assign ex_spr_write = spr_write && !abort_mvspr;
assign ex_spr_read = spr_read && !abort_mvspr;

//
// ex_delayslot_dsi: delay slot insn is in EX stage
// ex_delayslot_nop: (filler) nop insn is in EX stage (before nops jump/branch was executed)
//
//  ex_delayslot_dsi & !ex_delayslot_nop - DS insn in EX stage
//  !ex_delayslot_dsi & ex_delayslot_nop - NOP insn in EX stage, 
//       next different is DS insn, previous different was Jump/Branch
//  !ex_delayslot_dsi & !ex_delayslot_nop - normal insn in EX stage
//
always @(posedge clk ) begin
        if (rst == `OR1200_RST_VALUE) begin
		ex_delayslot_nop <=  1'b0;
		ex_delayslot_dsi <=  1'b0;
	end
	else if (!ex_freeze & !ex_delayslot_dsi & ex_delayslot_nop) begin
		ex_delayslot_nop <=  id_void;
		ex_delayslot_dsi <=  !id_void;
	end
	else if (!ex_freeze & ex_delayslot_dsi & !ex_delayslot_nop) begin
		ex_delayslot_nop <=  1'b0;
		ex_delayslot_dsi <=  1'b0;
	end
	else if (!ex_freeze) begin
		ex_delayslot_nop <=  id_void && ex_branch_taken && (ex_branch_op != `OR1200_BRANCHOP_NOP) && 
								(ex_branch_op != `OR1200_BRANCHOP_RFE);
		ex_delayslot_dsi <=  !id_void && ex_branch_taken && (ex_branch_op != `OR1200_BRANCHOP_NOP) && 
								 (ex_branch_op != `OR1200_BRANCHOP_RFE);
	end
end

//
// Flush pipeline
//
assign if_flushpipe = except_flushpipe | pc_we | extend_flush;
assign id_flushpipe = except_flushpipe | pc_we | extend_flush;
assign ex_flushpipe = except_flushpipe | pc_we | extend_flush;
assign wb_flushpipe = except_flushpipe | pc_we | extend_flush;

//
// EX Sign/Zero extension of immediates
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		ex_simm <=  32'h0000_0000;
	else if (!ex_freeze) begin
		ex_simm <=  id_simm;
	end
end

//
// ID Sign/Zero extension of immediate
//
always @(id_insn) begin
	case (id_insn[31:26])     // synopsys parallel_case

	// l.addi
	`OR1200_OR32_ADDI:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// l.addic
	`OR1200_OR32_ADDIC:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// l.lxx (load instructions)
	`OR1200_OR32_LWZ, `OR1200_OR32_LBZ, `OR1200_OR32_LBS, `OR1200_OR32_LHZ, `OR1200_OR32_LHS:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// l.muli
	`ifdef OR1200_MULT_IMPLEMENTED
	`OR1200_OR32_MULI:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};
	`endif

	// l.maci
	`ifdef OR1200_MAC_IMPLEMENTED
	`OR1200_OR32_MACI:
		id_simm = {{16{id_insn[25]}}, id_insn[25:21], id_insn[10:0]};
	`endif

	// l.mtspr
	`OR1200_OR32_MTSPR:
		id_simm = {16'b0, id_insn[25:21], id_insn[10:0]};

	// l.sxx (store instructions)
	`OR1200_OR32_SW, `OR1200_OR32_SH, `OR1200_OR32_SB:
		id_simm = {{16{id_insn[25]}}, id_insn[25:21], id_insn[10:0]};

	// l.xori
	`OR1200_OR32_XORI:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// l.sfxxi (SFXX with immediate)
	`OR1200_OR32_SFXXI:
		id_simm = {{16{id_insn[15]}}, id_insn[15:0]};

	// Instructions with no or zero extended immediate
	default:
		id_simm = {{16'b0}, id_insn[15:0]};

	endcase
end

//
// ID Sign extension of branch offset
//
assign id_branch_addrtarget = {{4{id_insn[25]}}, id_insn[25:0]} + id_pc[31:2];

//
// EX Sign extension of branch offset
//

// pipeline ID and EX branch target address 
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		ex_branch_addrtarget <=  0;
	else if (!ex_freeze) 
		ex_branch_addrtarget <=  id_branch_addrtarget;
end
// not pipelined
//assign ex_branch_addrtarget = {{4{ex_insn[25]}}, ex_insn[25:0]} + ex_pc[31:2];

//
// l.maci in IF stage
//
`ifdef OR1200_MAC_IMPLEMENTED
assign if_maci_op = (if_insn[31:26] == `OR1200_OR32_MACI);
`else
assign if_maci_op = 1'b0;
`endif

//
// l.macrc in ID stage
//
`ifdef OR1200_MAC_IMPLEMENTED
assign id_macrc_op = (id_insn[31:26] == `OR1200_OR32_MOVHI) & id_insn[16];
`else
assign id_macrc_op = 1'b0;
`endif

//
// l.macrc in EX stage
//
`ifdef OR1200_MAC_IMPLEMENTED
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		ex_macrc_op <=  1'b0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		ex_macrc_op <=  1'b0;
	else if (!ex_freeze)
		ex_macrc_op <=  id_macrc_op;
end
`else
assign ex_macrc_op = 1'b0;
`endif

//
// cust5_op, cust5_limm (L immediate)
//
assign cust5_op = ex_insn[4:0];
assign cust5_limm = ex_insn[10:5];

//
//
//
assign rfe = (id_branch_op == `OR1200_BRANCHOP_RFE) | (ex_branch_op == `OR1200_BRANCHOP_RFE);

   
`ifdef verilator
   // Function to access wb_insn (for Verilator). Have to hide this from
   // simulator, since functions with no inputs are not allowed in IEEE
   // 1364-2001.
   function [31:0] get_wb_insn;
      // verilator public
      get_wb_insn = wb_insn;
   endfunction // get_wb_insn

   // Function to access id_insn (for Verilator). Have to hide this from
   // simulator, since functions with no inputs are not allowed in IEEE
   // 1364-2001.
   function [31:0] get_id_insn;
      // verilator public
      get_id_insn = id_insn;
   endfunction // get_id_insn

   // Function to access ex_insn (for Verilator). Have to hide this from
   // simulator, since functions with no inputs are not allowed in IEEE
   // 1364-2001.
   function [31:0] get_ex_insn;
      // verilator public
      get_ex_insn = ex_insn;
   endfunction // get_ex_insn
   
`endif

   
//
// Generation of sel_a
//
always @(rf_addrw or id_insn or rfwb_op or wbforw_valid or wb_rfaddrw)
	if ((id_insn[20:16] == rf_addrw) && rfwb_op[0])
		sel_a = `OR1200_SEL_EX_FORW;
	else if ((id_insn[20:16] == wb_rfaddrw) && wbforw_valid)
		sel_a = `OR1200_SEL_WB_FORW;
	else
		sel_a = `OR1200_SEL_RF;

//
// Generation of sel_b
//
always @(rf_addrw or sel_imm or id_insn or rfwb_op or wbforw_valid or wb_rfaddrw)
	if (sel_imm)
		sel_b = `OR1200_SEL_IMM;
	else if ((id_insn[15:11] == rf_addrw) && rfwb_op[0])
		sel_b = `OR1200_SEL_EX_FORW;
	else if ((id_insn[15:11] == wb_rfaddrw) && wbforw_valid)
		sel_b = `OR1200_SEL_WB_FORW;
	else
		sel_b = `OR1200_SEL_RF;

//
// Decode of multicycle
//
always @(id_insn) begin
  case (id_insn[31:26])		// synopsys parallel_case
`ifdef UNUSED
    // l.lwz
    `OR1200_OR32_LWZ:
      multicycle = `OR1200_TWO_CYCLES;
    
    // l.lbz
    `OR1200_OR32_LBZ:
      multicycle = `OR1200_TWO_CYCLES;
    
    // l.lbs
    `OR1200_OR32_LBS:
      multicycle = `OR1200_TWO_CYCLES;
    
    // l.lhz
    `OR1200_OR32_LHZ:
      multicycle = `OR1200_TWO_CYCLES;
    
    // l.lhs
    `OR1200_OR32_LHS:
      multicycle = `OR1200_TWO_CYCLES;
    
    // l.sw
    `OR1200_OR32_SW:
      multicycle = `OR1200_TWO_CYCLES;
    
    // l.sb
    `OR1200_OR32_SB:
      multicycle = `OR1200_TWO_CYCLES;
    
    // l.sh
    `OR1200_OR32_SH:
      multicycle = `OR1200_TWO_CYCLES;
`endif    
    // l.mfspr
    `OR1200_OR32_MFSPR:
      multicycle = `OR1200_TWO_CYCLES;	// to read from ITLB/DTLB (sync RAMs)

    // ALU instructions except the one with immediate
    `OR1200_OR32_ALU:
        case (id_insn[3:0]) // synopsys parallel_case
        4'h6: multicycle = `OR1200_MULTICYCLE_WIDTH'd3; // l.mul
        4'h9: multicycle = `OR1200_MULTICYCLE_WIDTH'd2; // l.div
        4'hA: multicycle = `OR1200_MULTICYCLE_WIDTH'd2; // l.divu
        4'hB: multicycle = `OR1200_MULTICYCLE_WIDTH'd3; // l.mulu
        default: multicycle = `OR1200_MULTICYCLE_WIDTH'd0;
        endcase    
    `OR1200_OR32_MULI:
      multicycle = `OR1200_MULTICYCLE_WIDTH'd3;
    
    // Single cycle instructions
    default: begin
      multicycle = `OR1200_ONE_CYCLE;
    end    
  endcase
end // always @ (id_insn)

//
// Encode wait_on signal
//    
always @(id_insn) begin
   case (id_insn[31:26])		// synopsys parallel_case
`ifdef OR1200_FPU_IMPLEMENTED
       `OR1200_OR32_FLOAT: begin
	 wait_on = id_insn[`OR1200_FPUOP_DOUBLE_BIT] ? 0 : `OR1200_WAIT_ON_FPU;
       end
`endif
`ifndef OR1200_DC_WRITHROUGH
     // l.mtspr
     `OR1200_OR32_MTSPR: begin
	wait_on = `OR1200_WAIT_ON_MTSPR;
     end
`endif
     default: begin
	wait_on = 0;
     end
   endcase // case (id_insn[31:26])
end // always @ (id_insn)
   
   
   
   
//
// Register file write address
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		rf_addrw <=  5'd0;
	else if (!ex_freeze & id_freeze)
		rf_addrw <=  5'd00;
	else if (!ex_freeze)
		case (id_insn[31:26])	// synopsys parallel_case
			`OR1200_OR32_JAL, `OR1200_OR32_JALR:
				rf_addrw <=  5'd09;	// link register r9
			default:
				rf_addrw <=  id_insn[25:21];
		endcase
end

//
// rf_addrw in wb stage (used in forwarding logic)
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		wb_rfaddrw <=  5'd0;
	else if (!wb_freeze)
		wb_rfaddrw <=  rf_addrw;
end

//
// Instruction latch in id_insn
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		id_insn <=  {`OR1200_OR32_NOP, 26'h041_0000};
        else if (id_flushpipe)
                id_insn <=  {`OR1200_OR32_NOP, 26'h041_0000};        // NOP -> id_insn[16] must be 1
	else if (!id_freeze) begin
		id_insn <=  if_insn;
`ifdef OR1200_VERBOSE
// synopsys translate_off
		$display("%t: id_insn <= %h", $time, if_insn);
// synopsys translate_on
`endif
	end
end

//
// Instruction latch in ex_insn
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		ex_insn <=  {`OR1200_OR32_NOP, 26'h041_0000};
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		ex_insn <=  {`OR1200_OR32_NOP, 26'h041_0000};	// NOP -> ex_insn[16] must be 1
	else if (!ex_freeze) begin
		ex_insn <=  id_insn;
`ifdef OR1200_VERBOSE
// synopsys translate_off
		$display("%t: ex_insn <= %h", $time, id_insn);
// synopsys translate_on
`endif
	end
end
   
//
// Instruction latch in wb_insn
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		wb_insn <=  {`OR1200_OR32_NOP, 26'h041_0000};
	// wb_insn should not be changed by exceptions due to correct 
	// recording of display_arch_state in the or1200_monitor! 
	// wb_insn changed by exception is not used elsewhere! 
	else if (!wb_freeze) begin
		wb_insn <=  ex_insn;
	end
end

//
// Decode of sel_imm
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		sel_imm <=  1'b0;
	else if (!id_freeze) begin
	  case (if_insn[31:26])		// synopsys parallel_case

	    // j.jalr
	    `OR1200_OR32_JALR:
	      sel_imm <=  1'b0;
	    
	    // l.jr
	    `OR1200_OR32_JR:
	      sel_imm <=  1'b0;
	    
	    // l.rfe
	    `OR1200_OR32_RFE:
	      sel_imm <=  1'b0;
	    
	    // l.mfspr
	    `OR1200_OR32_MFSPR:
	      sel_imm <=  1'b0;
	    
	    // l.mtspr
	    `OR1200_OR32_MTSPR:
	      sel_imm <=  1'b0;
	    
	    // l.sys, l.brk and all three sync insns
	    `OR1200_OR32_XSYNC:
	      sel_imm <=  1'b0;
	    
	    // l.mac/l.msb
`ifdef OR1200_MAC_IMPLEMENTED
	    `OR1200_OR32_MACMSB:
	      sel_imm <=  1'b0;
`endif

	    // l.sw
	    `OR1200_OR32_SW:
	      sel_imm <=  1'b0;
	    
	    // l.sb
	    `OR1200_OR32_SB:
	      sel_imm <=  1'b0;
	    
	    // l.sh
	    `OR1200_OR32_SH:
	      sel_imm <=  1'b0;
	    
	    // ALU instructions except the one with immediate
	    `OR1200_OR32_ALU:
	      sel_imm <=  1'b0;
	    
	    // SFXX instructions
	    `OR1200_OR32_SFXX:
	      sel_imm <=  1'b0;

`ifdef OR1200_OR32_CUST5
	    // l.cust5 instructions
	    `OR1200_OR32_CUST5:
	      sel_imm <=  1'b0;
`endif
`ifdef OR1200_FPU_IMPLEMENTED
	    // FPU instructions
	    `OR1200_OR32_FLOAT:
	      sel_imm <=  1'b0;
`endif
	    // l.nop
	    `OR1200_OR32_NOP:
	      sel_imm <=  1'b0;

	    // All instructions with immediates
	    default: begin
	      sel_imm <=  1'b1;
	    end
	    
	  endcase
	  
	end
end

//
// Decode of except_illegal
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		except_illegal <=  1'b0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		except_illegal <=  1'b0;
	else if (!ex_freeze) begin
		case (id_insn[31:26])		// synopsys parallel_case

		`OR1200_OR32_J,
		`OR1200_OR32_JAL,
		`OR1200_OR32_JALR,
		`OR1200_OR32_JR,
		`OR1200_OR32_BNF,
		`OR1200_OR32_BF,
		`OR1200_OR32_RFE,
		`OR1200_OR32_MOVHI,
		`OR1200_OR32_MFSPR,
		`OR1200_OR32_XSYNC,
`ifdef OR1200_MAC_IMPLEMENTED
		`OR1200_OR32_MACI,
`endif
		`OR1200_OR32_LWZ,
		`OR1200_OR32_LBZ,
		`OR1200_OR32_LBS,
		`OR1200_OR32_LHZ,
		`OR1200_OR32_LHS,
		`OR1200_OR32_ADDI,
		`OR1200_OR32_ADDIC,
		`OR1200_OR32_ANDI,
		`OR1200_OR32_ORI,
		`OR1200_OR32_XORI,
`ifdef OR1200_MULT_IMPLEMENTED
		`OR1200_OR32_MULI,
`endif
		`OR1200_OR32_SH_ROTI,
		`OR1200_OR32_SFXXI,
		`OR1200_OR32_MTSPR,
`ifdef OR1200_MAC_IMPLEMENTED
		`OR1200_OR32_MACMSB,
`endif
		`OR1200_OR32_SW,
		`OR1200_OR32_SB,
		`OR1200_OR32_SH,
		`OR1200_OR32_SFXX,
`ifdef OR1200_OR32_CUST5
		`OR1200_OR32_CUST5,
`endif
	`OR1200_OR32_NOP:
		except_illegal <=  1'b0;
`ifdef OR1200_FPU_IMPLEMENTED
	    `OR1200_OR32_FLOAT:
                // Check it's not a double precision instruction
                except_illegal <=  id_insn[`OR1200_FPUOP_DOUBLE_BIT];
`endif	      

	`OR1200_OR32_ALU:
		except_illegal <=  1'b0 

`ifdef OR1200_MULT_IMPLEMENTED
`ifdef OR1200_DIV_IMPLEMENTED
`else 
		| (id_insn[3:0] == `OR1200_ALUOP_DIV)
		| (id_insn[3:0] == `OR1200_ALUOP_DIVU)
`endif
`else
		| (id_insn[3:0] == `OR1200_ALUOP_DIV)
		| (id_insn[3:0] == `OR1200_ALUOP_DIVU)
		| (id_insn[3:0] == `OR1200_ALUOP_MUL)
`endif

`ifdef OR1200_IMPL_ADDC
`else
		| (id_insn[3:0] == `OR1200_ALUOP_ADDC)
`endif

`ifdef OR1200_IMPL_ALU_FFL1
`else
		| (id_insn[3:0] == `OR1200_ALUOP_FFL1)
`endif

`ifdef OR1200_IMPL_ALU_ROTATE
`else
		| ((id_insn[3:0] == `OR1200_ALUOP_SHROT) &
		   (id_insn[7:6] == `OR1200_SHROTOP_ROR))
`endif

`ifdef OR1200_IMPL_SUB
`else
		| (id_insn[3:0] == `OR1200_ALUOP_SUB)
`endif
		;

		// Illegal and OR1200 unsupported instructions
	default:
		except_illegal <=  1'b1;

	endcase
	end // if (!ex_freeze)
end
   

//
// Decode of alu_op
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		alu_op <=  `OR1200_ALUOP_NOP;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		alu_op <=  `OR1200_ALUOP_NOP;
	else if (!ex_freeze) begin
	  case (id_insn[31:26])		// synopsys parallel_case
	    
	    // l.movhi
	    `OR1200_OR32_MOVHI:
	      alu_op <=  `OR1200_ALUOP_MOVHI;
	    
	    // l.addi
	    `OR1200_OR32_ADDI:
	      alu_op <=  `OR1200_ALUOP_ADD;
	    
	    // l.addic
	    `OR1200_OR32_ADDIC:
	      alu_op <=  `OR1200_ALUOP_ADDC;
	    
	    // l.andi
	    `OR1200_OR32_ANDI:
	      alu_op <=  `OR1200_ALUOP_AND;
	    
	    // l.ori
	    `OR1200_OR32_ORI:
	      alu_op <=  `OR1200_ALUOP_OR;
	    
	    // l.xori
	    `OR1200_OR32_XORI:
	      alu_op <=  `OR1200_ALUOP_XOR;
	    
	    // l.muli
`ifdef OR1200_MULT_IMPLEMENTED
	    `OR1200_OR32_MULI:
	      alu_op <=  `OR1200_ALUOP_MUL;
`endif
	    
	    // Shift and rotate insns with immediate
	    `OR1200_OR32_SH_ROTI:
	      alu_op <=  `OR1200_ALUOP_SHROT;
	    
	    // SFXX insns with immediate
	    `OR1200_OR32_SFXXI:
	      alu_op <=  `OR1200_ALUOP_COMP;
	    
	    // ALU instructions except the one with immediate
	    `OR1200_OR32_ALU:
	      alu_op <=  id_insn[3:0];
	    
	    // SFXX instructions
	    `OR1200_OR32_SFXX:
	      alu_op <=  `OR1200_ALUOP_COMP;

`ifdef OR1200_OR32_CUST5
	    // l.cust5 instructions
	    `OR1200_OR32_CUST5:
	      alu_op <=  `OR1200_ALUOP_CUST5;
`endif
	    
	    // Default
	    default: begin
	      alu_op <=  `OR1200_ALUOP_NOP;
	    end
	      
	  endcase
	  
	end
end


//
// Decode of alu_op2 (field of bits 9:8)
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		alu_op2 <=  0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
	        alu_op2 <= 0;
   	else if (!ex_freeze) begin
		alu_op2 <=  id_insn[`OR1200_ALUOP2_POS];
	end
end


//
// Decode of spr_read, spr_write
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE) begin
		spr_read <=  1'b0;
		spr_write <=  1'b0;
	end
	else if (!ex_freeze & id_freeze | ex_flushpipe) begin
		spr_read <=  1'b0;
		spr_write <=  1'b0;
	end
	else if (!ex_freeze) begin
		case (id_insn[31:26])     // synopsys parallel_case

		// l.mfspr
		`OR1200_OR32_MFSPR: begin
			spr_read <=  1'b1;
			spr_write <=  1'b0;
		end

		// l.mtspr
		`OR1200_OR32_MTSPR: begin
			spr_read <=  1'b0;
			spr_write <=  1'b1;
		end

		// Default
		default: begin
			spr_read <=  1'b0;
			spr_write <=  1'b0;
		end

		endcase
	end
end

//
// Decode of mac_op
//
`ifdef OR1200_MAC_IMPLEMENTED
always @(id_insn) begin
	case (id_insn[31:26])		// synopsys parallel_case

	// l.maci
	`OR1200_OR32_MACI:
		id_mac_op =  `OR1200_MACOP_MAC;

	// l.mac, l.msb
	`OR1200_OR32_MACMSB:
		id_mac_op =  id_insn[2:0];

	// Illegal and OR1200 unsupported instructions
	default:
		id_mac_op =  `OR1200_MACOP_NOP;

	endcase
end

always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		ex_mac_op <=  `OR1200_MACOP_NOP;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		ex_mac_op <=  `OR1200_MACOP_NOP;
	else if (!ex_freeze)
		ex_mac_op <=  id_mac_op;
end

assign mac_op = abort_mvspr ? `OR1200_MACOP_NOP : ex_mac_op;
`else
assign id_mac_op = `OR1200_MACOP_NOP;
assign mac_op = `OR1200_MACOP_NOP;
`endif

//
// Decode of shrot_op
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		shrot_op <=  `OR1200_SHROTOP_NOP;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		shrot_op <=  `OR1200_SHROTOP_NOP;
	else if (!ex_freeze) begin
		shrot_op <=  id_insn[`OR1200_SHROTOP_POS];
	end
end

//
// Decode of rfwb_op
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		rfwb_op <=  `OR1200_RFWBOP_NOP;
	else  if (!ex_freeze & id_freeze | ex_flushpipe)
		rfwb_op <=  `OR1200_RFWBOP_NOP;
	else  if (!ex_freeze) begin
		case (id_insn[31:26])		// synopsys parallel_case

		// j.jal
		`OR1200_OR32_JAL:
			rfwb_op <=  {`OR1200_RFWBOP_LR, 1'b1};
		  
		// j.jalr
		`OR1200_OR32_JALR:
			rfwb_op <=  {`OR1200_RFWBOP_LR, 1'b1};
		  
		// l.movhi
		`OR1200_OR32_MOVHI:
			rfwb_op <=  {`OR1200_RFWBOP_ALU, 1'b1};
		  
		// l.mfspr
		`OR1200_OR32_MFSPR:
			rfwb_op <=  {`OR1200_RFWBOP_SPRS, 1'b1};
		  
		// l.lwz
		`OR1200_OR32_LWZ:
			rfwb_op <=  {`OR1200_RFWBOP_LSU, 1'b1};
		  
		// l.lbz
		`OR1200_OR32_LBZ:
			rfwb_op <=  {`OR1200_RFWBOP_LSU, 1'b1};
		  
		// l.lbs
		`OR1200_OR32_LBS:
			rfwb_op <=  {`OR1200_RFWBOP_LSU, 1'b1};
		  
		// l.lhz
		`OR1200_OR32_LHZ:
			rfwb_op <=  {`OR1200_RFWBOP_LSU, 1'b1};
		  
		// l.lhs
		`OR1200_OR32_LHS:
			rfwb_op <=  {`OR1200_RFWBOP_LSU, 1'b1};
		  
		// l.addi
		`OR1200_OR32_ADDI:
			rfwb_op <=  {`OR1200_RFWBOP_ALU, 1'b1};
		  
		// l.addic
		`OR1200_OR32_ADDIC:
			rfwb_op <=  {`OR1200_RFWBOP_ALU, 1'b1};
		  
		// l.andi
		`OR1200_OR32_ANDI:
			rfwb_op <=  {`OR1200_RFWBOP_ALU, 1'b1};
		  
		// l.ori
		`OR1200_OR32_ORI:
			rfwb_op <=  {`OR1200_RFWBOP_ALU, 1'b1};
		  
		// l.xori
		`OR1200_OR32_XORI:
			rfwb_op <=  {`OR1200_RFWBOP_ALU, 1'b1};
		  
		// l.muli
`ifdef OR1200_MULT_IMPLEMENTED
		`OR1200_OR32_MULI:
			rfwb_op <=  {`OR1200_RFWBOP_ALU, 1'b1};
`endif
		  
		// Shift and rotate insns with immediate
		`OR1200_OR32_SH_ROTI:
			rfwb_op <=  {`OR1200_RFWBOP_ALU, 1'b1};
		  
		// ALU instructions except the one with immediate
		`OR1200_OR32_ALU:
			rfwb_op <=  {`OR1200_RFWBOP_ALU, 1'b1};

`ifdef OR1200_OR32_CUST5
		// l.cust5 instructions
		`OR1200_OR32_CUST5:
			rfwb_op <=  {`OR1200_RFWBOP_ALU, 1'b1};
`endif
`ifdef OR1200_FPU_IMPLEMENTED
		  // FPU instructions, lf.XXX.s, except sfxx
		  `OR1200_OR32_FLOAT:
		    rfwb_op <=  {`OR1200_RFWBOP_FPU,!id_insn[3]};
`endif
		// Instructions w/o register-file write-back
		default: 
			rfwb_op <=  `OR1200_RFWBOP_NOP;


		endcase
	end
end

//
// Decode of id_branch_op
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		id_branch_op <=  `OR1200_BRANCHOP_NOP;
	else if (id_flushpipe)
		id_branch_op <=  `OR1200_BRANCHOP_NOP;
	else if (!id_freeze) begin
		case (if_insn[31:26])		// synopsys parallel_case

		// l.j
		`OR1200_OR32_J:
			id_branch_op <=  `OR1200_BRANCHOP_J;
		  
		// j.jal
		`OR1200_OR32_JAL:
			id_branch_op <=  `OR1200_BRANCHOP_J;
		  
		// j.jalr
		`OR1200_OR32_JALR:
			id_branch_op <=  `OR1200_BRANCHOP_JR;
		  
		// l.jr
		`OR1200_OR32_JR:
			id_branch_op <=  `OR1200_BRANCHOP_JR;
		  
		// l.bnf
		`OR1200_OR32_BNF:
			id_branch_op <=  `OR1200_BRANCHOP_BNF;
		  
		// l.bf
		`OR1200_OR32_BF:
			id_branch_op <=  `OR1200_BRANCHOP_BF;
		  
		// l.rfe
		`OR1200_OR32_RFE:
			id_branch_op <=  `OR1200_BRANCHOP_RFE;
		  
		// Non branch instructions
		default:
			id_branch_op <=  `OR1200_BRANCHOP_NOP;

		endcase
	end
end

//
// Generation of ex_branch_op
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		ex_branch_op <=  `OR1200_BRANCHOP_NOP;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		ex_branch_op <=  `OR1200_BRANCHOP_NOP;		
	else if (!ex_freeze)
		ex_branch_op <=  id_branch_op;

//
// Decode of id_lsu_op
//
always @(id_insn) begin
	case (id_insn[31:26])		// synopsys parallel_case

	// l.lwz
	`OR1200_OR32_LWZ:
		id_lsu_op =  `OR1200_LSUOP_LWZ;

	// l.lbz
	`OR1200_OR32_LBZ:
		id_lsu_op =  `OR1200_LSUOP_LBZ;

	// l.lbs
	`OR1200_OR32_LBS:
		id_lsu_op =  `OR1200_LSUOP_LBS;

	// l.lhz
	`OR1200_OR32_LHZ:
		id_lsu_op =  `OR1200_LSUOP_LHZ;

	// l.lhs
	`OR1200_OR32_LHS:
		id_lsu_op =  `OR1200_LSUOP_LHS;

	// l.sw
	`OR1200_OR32_SW:
		id_lsu_op =  `OR1200_LSUOP_SW;

	// l.sb
	`OR1200_OR32_SB:
		id_lsu_op =  `OR1200_LSUOP_SB;

	// l.sh
	`OR1200_OR32_SH:
		id_lsu_op =  `OR1200_LSUOP_SH;

	// Non load/store instructions
	default:
		id_lsu_op =  `OR1200_LSUOP_NOP;

	endcase
end

//
// Decode of comp_op
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE) begin
		comp_op <=  4'd0;
	end else if (!ex_freeze & id_freeze | ex_flushpipe)
		comp_op <=  4'd0;
	else if (!ex_freeze)
		comp_op <=  id_insn[24:21];
end

`ifdef OR1200_FPU_IMPLEMENTED
//
// Decode of FPU ops
//
   assign fpu_op = {(id_insn[31:26] == `OR1200_OR32_FLOAT), 
		    id_insn[`OR1200_FPUOP_WIDTH-2:0]};
`else
   assign fpu_op = {`OR1200_FPUOP_WIDTH{1'b0}};
`endif

   
//
// Decode of l.sys
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		sig_syscall <=  1'b0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		sig_syscall <=  1'b0;
	else if (!ex_freeze) begin
`ifdef OR1200_VERBOSE
// synopsys translate_off
		if (id_insn[31:23] == {`OR1200_OR32_XSYNC, 3'b000})
			$display("Generating sig_syscall");
// synopsys translate_on
`endif
		sig_syscall <=  (id_insn[31:23] == {`OR1200_OR32_XSYNC, 3'b000});
	end
end

//
// Decode of l.trap
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE)
		sig_trap <=  1'b0;
	else if (!ex_freeze & id_freeze | ex_flushpipe)
		sig_trap <=  1'b0;
	else if (!ex_freeze) begin
`ifdef OR1200_VERBOSE
// synopsys translate_off
		if (id_insn[31:23] == {`OR1200_OR32_XSYNC, 3'b010})
			$display("Generating sig_trap");
// synopsys translate_on
`endif
		sig_trap <=  (id_insn[31:23] == {`OR1200_OR32_XSYNC, 3'b010})
			| du_hwbkpt;
	end
end

// Decode destination register address for data cache to check if store ops
// are being done from the stack register (r1) or frame pointer register (r2)
`ifdef OR1200_DC_NOSTACKWRITETHROUGH   
always @(posedge clk ) begin
   if (rst == `OR1200_RST_VALUE)
     dc_no_writethrough <= 0;
   else if (!ex_freeze)
     dc_no_writethrough <= (id_insn[20:16] == 5'd1) | (id_insn[20:16] == 5'd2);
end
`else
   
   assign dc_no_writethrough = 0;
  
`endif      
   
endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's DC FSM                                             ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Data cache state machine                                    ////
////                                                              ////
////  To Do:                                                      ////
////   - Test error during line read or write                     ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////      - Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000, 2010 Authors and OPENCORES.ORG           ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_dc_fsm.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed. 
//

// synopsys translate_off
// synopsys translate_on

`define OR1200_DCFSM_IDLE	3'd0
`define OR1200_DCFSM_CLOADSTORE	3'd1
`define OR1200_DCFSM_LOOP2	3'd2
`define OR1200_DCFSM_LOOP3	3'd3
`define OR1200_DCFSM_LOOP4	3'd4
`define OR1200_DCFSM_FLUSH5	3'd5
`define OR1200_DCFSM_INV6	3'd6
`define OR1200_DCFSM_WAITSPRCS7	3'd7



//
// Data cache FSM for cache line of 16 bytes (4x singleword)
//

module or1200_dc_fsm
  (
   // Clock and reset
   clk, rst,
   
   // Internal i/f to top level DC
   dc_en, dcqmem_cycstb_i, dcqmem_ci_i, dcqmem_we_i, dcqmem_sel_i,
   tagcomp_miss, biudata_valid, biudata_error, lsu_addr,
   dcram_we, biu_read, biu_write, biu_do_sel, dcram_di_sel, first_hit_ack, 
   first_miss_ack, first_miss_err, burst, tag_we, tag_valid, dc_addr, 
   dc_no_writethrough, tag_dirty, dirty, tag, tag_v, dc_block_flush, 
   dc_block_writeback, spr_dat_i, mtspr_dc_done, spr_cswe
   );

   //
   // I/O
   //
   input				clk;
   input				rst;
   input				dc_en;
   input				dcqmem_cycstb_i;
   input				dcqmem_ci_i;
   input				dcqmem_we_i;
   input [3:0] 				dcqmem_sel_i;
   input				tagcomp_miss;
   input				biudata_valid;
   input				biudata_error;
   input [31:0] 			lsu_addr;
   output [3:0] 			dcram_we;
   output				biu_read;
   output				biu_write;
   output 				dcram_di_sel;
   output 				biu_do_sel;
   output				first_hit_ack;
   output				first_miss_ack;
   output				first_miss_err;
   output				burst;
   output				tag_we;
   output 				tag_valid;
   output [31:0] 			dc_addr;
   input 				dc_no_writethrough;
   output 				tag_dirty;
   input 				dirty;
   input [`OR1200_DCTAG_W-2:0] 		tag;
   input 				tag_v;   
   input 				dc_block_flush;
   input 				dc_block_writeback;
   input [31:0] 			spr_dat_i;
   output 				mtspr_dc_done;
   input 				spr_cswe;
   
   
   //
   // Internal wires and regs
   //
   reg [31:0] 				addr_r;
   reg [2:0] 				state;
   reg [2:0] 				cnt;
   reg 					hitmiss_eval;
   reg 					store;
   reg 					load;
   reg 					cache_inhibit;
   reg 					cache_miss;
   reg 					cache_dirty_needs_writeback;
   reg                                  did_early_load_ack;
   reg 					cache_spr_block_flush;
   reg 					cache_spr_block_writeback;
   reg 					cache_wb;   
   wire 				load_hit_ack;
   wire 				load_miss_ack;
   wire 				load_inhibit_ack;   
   wire 				store_hit_ack;
   wire 				store_hit_writethrough_ack;   
   wire 				store_miss_writethrough_ack;   
   wire 				store_inhibit_ack;
   wire 				store_miss_ack;
   wire 				dcram_we_after_line_load;
   wire 				dcram_we_during_line_load;
   wire 				tagram_we_end_of_loadstore_loop;
   wire 				tagram_dirty_bit_set;   
   wire 				writethrough;
   wire 				cache_inhibit_with_eval;
   wire [1:0] 				next_addr_word;

   //
   // Cache inhibit
   //
   
   // Indicates whether cache is inhibited, during hitmiss_eval and after
   assign cache_inhibit_with_eval = (hitmiss_eval & dcqmem_ci_i) |
				    (!hitmiss_eval & cache_inhibit);
   
   //
   // Generate of DCRAM write enables
   //

   // WE when non-writethrough, and had to wait for a line to load.
   assign dcram_we_after_line_load = (state == `OR1200_DCFSM_LOOP3) &
				    dcqmem_we_i & !cache_dirty_needs_writeback &
				     !did_early_load_ack;

   // WE when receiving the data cache line
   assign dcram_we_during_line_load = (state == `OR1200_DCFSM_LOOP2) & load & 
				      biudata_valid;   
   
   assign dcram_we =(// Write when hit - make sure it is only when hit - could
		     // maybe be doing write through and don't want to corrupt
		     // cache lines corresponding to the writethrough addr_r.
		     ({4{store_hit_ack | store_hit_writethrough_ack}} |
		     // Write after load of line
		     {4{dcram_we_after_line_load}}) & 
		     dcqmem_sel_i		 ) |
		    // Write during load
		    {4{dcram_we_during_line_load}};

   //
   // Tag RAM signals
   //
   
   // WE to tag RAM when we finish loading a line.
   assign tagram_we_end_of_loadstore_loop = ((state==`OR1200_DCFSM_LOOP2) & 
					     biudata_valid & !(|cnt));
   
`ifndef OR1200_DC_WRITETHROUGH
   // No writethrough, so mark a line dirty whenever we write to it
   assign tagram_dirty_bit_set = store_hit_ack | store_miss_ack;

   // Generate done signal for MTSPR instructions that may block execution
   assign mtspr_dc_done = // Either DC disabled or we're not selected, or
			  !dc_en | !spr_cswe |
			  // Requested address not valid or writeback and !dirty
			  ((state==`OR1200_DCFSM_FLUSH5) & 
			   (!tag_v | (cache_spr_block_writeback & !dirty))) |
			  // Writeback or flush is finished
			  ((state==`OR1200_DCFSM_LOOP3) & 
			   (cache_spr_block_flush | cache_spr_block_writeback))|
			  // Invalidate of clean line finished
			  ((state==`OR1200_DCFSM_INV6) & cache_spr_block_flush);
   
   
`else
 `ifdef OR1200_DC_NOSTACKWRITETHROUGH   
   // For dirty bit setting when having writethrough but not for stack
   assign tagram_dirty_bit_set = store_hit_ack | store_miss_ack;
 `else
   // Lines will never be dirty if always writethrough
   assign tagram_dirty_bit_set = 0;
 `endif
   
   assign mtspr_dc_done = 1'b1;
   
`endif

   assign tag_dirty = tagram_dirty_bit_set;
   
   // WE to tag RAM
   assign tag_we = tagram_we_end_of_loadstore_loop |		    
                    tagram_dirty_bit_set | (state == `OR1200_DCFSM_INV6);
   

   // Valid bit
   // Set valid when end of line load, or marking dirty (is still valid)
   assign tag_valid = ( tagram_we_end_of_loadstore_loop & 
			(load | (store & cache_spr_block_writeback)) ) |
		      tagram_dirty_bit_set;


   
   //
   // BIU read and write
   //

   assign biu_read = // Bus read request when:
		     // 1) Have a miss and not dirty or a load with inhibit
		     ((state == `OR1200_DCFSM_CLOADSTORE) &
		      (((hitmiss_eval & tagcomp_miss & !dirty & 
			 !(store & writethrough)) | 
			(load & cache_inhibit_with_eval)) & dcqmem_cycstb_i)) |
		     // 2) In the loop and loading
		     ((state == `OR1200_DCFSM_LOOP2) & load);
   

   assign biu_write = // Bus write request when:
		      // 1) Have a miss and dirty or store with inhibit
		      ((state == `OR1200_DCFSM_CLOADSTORE) & 
		       (((hitmiss_eval & tagcomp_miss & dirty) | 
			 (store & writethrough)) | 
			(store & cache_inhibit_with_eval)) & dcqmem_cycstb_i) |
		      // 2) In the loop and storing
		      ((state == `OR1200_DCFSM_LOOP2) & store);
   
   //
   // Select for data to actual cache RAM (from LSU or BIU)
   //
   // Data to DCRAM - from external bus when loading (from IU when store)
   assign dcram_di_sel = load;
   // Data to external bus - always from IU except in case of bursting back
   //                        the line to memory. (1 selects DCRAM)
   assign biu_do_sel = (state == `OR1200_DCFSM_LOOP2) & store;

   // 2-bit wire for calculating next word of burst write
   assign next_addr_word = addr_r[3:2] + 1;
   
   // Address to cache RAM (tag address also derived from this)   
   assign dc_addr =
		   // First check if we've got a block flush or WB op
		   ((dc_block_flush & !cache_spr_block_flush) | 
		   (dc_block_writeback & !cache_spr_block_writeback)) ? 
		   spr_dat_i :
		   (state==`OR1200_DCFSM_FLUSH5) ? addr_r:
		    // If no SPR action, then always put out address from LSU
		    (state==`OR1200_DCFSM_IDLE | hitmiss_eval) ? lsu_addr :
		    // Next, if in writeback loop, when ACKed must immediately
		    // output next word address (the RAM address takes a cycle
		    // to increment, but it's needed immediately for burst)
		    // otherwise, output our registered address.
		    (state==`OR1200_DCFSM_LOOP2 & biudata_valid & store ) ? 
		    {addr_r[31:4], next_addr_word, 2'b00} : addr_r;
   
`ifdef OR1200_DC_WRITETHROUGH
 `ifdef OR1200_DC_NOSTACKWRITETHROUGH   
   assign writethrough = !dc_no_writethrough;
 `else
   assign writethrough = 1;
 `endif
`else
   assign writethrough = 0;
`endif
   
   //
   // ACK generation for LSU
   //
   
   // ACK for when it's a cache hit
   assign first_hit_ack = load_hit_ack | store_hit_ack | 
			  store_hit_writethrough_ack | 
			  store_miss_writethrough_ack |
			  store_inhibit_ack | store_miss_ack ;

   // ACK for when it's a cache miss - load only, is used in MUX for data back
   //                                  LSU straight off external data bus. In
   //                                  this was is also used for cache inhibit
   //                                  loads.
   assign first_miss_ack = load_miss_ack | load_inhibit_ack;
   
   // ACK cache hit on load
   assign load_hit_ack = (state == `OR1200_DCFSM_CLOADSTORE) & 
			 hitmiss_eval & !tagcomp_miss & !dcqmem_ci_i & load;
   
   // ACK cache hit on store, no writethrough
   assign store_hit_ack = (state == `OR1200_DCFSM_CLOADSTORE) & 
			  hitmiss_eval  & !tagcomp_miss & !dcqmem_ci_i &
			  store & !writethrough;
   
   // ACK cache hit on store with writethrough
   assign store_hit_writethrough_ack = (state == `OR1200_DCFSM_CLOADSTORE) & 
				       !cache_miss & !cache_inhibit &
				       store & writethrough & biudata_valid;
   
   // ACK cache miss on store with writethrough
   assign store_miss_writethrough_ack = (state == `OR1200_DCFSM_CLOADSTORE) & 
					cache_miss & !cache_inhibit &
					store & writethrough & biudata_valid;
      
   // ACK store when cacheinhibit
   assign store_inhibit_ack = (state == `OR1200_DCFSM_CLOADSTORE) &
			      store & cache_inhibit & biudata_valid;
   
   
   // Get the _early_ ack on first ACK back from wishbone during load only
   // Condition is that we're in the loop - that it's the first ack we get (can
   // tell from value of cnt), and we're loading a line to read from it (not
   // loading to write to it, in the case of a write without writethrough.)
   assign load_miss_ack =  ((state== `OR1200_DCFSM_LOOP2) & load &
			     (cnt==`OR1200_DCLS-1) & biudata_valid & 
			    !(dcqmem_we_i & !writethrough));

   assign load_inhibit_ack = (state == `OR1200_DCFSM_CLOADSTORE) &
			     load & cache_inhibit & biudata_valid;   
   
   // This will be case of write through disabled, and had to load a line.
   assign store_miss_ack = dcram_we_after_line_load;
            
   assign first_miss_err = biudata_error & dcqmem_cycstb_i;

   // Signal burst when in the load/store loop. We will always try to burst.
   assign burst = (state == `OR1200_DCFSM_LOOP2);

   //
   // Main DC FSM
   //
   always @(posedge clk ) begin
      if (rst == `OR1200_RST_VALUE) begin
	 state <=  `OR1200_DCFSM_IDLE;
	 addr_r <=  32'b0;
	 hitmiss_eval <=  1'b0;
	 store <=  1'b0;
	 load <=  1'b0;
	 cnt <=  3'd0;
         cache_miss <=  1'b0;
	 cache_dirty_needs_writeback <= 1'b0;
	 cache_inhibit <=  1'b0;
	 did_early_load_ack <= 1'b0;
	 cache_spr_block_flush <= 1'b0;
	 cache_spr_block_writeback <= 1'b0;
      end
      else
	case (state)	// synopsys parallel_case
	  
          `OR1200_DCFSM_IDLE : begin
	     if (dc_en & (dc_block_flush | dc_block_writeback))
	       begin
		  cache_spr_block_flush <= dc_block_flush;
		  cache_spr_block_writeback <= dc_block_writeback;
		  hitmiss_eval <= 1'b1;
		  state <= `OR1200_DCFSM_FLUSH5;
		  addr_r <=  spr_dat_i;
	       end
	     else if (dc_en & dcqmem_cycstb_i)
	       begin
		  state <= `OR1200_DCFSM_CLOADSTORE;
		  hitmiss_eval <=  1'b1;
		  store <=  dcqmem_we_i;
		  load <=  !dcqmem_we_i;
	       end
	     
	     
          end // case: `OR1200_DCFSM_IDLE
	  
          `OR1200_DCFSM_CLOADSTORE: begin
	     hitmiss_eval <=  1'b0;
	     if (hitmiss_eval) begin
                cache_inhibit <=  dcqmem_ci_i; // Check for cache inhibit here
                cache_miss <=  tagcomp_miss;
		cache_dirty_needs_writeback <= dirty;
		addr_r <=  lsu_addr;
             end

	     // Evaluate any cache line load/stores in first cycle:
			     //
	     if (hitmiss_eval & tagcomp_miss & !(store & writethrough) &
		 !dcqmem_ci_i)
	       begin
		  // Miss - first either:
		  //  1) write back dirty line 
		  if (dirty) begin
		     // Address for writeback
		     addr_r <=  {tag, lsu_addr[`OR1200_DCINDXH:2],2'd0};
		     load <= 1'b0;
		     store <= 1'b1;
`ifdef OR1200_VERBOSE		     
		     $display("%t: dcache miss and dirty", $time);
`endif
		  end
		  //  2) load requested line
		  else begin
		     addr_r <=  lsu_addr;
		     load <= 1'b1;
		     store <= 1'b0;
		  end // else: !if(dirty)
		  state <= `OR1200_DCFSM_LOOP2;		  
		  // Set the counter for the burst accesses
		  cnt <=  `OR1200_DCLS-1;
	       end
             else if (// Strobe goes low
		      !dcqmem_cycstb_i |
		      // Cycle finishes
		      (!hitmiss_eval & (biudata_valid | biudata_error)) |
		      // Cache hit in first cycle....
		      (hitmiss_eval & !tagcomp_miss & !dcqmem_ci_i &
		      // .. and you're not doing a writethrough store..
		      !(store & writethrough))) begin
                state <=  `OR1200_DCFSM_IDLE;
                load <=  1'b0;
		store <= 1'b0;
		cache_inhibit <= 1'b0;
		cache_dirty_needs_writeback <= 1'b0;
             end	     
          end // case: `OR1200_DCFSM_CLOADSTORE	  
	  
          `OR1200_DCFSM_LOOP2 : begin // loop/abort	     
             if (!dc_en| biudata_error) begin
                state <=  `OR1200_DCFSM_IDLE;
                load <=  1'b0;
		store <= 1'b0;
		cnt <= 3'd0;
             end
             if (biudata_valid & (|cnt)) begin
                cnt <=  cnt - 3'd1;
                addr_r[3:2] <=  addr_r[3:2] + 1'b1;
             end
	     else if (biudata_valid & !(|cnt)) begin
		state <= `OR1200_DCFSM_LOOP3;
		addr_r <=  lsu_addr;
		load <= 1'b0;
		store <= 1'b0;
	     end

	     // Track if we did an early ack during a load
	     if (load_miss_ack)
	       did_early_load_ack <= 1'b1;
	     

          end // case: `OR1200_DCFSM_LOOP2
	  
	  `OR1200_DCFSM_LOOP3: begin // figure out next step
	     if (cache_dirty_needs_writeback) begin
		// Just did store of the dirty line so now load new one
		load <= 1'b1;
		// Set the counter for the burst accesses
		cnt <=  `OR1200_DCLS-1;
		// Address of line to be loaded
		addr_r <=  lsu_addr;
		cache_dirty_needs_writeback <= 1'b0;
		state <= `OR1200_DCFSM_LOOP2;
	     end // if (cache_dirty_needs_writeback)
	     else if (cache_spr_block_flush | cache_spr_block_writeback) begin
		// Just wrote back the line to memory, we're finished.
		cache_spr_block_flush <= 1'b0;
		cache_spr_block_writeback <= 1'b0;
		state <= `OR1200_DCFSM_WAITSPRCS7;
	     end
	     else begin
		// Just loaded a new line, finish up
		did_early_load_ack <= 1'b0;
		state <= `OR1200_DCFSM_LOOP4;
	     end
	  end // case: `OR1200_DCFSM_LOOP3

	  `OR1200_DCFSM_LOOP4: begin
	     state <=  `OR1200_DCFSM_IDLE;
	  end

	  `OR1200_DCFSM_FLUSH5: begin
	     hitmiss_eval <= 1'b0;
	     if (hitmiss_eval & !tag_v)
	       begin
		  // Not even cached, just ignore
		  cache_spr_block_flush <= 1'b0;
		  cache_spr_block_writeback <= 1'b0;
		  state <=  `OR1200_DCFSM_WAITSPRCS7;
	       end
	     else if (hitmiss_eval & tag_v)
	       begin
		  // Tag is valid - what do we do?
		  if ((cache_spr_block_flush | cache_spr_block_writeback) & 
		      dirty) begin
		     // Need to writeback
		     // Address for writeback (spr_dat_i has already changed so
		     // use line number from addr_r)
		     addr_r <=  {tag, addr_r[`OR1200_DCINDXH:2],2'd0};
		     load <= 1'b0;
		     store <= 1'b1;
`ifdef OR1200_VERBOSE		     
		     $display("%t: block flush: dirty block", $time);
`endif
		     state <= `OR1200_DCFSM_LOOP2;		  
		     // Set the counter for the burst accesses
		     cnt <=  `OR1200_DCLS-1;
		  end
		  else if (cache_spr_block_flush & !dirty)
		    begin
		       // Line not dirty, just need to invalidate
		       state <=  `OR1200_DCFSM_INV6;
		    end // else: !if(dirty)
		  else if (cache_spr_block_writeback & !dirty)
		    begin
		       // Nothing to do - line is valid but not dirty
		       cache_spr_block_writeback <= 1'b0;
		       state <=  `OR1200_DCFSM_WAITSPRCS7;
		    end
	  end // if (hitmiss_eval & tag_v)
	  end
	  `OR1200_DCFSM_INV6: begin
	     cache_spr_block_flush <= 1'b0;
	     // Wait until SPR CS goes low before going back to idle
	     if (!spr_cswe)
	       state <=  `OR1200_DCFSM_IDLE;
	  end
	  `OR1200_DCFSM_WAITSPRCS7: begin
	     // Wait until SPR CS goes low before going back to idle
	     if (!spr_cswe)
	       state <=  `OR1200_DCFSM_IDLE;
	  end

	endcase // case (state)
      
   end // always @ (posedge clk )
   

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's DC RAMs                                            ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Instatiation of DC RAM blocks.                              ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//
// $Log: or1200_dc_ram.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//

// synopsys translate_off
// synopsys translate_on

module or1200_dc_ram(
	// Reset and clock
	clk, rst,

`ifdef OR1200_BIST
	// RAM BIST
	mbist_si_i, mbist_so_o, mbist_ctrl_i,
`endif

	// Internal i/f
	addr, en, we, datain, dataout
);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_DCINDX;

//
// I/O
//
input				clk;
input				rst;
input	[aw-1:0]		addr;
input				en;
input	[3:0]			we;
input	[dw-1:0]		datain;
output	[dw-1:0]		dataout;

//
// Internal wires and regs
//
`ifdef OR1200_GF_ARM_28SLP 
wire				gwen;
wire				cen;
wire [3:0]			wen;
`endif

`ifdef OR1200_BIST
//
// RAM BIST
//
input				mbist_si_i;
input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;       // bist chain shift control
output				mbist_so_o;
`endif

`ifdef OR1200_NO_DC

//
// Data cache not implemented
//
assign dataout = {dw{1'b0}};
`ifdef OR1200_BIST
assign mbist_so_o = mbist_si_i;
`endif

`else

//
// Instantiation of RAM block
//
`ifdef OR1200_DC_1W_4KB
   or1200_spram_32_bw #
     (
      .aw(10),
      .dw(32)
      )
`endif
`ifdef OR1200_DC_1W_8KB
`ifdef OR1200_GF_ARM_28SLP
   assign gwen = !(|we);
   assign cen = ~en;
   assign wen = ~we;
   
   sp_hsc_2048x32bw dc_ram
     (
      .Q(dataout),
      .CLK(clk),
      .CEN(cen),
      .WEN(wen),
      .A(addr),
      .D(datain),
      .EMA(3'b000),
      .EMAW(2'b00),
      .EMAS(1'b0),
      .GWEN(gwen),
      .RET1N(1'b1)
      );
`else   
   or1200_spram_32_bw #
     (
      .aw(11),
      .dw(32)
      )
`endif // !`ifdef OR1200_GF_ARM_28SLP
`endif //  `ifdef OR1200_DC_1W_8KB

`ifndef OR1200_GF_ARM_28SLP      
   dc_ram
     (
`ifdef OR1200_BIST
      // RAM BIST
      .mbist_si_i(mbist_si_i),
      .mbist_so_o(mbist_so_o),
      .mbist_ctrl_i(mbist_ctrl_i),
`endif
      .clk(clk),
      .ce(en),
      .we(we),
      .addr(addr),
      .di(datain),
      .doq(dataout)
      );
`endif //  `ifndef OR1200_GF_ARM_28SLP
`endif // !`ifdef OR1200_NO_DC

endmodule // or1200_dc_ram


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's DC TAG RAMs                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Instatiation of data cache tag rams.                        ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_dc_tag.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//

// synopsys translate_off
// synopsys translate_on

module or1200_dc_tag(
	// Clock and reset
	clk, rst,

`ifdef OR1200_BIST
	// RAM BIST
	mbist_si_i, mbist_so_o, mbist_ctrl_i,
`endif

	// Internal i/f
	addr, en, we, datain, tag_v, tag, dirty
);

parameter dw = `OR1200_DCTAG_W+1;
parameter aw = `OR1200_DCTAG;

//
// I/O
//
input				clk;
input				rst;
input	[aw-1:0]		addr;
input				en;
input				we;
input	[dw-1:0]		datain;
output				tag_v;
output	[dw-3:0]		tag;
output  			dirty;

//
// Internal wires and regs
//
`ifdef OR1200_GF_ARM_28SLP 
wire				cen;
wire				wen;
`endif   

`ifdef OR1200_BIST
//
// RAM BIST
//
input mbist_si_i;
input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;
output mbist_so_o;
`endif

`ifdef OR1200_NO_DC

//
// Data cache not implemented
//
assign tag = {dw-1{1'b0}};
assign tag_v = 1'b0;
`ifdef OR1200_BIST
assign mbist_so_o = mbist_si_i;
`endif

`else

//
// Instantiation of TAG RAM block
//
`ifdef OR1200_DC_1W_4KB
   or1200_spram #
     (
      .aw(8),
      .dw(21 + 1)
      )
`endif
`ifdef OR1200_DC_1W_8KB
`ifdef OR1200_GF_ARM_28SLP
   assign cen = ~en;
   assign wen = ~we;
   
    sp_hsc_512x21 dc_tag0
     (
      .Q({tag, tag_v, dirty}),
      .CLK(clk),
      .CEN(cen),
      .WEN(wen),
      .A(addr),
      .D(datain),
      .EMA(3'b000),
      .EMAW(2'b00),
      .EMAS(1'b0),      
      .RET1N(1'b1)
      );
`else   
   or1200_spram #
     (
      .aw(9),
      .dw(20 + 1)
      )
`endif // !`ifdef OR1200_GF_ARM_28SLP
`endif //  `ifdef OR1200_DC_1W_8KB

`ifndef OR1200_GF_ARM_28SLP      
   dc_tag0
     (
`ifdef OR1200_BIST
      // RAM BIST
      .mbist_si_i(mbist_si_i),
      .mbist_so_o(mbist_so_o),
      .mbist_ctrl_i(mbist_ctrl_i),
`endif
      .clk(clk),
      .ce(en),
      .we(we),
      .addr(addr),
      .di(datain),
      .doq({tag, tag_v, dirty})
      );
`endif //  `ifndef OR1200_GF_ARM_28SLP
`endif // !`ifdef OR1200_NO_DC

endmodule // or1200_dc_tag


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Data Cache top level                               ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Instantiation of all DC blocks.                             ////
////                                                              ////
////  To Do:                                                      ////
////   - Test error during line read or write                     ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////      - Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000, 2010 Authors and OPENCORES.ORG           ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//
// $Log: or1200_dc_top.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed. 
//

// synopsys translate_off
// synopsys translate_on

//
// Data cache
//
module or1200_dc_top(
	// Rst, clk and clock control
	clk, rst,

	// External i/f
	dcsb_dat_o, dcsb_adr_o, dcsb_cyc_o, dcsb_stb_o, dcsb_we_o, dcsb_sel_o, 
	dcsb_cab_o, dcsb_dat_i, dcsb_ack_i, dcsb_err_i,

	// Internal i/f
	dc_en,
	dcqmem_adr_i, dcqmem_cycstb_i, dcqmem_ci_i,
	dcqmem_we_i, dcqmem_sel_i, dcqmem_tag_i, dcqmem_dat_i,
	dcqmem_dat_o, dcqmem_ack_o, dcqmem_rty_o, dcqmem_err_o, dcqmem_tag_o,
	
        dc_no_writethrough,

`ifdef OR1200_BIST
	// RAM BIST
	mbist_si_i, mbist_so_o, mbist_ctrl_i,
`endif

	// SPRs
	spr_cs, spr_write, spr_dat_i, spr_addr, mtspr_dc_done
);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_OPERAND_WIDTH;
   
//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// External I/F
//
output	[dw-1:0]		dcsb_dat_o;
output	[31:0]			dcsb_adr_o;
output				dcsb_cyc_o;
output				dcsb_stb_o;
output				dcsb_we_o;
output	[3:0]			dcsb_sel_o;
output				dcsb_cab_o;
input	[dw-1:0]		dcsb_dat_i;
input				dcsb_ack_i;
input				dcsb_err_i;

//
// Internal I/F
//
input				dc_en;
input	[31:0]			dcqmem_adr_i;
input				dcqmem_cycstb_i;
input				dcqmem_ci_i;
input				dcqmem_we_i;
input	[3:0]			dcqmem_sel_i;
input	[3:0]			dcqmem_tag_i;
input	[dw-1:0]		dcqmem_dat_i;
output	[dw-1:0]		dcqmem_dat_o;
output				dcqmem_ack_o;
output				dcqmem_rty_o;
output				dcqmem_err_o;
output	[3:0]			dcqmem_tag_o;

input   			dc_no_writethrough;
   
`ifdef OR1200_BIST
//
// RAM BIST
//
input mbist_si_i;
input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;
output mbist_so_o;
`endif

//
// SPR access
//
input				spr_cs;
input				spr_write;
input	[31:0]			spr_dat_i;
input	[aw-1:0]	        spr_addr;
output  			mtspr_dc_done;

`ifdef OR1200_NO_DC

// Bypass cache

// IF to external memory
assign dcsb_dat_o = dcqmem_dat_i;
assign dcsb_adr_o = dcqmem_adr_i;
assign dcsb_cyc_o = dcqmem_cycstb_i;
assign dcsb_stb_o = dcqmem_cycstb_i;
assign dcsb_we_o = dcqmem_we_i;
assign dcsb_sel_o = dcqmem_sel_i;
assign dcsb_cab_o = 1'b0;

// IF to internal memory
assign dcqmem_dat_o = dcsb_dat_i;
assign dcqmem_ack_o = dcsb_ack_i;
assign dcqmem_err_o = dcsb_err_i;   
assign dcqmem_rty_o = ~dcqmem_ack_o;
assign dcqmem_tag_o = dcqmem_err_o ? `OR1200_DTAG_BE : dcqmem_tag_i;

assign mtspr_dc_done = 1'b1;

`else   
   
//
// Internal wires and regs
//
wire				tag_v;
wire	[`OR1200_DCTAG_W-2:0]	tag;
wire    			dirty;   
wire	[dw-1:0]		to_dcram;
wire	[dw-1:0]		from_dcram;
wire	[3:0]			dcram_we;
wire				dctag_we;
wire	[31:0]			dc_addr;
wire				dcfsm_biu_read;
wire				dcfsm_biu_write;
wire                            dcfsm_dcram_di_sel;
wire                            dcfsm_biu_do_sel;   
reg				tagcomp_miss;
wire	[`OR1200_DCINDXH:`OR1200_DCLS]	dctag_addr;
wire				dctag_en;
wire				dctag_v;
wire    			dctag_dirty;
   
wire				dc_block_invalidate;
wire 			        dc_block_flush;
wire 			        dc_block_writeback;   
wire				dcfsm_first_hit_ack;
wire				dcfsm_first_miss_ack;
wire				dcfsm_first_miss_err;
wire				dcfsm_burst;
wire				dcfsm_tag_we;
wire    			dcfsm_tag_valid;
wire    			dcfsm_tag_dirty;
   
`ifdef OR1200_BIST
//
// RAM BIST
//
wire				mbist_ram_so;
wire				mbist_tag_so;
wire				mbist_ram_si = mbist_si_i;
wire				mbist_tag_si = mbist_ram_so;
assign				mbist_so_o = mbist_tag_so;
`endif

// Address out to external bus - always from FSM   
assign dcsb_adr_o = dc_addr;
//
// SPR register decodes
//
`ifdef OR1200_DC_WRITETHROUGH
assign dc_block_invalidate = spr_cs & spr_write & 
       ((spr_addr[`OR1200_SPRGRP_DC_ADR_WIDTH-1:0]==`OR1200_SPRGRP_DC_DCBIR) |
	(spr_addr[`OR1200_SPRGRP_DC_ADR_WIDTH-1:0]==`OR1200_SPRGRP_DC_DCBFR));
assign dc_block_flush = 0;
assign dc_block_writeback = 0;
`else   
assign dc_block_invalidate = spr_cs & spr_write & 
	  (spr_addr[`OR1200_SPRGRP_DC_ADR_WIDTH-1:0]==`OR1200_SPRGRP_DC_DCBIR);
assign dc_block_flush =    spr_cs & spr_write &
	   (spr_addr[`OR1200_SPRGRP_DC_ADR_WIDTH-1:0]==`OR1200_SPRGRP_DC_DCBFR);
assign dc_block_writeback =    spr_cs & spr_write &
	   (spr_addr[`OR1200_SPRGRP_DC_ADR_WIDTH-1:0]==`OR1200_SPRGRP_DC_DCBWR);
`endif // !`ifdef OR1200_DC_WRITETHROUGH
   
assign dctag_we = dcfsm_tag_we | dc_block_invalidate;
assign dctag_addr = dc_block_invalidate ? 
		    spr_dat_i[`OR1200_DCINDXH:`OR1200_DCLS] :
		    dc_addr[`OR1200_DCINDXH:`OR1200_DCLS];
assign dctag_en = dc_block_invalidate | dc_en;

assign dctag_v = dc_block_invalidate ? 1'b0 : dcfsm_tag_valid;
assign dctag_dirty = dc_block_invalidate ? 1'b0 : dcfsm_tag_dirty;
   
//
// Data to BIU is from DCRAM when bursting lines back into memory
//
assign dcsb_dat_o = dcfsm_biu_do_sel ? from_dcram : dcqmem_dat_i;


//
// Bypases of the DC when DC is disabled
//
assign dcsb_cyc_o = (dc_en) ? 
		    dcfsm_biu_read | dcfsm_biu_write : dcqmem_cycstb_i;
   
assign dcsb_stb_o = (dc_en) ? 
		    dcfsm_biu_read | dcfsm_biu_write : dcqmem_cycstb_i;
   
assign dcsb_we_o = (dc_en) ? 
		   dcfsm_biu_write : dcqmem_we_i;

assign dcsb_sel_o = (dc_en & dcfsm_burst) ? 
		    4'b1111 : dcqmem_sel_i;

assign dcsb_cab_o = dc_en & dcfsm_burst & dcsb_cyc_o;
assign dcqmem_rty_o = ~dcqmem_ack_o;
assign dcqmem_tag_o = dcqmem_err_o ? `OR1200_DTAG_BE : dcqmem_tag_i;

//
// DC/LSU normal and error termination
//
assign dcqmem_ack_o = dc_en ? 
		      dcfsm_first_hit_ack | dcfsm_first_miss_ack : dcsb_ack_i;
   
assign dcqmem_err_o = dc_en ? dcfsm_first_miss_err : dcsb_err_i;
   
//
// Select between input data generated by LSU or by BIU
//
assign to_dcram = (dcfsm_dcram_di_sel) ? dcsb_dat_i : dcqmem_dat_i;

//
// Select between data generated by DCRAM or passed by BIU
//
assign dcqmem_dat_o = dcfsm_first_miss_ack | !dc_en ? dcsb_dat_i : from_dcram;
//assign dcqmem_dat_o = !dc_en ? dcsb_dat_i : from_dcram;

//
// Tag comparison
//
   wire [31:`OR1200_DCTAGL]  dcqmem_adr_i_tag;
   assign dcqmem_adr_i_tag = dcqmem_adr_i[31:`OR1200_DCTAGL];
   
always @(tag or dcqmem_adr_i_tag or tag_v) begin
	if ((tag != dcqmem_adr_i_tag) || !tag_v)
		tagcomp_miss = 1'b1;
	else
		tagcomp_miss = 1'b0;
end

//
// Instantiation of DC Finite State Machine
//
or1200_dc_fsm or1200_dc_fsm(
	.clk(clk),
	.rst(rst),
	.dc_en(dc_en),
	.dcqmem_cycstb_i(dcqmem_cycstb_i),
	.dcqmem_ci_i(dcqmem_ci_i),
	.dcqmem_we_i(dcqmem_we_i),
	.dcqmem_sel_i(dcqmem_sel_i),
	.tagcomp_miss(tagcomp_miss),
	.tag(tag),
        .tag_v(tag_v),
	.dirty(dirty),
	.biudata_valid(dcsb_ack_i),
	.biudata_error(dcsb_err_i),
	.lsu_addr(dcqmem_adr_i),
	.dcram_we(dcram_we),
	.biu_read(dcfsm_biu_read),
	.biu_write(dcfsm_biu_write),
	.dcram_di_sel(dcfsm_dcram_di_sel),
	.biu_do_sel(dcfsm_biu_do_sel),
	.first_hit_ack(dcfsm_first_hit_ack),
	.first_miss_ack(dcfsm_first_miss_ack),
	.first_miss_err(dcfsm_first_miss_err),
	.burst(dcfsm_burst),
	.tag_we(dcfsm_tag_we),
        .tag_valid(dcfsm_tag_valid),
	.tag_dirty(dcfsm_tag_dirty),
	.dc_addr(dc_addr),
	.dc_no_writethrough(dc_no_writethrough),
	.dc_block_flush(dc_block_flush),
	.dc_block_writeback(dc_block_writeback),
	.spr_dat_i(spr_dat_i),
	.mtspr_dc_done(mtspr_dc_done),
	.spr_cswe(spr_cs & spr_write)
);

//
// Instantiation of DC main memory
//
or1200_dc_ram or1200_dc_ram(
	.clk(clk),
	.rst(rst),
`ifdef OR1200_BIST
	// RAM BIST
	.mbist_si_i(mbist_ram_si),
	.mbist_so_o(mbist_ram_so),
	.mbist_ctrl_i(mbist_ctrl_i),
`endif
	.addr(dc_addr[`OR1200_DCINDXH:2]),
	.en(dc_en),
	.we(dcram_we),
	.datain(to_dcram),
	.dataout(from_dcram)
);

//
// Instantiation of DC TAG memory
//
or1200_dc_tag or1200_dc_tag(
	.clk(clk),
	.rst(rst),
`ifdef OR1200_BIST
	// RAM BIST
	.mbist_si_i(mbist_tag_si),
	.mbist_so_o(mbist_tag_so),
	.mbist_ctrl_i(mbist_ctrl_i),
`endif
	.addr(dctag_addr),
	.en(dctag_en),
	.we(dctag_we),
	.datain({dc_addr[31:`OR1200_DCTAGL], dctag_v, dctag_dirty}),
	.tag_v(tag_v),
	.tag(tag),
	.dirty(dirty)
);
`endif // !`ifdef OR1200_NO_DC
   
endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Data TLB                                           ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Instantiation of DTLB.                                      ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//
// $Log: or1200_dmmu_tlb.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed, coding style changed. 
//

// synopsys translate_off
// synopsys translate_on

//
// Data TLB
//

module or1200_dmmu_tlb(
	// Rst and clk
	clk, rst,

	// I/F for translation
	tlb_en, vaddr, hit, ppn, uwe, ure, swe, sre, ci,

`ifdef OR1200_BIST
	// RAM BIST
	mbist_si_i, mbist_so_o, mbist_ctrl_i,
`endif

	// SPR access
	spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o
);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_OPERAND_WIDTH;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// I/F for translation
//
input				tlb_en;
input	[aw-1:0]		vaddr;
output				hit;
output	[31:`OR1200_DMMU_PS]	ppn;
output				uwe;
output				ure;
output				swe;
output				sre;
output				ci;

`ifdef OR1200_BIST
//
// RAM BIST
//
input mbist_si_i;
input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;
output mbist_so_o;
`endif

//
// SPR access
//
input				spr_cs;
input				spr_write;
input	[31:0]			spr_addr;
input	[31:0]			spr_dat_i;
output	[31:0]			spr_dat_o;

//
// Internal wires and regs
//
wire	[`OR1200_DTLB_TAG]	vpn;
wire				v;
wire	[`OR1200_DTLB_INDXW-1:0]	tlb_index;
wire				tlb_mr_en;
wire				tlb_mr_we;
wire	[`OR1200_DTLBMRW-1:0]	tlb_mr_ram_in;
wire	[`OR1200_DTLBMRW-1:0]	tlb_mr_ram_out;
wire				tlb_tr_en;
wire				tlb_tr_we;
wire	[`OR1200_DTLBTRW-1:0]	tlb_tr_ram_in;
wire	[`OR1200_DTLBTRW-1:0]	tlb_tr_ram_out;
`ifdef OR1200_BIST
//
// RAM BIST
//
wire				mbist_mr_so;
wire				mbist_tr_so;
wire				mbist_mr_si = mbist_si_i;
wire				mbist_tr_si = mbist_mr_so;
assign				mbist_so_o = mbist_tr_so;
`endif
`ifdef OR1200_GF_ARM_28SLP
wire				tlb_mr_cen;
wire	 			tlb_mr_wen;   
wire				tlb_tr_cen;
wire	 			tlb_tr_wen;
`endif   

//
// Implemented bits inside match and translate registers
//
// dtlbwYmrX: vpn 31-19  v 0
// dtlbwYtrX: ppn 31-13  swe 9  sre 8  uwe 7  ure 6
//
// dtlb memory width:
// 19 bits for ppn
// 13 bits for vpn
// 1 bit for valid
// 4 bits for protection
// 1 bit for cache inhibit

//
// Enable for Match registers
//
assign tlb_mr_en = tlb_en | (spr_cs & !spr_addr[`OR1200_DTLB_TM_ADDR]);

//
// Write enable for Match registers
//
assign tlb_mr_we = spr_cs & spr_write & !spr_addr[`OR1200_DTLB_TM_ADDR];

//
// Enable for Translate registers
//
assign tlb_tr_en = tlb_en | (spr_cs & spr_addr[`OR1200_DTLB_TM_ADDR]);

//
// Write enable for Translate registers
//
assign tlb_tr_we = spr_cs & spr_write & spr_addr[`OR1200_DTLB_TM_ADDR];

//
// Output to SPRS unit
//
assign spr_dat_o = (spr_cs & !spr_write & !spr_addr[`OR1200_DTLB_TM_ADDR]) ?
			{vpn, tlb_index, {`OR1200_DTLB_TAGW-7{1'b0}}, 1'b0, 5'b00000, v} : 
		(spr_cs & !spr_write & spr_addr[`OR1200_DTLB_TM_ADDR]) ?
			{ppn, {`OR1200_DMMU_PS-10{1'b0}}, swe, sre, uwe, ure, {4{1'b0}}, ci, 1'b0} :
			32'h00000000;

//
// Assign outputs from Match registers
//
assign {vpn, v} = tlb_mr_ram_out;

//
// Assign to Match registers inputs
//
assign tlb_mr_ram_in = {spr_dat_i[`OR1200_DTLB_TAG], spr_dat_i[`OR1200_DTLBMR_V_BITS]};

//
// Assign outputs from Translate registers
//
assign {ppn, swe, sre, uwe, ure, ci} = tlb_tr_ram_out;

//
// Assign to Translate registers inputs
//
assign tlb_tr_ram_in = {spr_dat_i[31:`OR1200_DMMU_PS],
			spr_dat_i[`OR1200_DTLBTR_SWE_BITS],
			spr_dat_i[`OR1200_DTLBTR_SRE_BITS],
			spr_dat_i[`OR1200_DTLBTR_UWE_BITS],
			spr_dat_i[`OR1200_DTLBTR_URE_BITS],
			spr_dat_i[`OR1200_DTLBTR_CI_BITS]};

//
// Generate hit
//
assign hit = (vpn == vaddr[`OR1200_DTLB_TAG]) & v;

//
// TLB index is normally vaddr[18:13]. If it is SPR access then index is
// spr_addr[5:0].
//
assign tlb_index = spr_cs ? spr_addr[`OR1200_DTLB_INDXW-1:0] : vaddr[`OR1200_DTLB_INDX];

//
// Instantiation of DTLB Match Registers
//
//or1200_spram_64x14 dtlb_mr_ram(

`ifdef OR1200_GF_ARM_28SLP
   assign tlb_mr_cen = ~tlb_mr_en;
   assign tlb_mr_wen = ~tlb_mr_we;
   
   sp_hsc_128x14 dtlb_ram
     (
      .Q(tlb_mr_ram_out),
      .CLK(clk),
      .CEN(tlb_mr_cen),
      .WEN(tlb_mr_wen),
      .A({1'b0, tlb_index}),
      .D(tlb_mr_ram_in),
      .EMA(3'b000),
      .EMAW(2'b00),
      .EMAS(1'b0),      
      .RET1N(1'b1)
      );
`else
   or1200_spram #
     (
      .aw(6),
      .dw(14)
      )
   dtlb_ram
     (
      .clk(clk),
`ifdef OR1200_BIST
      // RAM BIST
      .mbist_si_i(mbist_mr_si),
      .mbist_so_o(mbist_mr_so),
      .mbist_ctrl_i(mbist_ctrl_i),
`endif
      .ce(tlb_mr_en),
      .we(tlb_mr_we),
      .addr(tlb_index),
      .di(tlb_mr_ram_in),
      .doq(tlb_mr_ram_out)
      );
`endif // !`ifdef OR1200_GF_ARM_28SLP
   
   
   //
   // Instantiation of DTLB Translate Registers
   //
   //or1200_spram_64x24 dtlb_tr_ram(
`ifdef OR1200_GF_ARM_28SLP
   assign tlb_tr_cen = ~tlb_tr_en;
   assign tlb_tr_wen = ~tlb_tr_we;
   
   sp_hsc_128x24 dtlb_tr_ram
     (
      .Q(tlb_tr_ram_out),
      .CLK(clk),
      .CEN(tlb_tr_cen),
      .WEN(tlb_tr_wen),
      .A({1'b0, tlb_index}),      
      .D(tlb_tr_ram_in),
      .EMA(3'b000),
      .EMAW(2'b00),
      .EMAS(1'b0),      
      .RET1N(1'b1)
   );
`else   
   or1200_spram #
     (
      .aw(6),
      .dw(24)
      )
   dtlb_tr_ram
     (
      .clk(clk),
`ifdef OR1200_BIST
      // RAM BIST
      .mbist_si_i(mbist_tr_si),
      .mbist_so_o(mbist_tr_so),
      .mbist_ctrl_i(mbist_ctrl_i),
`endif
      .ce(tlb_tr_en),
      .we(tlb_tr_we),
      .addr(tlb_index),
      .di(tlb_tr_ram_in),
      .doq(tlb_tr_ram_out)
      );
`endif // !`ifdef OR1200_GF_ARM_28SLP
      
endmodule // or1200_dmmu_tlb


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Data MMU top level                                 ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Instantiation of all DMMU blocks.                           ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_dmmu_top.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed. 
//

// synopsys translate_off
// synopsys translate_on

//
// Data MMU
//

module or1200_dmmu_top(
	// Rst and clk
	clk, rst,

	// CPU i/f
	dc_en, dmmu_en, supv, dcpu_adr_i, dcpu_cycstb_i, dcpu_we_i,
	dcpu_tag_o, dcpu_err_o,

	// SPR access
	spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o,

`ifdef OR1200_BIST
	// RAM BIST
	mbist_si_i, mbist_so_o, mbist_ctrl_i,
`endif

	// DC i/f
	qmemdmmu_err_i, qmemdmmu_tag_i, qmemdmmu_adr_o, qmemdmmu_cycstb_o, qmemdmmu_ci_o
);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_OPERAND_WIDTH;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// CPU I/F
//
input				dc_en;
input				dmmu_en;
input				supv;
input	[aw-1:0]		dcpu_adr_i;
input				dcpu_cycstb_i;
input				dcpu_we_i;
output	[3:0]			dcpu_tag_o;
output				dcpu_err_o;

//
// SPR access
//
input				spr_cs;
input				spr_write;
input	[aw-1:0]		spr_addr;
input	[31:0]			spr_dat_i;
output	[31:0]			spr_dat_o;

`ifdef OR1200_BIST
//
// RAM BIST
//
input mbist_si_i;
input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;
output mbist_so_o;
`endif

//
// DC I/F
//
input				qmemdmmu_err_i;
input	[3:0]			qmemdmmu_tag_i;
output	[aw-1:0]		qmemdmmu_adr_o;
output				qmemdmmu_cycstb_o;
output				qmemdmmu_ci_o;

//
// Internal wires and regs
//
wire				dtlb_spr_access;
wire	[31:`OR1200_DMMU_PS]	dtlb_ppn;
wire				dtlb_hit;
wire				dtlb_uwe;
wire				dtlb_ure;
wire				dtlb_swe;
wire				dtlb_sre;
wire	[31:0]			dtlb_dat_o;
wire				dtlb_en;
wire				dtlb_ci;
wire				fault;
wire				miss;
`ifdef OR1200_NO_DMMU
`else
reg				dtlb_done;
reg	[31:`OR1200_DMMU_PS]	dcpu_vpn_r;
`endif

//
// Implemented bits inside match and translate registers
//
// dtlbwYmrX: vpn 31-10  v 0
// dtlbwYtrX: ppn 31-10  swe 9  sre 8  uwe 7  ure 6
//
// dtlb memory width:
// 19 bits for ppn
// 13 bits for vpn
// 1 bit for valid
// 4 bits for protection
// 1 bit for cache inhibit

`ifdef OR1200_NO_DMMU

//
// Put all outputs in inactive state
//
assign spr_dat_o = 32'h00000000;
assign qmemdmmu_adr_o = dcpu_adr_i;
assign dcpu_tag_o = qmemdmmu_tag_i;
assign qmemdmmu_cycstb_o = dcpu_cycstb_i;
assign dcpu_err_o = qmemdmmu_err_i;
assign qmemdmmu_ci_o = `OR1200_DMMU_CI;
`ifdef OR1200_BIST
assign mbist_so_o = mbist_si_i;
`endif

`else

//
// DTLB SPR access
//
// 0A00 - 0AFF  dtlbmr w0
// 0A00 - 0A3F  dtlbmr w0 [63:0]
//
// 0B00 - 0BFF  dtlbtr w0
// 0B00 - 0B3F  dtlbtr w0 [63:0]
//
assign dtlb_spr_access = spr_cs;

//
// Tags:
//
// OR1200_DTAG_TE - TLB miss Exception
// OR1200_DTAG_PE - Page fault Exception
//
assign dcpu_tag_o = miss ? `OR1200_DTAG_TE : fault ? `OR1200_DTAG_PE : qmemdmmu_tag_i;

//
// dcpu_err_o
//
assign dcpu_err_o = miss | fault | qmemdmmu_err_i;

//
// Assert dtlb_done one clock cycle after new address and dtlb_en must be active
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dtlb_done <=  1'b0;
	else if (dtlb_en)
		dtlb_done <=  dcpu_cycstb_i;
	else
		dtlb_done <=  1'b0;

//
// Cut transfer if something goes wrong with translation. Also delayed signals 
// because of translation delay.
assign qmemdmmu_cycstb_o = (dc_en & dmmu_en) ? 
			   !(miss | fault) & dtlb_done & dcpu_cycstb_i : 
			   !(miss | fault) & dcpu_cycstb_i;


//
// Cache Inhibit
//
assign qmemdmmu_ci_o = dmmu_en ? dtlb_ci : `OR1200_DMMU_CI;

//
// Register dcpu_adr_i's VPN for use when DMMU is not enabled but PPN is 
// expected to come one clock cycle after offset part.
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dcpu_vpn_r <=  {32-`OR1200_DMMU_PS{1'b0}};
	else
		dcpu_vpn_r <=  dcpu_adr_i[31:`OR1200_DMMU_PS];

//
// Physical address is either translated virtual address or
// simply equal when DMMU is disabled
//
assign qmemdmmu_adr_o = dmmu_en ? {dtlb_ppn, dcpu_adr_i[`OR1200_DMMU_PS-1:0]} :
			          dcpu_adr_i;

//
// Output to SPRS unit
//
assign spr_dat_o = dtlb_spr_access ? dtlb_dat_o : 32'h00000000;

//
// Page fault exception logic
//
assign fault = dtlb_done &
	(  (!dcpu_we_i & !supv & !dtlb_ure) // Load in user mode not enabled
	   || (!dcpu_we_i & supv & !dtlb_sre) // Load in supv mode not enabled
	   || (dcpu_we_i & !supv & !dtlb_uwe) // Store in user mode not enabled
	   || (dcpu_we_i & supv & !dtlb_swe)); // Store in supv mode not enabled

//
// TLB Miss exception logic
//
assign miss = dtlb_done & !dtlb_hit;

//
// DTLB Enable
//
assign dtlb_en = dmmu_en & dcpu_cycstb_i;

//
// Instantiation of DTLB
//
or1200_dmmu_tlb or1200_dmmu_tlb(
	// Rst and clk
        .clk(clk),
	.rst(rst),

        // I/F for translation
        .tlb_en(dtlb_en),
	.vaddr(dcpu_adr_i),
	.hit(dtlb_hit),
	.ppn(dtlb_ppn),
	.uwe(dtlb_uwe),
	.ure(dtlb_ure),
	.swe(dtlb_swe),
	.sre(dtlb_sre),
	.ci(dtlb_ci),

`ifdef OR1200_BIST
	// RAM BIST
	.mbist_si_i(mbist_si_i),
	.mbist_so_o(mbist_so_o),
	.mbist_ctrl_i(mbist_ctrl_i),
`endif

        // SPR access
        .spr_cs(dtlb_spr_access),
	.spr_write(spr_write),
	.spr_addr(spr_addr),
	.spr_dat_i(spr_dat_i),
	.spr_dat_o(dtlb_dat_o)
);

`endif

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Generic Double-Port Synchronous RAM                         ////
////                                                              ////
////  This file is part of memory library available from          ////
////  http://www.opencores.org/cvsweb.shtml/generic_memories/     ////
////                                                              ////
////  Description                                                 ////
////  This block is a wrapper with common double-port             ////
////  synchronous memory interface for different                  ////
////  types of ASIC and FPGA RAMs. Beside universal memory        ////
////  interface it also provides behavioral model of generic      ////
////  double-port synchronous RAM.                                ////
////  It should be used in all OPENCORES designs that want to be  ////
////  portable accross different target technologies and          ////
////  independent of target memory.                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Michael Unneback, unneback@opencores.org              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_dpram.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// New 
//

// synopsys translate_off
// synopsys translate_on

module or1200_dpram
  (
   // Generic synchronous double-port RAM interface
   clk_a, ce_a, addr_a, do_a,
   clk_b, ce_b, we_b, addr_b, di_b
   );
   
   //
   // Default address and data buses width
   //
   parameter aw = 5;
   parameter dw = 32;
   
   //
   // Generic synchronous double-port RAM interface
   //
   input			clk_a;	// Clock
   input			ce_a;	// Chip enable input
   input [aw-1:0] 		addr_a;	// address bus inputs
   output [dw-1:0] 		do_a;	// output data bus
   input			clk_b;	// Clock
   input			ce_b;	// Chip enable input
   input			we_b;	// Write enable input
   input [aw-1:0] 		addr_b;	// address bus inputs
   input [dw-1:0] 		di_b;	// input data bus
   
   //
   // Internal wires and registers
   //
   
   //
   // Generic double-port synchronous RAM model
   //
   
   //
   // Generic RAM's registers and wires
   //
   reg [dw-1:0] 		mem [(1<<aw)-1:0] /*synthesis syn_ramstyle = "no_rw_check"*/;	// RAM content
   reg [aw-1:0] 		addr_a_reg;		// RAM address registered


   // Function to access GPRs (for use by Verilator). No need to hide this one
   // from the simulator, since it has an input (as required by IEEE 1364-2001).
   function [31:0] get_gpr;
      // verilator public
      input [aw-1:0] 		gpr_no;

      get_gpr = mem[gpr_no];
      
   endfunction // get_gpr
   
   //
   // Data output drivers
   //
   //assign do_a = (oe_a) ? mem[addr_a_reg] : {dw{1'b0}};
   assign do_a = mem[addr_a_reg];
   
   
   //
   // RAM read
   //
   always @(posedge clk_a)
     if (ce_a)
       addr_a_reg <=  addr_a;
   
   //
   // RAM write
   //
   always @(posedge clk_b)
     if (ce_b & we_b)
       mem[addr_b] <=  di_b;
   
endmodule // or1200_dpram


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Generic Double-Port Synchronous RAM                         ////
////                                                              ////
////  This file is part of memory library available from          ////
////  http://www.opencores.org/cvsweb.shtml/generic_memories/     ////
////                                                              ////
////  Description                                                 ////
////  This block is a wrapper with common double-port             ////
////  synchronous memory interface for different                  ////
////  types of ASIC and FPGA RAMs. Beside universal memory        ////
////  interface it also provides behavioral model of generic      ////
////  double-port synchronous RAM.                                ////
////  It should be used in all OPENCORES designs that want to be  ////
////  portable accross different target technologies and          ////
////  independent of target memory.                               ////
////                                                              ////
////  Supported ASIC RAMs are:                                    ////
////                                                              ////
////  Supported FPGA RAMs are:                                    ////
////  - Xilinx Virtex RAMB16                                      ////
////  - Xilinx Virtex RAMB4                                       ////
////                                                              ////
////  To Do:                                                      ////
////   - add additional RAMs                                      ////
////   - xilinx rams need external tri-state logic                ////
////                                                              ////
////  Author(s):                                                  ////
////      - Nir  Mor, nirm@opencores.org                          ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2005 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_dpram_256x32.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// New
//

// synopsys translate_off
// synopsys translate_on

module or1200_dpram_256x32(
	// Generic synchronous double-port RAM interface
	clk_a, rst_a, ce_a, oe_a, addr_a, do_a,
	clk_b, rst_b, ce_b, we_b, addr_b, di_b
);

//
// Default address and data buses width
//
parameter aw = 8;
parameter dw = 32;

//
// Generic synchronous double-port RAM interface
//
input			clk_a;	// Clock
input			rst_a;	// Reset
input			ce_a;	// Chip enable input
input			oe_a;	// Output enable input
input 	[aw-1:0]	addr_a;	// address bus inputs
output	[dw-1:0]	do_a;	// output data bus
input			clk_b;	// Clock
input			rst_b;	// Reset
input			ce_b;	// Chip enable input
input			we_b;	// Write enable input
input 	[aw-1:0]	addr_b;	// address bus inputs
input	[dw-1:0]	di_b;	// input data bus


`ifdef OR1200_XILINX_RAMB4

//
// Instantiation of FPGA memory:
//
// Virtex/Spartan2
//

//
// Block 0
//
RAMB4_S16_S16 ramb4_s16_0(
	.CLKA(clk_a),
	.RSTA(rst_a),
	.ADDRA(addr_a),
	.DIA(16'h0000),
	.ENA(ce_a),
	.WEA(1'b0),
	.DOA(do_a[15:0]),

	.CLKB(clk_b),
	.RSTB(rst_b),
	.ADDRB(addr_b),
	.DIB(di_b[15:0]),
	.ENB(ce_b),
	.WEB(we_b),
	.DOB()
);

//
// Block 1
//
RAMB4_S16_S16 ramb4_s16_1(
	.CLKA(clk_a),
	.RSTA(rst_a),
	.ADDRA(addr_a),
	.DIA(16'h0000),
	.ENA(ce_a),
	.WEA(1'b0),
	.DOA(do_a[31:16]),

	.CLKB(clk_b),
	.RSTB(rst_b),
	.ADDRB(addr_b),
	.DIB(di_b[31:16]),
	.ENB(ce_b),
	.WEB(we_b),
	.DOB()
);

`else

`ifdef OR1200_XILINX_RAMB16

//
// Instantiation of FPGA memory:
//
// Virtex4/Spartan3E
//
// Added By Nir Mor
//

RAMB16_S36_S36 ramb16_s36_s36(
	.CLKA(clk_a),
	.SSRA(rst_a),
	.ADDRA({1'b0, addr_a}),
	.DIA(32'h00000000),
	.DIPA(4'h0),
 	.ENA(ce_a),
	.WEA(1'b0),
	.DOA(do_a),
	.DOPA(),

	.CLKB(clk_b),
	.SSRB(rst_b),
	.ADDRB({1'b0, addr_b}),
	.DIB(di_b),
	.DIPB(4'h0),
	.ENB(ce_b),
	.WEB(we_b),
	.DOB(),
	.DOPB()
);

`else

//
// Generic double-port synchronous RAM model
//

//
// Generic RAM's registers and wires
//
reg	[dw-1:0]	mem [(1<<aw)-1:0];	// RAM content
reg	[aw-1:0]	addr_a_reg;		// RAM address registered

//
// Data output drivers
//
assign do_a = (oe_a) ? mem[addr_a_reg] : {dw{1'b0}};

//
// RAM read
//
always @(posedge clk_a )
	if (rst_a == `OR1200_RST_VALUE)
		addr_a_reg <=  {aw{1'b0}};
	else if (ce_a)
		addr_a_reg <=  addr_a;

//
// RAM write
//
always @(posedge clk_b)
	if (ce_b && we_b)
		mem[addr_b] <=  di_b;

`endif	// !OR1200_XILINX_RAMB16
`endif	// !OR1200_XILINX_RAMB4
endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Generic Double-Port Synchronous RAM                         ////
////                                                              ////
////  This file is part of memory library available from          ////
////  http://www.opencores.org/cvsweb.shtml/generic_memories/     ////
////                                                              ////
////  Description                                                 ////
////  This block is a wrapper with common double-port             ////
////  synchronous memory interface for different                  ////
////  types of ASIC and FPGA RAMs. Beside universal memory        ////
////  interface it also provides behavioral model of generic      ////
////  double-port synchronous RAM.                                ////
////  It should be used in all OPENCORES designs that want to be  ////
////  portable accross different target technologies and          ////
////  independent of target memory.                               ////
////                                                              ////
////  Supported ASIC RAMs are:                                    ////
////  - Artisan Double-Port Sync RAM                              ////
////  - Avant! Two-Port Sync RAM (*)                              ////
////  - Virage 2-port Sync RAM                                    ////
////                                                              ////
////  Supported FPGA RAMs are:                                    ////
////  - Xilinx Virtex RAMB16                                      ////
////  - Xilinx Virtex RAMB4                                       ////
////  - Altera LPM                                                ////
////                                                              ////
////  To Do:                                                      ////
////   - fix Avant!                                               ////
////   - xilinx rams need external tri-state logic                ////
////   - add additional RAMs                                      ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_dpram_32x32.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//
// Revision 1.10  2005/10/19 11:37:56  jcastillo
// Added support for RAMB16 Xilinx4/Spartan3 primitives
//
// Revision 1.9  2004/06/08 18:15:48  lampret
// Changed behavior of the simulation generic models
//
// Revision 1.8  2004/04/05 08:29:57  lampret
// Merged branch_qmem into main tree.
//
// Revision 1.7.4.1  2003/07/08 15:36:37  lampret
// Added embedded memory QMEM.
//
// Revision 1.7  2003/04/07 01:19:07  lampret
// Added Altera LPM RAMs. Changed generic RAM output when OE inactive.
//
// Revision 1.6  2002/03/28 19:25:42  lampret
// Added second type of Virtual Silicon two-port SRAM (for register file). Changed defines for VS STP RAMs.
//
// Revision 1.5  2002/02/01 19:56:54  lampret
// Fixed combinational loops.
//
// Revision 1.4  2002/01/23 07:52:36  lampret
// Changed default reset values for SR and ESR to match or1ksim's. Fixed flop model in or1200_dpram_32x32 when OR1200_XILINX_RAM32X1D is defined.
//
// Revision 1.3  2002/01/19 14:10:22  lampret
// Fixed OR1200_XILINX_RAM32X1D.
//
// Revision 1.2  2002/01/15 06:12:22  lampret
// Fixed module name when compiling with OR1200_XILINX_RAM32X1D
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.10  2001/11/05 14:48:00  lampret
// Added missing endif
//
// Revision 1.9  2001/11/02 18:57:14  lampret
// Modified virtual silicon instantiations.
//
// Revision 1.8  2001/10/22 19:39:56  lampret
// Fixed parameters in generic sprams.
//
// Revision 1.7  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.6  2001/10/14 13:12:09  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
// Revision 1.1  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.2  2001/07/30 05:38:02  lampret
// Adding empty directories required by HDL coding guidelines
//
//

// synopsys translate_off
// synopsys translate_on

module or1200_dpram_32x32(
	// Generic synchronous double-port RAM interface
	clk_a, rst_a, ce_a, oe_a, addr_a, do_a,
	clk_b, rst_b, ce_b, we_b, addr_b, di_b
);

//
// Default address and data buses width
//
parameter aw = 5;
parameter dw = 32;

//
// Generic synchronous double-port RAM interface
//
input			clk_a;	// Clock
input			rst_a;	// Reset
input			ce_a;	// Chip enable input
input			oe_a;	// Output enable input
input 	[aw-1:0]	addr_a;	// address bus inputs
output	[dw-1:0]	do_a;	// output data bus
input			clk_b;	// Clock
input			rst_b;	// Reset
input			ce_b;	// Chip enable input
input			we_b;	// Write enable input
input 	[aw-1:0]	addr_b;	// address bus inputs
input	[dw-1:0]	di_b;	// input data bus

//
// Internal wires and registers
//

`ifdef OR1200_ARTISAN_SDP

//
// Instantiation of ASIC memory:
//
// Artisan Synchronous Double-Port RAM (ra2sh)
//
`ifdef UNUSED
art_hsdp_32x32 #(dw, 1<<aw, aw) artisan_sdp(
`else
art_hsdp_32x32 artisan_sdp(
`endif
	.qa(do_a),
	.clka(clk_a),
	.cena(~ce_a),
	.wena(1'b1),
	.aa(addr_a),
	.da(32'h00000000),
	.oena(~oe_a),
	.qb(),
	.clkb(clk_b),
	.cenb(~ce_b),
	.wenb(~we_b),
	.ab(addr_b),
	.db(di_b),
	.oenb(1'b1)
);

`else

`ifdef OR1200_AVANT_ATP

//
// Instantiation of ASIC memory:
//
// Avant! Asynchronous Two-Port RAM
//
avant_atp avant_atp(
	.web(~we),
	.reb(),
	.oeb(~oe),
	.rcsb(),
	.wcsb(),
	.ra(addr),
	.wa(addr),
	.di(di),
	.doq(doq)
);

`else

`ifdef OR1200_VIRAGE_STP

//
// Instantiation of ASIC memory:
//
// Virage Synchronous 2-port R/W RAM
//
virage_stp virage_stp(
	.QA(do_a),
	.QB(),

	.ADRA(addr_a),
	.DA(32'h00000000),
	.WEA(1'b0),
	.OEA(oe_a),
	.MEA(ce_a),
	.CLKA(clk_a),

	.ADRB(addr_b),
	.DB(di_b),
	.WEB(we_b),
	.OEB(1'b1),
	.MEB(ce_b),
	.CLKB(clk_b)
);

`else

`ifdef OR1200_VIRTUALSILICON_STP_T1

//
// Instantiation of ASIC memory:
//
// Virtual Silicon Two-port R/W SRAM Type 1
//
`ifdef UNUSED
vs_hdtp_64x32 #(1<<aw, aw-1, dw-1) vs_ssp(
`else
vs_hdtp_64x32 vs_ssp(
`endif
	.P1CK(clk_a),
	.P1CEN(~ce_a),
	.P1WEN(1'b1),
	.P1OEN(~oe_a),
	.P1ADR({1'b0, addr_a}),
	.P1DI(32'h0000_0000),
	.P1DOUT(do_a),

	.P2CK(clk_b),
	.P2CEN(~ce_b),
	.P2WEN(~ce_b),
	.P2OEN(1'b1),
	.P2ADR({1'b0, addr_b}),
	.P2DI(di_b),
	.P2DOUT()
);

`else

`ifdef OR1200_VIRTUALSILICON_STP_T2

//
// Instantiation of ASIC memory:
//
// Virtual Silicon Two-port R/W SRAM Type 2
//
`ifdef UNUSED
vs_hdtp_32x32 #(1<<aw, aw-1, dw-1) vs_ssp(
`else
vs_hdtp_32x32 vs_ssp(
`endif
        .RCK(clk_a),
        .REN(~ce_a),
        .OEN(~oe_a),
        .RADR(addr_a),
        .DOUT(do_a),

	.WCK(clk_b),
	.WEN(~ce_b),
	.WADR(addr_b),
	.DI(di_b)
);

`else

`ifdef OR1200_XILINX_RAM32X1D

//
// Instantiation of FPGA memory:
//
// Virtex/Spartan2
//

reg	[4:0]	addr_a_r;

always @(posedge clk_a )
	if (rst_a == `OR1200_RST_VALUE)
		addr_a_r <=  5'b00000;
	else if (ce_a)
		addr_a_r <=  addr_a;

//
// Block 0
//
or1200_xcv_ram32x8d xcv_ram32x8d_0 (
	.DPO(do_a[7:0]),
	.SPO(),
	.A(addr_b),
	.D(di_b[7:0]),
	.DPRA(addr_a_r),
	.WCLK(clk_b),
	.WE(we_b)
);

//
// Block 1
//
or1200_xcv_ram32x8d xcv_ram32x8d_1 (
	.DPO(do_a[15:8]),
	.SPO(),
	.A(addr_b),
	.D(di_b[15:8]),
	.DPRA(addr_a_r),
	.WCLK(clk_b),
	.WE(we_b)
);


//
// Block 2
//
or1200_xcv_ram32x8d xcv_ram32x8d_2 (
	.DPO(do_a[23:16]),
	.SPO(),
	.A(addr_b),
	.D(di_b[23:16]),
	.DPRA(addr_a_r),
	.WCLK(clk_b),
	.WE(we_b)
);

//
// Block 3
//
or1200_xcv_ram32x8d xcv_ram32x8d_3 (
	.DPO(do_a[31:24]),
	.SPO(),
	.A(addr_b),
	.D(di_b[31:24]),
	.DPRA(addr_a_r),
	.WCLK(clk_b),
	.WE(we_b)
);

`else

`ifdef OR1200_XILINX_RAMB4

//
// Instantiation of FPGA memory:
//
// Virtex/Spartan2
//

//
// Block 0
//
RAMB4_S16_S16 ramb4_s16_0(
	.CLKA(clk_a),
	.RSTA(1'b0),
	.ADDRA({3'b000, addr_a}),
	.DIA(16'h0000),
	.ENA(ce_a),
	.WEA(1'b0),
	.DOA(do_a[15:0]),

	.CLKB(clk_b),
	.RSTB(1'b0),
	.ADDRB({3'b000, addr_b}),
	.DIB(di_b[15:0]),
	.ENB(ce_b),
	.WEB(we_b),
	.DOB()
);

//
// Block 1
//
RAMB4_S16_S16 ramb4_s16_1(
	.CLKA(clk_a),
	.RSTA(1'b0),
	.ADDRA({3'b000, addr_a}),
	.DIA(16'h0000),
	.ENA(ce_a),
	.WEA(1'b0),
	.DOA(do_a[31:16]),

	.CLKB(clk_b),
	.RSTB(1'b0),
	.ADDRB({3'b000, addr_b}),
	.DIB(di_b[31:16]),
	.ENB(ce_b),
	.WEB(we_b),
	.DOB()
);

`else

`ifdef OR1200_XILINX_RAMB16

//
// Instantiation of FPGA memory:
//
// Virtex4/Spartan3E
//
// Added By Nir Mor
//

RAMB16_S36_S36 ramb16_s36_s36(
	.CLKA(clk_a),
	.SSRA(1'b0),
	.ADDRA({4'b0000, addr_a}),
	.DIA(32'h00000000),
	.DIPA(4'h0),
	.ENA(ce_a),
	.WEA(1'b0),
	.DOA(do_a),
	.DOPA(),

	.CLKB(clk_b),
	.SSRB(1'b0),
	.ADDRB({4'b0000, addr_b}),
	.DIB(di_b),
	.DIPB(4'h0),
	.ENB(ce_b),
	.WEB(we_b),
	.DOB(),
	.DOPB()
);

`else

`ifdef OR1200_ALTERA_LPM_XXX

//
// Instantiation of FPGA memory:
//
// Altera LPM
//
// Added By Jamil Khatib
//
altqpram altqpram_component (
        .wraddress_a (addr_a),
        .inclocken_a (ce_a),
        .wraddress_b (addr_b),
        .wren_a (we_a),
        .inclocken_b (ce_b),
        .wren_b (we_b),
        .inaclr_a (1'b0),
        .inaclr_b (1'b0),
        .inclock_a (clk_a),
        .inclock_b (clk_b),
        .data_a (di_a),
        .data_b (di_b),
        .q_a (do_a),
        .q_b (do_b)
);

defparam altqpram_component.operation_mode = "BIDIR_DUAL_PORT",
        altqpram_component.width_write_a = dw,
        altqpram_component.widthad_write_a = aw,
        altqpram_component.numwords_write_a = dw,
        altqpram_component.width_read_a = dw,
        altqpram_component.widthad_read_a = aw,
        altqpram_component.numwords_read_a = dw,
        altqpram_component.width_write_b = dw,
        altqpram_component.widthad_write_b = aw,
        altqpram_component.numwords_write_b = dw,
        altqpram_component.width_read_b = dw,
        altqpram_component.widthad_read_b = aw,
        altqpram_component.numwords_read_b = dw,
        altqpram_component.indata_reg_a = "INCLOCK_A",
        altqpram_component.wrcontrol_wraddress_reg_a = "INCLOCK_A",
        altqpram_component.outdata_reg_a = "INCLOCK_A",
        altqpram_component.indata_reg_b = "INCLOCK_B",
        altqpram_component.wrcontrol_wraddress_reg_b = "INCLOCK_B",
        altqpram_component.outdata_reg_b = "INCLOCK_B",
        altqpram_component.indata_aclr_a = "INACLR_A",
        altqpram_component.wraddress_aclr_a = "INACLR_A",
        altqpram_component.wrcontrol_aclr_a = "INACLR_A",
        altqpram_component.outdata_aclr_a = "INACLR_A",
        altqpram_component.indata_aclr_b = "NONE",
        altqpram_component.wraddress_aclr_b = "NONE",
        altqpram_component.wrcontrol_aclr_b = "NONE",
        altqpram_component.outdata_aclr_b = "INACLR_B",
        altqpram_component.lpm_hint = "USE_ESB=ON";
        //examplar attribute altqpram_component NOOPT TRUE

`else

//
// Generic double-port synchronous RAM model
//

//
// Generic RAM's registers and wires
//
reg	[dw-1:0]	mem [(1<<aw)-1:0];	// RAM content
reg	[aw-1:0]	addr_a_reg;		// RAM address registered

//
// Data output drivers
//
assign do_a = (oe_a) ? mem[addr_a_reg] : {dw{1'b0}};

//
// RAM read
//
always @(posedge clk_a )
	if (rst_a == `OR1200_RST_VALUE)
		addr_a_reg <=  {aw{1'b0}};
	else if (ce_a)
		addr_a_reg <=  addr_a;

//
// RAM write
//
always @(posedge clk_b)
	if (ce_b && we_b)
		mem[addr_b] <=  di_b;

`endif	// !OR1200_ALTERA_LPM
`endif	// !OR1200_XILINX_RAMB16
`endif	// !OR1200_XILINX_RAMB4
`endif	// !OR1200_XILINX_RAM32X1D
`endif	// !OR1200_VIRTUALSILICON_SSP_T1
`endif	// !OR1200_VIRTUALSILICON_SSP_T2
`endif	// !OR1200_VIRAGE_STP
`endif	// !OR1200_AVANT_ATP
`endif	// !OR1200_ARTISAN_SDP

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Debug Unit                                         ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Basic OR1200 debug unit.                                    ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//
// $Log: or1200_du.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed. 

// synopsys translate_off
// synopsys translate_on

//
// Debug unit
//

module or1200_du(
	// RISC Internal Interface
	clk, rst,
	dcpu_cycstb_i, dcpu_we_i, dcpu_adr_i, dcpu_dat_lsu,
	dcpu_dat_dc, icpu_cycstb_i,
	ex_freeze, branch_op, ex_insn, id_pc,
	spr_dat_npc, rf_dataw,
	du_dsr, du_dmr1, du_stall, du_addr, du_dat_i, du_dat_o,
	du_read, du_write, du_except_stop, du_hwbkpt,
	spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o,

	// External Debug Interface
	dbg_stall_i, dbg_ewt_i,	dbg_lss_o, dbg_is_o, dbg_wp_o, dbg_bp_o,
	dbg_stb_i, dbg_we_i, dbg_adr_i, dbg_dat_i, dbg_dat_o, dbg_ack_o
);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_OPERAND_WIDTH;

//
// I/O
//

//
// RISC Internal Interface
//
input				clk;		// Clock
input				rst;		// Reset
input				dcpu_cycstb_i;	// LSU status
input				dcpu_we_i;	// LSU status
input	[31:0]			dcpu_adr_i;	// LSU addr
input	[31:0]			dcpu_dat_lsu;	// LSU store data
input	[31:0]			dcpu_dat_dc;	// LSU load data
input	[`OR1200_FETCHOP_WIDTH-1:0]	icpu_cycstb_i;	// IFETCH unit status
input				ex_freeze;	// EX stage freeze
input	[`OR1200_BRANCHOP_WIDTH-1:0]	branch_op;	// Branch op
input	[dw-1:0]		ex_insn;	// EX insn
input	[31:0]			id_pc;		// insn fetch EA
input	[31:0]			spr_dat_npc;	// Next PC (for trace)
input	[31:0]			rf_dataw;	// ALU result (for trace)
output	[`OR1200_DU_DSR_WIDTH-1:0]     du_dsr;		// DSR
output	[24: 0]			du_dmr1;
output				du_stall;	// Debug Unit Stall
output	[aw-1:0]		du_addr;	// Debug Unit Address
input	[dw-1:0]		du_dat_i;	// Debug Unit Data In
output	[dw-1:0]		du_dat_o;	// Debug Unit Data Out
output				du_read;	// Debug Unit Read Enable
output				du_write;	// Debug Unit Write Enable
input	[13:0]			du_except_stop;	// Exception masked by DSR
output				du_hwbkpt;	// Cause trap exception (HW Breakpoints)
input				spr_cs;		// SPR Chip Select
input				spr_write;	// SPR Read/Write
input	[aw-1:0]		spr_addr;	// SPR Address
input	[dw-1:0]		spr_dat_i;	// SPR Data Input
output	[dw-1:0]		spr_dat_o;	// SPR Data Output

//
// External Debug Interface
//
input			dbg_stall_i;	// External Stall Input
input			dbg_ewt_i;	// External Watchpoint Trigger Input
output	[3:0]		dbg_lss_o;	// External Load/Store Unit Status
output	[1:0]		dbg_is_o;	// External Insn Fetch Status
output	[10:0]		dbg_wp_o;	// Watchpoints Outputs
output			dbg_bp_o;	// Breakpoint Output
input			dbg_stb_i;      // External Address/Data Strobe
input			dbg_we_i;       // External Write Enable
input	[aw-1:0]	dbg_adr_i;	// External Address Input
input	[dw-1:0]	dbg_dat_i;	// External Data Input
output	[dw-1:0]	dbg_dat_o;	// External Data Output
output			dbg_ack_o;	// External Data Acknowledge (not WB compatible)
reg	[dw-1:0]	dbg_dat_o;	// External Data Output
reg			dbg_ack_o;	// External Data Acknowledge (not WB compatible)


//
// Some connections go directly from the CPU through DU to Debug I/F
//
`ifdef OR1200_DU_STATUS_UNIMPLEMENTED
assign dbg_lss_o = 4'b0000;

reg	[1:0]			dbg_is_o;
//
// Show insn activity (temp, must be removed)
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dbg_is_o <=  2'b00;
	else if (!ex_freeze & ~((ex_insn[31:26] == `OR1200_OR32_NOP) & ex_insn[16]))
		dbg_is_o <=  ~dbg_is_o;
`ifdef UNUSED
assign dbg_is_o = 2'b00;
`endif
`else
assign dbg_lss_o = dcpu_cycstb_i ? {dcpu_we_i, 3'b000} : 4'b0000;
assign dbg_is_o = {1'b0, icpu_cycstb_i};
`endif
assign dbg_wp_o = 11'b000_0000_0000;

//
// Some connections go directly from Debug I/F through DU to the CPU
//
assign du_stall = dbg_stall_i;
assign du_addr = dbg_adr_i;
assign du_dat_o = dbg_dat_i;
assign du_read = dbg_stb_i && !dbg_we_i;
assign du_write = dbg_stb_i && dbg_we_i;

reg				dbg_ack;
//
// Generate acknowledge -- just delay stb signal
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE) begin
		dbg_ack   <=  1'b0;
		dbg_ack_o <=  1'b0;
	end
	else begin
		dbg_ack   <=  dbg_stb_i;		// valid when du_dat_i 
		dbg_ack_o <=  dbg_ack & dbg_stb_i;	// valid when dbg_dat_o 
	end
end

// 
// Register data output
//
always @(posedge clk)
    dbg_dat_o <=  du_dat_i;

`ifdef OR1200_DU_IMPLEMENTED

//
// Debug Mode Register 1
//
`ifdef OR1200_DU_DMR1
reg	[24:0]			dmr1;		// DMR1 implemented
`else
wire	[24:0]			dmr1;		// DMR1 not implemented
`endif
assign du_dmr1 = dmr1;

//
// Debug Mode Register 2
//
`ifdef OR1200_DU_DMR2
reg	[23:0]			dmr2;		// DMR2 implemented
`else
wire	[23:0]			dmr2;		// DMR2 not implemented
`endif

//
// Debug Stop Register
//
`ifdef OR1200_DU_DSR
reg	[`OR1200_DU_DSR_WIDTH-1:0]	dsr;		// DSR implemented
`else
wire	[`OR1200_DU_DSR_WIDTH-1:0]	dsr;		// DSR not implemented
`endif

//
// Debug Reason Register
//
`ifdef OR1200_DU_DRR
reg	[13:0]			drr;		// DRR implemented
`else
wire	[13:0]			drr;		// DRR not implemented
`endif

//
// Debug Value Register N
//
`ifdef OR1200_DU_DVR0
reg	[31:0]			dvr0;
`else
wire	[31:0]			dvr0;
`endif

//
// Debug Value Register N
//
`ifdef OR1200_DU_DVR1
reg	[31:0]			dvr1;
`else
wire	[31:0]			dvr1;
`endif

//
// Debug Value Register N
//
`ifdef OR1200_DU_DVR2
reg	[31:0]			dvr2;
`else
wire	[31:0]			dvr2;
`endif

//
// Debug Value Register N
//
`ifdef OR1200_DU_DVR3
reg	[31:0]			dvr3;
`else
wire	[31:0]			dvr3;
`endif

//
// Debug Value Register N
//
`ifdef OR1200_DU_DVR4
reg	[31:0]			dvr4;
`else
wire	[31:0]			dvr4;
`endif

//
// Debug Value Register N
//
`ifdef OR1200_DU_DVR5
reg	[31:0]			dvr5;
`else
wire	[31:0]			dvr5;
`endif

//
// Debug Value Register N
//
`ifdef OR1200_DU_DVR6
reg	[31:0]			dvr6;
`else
wire	[31:0]			dvr6;
`endif

//
// Debug Value Register N
//
`ifdef OR1200_DU_DVR7
reg	[31:0]			dvr7;
`else
wire	[31:0]			dvr7;
`endif

//
// Debug Control Register N
//
`ifdef OR1200_DU_DCR0
reg	[7:0]			dcr0;
`else
wire	[7:0]			dcr0;
`endif

//
// Debug Control Register N
//
`ifdef OR1200_DU_DCR1
reg	[7:0]			dcr1;
`else
wire	[7:0]			dcr1;
`endif

//
// Debug Control Register N
//
`ifdef OR1200_DU_DCR2
reg	[7:0]			dcr2;
`else
wire	[7:0]			dcr2;
`endif

//
// Debug Control Register N
//
`ifdef OR1200_DU_DCR3
reg	[7:0]			dcr3;
`else
wire	[7:0]			dcr3;
`endif

//
// Debug Control Register N
//
`ifdef OR1200_DU_DCR4
reg	[7:0]			dcr4;
`else
wire	[7:0]			dcr4;
`endif

//
// Debug Control Register N
//
`ifdef OR1200_DU_DCR5
reg	[7:0]			dcr5;
`else
wire	[7:0]			dcr5;
`endif

//
// Debug Control Register N
//
`ifdef OR1200_DU_DCR6
reg	[7:0]			dcr6;
`else
wire	[7:0]			dcr6;
`endif

//
// Debug Control Register N
//
`ifdef OR1200_DU_DCR7
reg	[7:0]			dcr7;
`else
wire	[7:0]			dcr7;
`endif

//
// Debug Watchpoint Counter Register 0
//
`ifdef OR1200_DU_DWCR0
reg	[31:0]			dwcr0;
`else
wire	[31:0]			dwcr0;
`endif

//
// Debug Watchpoint Counter Register 1
//
`ifdef OR1200_DU_DWCR1
reg	[31:0]			dwcr1;
`else
wire	[31:0]			dwcr1;
`endif

//
// Internal wires
//
wire				dmr1_sel; 	// DMR1 select
wire				dmr2_sel; 	// DMR2 select
wire				dsr_sel; 	// DSR select
wire				drr_sel; 	// DRR select
wire				dvr0_sel,
				dvr1_sel,
				dvr2_sel,
				dvr3_sel,
				dvr4_sel,
				dvr5_sel,
				dvr6_sel,
				dvr7_sel; 	// DVR selects
wire				dcr0_sel,
				dcr1_sel,
				dcr2_sel,
				dcr3_sel,
				dcr4_sel,
				dcr5_sel,
				dcr6_sel,
				dcr7_sel; 	// DCR selects
wire				dwcr0_sel,
				dwcr1_sel; 	// DWCR selects
reg				dbg_bp_r;
`ifdef OR1200_DU_HWBKPTS
reg	[31:0]			match_cond0_ct;
reg	[31:0]			match_cond1_ct;
reg	[31:0]			match_cond2_ct;
reg	[31:0]			match_cond3_ct;
reg	[31:0]			match_cond4_ct;
reg	[31:0]			match_cond5_ct;
reg	[31:0]			match_cond6_ct;
reg	[31:0]			match_cond7_ct;
reg				match_cond0_stb;
reg				match_cond1_stb;
reg				match_cond2_stb;
reg				match_cond3_stb;
reg				match_cond4_stb;
reg				match_cond5_stb;
reg				match_cond6_stb;
reg				match_cond7_stb;
reg				match0;
reg				match1;
reg				match2;
reg				match3;
reg				match4;
reg				match5;
reg				match6;
reg				match7;
reg				wpcntr0_match;
reg				wpcntr1_match;
reg				incr_wpcntr0;
reg				incr_wpcntr1;
reg	[10:0]			wp;
`endif
wire				du_hwbkpt;
reg				du_hwbkpt_hold;
`ifdef OR1200_DU_READREGS
reg	[31:0]			spr_dat_o;
`endif
reg	[13:0]			except_stop;	// Exceptions that stop because of DSR
`ifdef OR1200_DU_TB_IMPLEMENTED
wire				tb_enw;
reg	[7:0]			tb_wadr;
reg [31:0]			tb_timstmp;
`endif
wire	[31:0]			tbia_dat_o;
wire	[31:0]			tbim_dat_o;
wire	[31:0]			tbar_dat_o;
wire	[31:0]			tbts_dat_o;

//
// DU registers address decoder
//
`ifdef OR1200_DU_DMR1
assign dmr1_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DMR1));
`endif
`ifdef OR1200_DU_DMR2
assign dmr2_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DMR2));
`endif
`ifdef OR1200_DU_DSR
assign dsr_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DSR));
`endif
`ifdef OR1200_DU_DRR
assign drr_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DRR));
`endif
`ifdef OR1200_DU_DVR0
assign dvr0_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DVR0));
`endif
`ifdef OR1200_DU_DVR1
assign dvr1_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DVR1));
`endif
`ifdef OR1200_DU_DVR2
assign dvr2_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DVR2));
`endif
`ifdef OR1200_DU_DVR3
assign dvr3_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DVR3));
`endif
`ifdef OR1200_DU_DVR4
assign dvr4_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DVR4));
`endif
`ifdef OR1200_DU_DVR5
assign dvr5_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DVR5));
`endif
`ifdef OR1200_DU_DVR6
assign dvr6_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DVR6));
`endif
`ifdef OR1200_DU_DVR7
assign dvr7_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DVR7));
`endif
`ifdef OR1200_DU_DCR0
assign dcr0_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DCR0));
`endif
`ifdef OR1200_DU_DCR1
assign dcr1_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DCR1));
`endif
`ifdef OR1200_DU_DCR2
assign dcr2_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DCR2));
`endif
`ifdef OR1200_DU_DCR3
assign dcr3_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DCR3));
`endif
`ifdef OR1200_DU_DCR4
assign dcr4_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DCR4));
`endif
`ifdef OR1200_DU_DCR5
assign dcr5_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DCR5));
`endif
`ifdef OR1200_DU_DCR6
assign dcr6_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DCR6));
`endif
`ifdef OR1200_DU_DCR7
assign dcr7_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DCR7));
`endif
`ifdef OR1200_DU_DWCR0
assign dwcr0_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DWCR0));
`endif
`ifdef OR1200_DU_DWCR1
assign dwcr1_sel = (spr_cs && (spr_addr[`OR1200_DUOFS_BITS] == `OR1200_DU_DWCR1));
`endif

//
// Decode started exception
//
// du_except_stop comes from or1200_except
//   
always @(du_except_stop) begin
	except_stop = 14'b00_0000_0000_0000;
	casez (du_except_stop)
	        14'b1?_????_????_????:
			except_stop[`OR1200_DU_DRR_TTE] = 1'b1;
		14'b01_????_????_????: begin
			except_stop[`OR1200_DU_DRR_IE] = 1'b1;
		end
		14'b00_1???_????_????: begin
			except_stop[`OR1200_DU_DRR_IME] = 1'b1;
		end
		14'b00_01??_????_????:
			except_stop[`OR1200_DU_DRR_IPFE] = 1'b1;
		14'b00_001?_????_????: begin
			except_stop[`OR1200_DU_DRR_BUSEE] = 1'b1;
		end
		14'b00_0001_????_????:
			except_stop[`OR1200_DU_DRR_IIE] = 1'b1;
		14'b00_0000_1???_????: begin
			except_stop[`OR1200_DU_DRR_AE] = 1'b1;
		end
		14'b00_0000_01??_????: begin
			except_stop[`OR1200_DU_DRR_DME] = 1'b1;
		end
		14'b00_0000_001?_????:
			except_stop[`OR1200_DU_DRR_DPFE] = 1'b1;
		14'b00_0000_0001_????:
			except_stop[`OR1200_DU_DRR_BUSEE] = 1'b1;
		14'b00_0000_0000_1???: begin
			except_stop[`OR1200_DU_DRR_RE] = 1'b1;
		end
		14'b00_0000_0000_01??: begin
			except_stop[`OR1200_DU_DRR_TE] = 1'b1;
		end
		14'b00_0000_0000_001?: begin
		        except_stop[`OR1200_DU_DRR_FPE] = 1'b1;
		end	  
		14'b00_0000_0000_0001:
			except_stop[`OR1200_DU_DRR_SCE] = 1'b1;
		default:
			except_stop = 14'b00_0000_0000_0000;
	endcase
end

//
// dbg_bp_o is registered
//
assign dbg_bp_o = dbg_bp_r;

//
// Breakpoint activation register
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dbg_bp_r <=  1'b0;
	else if (!ex_freeze)
		dbg_bp_r <=  |except_stop
`ifdef OR1200_DU_DMR1_ST
                        | ~((ex_insn[31:26] == `OR1200_OR32_NOP) & ex_insn[16]) & dmr1[`OR1200_DU_DMR1_ST]
`endif
`ifdef OR1200_DU_DMR1_BT
                        | (branch_op != `OR1200_BRANCHOP_NOP) & (branch_op != `OR1200_BRANCHOP_RFE) & dmr1[`OR1200_DU_DMR1_BT]
`endif
			;
        else
                dbg_bp_r <=  |except_stop;

//
// Write to DMR1
//
`ifdef OR1200_DU_DMR1
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dmr1 <= 25'h000_0000;
	else if (dmr1_sel && spr_write)
`ifdef OR1200_DU_HWBKPTS
		dmr1 <=  spr_dat_i[24:0];
`else
		dmr1 <=  {1'b0, spr_dat_i[23:22], 22'h00_0000};
`endif
`else
assign dmr1 = 25'h000_0000;
`endif

//
// Write to DMR2
//
`ifdef OR1200_DU_DMR2
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dmr2 <= 24'h00_0000;
	else if (dmr2_sel && spr_write)
		dmr2 <=  spr_dat_i[23:0];
`else
assign dmr2 = 24'h00_0000;
`endif

//
// Write to DSR
//
`ifdef OR1200_DU_DSR
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dsr <= {`OR1200_DU_DSR_WIDTH{1'b0}};
	else if (dsr_sel && spr_write)
		dsr <=  spr_dat_i[`OR1200_DU_DSR_WIDTH-1:0];
`else
assign dsr = {`OR1200_DU_DSR_WIDTH{1'b0}};
`endif

//
// Write to DRR
//
`ifdef OR1200_DU_DRR
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		drr <= 14'b0;
	else if (drr_sel && spr_write)
		drr <=  spr_dat_i[13:0];
	else
		drr <=  drr | except_stop;
`else
assign drr = 14'b0;
`endif

//
// Write to DVR0
//
`ifdef OR1200_DU_DVR0
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dvr0 <= 32'h0000_0000;
	else if (dvr0_sel && spr_write)
		dvr0 <=  spr_dat_i[31:0];
`else
assign dvr0 = 32'h0000_0000;
`endif

//
// Write to DVR1
//
`ifdef OR1200_DU_DVR1
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dvr1 <= 32'h0000_0000;
	else if (dvr1_sel && spr_write)
		dvr1 <=  spr_dat_i[31:0];
`else
assign dvr1 = 32'h0000_0000;
`endif

//
// Write to DVR2
//
`ifdef OR1200_DU_DVR2
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dvr2 <= 32'h0000_0000;
	else if (dvr2_sel && spr_write)
		dvr2 <=  spr_dat_i[31:0];
`else
assign dvr2 = 32'h0000_0000;
`endif

//
// Write to DVR3
//
`ifdef OR1200_DU_DVR3
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dvr3 <= 32'h0000_0000;
	else if (dvr3_sel && spr_write)
		dvr3 <=  spr_dat_i[31:0];
`else
assign dvr3 = 32'h0000_0000;
`endif

//
// Write to DVR4
//
`ifdef OR1200_DU_DVR4
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dvr4 <= 32'h0000_0000;
	else if (dvr4_sel && spr_write)
		dvr4 <=  spr_dat_i[31:0];
`else
assign dvr4 = 32'h0000_0000;
`endif

//
// Write to DVR5
//
`ifdef OR1200_DU_DVR5
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dvr5 <= 32'h0000_0000;
	else if (dvr5_sel && spr_write)
		dvr5 <=  spr_dat_i[31:0];
`else
assign dvr5 = 32'h0000_0000;
`endif

//
// Write to DVR6
//
`ifdef OR1200_DU_DVR6
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dvr6 <= 32'h0000_0000;
	else if (dvr6_sel && spr_write)
		dvr6 <=  spr_dat_i[31:0];
`else
assign dvr6 = 32'h0000_0000;
`endif

//
// Write to DVR7
//
`ifdef OR1200_DU_DVR7
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dvr7 <= 32'h0000_0000;
	else if (dvr7_sel && spr_write)
		dvr7 <=  spr_dat_i[31:0];
`else
assign dvr7 = 32'h0000_0000;
`endif

//
// Write to DCR0
//
`ifdef OR1200_DU_DCR0
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dcr0 <= 8'h00;
	else if (dcr0_sel && spr_write)
		dcr0 <=  spr_dat_i[7:0];
`else
assign dcr0 = 8'h00;
`endif

//
// Write to DCR1
//
`ifdef OR1200_DU_DCR1
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dcr1 <= 8'h00;
	else if (dcr1_sel && spr_write)
		dcr1 <=  spr_dat_i[7:0];
`else
assign dcr1 = 8'h00;
`endif

//
// Write to DCR2
//
`ifdef OR1200_DU_DCR2
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dcr2 <= 8'h00;
	else if (dcr2_sel && spr_write)
		dcr2 <=  spr_dat_i[7:0];
`else
assign dcr2 = 8'h00;
`endif

//
// Write to DCR3
//
`ifdef OR1200_DU_DCR3
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dcr3 <= 8'h00;
	else if (dcr3_sel && spr_write)
		dcr3 <=  spr_dat_i[7:0];
`else
assign dcr3 = 8'h00;
`endif

//
// Write to DCR4
//
`ifdef OR1200_DU_DCR4
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dcr4 <= 8'h00;
	else if (dcr4_sel && spr_write)
		dcr4 <=  spr_dat_i[7:0];
`else
assign dcr4 = 8'h00;
`endif

//
// Write to DCR5
//
`ifdef OR1200_DU_DCR5
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dcr5 <= 8'h00;
	else if (dcr5_sel && spr_write)
		dcr5 <=  spr_dat_i[7:0];
`else
assign dcr5 = 8'h00;
`endif

//
// Write to DCR6
//
`ifdef OR1200_DU_DCR6
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dcr6 <= 8'h00;
	else if (dcr6_sel && spr_write)
		dcr6 <=  spr_dat_i[7:0];
`else
assign dcr6 = 8'h00;
`endif

//
// Write to DCR7
//
`ifdef OR1200_DU_DCR7
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dcr7 <= 8'h00;
	else if (dcr7_sel && spr_write)
		dcr7 <=  spr_dat_i[7:0];
`else
assign dcr7 = 8'h00;
`endif

//
// Write to DWCR0
//
`ifdef OR1200_DU_DWCR0
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dwcr0 <= 32'h0000_0000;
	else if (dwcr0_sel && spr_write)
		dwcr0 <=  spr_dat_i[31:0];
	else if (incr_wpcntr0)
		dwcr0[`OR1200_DU_DWCR_COUNT] <=  dwcr0[`OR1200_DU_DWCR_COUNT] + 16'h0001;
`else
assign dwcr0 = 32'h0000_0000;
`endif

//
// Write to DWCR1
//
`ifdef OR1200_DU_DWCR1
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dwcr1 <= 32'h0000_0000;
	else if (dwcr1_sel && spr_write)
		dwcr1 <=  spr_dat_i[31:0];
	else if (incr_wpcntr1)
		dwcr1[`OR1200_DU_DWCR_COUNT] <=  dwcr1[`OR1200_DU_DWCR_COUNT] + 16'h0001;
`else
assign dwcr1 = 32'h0000_0000;
`endif

//
// Read DU registers
//
`ifdef OR1200_DU_READREGS
always @(spr_addr or dsr or drr or dmr1 or dmr2
	or dvr0 or dvr1 or dvr2 or dvr3 or dvr4
	or dvr5 or dvr6 or dvr7
	or dcr0 or dcr1 or dcr2 or dcr3 or dcr4
	or dcr5 or dcr6 or dcr7
	or dwcr0 or dwcr1
`ifdef OR1200_DU_TB_IMPLEMENTED
	or tb_wadr or tbia_dat_o or tbim_dat_o
	or tbar_dat_o or tbts_dat_o
`endif
	)
	casez (spr_addr[`OR1200_DUOFS_BITS]) // synopsys parallel_case
`ifdef OR1200_DU_DVR0
		`OR1200_DU_DVR0:
			spr_dat_o = dvr0;
`endif
`ifdef OR1200_DU_DVR1
		`OR1200_DU_DVR1:
			spr_dat_o = dvr1;
`endif
`ifdef OR1200_DU_DVR2
		`OR1200_DU_DVR2:
			spr_dat_o = dvr2;
`endif
`ifdef OR1200_DU_DVR3
		`OR1200_DU_DVR3:
			spr_dat_o = dvr3;
`endif
`ifdef OR1200_DU_DVR4
		`OR1200_DU_DVR4:
			spr_dat_o = dvr4;
`endif
`ifdef OR1200_DU_DVR5
		`OR1200_DU_DVR5:
			spr_dat_o = dvr5;
`endif
`ifdef OR1200_DU_DVR6
		`OR1200_DU_DVR6:
			spr_dat_o = dvr6;
`endif
`ifdef OR1200_DU_DVR7
		`OR1200_DU_DVR7:
			spr_dat_o = dvr7;
`endif
`ifdef OR1200_DU_DCR0
		`OR1200_DU_DCR0:
			spr_dat_o = {24'h00_0000, dcr0};
`endif
`ifdef OR1200_DU_DCR1
		`OR1200_DU_DCR1:
			spr_dat_o = {24'h00_0000, dcr1};
`endif
`ifdef OR1200_DU_DCR2
		`OR1200_DU_DCR2:
			spr_dat_o = {24'h00_0000, dcr2};
`endif
`ifdef OR1200_DU_DCR3
		`OR1200_DU_DCR3:
			spr_dat_o = {24'h00_0000, dcr3};
`endif
`ifdef OR1200_DU_DCR4
		`OR1200_DU_DCR4:
			spr_dat_o = {24'h00_0000, dcr4};
`endif
`ifdef OR1200_DU_DCR5
		`OR1200_DU_DCR5:
			spr_dat_o = {24'h00_0000, dcr5};
`endif
`ifdef OR1200_DU_DCR6
		`OR1200_DU_DCR6:
			spr_dat_o = {24'h00_0000, dcr6};
`endif
`ifdef OR1200_DU_DCR7
		`OR1200_DU_DCR7:
			spr_dat_o = {24'h00_0000, dcr7};
`endif
`ifdef OR1200_DU_DMR1
		`OR1200_DU_DMR1:
			spr_dat_o = {7'h00, dmr1};
`endif
`ifdef OR1200_DU_DMR2
		`OR1200_DU_DMR2:
			spr_dat_o = {8'h00, dmr2};
`endif
`ifdef OR1200_DU_DWCR0
		`OR1200_DU_DWCR0:
			spr_dat_o = dwcr0;
`endif
`ifdef OR1200_DU_DWCR1
		`OR1200_DU_DWCR1:
			spr_dat_o = dwcr1;
`endif
`ifdef OR1200_DU_DSR
		`OR1200_DU_DSR:
			spr_dat_o = {18'b0, dsr};
`endif
`ifdef OR1200_DU_DRR
		`OR1200_DU_DRR:
			spr_dat_o = {18'b0, drr};
`endif
`ifdef OR1200_DU_TB_IMPLEMENTED
		`OR1200_DU_TBADR:
			spr_dat_o = {24'h000000, tb_wadr};
		`OR1200_DU_TBIA:
			spr_dat_o = tbia_dat_o;
		`OR1200_DU_TBIM:
			spr_dat_o = tbim_dat_o;
		`OR1200_DU_TBAR:
			spr_dat_o = tbar_dat_o;
		`OR1200_DU_TBTS:
			spr_dat_o = tbts_dat_o;
`endif
		default:
			spr_dat_o = 32'h0000_0000;
	endcase
`endif

//
// DSR alias
//
assign du_dsr = dsr;

`ifdef OR1200_DU_HWBKPTS

//
// Compare To What (Match Condition 0)
//
always @(dcr0 or id_pc or dcpu_adr_i or dcpu_dat_dc
	or dcpu_dat_lsu or dcpu_we_i)
	case (dcr0[`OR1200_DU_DCR_CT])		// synopsys parallel_case
		3'b001:	match_cond0_ct = id_pc;		// insn fetch EA
		3'b010:	match_cond0_ct = dcpu_adr_i;	// load EA
		3'b011:	match_cond0_ct = dcpu_adr_i;	// store EA
		3'b100:	match_cond0_ct = dcpu_dat_dc;	// load data
		3'b101:	match_cond0_ct = dcpu_dat_lsu;	// store data
		3'b110:	match_cond0_ct = dcpu_adr_i;	// load/store EA
		default:match_cond0_ct = dcpu_we_i ? dcpu_dat_lsu : dcpu_dat_dc;
	endcase

//
// When To Compare (Match Condition 0)
//
always @(dcr0 or dcpu_cycstb_i)
	case (dcr0[`OR1200_DU_DCR_CT]) 		// synopsys parallel_case
		3'b000:	match_cond0_stb = 1'b0;		//comparison disabled
		3'b001:	match_cond0_stb = 1'b1;		// insn fetch EA
		default:match_cond0_stb = dcpu_cycstb_i; // any load/store
	endcase

//
// Match Condition 0
//
always @(match_cond0_stb or dcr0 or dvr0 or match_cond0_ct)
	casex ({match_cond0_stb, dcr0[`OR1200_DU_DCR_CC]})
		4'b0_xxx,
		4'b1_000,
		4'b1_111: match0 = 1'b0;
		4'b1_001: match0 =
			({(match_cond0_ct[31] ^ dcr0[`OR1200_DU_DCR_SC]), match_cond0_ct[30:0]} ==
			 {(dvr0[31] ^ dcr0[`OR1200_DU_DCR_SC]), dvr0[30:0]});
		4'b1_010: match0 = 
			({(match_cond0_ct[31] ^ dcr0[`OR1200_DU_DCR_SC]), match_cond0_ct[30:0]} <
			 {(dvr0[31] ^ dcr0[`OR1200_DU_DCR_SC]), dvr0[30:0]});
		4'b1_011: match0 = 
			({(match_cond0_ct[31] ^ dcr0[`OR1200_DU_DCR_SC]), match_cond0_ct[30:0]} <=
			 {(dvr0[31] ^ dcr0[`OR1200_DU_DCR_SC]), dvr0[30:0]});
		4'b1_100: match0 = 
			({(match_cond0_ct[31] ^ dcr0[`OR1200_DU_DCR_SC]), match_cond0_ct[30:0]} >
			 {(dvr0[31] ^ dcr0[`OR1200_DU_DCR_SC]), dvr0[30:0]});
		4'b1_101: match0 = 
			({(match_cond0_ct[31] ^ dcr0[`OR1200_DU_DCR_SC]), match_cond0_ct[30:0]} >=
			 {(dvr0[31] ^ dcr0[`OR1200_DU_DCR_SC]), dvr0[30:0]});
		4'b1_110: match0 = 
			({(match_cond0_ct[31] ^ dcr0[`OR1200_DU_DCR_SC]), match_cond0_ct[30:0]} !=
			 {(dvr0[31] ^ dcr0[`OR1200_DU_DCR_SC]), dvr0[30:0]});
	endcase

//
// Watchpoint 0
//
always @(dmr1 or match0)
	case (dmr1[`OR1200_DU_DMR1_CW0])
		2'b00: wp[0] = match0;
		2'b01: wp[0] = match0;
		2'b10: wp[0] = match0;
		2'b11: wp[0] = 1'b0;
	endcase

//
// Compare To What (Match Condition 1)
//
always @(dcr1 or id_pc or dcpu_adr_i or dcpu_dat_dc
	or dcpu_dat_lsu or dcpu_we_i)
	case (dcr1[`OR1200_DU_DCR_CT])		// synopsys parallel_case
		3'b001:	match_cond1_ct = id_pc;		// insn fetch EA
		3'b010:	match_cond1_ct = dcpu_adr_i;	// load EA
		3'b011:	match_cond1_ct = dcpu_adr_i;	// store EA
		3'b100:	match_cond1_ct = dcpu_dat_dc;	// load data
		3'b101:	match_cond1_ct = dcpu_dat_lsu;	// store data
		3'b110:	match_cond1_ct = dcpu_adr_i;	// load/store EA
		default:match_cond1_ct = dcpu_we_i ? dcpu_dat_lsu : dcpu_dat_dc;
	endcase

//
// When To Compare (Match Condition 1)
//
always @(dcr1 or dcpu_cycstb_i)
	case (dcr1[`OR1200_DU_DCR_CT]) 		// synopsys parallel_case
		3'b000:	match_cond1_stb = 1'b0;		//comparison disabled
		3'b001:	match_cond1_stb = 1'b1;		// insn fetch EA
		default:match_cond1_stb = dcpu_cycstb_i; // any load/store
	endcase

//
// Match Condition 1
//
always @(match_cond1_stb or dcr1 or dvr1 or match_cond1_ct)
	casex ({match_cond1_stb, dcr1[`OR1200_DU_DCR_CC]})
		4'b0_xxx,
		4'b1_000,
		4'b1_111: match1 = 1'b0;
		4'b1_001: match1 =
			({(match_cond1_ct[31] ^ dcr1[`OR1200_DU_DCR_SC]), match_cond1_ct[30:0]} ==
			 {(dvr1[31] ^ dcr1[`OR1200_DU_DCR_SC]), dvr1[30:0]});
		4'b1_010: match1 = 
			({(match_cond1_ct[31] ^ dcr1[`OR1200_DU_DCR_SC]), match_cond1_ct[30:0]} <
			 {(dvr1[31] ^ dcr1[`OR1200_DU_DCR_SC]), dvr1[30:0]});
		4'b1_011: match1 = 
			({(match_cond1_ct[31] ^ dcr1[`OR1200_DU_DCR_SC]), match_cond1_ct[30:0]} <=
			 {(dvr1[31] ^ dcr1[`OR1200_DU_DCR_SC]), dvr1[30:0]});
		4'b1_100: match1 = 
			({(match_cond1_ct[31] ^ dcr1[`OR1200_DU_DCR_SC]), match_cond1_ct[30:0]} >
			 {(dvr1[31] ^ dcr1[`OR1200_DU_DCR_SC]), dvr1[30:0]});
		4'b1_101: match1 = 
			({(match_cond1_ct[31] ^ dcr1[`OR1200_DU_DCR_SC]), match_cond1_ct[30:0]} >=
			 {(dvr1[31] ^ dcr1[`OR1200_DU_DCR_SC]), dvr1[30:0]});
		4'b1_110: match1 = 
			({(match_cond1_ct[31] ^ dcr1[`OR1200_DU_DCR_SC]), match_cond1_ct[30:0]} !=
			 {(dvr1[31] ^ dcr1[`OR1200_DU_DCR_SC]), dvr1[30:0]});
	endcase

//
// Watchpoint 1
//
always @(dmr1 or match1 or wp)
	case (dmr1[`OR1200_DU_DMR1_CW1])
		2'b00: wp[1] = match1;
		2'b01: wp[1] = match1 & wp[0];
		2'b10: wp[1] = match1 | wp[0];
		2'b11: wp[1] = 1'b0;
	endcase

//
// Compare To What (Match Condition 2)
//
always @(dcr2 or id_pc or dcpu_adr_i or dcpu_dat_dc
	or dcpu_dat_lsu or dcpu_we_i)
	case (dcr2[`OR1200_DU_DCR_CT])		// synopsys parallel_case
		3'b001:	match_cond2_ct = id_pc;		// insn fetch EA
		3'b010:	match_cond2_ct = dcpu_adr_i;	// load EA
		3'b011:	match_cond2_ct = dcpu_adr_i;	// store EA
		3'b100:	match_cond2_ct = dcpu_dat_dc;	// load data
		3'b101:	match_cond2_ct = dcpu_dat_lsu;	// store data
		3'b110:	match_cond2_ct = dcpu_adr_i;	// load/store EA
		default:match_cond2_ct = dcpu_we_i ? dcpu_dat_lsu : dcpu_dat_dc;
	endcase

//
// When To Compare (Match Condition 2)
//
always @(dcr2 or dcpu_cycstb_i)
	case (dcr2[`OR1200_DU_DCR_CT]) 		// synopsys parallel_case
		3'b000:	match_cond2_stb = 1'b0;		//comparison disabled
		3'b001:	match_cond2_stb = 1'b1;		// insn fetch EA
		default:match_cond2_stb = dcpu_cycstb_i; // any load/store
	endcase

//
// Match Condition 2
//
always @(match_cond2_stb or dcr2 or dvr2 or match_cond2_ct)
	casex ({match_cond2_stb, dcr2[`OR1200_DU_DCR_CC]})
		4'b0_xxx,
		4'b1_000,
		4'b1_111: match2 = 1'b0;
		4'b1_001: match2 =
			({(match_cond2_ct[31] ^ dcr2[`OR1200_DU_DCR_SC]), match_cond2_ct[30:0]} ==
			 {(dvr2[31] ^ dcr2[`OR1200_DU_DCR_SC]), dvr2[30:0]});
		4'b1_010: match2 = 
			({(match_cond2_ct[31] ^ dcr2[`OR1200_DU_DCR_SC]), match_cond2_ct[30:0]} <
			 {(dvr2[31] ^ dcr2[`OR1200_DU_DCR_SC]), dvr2[30:0]});
		4'b1_011: match2 = 
			({(match_cond2_ct[31] ^ dcr2[`OR1200_DU_DCR_SC]), match_cond2_ct[30:0]} <=
			 {(dvr2[31] ^ dcr2[`OR1200_DU_DCR_SC]), dvr2[30:0]});
		4'b1_100: match2 = 
			({(match_cond2_ct[31] ^ dcr2[`OR1200_DU_DCR_SC]), match_cond2_ct[30:0]} >
			 {(dvr2[31] ^ dcr2[`OR1200_DU_DCR_SC]), dvr2[30:0]});
		4'b1_101: match2 = 
			({(match_cond2_ct[31] ^ dcr2[`OR1200_DU_DCR_SC]), match_cond2_ct[30:0]} >=
			 {(dvr2[31] ^ dcr2[`OR1200_DU_DCR_SC]), dvr2[30:0]});
		4'b1_110: match2 = 
			({(match_cond2_ct[31] ^ dcr2[`OR1200_DU_DCR_SC]), match_cond2_ct[30:0]} !=
			 {(dvr2[31] ^ dcr2[`OR1200_DU_DCR_SC]), dvr2[30:0]});
	endcase

//
// Watchpoint 2
//
always @(dmr1 or match2 or wp)
	case (dmr1[`OR1200_DU_DMR1_CW2])
		2'b00: wp[2] = match2;
		2'b01: wp[2] = match2 & wp[1];
		2'b10: wp[2] = match2 | wp[1];
		2'b11: wp[2] = 1'b0;
	endcase

//
// Compare To What (Match Condition 3)
//
always @(dcr3 or id_pc or dcpu_adr_i or dcpu_dat_dc
	or dcpu_dat_lsu or dcpu_we_i)
	case (dcr3[`OR1200_DU_DCR_CT])		// synopsys parallel_case
		3'b001:	match_cond3_ct = id_pc;		// insn fetch EA
		3'b010:	match_cond3_ct = dcpu_adr_i;	// load EA
		3'b011:	match_cond3_ct = dcpu_adr_i;	// store EA
		3'b100:	match_cond3_ct = dcpu_dat_dc;	// load data
		3'b101:	match_cond3_ct = dcpu_dat_lsu;	// store data
		3'b110:	match_cond3_ct = dcpu_adr_i;	// load/store EA
		default:match_cond3_ct = dcpu_we_i ? dcpu_dat_lsu : dcpu_dat_dc;
	endcase

//
// When To Compare (Match Condition 3)
//
always @(dcr3 or dcpu_cycstb_i)
	case (dcr3[`OR1200_DU_DCR_CT]) 		// synopsys parallel_case
		3'b000:	match_cond3_stb = 1'b0;		//comparison disabled
		3'b001:	match_cond3_stb = 1'b1;		// insn fetch EA
		default:match_cond3_stb = dcpu_cycstb_i; // any load/store
	endcase

//
// Match Condition 3
//
always @(match_cond3_stb or dcr3 or dvr3 or match_cond3_ct)
	casex ({match_cond3_stb, dcr3[`OR1200_DU_DCR_CC]})
		4'b0_xxx,
		4'b1_000,
		4'b1_111: match3 = 1'b0;
		4'b1_001: match3 =
			({(match_cond3_ct[31] ^ dcr3[`OR1200_DU_DCR_SC]), match_cond3_ct[30:0]} ==
			 {(dvr3[31] ^ dcr3[`OR1200_DU_DCR_SC]), dvr3[30:0]});
		4'b1_010: match3 = 
			({(match_cond3_ct[31] ^ dcr3[`OR1200_DU_DCR_SC]), match_cond3_ct[30:0]} <
			 {(dvr3[31] ^ dcr3[`OR1200_DU_DCR_SC]), dvr3[30:0]});
		4'b1_011: match3 = 
			({(match_cond3_ct[31] ^ dcr3[`OR1200_DU_DCR_SC]), match_cond3_ct[30:0]} <=
			 {(dvr3[31] ^ dcr3[`OR1200_DU_DCR_SC]), dvr3[30:0]});
		4'b1_100: match3 = 
			({(match_cond3_ct[31] ^ dcr3[`OR1200_DU_DCR_SC]), match_cond3_ct[30:0]} >
			 {(dvr3[31] ^ dcr3[`OR1200_DU_DCR_SC]), dvr3[30:0]});
		4'b1_101: match3 = 
			({(match_cond3_ct[31] ^ dcr3[`OR1200_DU_DCR_SC]), match_cond3_ct[30:0]} >=
			 {(dvr3[31] ^ dcr3[`OR1200_DU_DCR_SC]), dvr3[30:0]});
		4'b1_110: match3 = 
			({(match_cond3_ct[31] ^ dcr3[`OR1200_DU_DCR_SC]), match_cond3_ct[30:0]} !=
			 {(dvr3[31] ^ dcr3[`OR1200_DU_DCR_SC]), dvr3[30:0]});
	endcase

//
// Watchpoint 3
//
always @(dmr1 or match3 or wp)
	case (dmr1[`OR1200_DU_DMR1_CW3])
		2'b00: wp[3] = match3;
		2'b01: wp[3] = match3 & wp[2];
		2'b10: wp[3] = match3 | wp[2];
		2'b11: wp[3] = 1'b0;
	endcase

//
// Compare To What (Match Condition 4)
//
always @(dcr4 or id_pc or dcpu_adr_i or dcpu_dat_dc
	or dcpu_dat_lsu or dcpu_we_i)
	case (dcr4[`OR1200_DU_DCR_CT])		// synopsys parallel_case
		3'b001:	match_cond4_ct = id_pc;		// insn fetch EA
		3'b010:	match_cond4_ct = dcpu_adr_i;	// load EA
		3'b011:	match_cond4_ct = dcpu_adr_i;	// store EA
		3'b100:	match_cond4_ct = dcpu_dat_dc;	// load data
		3'b101:	match_cond4_ct = dcpu_dat_lsu;	// store data
		3'b110:	match_cond4_ct = dcpu_adr_i;	// load/store EA
		default:match_cond4_ct = dcpu_we_i ? dcpu_dat_lsu : dcpu_dat_dc;
	endcase

//
// When To Compare (Match Condition 4)
//
always @(dcr4 or dcpu_cycstb_i)
	case (dcr4[`OR1200_DU_DCR_CT]) 		// synopsys parallel_case
		3'b000:	match_cond4_stb = 1'b0;		//comparison disabled
		3'b001:	match_cond4_stb = 1'b1;		// insn fetch EA
		default:match_cond4_stb = dcpu_cycstb_i; // any load/store
	endcase

//
// Match Condition 4
//
always @(match_cond4_stb or dcr4 or dvr4 or match_cond4_ct)
	casex ({match_cond4_stb, dcr4[`OR1200_DU_DCR_CC]})
		4'b0_xxx,
		4'b1_000,
		4'b1_111: match4 = 1'b0;
		4'b1_001: match4 =
			({(match_cond4_ct[31] ^ dcr4[`OR1200_DU_DCR_SC]), match_cond4_ct[30:0]} ==
			 {(dvr4[31] ^ dcr4[`OR1200_DU_DCR_SC]), dvr4[30:0]});
		4'b1_010: match4 = 
			({(match_cond4_ct[31] ^ dcr4[`OR1200_DU_DCR_SC]), match_cond4_ct[30:0]} <
			 {(dvr4[31] ^ dcr4[`OR1200_DU_DCR_SC]), dvr4[30:0]});
		4'b1_011: match4 = 
			({(match_cond4_ct[31] ^ dcr4[`OR1200_DU_DCR_SC]), match_cond4_ct[30:0]} <=
			 {(dvr4[31] ^ dcr4[`OR1200_DU_DCR_SC]), dvr4[30:0]});
		4'b1_100: match4 = 
			({(match_cond4_ct[31] ^ dcr4[`OR1200_DU_DCR_SC]), match_cond4_ct[30:0]} >
			 {(dvr4[31] ^ dcr4[`OR1200_DU_DCR_SC]), dvr4[30:0]});
		4'b1_101: match4 = 
			({(match_cond4_ct[31] ^ dcr4[`OR1200_DU_DCR_SC]), match_cond4_ct[30:0]} >=
			 {(dvr4[31] ^ dcr4[`OR1200_DU_DCR_SC]), dvr4[30:0]});
		4'b1_110: match4 = 
			({(match_cond4_ct[31] ^ dcr4[`OR1200_DU_DCR_SC]), match_cond4_ct[30:0]} !=
			 {(dvr4[31] ^ dcr4[`OR1200_DU_DCR_SC]), dvr4[30:0]});
	endcase

//
// Watchpoint 4
//
always @(dmr1 or match4 or wp)
	case (dmr1[`OR1200_DU_DMR1_CW4])
		2'b00: wp[4] = match4;
		2'b01: wp[4] = match4 & wp[3];
		2'b10: wp[4] = match4 | wp[3];
		2'b11: wp[4] = 1'b0;
	endcase

//
// Compare To What (Match Condition 5)
//
always @(dcr5 or id_pc or dcpu_adr_i or dcpu_dat_dc
	or dcpu_dat_lsu or dcpu_we_i)
	case (dcr5[`OR1200_DU_DCR_CT])		// synopsys parallel_case
		3'b001:	match_cond5_ct = id_pc;		// insn fetch EA
		3'b010:	match_cond5_ct = dcpu_adr_i;	// load EA
		3'b011:	match_cond5_ct = dcpu_adr_i;	// store EA
		3'b100:	match_cond5_ct = dcpu_dat_dc;	// load data
		3'b101:	match_cond5_ct = dcpu_dat_lsu;	// store data
		3'b110:	match_cond5_ct = dcpu_adr_i;	// load/store EA
		default:match_cond5_ct = dcpu_we_i ? dcpu_dat_lsu : dcpu_dat_dc;
	endcase

//
// When To Compare (Match Condition 5)
//
always @(dcr5 or dcpu_cycstb_i)
	case (dcr5[`OR1200_DU_DCR_CT]) 		// synopsys parallel_case
		3'b000:	match_cond5_stb = 1'b0;		//comparison disabled
		3'b001:	match_cond5_stb = 1'b1;		// insn fetch EA
		default:match_cond5_stb = dcpu_cycstb_i; // any load/store
	endcase

//
// Match Condition 5
//
always @(match_cond5_stb or dcr5 or dvr5 or match_cond5_ct)
	casex ({match_cond5_stb, dcr5[`OR1200_DU_DCR_CC]})
		4'b0_xxx,
		4'b1_000,
		4'b1_111: match5 = 1'b0;
		4'b1_001: match5 =
			({(match_cond5_ct[31] ^ dcr5[`OR1200_DU_DCR_SC]), match_cond5_ct[30:0]} ==
			 {(dvr5[31] ^ dcr5[`OR1200_DU_DCR_SC]), dvr5[30:0]});
		4'b1_010: match5 = 
			({(match_cond5_ct[31] ^ dcr5[`OR1200_DU_DCR_SC]), match_cond5_ct[30:0]} <
			 {(dvr5[31] ^ dcr5[`OR1200_DU_DCR_SC]), dvr5[30:0]});
		4'b1_011: match5 = 
			({(match_cond5_ct[31] ^ dcr5[`OR1200_DU_DCR_SC]), match_cond5_ct[30:0]} <=
			 {(dvr5[31] ^ dcr5[`OR1200_DU_DCR_SC]), dvr5[30:0]});
		4'b1_100: match5 = 
			({(match_cond5_ct[31] ^ dcr5[`OR1200_DU_DCR_SC]), match_cond5_ct[30:0]} >
			 {(dvr5[31] ^ dcr5[`OR1200_DU_DCR_SC]), dvr5[30:0]});
		4'b1_101: match5 = 
			({(match_cond5_ct[31] ^ dcr5[`OR1200_DU_DCR_SC]), match_cond5_ct[30:0]} >=
			 {(dvr5[31] ^ dcr5[`OR1200_DU_DCR_SC]), dvr5[30:0]});
		4'b1_110: match5 = 
			({(match_cond5_ct[31] ^ dcr5[`OR1200_DU_DCR_SC]), match_cond5_ct[30:0]} !=
			 {(dvr5[31] ^ dcr5[`OR1200_DU_DCR_SC]), dvr5[30:0]});
	endcase

//
// Watchpoint 5
//
always @(dmr1 or match5 or wp)
	case (dmr1[`OR1200_DU_DMR1_CW5])
		2'b00: wp[5] = match5;
		2'b01: wp[5] = match5 & wp[4];
		2'b10: wp[5] = match5 | wp[4];
		2'b11: wp[5] = 1'b0;
	endcase

//
// Compare To What (Match Condition 6)
//
always @(dcr6 or id_pc or dcpu_adr_i or dcpu_dat_dc
	or dcpu_dat_lsu or dcpu_we_i)
	case (dcr6[`OR1200_DU_DCR_CT])		// synopsys parallel_case
		3'b001:	match_cond6_ct = id_pc;		// insn fetch EA
		3'b010:	match_cond6_ct = dcpu_adr_i;	// load EA
		3'b011:	match_cond6_ct = dcpu_adr_i;	// store EA
		3'b100:	match_cond6_ct = dcpu_dat_dc;	// load data
		3'b101:	match_cond6_ct = dcpu_dat_lsu;	// store data
		3'b110:	match_cond6_ct = dcpu_adr_i;	// load/store EA
		default:match_cond6_ct = dcpu_we_i ? dcpu_dat_lsu : dcpu_dat_dc;
	endcase

//
// When To Compare (Match Condition 6)
//
always @(dcr6 or dcpu_cycstb_i)
	case (dcr6[`OR1200_DU_DCR_CT]) 		// synopsys parallel_case
		3'b000:	match_cond6_stb = 1'b0;		//comparison disabled
		3'b001:	match_cond6_stb = 1'b1;		// insn fetch EA
		default:match_cond6_stb = dcpu_cycstb_i; // any load/store
	endcase

//
// Match Condition 6
//
always @(match_cond6_stb or dcr6 or dvr6 or match_cond6_ct)
	casex ({match_cond6_stb, dcr6[`OR1200_DU_DCR_CC]})
		4'b0_xxx,
		4'b1_000,
		4'b1_111: match6 = 1'b0;
		4'b1_001: match6 =
			({(match_cond6_ct[31] ^ dcr6[`OR1200_DU_DCR_SC]), match_cond6_ct[30:0]} ==
			 {(dvr6[31] ^ dcr6[`OR1200_DU_DCR_SC]), dvr6[30:0]});
		4'b1_010: match6 = 
			({(match_cond6_ct[31] ^ dcr6[`OR1200_DU_DCR_SC]), match_cond6_ct[30:0]} <
			 {(dvr6[31] ^ dcr6[`OR1200_DU_DCR_SC]), dvr6[30:0]});
		4'b1_011: match6 = 
			({(match_cond6_ct[31] ^ dcr6[`OR1200_DU_DCR_SC]), match_cond6_ct[30:0]} <=
			 {(dvr6[31] ^ dcr6[`OR1200_DU_DCR_SC]), dvr6[30:0]});
		4'b1_100: match6 = 
			({(match_cond6_ct[31] ^ dcr6[`OR1200_DU_DCR_SC]), match_cond6_ct[30:0]} >
			 {(dvr6[31] ^ dcr6[`OR1200_DU_DCR_SC]), dvr6[30:0]});
		4'b1_101: match6 = 
			({(match_cond6_ct[31] ^ dcr6[`OR1200_DU_DCR_SC]), match_cond6_ct[30:0]} >=
			 {(dvr6[31] ^ dcr6[`OR1200_DU_DCR_SC]), dvr6[30:0]});
		4'b1_110: match6 = 
			({(match_cond6_ct[31] ^ dcr6[`OR1200_DU_DCR_SC]), match_cond6_ct[30:0]} !=
			 {(dvr6[31] ^ dcr6[`OR1200_DU_DCR_SC]), dvr6[30:0]});
	endcase

//
// Watchpoint 6
//
always @(dmr1 or match6 or wp)
	case (dmr1[`OR1200_DU_DMR1_CW6])
		2'b00: wp[6] = match6;
		2'b01: wp[6] = match6 & wp[5];
		2'b10: wp[6] = match6 | wp[5];
		2'b11: wp[6] = 1'b0;
	endcase

//
// Compare To What (Match Condition 7)
//
always @(dcr7 or id_pc or dcpu_adr_i or dcpu_dat_dc
	or dcpu_dat_lsu or dcpu_we_i)
	case (dcr7[`OR1200_DU_DCR_CT])		// synopsys parallel_case
		3'b001:	match_cond7_ct = id_pc;		// insn fetch EA
		3'b010:	match_cond7_ct = dcpu_adr_i;	// load EA
		3'b011:	match_cond7_ct = dcpu_adr_i;	// store EA
		3'b100:	match_cond7_ct = dcpu_dat_dc;	// load data
		3'b101:	match_cond7_ct = dcpu_dat_lsu;	// store data
		3'b110:	match_cond7_ct = dcpu_adr_i;	// load/store EA
		default:match_cond7_ct = dcpu_we_i ? dcpu_dat_lsu : dcpu_dat_dc;
	endcase

//
// When To Compare (Match Condition 7)
//
always @(dcr7 or dcpu_cycstb_i)
	case (dcr7[`OR1200_DU_DCR_CT]) 		// synopsys parallel_case
		3'b000:	match_cond7_stb = 1'b0;		//comparison disabled
		3'b001:	match_cond7_stb = 1'b1;		// insn fetch EA
		default:match_cond7_stb = dcpu_cycstb_i; // any load/store
	endcase

//
// Match Condition 7
//
always @(match_cond7_stb or dcr7 or dvr7 or match_cond7_ct)
	casex ({match_cond7_stb, dcr7[`OR1200_DU_DCR_CC]})
		4'b0_xxx,
		4'b1_000,
		4'b1_111: match7 = 1'b0;
		4'b1_001: match7 =
			({(match_cond7_ct[31] ^ dcr7[`OR1200_DU_DCR_SC]), match_cond7_ct[30:0]} ==
			 {(dvr7[31] ^ dcr7[`OR1200_DU_DCR_SC]), dvr7[30:0]});
		4'b1_010: match7 = 
			({(match_cond7_ct[31] ^ dcr7[`OR1200_DU_DCR_SC]), match_cond7_ct[30:0]} <
			 {(dvr7[31] ^ dcr7[`OR1200_DU_DCR_SC]), dvr7[30:0]});
		4'b1_011: match7 = 
			({(match_cond7_ct[31] ^ dcr7[`OR1200_DU_DCR_SC]), match_cond7_ct[30:0]} <=
			 {(dvr7[31] ^ dcr7[`OR1200_DU_DCR_SC]), dvr7[30:0]});
		4'b1_100: match7 = 
			({(match_cond7_ct[31] ^ dcr7[`OR1200_DU_DCR_SC]), match_cond7_ct[30:0]} >
			 {(dvr7[31] ^ dcr7[`OR1200_DU_DCR_SC]), dvr7[30:0]});
		4'b1_101: match7 = 
			({(match_cond7_ct[31] ^ dcr7[`OR1200_DU_DCR_SC]), match_cond7_ct[30:0]} >=
			 {(dvr7[31] ^ dcr7[`OR1200_DU_DCR_SC]), dvr7[30:0]});
		4'b1_110: match7 = 
			({(match_cond7_ct[31] ^ dcr7[`OR1200_DU_DCR_SC]), match_cond7_ct[30:0]} !=
			 {(dvr7[31] ^ dcr7[`OR1200_DU_DCR_SC]), dvr7[30:0]});
	endcase

//
// Watchpoint 7
//
always @(dmr1 or match7 or wp)
	case (dmr1[`OR1200_DU_DMR1_CW7])
		2'b00: wp[7] = match7;
		2'b01: wp[7] = match7 & wp[6];
		2'b10: wp[7] = match7 | wp[6];
		2'b11: wp[7] = 1'b0;
	endcase

//
// Increment Watchpoint Counter 0
//
always @(wp or dmr2)
	if (dmr2[`OR1200_DU_DMR2_WCE0])
		incr_wpcntr0 = |(wp & ~dmr2[`OR1200_DU_DMR2_AWTC]);
	else
		incr_wpcntr0 = 1'b0;

//
// Match Condition Watchpoint Counter 0
//
always @(dwcr0)
	if (dwcr0[`OR1200_DU_DWCR_MATCH] == dwcr0[`OR1200_DU_DWCR_COUNT])
		wpcntr0_match = 1'b1;
	else
		wpcntr0_match = 1'b0;


//
// Watchpoint 8
//
always @(dmr1 or wpcntr0_match or wp)
	case (dmr1[`OR1200_DU_DMR1_CW8])
		2'b00: wp[8] = wpcntr0_match;
		2'b01: wp[8] = wpcntr0_match & wp[7];
		2'b10: wp[8] = wpcntr0_match | wp[7];
		2'b11: wp[8] = 1'b0;
	endcase


//
// Increment Watchpoint Counter 1
//
always @(wp or dmr2)
	if (dmr2[`OR1200_DU_DMR2_WCE1])
		incr_wpcntr1 = |(wp & dmr2[`OR1200_DU_DMR2_AWTC]);
	else
		incr_wpcntr1 = 1'b0;

//
// Match Condition Watchpoint Counter 1
//
always @(dwcr1)
	if (dwcr1[`OR1200_DU_DWCR_MATCH] == dwcr1[`OR1200_DU_DWCR_COUNT])
		wpcntr1_match = 1'b1;
	else
		wpcntr1_match = 1'b0;

//
// Watchpoint 9
//
always @(dmr1 or wpcntr1_match or wp)
	case (dmr1[`OR1200_DU_DMR1_CW9])
		2'b00: wp[9] = wpcntr1_match;
		2'b01: wp[9] = wpcntr1_match & wp[8];
		2'b10: wp[9] = wpcntr1_match | wp[8];
		2'b11: wp[9] = 1'b0;
	endcase

//
// Watchpoint 10
//
always @(dmr1 or dbg_ewt_i or wp)
	case (dmr1[`OR1200_DU_DMR1_CW10])
		2'b00: wp[10] = dbg_ewt_i;
		2'b01: wp[10] = dbg_ewt_i & wp[9];
		2'b10: wp[10] = dbg_ewt_i | wp[9];
		2'b11: wp[10] = 1'b0;
	endcase

`endif

//
// Watchpoints can cause trap exception
//
`ifdef OR1200_DU_HWBKPTS
assign du_hwbkpt = |(wp & dmr2[`OR1200_DU_DMR2_WGB]) | du_hwbkpt_hold | (dbg_bp_r & ~dsr[`OR1200_DU_DSR_TE]);
`else
assign du_hwbkpt = 1'b0;
`endif

// Hold du_hwbkpt if ex_freeze is active in order to cause trap exception 
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		du_hwbkpt_hold <=  1'b0;
	else if (du_hwbkpt & ex_freeze)
		du_hwbkpt_hold <=  1'b1;
	else if (!ex_freeze)
		du_hwbkpt_hold <=  1'b0;

`ifdef OR1200_DU_TB_IMPLEMENTED
//
// Simple trace buffer
// (right now hardcoded for Xilinx Virtex FPGAs)
//
// Stores last 256 instruction addresses, instruction
// machine words and ALU results
//

//
// Trace buffer write enable
//
assign tb_enw = ~ex_freeze & ~((ex_insn[31:26] == `OR1200_OR32_NOP) & ex_insn[16]);

//
// Trace buffer write address pointer
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		tb_wadr <=  8'h00;
	else if (tb_enw)
		tb_wadr <=  tb_wadr + 8'd1;

//
// Free running counter (time stamp)
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		tb_timstmp <=  32'h00000000;
	else if (!dbg_bp_r)
		tb_timstmp <=  tb_timstmp + 32'd1;

//
// Trace buffer RAMs
//

or1200_dpram_256x32 tbia_ram(
	.clk_a(clk),
	.rst_a(1'b0),
	.addr_a(spr_addr[7:0]),
	.ce_a(1'b1),
	.oe_a(1'b1),
	.do_a(tbia_dat_o),

	.clk_b(clk),
	.rst_b(1'b0),
	.addr_b(tb_wadr),
	.di_b(spr_dat_npc),
	.ce_b(1'b1),
	.we_b(tb_enw)

);

or1200_dpram_256x32 tbim_ram(
	.clk_a(clk),
	.rst_a(1'b0),
	.addr_a(spr_addr[7:0]),
	.ce_a(1'b1),
	.oe_a(1'b1),
	.do_a(tbim_dat_o),
	
	.clk_b(clk),
	.rst_b(1'b0),
	.addr_b(tb_wadr),
	.di_b(ex_insn),
	.ce_b(1'b1),
	.we_b(tb_enw)
);

or1200_dpram_256x32 tbar_ram(
	.clk_a(clk),
	.rst_a(1'b0),
	.addr_a(spr_addr[7:0]),
	.ce_a(1'b1),
	.oe_a(1'b1),
	.do_a(tbar_dat_o),
	
	.clk_b(clk),
	.rst_b(1'b0),
	.addr_b(tb_wadr),
	.di_b(rf_dataw),
	.ce_b(1'b1),
	.we_b(tb_enw)
);

or1200_dpram_256x32 tbts_ram(
	.clk_a(clk),
	.rst_a(1'b0),
	.addr_a(spr_addr[7:0]),
	.ce_a(1'b1),
	.oe_a(1'b1),
	.do_a(tbts_dat_o),

	.clk_b(clk),
	.rst_b(1'b0),
	.addr_b(tb_wadr),
	.di_b(tb_timstmp),
	.ce_b(1'b1),
	.we_b(tb_enw)
);

`else

assign tbia_dat_o = 32'h0000_0000;
assign tbim_dat_o = 32'h0000_0000;
assign tbar_dat_o = 32'h0000_0000;
assign tbts_dat_o = 32'h0000_0000;

`endif	// OR1200_DU_TB_IMPLEMENTED

`else	// OR1200_DU_IMPLEMENTED

//
// When DU is not implemented, drive all outputs as would when DU is disabled
//
assign dbg_bp_o = 1'b0;
assign du_dsr = {`OR1200_DU_DSR_WIDTH{1'b0}};
assign du_dmr1 = {25{1'b0}};
assign du_hwbkpt = 1'b0;

//
// Read DU registers
//
`ifdef OR1200_DU_READREGS
assign spr_dat_o = 32'h0000_0000;
`ifdef OR1200_DU_UNUSED_ZERO
`endif
`endif

`endif

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Exception logic                                    ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Handles all OR1K exceptions inside CPU block.               ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_except.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 

// synopsys translate_off
// synopsys translate_on

`define OR1200_EXCEPTFSM_WIDTH 3
`define OR1200_EXCEPTFSM_IDLE	`OR1200_EXCEPTFSM_WIDTH'd0
`define OR1200_EXCEPTFSM_FLU1 	`OR1200_EXCEPTFSM_WIDTH'd1
`define OR1200_EXCEPTFSM_FLU2 	`OR1200_EXCEPTFSM_WIDTH'd2
`define OR1200_EXCEPTFSM_FLU3 	`OR1200_EXCEPTFSM_WIDTH'd3
`define OR1200_EXCEPTFSM_FLU4 	`OR1200_EXCEPTFSM_WIDTH'd4
`define OR1200_EXCEPTFSM_FLU5 	`OR1200_EXCEPTFSM_WIDTH'd5

//
// Exception recognition and sequencing
//

module or1200_except
  (
   // Clock and reset
   clk, rst, 
   
   // Internal i/f
   sig_ibuserr, sig_dbuserr, sig_illegal, sig_align, sig_range, sig_dtlbmiss, 
   sig_dmmufault, sig_int, sig_syscall, sig_trap, sig_itlbmiss, sig_immufault, 
   sig_tick, ex_branch_taken, genpc_freeze, id_freeze, ex_freeze, wb_freeze,  
   if_stall,  if_pc, id_pc, ex_pc, wb_pc, id_flushpipe, ex_flushpipe, 
   extend_flush, except_flushpipe, except_type, except_start, except_started, 
   except_stop, except_trig, ex_void, abort_mvspr, branch_op, spr_dat_ppc, 
   spr_dat_npc, datain, du_dsr, epcr_we, eear_we, esr_we, pc_we, epcr, eear, 
   du_dmr1, du_hwbkpt, du_hwbkpt_ls_r, esr, sr_we, to_sr, sr, lsu_addr, 
   abort_ex, icpu_ack_i, icpu_err_i, dcpu_ack_i, dcpu_err_i, sig_fp, fpcsr_fpee
   
);

//
// I/O
//
input				clk;
input				rst;
input				sig_ibuserr;
input				sig_dbuserr;
input				sig_illegal;
input				sig_align;
input				sig_range;
input				sig_dtlbmiss;
input				sig_dmmufault;
input				sig_int;
input				sig_syscall;
input				sig_trap;
input				sig_itlbmiss;
input				sig_immufault;
input				sig_tick;
input   			sig_fp;
input    			fpcsr_fpee;   
input				ex_branch_taken;
input				genpc_freeze;
input				id_freeze;
input				ex_freeze;
input				wb_freeze;
input				if_stall;
input	[31:0]		if_pc;
output	[31:0]		id_pc;
output  [31:0]      ex_pc;
output  [31:0]      wb_pc;
input	[31:0]		datain;
input   [`OR1200_DU_DSR_WIDTH-1:0]     du_dsr;
input   [24:0]                       du_dmr1;
input			du_hwbkpt;
input			du_hwbkpt_ls_r;
input				epcr_we;
input				eear_we;
input				esr_we;
input				pc_we;
output	[31:0]			epcr;
output	[31:0]			eear;
output	[`OR1200_SR_WIDTH-1:0]	esr;
input	[`OR1200_SR_WIDTH-1:0]	to_sr;
input				sr_we;
input	[`OR1200_SR_WIDTH-1:0]	sr;
input	[31:0]			lsu_addr;
input              	id_flushpipe;
input              	ex_flushpipe;
output				except_flushpipe;
output				extend_flush;
output	[`OR1200_EXCEPT_WIDTH-1:0]	except_type;
output				except_start;
output				except_started;
output	[13:0]		except_stop;
output	[13:0]		except_trig;
input				ex_void;
input   [`OR1200_BRANCHOP_WIDTH-1:0]    branch_op; 
output	[31:0]			spr_dat_ppc;
output	[31:0]			spr_dat_npc;
output				abort_ex;
output              abort_mvspr;
input				icpu_ack_i;
input				icpu_err_i;
input				dcpu_ack_i;
input				dcpu_err_i;

//
// Internal regs and wires
//
reg	[`OR1200_EXCEPT_WIDTH-1:0]	except_type /* verilator public */;
reg	[31:0]			id_pc /* verilator public */;
reg                 id_pc_val;
reg	[31:0]			ex_pc /* verilator public */;
reg                 ex_pc_val;
reg	[31:0]			wb_pc /* verilator public */;
reg [31:0]          dl_pc;
reg	[31:0]			epcr;
reg	[31:0]			eear;
reg	[`OR1200_SR_WIDTH-1:0]		esr;
reg	[2:0]			id_exceptflags;
reg	[2:0]			ex_exceptflags;
reg	[`OR1200_EXCEPTFSM_WIDTH-1:0]	state;
reg				extend_flush;
reg				extend_flush_last;
reg				ex_dslot /* verilator public */;
reg				delayed1_ex_dslot;
reg				delayed2_ex_dslot;
wire				except_started;
wire				except_flushpipe /* verilator public */;
reg	[2:0]			delayed_iee;
reg	[2:0]			delayed_tee;
wire				int_pending;
wire				tick_pending;
wire    			fp_pending;
   
reg trace_trap      ;
reg ex_freeze_prev;
reg sr_ted_prev;
reg dsr_te_prev;
reg dmr1_st_prev    ;
reg dmr1_bt_prev    ;
wire dsr_te = ex_freeze_prev ? dsr_te_prev : du_dsr[`OR1200_DU_DSR_TE];
wire sr_ted = ex_freeze_prev ? sr_ted_prev : sr[`OR1200_SR_TED];
wire dmr1_st = ex_freeze_prev ? dmr1_st_prev: du_dmr1[`OR1200_DU_DMR1_ST] ;
wire dmr1_bt = ex_freeze_prev ? dmr1_bt_prev: du_dmr1[`OR1200_DU_DMR1_BT] ;

//
// Simple combinatorial logic
//
assign except_started = extend_flush & except_start;
   
assign except_start = (except_type != `OR1200_EXCEPT_NONE) & extend_flush;
   
assign int_pending = sig_int & (sr[`OR1200_SR_IEE] | 
				(sr_we & to_sr[`OR1200_SR_IEE])) 
		    & id_pc_val & delayed_iee[2] & ~ex_freeze & ~ex_branch_taken
		     & ~ex_dslot & ~(sr_we & ~to_sr[`OR1200_SR_IEE]);
   
assign tick_pending = sig_tick & (sr[`OR1200_SR_TEE] | 
				  (sr_we & to_sr[`OR1200_SR_TEE])) & id_pc_val
		      & delayed_tee[2] & ~ex_freeze & ~ex_branch_taken 
		      & ~ex_dslot & ~(sr_we & ~to_sr[`OR1200_SR_TEE]);

assign fp_pending = sig_fp & fpcsr_fpee & ~ex_freeze & ~ex_branch_taken 
		    & ~ex_dslot;
   
// Abort write into RF by load & other instructions   
assign abort_ex = sig_dbuserr | sig_dmmufault | sig_dtlbmiss | sig_align | 
		  sig_illegal | ((du_hwbkpt | trace_trap) & ex_pc_val 
				 & !sr_ted & !dsr_te);

// abort spr read/writes   
assign abort_mvspr  = sig_illegal | ((du_hwbkpt | trace_trap) & ex_pc_val 
				     & !sr_ted & !dsr_te) ; 
assign spr_dat_ppc = wb_pc;
   
assign spr_dat_npc = ex_void ? id_pc : ex_pc;

//
// Order defines exception detection priority
//
assign except_trig = {
		      ex_exceptflags[1]	& ~du_dsr[`OR1200_DU_DSR_IME],
		      ex_exceptflags[0]	& ~du_dsr[`OR1200_DU_DSR_IPFE],
		      ex_exceptflags[2]	& ~du_dsr[`OR1200_DU_DSR_BUSEE],
		      sig_illegal       & ~du_dsr[`OR1200_DU_DSR_IIE],
		      sig_align		& ~du_dsr[`OR1200_DU_DSR_AE],
		      sig_dtlbmiss	& ~du_dsr[`OR1200_DU_DSR_DME],
		      sig_trap		& ~du_dsr[`OR1200_DU_DSR_TE],
		      sig_syscall       & ~du_dsr[`OR1200_DU_DSR_SCE] & ~ex_freeze,
		      sig_dmmufault	& ~du_dsr[`OR1200_DU_DSR_DPFE],
		      sig_dbuserr	& ~du_dsr[`OR1200_DU_DSR_BUSEE],
		      sig_range		& ~du_dsr[`OR1200_DU_DSR_RE],
		      fp_pending	& ~du_dsr[`OR1200_DU_DSR_FPE],
		      int_pending 	& ~du_dsr[`OR1200_DU_DSR_IE],
		      tick_pending	& ~du_dsr[`OR1200_DU_DSR_TTE]
		      };

wire    trace_cond  = !ex_freeze && !ex_void && (1'b0
`ifdef OR1200_DU_DMR1_ST
    ||  dmr1_st
`endif
`ifdef OR1200_DU_DMR1_BT
    ||  ((branch_op != `OR1200_BRANCHOP_NOP) && (branch_op != `OR1200_BRANCHOP_RFE) && dmr1_bt)
`endif
    );

assign except_stop = {
			tick_pending		& du_dsr[`OR1200_DU_DSR_TTE],
			int_pending 		& du_dsr[`OR1200_DU_DSR_IE],
			ex_exceptflags[1]	& du_dsr[`OR1200_DU_DSR_IME],
			ex_exceptflags[0]	& du_dsr[`OR1200_DU_DSR_IPFE],
			ex_exceptflags[2]	& du_dsr[`OR1200_DU_DSR_BUSEE],
			sig_illegal		& du_dsr[`OR1200_DU_DSR_IIE],
			sig_align		& du_dsr[`OR1200_DU_DSR_AE],
			sig_dtlbmiss		& du_dsr[`OR1200_DU_DSR_DME],
			sig_dmmufault		& du_dsr[`OR1200_DU_DSR_DPFE],
			sig_dbuserr		& du_dsr[`OR1200_DU_DSR_BUSEE],
			sig_range		& du_dsr[`OR1200_DU_DSR_RE],
			sig_trap		& du_dsr[`OR1200_DU_DSR_TE],
		        fp_pending  		& du_dsr[`OR1200_DU_DSR_FPE],
			sig_syscall		& du_dsr[`OR1200_DU_DSR_SCE] & ~ex_freeze
		};

always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE) begin
		trace_trap  <=  1'b0 ;
	end 
	else if (!(trace_trap && !ex_pc_val)) begin
		trace_trap  <=  trace_cond & !dsr_te & !sr_ted ;
	end
end

always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE) begin
        ex_freeze_prev  <=  1'b0 ;
        sr_ted_prev     <=  1'b0 ;
        dsr_te_prev     <=  1'b0 ;
        dmr1_st_prev    <=  1'b0 ;
        dmr1_bt_prev    <=  1'b0 ;
    end 
    else begin
        ex_freeze_prev  <=  ex_freeze ;
        if (!ex_freeze_prev || ex_void) begin
            sr_ted_prev     <=  sr     [`OR1200_SR_TED    ] ;
            dsr_te_prev     <=  du_dsr [`OR1200_DU_DSR_TE ] ;
            dmr1_st_prev    <=  du_dmr1[`OR1200_DU_DMR1_ST] ;
            dmr1_bt_prev    <=  du_dmr1[`OR1200_DU_DMR1_BT] ;
        end
    end
end

`ifdef verilator
   // Function to access wb_pc (for Verilator). Have to hide this from
   // simulator, since functions with no inputs are not allowed in IEEE
   // 1364-2001.
   function [31:0] get_wb_pc;
      // verilator public
      get_wb_pc = wb_pc;
   endfunction // get_wb_pc

   // Function to access id_pc (for Verilator). Have to hide this from
   // simulator, since functions with no inputs are not allowed in IEEE
   // 1364-2001.
   function [31:0] get_id_pc;
      // verilator public
      get_id_pc = id_pc;
   endfunction // get_id_pc

   // Function to access ex_pc (for Verilator). Have to hide this from
   // simulator, since functions with no inputs are not allowed in IEEE
   // 1364-2001.
   function [31:0] get_ex_pc;
      // verilator public
      get_ex_pc = ex_pc;
   endfunction // get_ex_pc
   // Function to access except_type[3:0] (for Verilator). Have to hide this from
   // simulator, since functions with no inputs are not allowed in IEEE
   // 1364-2001.
   function [3:0] get_except_type;
      // verilator public
      get_except_type = except_type;
   endfunction // get_except_type
   
`endif
   
   
//
// PC and Exception flags pipelines
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE) begin
		id_pc <=  32'd0;
        id_pc_val <=  1'b0 ;
		id_exceptflags <=  3'b000;
	end
	else if (id_flushpipe) begin
        id_pc_val <=  1'b0 ;
		id_exceptflags <=  3'b000;
	end
	else if (!id_freeze) begin
		id_pc <=  if_pc;
        id_pc_val <=  1'b1 ;
		id_exceptflags <=  { sig_ibuserr, sig_itlbmiss, sig_immufault };
	end
end

//
// delayed_iee
//
// SR[IEE] should not enable interrupts right away
// when it is restored with l.rfe. Instead delayed_iee
// together with SR[IEE] enables interrupts once
// pipeline is again ready.
//
always @( posedge clk)
	if (rst == `OR1200_RST_VALUE)
		delayed_iee <=  3'b000;
	else if (!sr[`OR1200_SR_IEE])
		delayed_iee <=  3'b000;
	else
		delayed_iee <=  {delayed_iee[1:0], 1'b1};

//
// delayed_tee
//
// SR[TEE] should not enable tick exceptions right away
// when it is restored with l.rfe. Instead delayed_tee
// together with SR[TEE] enables tick exceptions once
// pipeline is again ready.
//
always @( posedge clk)
	if (rst == `OR1200_RST_VALUE)
		delayed_tee <=  3'b000;
	else if (!sr[`OR1200_SR_TEE])
		delayed_tee <=  3'b000;
	else
		delayed_tee <=  {delayed_tee[1:0], 1'b1};

//
// PC and Exception flags pipelines
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE) begin
		ex_dslot <=  1'b0;
		ex_pc <=  32'd0;
                ex_pc_val <=  1'b0 ;
		ex_exceptflags <=  3'b000;
		delayed1_ex_dslot <=  1'b0;
		delayed2_ex_dslot <=  1'b0;
	end
	else if (ex_flushpipe) begin
		ex_dslot <=  1'b0;
                ex_pc_val <=  1'b0 ;
		ex_exceptflags <=  3'b000;
		delayed1_ex_dslot <=  1'b0;
		delayed2_ex_dslot <=  1'b0;
	end
	else if (!ex_freeze & id_freeze) begin
		ex_dslot <=  1'b0;
		ex_pc <=  id_pc;
                ex_pc_val <=  id_pc_val ;
		ex_exceptflags <=  3'b000;
		delayed1_ex_dslot <=  ex_dslot;
		delayed2_ex_dslot <=  delayed1_ex_dslot;
	end
	else if (!ex_freeze) begin
		ex_dslot <=  ex_branch_taken;
		ex_pc <=  id_pc;
                ex_pc_val <=  id_pc_val ;
		ex_exceptflags <=  id_exceptflags;
		delayed1_ex_dslot <=  ex_dslot;
		delayed2_ex_dslot <=  delayed1_ex_dslot;
	end
end

//
// PC and Exception flags pipelines
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE) begin
		wb_pc <=  32'd0;
        dl_pc <=  32'd0;
	end
	else if (!wb_freeze) begin
		wb_pc <=  ex_pc;
        dl_pc <=  wb_pc;
	end
end

//
// We have started execution of exception handler:
//  1. Asserted for 3 clock cycles
//  2. Don't execute any instruction that is still in pipeline and is not part of exception handler
//
assign except_flushpipe = |except_trig & ~|state;

//
// Exception FSM that sequences execution of exception handler
//
// except_type signals which exception handler we start fetching in:
//  1. Asserted in next clock cycle after exception is recognized
//
   always @(posedge clk ) begin
      if (rst == `OR1200_RST_VALUE) begin
	 state <=  `OR1200_EXCEPTFSM_IDLE;
	 except_type <=  `OR1200_EXCEPT_NONE;
	 extend_flush <=  1'b0;
	 epcr <=  32'b0;
	 eear <=  32'b0;
	 esr <=  {2'h1, {`OR1200_SR_WIDTH-3{1'b0}}, 1'b1};
	 extend_flush_last <=  1'b0;
      end
      else begin
`ifdef OR1200_CASE_DEFAULT
	 case (state)	// synopsys parallel_case
`else
	   case (state)	// synopsys full_case parallel_case
`endif
	     `OR1200_EXCEPTFSM_IDLE:
	       if (except_flushpipe) begin
		  state <=  `OR1200_EXCEPTFSM_FLU1;
		  extend_flush <=  1'b1;
		  esr <=  sr_we ? to_sr : sr;
		  casez (except_trig)
`ifdef OR1200_EXCEPT_ITLBMISS
		    14'b1?_????_????_????: begin
		       except_type <=  `OR1200_EXCEPT_ITLBMISS;
		       eear <=  ex_dslot ? 
			       ex_pc : ex_pc;
		       epcr <=  ex_dslot ? 
			       wb_pc : ex_pc;
		    end
`endif
`ifdef OR1200_EXCEPT_IPF
		    14'b01_????_????_????: begin
		       except_type <=  `OR1200_EXCEPT_IPF;
		       eear <=  ex_dslot ? 
			       ex_pc : delayed1_ex_dslot ? 
			       id_pc : delayed2_ex_dslot ? 
			       id_pc : id_pc;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       id_pc : delayed2_ex_dslot ? 
			       id_pc : id_pc;
		    end
`endif
`ifdef OR1200_EXCEPT_BUSERR
		    14'b00_1???_????_????: begin	// Insn. Bus Error
		       except_type <=  `OR1200_EXCEPT_BUSERR;
		       eear <=  ex_dslot ? 
			       wb_pc : ex_pc;
		       epcr <=  ex_dslot ? 
			       wb_pc : ex_pc;
		    end
`endif
`ifdef OR1200_EXCEPT_ILLEGAL
		    14'b00_01??_????_????: begin
		       except_type <=  `OR1200_EXCEPT_ILLEGAL;
		       eear <=  ex_pc;
		       epcr <=  ex_dslot ? 
			       wb_pc : ex_pc;
		    end
`endif
`ifdef OR1200_EXCEPT_ALIGN
		    14'b00_001?_????_????: begin
		       except_type <=  `OR1200_EXCEPT_ALIGN;
		       eear <=  lsu_addr;
		       epcr <=  ex_dslot ? 
			       wb_pc : ex_pc;
		    end
`endif
`ifdef OR1200_EXCEPT_DTLBMISS
		    14'b00_0001_????_????: begin
		       except_type <=  `OR1200_EXCEPT_DTLBMISS;
		       eear <=  lsu_addr;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       dl_pc : ex_pc;
		    end
`endif
`ifdef OR1200_EXCEPT_TRAP			
		    14'b00_0000_1???_????: begin
		       except_type <=  `OR1200_EXCEPT_TRAP;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       id_pc : ex_pc;
		    end
`endif
`ifdef OR1200_EXCEPT_SYSCALL
		    14'b00_0000_01??_????: begin
		       except_type <=  `OR1200_EXCEPT_SYSCALL;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       id_pc : delayed2_ex_dslot ? 
			       id_pc : id_pc;
		    end
`endif
`ifdef OR1200_EXCEPT_DPF
		    14'b00_0000_001?_????: begin
		       except_type <=  `OR1200_EXCEPT_DPF;
		       eear <=  lsu_addr;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       dl_pc : ex_pc;
		    end
`endif
`ifdef OR1200_EXCEPT_BUSERR
		    14'b00_0000_0001_????: begin	// Data Bus Error
		       except_type <=  `OR1200_EXCEPT_BUSERR;
		       eear <=  lsu_addr;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       dl_pc : ex_pc;
		    end
`endif
`ifdef OR1200_EXCEPT_RANGE
		    14'b00_0000_0000_1???: begin
		       except_type <=  `OR1200_EXCEPT_RANGE;
		       epcr <=  ex_dslot ? 
			       wb_pc : delayed1_ex_dslot ? 
			       id_pc : delayed2_ex_dslot ? 
			       id_pc : id_pc;
		    end
`endif
`ifdef OR1200_EXCEPT_FLOAT
		    14'b00_0000_0000_01??: begin
		       except_type <=  `OR1200_EXCEPT_FLOAT;
		       epcr <=  id_pc;
		    end
`endif
`ifdef OR1200_EXCEPT_INT
		    14'b00_0000_0000_001?: begin
		       except_type <=  `OR1200_EXCEPT_INT;
		       epcr <=  id_pc;
		    end
`endif
`ifdef OR1200_EXCEPT_TICK
		    14'b00_0000_0000_0001: begin
		       except_type <=  `OR1200_EXCEPT_TICK;
		       epcr <=  id_pc;
		    end
`endif
		    default:
		      except_type <=  `OR1200_EXCEPT_NONE;
		  endcase
	       end
	       else if (pc_we) begin
		  state <=  `OR1200_EXCEPTFSM_FLU1;
		  extend_flush <=  1'b1;
	       end
	       else begin
		  if (epcr_we)
		    epcr <=  datain;
		  if (eear_we)
		    eear <=  datain;
		  if (esr_we)
		    esr <=  {datain[`OR1200_SR_WIDTH-1], 1'b1, datain[`OR1200_SR_WIDTH-3:0]};
	       end
	     `OR1200_EXCEPTFSM_FLU1:
	       if (icpu_ack_i | icpu_err_i | genpc_freeze)
		 state <=  `OR1200_EXCEPTFSM_FLU2;
	     `OR1200_EXCEPTFSM_FLU2:
`ifdef OR1200_EXCEPT_TRAP
	       if (except_type == `OR1200_EXCEPT_TRAP) begin
		  state <=  `OR1200_EXCEPTFSM_IDLE;
		  extend_flush <=  1'b0;
		  extend_flush_last <=  1'b0;
		  except_type <=  `OR1200_EXCEPT_NONE;
	       end
               else
`endif
		 state <=  `OR1200_EXCEPTFSM_FLU3;
	     `OR1200_EXCEPTFSM_FLU3:
	       begin
		  state <=  `OR1200_EXCEPTFSM_FLU4;
	       end
	     `OR1200_EXCEPTFSM_FLU4: begin
		state <=  `OR1200_EXCEPTFSM_FLU5;
		extend_flush <=  1'b0;
		extend_flush_last <=  1'b0; // damjan
	     end
`ifdef OR1200_CASE_DEFAULT
	     default: begin
`else
		`OR1200_EXCEPTFSM_FLU5: begin
`endif
		   if (!if_stall && !id_freeze) begin
		      state <=  `OR1200_EXCEPTFSM_IDLE;
		      except_type <=  `OR1200_EXCEPT_NONE;
		      extend_flush_last <=  1'b0;
		   end
		end
	   endcase
	 end
   end

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's FPU Wrapper                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Wrapper for floating point unit.                            ////
////  Interface based on MULT/MAC unit.                           ////
////                                                              ////
////  To Do:                                                      ////
////   - lf.rem.s and lf.madd.s instruction support               ////
////   - implement FP SPRs as needed                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009,2010 Authors and OPENCORES.ORG            ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

// synopsys translate_off
// synopsys translate_on

module or1200_fpu(
		  // Clock and reset
		  clk, rst,

		  // FPU interface
		  ex_freeze, a, b, fpu_op, result, done,

		  // Flag controls
		  flagforw, flag_we,

		  // Exception signal
		  sig_fp, except_started,

		  // FPCSR system register
		  fpcsr_we, fpcsr,
		  
		  // SPR interface -- currently unused
		  spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o
		  );

   parameter width = `OR1200_OPERAND_WIDTH;

   //
   // I/O
   //

   //
   // Clock and reset
   //
   input				clk;
   input				rst;

   //
   // FPU interface
   //
   input				ex_freeze;
   input [width-1:0] 			a;
   input [width-1:0] 			b;
   input [`OR1200_FPUOP_WIDTH-1:0] 	fpu_op;
   output [width-1:0] 			result;
   output 				done;
   
   //
   // Flag signals
   //
   output 				flagforw;
   output 				flag_we;

   //
   // FPCSR interface
   //  
   input 				fpcsr_we;   
   output [`OR1200_FPCSR_WIDTH-1:0] 	fpcsr;   

   //
   // Exception signal
   //   
   output 				sig_fp;
   input 				except_started;
   
   
   //
   // SPR interface
   //
   input				spr_cs;
   input				spr_write;
   input [31:0] 			spr_addr;
   input [31:0] 			spr_dat_i;
   output [31:0] 			spr_dat_o;


`ifndef OR1200_FPU_IMPLEMENTED
   
   // No FPU needed
   assign result = 0;
   assign flagforw  = 0;
   assign flag_we = 0;
   assign sig_fp = 0;
   assign spr_dat_o = 0;
   assign fpcsr = 0;
   assign done = 1;   
`else

   
   //
   // Internals
   //
   wire 				fpu_op_is_arith, fpu_op_is_conv, 
					fpu_op_is_comp;
   wire 				fpu_op_r_is_arith, fpu_op_r_is_conv, 
					fpu_op_r_is_comp;
   wire 				fpu_arith_done, fpu_conv_done, 
					fpu_comp_done;
   wire [width-1:0] 			result_arith, result_conv;
   
   reg [`OR1200_FPUOP_WIDTH-1:0] 	fpu_op_r;   
   reg [`OR1200_FPCSR_WIDTH-1:0] 	fpcsr_r;
   wire 				fpu_op_valid;
   reg 					fpu_op_valid_re;   
   wire 				fpu_check_op;   
   wire 				inf, inv_inf_op_in,snan, snan_in,qnan, 
					ine, overflow, underflow, zero, dbz, 
					dbz_in, mul_z_inf, nan_in;
   wire 				altb, blta, aeqb, inf_cmp, zero_cmp, 
					unordered ;
   wire 				snan_conv, ine_conv, inv_conv, 
					zero_conv, underflow_conv, 
					overflow_conv;
   wire 				inv_comp;   
   reg 					flag;

   
   assign spr_dat_o = 0;
   
   assign fpcsr = fpcsr_r;
   
   assign sig_fp = fpcsr_r[`OR1200_FPCSR_FPEE] 
	    & (|fpcsr_r[`OR1200_FPCSR_WIDTH-1:`OR1200_FPCSR_OVF]);

   // Top bit indicates FPU instruction
   assign fpu_op_valid = fpu_op[`OR1200_FPUOP_WIDTH-1];

   assign fpu_check_op = !ex_freeze & fpu_op_valid;   
      
   // Generate signals to latch fpu_op from decode instruction, then latch 
   // operands when they appear during execute stage
   
   assign fpu_op_is_arith = !(|fpu_op[3:2]);
   assign fpu_op_is_conv = fpu_op[2] & !fpu_op[3];   
   assign fpu_op_is_comp = fpu_op[3];

   assign fpu_op_r_is_arith = !(|fpu_op_r[3:2]);
   assign fpu_op_r_is_conv = fpu_op_r[2] & !fpu_op_r[3];   
   assign fpu_op_r_is_comp = fpu_op_r[3];

   assign done = (fpu_op_r_is_arith & fpu_arith_done) |
		 (fpu_op_r_is_conv & fpu_conv_done)   |
		 (fpu_op_r_is_comp & fpu_comp_done)   ;
   
   // Register fpu_op (remove FPU op valid bit [7], replace with 0)
   always @(posedge clk)
     if (fpu_check_op)
       fpu_op_r <= {1'b0,fpu_op[`OR1200_FPUOP_WIDTH-2:0]}; 

   // Indicate new FPU op
   always @(posedge clk )
     if (rst == `OR1200_RST_VALUE) 
       fpu_op_valid_re <= 0;
     else if (fpu_op_valid_re)
       fpu_op_valid_re <= 0;
     else if (fpu_check_op)
       fpu_op_valid_re <= 1;   
   
   //
   // FPCSR system group register implementation
   //   
   always @(posedge clk ) begin
      if (rst == `OR1200_RST_VALUE)
	fpcsr_r <= 0;
      else
	begin
	   if (fpcsr_we)
	     fpcsr_r <= b[`OR1200_FPCSR_WIDTH-1:0];
           else if (done)
	     begin
		fpcsr_r[`OR1200_FPCSR_OVF] <= (overflow & fpu_op_r_is_arith);
		fpcsr_r[`OR1200_FPCSR_UNF] <= (underflow & fpu_op_r_is_arith) |
					  (underflow_conv  & fpu_op_r_is_conv);
		fpcsr_r[`OR1200_FPCSR_SNF] <= (snan  & fpu_op_r_is_arith)|
					      (snan_conv & fpu_op_r_is_conv);
		fpcsr_r[`OR1200_FPCSR_QNF] <= (qnan  & fpu_op_r_is_arith);
		fpcsr_r[`OR1200_FPCSR_ZF]  <= (zero  & fpu_op_r_is_arith) | 
					      (zero_cmp & fpu_op_r_is_comp) |
					      (zero_conv & fpu_op_r_is_conv);
		fpcsr_r[`OR1200_FPCSR_IXF] <= (ine  & fpu_op_r_is_arith) |
					      (ine_conv & fpu_op_r_is_conv);
		fpcsr_r[`OR1200_FPCSR_IVF] <= 
				((snan_in | dbz_in | inv_inf_op_in | mul_z_inf) & 
					   fpu_op_r_is_arith) |
				  ((inv_conv | snan_conv) & fpu_op_r_is_conv) |
					      (inv_comp & fpu_op_r_is_comp);
		fpcsr_r[`OR1200_FPCSR_INF] <= (inf  & fpu_op_r_is_arith) | 
					      (inf_cmp & fpu_op_r_is_comp);
		fpcsr_r[`OR1200_FPCSR_DZF] <= (dbz & fpu_op_r_is_arith);
	     end // if (fpu_arith_done | fpu_conv_done)	   
	   if (except_started)
	     fpcsr_r[`OR1200_FPCSR_FPEE] <= 0;
	end // else: !if(rst)
   end // always @ (posedge clk )

   //
   // Comparison flag generation
   //
   always @*
     begin
	// Get rid of top bit - is FPU op valid bit
	case({1'b0,fpu_op_r[`OR1200_FPUOP_WIDTH-2:0]})
	  `OR1200_FPCOP_SFEQ: begin
	     flag = aeqb;
	  end
	  `OR1200_FPCOP_SFNE: begin
	     flag = !aeqb;
	       end
	  `OR1200_FPCOP_SFGT: begin
	     flag = blta & !aeqb;
	  end
	  `OR1200_FPCOP_SFGE: begin
	     flag = blta | aeqb;
	  end
	  `OR1200_FPCOP_SFLT: begin
	     flag = altb & !aeqb;
	  end
	  `OR1200_FPCOP_SFLE: begin
	     flag = altb | aeqb;
	  end
	  default: begin
	     flag = 0;
	  end
	endcase // case (fpu_op_r)
     end // always@ (posedge clk)
   
   assign flagforw = flag;
   
   // Determine here where we do the write, ie how much we pipeline the 
   // comparison
   assign flag_we = fpu_op_r_is_comp & fpu_comp_done;

   // MUX for outputs from arith and conversion modules
   assign result = fpu_op_r_is_conv ? result_conv : result_arith;   

   //
   // Instantiate FPU modules
   //
   
   // FPU 100 VHDL core from OpenCores.org: http://opencores.org/project,fpu100
   // Used only for add,sub,mul,div
   or1200_fpu_arith fpu_arith
     (
      .clk_i(clk),
      .opa_i(a),
      .opb_i(b),
      .fpu_op_i({1'b0,fpu_op_r[1:0]}), // Only bottom 2 bits
      .rmode_i(fpcsr_r[`OR1200_FPCSR_RM]),
      .output_o(result_arith),
      .start_i(fpu_op_valid_re & fpu_op_r_is_arith),
      .ready_o(fpu_arith_done),
      .ine_o(ine),
      .overflow_o(overflow),
      .underflow_o(underflow),
      .div_zero_o(dbz),
      .inf_o(inf),
      .zero_o(zero),
      .qnan_o(qnan),
      .snan_o(snan)
      );

   // Logic for detection of signaling NaN on input
   // signaling NaN: exponent is 8hff, [22] is zero, rest of fract is non-zero
   // quiet NaN: exponent is 8hff, [22] is 1
   reg a_is_snan, b_is_snan;
   reg a_is_qnan, b_is_qnan;
   
   always @(posedge clk)
     begin
	a_is_snan <= (a[30:23]==8'hff) & !a[22] & (|a[21:0]);
	b_is_snan <= (b[30:23]==8'hff) & !b[22] & (|b[21:0]);
	a_is_qnan <= (a[30:23]==8'hff) & a[22];
	b_is_qnan <= (b[30:23]==8'hff) & b[22];	
     end
   // Signal to indicate there was a signaling NaN on input
   assign snan_in = a_is_snan | b_is_snan;

   // Check for, add with opposite signed infinities, or subtract with 
   // same signed infinities.
   reg a_is_inf, b_is_inf, a_b_sign_xor;
   
   always @(posedge clk)
     begin
	a_is_inf <= (a[30:23]==8'hff) & !(|a[22:0]);
	b_is_inf <= (b[30:23]==8'hff) & !(|a[22:0]);
	a_b_sign_xor <= a[31] ^ b[31];
     end
   
   assign inv_inf_op_in = (a_is_inf & b_is_inf) & 
			  ((a_b_sign_xor & 
			    ({1'b0,fpu_op_r[`OR1200_FPUOP_WIDTH-2:0]} == 
			     `OR1200_FPUOP_ADD)) |
			   (!a_b_sign_xor & 
			    ({1'b0,fpu_op_r[`OR1200_FPUOP_WIDTH-2:0]} == 
			     `OR1200_FPUOP_SUB))) ;
   
   // Check if it's 0.0/0.0 to generate invalid signal (ignore sign bit)
   reg a_is_zero, b_is_zero;
   
   always @(posedge clk)
     begin
	a_is_zero <= !(|a[30:0]);
	b_is_zero <= !(|b[30:0]);
     end
   assign dbz_in = ({1'b0,fpu_op_r[`OR1200_FPUOP_WIDTH-2:0]} == 
		    `OR1200_FPUOP_DIV) & (a_is_zero & b_is_zero);
   
   
   assign mul_z_inf = ({1'b0,fpu_op_r[`OR1200_FPUOP_WIDTH-2:0]} == 
		       `OR1200_FPUOP_MUL) & 
		      ((a_is_zero & b_is_inf) | (b_is_zero & a_is_inf));
   
   assign nan_in = (a_is_snan | b_is_snan | a_is_qnan | b_is_qnan);

   // 32-bit integer <-> single precision floating point conversion unit
   or1200_fpu_intfloat_conv fpu_intfloat_conv
     ( 
       .clk(clk),
       .rmode(fpcsr_r[`OR1200_FPCSR_RM]),
       .fpu_op(fpu_op_r[2:0]),
       .opa(a),
       .out(result_conv),
       .snan(snan_conv),
       .ine(ine_conv),
       .inv(inv_conv),
       .overflow(overflow_conv),
       .underflow(underflow_conv),
       .zero(zero_conv)
       );

   // 5-long shift reg for conversion ready counter
   reg [6:0] fpu_conv_shr;
   always @(posedge clk)
     fpu_conv_shr <= {fpu_conv_shr[5:0],fpu_check_op & fpu_op_is_conv};
   assign fpu_conv_done = fpu_conv_shr[6];

   // Single precision floating point number comparison module
   or1200_fpu_fcmp fpu_fcmp
     (
      .opa(a), 
      .opb(b), 
      .unordered(unordered),
      // I am convinced the comparison logic is wrong way around in this 
      // module, simplest to swap them on output -- julius       
      .altb(blta), 
      .blta(altb), 
      .aeqb(aeqb), 
      .inf(inf_cmp), 
      .zero(zero_cmp));

   reg 	     fpu_op_valid_re_r;
   always @(posedge clk)
     fpu_op_valid_re_r  <= fpu_op_valid_re;
   
   assign fpu_comp_done = fpu_op_valid_re_r & fpu_op_r_is_comp;

   // Comparison invalid when sNaN in on an equal comparison, or any NaN 
   // for any other comparison.
   assign inv_comp =  (snan_in & ({1'b0,fpu_op_r[`OR1200_FPUOP_WIDTH-2:0]} 
				  == `OR1200_FPCOP_SFEQ)) | 
		      (nan_in & ({1'b0,fpu_op_r[`OR1200_FPUOP_WIDTH-2:0]} 
				 != `OR1200_FPCOP_SFEQ));
   
`endif // !`ifndef OR1200_FPU_IMPLEMENTED
   
endmodule // or1200_fpu


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_fpu_addsub                                           ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  addition/subtraction entity for the addition/subtraction    ////
////  unit                                                        ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//

module or1200_fpu_addsub(
		 clk_i,
		 fpu_op_i,
		 fracta_i,
		 fractb_i,
		 signa_i,
		 signb_i,
		 fract_o,
		 sign_o);

   
   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 0; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 11; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b1111111110000000000000000000000;
   parameter SNAN = 31'b1111111100000000000000000000001;
		 
   input clk_i;
   input fpu_op_i;   
   input [FRAC_WIDTH+4:0] fracta_i;
   input [FRAC_WIDTH+4:0] fractb_i;
   input 		  signa_i;
   input 		  signb_i;
   output reg [FRAC_WIDTH+4:0] fract_o;
   output reg 		       sign_o;
   
   wire [FRAC_WIDTH+4:0]       s_fracta_i;
   wire [FRAC_WIDTH+4:0]       s_fractb_i;
   wire [FRAC_WIDTH+4:0]       s_fract_o;
   wire 		       s_signa_i, s_signb_i, s_sign_o;   
   wire 		       s_fpu_op_i;
   
   wire 		       fracta_gt_fractb;
   wire 		       s_addop;
   
   assign s_fracta_i = fracta_i;
   assign s_fractb_i = fractb_i;
   assign s_signa_i  = signa_i;
   assign s_signb_i  = signb_i;
   assign s_fpu_op_i = fpu_op_i;
   
   always @(posedge clk_i) 
     begin
	fract_o <= s_fract_o;
	sign_o <= s_sign_o;	
     end
   
   assign fracta_gt_fractb = s_fracta_i > s_fractb_i;
   
   // check if its a subtraction or an addition operation
   assign s_addop = ((s_signa_i ^ s_signb_i) & !s_fpu_op_i) |
		    ((s_signa_i ^~ s_signb_i) & s_fpu_op_i);
   
   // sign of result
   assign s_sign_o = ((s_fract_o == 28'd0) & !(s_signa_i & s_signb_i)) ? 0 :
		     (!s_signa_i & (!fracta_gt_fractb & (fpu_op_i^s_signb_i)))|
		     (s_signa_i & (fracta_gt_fractb | (fpu_op_i^s_signb_i)));
   
   // add/substract
   assign s_fract_o = s_addop ?
		      (fracta_gt_fractb ? s_fracta_i - s_fractb_i :
		       s_fractb_i - s_fracta_i) :
		      s_fracta_i + s_fractb_i;
   
		       
endmodule // or1200_fpu_addsub





//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200 FPU arith                                            ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Wrapper for floating point arithmetic units.                ////
////                                                              ////
////  To Do:                                                      ////
////   - lf.rem.s and lf.madd.s instruction support               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//

module or1200_fpu_arith
  (
   clk_i,
   opa_i,
   opb_i,
   fpu_op_i,
   rmode_i,
   output_o,
   start_i,
   ready_o,
   ine_o,
   overflow_o,
   underflow_o,
   div_zero_o,
   inf_o,
   zero_o,
   qnan_o,
   snan_o
   );

   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 1; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 34; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b11111111_10000000000000000000000;
   parameter SNAN = 31'b11111111_00000000000000000000001;

   // fpu operations (fpu_op_i):
   // ========================
   // 000 = add, 
   // 001 = substract, 
   // 010 = multiply, 
   // 011 = divide,
   // 100 = square root - DISABLED - JPB
   // 101 = unused
   // 110 = unused
   // 111 = unused

   // Rounding Mode: 
   // ==============
   // 00 = round to nearest even (default), 
   // 01 = round to zero, 
   // 10 = round up, 
   // 11 = round down
   
   input  clk_i;
   input [FP_WIDTH-1:0] opa_i;
   input [FP_WIDTH-1:0] opb_i;
   input [2:0] 		fpu_op_i;
   input [1:0] 		rmode_i;
   input 		start_i;
   output reg 		ready_o;
   output reg [FP_WIDTH-1:0] output_o;
   output reg 		     ine_o;
   output reg 		     overflow_o;
   output reg 		     underflow_o;
   output reg 		     div_zero_o;
   output reg 		     inf_o;
   output reg 		     zero_o;
   output reg 		     qnan_o;
   output reg 		     snan_o;

   reg [FP_WIDTH-1:0] 	     s_opa_i;
   reg [FP_WIDTH-1:0] 	     s_opb_i;
   reg [2:0] 		     s_fpu_op_i;
   reg [1:0] 		     s_rmode_i;
   reg 			     s_start_i;
   reg [5:0] 		     s_count; // Max value of 64

   reg [FP_WIDTH-1:0] 	     s_output1;   
   reg [FP_WIDTH-1:0] 	     s_output_o; // Comb
   
   reg 			     s_ine_o;
   
   wire 		     s_overflow_o, 
			     s_underflow_o, 
			     s_div_zero_o, 
			     s_inf_o, s_zero_o, s_qnan_o, s_snan_o;

   wire 		     s_infa, s_infb;
   
   parameter t_state_waiting = 0,
	       t_state_busy = 1;
   
   reg 			     s_state;
   
   ////	***Add/Substract units signals***
   wire [27:0] 		     prenorm_addsub_fracta_28_o;
   wire [27:0] 		     prenorm_addsub_fractb_28_o;
   
   wire [7:0] 		     prenorm_addsub_exp_o; 
   
   wire [27:0] 		     addsub_fract_o; 
   wire 		     addsub_sign_o;
   
   wire [31:0] 		     postnorm_addsub_output_o; 
   wire 		     postnorm_addsub_ine_o;
   
   ////	***Multiply units signals***
   
   wire [9:0] 		     pre_norm_mul_exp_10;
   wire [23:0] 		     pre_norm_mul_fracta_24 ;
   wire [23:0] 		     pre_norm_mul_fractb_24 ;
   wire [47:0] 		     mul_fract_48;
   wire [47:0] 		     mul_24_fract_48;
   wire 		     mul_24_sign;   
   wire [47:0] 		     serial_mul_fract_48;
   wire 		     serial_mul_sign;   
   wire 		     mul_sign;
   wire [31:0] 		     post_norm_mul_output   ;
   wire 		     post_norm_mul_ine;
   
   
   ////	***Division units signals***
   
   wire [49:0] 		     pre_norm_div_dvdnd;
   wire [26:0] 		     pre_norm_div_dvsor;
   wire [EXP_WIDTH+1:0]      pre_norm_div_exp;   
   wire [26:0] 		     serial_div_qutnt;
   wire [26:0] 		     serial_div_rmndr;
   wire 		     serial_div_sign;   
   wire 		     serial_div_div_zero;
   wire [31:0] 		     post_norm_div_output;
   wire 		     post_norm_div_ine;
   
   
   ////	***Square units***
   
   wire [51:0] 		     pre_norm_sqrt_fracta_o;   
   wire [7:0] 		     pre_norm_sqrt_exp_o;   
   wire [25:0] 		     sqrt_sqr_o;
   wire 		     sqrt_ine_o;
   
   wire [31:0] 		     post_norm_sqrt_output  ;
   wire 		     post_norm_sqrt_ine_o;
   
   //***Add/Substract units***
   
   or1200_fpu_pre_norm_addsub fpu_prenorm_addsub
     (
      .clk_i(clk_i)  ,
      .opa_i(s_opa_i)  ,
      .opb_i(s_opb_i)  ,
      .fracta_28_o(prenorm_addsub_fracta_28_o)  ,
      .fractb_28_o(prenorm_addsub_fractb_28_o)  ,
      .exp_o(prenorm_addsub_exp_o) );
   
   or1200_fpu_addsub fpu_addsub
     (      
	    .clk_i(clk_i)  , 			
	    .fpu_op_i(s_fpu_op_i[0]),		 
	    .fracta_i(prenorm_addsub_fracta_28_o)	 ,	
	    .fractb_i(prenorm_addsub_fractb_28_o)	 ,		
	    .signa_i( s_opa_i[31]),			
	    .signb_i( s_opb_i[31]),				
	    .fract_o(addsub_fract_o)  ,			
	    .sign_o(addsub_sign_o)  );	
   
   or1200_fpu_post_norm_addsub fpu_postnorm_addsub
     (
      .clk_i(clk_i)  ,		
      .opa_i(s_opa_i)  ,
      .opb_i(s_opb_i)  ,	
      .fract_28_i(addsub_fract_o)  ,
      .exp_i(prenorm_addsub_exp_o)  ,
      .sign_i(addsub_sign_o)  ,
      .fpu_op_i(s_fpu_op_i[0]), 
      .rmode_i(s_rmode_i)  ,
      .output_o(postnorm_addsub_output_o)  ,
      .ine_o(postnorm_addsub_ine_o)  
      );
   
   //***Multiply units***
   
   or1200_fpu_pre_norm_mul fpu_pre_norm_mul
     (
      .clk_i(clk_i),
      .opa_i(s_opa_i),
      .opb_i(s_opb_i),
      .exp_10_o(pre_norm_mul_exp_10),
      .fracta_24_o(pre_norm_mul_fracta_24),
      .fractb_24_o(pre_norm_mul_fractb_24));
   /*   
    mul_24 i_mul_24 
    (
    .clk_i(clk_i)  ,
    .fracta_i(pre_norm_mul_fracta_24)  ,
    .fractb_i(pre_norm_mul_fractb_24)  ,
    .signa_i(s_opa_i[31]),
    .signb_i(s_opb_i[31]),
    .start_i(start_i)  ,
    .fract_o(mul_24_fract_48)  , 
    .sign_o(mul_24_sign) 	,
    .ready_o()  );	
    */
   // Serial multiply is default and only one included here
   or1200_fpu_mul fpu_mul
     (
      .clk_i(clk_i)  ,
      .fracta_i(pre_norm_mul_fracta_24)  ,
      .fractb_i(pre_norm_mul_fractb_24)  ,
      .signa_i(s_opa_i[31]),
      .signb_i(s_opb_i[31]),
      .start_i(s_start_i)  ,
      .fract_o(serial_mul_fract_48)  ,
      .sign_o(serial_mul_sign) 	,
      .ready_o()
      );
   
   // Serial or parallel multiplier will be chosen depending on constant 
   // MUL_SERIAL
   assign mul_fract_48 = MUL_SERIAL ? serial_mul_fract_48 : mul_24_fract_48;
   assign mul_sign = MUL_SERIAL ? serial_mul_sign : mul_24_sign;
   
   or1200_fpu_post_norm_mul fpu_post_norm_mul
     (
      .clk_i(clk_i)  ,
      .opa_i(s_opa_i)  ,
      .opb_i(s_opb_i)  ,
      .exp_10_i(pre_norm_mul_exp_10)  ,
      .fract_48_i(mul_fract_48)	 , // Parallel multiplier input
      .sign_i(mul_sign)	 , // Parallel multiplier input
      .rmode_i(s_rmode_i)  ,
      .output_o(post_norm_mul_output)  ,
      .ine_o(post_norm_mul_ine)  
      );
   
   ////***Division units***
      
   or1200_fpu_pre_norm_div fpu_pre_norm_div
     (
      .clk_i(clk_i)  ,
      .opa_i(s_opa_i)  ,
      .opb_i(s_opb_i)  ,
      .exp_10_o(pre_norm_div_exp)  ,
      .dvdnd_50_o(pre_norm_div_dvdnd)	 ,
      .dvsor_27_o(pre_norm_div_dvsor)	 );
   
   or1200_fpu_div fpu_div
     (
      .clk_i(clk_i) ,
      .dvdnd_i(pre_norm_div_dvdnd)  ,
      .dvsor_i(pre_norm_div_dvsor)  ,
      .sign_dvd_i(s_opa_i[31]),
      .sign_div_i(s_opb_i[31]),
      .start_i(s_start_i)  ,
      .ready_o()  ,
      .qutnt_o(serial_div_qutnt)  ,
      .rmndr_o(serial_div_rmndr)  ,
      .sign_o(serial_div_sign)  ,
      .div_zero_o(serial_div_div_zero)	 );
   
   or1200_fpu_post_norm_div fpu_post_norm_div
     (
      .clk_i(clk_i)  ,
      .opa_i(s_opa_i)  ,
      .opb_i(s_opb_i)  ,
      .qutnt_i(serial_div_qutnt) 	,
      .rmndr_i(serial_div_rmndr)  ,
      .exp_10_i(pre_norm_div_exp)  ,
      .sign_i(serial_div_sign)	 ,
      .rmode_i(s_rmode_i) 	,
      .output_o(post_norm_div_output)  ,
      .ine_o(post_norm_div_ine)  );
   
   //////////////////////////////////////////////////////////////////-

   // Input Registers
   always @(posedge clk_i)
     begin
	s_opa_i <= opa_i;
	s_opb_i <= opb_i;
	s_fpu_op_i <= fpu_op_i;
	s_rmode_i <= rmode_i;
	s_start_i <= start_i;
     end
   
   // Output registers
   always @(posedge clk_i)
     begin
	output_o <= s_output_o;
	ine_o <= s_ine_o;
	overflow_o <= s_overflow_o;
	underflow_o <= s_underflow_o;
	div_zero_o <= s_div_zero_o & !s_infa;
	inf_o <= s_inf_o;
	zero_o <= s_zero_o;
	qnan_o <= s_qnan_o;
	snan_o <= s_snan_o;
     end

   always @(posedge clk_i)
     begin
	if (s_start_i)  begin
	   s_state <= t_state_busy;
	   s_count <= 0;
	end
	else if (s_state == t_state_busy) begin
	   // Ready cases
	   if (((s_count == 6) & ((fpu_op_i==3'd0) | (fpu_op_i==3'd1))) |
	       ((s_count==MUL_COUNT) & (fpu_op_i==3'd2)) |
	       ((s_count==33) & (fpu_op_i==3'd3))) 
	     begin
		s_state <= t_state_waiting;
		ready_o <= 1;
		s_count <= 0;
	     end
	   else
	     s_count <= s_count + 1;
	end // if (s_state == t_state_busy)
	else begin
	   s_state <= t_state_waiting;
	   ready_o <= 0;
	end // else: !if(s_state == t_state_busy)
     end // else: !if(s_start_i)
   
   //// Output Multiplexer
   always @(posedge clk_i)
     begin
	case(fpu_op_i)
	  3'd0,
	    3'd1: begin
	       s_output1 <= postnorm_addsub_output_o;
	       s_ine_o <= postnorm_addsub_ine_o;
	    end
	  3'd2: begin
	     s_output1 <= post_norm_mul_output;
	     s_ine_o <= post_norm_mul_ine;
	  end
	  3'd3: begin
	     s_output1 <= post_norm_div_output;
	     s_ine_o <= post_norm_div_ine;
	  end
	  //	  3'd4: begin
	  //	        s_output1 	<= post_norm_sqrt_output;
	  //		s_ine_o 	<= post_norm_sqrt_ine_o;
	  //	end
	  default: begin
	     s_output1 <= 0;
	     s_ine_o <= 0;
	  end
	endcase // case (fpu_op_i)
     end // always @ (posedge clk_i)
   
   // Infinte exponent
   assign s_infa = &s_opa_i[30:23];
   assign s_infb = &s_opb_i[30:23];

   always @*
     begin
	if (s_rmode_i==2'd0 | s_div_zero_o | s_infa | s_infb | s_qnan_o |
	    s_qnan_o) // Round to nearest even
	  s_output_o = s_output1;
	else if (s_rmode_i==2'd1 & (&s_output1[30:23]))
	  // In round-to-zero: the sum of two non-infinity operands is never 
	  // infinity,even if an overflow occures
	  s_output_o = {s_output1[31], 31'b1111111_01111111_11111111_11111111};
	else if (s_rmode_i==2'd2 & (&s_output1[31:23]))
	  // In round-up: the sum of two non-infinity operands is never 
	  // negative infinity,even if an overflow occures
	  s_output_o = {32'b11111111_01111111_11111111_11111111};
	else if (s_rmode_i==2'd3) begin
	   if (((s_fpu_op_i==3'd0) | (s_fpu_op_i==3'd1)) & s_zero_o & 
	       (s_opa_i[31] | (s_fpu_op_i[0] ^ s_opb_i[31])))
	     // In round-down: a-a= -0
	     s_output_o = {1'b1,s_output1[30:0]};
	   else if (s_output1[31:23]==9'b0_11111111)
	     s_output_o = 32'b01111111011111111111111111111111;
	   else
	     s_output_o = s_output1;
	end
	else
	  s_output_o = s_output1;
     end // always @ *

   // Exception generation
   assign s_underflow_o = (s_output1[30:23]==8'h00) & s_ine_o;
   assign s_overflow_o = (s_output1[30:23]==8'hff) & s_ine_o;
   assign s_div_zero_o = serial_div_div_zero & fpu_op_i==3'd3;
   assign s_inf_o = s_output1[30:23]==8'hff & !(s_qnan_o | s_snan_o);
   assign s_zero_o = !(|s_output1[30:0]);
   assign s_qnan_o = s_output1[30:0]==QNAN;
   assign s_snan_o = s_output1[30:0]==SNAN;

endmodule // or1200_fpu_arith




//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_fpu_div                                              ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  division entity for the division unit                       ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//

module or1200_fpu_div
  (
   clk_i,
   dvdnd_i,
   dvsor_i,
   sign_dvd_i,
   sign_div_i,
   start_i,
   ready_o,
   qutnt_o,
   rmndr_o,
   sign_o,
   div_zero_o
   );

   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 0; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 11; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b1111111110000000000000000000000;
   parameter SNAN = 31'b1111111100000000000000000000001;


   input clk_i;
   input [2*(FRAC_WIDTH+2)-1:0] dvdnd_i;
   input [FRAC_WIDTH+3:0] 	dvsor_i;
   input 			sign_dvd_i;
   input 			sign_div_i;
   input 			start_i;
   output 			ready_o;
   output [FRAC_WIDTH+3:0] 	qutnt_o;
   output [FRAC_WIDTH+3:0] 	rmndr_o;
   output 			sign_o;
   output 			div_zero_o;
   
   parameter t_state_waiting = 1'b0,
	       t_state_busy = 1'b1;
   
   reg [FRAC_WIDTH+3:0] 	s_qutnt_o;
   reg [FRAC_WIDTH+3:0] 	s_rmndr_o;   
   reg [2*(FRAC_WIDTH+2)-1:0] 	s_dvdnd_i;   
   reg [FRAC_WIDTH+3:0] 	s_dvsor_i;
   reg 				s_sign_dvd_i, s_sign_div_i;
   wire 			s_sign_o;
   wire 			s_div_zero_o;
   reg 				s_start_i;
   reg 				s_ready_o;
   reg 				s_state;
   reg [4:0] 			s_count;
   reg [FRAC_WIDTH+3:0] 	s_dvd;

   // Input Register
   always @(posedge clk_i)
     begin
	s_dvdnd_i <= dvdnd_i;
	s_dvsor_i <= dvsor_i;
	s_sign_dvd_i<= sign_dvd_i;
	s_sign_div_i<= sign_div_i;
	s_start_i <= start_i;
     end
   
   assign qutnt_o = s_qutnt_o;
   assign rmndr_o = s_rmndr_o;
   assign sign_o = s_sign_o;	
   assign ready_o = s_ready_o;
   assign div_zero_o = s_div_zero_o;

   assign s_sign_o = sign_dvd_i ^ sign_div_i;
   assign s_div_zero_o = !(|s_dvsor_i) & (|s_dvdnd_i);
   

   always @(posedge clk_i)
     if (s_start_i)
       begin
	  s_state <= t_state_busy;
	  s_count <= 26;
       end
     else if (!(|s_count) & s_state==t_state_busy)
       begin
	  s_state <= t_state_waiting;
	  s_ready_o <= 1;
	  s_count <=26;
       end
     else if (s_state==t_state_busy)
       s_count <= s_count - 1;
     else
       begin
	  s_state <= t_state_waiting;
	  s_ready_o <= 0;
       end

   wire [26:0] v_div;
   assign v_div = (s_count==26) ? {3'd0,s_dvdnd_i[49:26]} : s_dvd;
   wire [26:0] v_div_minus_s_dvsor_i;
   assign v_div_minus_s_dvsor_i = v_div - s_dvsor_i;
   

   always @(posedge clk_i)
     begin
	//Reset
	if (s_start_i)
	  begin
	     s_qutnt_o <= 0;
	     s_rmndr_o <= 0;
	  end
	else if (s_state==t_state_busy)
	  begin

	     if (v_div < s_dvsor_i)
	       begin
		  s_qutnt_o[s_count] <= 1'b0;
		  s_dvd <= {v_div[25:0],1'b0};		  
	       end
	     else
	       begin
		  s_qutnt_o[s_count] <= 1'b1;
		  s_dvd <= {v_div_minus_s_dvsor_i[25:0],1'b0};		  
	       end

	     s_rmndr_o <= v_div;

	  end // if (s_state==t_state_busy)
     end // always @ (posedge clk_i)

endmodule // or1200_fpu_div



/////////////////////////////////////////////////////////////////////
////                                                             ////
////  or1200_fpu_fcmp                                            ////
////  Single precision Floating Point Compare Unit               ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000 Rudolf Usselmann                         ////
////                    rudi@asics.ws                            ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps


module or1200_fpu_fcmp(opa, opb, unordered, altb, blta, aeqb, inf, zero);

input	[31:0]	opa, opb;
output		unordered;
output		altb, blta, aeqb;
output		inf, zero;

////////////////////////////////////////////////////////////////////////
//
// Local Wire
//

reg		altb, blta, aeqb;

wire		signa, signb;
wire	[7:0]	expa, expb;
wire	[22:0]	fracta, fractb;

wire		expa_ff, expb_ff, fracta_00, fractb_00;
wire		qnan_a, snan_a, qnan_b, snan_b, opa_inf, opb_inf, inf;
wire		qnan, snan, opa_zero, opb_zero;

wire 		exp_eq, exp_gt, exp_lt;
wire 		fract_eq, fract_gt, fract_lt;
wire		all_zero;

////////////////////////////////////////////////////////////////////////
//
// Aliases
//

assign  signa = opa[31];
assign  signb = opb[31];
assign   expa = opa[30:23];
assign   expb = opb[30:23];
assign fracta = opa[22:0];
assign fractb = opb[22:0];

////////////////////////////////////////////////////////////////////////
//
// Exception Logic
//

assign expa_ff = &expa;
assign expb_ff = &expb;
	
assign fracta_00 = !(|fracta);
assign fractb_00 = !(|fractb);

assign qnan_a =  fracta[22];
assign snan_a = !fracta[22] & |fracta[21:0];
assign qnan_b =  fractb[22];
assign snan_b = !fractb[22] & |fractb[21:0];

assign opa_inf = (expa_ff & fracta_00);
assign opb_inf = (expb_ff & fractb_00);
assign inf  = opa_inf | opb_inf;

assign qnan = (expa_ff & qnan_a) | (expb_ff & qnan_b);
assign snan = (expa_ff & snan_a) | (expb_ff & snan_b);
assign unordered = qnan | snan;

assign opa_zero = !(|expa) & fracta_00;
assign opb_zero = !(|expb) & fractb_00;
assign zero = opa_zero;


////////////////////////////////////////////////////////////////////////
//
// Comparison Logic
//

assign exp_eq = expa == expb;
assign exp_gt = expa  > expb;
assign exp_lt = expa  < expb;

assign fract_eq = fracta == fractb;
assign fract_gt = fracta  > fractb;
assign fract_lt = fracta  < fractb;

assign all_zero = opa_zero & opb_zero;

always @( qnan or snan or opa_inf or opb_inf or signa or signb or exp_eq or exp_gt or
	exp_lt or fract_eq or fract_gt or fract_lt or all_zero)

	casez( {qnan, snan, opa_inf, opb_inf, signa, signb, exp_eq, exp_gt, exp_lt, fract_eq, fract_gt, fract_lt, all_zero})
	   //13'b??_??_??_???_???_?: {altb, blta, aeqb} = 3'b000;

	   13'b1?_??_??_???_???_?: {altb, blta, aeqb} = 3'b000;	// qnan
           13'b?1_??_??_???_???_?: {altb, blta, aeqb} = 3'b000;	// snan

           13'b00_11_00_???_???_?: {altb, blta, aeqb} = 3'b001;	// both op INF comparisson
           13'b00_11_01_???_???_?: {altb, blta, aeqb} = 3'b100;
           13'b00_11_10_???_???_?: {altb, blta, aeqb} = 3'b010;
           13'b00_11_11_???_???_?: {altb, blta, aeqb} = 3'b001;

           13'b00_10_00_???_???_?: {altb, blta, aeqb} = 3'b100;	// opa INF comparisson
           13'b00_10_01_???_???_?: {altb, blta, aeqb} = 3'b100;
           13'b00_10_10_???_???_?: {altb, blta, aeqb} = 3'b010;
           13'b00_10_11_???_???_?: {altb, blta, aeqb} = 3'b010;

           13'b00_01_00_???_???_?: {altb, blta, aeqb} = 3'b010;	// opb INF comparisson
           13'b00_01_01_???_???_?: {altb, blta, aeqb} = 3'b100;
           13'b00_01_10_???_???_?: {altb, blta, aeqb} = 3'b010;
           13'b00_01_11_???_???_?: {altb, blta, aeqb} = 3'b100;

           13'b00_00_10_???_???_0: {altb, blta, aeqb} = 3'b010;	//compare base on sign
           13'b00_00_01_???_???_0: {altb, blta, aeqb} = 3'b100;	//compare base on sign

           13'b00_00_??_???_???_1: {altb, blta, aeqb} = 3'b001;	//compare base on sign both are zero

           13'b00_00_00_010_???_?: {altb, blta, aeqb} = 3'b100;	// cmp exp, equal sign
           13'b00_00_00_001_???_?: {altb, blta, aeqb} = 3'b010;
           13'b00_00_11_010_???_?: {altb, blta, aeqb} = 3'b010;
           13'b00_00_11_001_???_?: {altb, blta, aeqb} = 3'b100;

           13'b00_00_00_100_010_?: {altb, blta, aeqb} = 3'b100;	// compare fractions, equal sign, equal exp
           13'b00_00_00_100_001_?: {altb, blta, aeqb} = 3'b010;
           13'b00_00_11_100_010_?: {altb, blta, aeqb} = 3'b010;
           13'b00_00_11_100_001_?: {altb, blta, aeqb} = 3'b100;

           13'b00_00_00_100_100_?: {altb, blta, aeqb} = 3'b001;
           13'b00_00_11_100_100_?: {altb, blta, aeqb} = 3'b001;

	   default: {altb, blta, aeqb} = 3'bxxx;
	endcase

endmodule // or1200_fpu_fcmp



/////////////////////////////////////////////////////////////////////
////                                                             ////
////  or1200_fpu_intfloat_conv                                   ////
////  Only conversion between 32-bit integer and single          ////
////  precision floating point format                            ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
////                                                             ////
//// Modified by Julius Baxter, July, 2010                       ////
////             julius.baxter@orsoc.se                          ////
////                                                             ////
//// TODO: Fix bug where 1.0f in round up goes to integer 2      ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000 Rudolf Usselmann                         ////
////                    rudi@asics.ws                            ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

/*

 FPU Operations (fpu_op):
 ========================

 0 = 
 1 = 
 2 = 
 3 = 
 4 = int to float
 5 = float to int
 6 =
 7 =

 Rounding Modes (rmode):
 =======================

 0 = round_nearest_even
 1 = round_to_zero
 2 = round_up
 3 = round_down

 */


module or1200_fpu_intfloat_conv
  ( 
    clk, rmode, fpu_op, opa, out, snan, ine, inv,
    overflow, underflow, zero
    );
   input		clk;
   input [1:0] 		rmode;
   input [2:0] 		fpu_op;
   input [31:0] 	opa;
   output [31:0] 	out;
   output		snan;   
   output		ine;
   output 		inv;   
   output 		overflow;
   output 		underflow;   
   output		zero;


   parameter	INF  = 31'h7f800000,
		  QNAN = 31'h7fc00001,
		  SNAN = 31'h7f800001;

   ////////////////////////////////////////////////////////////////////////
   //
   // Local Wires
   //
   reg 			zero;
   reg [31:0] 		opa_r;	// Input operand registers
   reg [31:0] 		out;		// Output register
   reg 			div_by_zero;	// Divide by zero output register
   wire [7:0] 		exp_fasu;	// Exponent output from EQU block
   reg [7:0] 		exp_r;		// Exponent output (registerd)
   wire 		co;		// carry output
   wire [30:0] 		out_d;		// Intermediate final result output
   wire 		overflow_d, underflow_d;// Overflow/Underflow
   reg 			inf, snan, qnan;// Output Registers for INF, S/QNAN
   reg 			ine;		// Output Registers for INE
   reg [1:0] 		rmode_r1, rmode_r2,// Pipeline registers for round mode
			rmode_r3;
   reg [2:0] 		fpu_op_r1, fpu_op_r2,// Pipeline registers for fp 
			                     // operation
			fpu_op_r3;

   ////////////////////////////////////////////////////////////////////////
     //
   // Input Registers
   //

   always @(posedge clk)
     opa_r <=  opa;


   always @(posedge clk)
     rmode_r1 <=  rmode;

   always @(posedge clk)
     rmode_r2 <=  rmode_r1;

   always @(posedge clk)
     rmode_r3 <=  rmode_r2;

   always @(posedge clk)
     fpu_op_r1 <=  fpu_op;

   always @(posedge clk)
     fpu_op_r2 <=  fpu_op_r1;

   always @(posedge clk)
     fpu_op_r3 <=  fpu_op_r2;

   ////////////////////////////////////////////////////////////////////////
   //
   // Exceptions block
   //
   wire 		inf_d, ind_d, qnan_d, snan_d, opa_nan;
   wire 		opa_00;   
   wire 		opa_inf;
   wire 		opa_dn;

   or1200_fpu_intfloat_conv_except u0
     (	.clk(clk),
	.opa(opa_r), 
	.opb(),
	.inf(inf_d), 
	.ind(ind_d),
	.qnan(qnan_d), 
	.snan(snan_d),
	.opa_nan(opa_nan), 
	.opb_nan(),
	.opa_00(opa_00),   
	.opb_00(),
	.opa_inf(opa_inf), 
	.opb_inf(),
	.opa_dn(opa_dn), 
	.opb_dn()
	);

   ////////////////////////////////////////////////////////////////////////
   //
   // Pre-Normalize block
   // - Adjusts the numbers to equal exponents and sorts them
   // - determine result sign
   // - determine actual operation to perform (add or sub)
   //

   wire 		nan_sign_d, result_zero_sign_d;
   reg 			sign_fasu_r;
   wire [1:0] 		exp_ovf;
   reg [1:0] 		exp_ovf_r;
  
   // This is all we need from post-norm module for int-float conversion
   reg 			opa_sign_r;
   always @(posedge clk)
     opa_sign_r <= opa_r[31];
   
   always @(posedge clk)
     sign_fasu_r <=  opa_sign_r; //sign_fasu;


   ////////////////////////////////////////////////////////////////////////
   //
   // Normalize Result
   //
   wire 		ine_d;
   wire 		inv_d;   
   wire 		sign_d;
   reg 			sign;
   reg [30:0] 		opa_r1;
   reg [47:0] 		fract_i2f;
   reg 			opas_r1, opas_r2;
   wire 		f2i_out_sign;
   wire [47:0] 		fract_denorm;

   always @(posedge clk)  // Exponent must be once cycle delayed
     case(fpu_op_r2)
       //4:	exp_r <=  0;
       5:	exp_r <=  opa_r1[30:23];
       default: exp_r <=  0;
     endcase

   always @(posedge clk)
     opa_r1 <=  opa_r[30:0];
   
   always @(posedge clk)
     fract_i2f <=  (fpu_op_r2==5) ?
		   (sign_d ?  1-{24'h00, (|opa_r1[30:23]), opa_r1[22:0]}-1 : 
		    {24'h0, (|opa_r1[30:23]), opa_r1[22:0]})
       : (sign_d ? 1 - {opa_r1, 17'h01} : {opa_r1, 17'h0});

   assign fract_denorm = fract_i2f;
   
   always @(posedge clk)
     opas_r1 <=  opa_r[31];

   always @(posedge clk)
     opas_r2 <=  opas_r1;

   assign sign_d = opa_sign_r; //sign_fasu;

   always @(posedge clk)
     sign <=  (rmode_r2==2'h3) ? !sign_d : sign_d;


   // Special case of largest negative integer we can convert to - usually
   // gets picked up as invalid, but really it's not, so deal with it as a
   // special case.
   wire 		f2i_special_case_no_inv;
   assign f2i_special_case_no_inv = (opa == 32'hcf000000);
   

   or1200_fpu_post_norm_intfloat_conv u4
     (
      .clk(clk),			// System Clock
      .fpu_op(fpu_op_r3),		// Floating Point Operation
      .opas(opas_r2),			// OPA Sign
      .sign(sign),			// Sign of the result
      .rmode(rmode_r3),		// Rounding mode
      .fract_in(fract_denorm),	// Fraction Input

      .exp_in(exp_r),			// Exponent Input
      .opa_dn(opa_dn),		// Operand A Denormalized
      .opa_nan(opa_nan),
      .opa_inf(opa_inf),
      
      .opb_dn(),		// Operand B Denormalized
      .out(out_d),		// Normalized output (un-registered)
      .ine(ine_d),		// Result Inexact output (un-registered)
      .inv(inv_d),            // Invalid input for f2i operation
      .overflow(overflow_d),	// Overflow output (un-registered)
      .underflow(underflow_d),// Underflow output (un-registered)
      .f2i_out_sign(f2i_out_sign)	// F2I Output Sign
      );

   ////////////////////////////////////////////////////////////////////////
     //
   // FPU Outputs
   //
   reg 			fasu_op_r1, fasu_op_r2;
   wire [30:0] 		out_fixed;
   wire 		output_zero_fasu;
   wire 		overflow_fasu;
   wire 		out_d_00;
   wire 		ine_fasu;
   wire 		underflow_fasu;   


   /*
    always @(posedge clk)
    fasu_op_r1 <=  fasu_op;

    always @(posedge clk)
    fasu_op_r2 <=  fasu_op_r1;
    */
   // Force pre-set values for non numerical output

   assign out_fixed = (	(qnan_d | snan_d) |
			(ind_d /*& !fasu_op_r2*/))  ? QNAN : INF;

   always @(posedge clk)
     out[30:0] <=  /*((inf_d & (fpu_op_r3!=3'b101)) | snan_d | qnan_d) 
		    & fpu_op_r3!=3'b100 ? out_fixed :*/ out_d;

   assign out_d_00 = !(|out_d);


   always @(posedge clk)
     out[31] <= (fpu_op_r3==3'b101) ? 
		f2i_out_sign : sign_fasu_r; 
   
   
   
   // Exception Outputs
   assign ine_fasu = (ine_d | overflow_d | underflow_d) & 
		     !(snan_d | qnan_d | inf_d);

   always @(posedge  clk)
     ine <= 	 fpu_op_r3[2] ? ine_d : ine_fasu;

   assign overflow = overflow_d & !(snan_d | qnan_d | inf_d);
   assign underflow = underflow_d & !(inf_d | snan_d | qnan_d);

   always @(posedge clk)
     snan <=  snan_d & (fpu_op_r3==3'b101);  // Only signal sNaN when ftoi

   // Status Outputs   
   assign output_zero_fasu = out_d_00 & !(inf_d | snan_d | qnan_d);

   always @(posedge clk)
     zero <= 	fpu_op_r3==3'b101 ? out_d_00 & !(snan_d | qnan_d) :
	     output_zero_fasu ;
   assign inv = inv_d & !f2i_special_case_no_inv;
   
endmodule // or1200_fpu_intfloat_conv


module or1200_fpu_intfloat_conv_except
  (	
	clk, opa, opb, inf, ind, qnan, snan, opa_nan, opb_nan,
	opa_00, opb_00, opa_inf, opb_inf, opa_dn, opb_dn
	);
   input		clk;
   input [31:0] 	opa, opb;
   output		inf, ind, qnan, snan, opa_nan, opb_nan;
   output		opa_00, opb_00;
   output		opa_inf, opb_inf;
   output		opa_dn;
   output		opb_dn;

   ////////////////////////////////////////////////////////////////////////
   //
   // Local Wires and registers
   //

   wire [7:0] 		expa, expb;		// alias to opX exponent
   wire [22:0] 		fracta, fractb;		// alias to opX fraction
   reg 			expa_ff, infa_f_r, qnan_r_a, snan_r_a;
   reg 			expb_ff, infb_f_r, qnan_r_b, snan_r_b;
   reg 			inf, ind, qnan, snan;	// Output registers
   reg 			opa_nan, opb_nan;
   reg 			expa_00, expb_00, fracta_00, fractb_00;
   reg 			opa_00, opb_00;
   reg 			opa_inf, opb_inf;
   reg 			opa_dn, opb_dn;

   ////////////////////////////////////////////////////////////////////////
   //
   // Aliases
   //

   assign   expa = opa[30:23];
   assign   expb = opb[30:23];
   assign fracta = opa[22:0];
   assign fractb = opb[22:0];

   ////////////////////////////////////////////////////////////////////////
   //
   // Determine if any of the input operators is a INF or NAN or any other 
   // special number
   //

   always @(posedge clk)
     expa_ff <=  &expa;

   always @(posedge clk)
     expb_ff <=  &expb;
   
   always @(posedge clk)
     infa_f_r <=  !(|fracta);

   always @(posedge clk)
     infb_f_r <=  !(|fractb);

   always @(posedge clk)
     qnan_r_a <=   fracta[22];

   always @(posedge clk)
     snan_r_a <=  !fracta[22] & |fracta[21:0];
   
   always @(posedge clk)
     qnan_r_b <=   fractb[22];

   always @(posedge clk)
     snan_r_b <=  !fractb[22]; // & |fractb[21:0];

   always @(posedge clk)
     ind  <=  (expa_ff & infa_f_r); // & (expb_ff & infb_f_r);

   always @(posedge clk)
     inf  <=  (expa_ff & infa_f_r); // | (expb_ff & infb_f_r);

   always @(posedge clk)
     qnan <=  (expa_ff & qnan_r_a); // | (expb_ff & qnan_r_b);

   always @(posedge clk)
     snan <=  (expa_ff & snan_r_a); // | (expb_ff & snan_r_b);

   always @(posedge clk)
     opa_nan <=  &expa & (|fracta[22:0]);

   always @(posedge clk)
     opb_nan <=  &expb & (|fractb[22:0]);

   always @(posedge clk)
     opa_inf <=  (expa_ff & infa_f_r);

   always @(posedge clk)
     opb_inf <=  (expb_ff & infb_f_r);

   always @(posedge clk)
     expa_00 <=  !(|expa);

   always @(posedge clk)
     expb_00 <=  !(|expb);

   always @(posedge clk)
     fracta_00 <=  !(|fracta);

   always @(posedge clk)
     fractb_00 <=  !(|fractb);

   always @(posedge clk)
     opa_00 <=  expa_00 & fracta_00;

   always @(posedge clk)
     opb_00 <=  expb_00 & fractb_00;

   always @(posedge clk)
     opa_dn <=  expa_00;

   always @(posedge clk)
     opb_dn <=  expb_00;

endmodule // or1200_fpu_intfloat_conv_except




//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_fpu_mul                                              ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Serial multiplication entity for the multiplication unit    ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//

module or1200_fpu_mul 
(  
   clk_i,
   fracta_i,
   fractb_i,
   signa_i,
   signb_i,
   start_i,
   fract_o,
   sign_o,
   ready_o
   );

   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 0; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 11; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b1111111110000000000000000000000;
   parameter SNAN = 31'b1111111100000000000000000000001;
   
   input clk_i;
   input [FRAC_WIDTH:0] fracta_i;   
   input [FRAC_WIDTH:0] fractb_i;   
   input 		signa_i;
   input 		signb_i;
   input 		start_i;
   output reg [2*FRAC_WIDTH+1:0] fract_o;
   output reg 		     sign_o;
   output reg 		     ready_o;
   
   parameter t_state_waiting = 1'b0,
	       t_state_busy = 1'b1;

   reg [47:0] 		     s_fract_o;
   reg [23:0] 		     s_fracta_i;
   reg [23:0] 		     s_fractb_i;
   reg 			     s_signa_i, s_signb_i;
   wire 		     s_sign_o;
   reg 			     s_start_i;
   reg 			     s_ready_o;
   reg 			     s_state;
   reg [4:0] 		     s_count;
   wire [23:0] 		     s_tem_prod;

   // Input Register
   always @(posedge clk_i)
     begin
	s_fracta_i <= fracta_i;
	s_fractb_i <= fractb_i;
	s_signa_i<= signa_i;
	s_signb_i<= signb_i;
	s_start_i <= start_i;
     end
   
   // Output Register
   always @(posedge clk_i)
     begin
	fract_o <= s_fract_o;
	sign_o <= s_sign_o;	
	ready_o <= s_ready_o;
     end

   assign s_sign_o = signa_i ^ signb_i;

   // FSM
   always @(posedge clk_i)
     if (s_start_i)
       begin
	  s_state <= t_state_busy;
	  s_count <= 0;
       end
     else if (s_count==23)
       begin
	  s_state <= t_state_waiting;
	  s_ready_o <= 1;
	  s_count <=0;
       end
     else if (s_state==t_state_busy)
       s_count <= s_count + 1;
     else
       begin
	  s_state <= t_state_waiting;
	  s_ready_o <= 0;
       end
   
   assign s_tem_prod[0] = s_fracta_i[0] & s_fractb_i[s_count];
   assign s_tem_prod[1] = s_fracta_i[1] & s_fractb_i[s_count];
   assign s_tem_prod[2] = s_fracta_i[2] & s_fractb_i[s_count];
   assign s_tem_prod[3] = s_fracta_i[3] & s_fractb_i[s_count];
   assign s_tem_prod[4] = s_fracta_i[4] & s_fractb_i[s_count];
   assign s_tem_prod[5] = s_fracta_i[5] & s_fractb_i[s_count];
   assign s_tem_prod[6] = s_fracta_i[6] & s_fractb_i[s_count];
   assign s_tem_prod[7] = s_fracta_i[7] & s_fractb_i[s_count];
   assign s_tem_prod[8] = s_fracta_i[8] & s_fractb_i[s_count];
   assign s_tem_prod[9] = s_fracta_i[9] & s_fractb_i[s_count];
   assign s_tem_prod[10] = s_fracta_i[10] & s_fractb_i[s_count];
   assign s_tem_prod[11] = s_fracta_i[11] & s_fractb_i[s_count];
   assign s_tem_prod[12] = s_fracta_i[12] & s_fractb_i[s_count];
   assign s_tem_prod[13] = s_fracta_i[13] & s_fractb_i[s_count];
   assign s_tem_prod[14] = s_fracta_i[14] & s_fractb_i[s_count];
   assign s_tem_prod[15] = s_fracta_i[15] & s_fractb_i[s_count];
   assign s_tem_prod[16] = s_fracta_i[16] & s_fractb_i[s_count];
   assign s_tem_prod[17] = s_fracta_i[17] & s_fractb_i[s_count];
   assign s_tem_prod[18] = s_fracta_i[18] & s_fractb_i[s_count];
   assign s_tem_prod[19] = s_fracta_i[19] & s_fractb_i[s_count];
   assign s_tem_prod[20] = s_fracta_i[20] & s_fractb_i[s_count];
   assign s_tem_prod[21] = s_fracta_i[21] & s_fractb_i[s_count];
   assign s_tem_prod[22] = s_fracta_i[22] & s_fractb_i[s_count];
   assign s_tem_prod[23] = s_fracta_i[23] & s_fractb_i[s_count];
   
   wire [47:0] v_prod_shl;
   assign v_prod_shl = {24'd0,s_tem_prod} << s_count[4:0];

   always @(posedge clk_i)
     if (s_state==t_state_busy)
       begin
	  if (|s_count)
	    s_fract_o <= v_prod_shl + s_fract_o;
	  else
	    s_fract_o <= v_prod_shl;
       end

endmodule // or1200_fpu_mul



//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_fpu_post_norm_addsub                                 ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  post-normalization entity for the addition/subtraction unit ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//

module or1200_fpu_post_norm_addsub
  (
   clk_i,
   opa_i,
   opb_i,
   fract_28_i,
   exp_i,
   sign_i,
   fpu_op_i,
   rmode_i,
   output_o,
   ine_o
   );
   
   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 0; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 11; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b1111111110000000000000000000000;
   parameter SNAN = 31'b1111111100000000000000000000001;

   input     clk_i;   
   input [FP_WIDTH-1:0] opa_i;   
   input [FP_WIDTH-1:0] opb_i;
   input [FRAC_WIDTH+4:0] fract_28_i;   
   input [EXP_WIDTH-1:0]  exp_i;
   input 		  sign_i;
   input 		  fpu_op_i;
   input [1:0] 		  rmode_i;
   output reg [FP_WIDTH-1:0] 	  output_o;
   output reg		  ine_o;
  
   wire [FP_WIDTH-1:0] 	  s_opa_i;   
   wire [FP_WIDTH-1:0] 	  s_opb_i;
   wire [FRAC_WIDTH+4:0] s_fract_28_i;	
   wire [EXP_WIDTH-1:0] s_exp_i;
   wire s_sign_i;
   wire s_fpu_op_i;
   wire [1:0] s_rmode_i;   
   wire [FP_WIDTH-1:0] s_output_o;
   wire s_ine_o;
   wire s_overflow;
   
   wire [5:0] s_zeros;
   reg [5:0] s_shr1;
   reg [5:0] s_shl1;
   wire s_shr2, s_carry;

   wire [9:0] s_exp10;
   reg [EXP_WIDTH:0] s_expo9_1;
   wire [EXP_WIDTH:0] s_expo9_2;
   wire [EXP_WIDTH:0] s_expo9_3;
   
   reg [FRAC_WIDTH+4:0] s_fracto28_1;
   wire [FRAC_WIDTH+4:0] s_fracto28_2;
   wire [FRAC_WIDTH+4:0] s_fracto28_rnd;

   wire s_roundup;
   wire s_sticky;
   
   wire s_zero_fract;	
   wire s_lost;
   wire s_infa, s_infb;
   wire s_nan_in, s_nan_op, s_nan_a, s_nan_b, s_nan_sign;
   
   assign s_opa_i = opa_i;
   assign s_opb_i = opb_i;
   assign s_fract_28_i = fract_28_i;
   assign s_exp_i = exp_i;
   assign s_sign_i = sign_i;
   assign s_fpu_op_i = fpu_op_i;
   assign s_rmode_i = rmode_i;
   
   // Output Register
   always @(posedge clk_i)
     begin
	output_o <= s_output_o;
	ine_o <= s_ine_o;
     end
   //*** Stage 1 ****
   // figure out the output exponent and how much the fraction has to be 
   // shiftd right/left
   
   assign s_carry = s_fract_28_i[27];

   reg [5:0] lzeroes;
   
   always @(s_fract_28_i)
     casez(s_fract_28_i[26:0])	// synopsys full_case parallel_case
       27'b1??????????????????????????: lzeroes = 0;
       27'b01?????????????????????????: lzeroes = 1;
       27'b001????????????????????????: lzeroes = 2;
       27'b0001???????????????????????: lzeroes = 3;
       27'b00001??????????????????????: lzeroes = 4;
       27'b000001?????????????????????: lzeroes = 5;
       27'b0000001????????????????????: lzeroes = 6;
       27'b00000001???????????????????: lzeroes = 7;
       27'b000000001??????????????????: lzeroes = 8;
       27'b0000000001?????????????????: lzeroes = 9;
       27'b00000000001????????????????: lzeroes = 10;
       27'b000000000001???????????????: lzeroes = 11;
       27'b0000000000001??????????????: lzeroes = 12;
       27'b00000000000001?????????????: lzeroes = 13;
       27'b000000000000001????????????: lzeroes = 14;
       27'b0000000000000001???????????: lzeroes = 15;
       27'b00000000000000001??????????: lzeroes = 16;
       27'b000000000000000001?????????: lzeroes = 17;
       27'b0000000000000000001????????: lzeroes = 18;
       27'b00000000000000000001???????: lzeroes = 19;
       27'b000000000000000000001??????: lzeroes = 20;
       27'b0000000000000000000001?????: lzeroes = 21;
       27'b00000000000000000000001????: lzeroes = 22;
       27'b000000000000000000000001???: lzeroes = 23;
       27'b0000000000000000000000001??: lzeroes = 24;
       27'b00000000000000000000000001?: lzeroes = 25;
       27'b000000000000000000000000001: lzeroes = 26;
       27'b000000000000000000000000000: lzeroes = 27;
     endcase

   assign s_zeros = s_fract_28_i[27] ? 0 : lzeroes;
   
   // negative flag & large flag & exp		
   assign s_exp10 = {2'd0,s_exp_i} + {9'd0,s_carry} - {4'd0,s_zeros}; 
   
   always @(posedge clk_i)
     begin
	if (s_exp10[9] | !(|s_exp10))
	  begin
	     s_shr1 <= 0;
	     s_expo9_1 <= 9'd1;
	     
	     if (|s_exp_i)
	       s_shl1 <= s_exp_i[5:0] - 6'd1;
	     else
	       s_shl1 <= 0;
	     
	  end
	else if (s_exp10[8])
	  begin
	     s_shr1 <= 0;
	     s_shl1 <= 0;
	     s_expo9_1 <= 9'b011111111;
	  end
	else
	  begin
	     s_shr1 <= {5'd0,s_carry};
	     s_shl1 <= s_zeros;
	     s_expo9_1 <= s_exp10[8:0];
	  end // else: !if(s_exp10[8])
     end // always @ (posedge clk_i)
   
   //-
   // *** Stage 2 ***
   // Shifting the fraction and rounding
   
   always @(posedge clk_i)
     if (|s_shr1)
       s_fracto28_1 <= s_fract_28_i >> s_shr1;
     else 
       s_fracto28_1 <= s_fract_28_i << s_shl1; 
   
   assign s_expo9_2 = (s_fracto28_1[27:26]==2'b00) ? 
		      s_expo9_1 - 9'd1 : s_expo9_1;
   
   // round
   //check last bit, before and after right-shift
   assign s_sticky = s_fracto28_1[0] | (s_fract_28_i[0] & s_fract_28_i[27]); 
   
   assign s_roundup = s_rmode_i==2'b00 ?
		      // round to nearset even
		      s_fracto28_1[2] & ((s_fracto28_1[1] | s_sticky) | 
					 s_fracto28_1[3]) :
		      s_rmode_i==2'b10 ?
		      // round up
		      (s_fracto28_1[2] | s_fracto28_1[1] | s_sticky) & !s_sign_i:
		      s_rmode_i==2'b11 ?
		      // round down
		      (s_fracto28_1[2] | s_fracto28_1[1] | s_sticky) & s_sign_i :
		      // round to zero(truncate = no rounding)
		      0;
   
   assign s_fracto28_rnd = s_roundup ? 
			   s_fracto28_1+28'b0000_0000_0000_0000_0000_0000_1000 :
			   s_fracto28_1;
   
   // ***Stage 3***
   // right-shift after rounding (if necessary)
   assign s_shr2 = s_fracto28_rnd[27]; 

   assign s_expo9_3 = (s_shr2 &  s_expo9_2!=9'b011111111) ?
		      s_expo9_2 + 9'b000000001 : s_expo9_2;

   assign s_fracto28_2 = s_shr2 ? {1'b0,s_fracto28_rnd[27:1]} : s_fracto28_rnd;

   ////-
   
   assign s_infa = &s_opa_i[30:23];
   assign s_infb = &s_opb_i[30:23];
   
   assign s_nan_a = s_infa &  (|s_opa_i[22:0]);
   assign s_nan_b = s_infb &  (|s_opb_i[22:0]);
   
   assign s_nan_in = s_nan_a | s_nan_b;

   // inf-inf=Nan
   assign s_nan_op = (s_infa & s_infb) & 
		     (s_opa_i[31] ^ (s_fpu_op_i ^ s_opb_i[31]));
   
   assign s_nan_sign = (s_nan_a & s_nan_b) ? s_sign_i :
		       s_nan_a ? 
		       s_opa_i[31] : s_opb_i[31];
   								
   // check if result is inexact;
   assign s_lost = (s_shr1[0] & s_fract_28_i[0]) | 
		   (s_shr2 & s_fracto28_rnd[0]) | (|s_fracto28_2[2:0]);

   assign s_ine_o = (s_lost | s_overflow) & !(s_infa | s_infb);
   
   assign s_overflow = s_expo9_3==9'b011111111 & !(s_infa | s_infb);

   // '1' if fraction result is zero
   assign s_zero_fract = s_zeros==27 & !s_fract_28_i[27];
   

   // Generate result
   assign s_output_o = (s_nan_in | s_nan_op) ?
		       {s_nan_sign,QNAN} :
		       (s_infa | s_infb) | s_overflow ?
		       {s_sign_i,INF} :
		       s_zero_fract ?
		       {s_sign_i,ZERO_VECTOR} :
		       {s_sign_i,s_expo9_3[7:0],s_fracto28_2[25:3]};

endmodule // or1200_fpu_post_norm_addsub




//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_fpu_post_norm_div                                    ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  post-normalization entity for the division unit             ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//


module or1200_fpu_post_norm_div
  (
   clk_i,
   opa_i,
   opb_i,
   qutnt_i,
   rmndr_i,
   exp_10_i,
   sign_i,
   rmode_i,
   output_o,
   ine_o
   );

   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 0; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 11; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b1111111110000000000000000000000;
   parameter SNAN = 31'b1111111100000000000000000000001;
   
   input clk_i;
   input [FP_WIDTH-1:0] opa_i;
   input [FP_WIDTH-1:0] opb_i;
   input [FRAC_WIDTH+3:0] qutnt_i;
   input [FRAC_WIDTH+3:0] rmndr_i;
   input [EXP_WIDTH+1:0]  exp_10_i;
   input 		  sign_i;
   input [1:0] 		  rmode_i;
   output reg [FP_WIDTH-1:0] output_o;
   output reg 		     ine_o;
   
   // input&output register wires
   reg [FP_WIDTH-1:0] 	     s_opa_i;
   reg [FP_WIDTH-1:0] 	     s_opb_i;
   reg [EXP_WIDTH-1:0] 	     s_expa;
   reg [EXP_WIDTH-1:0] 	     s_expb;
   reg [FRAC_WIDTH+3:0]      s_qutnt_i;
   reg [FRAC_WIDTH+3:0]      s_rmndr_i;
   reg [5:0] 		     s_r_zeros;
   reg [EXP_WIDTH+1:0] 	     s_exp_10_i;
   reg 			     s_sign_i;
   reg [1:0] 		     s_rmode_i;
   wire [FP_WIDTH-1:0] 	     s_output_o;
   
   wire 		     s_ine_o, s_overflow;
   wire 		     s_opa_dn, s_opb_dn;
   wire 		     s_qutdn;
   wire [9:0] 		     s_exp_10b;
   reg [5:0] 		     s_shr1;
   reg [5:0] 		     s_shl1;
   wire 		     s_shr2;
   reg [8:0] 		     s_expo1;
   wire [8:0] 		     s_expo2;
   reg [8:0] 		     s_expo3;
   reg [26:0] 		     s_fraco1;
   wire [24:0] 		     s_frac_rnd;
   reg [24:0] 		     s_fraco2;
   wire 		     s_guard, s_round, s_sticky, s_roundup;
   wire 		     s_lost;
   wire 		     s_op_0, s_opab_0, s_opb_0;
   wire 		     s_infa, s_infb;
   wire 		     s_nan_in, s_nan_op, s_nan_a, s_nan_b;
   wire 		     s_inf_result;
   
   always @(posedge clk_i)
     begin
	s_opa_i <= opa_i;
	s_opb_i <= opb_i;	
	s_expa <= opa_i[30:23];
	s_expb <= opb_i[30:23];
	s_qutnt_i <= qutnt_i;
	s_rmndr_i <= rmndr_i;
	s_exp_10_i <= exp_10_i;			
	s_sign_i <= sign_i;
	s_rmode_i <= rmode_i;
     end

   // Output Register
   always @(posedge clk_i)
     begin
	output_o <= s_output_o;
	ine_o	<= s_ine_o;
     end

    // qutnt_i
    // 26 25                    3
    // |  |                     | 
    // h  fffffffffffffffffffffff grs

   //*** Stage 1 ****
   // figure out the exponent and how far the fraction has to be shifted 
   // right or left
	
   assign s_opa_dn = !(|s_expa) & (|opa_i[22:0]);
   assign s_opb_dn = !(|s_expb) & (|opb_i[22:0]);
   
   assign s_qutdn =  !s_qutnt_i[26];

   assign s_exp_10b = s_exp_10_i - {9'd0,s_qutdn};
   
   wire [9:0] v_shr;
   wire [9:0] v_shl;
   
   assign v_shr = (s_exp_10b[9] | !(|s_exp_10b)) ?
		   (10'd1 - s_exp_10b) - {9'd0,s_qutdn} : 0;
         
   assign v_shl = (s_exp_10b[9] | !(|s_exp_10b)) ?
		   0 :
		   s_exp_10b[8] ?   
		   0 : {9'd0,s_qutdn};

   always @(posedge clk_i)
     if (s_exp_10b[9] | !(|s_exp_10b))
       s_expo1 <= 9'd1;
     else
       s_expo1 <= s_exp_10b[8:0];

   always @(posedge clk_i)
     s_shr1 <= v_shr[6] ? 6'b111111 : v_shr[5:0];

   always @(posedge clk_i)
     s_shl1 <= v_shl[5:0];
   
   // *** Stage 2 ***
   // Shifting the fraction and rounding
   
   // shift the fraction
   always @(posedge clk_i)
     if (|s_shr1)
       s_fraco1 <= s_qutnt_i >> s_shr1;
     else
       s_fraco1 <= s_qutnt_i << s_shl1;
	
   assign s_expo2 = s_fraco1[26] ? s_expo1 : s_expo1 - 9'd1;
   
   //s_r_zeros <= count_r_zeros(s_qutnt_i);
   always @(s_qutnt_i)
     casez(s_qutnt_i) // synopsys full_case parallel_case
       27'b??????????????????????????1: s_r_zeros = 0;
       27'b?????????????????????????10: s_r_zeros = 1;
       27'b????????????????????????100: s_r_zeros = 2;
       27'b???????????????????????1000: s_r_zeros = 3;
       27'b??????????????????????10000: s_r_zeros = 4;
       27'b?????????????????????100000: s_r_zeros = 5;
       27'b????????????????????1000000: s_r_zeros = 6;
       27'b???????????????????10000000: s_r_zeros = 7;
       27'b??????????????????100000000: s_r_zeros = 8;
       27'b?????????????????1000000000: s_r_zeros = 9;
       27'b????????????????10000000000: s_r_zeros = 10;
       27'b???????????????100000000000: s_r_zeros = 11;
       27'b??????????????1000000000000: s_r_zeros = 12;
       27'b?????????????10000000000000: s_r_zeros = 13;
       27'b????????????100000000000000: s_r_zeros = 14;
       27'b???????????1000000000000000: s_r_zeros = 15;
       27'b??????????10000000000000000: s_r_zeros = 16;
       27'b?????????100000000000000000: s_r_zeros = 17;
       27'b????????1000000000000000000: s_r_zeros = 18;
       27'b???????10000000000000000000: s_r_zeros = 19;
       27'b??????100000000000000000000: s_r_zeros = 20;
       27'b?????1000000000000000000000: s_r_zeros = 21;
       27'b????10000000000000000000000: s_r_zeros = 22;
       27'b???100000000000000000000000: s_r_zeros = 23;
       27'b??1000000000000000000000000: s_r_zeros = 24;
       27'b?10000000000000000000000000: s_r_zeros = 25;
       27'b100000000000000000000000000: s_r_zeros = 26;
       27'b000000000000000000000000000: s_r_zeros = 27;
     endcase // casex (s_qutnt_i)
   
   assign s_lost = (s_shr1+{5'd0,s_shr2}) > s_r_zeros;
   
   // ***Stage 3***
   // Rounding
   
   assign s_guard = s_fraco1[2];
   assign s_round = s_fraco1[1];
   assign s_sticky = s_fraco1[0] | (|s_rmndr_i);

   assign s_roundup = s_rmode_i==2'b00 ? // round to nearest even
		      s_guard & ((s_round | s_sticky) | s_fraco1[3]) :
		      s_rmode_i==2'b10 ? // round up
		      (s_guard | s_round | s_sticky) & !s_sign_i :
		      s_rmode_i==2'b11 ? // round down
		      (s_guard | s_round | s_sticky) & s_sign_i : 
		      0; // round to zero(truncate = no rounding)

   assign s_frac_rnd = s_roundup ?{1'b0,s_fraco1[26:3]} + 1 : 
		       {1'b0,s_fraco1[26:3]};
   assign s_shr2 = s_frac_rnd[24];

   always @(posedge clk_i)
     begin
	s_expo3 <= s_shr2 ? s_expo2 + "1" : s_expo2;
	s_fraco2 <= s_shr2 ? {1'b0,s_frac_rnd[24:1]} : s_frac_rnd;
     end
   //
   // ***Stage 4****
   // Output
		
   assign s_op_0 = !((|s_opa_i[30:0]) & (|s_opb_i[30:0]));

   assign s_opab_0 = !((|s_opa_i[30:0]) | (|s_opb_i[30:0]));

   assign s_opb_0 = !(|s_opb_i[30:0]);
	
   assign s_infa = &s_expa;
   
   assign s_infb = &s_expb;
      
   assign s_nan_a = s_infa & (|s_opa_i[22:0]);
   
   assign s_nan_b = s_infb & (|s_opb_i[22:0]);
   
   assign s_nan_in = s_nan_a | s_nan_b;
   
   assign s_nan_op = (s_infa & s_infb) | s_opab_0; // 0 / 0, inf / inf

   assign s_inf_result = (&s_expo3[7:0]) | s_expo3[8] | s_opb_0;

   assign s_overflow =  s_inf_result & !(s_infa) & !s_opb_0;
   
   assign s_ine_o =  !s_op_0 & 
		     (s_lost | (|s_fraco1[2:0]) | s_overflow | (|s_rmndr_i));
   	
   assign s_output_o = (s_nan_in | s_nan_op) ?
		       {s_sign_i,QNAN} :
		       s_infa  | s_overflow | s_inf_result ?
		       {s_sign_i,INF} :
		       s_op_0 | s_infb ?
		       {s_sign_i,ZERO_VECTOR} :
		       {s_sign_i,s_expo3[7:0],s_fraco2[22:0]};

endmodule // or1200_fpu_post_norm_div


  

/////////////////////////////////////////////////////////////////////
////                                                             ////
////  or1200_fpu_post_norm_intfloat_conv                         ////
////  Floating Point Post Normalisation Unit                     ////
////                                                             ////
////  Author: Rudolf Usselmann                                   ////
////          rudi@asics.ws                                      ////
//// Modified by Julius Baxter, July, 2010                       ////
////             julius.baxter@orsoc.se                          ////
////                                                             ////
/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2000 Rudolf Usselmann                         ////
////                    rudi@asics.ws                            ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module or1200_fpu_post_norm_intfloat_conv 
  ( 
    clk, fpu_op, opas, sign, rmode, fract_in, 
    exp_in, opa_dn, opa_nan, opa_inf, opb_dn,  out,
    ine, inv, overflow, underflow, f2i_out_sign
    );
   input		clk;
   input [2:0] 		fpu_op;
   input		opas;
   input		sign;
   input [1:0] 		rmode;
   input [47:0] 	fract_in;
   input [7:0] 		exp_in;
   input		opa_dn, opb_dn;
   input 		opa_nan, opa_inf;
   
   output [30:0] 	out;
   output		ine, inv;
   output		overflow, underflow;
   output		f2i_out_sign;

   ////////////////////////////////////////////////////////////////////////
   //
   // Local Wires and registers
   //

   /*wire*/ reg [22:0] 		fract_out;
   /*wire*/reg [7:0] 		exp_out;
   wire [30:0] 		out;
   wire 		exp_out1_co, overflow, underflow;
   wire [22:0] 		fract_out_final;
   reg [22:0] 		fract_out_rnd;
   wire [8:0] 		exp_next_mi;
   wire 		dn;
   wire 		exp_rnd_adj;
   wire [7:0] 		exp_out_final;
   reg [7:0] 		exp_out_rnd;
   wire 		op_dn = opa_dn | opb_dn;
   wire 		op_mul = fpu_op[2:0]==3'b010;
   wire 		op_div = fpu_op[2:0]==3'b011;
   wire 		op_i2f = fpu_op[2:0]==3'b100;
   wire 		op_f2i = fpu_op[2:0]==3'b101;
   reg [5:0] 		fi_ldz;

   wire 		g, r, s;
   wire 		round, round2, round2a, round2_fasu, round2_fmul;
   wire [7:0] 		exp_out_rnd0, exp_out_rnd1, exp_out_rnd2, exp_out_rnd2a;
   wire [22:0] 		fract_out_rnd0, fract_out_rnd1, fract_out_rnd2, 
			fract_out_rnd2a;
   wire 		exp_rnd_adj0, exp_rnd_adj2a;
   wire 		r_sign;
   wire 		ovf0, ovf1;
   wire [23:0] 		fract_out_pl1;
   wire [7:0] 		exp_out_pl1, exp_out_mi1;
   wire 		exp_out_00, exp_out_fe, exp_out_ff, exp_in_00, 
			exp_in_ff;
   wire 		exp_out_final_ff, fract_out_7fffff;
   /*wire*/reg [24:0] 		fract_trunc;
   wire [7:0] 		exp_out1;
   wire 		grs_sel;
   wire 		fract_out_00;
   reg 			fract_in_00;
   wire 		shft_co;
   wire [8:0] 		exp_in_pl1, exp_in_mi1;
   wire [47:0] 		fract_in_shftr;
   wire [47:0] 		fract_in_shftl;

   wire [7:0] 		shft2;
   wire [7:0] 		exp_out1_mi1;

   wire [6:0] 		fi_ldz_2a;
   wire [7:0] 		fi_ldz_2;

   wire 		left_right;   
   wire [7:0] 		shift_right;
   wire [7:0] 		shift_left;   
   wire [7:0] 		fasu_shift;

   wire [5:0] 		fi_ldz_mi1;
   wire [5:0] 		fi_ldz_mi22;
   wire [6:0] 		ldz_all;

   wire [7:0] 		f2i_shft;
   wire [55:0] 		exp_f2i_1;
   wire 		f2i_zero, f2i_max;
   wire [7:0] 		f2i_emin;
   wire 		f2i_exp_gt_max ,f2i_exp_lt_min;
   wire [7:0] 		conv_shft;
   wire [7:0] 		exp_i2f, exp_f2i, conv_exp;
   wire 		round2_f2i;

   ////////////////////////////////////////////////////////////////////////
   //
   // Normalize and Round Logic
   //

   // ---------------------------------------------------------------------
   // Count Leading zeros in fraction

   always @(/*fract_in*/ posedge clk)
     casez(fract_in)	// synopsys full_case parallel_case
       48'b1???????????????????????????????????????????????: fi_ldz <=  1;
       48'b01??????????????????????????????????????????????: fi_ldz <=  2;
       48'b001?????????????????????????????????????????????: fi_ldz <=  3;
       48'b0001????????????????????????????????????????????: fi_ldz <=  4;
       48'b00001???????????????????????????????????????????: fi_ldz <=  5;
       48'b000001??????????????????????????????????????????: fi_ldz <=  6;
       48'b0000001?????????????????????????????????????????: fi_ldz <=  7;
       48'b00000001????????????????????????????????????????: fi_ldz <=  8;
       48'b000000001???????????????????????????????????????: fi_ldz <=  9;
       48'b0000000001??????????????????????????????????????: fi_ldz <=  10;
       48'b00000000001?????????????????????????????????????: fi_ldz <=  11;
       48'b000000000001????????????????????????????????????: fi_ldz <=  12;
       48'b0000000000001???????????????????????????????????: fi_ldz <=  13;
       48'b00000000000001??????????????????????????????????: fi_ldz <=  14;
       48'b000000000000001?????????????????????????????????: fi_ldz <=  15;
       48'b0000000000000001????????????????????????????????: fi_ldz <=  16;
       48'b00000000000000001???????????????????????????????: fi_ldz <=  17;
       48'b000000000000000001??????????????????????????????: fi_ldz <=  18;
       48'b0000000000000000001?????????????????????????????: fi_ldz <=  19;
       48'b00000000000000000001????????????????????????????: fi_ldz <=  20;
       48'b000000000000000000001???????????????????????????: fi_ldz <=  21;
       48'b0000000000000000000001??????????????????????????: fi_ldz <=  22;
       48'b00000000000000000000001?????????????????????????: fi_ldz <=  23;
       48'b000000000000000000000001????????????????????????: fi_ldz <=  24;
       48'b0000000000000000000000001???????????????????????: fi_ldz <=  25;
       48'b00000000000000000000000001??????????????????????: fi_ldz <=  26;
       48'b000000000000000000000000001?????????????????????: fi_ldz <=  27;
       48'b0000000000000000000000000001????????????????????: fi_ldz <=  28;
       48'b00000000000000000000000000001???????????????????: fi_ldz <=  29;
       48'b000000000000000000000000000001??????????????????: fi_ldz <=  30;
       48'b0000000000000000000000000000001?????????????????: fi_ldz <=  31;
       48'b00000000000000000000000000000001????????????????: fi_ldz <=  32;
       48'b000000000000000000000000000000001???????????????: fi_ldz <=  33;
       48'b0000000000000000000000000000000001??????????????: fi_ldz <=  34;
       48'b00000000000000000000000000000000001?????????????: fi_ldz <=  35;
       48'b000000000000000000000000000000000001????????????: fi_ldz <=  36;
       48'b0000000000000000000000000000000000001???????????: fi_ldz <=  37;
       48'b00000000000000000000000000000000000001??????????: fi_ldz <=  38;
       48'b000000000000000000000000000000000000001?????????: fi_ldz <=  39;
       48'b0000000000000000000000000000000000000001????????: fi_ldz <=  40;
       48'b00000000000000000000000000000000000000001???????: fi_ldz <=  41;
       48'b000000000000000000000000000000000000000001??????: fi_ldz <=  42;
       48'b0000000000000000000000000000000000000000001?????: fi_ldz <=  43;
       48'b00000000000000000000000000000000000000000001????: fi_ldz <=  44;
       48'b000000000000000000000000000000000000000000001???: fi_ldz <=  45;
       48'b0000000000000000000000000000000000000000000001??: fi_ldz <=  46;
       48'b00000000000000000000000000000000000000000000001?: fi_ldz <=  47;
       48'b00000000000000000000000000000000000000000000000?: fi_ldz <=  48;
     endcase


   // ---------------------------------------------------------------------
   // Normalize

   wire 		exp_in_80;
   wire 		rmode_00, rmode_01, rmode_10, rmode_11;

   // Misc common signals
   assign exp_in_ff        = &exp_in;
   assign exp_in_00        = !(|exp_in);
   assign exp_in_80	= exp_in[7] & !(|exp_in[6:0]);
   assign exp_out_ff       = &exp_out;
   assign exp_out_00       = !(|exp_out);
   assign exp_out_fe       = &exp_out[7:1] & !exp_out[0];
   assign exp_out_final_ff = &exp_out_final;

   assign fract_out_7fffff = &fract_out;
   assign fract_out_00     = !(|fract_out);
   //assign fract_in_00      = !(|fract_in);
   always @(posedge clk)
     fract_in_00  <= !(|fract_in);

   assign rmode_00 = (rmode==2'b00);
   assign rmode_01 = (rmode==2'b01);
   assign rmode_10 = (rmode==2'b10);
   assign rmode_11 = (rmode==2'b11);

   // Fasu Output will be denormalized ...
   assign dn = !op_mul & !op_div & 
	       (exp_in_00 | (exp_next_mi[8] & !fract_in[47]) );

   // ---------------------------------------------------------------------
   // Fraction Normalization
   parameter	f2i_emax = 8'h9d;

   // Special Signals for f2i
   assign f2i_emin = rmode_00 ? 8'h7e : 8'h7f;
   
   assign f2i_exp_gt_max = (exp_in > f2i_emax);
   assign f2i_exp_lt_min = (exp_in < f2i_emin);
   
   // Incremented fraction for rounding
   assign fract_out_pl1 = fract_out + 1;

   /*
    assign f2i_zero = (!opas & (exp_in<f2i_emin)) | 
    (opas & (exp_in>f2i_emax)) | 
    (opas & (exp_in<f2i_emin) & (fract_in_00 | !rmode_11));

    assign f2i_max = (!opas & (exp_in>f2i_emax)) | 
    (opas & (exp_in<f2i_emin) & !fract_in_00 & rmode_11);
    */
   // Zero when :
   // a) too small exp. and positive sign - result will be 0
   // b) too big exp. and negative sign - result will be largest possible -int
   // c) -infinity: largest possible -int
   // d) -0.0: give positive 0
   assign f2i_zero = (
		      ( (f2i_exp_lt_min & (opas & (!rmode_11 | fract_in_00))) |
			(f2i_exp_lt_min & !opas) |
			(f2i_exp_gt_max & opas) )
		      & !(&exp_in)
		      ) |
		     // -inf case
		     (opa_inf & opas) |
		       // -0.0 case
		       (fract_in_00 & exp_in_00);

   // Maximum :
   // a) too big exp and positive sign - result will be maximum int.
   // b) rounding negative down and less than minimum expon. for int = -1
   // c) +/- NaN or +inf - result will be maximum int
   // d) disabled when the -0.0 case comes up
   assign f2i_max = (
		     ( ((!opas & f2i_exp_gt_max) | 
			(f2i_exp_lt_min & !fract_in_00 & rmode_11 & opas)) 
		       & !(&exp_in)) |
		     // Either +/- NaN, or +inf
		     (opa_nan | (opa_inf & !opas))) &
		    // .. and NOT -0.0( 0x80000000)
                    !(opas & fract_in_00 & exp_in_00);
   
   // Claculate various shifting options
   assign f2i_shft  = exp_in-8'h7d;

   assign conv_shft = op_f2i ? f2i_shft : {2'h0, fi_ldz};

   assign fract_in_shftl   = (|conv_shft[7:6] | (f2i_zero & op_f2i)) ? 
			     0 : fract_in<<conv_shft[5:0];

   // Final fraction output
   always @(posedge clk)
     {fract_out,fract_trunc} <= fract_in_shftl;
   

   // ---------------------------------------------------------------------
   // Exponent Normalization

   assign fi_ldz_mi1    = fi_ldz - 1;
   assign fi_ldz_mi22   = fi_ldz - 22;
   assign exp_out_pl1   = exp_out + 1;
   assign exp_out_mi1   = exp_out - 1;
   assign exp_in_pl1    = exp_in  + 1;	// 9 bits - includes carry out
   assign exp_in_mi1    = exp_in  - 1;	// 9 bits - includes carry out
   assign exp_out1_mi1  = exp_out1 - 1;

   assign exp_next_mi  = exp_in_pl1 - 
			 {3'd0,fi_ldz_mi1}; // 9 bits - includes carry out

   assign {exp_out1_co, exp_out1} = fract_in[47] ? exp_in_pl1 : exp_next_mi;
   
   // Only ever force positive if:
   // i) It's a NaN
   // ii) It's zero and not -inf
   // iii) We've rounded to 0 (both fract and exp out are 0 and not forced)
   // Force to 1 (negative) when have negative sign with too big exponent
   assign f2i_out_sign = (opas & (exp_in>f2i_emax) & f2i_zero) ?
			 1 : opa_nan | (f2i_zero & !f2i_max & !(opa_inf & opas))
			   | (!(|out) & !f2i_zero)
			     ? 
			 0 :opas;

   assign exp_i2f   = fract_in_00 ? (opas ? 8'h9e : 0) : (8'h9e-{2'd0,fi_ldz});
   assign exp_f2i_1 = {{8{fract_in[47]}}, fract_in }<<f2i_shft;
   assign exp_f2i   = f2i_zero ? 0 : f2i_max ? 8'hff : exp_f2i_1[55:48];
   assign conv_exp  = op_f2i ? exp_f2i : exp_i2f;

   //assign exp_out = conv_exp;
   always @(posedge clk)
     exp_out <= conv_exp;
   

   assign ldz_all   = {1'b0,fi_ldz};
   assign fi_ldz_2a = 6'd23 - fi_ldz;
   assign fi_ldz_2  = {fi_ldz_2a[6], fi_ldz_2a[6:0]};


   // ---------------------------------------------------------------------
   // Round

   // Extract rounding (GRS) bits
   assign g = fract_out[0];
   assign r = fract_trunc[24];
   assign s = |fract_trunc[23:0];

   // Round to nearest even
   assign round = (g & r) | (r & s) ;
   assign {exp_rnd_adj0, fract_out_rnd0} = round ? 
					   fract_out_pl1 : {1'b0, fract_out};
   
   assign exp_out_rnd0 =  exp_rnd_adj0 ? exp_out_pl1 : exp_out;
   
   assign ovf0 = exp_out_final_ff & !rmode_01 & !op_f2i;

   // round to zero
   // Added detection of sign and rounding up in case of negative ftoi! - JPB
   assign fract_out_rnd1 = (exp_out_ff  & !dn & !op_f2i) ? 
			   23'h7fffff : 
			   (op_f2i & (|fract_trunc) & opas) ? 
			   fract_out_pl1[22:0] : fract_out ;

   assign exp_out_rnd1 = (g & r & s & exp_in_ff) ? 
			 exp_next_mi[7:0] : (exp_out_ff & !op_f2i) ? 
			 exp_in : 
			 (op_f2i & opas & (|fract_trunc) & fract_out_pl1[23]) ? 
			 exp_out_pl1: exp_out;

   assign ovf1 = exp_out_ff & !dn;

   // round to +inf (UP) and -inf (DOWN)
   assign r_sign = sign;

   assign round2a = !exp_out_fe | !fract_out_7fffff | 
		    (exp_out_fe & fract_out_7fffff);

   assign round2_fasu = ((r | s) & !r_sign) & (!exp_out[7] | 
					       (exp_out[7] & round2a));

   assign round2_f2i = rmode_10 & 
		       (( |fract_in[23:0] & !opas & (exp_in<8'h80 )) | 
			(|fract_trunc));
   
   assign round2 = op_f2i ? round2_f2i : round2_fasu;

   assign {exp_rnd_adj2a, fract_out_rnd2a} = round2 ? fract_out_pl1 : 
					     {1'b0, fract_out};
   
   assign exp_out_rnd2a  = exp_rnd_adj2a ?  exp_out_pl1 : exp_out;

   assign fract_out_rnd2 = (r_sign & exp_out_ff & !op_div & !dn & !op_f2i) ? 
			   23'h7fffff : fract_out_rnd2a;
   
   assign exp_out_rnd2   = (r_sign & exp_out_ff & !op_f2i) ? 
			   8'hfe      : exp_out_rnd2a;


   // Choose rounding mode
   always @(rmode or exp_out_rnd0 or exp_out_rnd1 or exp_out_rnd2)
     case(rmode)	// synopsys full_case parallel_case
       0: exp_out_rnd = exp_out_rnd0;
       1: exp_out_rnd = exp_out_rnd1;
       2,3: exp_out_rnd = exp_out_rnd2;
     endcase

   always @(rmode or fract_out_rnd0 or fract_out_rnd1 or fract_out_rnd2)
     case(rmode)	// synopsys full_case parallel_case
       0: fract_out_rnd = fract_out_rnd0;
       1: fract_out_rnd = fract_out_rnd1;
       2,3: fract_out_rnd = fract_out_rnd2;
     endcase
   
   // ---------------------------------------------------------------------
   // Final Output Mux
   // Fix Output for denormalized and special numbers

   assign fract_out_final = ovf0 ? 23'h0 :
			    (f2i_max & op_f2i) ? 23'h7fffff :
			    fract_out_rnd;
   
   assign exp_out_final = (f2i_max & op_f2i) ? 8'hff :  exp_out_rnd;

   // ---------------------------------------------------------------------
   // Pack Result
   
   assign out = {exp_out_final, fract_out_final};
   
   // ---------------------------------------------------------------------
   // Exceptions
   
   
   assign underflow = (!fract_in[47] & exp_out1_co) & !dn;
   
   
   assign overflow  = ovf0 | ovf1;
   
   wire 		f2i_ine;
   wire 		exp_in_lt_half = (exp_in<8'h80);
   
   assign f2i_ine = (f2i_zero & !fract_in_00 & !opas) |
		    (|fract_trunc) |
		    (f2i_zero & exp_in_lt_half  & opas & !fract_in_00) |
		    (f2i_max & rmode_11 & (exp_in<8'h80));

   assign ine =	op_f2i ? f2i_ine :
	       op_i2f ? (|fract_trunc) :
	       ((r & !dn) | (s & !dn) );

   assign inv = op_f2i & (exp_in > f2i_emax);
   
   

endmodule // or1200_fpu_post_norm_intfloat_conv



//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_fpu_post_norm_mul                                    ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  post-normalization entity for the multiplication unit       ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//

module or1200_fpu_post_norm_mul(
		     clk_i,
		     opa_i,
		     opb_i,
		     exp_10_i,
		     fract_48_i,
		     sign_i,
		     rmode_i,
		     output_o,
		     ine_o
		     );

   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 0; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 11; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b1111111110000000000000000000000;
   parameter SNAN = 31'b1111111100000000000000000000001;

   input clk_i;
   input [FP_WIDTH-1:0] opa_i;
   input [FP_WIDTH-1:0] opb_i;
   input [EXP_WIDTH+1:0] exp_10_i;
   input [2*FRAC_WIDTH+1:0] fract_48_i;
   input 		    sign_i;
   input [1:0] 		    rmode_i;
   output reg [FP_WIDTH-1:0]    output_o;
   output reg 		    ine_o;

   
   reg [EXP_WIDTH-1:0]     s_expa;
   reg [EXP_WIDTH-1:0]     s_expb;
   reg [EXP_WIDTH+1:0]     s_exp_10_i;
   reg [2*FRAC_WIDTH+1:0]  s_fract_48_i;
   reg 			   s_sign_i;   
   wire [FP_WIDTH-1:0] 	    s_output_o;
   wire 		    s_ine_o;
   wire 		    s_overflow;   
   reg [FP_WIDTH-1:0] 	    s_opa_i;
   reg [FP_WIDTH-1:0] 	    s_opb_i;
   reg [1:0] 		    s_rmode_i;

   reg [5:0] 		    s_zeros;
   wire 		    s_carry;   
   reg [5:0] 		    s_shr2;
   reg [5:0] 		    s_shl2;
   reg [8:0] 		    s_expo1;
   wire [8:0] 		    s_expo2b;
   wire [9:0] 		    s_exp_10a;
   wire [9:0] 		    s_exp_10b;
   reg [47:0] 		    s_frac2a;

   wire 		    s_sticky, s_guard, s_round;   
   wire 		    s_roundup;   
   reg [24:0] 		    s_frac_rnd;
   wire [24:0] 		    s_frac3;
   wire 		    s_shr3;   
   reg [5:0] 		    s_r_zeros;
   wire 		    s_lost;   
   wire 		    s_op_0;   
   wire [8:0] 		    s_expo3;

   wire 		    s_infa, s_infb;   
   wire 		    s_nan_in, s_nan_op, s_nan_a, s_nan_b;   

   
   // Input Register
   always @(posedge clk_i)
     begin
	s_opa_i <= opa_i;
	s_opb_i <= opb_i;	
	s_expa <= opa_i[30:23];
	s_expb <= opb_i[30:23];
	s_exp_10_i <= exp_10_i;
	s_fract_48_i <= fract_48_i;
	s_sign_i <= sign_i;
	s_rmode_i <= rmode_i;
     end

   // Output register
   always @(posedge clk_i)
     begin
	output_o <= s_output_o;
	ine_o	<= s_ine_o;
     end

   //*** Stage 1 ****
   // figure out the exponent and howmuch the fraction has to be shiftd 
   // right/left
	
   assign s_carry = s_fract_48_i[47];
   
   
   always @(posedge clk_i)
     if (!s_fract_48_i[47])
       casez(s_fract_48_i[46:1])	// synopsys full_case parallel_case
	 46'b1?????????????????????????????????????????????: s_zeros <=  0;
	 46'b01????????????????????????????????????????????: s_zeros <=  1;
	 46'b001???????????????????????????????????????????: s_zeros <=  2;
	 46'b0001??????????????????????????????????????????: s_zeros <=  3;
	 46'b00001?????????????????????????????????????????: s_zeros <=  4;
	 46'b000001????????????????????????????????????????: s_zeros <=  5;
	 46'b0000001???????????????????????????????????????: s_zeros <=  6;
	 46'b00000001??????????????????????????????????????: s_zeros <=  7;
	 46'b000000001?????????????????????????????????????: s_zeros <=  8;
	 46'b0000000001????????????????????????????????????: s_zeros <=  9;
	 46'b00000000001???????????????????????????????????: s_zeros <=  10;
	 46'b000000000001??????????????????????????????????: s_zeros <=  11;
	 46'b0000000000001?????????????????????????????????: s_zeros <=  12;
	 46'b00000000000001????????????????????????????????: s_zeros <=  13;
	 46'b000000000000001???????????????????????????????: s_zeros <=  14;
	 46'b0000000000000001??????????????????????????????: s_zeros <=  15;
	 46'b00000000000000001?????????????????????????????: s_zeros <=  16;
	 46'b000000000000000001????????????????????????????: s_zeros <=  17;
	 46'b0000000000000000001???????????????????????????: s_zeros <=  18;
	 46'b00000000000000000001??????????????????????????: s_zeros <=  19;
	 46'b000000000000000000001?????????????????????????: s_zeros <=  20;
	 46'b0000000000000000000001????????????????????????: s_zeros <=  21;
	 46'b00000000000000000000001???????????????????????: s_zeros <=  22;
	 46'b000000000000000000000001??????????????????????: s_zeros <=  23;
	 46'b0000000000000000000000001?????????????????????: s_zeros <=  24;
	 46'b00000000000000000000000001????????????????????: s_zeros <=  25;
	 46'b000000000000000000000000001???????????????????: s_zeros <=  26;
	 46'b0000000000000000000000000001??????????????????: s_zeros <=  27;
	 46'b00000000000000000000000000001?????????????????: s_zeros <=  28;
	 46'b000000000000000000000000000001????????????????: s_zeros <=  29;
	 46'b0000000000000000000000000000001???????????????: s_zeros <=  30;
	 46'b00000000000000000000000000000001??????????????: s_zeros <=  31;
	 46'b000000000000000000000000000000001?????????????: s_zeros <=  32;
	 46'b0000000000000000000000000000000001????????????: s_zeros <=  33;
	 46'b00000000000000000000000000000000001???????????: s_zeros <=  34;
	 46'b000000000000000000000000000000000001??????????: s_zeros <=  35;
	 46'b0000000000000000000000000000000000001?????????: s_zeros <=  36;
	 46'b00000000000000000000000000000000000001????????: s_zeros <=  37;
	 46'b000000000000000000000000000000000000001???????: s_zeros <=  38;
	 46'b0000000000000000000000000000000000000001??????: s_zeros <=  39;
	 46'b00000000000000000000000000000000000000001?????: s_zeros <=  40;
	 46'b000000000000000000000000000000000000000001????: s_zeros <=  41;
	 46'b0000000000000000000000000000000000000000001???: s_zeros <=  42;
	 46'b00000000000000000000000000000000000000000001??: s_zeros <=  43;
	 46'b000000000000000000000000000000000000000000001?: s_zeros <=  44;
	 46'b0000000000000000000000000000000000000000000001: s_zeros <=  45;
	 46'b0000000000000000000000000000000000000000000000: s_zeros <=  46;
       endcase // casex (s_fract_48_i[46:1])
     else
       s_zeros <= 0;


   always @(posedge clk_i)
     casez(s_fract_48_i) // synopsys full_case parallel_case
       48'b???????????????????????????????????????????????1: s_r_zeros <=  0;
       48'b??????????????????????????????????????????????10: s_r_zeros <=  1;
       48'b?????????????????????????????????????????????100: s_r_zeros <=  2;
       48'b????????????????????????????????????????????1000: s_r_zeros <=  3;
       48'b???????????????????????????????????????????10000: s_r_zeros <=  4;
       48'b??????????????????????????????????????????100000: s_r_zeros <=  5;
       48'b?????????????????????????????????????????1000000: s_r_zeros <=  6;
       48'b????????????????????????????????????????10000000: s_r_zeros <=  7;
       48'b???????????????????????????????????????100000000: s_r_zeros <=  8;
       48'b??????????????????????????????????????1000000000: s_r_zeros <=  9;
       48'b?????????????????????????????????????10000000000: s_r_zeros <=  10;
       48'b????????????????????????????????????100000000000: s_r_zeros <=  11;
       48'b???????????????????????????????????1000000000000: s_r_zeros <=  12;
       48'b??????????????????????????????????10000000000000: s_r_zeros <=  13;
       48'b?????????????????????????????????100000000000000: s_r_zeros <=  14;
       48'b????????????????????????????????1000000000000000: s_r_zeros <=  15;
       48'b???????????????????????????????10000000000000000: s_r_zeros <=  16;
       48'b??????????????????????????????100000000000000000: s_r_zeros <=  17;
       48'b?????????????????????????????1000000000000000000: s_r_zeros <=  18;
       48'b????????????????????????????10000000000000000000: s_r_zeros <=  19;
       48'b???????????????????????????100000000000000000000: s_r_zeros <=  20;
       48'b??????????????????????????1000000000000000000000: s_r_zeros <=  21;
       48'b?????????????????????????10000000000000000000000: s_r_zeros <=  22;
       48'b????????????????????????100000000000000000000000: s_r_zeros <=  23;
       48'b???????????????????????1000000000000000000000000: s_r_zeros <=  24;
       48'b??????????????????????10000000000000000000000000: s_r_zeros <=  25;
       48'b?????????????????????100000000000000000000000000: s_r_zeros <=  26;
       48'b????????????????????1000000000000000000000000000: s_r_zeros <=  27;
       48'b???????????????????10000000000000000000000000000: s_r_zeros <=  28;
       48'b??????????????????100000000000000000000000000000: s_r_zeros <=  29;
       48'b?????????????????1000000000000000000000000000000: s_r_zeros <=  30;
       48'b????????????????10000000000000000000000000000000: s_r_zeros <=  31;
       48'b???????????????100000000000000000000000000000000: s_r_zeros <=  32;
       48'b??????????????1000000000000000000000000000000000: s_r_zeros <=  33;
       48'b?????????????10000000000000000000000000000000000: s_r_zeros <=  34;
       48'b????????????100000000000000000000000000000000000: s_r_zeros <=  35;
       48'b???????????1000000000000000000000000000000000000: s_r_zeros <=  36;
       48'b??????????10000000000000000000000000000000000000: s_r_zeros <=  37;
       48'b?????????100000000000000000000000000000000000000: s_r_zeros <=  38;
       48'b????????1000000000000000000000000000000000000000: s_r_zeros <=  39;
       48'b???????10000000000000000000000000000000000000000: s_r_zeros <=  40;
       48'b??????100000000000000000000000000000000000000000: s_r_zeros <=  41;
       48'b?????1000000000000000000000000000000000000000000: s_r_zeros <=  42;
       48'b????10000000000000000000000000000000000000000000: s_r_zeros <=  43;
       48'b???100000000000000000000000000000000000000000000: s_r_zeros <=  44;
       48'b??1000000000000000000000000000000000000000000000: s_r_zeros <=  45;
       48'b?10000000000000000000000000000000000000000000000: s_r_zeros <=  46;
       48'b100000000000000000000000000000000000000000000000: s_r_zeros <=  47;
       48'b000000000000000000000000000000000000000000000000: s_r_zeros <=  48;
     endcase // casex (s_fract_48_i)

   assign s_exp_10a = s_exp_10_i + {9'd0,s_carry};		
   assign s_exp_10b = s_exp_10a - {4'd0,s_zeros};

   wire [9:0] v_shr1;
   wire [9:0] v_shl1;
   
   assign v_shr1 = (s_exp_10a[9] | !(|s_exp_10a)) ?
		   10'd1 - s_exp_10a + {9'd0,s_carry} :
		   (s_exp_10b[9] | !(|s_exp_10b)) ?
		   0 :
		   s_exp_10b[8] ?
		   0 : {9'd0,s_carry};
   
   assign v_shl1 = (s_exp_10a[9] | !(|s_exp_10a)) ?
		   0 :
		   (s_exp_10b[9] | !(|s_exp_10b)) ?
		   {4'd0,s_zeros} - s_exp_10a :
		   s_exp_10b[8] ?
		   0 : {4'd0,s_zeros};
   
		   
   always @(posedge clk_i)
     begin
	if ((s_exp_10a[9] | !(|s_exp_10a)))
	  s_expo1 <= 9'd1;
	else if (s_exp_10b[9] | !(|s_exp_10b))
	  s_expo1 <= 9'd1;
	else if (s_exp_10b[8])
	  s_expo1 <= 9'b011111111;
	else
	  s_expo1 <= s_exp_10b[8:0];
	
	if (v_shr1[6])
	  s_shr2 <= {6{1'b1}};
	else
	  s_shr2 <= v_shr1[5:0];

	s_shl2 <= v_shl1[5:0];
     end // always @ (posedge clk_i)
   	
   // *** Stage 2 ***
   // Shifting the fraction and rounding
		
		
   // shift the fraction
   always @(posedge clk_i)
     if (|s_shr2)
       s_frac2a <= s_fract_48_i >> s_shr2;
     else 
       s_frac2a <= s_fract_48_i << s_shl2; 
	
   assign s_expo2b = s_frac2a[46] ? s_expo1 : s_expo1 - 9'd1;

   // signals if precision was last during the right-shift above
   assign s_lost = (s_shr2 + {5'd0,s_shr3}) > s_r_zeros;
   
   // ***Stage 3***
   // Rounding

   //								   23
   //									|	
   // 			xx00000000000000000000000grsxxxxxxxxxxxxxxxxxxxx
   // guard bit: s_frac2a[23] (LSB of output)
   // round bit: s_frac2a[22]
   assign s_guard = s_frac2a[22];
   assign s_round = s_frac2a[21];
   assign s_sticky = (|s_frac2a[20:0]) | s_lost;
   
   assign s_roundup = s_rmode_i==2'b00 ? // round to nearest even
		      s_guard & ((s_round | s_sticky) | s_frac2a[23]) :
		      s_rmode_i==2'b10 ? // round up
		      (s_guard | s_round | s_sticky) & !s_sign_i :
		      s_rmode_i==2'b11 ? // round down
		      (s_guard | s_round | s_sticky) & s_sign_i : 
		      0; // round to zero(truncate = no rounding)
   
   
   always @(posedge clk_i)
     if (s_roundup)
       s_frac_rnd <= s_frac2a[47:23] + 1; 
     else 
       s_frac_rnd <= s_frac2a[47:23];
	
   assign s_shr3 = s_frac_rnd[24];


   assign s_expo3 = (s_shr3 & (s_expo2b!=9'b011111111)) ? 
		     s_expo2b + 1 : s_expo2b;
   
   assign s_frac3 = (s_shr3 & (s_expo2b!=9'b011111111)) ? 
		     {1'b0,s_frac_rnd[24:1]} : s_frac_rnd; 
	
   //-***Stage 4****
   // Output
		
   assign s_op_0 = !((|s_opa_i[30:0]) & (|s_opb_i[30:0]));
	
   assign s_infa = &s_expa;
   
   assign s_infb = &s_expb;
      
   assign s_nan_a = s_infa & (|s_opa_i[22:0]);
   
   assign s_nan_b = s_infb & (|s_opb_i[22:0]);
   
   assign s_nan_in = s_nan_a | s_nan_b;
   
   assign s_nan_op = (s_infa | s_infb) & s_op_0; // 0 * inf = nan
   
   assign s_overflow = (s_expo3==9'b011111111) & !(s_infa | s_infb);
   
   assign s_ine_o = !s_op_0 & (s_lost | (|s_frac2a[22:0]) | s_overflow);
   
   assign s_output_o = (s_nan_in | s_nan_op) ?
		       {s_sign_i,QNAN} :
		       (s_infa | s_infb) | s_overflow ?
		       {s_sign_i,INF} :
		       s_r_zeros==48 ?
		       {s_sign_i,ZERO_VECTOR} :
		       {s_sign_i,s_expo3[7:0],s_frac3[22:0]};

endmodule // or1200_fpu_post_norm_mul



//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_fpu_pre_norm_addsub                                  ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  pre-normalization entity for the addition/subtraction unit  ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//

module or1200_fpu_pre_norm_addsub (

			clk_i, 		
			opa_i,		
			opb_i,		
			fracta_28_o, 
			fractb_28_o,
			exp_o
			);

   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 0; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 11; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b1111111110000000000000000000000;
   parameter SNAN = 31'b1111111100000000000000000000001;


   input clk_i;
   input [FP_WIDTH-1:0] opa_i;
   input [FP_WIDTH-1:0] opb_i;
   // carry(1) & hidden(1) & fraction(23) & guard(1) & round(1) & sticky(1)
   output reg [FRAC_WIDTH+4:0] fracta_28_o;
   output reg [FRAC_WIDTH+4:0] fractb_28_o;
   output reg [EXP_WIDTH-1:0]  exp_o;
   
   reg [EXP_WIDTH-1 : 0]       s_exp_o ;
   wire [FRAC_WIDTH+4 : 0]     s_fracta_28_o, s_fractb_28_o ;
   wire [EXP_WIDTH-1 : 0]      s_expa;
   wire [EXP_WIDTH-1 : 0]      s_expb ;
   wire [FRAC_WIDTH-1 : 0]     s_fracta;
   wire [FRAC_WIDTH-1 : 0]     s_fractb ;
   wire [FRAC_WIDTH+4 : 0]     s_fracta_28;

   wire [FRAC_WIDTH+4 : 0]     s_fractb_28 ;
   
   wire [FRAC_WIDTH+4 : 0]     s_fract_sm_28;
   wire [FRAC_WIDTH+4 : 0]     s_fract_shr_28 ;
   
   reg [EXP_WIDTH-1 : 0]       s_exp_diff ;
   reg [5 : 0] 		       s_rzeros ;
   wire 		       s_expa_eq_expb;
   wire 		       s_expa_gt_expb;
   wire 		       s_fracta_1;
   wire 		       s_fractb_1;
   wire 		       s_op_dn,s_opa_dn, s_opb_dn;
   wire [1 : 0] 	       s_mux_diff ;
   wire 		       s_mux_exp;
   wire 		       s_sticky;


   assign s_expa = opa_i[30:23];
   assign s_expb = opb_i[30:23];
   assign s_fracta = opa_i[22:0];
   assign s_fractb = opb_i[22:0];
   
   always @(posedge clk_i)
     begin
	exp_o <= s_exp_o;
	fracta_28_o <= s_fracta_28_o;
	fractb_28_o <= s_fractb_28_o;	
     end
   
   assign s_expa_eq_expb = (s_expa == s_expb);
   
   assign s_expa_gt_expb = (s_expa > s_expb);
   
   // '1' if fraction is not zero
   assign s_fracta_1 = |s_fracta;
   assign s_fractb_1 = |s_fractb; 
   
   // opa or Opb is denormalized
   assign s_opa_dn = !(|s_expa);
   assign s_opb_dn = !(|s_expb);
   assign s_op_dn = s_opa_dn | s_opb_dn; 

   // Output larger exponent
   assign s_mux_exp = s_expa_gt_expb;
   
   always @(posedge clk_i)
     s_exp_o <= s_mux_exp ? s_expa : s_expb;
   
   // convert to an easy to handle floating-point format
   assign s_fracta_28 = s_opa_dn ? 
			{2'b00, s_fracta, 3'b000} : {2'b01, s_fracta, 3'b000};
   assign s_fractb_28 = s_opb_dn ? 
			{2'b00, s_fractb, 3'b000} : {2'b01, s_fractb, 3'b000};
   
   assign s_mux_diff = {s_expa_gt_expb, s_opa_dn ^ s_opb_dn};
   
   // calculate howmany postions the fraction will be shifted
   always @(posedge clk_i)
     begin
	case(s_mux_diff)
	   2'b00: s_exp_diff <= s_expb - s_expa;
	   2'b01: s_exp_diff <= s_expb - (s_expa + 8'd1);
	   2'b10: s_exp_diff <= s_expa - s_expb;
	   2'b11: s_exp_diff <= s_expa - (s_expb + 8'd1);
	endcase
     end
   
   assign s_fract_sm_28 =  s_expa_gt_expb ? s_fractb_28 : s_fracta_28;
   
   // shift-right the fraction if necessary
   assign s_fract_shr_28 = s_fract_sm_28 >> s_exp_diff;

   // count the zeros from right to check if result is inexact
   always @(s_fract_sm_28)
     casez(s_fract_sm_28) // synopsys full_case parallel_case
       28'b???????????????????????????1: s_rzeros = 0;
       28'b??????????????????????????10: s_rzeros = 1;
       28'b?????????????????????????100: s_rzeros = 2;
       28'b????????????????????????1000: s_rzeros = 3;
       28'b???????????????????????10000: s_rzeros = 4;
       28'b??????????????????????100000: s_rzeros = 5;
       28'b?????????????????????1000000: s_rzeros = 6;
       28'b????????????????????10000000: s_rzeros = 7;
       28'b???????????????????100000000: s_rzeros = 8;
       28'b??????????????????1000000000: s_rzeros = 9;
       28'b?????????????????10000000000: s_rzeros = 10;
       28'b????????????????100000000000: s_rzeros = 11;
       28'b???????????????1000000000000: s_rzeros = 12;
       28'b??????????????10000000000000: s_rzeros = 13;
       28'b?????????????100000000000000: s_rzeros = 14;
       28'b????????????1000000000000000: s_rzeros = 15;
       28'b???????????10000000000000000: s_rzeros = 16;
       28'b??????????100000000000000000: s_rzeros = 17;
       28'b?????????1000000000000000000: s_rzeros = 18;
       28'b????????10000000000000000000: s_rzeros = 19;
       28'b???????100000000000000000000: s_rzeros = 20;
       28'b??????1000000000000000000000: s_rzeros = 21;
       28'b?????10000000000000000000000: s_rzeros = 22;
       28'b????100000000000000000000000: s_rzeros = 23;
       28'b???1000000000000000000000000: s_rzeros = 24;
       28'b??10000000000000000000000000: s_rzeros = 25;
       28'b?100000000000000000000000000: s_rzeros = 26;
       28'b1000000000000000000000000000: s_rzeros = 27;
       28'b0000000000000000000000000000: s_rzeros = 28;
     endcase // casex (s_fract_sm_28)
   
   assign s_sticky = (s_exp_diff > {2'b00,s_rzeros}) & (|s_fract_sm_28);
   
   assign s_fracta_28_o = s_expa_gt_expb ?
			  s_fracta_28 :
			  {s_fract_shr_28[27:1],(s_sticky|s_fract_shr_28[0])};
   
   assign s_fractb_28_o =  s_expa_gt_expb ? 
			   {s_fract_shr_28[27:1],(s_sticky|s_fract_shr_28[0])} :
			   s_fractb_28;

endmodule // or1200_fpu_pre_norm_addsub




//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_fpu_pre_norm_div                                     ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  pre-normalization entity for the division unit              ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//

module or1200_fpu_pre_norm_div
  (
   clk_i,
   opa_i,
   opb_i,
   exp_10_o,
   dvdnd_50_o,
   dvsor_27_o
   );

   
   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 0; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 11; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b1111111110000000000000000000000;
   parameter SNAN = 31'b1111111100000000000000000000001;

   input clk_i;
   input [FP_WIDTH-1:0] opa_i;
   input [FP_WIDTH-1:0] opb_i;
   output reg [EXP_WIDTH+1:0] exp_10_o;
   output [2*(FRAC_WIDTH+2)-1:0] dvdnd_50_o;
   output [FRAC_WIDTH+3:0] 	 dvsor_27_o;

   
   wire [EXP_WIDTH-1:0] 	 s_expa;
   wire [EXP_WIDTH-1:0] 	 s_expb;
   wire [FRAC_WIDTH-1:0] 	 s_fracta;
   wire [FRAC_WIDTH-1:0] 	 s_fractb;
   wire [2*(FRAC_WIDTH+2)-1:0] 	 s_dvdnd_50_o;
   wire [FRAC_WIDTH+3:0] 	 s_dvsor_27_o;
   reg [5:0] 			 s_dvd_zeros;
   reg [5:0] 			 s_div_zeros;
   reg [EXP_WIDTH+1:0] 		 s_exp_10_o;
   
   reg [EXP_WIDTH+1:0] 		 s_expa_in;
   reg [EXP_WIDTH+1:0] 		 s_expb_in;
   wire 			 s_opa_dn, s_opb_dn;
   
   wire [FRAC_WIDTH:0] 		 s_fracta_24;
   wire [FRAC_WIDTH:0] 		 s_fractb_24;

   
   assign s_expa = opa_i[30:23];
   assign s_expb = opb_i[30:23];
   assign s_fracta = opa_i[22:0];
   assign s_fractb = opb_i[22:0];
   assign dvdnd_50_o = s_dvdnd_50_o;
   assign dvsor_27_o	= s_dvsor_27_o;
   
   // Output Register
   always @(posedge clk_i)
     exp_10_o <= s_exp_10_o;

   assign s_opa_dn = !(|s_expa);
   assign s_opb_dn = !(|s_expb);
	
   assign s_fracta_24 = {!s_opa_dn,s_fracta};
   assign s_fractb_24 = {!s_opb_dn,s_fractb};
	
   
   // count leading zeros
   //s_dvd_zeros <= count_l_zeros( s_fracta_24 );
   always @(s_fracta_24)
     casez(s_fracta_24)	// synopsys full_case parallel_case
       24'b1???????????????????????: s_dvd_zeros = 0;
       24'b01??????????????????????: s_dvd_zeros = 1;
       24'b001?????????????????????: s_dvd_zeros = 2;
       24'b0001????????????????????: s_dvd_zeros = 3;
       24'b00001???????????????????: s_dvd_zeros = 4;
       24'b000001??????????????????: s_dvd_zeros = 5;
       24'b0000001?????????????????: s_dvd_zeros = 6;
       24'b00000001????????????????: s_dvd_zeros = 7;
       24'b000000001???????????????: s_dvd_zeros = 8;
       24'b0000000001??????????????: s_dvd_zeros = 9;
       24'b00000000001?????????????: s_dvd_zeros = 10;
       24'b000000000001????????????: s_dvd_zeros = 11;
       24'b0000000000001???????????: s_dvd_zeros = 12;
       24'b00000000000001??????????: s_dvd_zeros = 13;
       24'b000000000000001?????????: s_dvd_zeros = 14;
       24'b0000000000000001????????: s_dvd_zeros = 15;
       24'b00000000000000001???????: s_dvd_zeros = 16;
       24'b000000000000000001??????: s_dvd_zeros = 17;
       24'b0000000000000000001?????: s_dvd_zeros = 18;
       24'b00000000000000000001????: s_dvd_zeros = 19;
       24'b000000000000000000001???: s_dvd_zeros = 20;
       24'b0000000000000000000001??: s_dvd_zeros = 21;
       24'b00000000000000000000001?: s_dvd_zeros = 22;
       24'b000000000000000000000001: s_dvd_zeros = 23;
       24'b000000000000000000000000: s_dvd_zeros = 24;
     endcase

   //s_div_zeros <= count_l_zeros( s_fractb_24 );
   always @(s_fractb_24)
     casez(s_fractb_24)	// synopsys full_case parallel_case
       24'b1???????????????????????: s_div_zeros = 0;
       24'b01??????????????????????: s_div_zeros = 1;
       24'b001?????????????????????: s_div_zeros = 2;
       24'b0001????????????????????: s_div_zeros = 3;
       24'b00001???????????????????: s_div_zeros = 4;
       24'b000001??????????????????: s_div_zeros = 5;
       24'b0000001?????????????????: s_div_zeros = 6;
       24'b00000001????????????????: s_div_zeros = 7;
       24'b000000001???????????????: s_div_zeros = 8;
       24'b0000000001??????????????: s_div_zeros = 9;
       24'b00000000001?????????????: s_div_zeros = 10;
       24'b000000000001????????????: s_div_zeros = 11;
       24'b0000000000001???????????: s_div_zeros = 12;
       24'b00000000000001??????????: s_div_zeros = 13;
       24'b000000000000001?????????: s_div_zeros = 14;
       24'b0000000000000001????????: s_div_zeros = 15;
       24'b00000000000000001???????: s_div_zeros = 16;
       24'b000000000000000001??????: s_div_zeros = 17;
       24'b0000000000000000001?????: s_div_zeros = 18;
       24'b00000000000000000001????: s_div_zeros = 19;
       24'b000000000000000000001???: s_div_zeros = 20;
       24'b0000000000000000000001??: s_div_zeros = 21;
       24'b00000000000000000000001?: s_div_zeros = 22;
       24'b000000000000000000000001: s_div_zeros = 23;
       24'b000000000000000000000000: s_div_zeros = 24;
     endcase

   // left-shift the dividend and divisor
   wire [FRAC_WIDTH:0] 		 fracta_lshift_intermediate;
   wire [FRAC_WIDTH:0] 		 fractb_lshift_intermediate;
   assign fracta_lshift_intermediate = s_fracta_24 << s_dvd_zeros;
   assign fractb_lshift_intermediate = s_fractb_24 << s_div_zeros;
   
   assign s_dvdnd_50_o = {fracta_lshift_intermediate,26'd0};
   
   assign s_dvsor_27_o = {3'd0,fractb_lshift_intermediate};
	
   always @(posedge clk_i)
     begin
	// pre-calculate exponent
	s_expa_in <= {2'd0,s_expa} + {9'd0,s_opa_dn};
	s_expb_in <= {2'd0,s_expb} + {9'd0,s_opb_dn};	
	s_exp_10_o <= s_expa_in - s_expb_in + 10'b0001111111 - 
		      {4'd0,s_dvd_zeros} + {4'd0,s_div_zeros};
     end

   
endmodule // or1200_fpu_pre_norm_div



//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_fpu_pre_norm_mul                                     ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  pre-normalization entity for the multiplication unit        ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Original design (FPU100) -                            ////
////        Jidan Al-eryani, jidan@gmx.net                        ////
////      - Conv. to Verilog and inclusion in OR1200 -            ////
////        Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2006, 2010
//
//	This source file may be used and distributed without        
//	restriction provided that this copyright statement is not   
//	removed from the file and that any derivative work contains 
//	the original copyright notice and the associated disclaimer.
//                                                           
//		THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     
//	EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   
//	TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   
//	FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      
//	OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         
//	INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   
//	GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        
//	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  
//	LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  
//	OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         
//	POSSIBILITY OF SUCH DAMAGE. 
//

module or1200_fpu_pre_norm_mul (
		     clk_i,
		     opa_i,
		     opb_i,
		     exp_10_o,
		     fracta_24_o,
		     fractb_24_o
		     );

   parameter FP_WIDTH = 32;
   parameter MUL_SERIAL = 0; // 0 for parallel multiplier, 1 for serial
   parameter MUL_COUNT = 11; //11 for parallel multiplier, 34 for serial
   parameter FRAC_WIDTH = 23;
   parameter EXP_WIDTH = 8;
   parameter ZERO_VECTOR = 31'd0;
   parameter INF = 31'b1111111100000000000000000000000;
   parameter QNAN = 31'b1111111110000000000000000000000;
   parameter SNAN = 31'b1111111100000000000000000000001;


   input clk_i;
   input [FP_WIDTH-1:0] opa_i;
   input [FP_WIDTH-1:0] opb_i;
   output reg [EXP_WIDTH+1:0] exp_10_o;
   output [FRAC_WIDTH:0] fracta_24_o;
   output [FRAC_WIDTH:0] fractb_24_o; 

   
   wire [EXP_WIDTH-1:0]      s_expa;
   wire [EXP_WIDTH-1:0]      s_expb;
   
   wire [FRAC_WIDTH-1:0]     s_fracta;
   wire [FRAC_WIDTH-1:0]     s_fractb;

   wire [EXP_WIDTH+1:0]      s_exp_10_o;
   wire [EXP_WIDTH+1:0]      s_expa_in;
   wire [EXP_WIDTH+1:0]      s_expb_in;
   
   wire 		     s_opa_dn, s_opb_dn;

   assign s_expa = opa_i[30:23];
   assign s_expb = opb_i[30:23];
   assign s_fracta = opa_i[22:0];
   assign s_fractb = opb_i[22:0];
   
   // Output Register
   always @(posedge clk_i)
     exp_10_o <= s_exp_10_o;
   
   // opa or opb is denormalized
   assign s_opa_dn = !(|s_expa);
   assign s_opb_dn = !(|s_expb);
   
   assign fracta_24_o = {!s_opa_dn, s_fracta};
   assign fractb_24_o = {!s_opb_dn, s_fractb};
   
   assign s_expa_in = {2'd0, s_expa} + {9'd0, s_opa_dn};
   assign s_expb_in = {2'd0, s_expb} + {9'd0, s_opb_dn};
   
   assign s_exp_10_o = s_expa_in + s_expb_in - 10'b0001111111;		

endmodule // or1200_fpu_pre_norm_mul




//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Freeze logic                                       ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Generates all freezes and stalls inside RISC                ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_freeze.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed. 
//

// synopsys translate_off
// synopsys translate_on

`define OR1200_NO_FREEZE	3'd0
`define OR1200_FREEZE_BYDC	3'd1
`define OR1200_FREEZE_BYMULTICYCLE	3'd2
`define OR1200_WAIT_LSU_TO_FINISH	3'd3
`define OR1200_WAIT_IC			3'd4

//
// Freeze logic (stalls CPU pipeline, ifetcher etc.)
//
module or1200_freeze
  (
   // Clock and reset
   clk, rst,
   
   // Internal i/f
   multicycle, wait_on, flushpipe, extend_flush, lsu_stall, if_stall,
   lsu_unstall, du_stall, mac_stall, 
   force_dslot_fetch, abort_ex,
   genpc_freeze, if_freeze, id_freeze, ex_freeze, wb_freeze, saving_if_insn,
   fpu_done, mtspr_done,
   icpu_ack_i, icpu_err_i
   );

//
// I/O
//
input				clk;
input				rst;
input	[`OR1200_MULTICYCLE_WIDTH-1:0]	multicycle;
input   [`OR1200_WAIT_ON_WIDTH-1:0] 	wait_on;   
input				flushpipe;
input				extend_flush;
input				lsu_stall;
input				if_stall;
input				lsu_unstall;
input				force_dslot_fetch;
input				abort_ex;
input				du_stall;
input				mac_stall;
output				genpc_freeze;
output				if_freeze;
output				id_freeze;
output				ex_freeze;
output				wb_freeze;
input                           saving_if_insn;
input   			fpu_done;
input   			mtspr_done;   
input				icpu_ack_i;
input				icpu_err_i;

//
// Internal wires and regs
//
wire				multicycle_freeze;
reg	[`OR1200_MULTICYCLE_WIDTH-1:0]	multicycle_cnt;
reg				flushpipe_r;
reg [`OR1200_WAIT_ON_WIDTH-1:0]	waiting_on;
   
//
// Pipeline freeze
//
// Rules how to create freeze signals:
// 1. Not overwriting pipeline stages:
// Freeze signals at the beginning of pipeline (such as if_freeze) can be 
// asserted more often than freeze signals at the of pipeline (such as 
// wb_freeze). In other words, wb_freeze must never be asserted when ex_freeze 
// is not. ex_freeze must never be asserted when id_freeze is not etc.
//
// 2. Inserting NOPs in the middle of pipeline only if supported:
// At this time, only ex_freeze (and wb_freeze) can be deassrted when id_freeze
// (and if_freeze) are asserted.
// This way NOP is asserted from stage ID into EX stage.
//

assign genpc_freeze = (du_stall & !saving_if_insn) | flushpipe_r;
assign if_freeze = id_freeze | extend_flush;

assign id_freeze = (lsu_stall | (~lsu_unstall & if_stall) | multicycle_freeze 
		    | (|waiting_on) | force_dslot_fetch) | du_stall | mac_stall;
assign ex_freeze = wb_freeze;

assign wb_freeze = (lsu_stall | (~lsu_unstall & if_stall) | multicycle_freeze 
		    | (|waiting_on)) | du_stall | mac_stall | abort_ex;

//
// registered flushpipe
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		flushpipe_r <=  1'b0;
	else if (icpu_ack_i | icpu_err_i)
//	else if (!if_stall)
		flushpipe_r <=  flushpipe;
	else if (!flushpipe)
		flushpipe_r <=  1'b0;
		
//
// Multicycle freeze
//
assign multicycle_freeze = |multicycle_cnt;

//
// Multicycle counter
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		multicycle_cnt <=  `OR1200_MULTICYCLE_WIDTH'd0;
	else if (|multicycle_cnt)
		multicycle_cnt <=  multicycle_cnt - `OR1200_MULTICYCLE_WIDTH'd1;
	else if (|multicycle & !ex_freeze)
		multicycle_cnt <=  multicycle;


//
// Waiting on generation
//
always @(posedge clk )
  if (rst == `OR1200_RST_VALUE)
    waiting_on <= 0;
  else if ((waiting_on == `OR1200_WAIT_ON_FPU) & fpu_done)
    waiting_on <= 0;
  else if ((waiting_on == `OR1200_WAIT_ON_MTSPR) & mtspr_done)
    waiting_on <= 0;
  else if (!ex_freeze)
    waiting_on <= wait_on;
   
	   
endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's generate PC                                        ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  PC, interface to IC.                                        ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_genpc.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 

// synopsys translate_off
// synopsys translate_on

module or1200_genpc(
	// Clock and reset
	clk, rst,

	// External i/f to IC
	icpu_adr_o, icpu_cycstb_o, icpu_sel_o, icpu_tag_o,
	icpu_rty_i, icpu_adr_i,

	// Internal i/f
	pre_branch_op, branch_op, except_type, except_prefix,
	id_branch_addrtarget, ex_branch_addrtarget, muxed_b, operand_b, 
	flag, flagforw, ex_branch_taken, except_start,
	epcr, spr_dat_i, spr_pc_we, genpc_refetch,
	genpc_freeze, no_more_dslot
);

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// External i/f to IC
//
output	[31:0]			icpu_adr_o;
output				icpu_cycstb_o;
output	[3:0]			icpu_sel_o;
output	[3:0]			icpu_tag_o;
input				icpu_rty_i;
input	[31:0]			icpu_adr_i;

//
// Internal i/f
//
input   [`OR1200_BRANCHOP_WIDTH-1:0]    pre_branch_op;
input	[`OR1200_BRANCHOP_WIDTH-1:0]	branch_op;
input	[`OR1200_EXCEPT_WIDTH-1:0]	except_type;
input					except_prefix;
input	[31:2]			id_branch_addrtarget;
input	[31:2]			ex_branch_addrtarget;
input	[31:0]			muxed_b;
input	[31:0]			operand_b;
input				flag;
input				flagforw;
output				ex_branch_taken;
input				except_start;
input	[31:0]			epcr;
input	[31:0]			spr_dat_i;
input				spr_pc_we;
input				genpc_refetch;
input				genpc_freeze;
input				no_more_dslot;

//
// Internal wires and regs
//
reg	[31:2]			pcreg_default;
wire	[31:0]			pcreg_boot;
reg				pcreg_select;
reg	[31:2]			pcreg;
reg	[31:0]			pc;
// Set in event of jump or taken branch   
reg				ex_branch_taken;
reg				genpc_refetch_r;

   //
   // Address of insn to be fecthed
   //
   assign icpu_adr_o = !no_more_dslot & !except_start & !spr_pc_we 
		       & (icpu_rty_i | genpc_refetch) ? 
		       icpu_adr_i : {pc[31:2], 1'b0, ex_branch_taken|spr_pc_we};

   //
   // Control access to IC subsystem
   //
   assign icpu_cycstb_o = ~(genpc_freeze | (|pre_branch_op && !icpu_rty_i));
   assign icpu_sel_o = 4'b1111;
   assign icpu_tag_o = `OR1200_ITAG_NI;

   //
   // genpc_freeze_r
   //
   always @(posedge clk )
     if (rst == `OR1200_RST_VALUE)
       genpc_refetch_r <=  1'b0;
     else if (genpc_refetch)
       genpc_refetch_r <=  1'b1;
     else
       genpc_refetch_r <=  1'b0;

   //
   // Async calculation of new PC value. This value is used for addressing the
   // IC.
   //
   always @(pcreg or ex_branch_addrtarget or flag or branch_op or except_type
	    or except_start or operand_b or epcr or spr_pc_we or spr_dat_i or 
	    except_prefix) 
     begin
	casez ({spr_pc_we, except_start, branch_op}) // synopsys parallel_case
	  {2'b00, `OR1200_BRANCHOP_NOP}: begin
	     pc = {pcreg + 30'd1, 2'b0};
	     ex_branch_taken = 1'b0;
	  end
	  {2'b00, `OR1200_BRANCHOP_J}: begin
`ifdef OR1200_VERBOSE
	     // synopsys translate_off
	     $display("%t: BRANCHOP_J: pc <= ex_branch_addrtarget %h"
		      , $time, ex_branch_addrtarget);
	     // synopsys translate_on
`endif
	     pc = {ex_branch_addrtarget, 2'b00};
	     ex_branch_taken = 1'b1;
	  end
	  {2'b00, `OR1200_BRANCHOP_JR}: begin
`ifdef OR1200_VERBOSE
	     // synopsys translate_off
	     $display("%t: BRANCHOP_JR: pc <= operand_b %h", 
		      $time, operand_b);
	     // synopsys translate_on
`endif
	     pc = operand_b;
	     ex_branch_taken = 1'b1;
	  end
	  {2'b00, `OR1200_BRANCHOP_BF}:
	    if (flag) begin
`ifdef OR1200_VERBOSE
	       // synopsys translate_off
	       $display("%t: BRANCHOP_BF: pc <= ex_branch_addrtarget %h", 
			$time, ex_branch_addrtarget);
	       // synopsys translate_on
`endif
	       pc = {ex_branch_addrtarget, 2'b00};
	       ex_branch_taken = 1'b1;
	    end
	    else begin
`ifdef OR1200_VERBOSE
	       // synopsys translate_off
	       $display("%t: BRANCHOP_BF: not taken", $time);
	       // synopsys translate_on
`endif
	       pc = {pcreg + 30'd1, 2'b0};
	       ex_branch_taken = 1'b0;
	    end
	  {2'b00, `OR1200_BRANCHOP_BNF}:
	    if (flag) begin
`ifdef OR1200_VERBOSE
	       // synopsys translate_off
	       $display("%t: BRANCHOP_BNF: not taken", $time);
	       // synopsys translate_on
`endif
	       pc = {pcreg + 30'd1, 2'b0};
	       ex_branch_taken = 1'b0;
	    end
	    else begin
`ifdef OR1200_VERBOSE
	       // synopsys translate_off
	       $display("%t: BRANCHOP_BNF: pc <= ex_branch_addrtarget %h", 
			$time, ex_branch_addrtarget);
	       // synopsys translate_on
`endif
	       pc = {ex_branch_addrtarget, 2'b00};
	       ex_branch_taken = 1'b1;
	    end
	  {2'b00, `OR1200_BRANCHOP_RFE}: begin
`ifdef OR1200_VERBOSE
	     // synopsys translate_off
	     $display("%t: BRANCHOP_RFE: pc <= epcr %h", 
		      $time, epcr);
	     // synopsys translate_on
`endif
	     pc = epcr;
	     ex_branch_taken = 1'b1;
	  end
	  {2'b01, 3'b???}: begin
`ifdef OR1200_VERBOSE
	     // synopsys translate_off
	     $display("Starting exception: %h.", except_type);
	     // synopsys translate_on
`endif
	     pc = {(except_prefix ? 
		    `OR1200_EXCEPT_EPH1_P : `OR1200_EXCEPT_EPH0_P), 
		   except_type, `OR1200_EXCEPT_V};
	     ex_branch_taken = 1'b1;
	  end
	  default: begin
`ifdef OR1200_VERBOSE
	     // synopsys translate_off
	     $display("l.mtspr writing into PC: %h.", spr_dat_i);
	     // synopsys translate_on
`endif
	     pc = spr_dat_i;
	     ex_branch_taken = 1'b0;
	  end
	endcase
     end

   //
   // PC register
   //
   always @(posedge clk )
     // default value 
     if (rst == `OR1200_RST_VALUE) begin
	pcreg_default <=  `OR1200_BOOT_PCREG_DEFAULT; // jb
	pcreg_select <=  1'b1;// select async. value due to reset state
     end
   // selected value (different from default) is written into FF after
   // reset state
     else if (pcreg_select) begin
	// dynamic value can only be assigned to FF out of reset! 
	pcreg_default <=  pcreg_boot[31:2];	
	pcreg_select <=  1'b0;		// select FF value 
     end
     else if (spr_pc_we) begin
	pcreg_default <=  spr_dat_i[31:2];
     end
     else if (no_more_dslot | except_start | !genpc_freeze & !icpu_rty_i 
	      & !genpc_refetch) begin
	pcreg_default <=  pc[31:2];
     end

   // select async. value for pcreg after reset - PC jumps to the address selected
   // after boot.
   assign  pcreg_boot = `OR1200_BOOT_ADR; // changed JB

   always @(pcreg_boot or pcreg_default or pcreg_select)
     if (pcreg_select)
       // async. value is selected due to reset state 
       pcreg = pcreg_boot[31:2];
     else
       // FF value is selected 2nd clock after reset state 
       pcreg = pcreg_default ;

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's IC FSM                                             ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Insn cache state machine                                    ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_ic_fsm.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed. 
//

// synopsys translate_off
// synopsys translate_on

`define OR1200_ICFSM_IDLE	2'd0
`define OR1200_ICFSM_CFETCH	2'd1
`define OR1200_ICFSM_LREFILL3	2'd2
`define OR1200_ICFSM_IFETCH	2'd3

//
// Data cache FSM for cache line of 16 bytes (4x singleword)
//

module or1200_ic_fsm(
	// Clock and reset
	clk, rst,

	// Internal i/f to top level IC
	ic_en, icqmem_cycstb_i, icqmem_ci_i,
	tagcomp_miss, biudata_valid, biudata_error, start_addr, saved_addr,
	icram_we, biu_read, first_hit_ack, first_miss_ack, first_miss_err,
	burst, tag_we
);

//
// I/O
//
input				clk;
input				rst;
input				ic_en;
input				icqmem_cycstb_i;
input				icqmem_ci_i;
input				tagcomp_miss;
input				biudata_valid;
input				biudata_error;
input	[31:0]			start_addr;
output	[31:0]			saved_addr;
output	[3:0]			icram_we;
output				biu_read;
output				first_hit_ack;
output				first_miss_ack;
output				first_miss_err;
output				burst;
output				tag_we;

//
// Internal wires and regs
//
reg	[31:0]			saved_addr_r;
reg	[1:0]			state;
reg	[2:0]			cnt;
reg				hitmiss_eval;
reg				load;
reg				cache_inhibit;

   //
   // Generate of ICRAM write enables
   //
   assign icram_we = {4{biu_read & biudata_valid & !cache_inhibit}};
   assign tag_we = biu_read & biudata_valid & !cache_inhibit;

   //
   // BIU read and write
   //
   assign biu_read = (hitmiss_eval & tagcomp_miss) | (!hitmiss_eval & load);

   //assign saved_addr = hitmiss_eval ? start_addr : saved_addr_r;
   assign saved_addr = saved_addr_r;

   //
   // Assert for cache hit first word ready
   // Assert for cache miss first word stored/loaded OK
   // Assert for cache miss first word stored/loaded with an error
   //
   assign first_hit_ack = (state == `OR1200_ICFSM_CFETCH) & hitmiss_eval & 
			  !tagcomp_miss & !cache_inhibit;
   assign first_miss_ack = (state == `OR1200_ICFSM_CFETCH) & biudata_valid;
   assign first_miss_err = (state == `OR1200_ICFSM_CFETCH) & biudata_error;

   //
   // Assert burst when doing reload of complete cache line
   //
   assign burst = (state == `OR1200_ICFSM_CFETCH) & tagcomp_miss & 
		  !cache_inhibit | (state == `OR1200_ICFSM_LREFILL3);

   //
   // Main IC FSM
   //
   always @(posedge clk ) begin
      if (rst == `OR1200_RST_VALUE) begin
	 state <=  `OR1200_ICFSM_IDLE;
	 saved_addr_r <=  32'b0;
	 hitmiss_eval <=  1'b0;
	 load <=  1'b0;
	 cnt <=  3'b000;
	 cache_inhibit <=  1'b0;
      end
      else
	case (state)	// synopsys parallel_case
	  `OR1200_ICFSM_IDLE :
	    if (ic_en & icqmem_cycstb_i) begin		// fetch
	       state <=  `OR1200_ICFSM_CFETCH;
	       saved_addr_r <=  start_addr;
	       hitmiss_eval <=  1'b1;
	       load <=  1'b1;
	       cache_inhibit <=  icqmem_ci_i;
	    end
	    else begin			// idle
	       hitmiss_eval <=  1'b0;
	       load <=  1'b0;
	       cache_inhibit <=  1'b0;
	    end
	  `OR1200_ICFSM_CFETCH: begin	// fetch
	     
	     if (icqmem_cycstb_i & icqmem_ci_i)
	       cache_inhibit <=  1'b1;
	     
	     if (hitmiss_eval)
	       saved_addr_r[31:13] <=  start_addr[31:13];
	     
	     if ((!ic_en) ||
		 // fetch aborted (usually caused by IMMU)
		 (hitmiss_eval & !icqmem_cycstb_i) ||	
		 (biudata_error) ||  // fetch terminated with an error
		 // fetch from cache-inhibited page
		 (cache_inhibit & biudata_valid)) begin	
		state <=  `OR1200_ICFSM_IDLE;
		hitmiss_eval <=  1'b0;
		load <=  1'b0;
		cache_inhibit <=  1'b0;
	     end // if ((!ic_en) ||...	     
	     // fetch missed, finish current external fetch and refill
	     else if (tagcomp_miss & biudata_valid) begin	
		state <=  `OR1200_ICFSM_LREFILL3;
		saved_addr_r[3:2] <=  saved_addr_r[3:2] + 1'd1;
		hitmiss_eval <=  1'b0;
		cnt <=  `OR1200_ICLS-2;
		cache_inhibit <=  1'b0;
	     end
	     // fetch aborted (usually caused by exception)
	     else if (!icqmem_cycstb_i) begin	
		state <=  `OR1200_ICFSM_IDLE;
		hitmiss_eval <=  1'b0;
		load <=  1'b0;
		cache_inhibit <=  1'b0;
	     end
	     // fetch hit, finish immediately
	     else if (!tagcomp_miss & !icqmem_ci_i) begin 
		saved_addr_r <=  start_addr;
		cache_inhibit <=  1'b0;
	     end
	     else   // fetch in-progress
	       hitmiss_eval <=  1'b0;
	  end
	  `OR1200_ICFSM_LREFILL3 : begin
	     // abort because IC has just been turned off
             if (!ic_en) begin
		// invalidate before IC can be turned on
		state <=  `OR1200_ICFSM_IDLE;	
                saved_addr_r <=  start_addr;
                hitmiss_eval <=  1'b0;
                load <=  1'b0;
             end
	     // refill ack, more fetchs to come
	     else if (biudata_valid && (|cnt)) begin	
		cnt <=  cnt - 3'd1;
		saved_addr_r[3:2] <=  saved_addr_r[3:2] + 1'd1;
	     end
	     // last fetch of line refill
	     else if (biudata_valid) begin
		state <=  `OR1200_ICFSM_IDLE;
		saved_addr_r <=  start_addr;
		hitmiss_eval <=  1'b0;
		load <=  1'b0;
	     end
	  end
	  default:
	    state <=  `OR1200_ICFSM_IDLE;
	endcase
   end

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's IC RAMs                                            ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/cores/or1k/                        ////
////                                                              ////
////  Description                                                 ////
////  Instantiation of Instruction cache data rams                ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_ic_ram.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//
// Revision 1.6  2004/06/08 18:17:36  lampret
// Non-functional changes. Coding style fixes.
//
// Revision 1.5  2004/04/08 11:00:46  simont
// Add support for 512B instruction cache.
//
// Revision 1.4  2004/04/05 08:29:57  lampret
// Merged branch_qmem into main tree.
//
// Revision 1.2.4.1  2003/12/09 11:46:48  simons
// Mbist nameing changed, Artisan ram instance signal names fixed, some synthesis waning fixed.
//
// Revision 1.2  2002/10/17 20:04:40  lampret
// Added BIST scan. Special VS RAMs need to be used to implement BIST.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.9  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.8  2001/10/14 13:12:09  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
// Revision 1.3  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.2  2001/07/22 03:31:54  lampret
// Fixed RAM's oen bug. Cache bypass under development.
//
// Revision 1.1  2001/07/20 00:46:03  lampret
// Development version of RTL. Libraries are missing.
//
//

// synopsys translate_off
// synopsys translate_on

module or1200_ic_ram(
	// Clock and reset
	clk, rst, 

`ifdef OR1200_BIST
	// RAM BIST
	mbist_si_i, mbist_so_o, mbist_ctrl_i,
`endif

	// Internal i/f
	addr, en, we, datain, dataout
);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_ICINDX;

//
// I/O
//
input 				clk;
input				rst;
input	[aw-1:0]		addr;
input				en;
input	[3:0]			we;
input	[dw-1:0]		datain;
output	[dw-1:0]		dataout;
`ifdef OR1200_GF_ARM_28SLP 
wire				gwen;
wire				cen;
wire [3:0]			wen;
`endif   

`ifdef OR1200_BIST
//
// RAM BIST
//
input mbist_si_i;
input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;
output mbist_so_o;
`endif

`ifdef OR1200_NO_IC

//
// Insn cache not implemented
//
assign dataout = {dw{1'b0}};
`ifdef OR1200_BIST
assign mbist_so_o = mbist_si_i;
`endif

`else

//
// Instantiation of IC RAM block
//
`ifdef OR1200_IC_1W_512B
   or1200_spram #
     (
      .aw(9),
      .dw(32)
      )
`endif
`ifdef OR1200_IC_1W_4KB
   or1200_spram #
     (
      .aw(10),
      .dw(32)
      )
`endif
`ifdef OR1200_IC_1W_8KB
`ifdef OR1200_GF_ARM_28SLP
   assign gwen = !(|we);
   assign cen = ~en;
   assign wen = ~we;
   
   sp_hsc_2048x32bw ic_ram0
     (
      .Q(dataout),
      .CLK(clk),
      .CEN(cen),
      .WEN(wen),
      .A(addr),
      .D(datain),
      .EMA(3'b000),
      .EMAW(2'b00),
      .EMAS(1'b0),
      .GWEN(gwen),
      .RET1N(1'b1)
      );
`else   
   or1200_spram #
     (
      .aw(11),
      .dw(32)
      )
`endif // !`ifdef OR1200_GF_ARM_28SLP
`endif //  `ifdef OR1200_IC_1W_8KB

`ifndef OR1200_GF_ARM_28SLP
   ic_ram0
     (
`ifdef OR1200_BIST
      // RAM BIST
      .mbist_si_i(mbist_si_i),
      .mbist_so_o(mbist_so_o),
      .mbist_ctrl_i(mbist_ctrl_i),
`endif
      .clk(clk),
      .ce(en),
      .we(we[0]),
      //.oe(1'b1),
      .addr(addr),
      .di(datain),
      .doq(dataout)
      );
`endif //  `ifndef OR1200_GF_ARM_28SLP
`endif // !`ifdef OR1200_NO_IC
   

endmodule



//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's IC TAGs                                            ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/cores/or1k/                        ////
////                                                              ////
////  Description                                                 ////
////  Instatiation of instruction cache tag rams                  ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_ic_tag.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//
// Revision 1.7  2004/06/08 18:17:36  lampret
// Non-functional changes. Coding style fixes.
//
// Revision 1.6  2004/04/08 11:00:46  simont
// Add support for 512B instruction cache.
//
// Revision 1.5  2004/04/05 08:29:57  lampret
// Merged branch_qmem into main tree.
//
// Revision 1.3.4.1  2003/12/09 11:46:48  simons
// Mbist nameing changed, Artisan ram instance signal names fixed, some synthesis waning fixed.
//
// Revision 1.3  2002/10/24 22:19:04  mohor
// Signal scanb_eni renamed to scanb_en
//
// Revision 1.2  2002/10/17 20:04:40  lampret
// Added BIST scan. Special VS RAMs need to be used to implement BIST.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.8  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.7  2001/10/14 13:12:09  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
// Revision 1.2  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.1  2001/07/20 00:46:03  lampret
// Development version of RTL. Libraries are missing.
//
//

// synopsys translate_off
// synopsys translate_on

module or1200_ic_tag(
	// Clock and reset
	clk, rst,

`ifdef OR1200_BIST
	// RAM BIST
	mbist_si_i, mbist_so_o, mbist_ctrl_i,
`endif

	// Internal i/f
	addr, en, we, datain, tag_v, tag
);

parameter dw = `OR1200_ICTAG_W;
parameter aw = `OR1200_ICTAG;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

`ifdef OR1200_BIST
//
// RAM BIST
//
input mbist_si_i;
input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;
output mbist_so_o;
`endif

//
// Internal i/f
//
input	[aw-1:0]		addr;
input				en;
input				we;
input	[dw-1:0]		datain;
output				tag_v;
output	[dw-2:0]		tag;

//
// Internal wires and regs
//
`ifdef OR1200_GF_ARM_28SLP 
wire				cen;
wire				wen;
wire				unused;
`endif      

`ifdef OR1200_NO_IC

//
// Insn cache not implemented
//
assign tag = {dw-1{1'b0}};
assign tag_v = 1'b0;
`ifdef OR1200_BIST
assign mbist_so_o = mbist_si_i;
`endif

`else

//
// Instantiation of TAG RAM block
//
`ifdef OR1200_IC_1W_512B
//or1200_spram_32x24 ic_tag0(
   or1200_spram #
     (
      .aw(5),
      .dw(24)
      )
`endif
`ifdef OR1200_IC_1W_4KB
//or1200_spram_256x21 ic_tag0(
   or1200_spram #
     (
      .aw(8),
      .dw(21)
      )
`endif
`ifdef OR1200_IC_1W_8KB
`ifdef OR1200_GF_ARM_28SLP
   assign cen = ~en;
   assign wen = ~we;
   
    sp_hsc_512x21 ic_tag0
     (
      .Q({unused, tag, tag_v}),
      .CLK(clk),
      .CEN(cen),
      .WEN(wen),
      .A(addr),
      .D({1'b0, datain}),
      .EMA(3'b000),
      .EMAW(2'b00),
      .EMAS(1'b0),      
      .RET1N(1'b1)
      );
`else   
//or1200_spram_512x20 ic_tag0(
   or1200_spram #
     (
      .aw(9),
      .dw(20)
      )
`endif // !`ifdef OR1200_GF_ARM_28SLP
`endif //  `ifdef OR1200_IC_1W_8KB
   
`ifndef OR1200_GF_ARM_28SLP   
   ic_tag0
     (
`ifdef OR1200_BIST
      // RAM BIST
      .mbist_si_i(mbist_si_i),
      .mbist_so_o(mbist_so_o),
      .mbist_ctrl_i(mbist_ctrl_i),
`endif
      .clk(clk),
      .ce(en),
      .we(we),
      //.oe(1'b1),
      .addr(addr),
      .di(datain),
      .doq({tag, tag_v})
      );
`endif //  `ifndef OR1200_GF_ARM_28SLP
`endif // !`ifdef OR1200_NO_IC
   

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Data Cache top level                               ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Instantiation of all IC blocks.                             ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_ic_top.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 

// synopsys translate_off
// synopsys translate_on

//
// Data cache
//
module or1200_ic_top(
	// Rst, clk and clock control
	clk, rst,

	// External i/f
	icbiu_dat_o, icbiu_adr_o, icbiu_cyc_o, icbiu_stb_o, icbiu_we_o, icbiu_sel_o, icbiu_cab_o,
	icbiu_dat_i, icbiu_ack_i, icbiu_err_i,

	// Internal i/f
	ic_en,
	icqmem_adr_i, icqmem_cycstb_i, icqmem_ci_i,
	icqmem_sel_i, icqmem_tag_i,
	icqmem_dat_o, icqmem_ack_o, icqmem_rty_o, icqmem_err_o, icqmem_tag_o,

`ifdef OR1200_BIST
	// RAM BIST
	mbist_si_i, mbist_so_o, mbist_ctrl_i,
`endif

	// SPRs
	spr_cs, spr_write, spr_dat_i
);

parameter dw = `OR1200_OPERAND_WIDTH;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// External I/F
//
output	[dw-1:0]		icbiu_dat_o;
output	[31:0]			icbiu_adr_o;
output				icbiu_cyc_o;
output				icbiu_stb_o;
output				icbiu_we_o;
output	[3:0]			icbiu_sel_o;
output				icbiu_cab_o;
input	[dw-1:0]		icbiu_dat_i;
input				icbiu_ack_i;
input				icbiu_err_i;

//
// Internal I/F
//
input				ic_en;
input	[31:0]			icqmem_adr_i;
input				icqmem_cycstb_i;
input				icqmem_ci_i;
input	[3:0]			icqmem_sel_i;
input	[3:0]			icqmem_tag_i;
output	[dw-1:0]		icqmem_dat_o;
output				icqmem_ack_o;
output				icqmem_rty_o;
output				icqmem_err_o;
output	[3:0]			icqmem_tag_o;

`ifdef OR1200_BIST
//
// RAM BIST
//
input mbist_si_i;
input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;
output mbist_so_o;
`endif

//
// SPR access
//
input				spr_cs;
input				spr_write;
input	[31:0]			spr_dat_i;

//
// Internal wires and regs
//
wire				tag_v;
wire	[`OR1200_ICTAG_W-2:0]	tag;
wire	[dw-1:0]		to_icram;
wire	[dw-1:0]		from_icram;
wire	[31:0]			saved_addr;
wire	[3:0]			icram_we;
wire				ictag_we;
wire	[31:0]			ic_addr;
wire				icfsm_biu_read;
reg				tagcomp_miss;
wire	[`OR1200_ICINDXH:`OR1200_ICLS]	ictag_addr;
wire				ictag_en;
wire				ictag_v; 
wire				ic_inv;
wire				icfsm_first_hit_ack;
wire				icfsm_first_miss_ack;
wire				icfsm_first_miss_err;
wire				icfsm_burst;
wire				icfsm_tag_we;
`ifdef OR1200_BIST
//
// RAM BIST
//
wire				mbist_ram_so;
wire				mbist_tag_so;
wire				mbist_ram_si = mbist_si_i;
wire				mbist_tag_si = mbist_ram_so;
assign				mbist_so_o = mbist_tag_so;
`endif

//
// Simple assignments
//
assign icbiu_adr_o = ic_addr;
assign ic_inv = spr_cs & spr_write;
assign ictag_we = icfsm_tag_we | ic_inv;
assign ictag_addr = ic_inv ? 
		    spr_dat_i[`OR1200_ICINDXH:`OR1200_ICLS] : 
		    ic_addr[`OR1200_ICINDXH:`OR1200_ICLS];
assign ictag_en = ic_inv | ic_en;
assign ictag_v = ~ic_inv;

//
// Data to BIU is from ICRAM when IC is enabled or from LSU when
// IC is disabled
//
assign icbiu_dat_o = 32'h00000000;

//
// Bypases of the IC when IC is disabled
//
assign icbiu_cyc_o = (ic_en) ? icfsm_biu_read : icqmem_cycstb_i;
assign icbiu_stb_o = (ic_en) ? icfsm_biu_read : icqmem_cycstb_i;
assign icbiu_we_o = 1'b0;
assign icbiu_sel_o = (ic_en & icfsm_biu_read) ? 4'b1111 : icqmem_sel_i;
assign icbiu_cab_o = (ic_en) ? icfsm_burst : 1'b0;
assign icqmem_rty_o = ~icqmem_ack_o & ~icqmem_err_o;
assign icqmem_tag_o = icqmem_err_o ? `OR1200_ITAG_BE : icqmem_tag_i;

//
// CPU normal and error termination
//
assign icqmem_ack_o = ic_en ? (icfsm_first_hit_ack | icfsm_first_miss_ack) : icbiu_ack_i;
assign icqmem_err_o = ic_en ? icfsm_first_miss_err : icbiu_err_i;

//
// Select between claddr generated by IC FSM and addr[3:2] generated by LSU
//
assign ic_addr = (icfsm_biu_read) ? saved_addr : icqmem_adr_i;

//
// Select between input data generated by LSU or by BIU
//
assign to_icram = icbiu_dat_i;

//
// Select between data generated by ICRAM or passed by BIU
//
assign icqmem_dat_o = icfsm_first_miss_ack | !ic_en ? icbiu_dat_i : from_icram;

//
// Tag comparison
//
always @(tag or saved_addr or tag_v) begin
	if ((tag != saved_addr[31:`OR1200_ICTAGL]) || !tag_v)
		tagcomp_miss = 1'b1;
	else
		tagcomp_miss = 1'b0;
end

//
// Instantiation of IC Finite State Machine
//
or1200_ic_fsm or1200_ic_fsm(
	.clk(clk),
	.rst(rst),
	.ic_en(ic_en),
	.icqmem_cycstb_i(icqmem_cycstb_i),
	.icqmem_ci_i(icqmem_ci_i),
	.tagcomp_miss(tagcomp_miss),
	.biudata_valid(icbiu_ack_i),
	.biudata_error(icbiu_err_i),
	.start_addr(icqmem_adr_i),
	.saved_addr(saved_addr),
	.icram_we(icram_we),
	.biu_read(icfsm_biu_read),
	.first_hit_ack(icfsm_first_hit_ack),
	.first_miss_ack(icfsm_first_miss_ack),
	.first_miss_err(icfsm_first_miss_err),
	.burst(icfsm_burst),
	.tag_we(icfsm_tag_we)
);

//
// Instantiation of IC main memory
//
or1200_ic_ram or1200_ic_ram(
	.clk(clk),
	.rst(rst),
`ifdef OR1200_BIST
	// RAM BIST
	.mbist_si_i(mbist_ram_si),
	.mbist_so_o(mbist_ram_so),
	.mbist_ctrl_i(mbist_ctrl_i),
`endif
	.addr(ic_addr[`OR1200_ICINDXH:2]),
	.en(ic_en),
	.we(icram_we),
	.datain(to_icram),
	.dataout(from_icram)
);

//
// Instantiation of IC TAG memory
//
or1200_ic_tag or1200_ic_tag(
	.clk(clk),
	.rst(rst),
`ifdef OR1200_BIST
	// RAM BIST
	.mbist_si_i(mbist_tag_si),
	.mbist_so_o(mbist_tag_so),
	.mbist_ctrl_i(mbist_ctrl_i),
`endif
	.addr(ictag_addr),
	.en(ictag_en),
	.we(ictag_we),
	.datain({ic_addr[31:`OR1200_ICTAGL], ictag_v}),
	.tag_v(tag_v),
	.tag(tag)
);

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's instruction fetch                                  ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  PC, instruction fetch, interface to IC.                     ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_if.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 

// synopsys translate_off
// synopsys translate_on

module or1200_if(
	// Clock and reset
	clk, rst,

	// External i/f to IC
	icpu_dat_i, icpu_ack_i, icpu_err_i, icpu_adr_i, icpu_tag_i,

	// Internal i/f
	if_freeze, if_insn, if_pc, if_flushpipe, saving_if_insn, 
	if_stall, no_more_dslot, genpc_refetch, rfe,
	except_itlbmiss, except_immufault, except_ibuserr
);

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// External i/f to IC
//
input	[31:0]			icpu_dat_i;
input				icpu_ack_i;
input				icpu_err_i;
input	[31:0]			icpu_adr_i;
input	[3:0]			icpu_tag_i;

//
// Internal i/f
//
input				if_freeze;
output	[31:0]			if_insn;
output	[31:0]			if_pc;
input				if_flushpipe;
output				saving_if_insn;
output				if_stall;
input				no_more_dslot;
output				genpc_refetch;
input				rfe;
output				except_itlbmiss;
output				except_immufault;
output				except_ibuserr;

//
// Internal wires and regs
//
wire			save_insn;
wire			if_bypass;
reg			if_bypass_reg;
reg	[31:0]		insn_saved;
reg	[31:0]		addr_saved;
reg	[2:0]		err_saved;
reg			saved;

assign save_insn = (icpu_ack_i | icpu_err_i) & if_freeze & !saved;
assign saving_if_insn = !if_flushpipe & save_insn;

//
// IF bypass 
//
assign if_bypass = icpu_adr_i[0] ? 1'b0 : if_bypass_reg | if_flushpipe;

always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		if_bypass_reg <=  1'b0;
	else
		if_bypass_reg <=  if_bypass;

//
// IF stage insn
//
assign if_insn = no_more_dslot | rfe | if_bypass ? {`OR1200_OR32_NOP, 26'h041_0000} : saved ? insn_saved : icpu_ack_i ? icpu_dat_i : {`OR1200_OR32_NOP, 26'h061_0000};
assign if_pc = saved ? addr_saved : {icpu_adr_i[31:2], 2'h0};
assign if_stall = !icpu_err_i & !icpu_ack_i & !saved;
assign genpc_refetch = saved & icpu_ack_i;
assign except_itlbmiss = no_more_dslot ? 1'b0 : saved ? err_saved[0] : icpu_err_i & (icpu_tag_i == `OR1200_ITAG_TE);
assign except_immufault = no_more_dslot ? 1'b0 : saved ? err_saved[1] : icpu_err_i & (icpu_tag_i == `OR1200_ITAG_PE);
assign except_ibuserr = no_more_dslot ? 1'b0 : saved ? err_saved[2] : icpu_err_i & (icpu_tag_i == `OR1200_ITAG_BE);

//
// Flag for saved insn/address
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		saved <=  1'b0;
	else if (if_flushpipe)
		saved <=  1'b0;
	else if (save_insn)
		saved <=  1'b1;
	else if (!if_freeze)
		saved <=  1'b0;

//
// Store fetched instruction
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		insn_saved <=  {`OR1200_OR32_NOP, 26'h041_0000};
	else if (if_flushpipe)
		insn_saved <=  {`OR1200_OR32_NOP, 26'h041_0000};
	else if (save_insn)
		insn_saved <=  icpu_err_i ? {`OR1200_OR32_NOP, 26'h041_0000} : icpu_dat_i;
	else if (!if_freeze)
		insn_saved <=  {`OR1200_OR32_NOP, 26'h041_0000};

//
// Store fetched instruction's address
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		addr_saved <=  32'h00000000;
	else if (if_flushpipe)
		addr_saved <=  32'h00000000;
	else if (save_insn)
		addr_saved <=  {icpu_adr_i[31:2], 2'b00};
	else if (!if_freeze)
		addr_saved <=  {icpu_adr_i[31:2], 2'b00};

//
// Store fetched instruction's error tags 
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		err_saved <=  3'b000;
	else if (if_flushpipe)
		err_saved <=  3'b000;
	else if (save_insn) begin
		err_saved[0] <=  icpu_err_i & (icpu_tag_i == `OR1200_ITAG_TE);
		err_saved[1] <=  icpu_err_i & (icpu_tag_i == `OR1200_ITAG_PE);
		err_saved[2] <=  icpu_err_i & (icpu_tag_i == `OR1200_ITAG_BE);
	end
	else if (!if_freeze)
		err_saved <=  3'b000;


endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Instruction TLB                                    ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/cores/or1k/                        ////
////                                                              ////
////  Description                                                 ////
////  Instantiation of ITLB.                                      ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_immu_tlb.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed, coding style changed. 
//
// Revision 1.9  2004/06/08 18:17:36  lampret
// Non-functional changes. Coding style fixes.
//
// Revision 1.8  2004/04/05 08:29:57  lampret
// Merged branch_qmem into main tree.
//
// Revision 1.6.4.1  2003/12/09 11:46:48  simons
// Mbist nameing changed, Artisan ram instance signal names fixed, some synthesis waning fixed.
//
// Revision 1.6  2002/10/28 16:34:32  mohor
// RAMs wrong connected to the BIST scan chain.
//
// Revision 1.5  2002/10/17 20:04:40  lampret
// Added BIST scan. Special VS RAMs need to be used to implement BIST.
//
// Revision 1.4  2002/08/14 06:23:50  lampret
// Disabled ITLB translation when 1) doing access to ITLB SPRs or 2) crossing page. This modification was tested only with parts of IMMU test - remaining test cases needs to be run.
//
// Revision 1.3  2002/02/11 04:33:17  lampret
// Speed optimizations (removed duplicate _cyc_ and _stb_). Fixed D/IMMU cache-inhibit attr.
//
// Revision 1.2  2002/01/28 01:16:00  lampret
// Changed 'void' nop-ops instead of insn[0] to use insn[16]. Debug unit stalls the tick timer. Prepared new flag generation for add and and insns. Blocked DC/IC while they are turned off. Fixed I/D MMU SPRs layout except WAYs. TODO: smart IC invalidate, l.j 2 and TLB ways.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.8  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.7  2001/10/14 13:12:09  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
//

// synopsys translate_off
// synopsys translate_on

//
// Insn TLB
//

module or1200_immu_tlb(
	// Rst and clk
	clk, rst,

	// I/F for translation
	tlb_en, vaddr, hit, ppn, uxe, sxe, ci, 

`ifdef OR1200_BIST
	// RAM BIST
	mbist_si_i, mbist_so_o, mbist_ctrl_i,
`endif

	// SPR access
	spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o
);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_OPERAND_WIDTH;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// I/F for translation
//
input				tlb_en;
input	[aw-1:0]		vaddr;
output				hit;
output	[31:`OR1200_IMMU_PS]	ppn;
output				uxe;
output				sxe;
output				ci;

`ifdef OR1200_BIST
//
// RAM BIST
//
input mbist_si_i;
input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;
output mbist_so_o;
`endif

//
// SPR access
//
input				spr_cs;
input				spr_write;
input	[31:0]			spr_addr;
input	[31:0]			spr_dat_i;
output	[31:0]			spr_dat_o;

//
// Internal wires and regs
//
wire	[`OR1200_ITLB_TAG]	vpn;
wire				v;
wire	[`OR1200_ITLB_INDXW-1:0]	tlb_index;
wire				tlb_mr_en;
wire				tlb_mr_we;
wire	[`OR1200_ITLBMRW-1:0]	tlb_mr_ram_in;
wire	[`OR1200_ITLBMRW-1:0]	tlb_mr_ram_out;
wire				tlb_tr_en;
wire				tlb_tr_we;
wire	[`OR1200_ITLBTRW-1:0]	tlb_tr_ram_in;
wire	[`OR1200_ITLBTRW-1:0]	tlb_tr_ram_out;

// BIST
`ifdef OR1200_BIST
wire                        itlb_mr_ram_si;
wire                        itlb_mr_ram_so;
wire                        itlb_tr_ram_si;
wire                        itlb_tr_ram_so;
`endif
`ifdef OR1200_GF_ARM_28SLP
wire [1:0]	 		unused;
wire				tlb_mr_cen;
wire	 			tlb_mr_wen;   
wire				tlb_tr_cen;
wire	 			tlb_tr_wen;
`endif
   
//
// Implemented bits inside match and translate registers
//
// itlbwYmrX: vpn 31-19  v 0
// itlbwYtrX: ppn 31-13  uxe 7  sxe 6
//
// itlb memory width:
// 19 bits for ppn
// 13 bits for vpn
// 1 bit for valid
// 2 bits for protection
// 1 bit for cache inhibit

//
// Enable for Match registers
//
assign tlb_mr_en = tlb_en | (spr_cs & !spr_addr[`OR1200_ITLB_TM_ADDR]);

//
// Write enable for Match registers
//
assign tlb_mr_we = spr_cs & spr_write & !spr_addr[`OR1200_ITLB_TM_ADDR];

//
// Enable for Translate registers
//
assign tlb_tr_en = tlb_en | (spr_cs & spr_addr[`OR1200_ITLB_TM_ADDR]);

//
// Write enable for Translate registers
//
assign tlb_tr_we = spr_cs & spr_write & spr_addr[`OR1200_ITLB_TM_ADDR];

//
// Output to SPRS unit
//
assign spr_dat_o = (!spr_write & !spr_addr[`OR1200_ITLB_TM_ADDR]) ?
            {vpn, tlb_index, {`OR1200_ITLB_TAGW-7{1'b0}}, 1'b0, 5'b00000, v} :
		(!spr_write & spr_addr[`OR1200_ITLB_TM_ADDR]) ?
			{ppn, {`OR1200_IMMU_PS-8{1'b0}}, uxe, sxe, {4{1'b0}}, ci, 1'b0} :
			32'h00000000;

//
// Assign outputs from Match registers
//
assign {vpn, v} = tlb_mr_ram_out;

//
// Assign to Match registers inputs
//
assign tlb_mr_ram_in = {spr_dat_i[`OR1200_ITLB_TAG], spr_dat_i[`OR1200_ITLBMR_V_BITS]};

//
// Assign outputs from Translate registers
//
assign {ppn, uxe, sxe, ci} = tlb_tr_ram_out;

//
// Assign to Translate registers inputs
//
assign tlb_tr_ram_in = {spr_dat_i[31:`OR1200_IMMU_PS],
			spr_dat_i[`OR1200_ITLBTR_UXE_BITS],
			spr_dat_i[`OR1200_ITLBTR_SXE_BITS],
			spr_dat_i[`OR1200_ITLBTR_CI_BITS]};

//
// Generate hit
//
assign hit = (vpn == vaddr[`OR1200_ITLB_TAG]) & v;

//
// TLB index is normally vaddr[18:13]. If it is SPR access then index is
// spr_addr[5:0].
//
assign tlb_index = spr_cs ? spr_addr[`OR1200_ITLB_INDXW-1:0] : vaddr[`OR1200_ITLB_INDX];


`ifdef OR1200_BIST
assign itlb_mr_ram_si = mbist_si_i;
assign itlb_tr_ram_si = itlb_mr_ram_so;
assign mbist_so_o = itlb_tr_ram_so;
`endif


//
// Instantiation of ITLB Match Registers
//
`ifdef OR1200_GF_ARM_28SLP
   assign tlb_mr_cen = ~tlb_mr_en;
   assign tlb_mr_wen = ~tlb_mr_we;
   
   sp_hsc_128x14 itlb_mr_ram
     (
      .Q(tlb_mr_ram_out),
      .CLK(clk),
      .CEN(tlb_mr_cen),
      .WEN(tlb_mr_wen),
      .A({1'b0, tlb_index}),
      .D(tlb_mr_ram_in),
      .EMA(3'b000),
      .EMAW(2'b00),
      .EMAS(1'b0),      
      .RET1N(1'b1)
      );
`else   
   or1200_spram #
     (
      .aw(6),
      .dw(14)
      )
   itlb_mr_ram
     (
      .clk(clk),
`ifdef OR1200_BIST
      // RAM BIST
      .mbist_si_i(itlb_mr_ram_si),
      .mbist_so_o(itlb_mr_ram_so),
      .mbist_ctrl_i(mbist_ctrl_i),
`endif
      .ce(tlb_mr_en),
      .we(tlb_mr_we),
      //.oe(1'b1),
      .addr(tlb_index),
      .di(tlb_mr_ram_in),
      .doq(tlb_mr_ram_out)
      );
`endif // !`ifdef OR1200_GF_ARM_28SLP
   

//
// Instantiation of ITLB Translate Registers
//

`ifdef OR1200_GF_ARM_28SLP
   assign tlb_tr_cen = ~tlb_tr_en;
   assign tlb_tr_wen = ~tlb_tr_we;
   
   sp_hsc_128x24 itlb_tr_ram
     (
      .Q({unused, tlb_tr_ram_out}),
      .CLK(clk),
      .CEN(tlb_tr_cen),
      .WEN(tlb_tr_wen),
      .A({1'b0, tlb_index}),      
      .D({2'b00, tlb_tr_ram_in}),
      .EMA(3'b000),
      .EMAW(2'b00),
      .EMAS(1'b0),      
      .RET1N(1'b1)
      );
`else      
   or1200_spram #
     (
      .aw(6),
      .dw(22)
      )
   itlb_tr_ram
     (
      .clk(clk),
`ifdef OR1200_BIST
      // RAM BIST
      .mbist_si_i(itlb_tr_ram_si),
      .mbist_so_o(itlb_tr_ram_so),
      .mbist_ctrl_i(mbist_ctrl_i),
`endif
      .ce(tlb_tr_en),
      .we(tlb_tr_we),
      //.oe(1'b1),
      .addr(tlb_index),
      .di(tlb_tr_ram_in),
      .doq(tlb_tr_ram_out)
      );
`endif // !`ifdef OR1200_GF_ARM_28SLP
   
   
endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Instruction MMU top level                          ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/cores/or1k/                        ////
////                                                              ////
////  Description                                                 ////
////  Instantiation of all IMMU blocks.                           ////
////                                                              ////
////  To Do:                                                      ////
////   - cache inhibit                                            ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_immu_top.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 
//
// Revision 1.15  2004/06/08 18:17:36  lampret
// Non-functional changes. Coding style fixes.
//
// Revision 1.14  2004/04/05 08:29:57  lampret
// Merged branch_qmem into main tree.
//
// Revision 1.12.4.2  2003/12/09 11:46:48  simons
// Mbist nameing changed, Artisan ram instance signal names fixed, some synthesis waning fixed.
//
// Revision 1.12.4.1  2003/07/08 15:36:37  lampret
// Added embedded memory QMEM.
//
// Revision 1.12  2003/06/06 02:54:47  lampret
// When OR1200_NO_IMMU and OR1200_NO_IC are not both defined or undefined at the same time, results in a IC bug. Fixed.
//
// Revision 1.11  2002/10/17 20:04:40  lampret
// Added BIST scan. Special VS RAMs need to be used to implement BIST.
//
// Revision 1.10  2002/09/16 03:08:56  lampret
// Disabled cache inhibit atttribute.
//
// Revision 1.9  2002/08/18 19:54:17  lampret
// Added store buffer.
//
// Revision 1.8  2002/08/14 06:23:50  lampret
// Disabled ITLB translation when 1) doing access to ITLB SPRs or 2) crossing page. This modification was tested only with parts of IMMU test - remaining test cases needs to be run.
//
// Revision 1.7  2002/08/12 05:31:30  lampret
// Delayed external access at page crossing.
//
// Revision 1.6  2002/03/29 15:16:56  lampret
// Some of the warnings fixed.
//
// Revision 1.5  2002/02/11 04:33:17  lampret
// Speed optimizations (removed duplicate _cyc_ and _stb_). Fixed D/IMMU cache-inhibit attr.
//
// Revision 1.4  2002/02/01 19:56:54  lampret
// Fixed combinational loops.
//
// Revision 1.3  2002/01/28 01:16:00  lampret
// Changed 'void' nop-ops instead of insn[0] to use insn[16]. Debug unit stalls the tick timer. Prepared new flag generation for add and and insns. Blocked DC/IC while they are turned off. Fixed I/D MMU SPRs layout except WAYs. TODO: smart IC invalidate, l.j 2 and TLB ways.
//
// Revision 1.2  2002/01/14 06:18:22  lampret
// Fixed mem2reg bug in FAST implementation. Updated debug unit to work with new genpc/if.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.6  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.5  2001/10/14 13:12:09  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
// Revision 1.1  2001/08/17 08:03:35  lampret
// *** empty log message ***
//
// Revision 1.2  2001/07/22 03:31:53  lampret
// Fixed RAM's oen bug. Cache bypass under development.
//
// Revision 1.1  2001/07/20 00:46:03  lampret
// Development version of RTL. Libraries are missing.
//
//

// synopsys translate_off
// synopsys translate_on

//
// Insn MMU
//

module or1200_immu_top(
	// Rst and clk
	clk, rst,

	// CPU i/f
	ic_en, immu_en, supv, icpu_adr_i, icpu_cycstb_i,
	icpu_adr_o, icpu_tag_o, icpu_rty_o, icpu_err_o,

	// SR Interface
	boot_adr_sel_i,

	// SPR access
	spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o,

`ifdef OR1200_BIST
	// RAM BIST
	mbist_si_i, mbist_so_o, mbist_ctrl_i,
`endif

	// QMEM i/f
	qmemimmu_rty_i, qmemimmu_err_i, qmemimmu_tag_i, qmemimmu_adr_o, qmemimmu_cycstb_o, qmemimmu_ci_o
);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_OPERAND_WIDTH;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// CPU I/F
//
input				ic_en;
input				immu_en;
input				supv;
input	[aw-1:0]		icpu_adr_i;
input				icpu_cycstb_i;
output	[aw-1:0]		icpu_adr_o;
output	[3:0]			icpu_tag_o;
output				icpu_rty_o;
output				icpu_err_o;

//
// SR Interface
//
input				boot_adr_sel_i;

//
// SPR access
//
input				spr_cs;
input				spr_write;
input	[aw-1:0]		spr_addr;
input	[31:0]			spr_dat_i;
output	[31:0]			spr_dat_o;

`ifdef OR1200_BIST
//
// RAM BIST
//
input mbist_si_i;
input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;
output mbist_so_o;
`endif

//
// IC I/F
//
input				qmemimmu_rty_i;
input				qmemimmu_err_i;
input	[3:0]			qmemimmu_tag_i;
output	[aw-1:0]		qmemimmu_adr_o;
output				qmemimmu_cycstb_o;
output				qmemimmu_ci_o;

//
// Internal wires and regs
//
wire				itlb_spr_access;
wire	[31:`OR1200_IMMU_PS]	itlb_ppn;
wire				itlb_hit;
wire				itlb_uxe;
wire				itlb_sxe;
wire	[31:0]			itlb_dat_o;
wire				itlb_en;
wire				itlb_ci;
wire				itlb_done;
wire				fault;
wire				miss;
wire				page_cross;
reg	[31:0]			icpu_adr_default;
wire	[31:0]			icpu_adr_boot;
reg				icpu_adr_select;
reg		[31:0]		icpu_adr_o;
reg	[31:`OR1200_IMMU_PS]	icpu_vpn_r;
`ifdef OR1200_NO_IMMU
`else
reg				itlb_en_r;
reg				dis_spr_access_frst_clk;
reg				dis_spr_access_scnd_clk;
`endif

//
// Implemented bits inside match and translate registers
//
// itlbwYmrX: vpn 31-10  v 0
// itlbwYtrX: ppn 31-10  uxe 7  sxe 6
//
// itlb memory width:
// 19 bits for ppn
// 13 bits for vpn
// 1 bit for valid
// 2 bits for protection
// 1 bit for cache inhibit

//
// icpu_adr_o
//
`ifdef OR1200_REGISTERED_OUTPUTS
always @( posedge clk)
	// default value 
	if (rst == `OR1200_RST_VALUE) begin
		icpu_adr_default <=  32'h0000_0100;
		icpu_adr_select  <=  1'b1;		// select async. value due to reset state
	end
	// selected value (different from default) is written into FF after reset state
	else if (icpu_adr_select) begin
		icpu_adr_default <=  icpu_adr_boot;	// dynamic value can only be assigned to FF out of reset! 
		icpu_adr_select  <=  1'b0;		// select FF value 
	end
	else begin
		icpu_adr_default <=  icpu_adr_i;
	end

// select async. value for boot address after reset - PC jumps to the address selected after boot! 
//assign icpu_adr_boot = {(boot_adr_sel_i ? `OR1200_EXCEPT_EPH1_P : `OR1200_EXCEPT_EPH0_P), 12'h100} ;
   assign icpu_adr_boot = `OR1200_BOOT_ADR; // jb

always @(icpu_adr_boot or icpu_adr_default or icpu_adr_select)
	if (icpu_adr_select)
		icpu_adr_o = icpu_adr_boot ;		// async. value is selected due to reset state 
	else
		icpu_adr_o = icpu_adr_default ;		// FF value is selected 2nd clock after reset state 
`else
Unsupported !!!
`endif

//
// Page cross
//
// Asserted when CPU address crosses page boundary. Most of the time it is zero.
//
assign page_cross = icpu_adr_i[31:`OR1200_IMMU_PS] != icpu_vpn_r;

//
// Register icpu_adr_i's VPN for use when IMMU is not enabled but PPN is expected to come
// one clock cycle after offset part.
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		icpu_vpn_r <=  {32-`OR1200_IMMU_PS{1'b0}};
	else
		icpu_vpn_r <=  icpu_adr_i[31:`OR1200_IMMU_PS];

`ifdef OR1200_NO_IMMU

//
// Put all outputs in inactive state
//
assign spr_dat_o = 32'h00000000;
assign qmemimmu_adr_o = icpu_adr_i;
assign icpu_tag_o = qmemimmu_tag_i;
assign qmemimmu_cycstb_o = icpu_cycstb_i & ~page_cross;
assign icpu_rty_o = qmemimmu_rty_i;
assign icpu_err_o = qmemimmu_err_i;
assign qmemimmu_ci_o = `OR1200_IMMU_CI;
`ifdef OR1200_BIST
assign mbist_so_o = mbist_si_i;
`endif
`else

//
// ITLB SPR access
//
// 1200 - 12FF  itlbmr w0
// 1200 - 123F  itlbmr w0 [63:0]
//
// 1300 - 13FF  itlbtr w0
// 1300 - 133F  itlbtr w0 [63:0]
//
assign itlb_spr_access = spr_cs & ~dis_spr_access_scnd_clk;

//
// Disable ITLB SPR access
//
// This flops are used to mask ITLB miss/fault exception
// during first & second clock cycles of accessing ITLB SPR. In
// subsequent clock cycles it is assumed that ITLB SPR
// access was accomplished and that normal instruction fetching
// can proceed.
//
// spr_cs sets dis_spr_access_frst_clk and icpu_rty_o clears it.
// dis_spr_access_frst_clk  sets dis_spr_access_scnd_clk and 
// icpu_rty_o clears it.
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dis_spr_access_frst_clk  <=  1'b0;
	else if (!icpu_rty_o)
		dis_spr_access_frst_clk  <=  1'b0;
	else if (spr_cs)
		dis_spr_access_frst_clk  <=  1'b1;

always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		dis_spr_access_scnd_clk  <=  1'b0;
	else if (!icpu_rty_o)
		dis_spr_access_scnd_clk  <=  1'b0;
	else if (dis_spr_access_frst_clk)
		dis_spr_access_scnd_clk  <=  1'b1;

//
// Tags:
//
// OR1200_ITAG_TE - TLB miss Exception
// OR1200_ITAG_PE - Page fault Exception
//
assign icpu_tag_o = miss ? `OR1200_ITAG_TE : fault ? `OR1200_ITAG_PE : qmemimmu_tag_i;

//
// icpu_rty_o
//
// assign icpu_rty_o = !icpu_err_o & qmemimmu_rty_i;
//assign icpu_rty_o = qmemimmu_rty_i | itlb_spr_access & immu_en;
assign icpu_rty_o = qmemimmu_rty_i;

//
// icpu_err_o
//
assign icpu_err_o = miss | fault | qmemimmu_err_i;

//
// Assert itlb_en_r after one clock cycle and when there is no
// ITLB SPR access
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		itlb_en_r <=  1'b0;
	else
		itlb_en_r <=  itlb_en & ~itlb_spr_access;

//
// ITLB lookup successful
//
assign itlb_done = itlb_en_r & ~page_cross;

//
// Cut transfer when access (mtspr/mfspr) to/from ITLB occure or if something goes 
// wrong with translation. If IC is disabled, use delayed signals.
//
// assign qmemimmu_cycstb_o = (!ic_en & immu_en) ? ~(miss | fault) & icpu_cycstb_i & ~page_cross : (miss | fault) ? 1'b0 : icpu_cycstb_i & ~page_cross; // DL
//assign qmemimmu_cycstb_o = immu_en ? ~(miss | fault) & icpu_cycstb_i & ~page_cross & itlb_done : icpu_cycstb_i & ~page_cross;
assign qmemimmu_cycstb_o = immu_en ? ~(miss | fault) & icpu_cycstb_i & ~page_cross & itlb_done & ~itlb_spr_access : icpu_cycstb_i & ~page_cross;

//
// Cache Inhibit
//
// Cache inhibit is not really needed for instruction memory subsystem.
// If we would doq it, we would doq it like this.
// assign qmemimmu_ci_o = immu_en ? itlb_done & itlb_ci : `OR1200_IMMU_CI;
// However this causes an async combinatorial loop so we stick to
// no cache inhibit.
//assign qmemimmu_ci_o = `OR1200_IMMU_CI;
// Cache inhibit without an async combinatorial loop 
assign qmemimmu_ci_o = immu_en ? itlb_ci : `OR1200_IMMU_CI;


//
// Physical address is either translated virtual address or
// simply equal when IMMU is disabled
//
//assign qmemimmu_adr_o = itlb_done ? {itlb_ppn, icpu_adr_i[`OR1200_IMMU_PS-1:0]} : {icpu_vpn_r, icpu_adr_i[`OR1200_IMMU_PS-1:0]}; // DL: immu_en
assign qmemimmu_adr_o = immu_en & itlb_done ? {itlb_ppn, icpu_adr_i[`OR1200_IMMU_PS-1:2], 2'h0} : {icpu_vpn_r, icpu_adr_i[`OR1200_IMMU_PS-1:2], 2'h0}; 

reg     [31:0]                  spr_dat_reg;
//
// Output to SPRS unit
//
// spr_dat_o is registered on the 1st clock of spr read 
// so itlb can continue with process during execution of mfspr.
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		spr_dat_reg <=  32'h0000_0000;
	else if (spr_cs & !dis_spr_access_scnd_clk)
		spr_dat_reg <=  itlb_dat_o;

assign spr_dat_o = itlb_spr_access ? itlb_dat_o : spr_dat_reg; 

//
// Page fault exception logic
//
assign fault = itlb_done &
			(  (!supv & !itlb_uxe)		// Execute in user mode not enabled
			|| (supv & !itlb_sxe));		// Execute in supv mode not enabled

//
// TLB Miss exception logic
//
assign miss = itlb_done & !itlb_hit;

//
// ITLB Enable
//
assign itlb_en = immu_en & icpu_cycstb_i;

//
// Instantiation of ITLB
//
or1200_immu_tlb or1200_immu_tlb(
	// Rst and clk
        .clk(clk),
	.rst(rst),

        // I/F for translation
        .tlb_en(itlb_en),
	.vaddr(icpu_adr_i),
	.hit(itlb_hit),
	.ppn(itlb_ppn),
	.uxe(itlb_uxe),
	.sxe(itlb_sxe),
	.ci(itlb_ci),

`ifdef OR1200_BIST
	// RAM BIST
	.mbist_si_i(mbist_si_i),
	.mbist_so_o(mbist_so_o),
	.mbist_ctrl_i(mbist_ctrl_i),
`endif

        // SPR access
        .spr_cs(itlb_spr_access),
	.spr_write(spr_write),
	.spr_addr(spr_addr),
	.spr_dat_i(spr_dat_i),
	.spr_dat_o(itlb_dat_o)
);

`endif

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's WISHBONE BIU                                       ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Implements WISHBONE interface                               ////
////                                                              ////
////  To Do:                                                      ////
////   - if biu_cyc/stb are deasserted and wb_ack_i is asserted   ////
////   and this happens even before aborted_r is asssrted,        ////
////   wb_ack_i will be delivered even though transfer is         ////
////   internally considered already aborted. However most        ////
////   wb_ack_i are externally registered and delayed. Normally   ////
////   this shouldn't cause any problems.                         ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_iwb_biu.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// This module is obsolete.
//

// synopsys translate_off
// synopsys translate_on

module or1200_iwb_biu();

	// THIS MODULE IS OBSOLETE !!! 
	// COMPLETELY REWRITTEN or1200_wb_biu.v IS USED INSTEAD !!!


endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Load/Store unit                                    ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Interface between CPU and DC.                               ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//
// $Log: or1200_lsu.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 
//

// synopsys translate_off
// synopsys translate_on

module or1200_lsu(
	// Clock and Reset
	clk, rst,

	// Internal i/f
	id_addrbase, ex_addrbase, id_addrofs, ex_addrofs, id_lsu_op, 
	lsu_datain, lsu_dataout, lsu_stall, lsu_unstall,
	du_stall, except_align, except_dtlbmiss, except_dmmufault, except_dbuserr,
	id_freeze, ex_freeze, flushpipe,

	// External i/f to DC
	dcpu_adr_o, dcpu_cycstb_o, dcpu_we_o, dcpu_sel_o, dcpu_tag_o, dcpu_dat_o,
	dcpu_dat_i, dcpu_ack_i, dcpu_rty_i, dcpu_err_i, dcpu_tag_i
);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_REGFILE_ADDR_WIDTH;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// Internal i/f
//
input	[31:0]			id_addrbase;
input	[31:0]			ex_addrbase;
input	[31:0]			id_addrofs;
input	[31:0]			ex_addrofs;
input	[`OR1200_LSUOP_WIDTH-1:0] id_lsu_op;
input	[dw-1:0]		lsu_datain;
output	[dw-1:0]		lsu_dataout;
output				lsu_stall;
output				lsu_unstall;
input                           du_stall;
output				except_align;
output				except_dtlbmiss;
output				except_dmmufault;
output				except_dbuserr;
input                           id_freeze;
input                           ex_freeze;
input                           flushpipe;

//
// External i/f to DC
//
output	[31:0]			dcpu_adr_o;
output				dcpu_cycstb_o;
output				dcpu_we_o;
output	[3:0]			dcpu_sel_o;
output	[3:0]			dcpu_tag_o;
output	[31:0]			dcpu_dat_o;
input	[31:0]			dcpu_dat_i;
input				dcpu_ack_i;
input				dcpu_rty_i;
input				dcpu_err_i;
input	[3:0]			dcpu_tag_i;

//
// Internal wires/regs
//
reg	[3:0]			dcpu_sel_o;

reg	[`OR1200_LSUOP_WIDTH-1:0] ex_lsu_op;
wire	[`OR1200_LSUEA_PRECALC:0] id_precalc_sum;
reg	[`OR1200_LSUEA_PRECALC:0] dcpu_adr_r;
reg				except_align;

//
// ex_lsu_op
//
always @(posedge clk ) begin
    if (rst == `OR1200_RST_VALUE)
        ex_lsu_op <=  `OR1200_LSUOP_NOP;
    else if (!ex_freeze & id_freeze | flushpipe)
        ex_lsu_op <=  `OR1200_LSUOP_NOP;
    else if (!ex_freeze)
        ex_lsu_op <=  id_lsu_op;
end

//
// Precalculate part of load/store EA in ID stage
//
assign id_precalc_sum = id_addrbase[`OR1200_LSUEA_PRECALC-1:0] +
                        id_addrofs[`OR1200_LSUEA_PRECALC-1:0];

always @(posedge clk ) begin
    if (rst == `OR1200_RST_VALUE)
        dcpu_adr_r <=  {`OR1200_LSUEA_PRECALC+1{1'b0}};
    else if (!ex_freeze)
        dcpu_adr_r <=  id_precalc_sum;
end

//
// Generate except_align in ID stage
//
always @(posedge clk ) begin
    if (rst == `OR1200_RST_VALUE)
        except_align <=  1'b0;
    else if (!ex_freeze & id_freeze | flushpipe)
        except_align <=  1'b0;
    else if (!ex_freeze)
        except_align <=  ((id_lsu_op == `OR1200_LSUOP_SH) |
                            (id_lsu_op == `OR1200_LSUOP_LHZ) |
                            (id_lsu_op == `OR1200_LSUOP_LHS)) & id_precalc_sum[0]
		        |  ((id_lsu_op == `OR1200_LSUOP_SW) |
		            (id_lsu_op == `OR1200_LSUOP_LWZ) |
		            (id_lsu_op == `OR1200_LSUOP_LWS)) & |id_precalc_sum[1:0];
end

//
// Internal I/F assignments
//
assign lsu_stall = dcpu_rty_i & dcpu_cycstb_o;
assign lsu_unstall = dcpu_ack_i;
assign except_dtlbmiss = dcpu_err_i & (dcpu_tag_i == `OR1200_DTAG_TE);
assign except_dmmufault = dcpu_err_i & (dcpu_tag_i == `OR1200_DTAG_PE);
assign except_dbuserr = dcpu_err_i & (dcpu_tag_i == `OR1200_DTAG_BE);

//
// External I/F assignments
//
assign dcpu_adr_o[31:`OR1200_LSUEA_PRECALC] = 
				   ex_addrbase[31:`OR1200_LSUEA_PRECALC] + 
				   (ex_addrofs[31:`OR1200_LSUEA_PRECALC] +
				    // carry from precalc, pad to 30-bits
				   {{(32-`OR1200_LSUEA_PRECALC)-1{1'b0}},
				    dcpu_adr_r[`OR1200_LSUEA_PRECALC]});
assign dcpu_adr_o[`OR1200_LSUEA_PRECALC-1:0] = dcpu_adr_r[`OR1200_LSUEA_PRECALC-1:0];
assign dcpu_cycstb_o = du_stall | lsu_unstall | except_align ? 
		       1'b0 : |ex_lsu_op;
assign dcpu_we_o = ex_lsu_op[3];
assign dcpu_tag_o = dcpu_cycstb_o ? `OR1200_DTAG_ND : `OR1200_DTAG_IDLE;
always @(ex_lsu_op or dcpu_adr_o)
	casez({ex_lsu_op, dcpu_adr_o[1:0]})
		{`OR1200_LSUOP_SB, 2'b00} : dcpu_sel_o = 4'b1000;
		{`OR1200_LSUOP_SB, 2'b01} : dcpu_sel_o = 4'b0100;
		{`OR1200_LSUOP_SB, 2'b10} : dcpu_sel_o = 4'b0010;
		{`OR1200_LSUOP_SB, 2'b11} : dcpu_sel_o = 4'b0001;
		{`OR1200_LSUOP_SH, 2'b00} : dcpu_sel_o = 4'b1100;
		{`OR1200_LSUOP_SH, 2'b10} : dcpu_sel_o = 4'b0011;
		{`OR1200_LSUOP_SW, 2'b00} : dcpu_sel_o = 4'b1111;
		{`OR1200_LSUOP_LBZ, 2'b00}, {`OR1200_LSUOP_LBS, 2'b00} : dcpu_sel_o = 4'b1000;
		{`OR1200_LSUOP_LBZ, 2'b01}, {`OR1200_LSUOP_LBS, 2'b01} : dcpu_sel_o = 4'b0100;
		{`OR1200_LSUOP_LBZ, 2'b10}, {`OR1200_LSUOP_LBS, 2'b10} : dcpu_sel_o = 4'b0010;
		{`OR1200_LSUOP_LBZ, 2'b11}, {`OR1200_LSUOP_LBS, 2'b11} : dcpu_sel_o = 4'b0001;
		{`OR1200_LSUOP_LHZ, 2'b00}, {`OR1200_LSUOP_LHS, 2'b00} : dcpu_sel_o = 4'b1100;
		{`OR1200_LSUOP_LHZ, 2'b10}, {`OR1200_LSUOP_LHS, 2'b10} : dcpu_sel_o = 4'b0011;
		{`OR1200_LSUOP_LWZ, 2'b00}, {`OR1200_LSUOP_LWS, 2'b00} : dcpu_sel_o = 4'b1111;
		default : dcpu_sel_o = 4'b0000;
	endcase

//
// Instantiation of Memory-to-regfile aligner
//
or1200_mem2reg or1200_mem2reg(
	.addr(dcpu_adr_o[1:0]),
	.lsu_op(ex_lsu_op),
	.memdata(dcpu_dat_i),
	.regdata(lsu_dataout)
);

//
// Instantiation of Regfile-to-memory aligner
//
or1200_reg2mem or1200_reg2mem(
        .addr(dcpu_adr_o[1:0]),
        .lsu_op(ex_lsu_op),
        .regdata(lsu_datain),
        .memdata(dcpu_dat_o)
);

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's mem2reg alignment                                  ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/cores/or1k/                        ////
////                                                              ////
////  Description                                                 ////
////  Two versions of Memory to register data alignment.          ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_mem2reg.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 
//
// Revision 1.5  2002/09/03 22:28:21  lampret
// As per Taylor Su suggestion all case blocks are full case by default and optionally (OR1200_CASE_DEFAULT) can be disabled to increase clock frequncy.
//
// Revision 1.4  2002/03/29 15:16:56  lampret
// Some of the warnings fixed.
//
// Revision 1.3  2002/03/28 19:14:10  lampret
// Changed define name from OR1200_MEM2REG_FAST to OR1200_IMPL_MEM2REG2
//
// Revision 1.2  2002/01/14 06:18:22  lampret
// Fixed mem2reg bug in FAST implementation. Updated debug unit to work with new genpc/if.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.9  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.8  2001/10/19 23:28:46  lampret
// Fixed some synthesis warnings. Configured with caches and MMUs.
//
// Revision 1.7  2001/10/14 13:12:09  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
// Revision 1.2  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.1  2001/07/20 00:46:03  lampret
// Development version of RTL. Libraries are missing.
//
//

// synopsys translate_off
// synopsys translate_on

module or1200_mem2reg(addr, lsu_op, memdata, regdata);

parameter width = `OR1200_OPERAND_WIDTH;

//
// I/O
//
input	[1:0]			addr;
input	[`OR1200_LSUOP_WIDTH-1:0]	lsu_op;
input	[width-1:0]		memdata;
output	[width-1:0]		regdata;


//
// In the past faster implementation of mem2reg (today probably slower)
//
`ifdef OR1200_IMPL_MEM2REG2

`define OR1200_M2R_BYTE0 4'b0000
`define OR1200_M2R_BYTE1 4'b0001
`define OR1200_M2R_BYTE2 4'b0010
`define OR1200_M2R_BYTE3 4'b0011
`define OR1200_M2R_EXTB0 4'b0100
`define OR1200_M2R_EXTB1 4'b0101
`define OR1200_M2R_EXTB2 4'b0110
`define OR1200_M2R_EXTB3 4'b0111
`define OR1200_M2R_ZERO  4'b0000

reg	[7:0]			regdata_hh;
reg	[7:0]			regdata_hl;
reg	[7:0]			regdata_lh;
reg	[7:0]			regdata_ll;
reg	[width-1:0]		aligned;
reg	[3:0]			sel_byte0, sel_byte1,
				sel_byte2, sel_byte3;

assign regdata = {regdata_hh, regdata_hl, regdata_lh, regdata_ll};

//
// Byte select 0
//
always @(addr or lsu_op) begin
	casex({lsu_op[2:0], addr})	// synopsys parallel_case
		{3'b01x, 2'b00}:			// lbz/lbs 0
			sel_byte0 = `OR1200_M2R_BYTE3;	// take byte 3
		{3'b01x, 2'b01},			// lbz/lbs 1
		{3'b10x, 2'b00}:			// lhz/lhs 0
			sel_byte0 = `OR1200_M2R_BYTE2;	// take byte 2
		{3'b01x, 2'b10}:			// lbz/lbs 2
			sel_byte0 = `OR1200_M2R_BYTE1;	// take byte 1
		default:				// all other cases
			sel_byte0 = `OR1200_M2R_BYTE0;	// take byte 0
	endcase
end

//
// Byte select 1
//
always @(addr or lsu_op) begin
	casex({lsu_op[2:0], addr})	// synopsys parallel_case
		{3'b010, 2'bxx}:			// lbz
			sel_byte1 = `OR1200_M2R_ZERO;	// zero extend
		{3'b011, 2'b00}:			// lbs 0
			sel_byte1 = `OR1200_M2R_EXTB3;	// sign extend from byte 3
		{3'b011, 2'b01}:			// lbs 1
			sel_byte1 = `OR1200_M2R_EXTB2;	// sign extend from byte 2
		{3'b011, 2'b10}:			// lbs 2
			sel_byte1 = `OR1200_M2R_EXTB1;	// sign extend from byte 1
		{3'b011, 2'b11}:			// lbs 3
			sel_byte1 = `OR1200_M2R_EXTB0;	// sign extend from byte 0
		{3'b10x, 2'b00}:			// lhz/lhs 0
			sel_byte1 = `OR1200_M2R_BYTE3;	// take byte 3
		default:				// all other cases
			sel_byte1 = `OR1200_M2R_BYTE1;	// take byte 1
	endcase
end

//
// Byte select 2
//
always @(addr or lsu_op) begin
	casex({lsu_op[2:0], addr})	// synopsys parallel_case
		{3'b010, 2'bxx},			// lbz
		{3'b100, 2'bxx}:			// lhz
			sel_byte2 = `OR1200_M2R_ZERO;	// zero extend
		{3'b011, 2'b00},			// lbs 0
		{3'b101, 2'b00}:			// lhs 0
			sel_byte2 = `OR1200_M2R_EXTB3;	// sign extend from byte 3
		{3'b011, 2'b01}:			// lbs 1
			sel_byte2 = `OR1200_M2R_EXTB2;	// sign extend from byte 2
		{3'b011, 2'b10},			// lbs 2
		{3'b101, 2'b10}:			// lhs 0
			sel_byte2 = `OR1200_M2R_EXTB1;	// sign extend from byte 1
		{3'b011, 2'b11}:			// lbs 3
			sel_byte2 = `OR1200_M2R_EXTB0;	// sign extend from byte 0
		default:				// all other cases
			sel_byte2 = `OR1200_M2R_BYTE2;	// take byte 2
	endcase
end

//
// Byte select 3
//
always @(addr or lsu_op) begin
	casex({lsu_op[2:0], addr}) // synopsys parallel_case
		{3'b010, 2'bxx},			// lbz
		{3'b100, 2'bxx}:			// lhz
			sel_byte3 = `OR1200_M2R_ZERO;	// zero extend
		{3'b011, 2'b00},			// lbs 0
		{3'b101, 2'b00}:			// lhs 0
			sel_byte3 = `OR1200_M2R_EXTB3;	// sign extend from byte 3
		{3'b011, 2'b01}:			// lbs 1
			sel_byte3 = `OR1200_M2R_EXTB2;	// sign extend from byte 2
		{3'b011, 2'b10},			// lbs 2
		{3'b101, 2'b10}:			// lhs 0
			sel_byte3 = `OR1200_M2R_EXTB1;	// sign extend from byte 1
		{3'b011, 2'b11}:			// lbs 3
			sel_byte3 = `OR1200_M2R_EXTB0;	// sign extend from byte 0
		default:				// all other cases
			sel_byte3 = `OR1200_M2R_BYTE3;	// take byte 3
	endcase
end

//
// Byte 0
//
always @(sel_byte0 or memdata) begin
`ifdef OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES
`ifdef OR1200_CASE_DEFAULT
	case(sel_byte0) // synopsys parallel_case infer_mux
`else
	case(sel_byte0) // synopsys full_case parallel_case infer_mux
`endif
`else
`ifdef OR1200_CASE_DEFAULT
	case(sel_byte0) // synopsys parallel_case
`else
	case(sel_byte0) // synopsys full_case parallel_case
`endif
`endif
		`OR1200_M2R_BYTE0: begin
				regdata_ll = memdata[7:0];
			end
		`OR1200_M2R_BYTE1: begin
				regdata_ll = memdata[15:8];
			end
		`OR1200_M2R_BYTE2: begin
				regdata_ll = memdata[23:16];
			end
`ifdef OR1200_CASE_DEFAULT
		default: begin
`else
		`OR1200_M2R_BYTE3: begin
`endif
				regdata_ll = memdata[31:24];
			end
	endcase
end

//
// Byte 1
//
always @(sel_byte1 or memdata) begin
`ifdef OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES
`ifdef OR1200_CASE_DEFAULT
	case(sel_byte1) // synopsys parallel_case infer_mux
`else
	case(sel_byte1) // synopsys full_case parallel_case infer_mux
`endif
`else
`ifdef OR1200_CASE_DEFAULT
	case(sel_byte1) // synopsys parallel_case
`else
	case(sel_byte1) // synopsys full_case parallel_case
`endif
`endif
		`OR1200_M2R_ZERO: begin
				regdata_lh = 8'h00;
			end
		`OR1200_M2R_BYTE1: begin
				regdata_lh = memdata[15:8];
			end
		`OR1200_M2R_BYTE3: begin
				regdata_lh = memdata[31:24];
			end
		`OR1200_M2R_EXTB0: begin
				regdata_lh = {8{memdata[7]}};
			end
		`OR1200_M2R_EXTB1: begin
				regdata_lh = {8{memdata[15]}};
			end
		`OR1200_M2R_EXTB2: begin
				regdata_lh = {8{memdata[23]}};
			end
`ifdef OR1200_CASE_DEFAULT
		default: begin
`else
		`OR1200_M2R_EXTB3: begin
`endif
				regdata_lh = {8{memdata[31]}};
			end
	endcase
end

//
// Byte 2
//
always @(sel_byte2 or memdata) begin
`ifdef OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES
`ifdef OR1200_CASE_DEFAULT
	case(sel_byte2) // synopsys parallel_case infer_mux
`else
	case(sel_byte2) // synopsys full_case parallel_case infer_mux
`endif
`else
`ifdef OR1200_CASE_DEFAULT
	case(sel_byte2) // synopsys parallel_case
`else
	case(sel_byte2) // synopsys full_case parallel_case
`endif
`endif
		`OR1200_M2R_ZERO: begin
				regdata_hl = 8'h00;
			end
		`OR1200_M2R_BYTE2: begin
				regdata_hl = memdata[23:16];
			end
		`OR1200_M2R_EXTB0: begin
				regdata_hl = {8{memdata[7]}};
			end
		`OR1200_M2R_EXTB1: begin
				regdata_hl = {8{memdata[15]}};
			end
		`OR1200_M2R_EXTB2: begin
				regdata_hl = {8{memdata[23]}};
			end
`ifdef OR1200_CASE_DEFAULT
		default: begin
`else
		`OR1200_M2R_EXTB3: begin
`endif
				regdata_hl = {8{memdata[31]}};
			end
	endcase
end

//
// Byte 3
//
always @(sel_byte3 or memdata) begin
`ifdef OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES
`ifdef OR1200_CASE_DEFAULT
	case(sel_byte3) // synopsys parallel_case infer_mux
`else
	case(sel_byte3) // synopsys full_case parallel_case infer_mux
`endif
`else
`ifdef OR1200_CASE_DEFAULT
	case(sel_byte3) // synopsys parallel_case
`else
	case(sel_byte3) // synopsys full_case parallel_case
`endif
`endif
		`OR1200_M2R_ZERO: begin
				regdata_hh = 8'h00;
			end
		`OR1200_M2R_BYTE3: begin
				regdata_hh = memdata[31:24];
			end
		`OR1200_M2R_EXTB0: begin
				regdata_hh = {8{memdata[7]}};
			end
		`OR1200_M2R_EXTB1: begin
				regdata_hh = {8{memdata[15]}};
			end
		`OR1200_M2R_EXTB2: begin
				regdata_hh = {8{memdata[23]}};
			end
`ifdef OR1200_CASE_DEFAULT
		`OR1200_M2R_EXTB3: begin
`else
		`OR1200_M2R_EXTB3: begin
`endif
				regdata_hh = {8{memdata[31]}};
			end
	endcase
end

`else

//
// Straightforward implementation of mem2reg
//

reg	[width-1:0]		regdata;
reg	[width-1:0]		aligned;

//
// Alignment
//
always @(addr or memdata) begin
`ifdef OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES
	case(addr) // synopsys parallel_case infer_mux
`else
	case(addr) // synopsys parallel_case
`endif
		2'b00:
			aligned = memdata;
		2'b01:
			aligned = {memdata[23:0], 8'b0};
		2'b10:
			aligned = {memdata[15:0], 16'b0};
		2'b11:
			aligned = {memdata[7:0], 24'b0};
	endcase
end

//
// Bytes
//
always @(lsu_op or aligned) begin
`ifdef OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES
	case(lsu_op) // synopsys parallel_case infer_mux
`else
	case(lsu_op) // synopsys parallel_case
`endif
		`OR1200_LSUOP_LBZ: begin
				regdata[7:0] = aligned[31:24];
				regdata[31:8] = 24'b0;
			end
		`OR1200_LSUOP_LBS: begin
				regdata[7:0] = aligned[31:24];
				regdata[31:8] = {24{aligned[31]}};
			end
		`OR1200_LSUOP_LHZ: begin
				regdata[15:0] = aligned[31:16];
				regdata[31:16] = 16'b0;
			end
		`OR1200_LSUOP_LHS: begin
				regdata[15:0] = aligned[31:16];
				regdata[31:16] = {16{aligned[31]}};
			end
		default:
				regdata = aligned;
	endcase
end

`endif

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Top level multiplier, divider and MAC              ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Multiplier is 32x32 however multiply instructions only      ////
////  use lower 32 bits of the result. MAC is 32x32=64+64.        ////
////                                                              ////
////  To Do:                                                      ////
////   - make signed division better, w/o negating the operands   ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_mult_mac.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed. 
//

// synopsys translate_off
// synopsys translate_on

module or1200_mult_mac(
	// Clock and reset
	clk, rst,

	// Multiplier/MAC interface
	ex_freeze, id_macrc_op, macrc_op, a, b, mac_op, alu_op, result, mac_stall_r,

	// SPR interface
	spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o
);

parameter width = `OR1200_OPERAND_WIDTH;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// Multiplier/MAC interface
//
input				ex_freeze;
input				id_macrc_op;
input				macrc_op;
input	[width-1:0]		a;
input	[width-1:0]		b;
input	[`OR1200_MACOP_WIDTH-1:0]	mac_op;
input	[`OR1200_ALUOP_WIDTH-1:0]	alu_op;
output	[width-1:0]		result;
output				mac_stall_r;

//
// SPR interface
//
input				spr_cs;
input				spr_write;
input	[31:0]			spr_addr;
input	[31:0]			spr_dat_i;
output	[31:0]			spr_dat_o;

//
// Internal wires and regs
//
`ifdef OR1200_MULT_IMPLEMENTED
reg	[width-1:0]		result;
reg	[2*width-1:0]		mul_prod_r;
`else
wire	[width-1:0]		result;
wire	[2*width-1:0]		mul_prod_r;
`endif
wire	[2*width-1:0]		mul_prod;
wire	[`OR1200_MACOP_WIDTH-1:0]	mac_op;
`ifdef OR1200_MAC_IMPLEMENTED
reg	[`OR1200_MACOP_WIDTH-1:0]	mac_op_r1;
reg	[`OR1200_MACOP_WIDTH-1:0]	mac_op_r2;
reg	[`OR1200_MACOP_WIDTH-1:0]	mac_op_r3;
reg				mac_stall_r;
reg	[63:0]		mac_r;
`else
wire	[`OR1200_MACOP_WIDTH-1:0]	mac_op_r1;
wire	[`OR1200_MACOP_WIDTH-1:0]	mac_op_r2;
wire	[`OR1200_MACOP_WIDTH-1:0]	mac_op_r3;
wire				mac_stall_r;
wire	[63:0]		mac_r;
`endif
wire	[width-1:0]		x;
wire	[width-1:0]		y;
wire				spr_maclo_we;
wire				spr_machi_we;
wire				alu_op_div_divu;
wire				alu_op_div;
reg				div_free;
`ifdef OR1200_DIV_IMPLEMENTED
wire	[width-1:0]		div_tmp;
reg	[5:0]			div_cntr;
`endif

//
// Combinatorial logic
//
`ifdef OR1200_MAC_IMPLEMENTED
assign spr_maclo_we = spr_cs & spr_write & spr_addr[`OR1200_MAC_ADDR];
assign spr_machi_we = spr_cs & spr_write & !spr_addr[`OR1200_MAC_ADDR];
assign spr_dat_o = spr_addr[`OR1200_MAC_ADDR] ? mac_r[31:0] : mac_r[63:32];
`else
assign spr_maclo_we = 1'b0;
assign spr_machi_we = 1'b0;
assign spr_dat_o = 32'h0000_0000;
`endif
`ifdef OR1200_LOWPWR_MULT
assign x = (alu_op_div & a[31]) ? ~a + 1'b1 : 
	   alu_op_div_divu | (alu_op == `OR1200_ALUOP_MUL) | (|mac_op) ? 
	   a : 32'h0000_0000;
assign y = (alu_op_div & b[31]) ? ~b + 1'b1 : 
	   alu_op_div_divu | (alu_op == `OR1200_ALUOP_MUL) | (|mac_op) ? 
	   b : 32'h0000_0000;
`else
assign x = alu_op_div & a[31] ? ~a + 32'b1 : a;
assign y = alu_op_div & b[31] ? ~b + 32'b1 : b;
`endif
`ifdef OR1200_DIV_IMPLEMENTED
assign alu_op_div = (alu_op == `OR1200_ALUOP_DIV);
assign alu_op_div_divu = alu_op_div | (alu_op == `OR1200_ALUOP_DIVU);
assign div_tmp = mul_prod_r[63:32] - y;
`else
assign alu_op_div = 1'b0;
assign alu_op_div_divu = 1'b0;
`endif

`ifdef OR1200_MULT_IMPLEMENTED

//
// Select result of current ALU operation to be forwarded
// to next instruction and to WB stage
//
always @*
  casez(alu_op)	// synopsys parallel_case
 `ifdef OR1200_DIV_IMPLEMENTED
    `OR1200_ALUOP_DIV: begin
       result = a[31] ^ b[31] ? ~mul_prod_r[31:0] + 32'd1 : mul_prod_r[31:0];
    end
    `OR1200_ALUOP_DIVU,
 `endif
    `OR1200_ALUOP_MUL: begin
       result = mul_prod_r[31:0];
    end
    default:
 `ifdef OR1200_MAC_SHIFTBY
      result = mac_r[`OR1200_MAC_SHIFTBY+31:`OR1200_MAC_SHIFTBY];
 `else
      result = mac_r[31:0];
 `endif
  endcase
   
   //
   // Instantiation of the multiplier
   //
 `ifdef OR1200_ASIC_MULTP2_32X32
or1200_amultp2_32x32 or1200_amultp2_32x32(
	.X(x),
	.Y(y),
	.RST(rst),
	.CLK(clk),
	.P(mul_prod)
);
`else // OR1200_ASIC_MULTP2_32X32
or1200_gmultp2_32x32 or1200_gmultp2_32x32(
	.X(x),
	.Y(y),
	.RST(rst),
	.CLK(clk),
	.P(mul_prod)
);
`endif // OR1200_ASIC_MULTP2_32X32

//
// Registered output from the multiplier and
// an optional divider
//
always @( posedge clk)
	if (rst == `OR1200_RST_VALUE) begin
		mul_prod_r <=  64'h0000_0000_0000_0000;
		div_free <=  1'b1;
`ifdef OR1200_DIV_IMPLEMENTED
		div_cntr <=  6'b00_0000;
`endif
	end
`ifdef OR1200_DIV_IMPLEMENTED
	else if (|div_cntr) begin
		if (div_tmp[31])
			mul_prod_r <=  {mul_prod_r[62:0], 1'b0};
		else
			mul_prod_r <=  {div_tmp[30:0], mul_prod_r[31:0], 1'b1};
		div_cntr <=  div_cntr - 6'd1;
	end
	else if (alu_op_div_divu && div_free) begin
		mul_prod_r <=  {31'b0, x[31:0], 1'b0};
		div_cntr <=  6'b10_0000;
		div_free <=  1'b0;
	end
`endif // OR1200_DIV_IMPLEMENTED
	else if (div_free | !ex_freeze) begin
		mul_prod_r <=  mul_prod[63:0];
		div_free <=  1'b1;
	end

`else // OR1200_MULT_IMPLEMENTED
assign result = {width{1'b0}};
assign mul_prod = {2*width{1'b0}};
assign mul_prod_r = {2*width{1'b0}};
`endif // OR1200_MULT_IMPLEMENTED

`ifdef OR1200_MAC_IMPLEMENTED
// Signal to indicate when we should check for new MAC op
reg ex_freeze_r;
   
always @(posedge clk )
  if (rst == `OR1200_RST_VALUE)
    ex_freeze_r <= 1'b1;
  else
    ex_freeze_r <= ex_freeze;
   
//
// Propagation of l.mac opcode, only register it for one cycle
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		mac_op_r1 <=  `OR1200_MACOP_WIDTH'b0;
	else
		mac_op_r1 <=  !ex_freeze_r ? mac_op : `OR1200_MACOP_WIDTH'b0;

//
// Propagation of l.mac opcode
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		mac_op_r2 <=  `OR1200_MACOP_WIDTH'b0;
	else
		mac_op_r2 <=  mac_op_r1;

//
// Propagation of l.mac opcode
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		mac_op_r3 <=  `OR1200_MACOP_WIDTH'b0;
	else
		mac_op_r3 <=  mac_op_r2;

//
// Implementation of MAC
//
always @( posedge clk)
	if (rst == `OR1200_RST_VALUE)
		mac_r <=  64'h0000_0000_0000_0000;
`ifdef OR1200_MAC_SPR_WE
	else if (spr_maclo_we)
		mac_r[31:0] <=  spr_dat_i;
	else if (spr_machi_we)
		mac_r[63:32] <=  spr_dat_i;
`endif
	else if (mac_op_r3 == `OR1200_MACOP_MAC)
		mac_r <=  mac_r + mul_prod_r;
	else if (mac_op_r3 == `OR1200_MACOP_MSB)
		mac_r <=  mac_r - mul_prod_r;
	else if (macrc_op && !ex_freeze)
		mac_r <=  64'h0000_0000_0000_0000;

//
// Stall CPU if l.macrc is in ID and MAC still has to process l.mac instructions
// in EX stage (e.g. inside multiplier)
// This stall signal is also used by the divider.
//
always @( posedge clk)
	if (rst == `OR1200_RST_VALUE)
		mac_stall_r <=  1'b0;
	else
		mac_stall_r <=  (|mac_op | (|mac_op_r1) | (|mac_op_r2)) & (id_macrc_op | mac_stall_r)
`ifdef OR1200_DIV_IMPLEMENTED
				| (|div_cntr)
`endif
				;
`else // OR1200_MAC_IMPLEMENTED
assign mac_stall_r = 1'b0;
assign mac_r = {2*width{1'b0}};
assign mac_op_r1 = `OR1200_MACOP_WIDTH'b0;
assign mac_op_r2 = `OR1200_MACOP_WIDTH'b0;
assign mac_op_r3 = `OR1200_MACOP_WIDTH'b0;
`endif // OR1200_MAC_IMPLEMENTED

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's register file read operands mux                    ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Mux for two register file read operands.                    ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_operandmuxes.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed. 

// synopsys translate_off
// synopsys translate_on

module or1200_operandmuxes(
	// Clock and reset
	clk, rst,

	// Internal i/f
	id_freeze, ex_freeze, rf_dataa, rf_datab, ex_forw, wb_forw,
	simm, sel_a, sel_b, operand_a, operand_b, muxed_a, muxed_b
);

parameter width = `OR1200_OPERAND_WIDTH;

//
// I/O
//
input				clk;
input				rst;
input				id_freeze;
input				ex_freeze;
input	[width-1:0]		rf_dataa;
input	[width-1:0]		rf_datab;
input	[width-1:0]		ex_forw;
input	[width-1:0]		wb_forw;
input	[width-1:0]		simm;
input	[`OR1200_SEL_WIDTH-1:0]	sel_a;
input	[`OR1200_SEL_WIDTH-1:0]	sel_b;
output	[width-1:0]		operand_a;
output	[width-1:0]		operand_b;
output	[width-1:0]		muxed_a;
output	[width-1:0]		muxed_b;

//
// Internal wires and regs
//
reg	[width-1:0]		operand_a;
reg	[width-1:0]		operand_b;
reg	[width-1:0]		muxed_a;
reg	[width-1:0]		muxed_b;
reg				saved_a;
reg				saved_b;

//
// Operand A register
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE) begin
		operand_a <=  32'd0;
		saved_a <=  1'b0;
	end else if (!ex_freeze && id_freeze && !saved_a) begin
		operand_a <=  muxed_a;
		saved_a <=  1'b1;
	end else if (!ex_freeze && !saved_a) begin
		operand_a <=  muxed_a;
	end else if (!ex_freeze && !id_freeze)
		saved_a <=  1'b0;
end

//
// Operand B register
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE) begin
		operand_b <=  32'd0;
		saved_b <=  1'b0;
	end else if (!ex_freeze && id_freeze && !saved_b) begin
		operand_b <=  muxed_b;
		saved_b <=  1'b1;
	end else if (!ex_freeze && !saved_b) begin
		operand_b <=  muxed_b;
	end else if (!ex_freeze && !id_freeze)
		saved_b <=  1'b0;
end

//
// Forwarding logic for operand A register
//
always @(ex_forw or wb_forw or rf_dataa or sel_a) begin
`ifdef OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES
	casez (sel_a)	// synopsys parallel_case infer_mux
`else
	casez (sel_a)	// synopsys parallel_case
`endif
		`OR1200_SEL_EX_FORW:
			muxed_a = ex_forw;
		`OR1200_SEL_WB_FORW:
			muxed_a = wb_forw;
		default:
			muxed_a = rf_dataa;
	endcase
end

//
// Forwarding logic for operand B register
//
always @(simm or ex_forw or wb_forw or rf_datab or sel_b) begin
`ifdef OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES
	casez (sel_b)	// synopsys parallel_case infer_mux
`else
	casez (sel_b)	// synopsys parallel_case
`endif
		`OR1200_SEL_IMM:
			muxed_b = simm;
		`OR1200_SEL_EX_FORW:
			muxed_b = ex_forw;
		`OR1200_SEL_WB_FORW:
			muxed_b = wb_forw;
		default:
			muxed_b = rf_datab;
	endcase
end

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Programmable Interrupt Controller                  ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  PIC according to OR1K architectural specification.          ////
////                                                              ////
////  To Do:                                                      ////
////   None                                                       ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_pic.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
//

// synopsys translate_off
// synopsys translate_on

module or1200_pic(
	// RISC Internal Interface
	clk, rst, spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o,
	pic_wakeup, intr,
	
	// PIC Interface
	pic_int
);

//
// RISC Internal Interface
//
input		clk;		// Clock
input		rst;		// Reset
input		spr_cs;		// SPR CS
input		spr_write;	// SPR Write
input	[31:0]	spr_addr;	// SPR Address
input	[31:0]	spr_dat_i;	// SPR Write Data
output	[31:0]	spr_dat_o;	// SPR Read Data
output		pic_wakeup;	// Wakeup to the PM
output		intr;		// interrupt
				// exception request

//
// PIC Interface
//
input	[`OR1200_PIC_INTS-1:0]	pic_int;// Interrupt inputs

`ifdef OR1200_PIC_IMPLEMENTED

//
// PIC Mask Register bits (or no register)
//
`ifdef OR1200_PIC_PICMR
reg	[`OR1200_PIC_INTS-1:2]	picmr;	// PICMR bits
`else
wire	[`OR1200_PIC_INTS-1:2]	picmr;	// No PICMR register
`endif

//
// PIC Status Register bits (or no register)
//
`ifdef OR1200_PIC_PICSR
reg	[`OR1200_PIC_INTS-1:0]	picsr;	// PICSR bits
`else
wire	[`OR1200_PIC_INTS-1:0]	picsr;	// No PICSR register
`endif

//
// Internal wires & regs
//
wire		picmr_sel;	// PICMR select
wire		picsr_sel;	// PICSR select
wire	[`OR1200_PIC_INTS-1:0] um_ints;// Unmasked interrupts
reg	[31:0] 	spr_dat_o;	// SPR data out

//
// PIC registers address decoder
//
assign picmr_sel = (spr_cs && (spr_addr[`OR1200_PICOFS_BITS] == `OR1200_PIC_OFS_PICMR)) ? 1'b1 : 1'b0;
assign picsr_sel = (spr_cs && (spr_addr[`OR1200_PICOFS_BITS] == `OR1200_PIC_OFS_PICSR)) ? 1'b1 : 1'b0;

//
// Write to PICMR
//
`ifdef OR1200_PIC_PICMR
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		picmr <= {1'b1, {`OR1200_PIC_INTS-3{1'b0}}};
	else if (picmr_sel && spr_write) begin
		picmr <=  spr_dat_i[`OR1200_PIC_INTS-1:2];
	end
`else
assign picmr = (`OR1200_PIC_INTS)'b1;
`endif

//
// Write to PICSR, both CPU and external ints
//
`ifdef OR1200_PIC_PICSR
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		picsr <= {`OR1200_PIC_INTS{1'b0}};
	else if (picsr_sel && spr_write) begin
		picsr <=  spr_dat_i[`OR1200_PIC_INTS-1:0] | um_ints;
	end else
		picsr <=  picsr | um_ints;
`else
assign picsr = pic_int;
`endif

//
// Read PIC registers
//
always @(spr_addr or picmr or picsr)
	case (spr_addr[`OR1200_PICOFS_BITS])	// synopsys parallel_case
`ifdef OR1200_PIC_READREGS
		`OR1200_PIC_OFS_PICMR: begin
		   spr_dat_o[`OR1200_PIC_INTS-1:0] = {picmr, 2'b11};
 `ifdef OR1200_PIC_UNUSED_ZERO
		   spr_dat_o[31:`OR1200_PIC_INTS] = {32-`OR1200_PIC_INTS{1'b0}};
 `endif
		end
`endif
	  default: begin
	     spr_dat_o[`OR1200_PIC_INTS-1:0] = picsr;
`ifdef OR1200_PIC_UNUSED_ZERO
	     spr_dat_o[31:`OR1200_PIC_INTS] = {32-`OR1200_PIC_INTS{1'b0}};
`endif
	  end
	endcase
   
//
// Unmasked interrupts
//
assign um_ints = pic_int & {picmr, 2'b11};

//
// Generate intr
//
assign intr = |um_ints;

//
// Assert pic_wakeup when intr is asserted
//
assign pic_wakeup = intr;

`else

//
// When PIC is not implemented, drive all outputs as would when PIC is disabled
//
assign intr = pic_int[1] | pic_int[0];
assign pic_wakeup= intr;

//
// Read PIC registers
//
`ifdef OR1200_PIC_READREGS
assign spr_dat_o[`OR1200_PIC_INTS-1:0] = `OR1200_PIC_INTS'b0;
`ifdef OR1200_PIC_UNUSED_ZERO
assign spr_dat_o[31:`OR1200_PIC_INTS] = 32-`OR1200_PIC_INTS'b0;
`endif
`endif

`endif

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Power Management                                   ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/cores/or1k/                        ////
////                                                              ////
////  Description                                                 ////
////  PM according to OR1K architectural specification.           ////
////                                                              ////
////  To Do:                                                      ////
////   - add support for dynamic clock gating                     ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_pm.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.8  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.7  2001/10/14 13:12:10  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:35  igorm
// no message
//
// Revision 1.2  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.1  2001/07/20 00:46:21  lampret
// Development version of RTL. Libraries are missing.
//
//

// synopsys translate_off
// synopsys translate_on

module or1200_pm(
	// RISC Internal Interface
	clk, rst, pic_wakeup, spr_write, spr_addr, spr_dat_i, spr_dat_o,
	
	// Power Management Interface
	pm_clksd, pm_cpustall, pm_dc_gate, pm_ic_gate, pm_dmmu_gate,
	pm_immu_gate, pm_tt_gate, pm_cpu_gate, pm_wakeup, pm_lvolt
);

//
// RISC Internal Interface
//
input		clk;		// Clock
input		rst;		// Reset
input		pic_wakeup;	// Wakeup from the PIC
input		spr_write;	// SPR Read/Write
input	[31:0]	spr_addr;	// SPR Address
input	[31:0]	spr_dat_i;	// SPR Write Data
output	[31:0]	spr_dat_o;	// SPR Read Data

//
// Power Management Interface
//
input		pm_cpustall;	// Stall the CPU
output	[3:0]	pm_clksd;	// Clock Slowdown factor
output		pm_dc_gate;	// Gate DCache clock
output		pm_ic_gate;	// Gate ICache clock
output		pm_dmmu_gate;	// Gate DMMU clock
output		pm_immu_gate;	// Gate IMMU clock
output		pm_tt_gate;	// Gate Tick Timer clock
output		pm_cpu_gate;	// Gate main RISC/CPU clock
output		pm_wakeup;	// Activate (de-gate) all clocks
output		pm_lvolt;	// Lower operating voltage

`ifdef OR1200_PM_IMPLEMENTED

//
// Power Management Register bits
//
reg	[3:0]	sdf;	// Slow-down factor
reg		dme;	// Doze Mode Enable
reg		sme;	// Sleep Mode Enable
reg		dcge;	// Dynamic Clock Gating Enable

//
// Internal wires
//
wire		pmr_sel; // PMR select

//
// PMR address decoder (partial decoder)
//
`ifdef OR1200_PM_PARTIAL_DECODING
assign pmr_sel = (spr_addr[`OR1200_SPR_GROUP_BITS] == `OR1200_SPRGRP_PM) ? 1'b1 : 1'b0;
`else
assign pmr_sel = ((spr_addr[`OR1200_SPR_GROUP_BITS] == `OR1200_SPRGRP_PM) &&
		  (spr_addr[`OR1200_SPR_OFS_BITS] == `OR1200_PM_OFS_PMR)) ? 1'b1 : 1'b0;
`endif

//
// Write to PMR and also PMR[DME]/PMR[SME] reset when
// pic_wakeup is asserted
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		{dcge, sme, dme, sdf} <= 7'b0;
	else if (pmr_sel && spr_write) begin
		sdf <=  spr_dat_i[`OR1200_PM_PMR_SDF];
		dme <=  spr_dat_i[`OR1200_PM_PMR_DME];
		sme <=  spr_dat_i[`OR1200_PM_PMR_SME];
		dcge <=  spr_dat_i[`OR1200_PM_PMR_DCGE];
	end
	else if (pic_wakeup) begin
		dme <=  1'b0;
		sme <=  1'b0;
	end

//
// Read PMR
//
`ifdef OR1200_PM_READREGS
assign spr_dat_o[`OR1200_PM_PMR_SDF] = sdf;
assign spr_dat_o[`OR1200_PM_PMR_DME] = dme;
assign spr_dat_o[`OR1200_PM_PMR_SME] = sme;
assign spr_dat_o[`OR1200_PM_PMR_DCGE] = dcge;
`ifdef OR1200_PM_UNUSED_ZERO
assign spr_dat_o[`OR1200_PM_PMR_UNUSED] = 25'b0;
`endif
`endif

//
// Generate pm_clksd
//
assign pm_clksd = sdf;

//
// Statically generate all clock gate outputs
// TODO: add dynamic clock gating feature
//
assign pm_cpu_gate = (dme | sme) & ~pic_wakeup;
assign pm_dc_gate = pm_cpu_gate;
assign pm_ic_gate = pm_cpu_gate;
assign pm_dmmu_gate = pm_cpu_gate;
assign pm_immu_gate = pm_cpu_gate;
assign pm_tt_gate = sme & ~pic_wakeup;

//
// Assert pm_wakeup when pic_wakeup is asserted
//
assign pm_wakeup = pic_wakeup;

//
// Assert pm_lvolt when pm_cpu_gate or pm_cpustall are asserted
//
assign pm_lvolt = pm_cpu_gate | pm_cpustall;

`else

//
// When PM is not implemented, drive all outputs as would when PM is disabled
//
assign pm_clksd = 4'b0;
assign pm_cpu_gate = 1'b0;
assign pm_dc_gate = 1'b0;
assign pm_ic_gate = 1'b0;
assign pm_dmmu_gate = 1'b0;
assign pm_immu_gate = 1'b0;
assign pm_tt_gate = 1'b0;
assign pm_wakeup = 1'b1;
assign pm_lvolt = 1'b0;

//
// Read PMR
//
`ifdef OR1200_PM_READREGS
assign spr_dat_o[`OR1200_PM_PMR_SDF] = 4'b0;
assign spr_dat_o[`OR1200_PM_PMR_DME] = 1'b0;
assign spr_dat_o[`OR1200_PM_PMR_SME] = 1'b0;
assign spr_dat_o[`OR1200_PM_PMR_DCGE] = 1'b0;
`ifdef OR1200_PM_UNUSED_ZERO
assign spr_dat_o[`OR1200_PM_PMR_UNUSED] = 25'b0;
`endif
`endif

`endif

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Embedded Memory                                    ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/cores/or1k/                        ////
////                                                              ////
////  Description                                                 ////
////  Embedded Memory               .                             ////
////                                                              ////
////  To Do:                                                      ////
////   - QMEM and IC/DC muxes can be removed except for cycstb    ////
////     (now are is there for easier debugging)                  ////
////   - currently arbitration is slow and stores take 2 clocks   ////
////     (final debugged version will be faster)                  ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2003 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_qmem_top.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Coding style changed.
//
// Revision 1.3  2004/06/08 18:17:36  lampret
// Non-functional changes. Coding style fixes.
//
// Revision 1.2  2004/04/05 08:40:26  lampret
// Merged branch_qmem into main tree.
//
// Revision 1.1.2.4  2004/01/11 22:45:46  andreje
// Separate instruction and data QMEM decoders, QMEM acknowledge and byte-select added
//
// Revision 1.1.2.3  2003/12/17 13:36:58  simons
// Qmem mbist signals fixed.
//
// Revision 1.1.2.2  2003/12/09 11:46:48  simons
// Mbist nameing changed, Artisan ram instance signal names fixed, some synthesis waning fixed.
//
// Revision 1.1.2.1  2003/07/08 15:45:26  lampret
// Added embedded memory QMEM.
//
//

// synopsys translate_off
// synopsys translate_on

`define OR1200_QMEMFSM_IDLE	3'd0
`define OR1200_QMEMFSM_STORE	3'd1
`define OR1200_QMEMFSM_LOAD	3'd2
`define OR1200_QMEMFSM_FETCH	3'd3

//
// Embedded memory
//
module or1200_qmem_top(
	// Rst, clk and clock control
	clk, rst,

`ifdef OR1200_BIST
	// RAM BIST
	mbist_si_i, mbist_so_o, mbist_ctrl_i,
`endif

	// QMEM and CPU/IMMU
	qmemimmu_adr_i,
	qmemimmu_cycstb_i,
	qmemimmu_ci_i,
	qmemicpu_sel_i,
	qmemicpu_tag_i,
	qmemicpu_dat_o,
	qmemicpu_ack_o,
	qmemimmu_rty_o,
	qmemimmu_err_o,
	qmemimmu_tag_o,

	// QMEM and IC
	icqmem_adr_o,
	icqmem_cycstb_o,
	icqmem_ci_o,
	icqmem_sel_o,
	icqmem_tag_o,
	icqmem_dat_i,
	icqmem_ack_i,
	icqmem_rty_i,
	icqmem_err_i,
	icqmem_tag_i,

	// QMEM and CPU/DMMU
	qmemdmmu_adr_i,
	qmemdmmu_cycstb_i,
	qmemdmmu_ci_i,
	qmemdcpu_we_i,
	qmemdcpu_sel_i,
	qmemdcpu_tag_i,
	qmemdcpu_dat_i,
	qmemdcpu_dat_o,
	qmemdcpu_ack_o,
	qmemdcpu_rty_o,
	qmemdmmu_err_o,
	qmemdmmu_tag_o,

	// QMEM and DC
	dcqmem_adr_o,
	dcqmem_cycstb_o,
	dcqmem_ci_o,
	dcqmem_we_o,
	dcqmem_sel_o,
	dcqmem_tag_o,
	dcqmem_dat_o,
	dcqmem_dat_i,
	dcqmem_ack_i,
	dcqmem_rty_i,
	dcqmem_err_i,
	dcqmem_tag_i 

);

parameter dw = `OR1200_OPERAND_WIDTH;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

`ifdef OR1200_BIST
//
// RAM BIST
//
input mbist_si_i;
input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;
output mbist_so_o;
`endif

//
// QMEM and CPU/IMMU
//
input	[31:0]			qmemimmu_adr_i;
input				qmemimmu_cycstb_i;
input				qmemimmu_ci_i;
input	[3:0]			qmemicpu_sel_i;
input	[3:0]			qmemicpu_tag_i;
output	[31:0]			qmemicpu_dat_o;
output				qmemicpu_ack_o;
output				qmemimmu_rty_o;
output				qmemimmu_err_o;
output	[3:0]			qmemimmu_tag_o;

//
// QMEM and IC
//
output	[31:0]			icqmem_adr_o;
output				icqmem_cycstb_o;
output				icqmem_ci_o;
output	[3:0]			icqmem_sel_o;
output	[3:0]			icqmem_tag_o;
input	[31:0]			icqmem_dat_i;
input				icqmem_ack_i;
input				icqmem_rty_i;
input				icqmem_err_i;
input	[3:0]			icqmem_tag_i;

//
// QMEM and CPU/DMMU
//
input	[31:0]			qmemdmmu_adr_i;
input				qmemdmmu_cycstb_i;
input				qmemdmmu_ci_i;
input				qmemdcpu_we_i;
input	[3:0]			qmemdcpu_sel_i;
input	[3:0]			qmemdcpu_tag_i;
input	[31:0]			qmemdcpu_dat_i;
output	[31:0]			qmemdcpu_dat_o;
output				qmemdcpu_ack_o;
output				qmemdcpu_rty_o;
output				qmemdmmu_err_o;
output	[3:0]			qmemdmmu_tag_o;

//
// QMEM and DC
//
output	[31:0]			dcqmem_adr_o;
output				dcqmem_cycstb_o;
output				dcqmem_ci_o;
output				dcqmem_we_o;
output	[3:0]			dcqmem_sel_o;
output	[3:0]			dcqmem_tag_o;
output	[dw-1:0]		dcqmem_dat_o;
input	[dw-1:0]		dcqmem_dat_i;
input				dcqmem_ack_i;
input				dcqmem_rty_i;
input				dcqmem_err_i;
input	[3:0]			dcqmem_tag_i;

`ifdef OR1200_QMEM_IMPLEMENTED

//
// Internal regs and wires
//
wire				iaddr_qmem_hit;
wire				daddr_qmem_hit;
reg	[2:0]			state;
reg				qmem_dack;
reg				qmem_iack;
wire	[31:0]			qmem_di;
wire	[31:0]			qmem_do;
wire				qmem_en;
wire				qmem_we;
`ifdef OR1200_QMEM_BSEL
wire  [3:0]       qmem_sel;
`endif
wire	[31:0]			qmem_addr;
`ifdef OR1200_QMEM_ACK
wire              qmem_ack;
`else
wire              qmem_ack = 1'b1;
`endif

//
// QMEM and CPU/IMMU
//
assign qmemicpu_dat_o = qmem_iack ? qmem_do : icqmem_dat_i;
assign qmemicpu_ack_o = qmem_iack ? 1'b1 : icqmem_ack_i;
assign qmemimmu_rty_o = qmem_iack ? 1'b0 : icqmem_rty_i;
assign qmemimmu_err_o = qmem_iack ? 1'b0 : icqmem_err_i;
assign qmemimmu_tag_o = qmem_iack ? 4'h0 : icqmem_tag_i;

//
// QMEM and IC
//
assign icqmem_adr_o = iaddr_qmem_hit ? 32'h0000_0000 : qmemimmu_adr_i;
assign icqmem_cycstb_o = iaddr_qmem_hit ? 1'b0 : qmemimmu_cycstb_i;
assign icqmem_ci_o = iaddr_qmem_hit ? 1'b0 : qmemimmu_ci_i;
assign icqmem_sel_o = iaddr_qmem_hit ? 4'h0 : qmemicpu_sel_i;
assign icqmem_tag_o = iaddr_qmem_hit ? 4'h0 : qmemicpu_tag_i;

//
// QMEM and CPU/DMMU
//
assign qmemdcpu_dat_o = daddr_qmem_hit ? qmem_do : dcqmem_dat_i;
assign qmemdcpu_ack_o = daddr_qmem_hit ? qmem_dack : dcqmem_ack_i;
assign qmemdcpu_rty_o = daddr_qmem_hit ? ~qmem_dack : dcqmem_rty_i;
assign qmemdmmu_err_o = daddr_qmem_hit ? 1'b0 : dcqmem_err_i;
assign qmemdmmu_tag_o = daddr_qmem_hit ? 4'h0 : dcqmem_tag_i;

//
// QMEM and DC
//
assign dcqmem_adr_o = daddr_qmem_hit ? 32'h0000_0000 : qmemdmmu_adr_i;
assign dcqmem_cycstb_o = daddr_qmem_hit ? 1'b0 : qmemdmmu_cycstb_i;
assign dcqmem_ci_o = daddr_qmem_hit ? 1'b0 : qmemdmmu_ci_i;
assign dcqmem_we_o = daddr_qmem_hit ? 1'b0 : qmemdcpu_we_i;
assign dcqmem_sel_o = daddr_qmem_hit ? 4'h0 : qmemdcpu_sel_i;
assign dcqmem_tag_o = daddr_qmem_hit ? 4'h0 : qmemdcpu_tag_i;
assign dcqmem_dat_o = daddr_qmem_hit ? 32'h0000_0000 : qmemdcpu_dat_i;

//
// Address comparison whether QMEM was hit
//
`ifdef OR1200_QMEM_IADDR
assign iaddr_qmem_hit = (qmemimmu_adr_i & `OR1200_QMEM_IMASK) == `OR1200_QMEM_IADDR;
`else
assign iaddr_qmem_hit = 1'b0;
`endif

`ifdef OR1200_QMEM_DADDR
assign daddr_qmem_hit = (qmemdmmu_adr_i & `OR1200_QMEM_DMASK) == `OR1200_QMEM_DADDR;
`else
assign daddr_qmem_hit = 1'b0;
`endif

//
//
//
assign qmem_en = iaddr_qmem_hit & qmemimmu_cycstb_i | daddr_qmem_hit & qmemdmmu_cycstb_i;
assign qmem_we = qmemdmmu_cycstb_i & daddr_qmem_hit & qmemdcpu_we_i;
`ifdef OR1200_QMEM_BSEL
assign qmem_sel = (qmemdmmu_cycstb_i & daddr_qmem_hit) ? qmemdcpu_sel_i : qmemicpu_sel_i;
`endif
assign qmem_di = qmemdcpu_dat_i;
assign qmem_addr = (qmemdmmu_cycstb_i & daddr_qmem_hit) ? qmemdmmu_adr_i : qmemimmu_adr_i;

//
// QMEM control FSM
//
always @( posedge clk)
	if (rst == `OR1200_RST_VALUE) begin
		state <=  `OR1200_QMEMFSM_IDLE;
		qmem_dack <=  1'b0;
		qmem_iack <=  1'b0;
	end
	else case (state)	// synopsys parallel_case
		`OR1200_QMEMFSM_IDLE: begin
			if (qmemdmmu_cycstb_i & daddr_qmem_hit & qmemdcpu_we_i & qmem_ack) begin
				state <=  `OR1200_QMEMFSM_STORE;
				qmem_dack <=  1'b1;
				qmem_iack <=  1'b0;
			end
			else if (qmemdmmu_cycstb_i & daddr_qmem_hit & qmem_ack) begin
				state <=  `OR1200_QMEMFSM_LOAD;
				qmem_dack <=  1'b1;
				qmem_iack <=  1'b0;
			end
			else if (qmemimmu_cycstb_i & iaddr_qmem_hit & qmem_ack) begin
				state <=  `OR1200_QMEMFSM_FETCH;
				qmem_iack <=  1'b1;
				qmem_dack <=  1'b0;
			end
		end
		`OR1200_QMEMFSM_STORE: begin
			if (qmemdmmu_cycstb_i & daddr_qmem_hit & qmemdcpu_we_i & qmem_ack) begin
				state <=  `OR1200_QMEMFSM_STORE;
				qmem_dack <=  1'b1;
				qmem_iack <=  1'b0;
			end
			else if (qmemdmmu_cycstb_i & daddr_qmem_hit & qmem_ack) begin
				state <=  `OR1200_QMEMFSM_LOAD;
				qmem_dack <=  1'b1;
				qmem_iack <=  1'b0;
			end
			else if (qmemimmu_cycstb_i & iaddr_qmem_hit & qmem_ack) begin
				state <=  `OR1200_QMEMFSM_FETCH;
				qmem_iack <=  1'b1;
				qmem_dack <=  1'b0;
			end
			else begin
				state <=  `OR1200_QMEMFSM_IDLE;
				qmem_dack <=  1'b0;
				qmem_iack <=  1'b0;
			end
		end
		`OR1200_QMEMFSM_LOAD: begin
			if (qmemdmmu_cycstb_i & daddr_qmem_hit & qmemdcpu_we_i & qmem_ack) begin
				state <=  `OR1200_QMEMFSM_STORE;
				qmem_dack <=  1'b1;
				qmem_iack <=  1'b0;
			end
			else if (qmemdmmu_cycstb_i & daddr_qmem_hit & qmem_ack) begin
				state <=  `OR1200_QMEMFSM_LOAD;
				qmem_dack <=  1'b1;
				qmem_iack <=  1'b0;
			end
			else if (qmemimmu_cycstb_i & iaddr_qmem_hit & qmem_ack) begin
				state <=  `OR1200_QMEMFSM_FETCH;
				qmem_iack <=  1'b1;
				qmem_dack <=  1'b0;
			end
			else begin
				state <=  `OR1200_QMEMFSM_IDLE;
				qmem_dack <=  1'b0;
				qmem_iack <=  1'b0;
			end
		end
		`OR1200_QMEMFSM_FETCH: begin
			if (qmemdmmu_cycstb_i & daddr_qmem_hit & qmemdcpu_we_i & qmem_ack) begin
				state <=  `OR1200_QMEMFSM_STORE;
				qmem_dack <=  1'b1;
				qmem_iack <=  1'b0;
			end
			else if (qmemdmmu_cycstb_i & daddr_qmem_hit & qmem_ack) begin
				state <=  `OR1200_QMEMFSM_LOAD;
				qmem_dack <=  1'b1;
				qmem_iack <=  1'b0;
			end
			else if (qmemimmu_cycstb_i & iaddr_qmem_hit & qmem_ack) begin
				state <=  `OR1200_QMEMFSM_FETCH;
				qmem_iack <=  1'b1;
				qmem_dack <=  1'b0;
			end
			else begin
				state <=  `OR1200_QMEMFSM_IDLE;
				qmem_dack <=  1'b0;
				qmem_iack <=  1'b0;
			end
		end
		default: begin
			state <=  `OR1200_QMEMFSM_IDLE;
			qmem_dack <=  1'b0;
			qmem_iack <=  1'b0;
		end
	endcase

//
// Instantiation of embedded memory
//
or1200_spram_2048x32 or1200_qmem_ram(
	.clk(clk),
	.rst(rst),
`ifdef OR1200_BIST
	// RAM BIST
	.mbist_si_i(mbist_si_i),
	.mbist_so_o(mbist_so_o),
	.mbist_ctrl_i(mbist_ctrl_i),
`endif
	.addr(qmem_addr[12:2]),
`ifdef OR1200_QMEM_BSEL
	.sel(qmem_sel),
`endif
`ifdef OR1200_QMEM_ACK
  .ack(qmem_ack),
`endif
  .ce(qmem_en),
	.we(qmem_we),
	.oe(1'b1),
	.di(qmem_di),
	.doq(qmem_do)
);

`else  // OR1200_QMEM_IMPLEMENTED

//
// QMEM and CPU/IMMU
//
assign qmemicpu_dat_o = icqmem_dat_i;
assign qmemicpu_ack_o = icqmem_ack_i;
assign qmemimmu_rty_o = icqmem_rty_i;
assign qmemimmu_err_o = icqmem_err_i;
assign qmemimmu_tag_o = icqmem_tag_i;

//
// QMEM and IC
//
assign icqmem_adr_o = qmemimmu_adr_i;
assign icqmem_cycstb_o = qmemimmu_cycstb_i;
assign icqmem_ci_o = qmemimmu_ci_i;
assign icqmem_sel_o = qmemicpu_sel_i;
assign icqmem_tag_o = qmemicpu_tag_i;

//
// QMEM and CPU/DMMU
//
assign qmemdcpu_dat_o = dcqmem_dat_i;
assign qmemdcpu_ack_o = dcqmem_ack_i;
assign qmemdcpu_rty_o = dcqmem_rty_i;
assign qmemdmmu_err_o = dcqmem_err_i;
assign qmemdmmu_tag_o = dcqmem_tag_i;

//
// QMEM and DC
//
assign dcqmem_adr_o = qmemdmmu_adr_i;
assign dcqmem_cycstb_o = qmemdmmu_cycstb_i;
assign dcqmem_ci_o = qmemdmmu_ci_i;
assign dcqmem_we_o = qmemdcpu_we_i;
assign dcqmem_sel_o = qmemdcpu_sel_i;
assign dcqmem_tag_o = qmemdcpu_tag_i;
assign dcqmem_dat_o = qmemdcpu_dat_i;

`ifdef OR1200_BIST
assign mbist_so_o = mbist_si_i;
`endif

`endif

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's reg2mem aligner                                    ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/cores/or1k/                        ////
////                                                              ////
////  Description                                                 ////
////  Aligns register data to memory alignment.                   ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_reg2mem.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 
//
// Revision 1.2  2002/03/29 15:16:56  lampret
// Some of the warnings fixed.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.9  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.8  2001/10/19 23:28:46  lampret
// Fixed some synthesis warnings. Configured with caches and MMUs.
//
// Revision 1.7  2001/10/14 13:12:10  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:36  igorm
// no message
//
// Revision 1.2  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.1  2001/07/20 00:46:21  lampret
// Development version of RTL. Libraries are missing.
//
//

// synopsys translate_off
// synopsys translate_on

module or1200_reg2mem(addr, lsu_op, regdata, memdata);

parameter width = `OR1200_OPERAND_WIDTH;

//
// I/O
//
input	[1:0]			addr;
input	[`OR1200_LSUOP_WIDTH-1:0]	lsu_op;
input	[width-1:0]		regdata;
output	[width-1:0]		memdata;

//
// Internal regs and wires
//
reg	[7:0]			memdata_hh;
reg	[7:0]			memdata_hl;
reg	[7:0]			memdata_lh;
reg	[7:0]			memdata_ll;

assign memdata = {memdata_hh, memdata_hl, memdata_lh, memdata_ll};

//
// Mux to memdata[31:24]
//
always @(lsu_op or addr or regdata) begin
	casez({lsu_op, addr[1:0]})	// synopsys parallel_case
		{`OR1200_LSUOP_SB, 2'b00} : memdata_hh = regdata[7:0];
		{`OR1200_LSUOP_SH, 2'b00} : memdata_hh = regdata[15:8];
		default : memdata_hh = regdata[31:24];
	endcase
end

//
// Mux to memdata[23:16]
//
always @(lsu_op or addr or regdata) begin
	casez({lsu_op, addr[1:0]})	// synopsys parallel_case
		{`OR1200_LSUOP_SW, 2'b00} : memdata_hl = regdata[23:16];
		default : memdata_hl = regdata[7:0];
	endcase
end

//
// Mux to memdata[15:8]
//
always @(lsu_op or addr or regdata) begin
	casez({lsu_op, addr[1:0]})	// synopsys parallel_case
		{`OR1200_LSUOP_SB, 2'b10} : memdata_lh = regdata[7:0];
		default : memdata_lh = regdata[15:8];
	endcase
end

//
// Mux to memdata[7:0]
//
always @(regdata)
	memdata_ll = regdata[7:0];

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's register file inside CPU                           ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Instantiation of register file memories                     ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_rf.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed, coding style changed. 
//

// synopsys translate_off
// synopsys translate_on

module or1200_rf(
	// Clock and reset
	clk, rst,

	// Write i/f
	cy_we_i, cy_we_o, supv, wb_freeze, addrw, dataw, we, flushpipe,

	// Read i/f
	id_freeze, addra, addrb, dataa, datab, rda, rdb,

	// Debug
	spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o, du_read
);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_REGFILE_ADDR_WIDTH;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// Write i/f
//
input				cy_we_i;
output				cy_we_o;
input				supv;
input				wb_freeze;
input	[aw-1:0]		addrw;
input	[dw-1:0]		dataw;
input				we;
input				flushpipe;

//
// Read i/f
//
input				id_freeze;
input	[aw-1:0]		addra;
input	[aw-1:0]		addrb;
output	[dw-1:0]		dataa;
output	[dw-1:0]		datab;
input				rda;
input				rdb;

//
// SPR access for debugging purposes
//
input				spr_cs;
input				spr_write;
input	[31:0]			spr_addr;
input	[31:0]			spr_dat_i;
output	[31:0]			spr_dat_o;
input    			du_read;
   
//
// Internal wires and regs
//
wire	[dw-1:0]		from_rfa;
wire	[dw-1:0]		from_rfb;
wire	[aw-1:0]		rf_addra;
wire	[aw-1:0]		rf_addrw;
wire	[dw-1:0]		rf_dataw;
wire				rf_we;
wire				spr_valid;
wire				rf_ena;
wire				rf_enb;
reg				rf_we_allow;

   // Logic to restore output on RFA after debug unit has read out via SPR if.
   // Problem was that the incorrect output would be on RFA after debug unit
   // had read out  - this is bad if that output is relied upon by execute
   // stage for next instruction. We simply save the last address for rf A and
   // and re-read it whenever the SPR select goes low, so we must remember
   // the last address and generate a signal for falling edge of SPR cs.
   // -- Julius
   
   // Detect falling edge of SPR select 
   reg 				spr_du_cs;
   wire 			spr_cs_fe;
   // Track RF A's address each time it's enabled
   reg	[aw-1:0]		addra_last;


   always @(posedge clk)
     if (rf_ena & !(spr_cs_fe | (du_read & spr_cs)))
       addra_last <= addra;

   always @(posedge clk)
     spr_du_cs <= spr_cs & du_read;

   assign spr_cs_fe = spr_du_cs & !(spr_cs & du_read);

   
//
// SPR access is valid when spr_cs is asserted and
// SPR address matches GPR addresses
//
assign spr_valid = spr_cs & (spr_addr[10:5] == `OR1200_SPR_RF);

//
// SPR data output is always from RF A
//
assign spr_dat_o = from_rfa;

//
// Operand A comes from RF or from saved A register
//
assign dataa = from_rfa;

//
// Operand B comes from RF or from saved B register
//
assign datab = from_rfb;

//
// RF A read address is either from SPRS or normal from CPU control
//
assign rf_addra = (spr_valid & !spr_write) ? spr_addr[4:0] : 
		  spr_cs_fe ? addra_last : addra;

//
// RF write address is either from SPRS or normal from CPU control
//
assign rf_addrw = (spr_valid & spr_write) ? spr_addr[4:0] : addrw;

//
// RF write data is either from SPRS or normal from CPU datapath
//
assign rf_dataw = (spr_valid & spr_write) ? spr_dat_i : dataw;

//
// RF write enable is either from SPRS or normal from CPU control
//
always @( posedge clk)
	if (rst == `OR1200_RST_VALUE)
		rf_we_allow <=  1'b1;
	else if (~wb_freeze)
		rf_we_allow <=  ~flushpipe;

//assign rf_we = ((spr_valid & spr_write) | (we & ~wb_freeze)) & rf_we_allow & (supv | (|rf_addrw));
assign rf_we = ((spr_valid & spr_write) | (we & ~wb_freeze)) & rf_we_allow;
//assign cy_we_o = cy_we_i && rf_we;
assign cy_we_o = cy_we_i && ~wb_freeze && rf_we_allow;
   
   
//
// CS RF A asserted when instruction reads operand A and ID stage
// is not stalled
//
//assign rf_ena = rda & ~id_freeze | spr_valid;	// probably works with fixed binutils
assign rf_ena = (rda & ~id_freeze) | (spr_valid & !spr_write) | spr_cs_fe;	// probably works with fixed binutils
// assign rf_ena = 1'b1;			// does not work with single-stepping
//assign rf_ena = ~id_freeze | spr_valid;	// works with broken binutils 

//
// CS RF B asserted when instruction reads operand B and ID stage
// is not stalled
//
//assign rf_enb = rdb & ~id_freeze | spr_valid;
assign rf_enb = rdb & ~id_freeze;
// assign rf_enb = 1'b1;
//assign rf_enb = ~id_freeze | spr_valid;	// works with broken binutils 

`ifdef OR1200_RFRAM_TWOPORT

//
// Instantiation of register file two-port RAM A
//
or1200_tpram_32x32 rf_a(
	// Port A
	.clk_a(clk),
	.rst_a(rst),
	.ce_a(rf_ena),
	.we_a(1'b0),
	.oe_a(1'b1),
	.addr_a(rf_addra),
	.di_a(32'h0000_0000),
	.do_a(from_rfa),

	// Port B
	.clk_b(clk),
	.rst_b(rst),
	.ce_b(rf_we),
	.we_b(rf_we),
	.oe_b(1'b0),
	.addr_b(rf_addrw),
	.di_b(rf_dataw),
	.do_b()
);

//
// Instantiation of register file two-port RAM B
//
or1200_tpram_32x32 rf_b(
	// Port A
	.clk_a(clk),
	.rst_a(rst),
	.ce_a(rf_enb),
	.we_a(1'b0),
	.oe_a(1'b1),
	.addr_a(addrb),
	.di_a(32'h0000_0000),
	.do_a(from_rfb),

	// Port B
	.clk_b(clk),
	.rst_b(rst),
	.ce_b(rf_we),
	.we_b(rf_we),
	.oe_b(1'b0),
	.addr_b(rf_addrw),
	.di_b(rf_dataw),
	.do_b()
);

`else

`ifdef OR1200_RFRAM_DUALPORT

//
// Instantiation of register file two-port RAM A
//
   or1200_dpram #
     (
      .aw(5),
      .dw(32)
      )
   rf_a
     (
      // Port A
      .clk_a(clk),
      .ce_a(rf_ena),
      .addr_a(rf_addra),
      .do_a(from_rfa),
      
      // Port B
      .clk_b(clk),
      .ce_b(rf_we),
      .we_b(rf_we),
      .addr_b(rf_addrw),
      .di_b(rf_dataw)
      );

   //
   // Instantiation of register file two-port RAM B
   //
   or1200_dpram #
     (
      .aw(5),
      .dw(32)
      )
   rf_b
     (
      // Port A
      .clk_a(clk),
      .ce_a(rf_enb),
      .addr_a(addrb),
      .do_a(from_rfb),
      
      // Port B
      .clk_b(clk),
      .ce_b(rf_we),
      .we_b(rf_we),
      .addr_b(rf_addrw),
      .di_b(rf_dataw)
      );
   
`else

`ifdef OR1200_RFRAM_GENERIC

//
// Instantiation of generic (flip-flop based) register file
//
or1200_rfram_generic rf_a(
	// Clock and reset
	.clk(clk),
	.rst(rst),

	// Port A
	.ce_a(rf_ena),
	.addr_a(rf_addra),
	.do_a(from_rfa),

	// Port B
	.ce_b(rf_enb),
	.addr_b(addrb),
	.do_b(from_rfb),

	// Port W
	.ce_w(rf_we),
	.we_w(rf_we),
	.addr_w(rf_addrw),
	.di_w(rf_dataw)
);

`else

//
// RFRAM type not specified
//
initial begin
	$display("Define RFRAM type.");
	$finish;
end

`endif
`endif
`endif

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's register file generic memory                       ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/cores/or1k/                        ////
////                                                              ////
////  Description                                                 ////
////  Generic (flip-flop based) register file memory              ////
////                                                              ////
////  To Do:                                                      ////
////   - nothing                                                  ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_rfram_generic.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Defines added, coding style changed. 
//
// Revision 1.3  2004/06/08 18:16:32  lampret
// GPR0 hardwired to zero.
//
// Revision 1.2  2002/09/03 22:28:21  lampret
// As per Taylor Su suggestion all case blocks are full case by default and optionally (OR1200_CASE_DEFAULT) can be disabled to increase clock frequncy.
//
// Revision 1.1  2002/06/08 16:23:30  lampret
// Generic flip-flop based memory macro for register file.
//
//

// synopsys translate_off
// synopsys translate_on

module or1200_rfram_generic(
	// Clock and reset
	clk, rst,

	// Port A
	ce_a, addr_a, do_a,

	// Port B
	ce_b, addr_b, do_b,

	// Port W
	ce_w, we_w, addr_w, di_w
);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_REGFILE_ADDR_WIDTH;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// Port A
//
input				ce_a;
input	[aw-1:0]		addr_a;
output	[dw-1:0]		do_a;

//
// Port B
//
input				ce_b;
input	[aw-1:0]		addr_b;
output	[dw-1:0]		do_b;

//
// Port W
//
input				ce_w;
input				we_w;
input	[aw-1:0]		addr_w;
input	[dw-1:0]		di_w;

//
// Internal wires and regs
//
reg	[aw-1:0]		intaddr_a;
reg	[aw-1:0]		intaddr_b;
`ifdef OR1200_RFRAM_16REG
reg	[16*dw-1:0]		mem;
`else
reg	[32*dw-1:0]		mem;
`endif
reg	[dw-1:0]		do_a;
reg	[dw-1:0]		do_b;

   // Function to access GPRs (for use by Verilator). No need to hide this one
   // from the simulator, since it has an input (as required by IEEE 1364-2001).
   function [31:0] get_gpr;
      // verilator public
      input [aw-1:0] 		gpr_no;

      get_gpr = { mem[gpr_no*32 + 31], mem[gpr_no*32 + 30],
                  mem[gpr_no*32 + 29], mem[gpr_no*32 + 28],
                  mem[gpr_no*32 + 27], mem[gpr_no*32 + 26],
                  mem[gpr_no*32 + 25], mem[gpr_no*32 + 24],
                  mem[gpr_no*32 + 23], mem[gpr_no*32 + 22],
                  mem[gpr_no*32 + 21], mem[gpr_no*32 + 20],
                  mem[gpr_no*32 + 19], mem[gpr_no*32 + 18],
                  mem[gpr_no*32 + 17], mem[gpr_no*32 + 16],
                  mem[gpr_no*32 + 15], mem[gpr_no*32 + 14],
                  mem[gpr_no*32 + 13], mem[gpr_no*32 + 12],
                  mem[gpr_no*32 + 11], mem[gpr_no*32 + 10],
                  mem[gpr_no*32 +  9], mem[gpr_no*32 +  8],
                  mem[gpr_no*32 +  7], mem[gpr_no*32 +  6],
                  mem[gpr_no*32 +  5], mem[gpr_no*32 +  4],
                  mem[gpr_no*32 +  3], mem[gpr_no*32 +  2],
                  mem[gpr_no*32 +  1], mem[gpr_no*32 +  0] };
      
   endfunction // get_gpr

//
// Write port
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE) begin
		mem <=  {512'h0, 512'h0};
	end
	else if (ce_w & we_w)
		case (addr_w)	// synopsys parallel_case
			5'd01: mem[32*1+31:32*1] <=  di_w;
			5'd02: mem[32*2+31:32*2] <=  di_w;
			5'd03: mem[32*3+31:32*3] <=  di_w;
			5'd04: mem[32*4+31:32*4] <=  di_w;
			5'd05: mem[32*5+31:32*5] <=  di_w;
			5'd06: mem[32*6+31:32*6] <=  di_w;
			5'd07: mem[32*7+31:32*7] <=  di_w;
			5'd08: mem[32*8+31:32*8] <=  di_w;
			5'd09: mem[32*9+31:32*9] <=  di_w;
			5'd10: mem[32*10+31:32*10] <=  di_w;
			5'd11: mem[32*11+31:32*11] <=  di_w;
			5'd12: mem[32*12+31:32*12] <=  di_w;
			5'd13: mem[32*13+31:32*13] <=  di_w;
			5'd14: mem[32*14+31:32*14] <=  di_w;
			5'd15: mem[32*15+31:32*15] <=  di_w;
`ifdef OR1200_RFRAM_16REG
`else
			5'd16: mem[32*16+31:32*16] <=  di_w;
			5'd17: mem[32*17+31:32*17] <=  di_w;
			5'd18: mem[32*18+31:32*18] <=  di_w;
			5'd19: mem[32*19+31:32*19] <=  di_w;
			5'd20: mem[32*20+31:32*20] <=  di_w;
			5'd21: mem[32*21+31:32*21] <=  di_w;
			5'd22: mem[32*22+31:32*22] <=  di_w;
			5'd23: mem[32*23+31:32*23] <=  di_w;
			5'd24: mem[32*24+31:32*24] <=  di_w;
			5'd25: mem[32*25+31:32*25] <=  di_w;
			5'd26: mem[32*26+31:32*26] <=  di_w;
			5'd27: mem[32*27+31:32*27] <=  di_w;
			5'd28: mem[32*28+31:32*28] <=  di_w;
			5'd29: mem[32*29+31:32*29] <=  di_w;
			5'd30: mem[32*30+31:32*30] <=  di_w;
			5'd31: mem[32*31+31:32*31] <=  di_w;
`endif
			default: mem[32*0+31:32*0] <=  32'h0000_0000;
		endcase

//
// Read port A
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE) begin
		intaddr_a <=  5'h00;
	end
	else if (ce_a)
		intaddr_a <=  addr_a;

always @(mem or intaddr_a)
	case (intaddr_a)	// synopsys parallel_case
		5'd01: do_a = mem[32*1+31:32*1];
		5'd02: do_a = mem[32*2+31:32*2];
		5'd03: do_a = mem[32*3+31:32*3];
		5'd04: do_a = mem[32*4+31:32*4];
		5'd05: do_a = mem[32*5+31:32*5];
		5'd06: do_a = mem[32*6+31:32*6];
		5'd07: do_a = mem[32*7+31:32*7];
		5'd08: do_a = mem[32*8+31:32*8];
		5'd09: do_a = mem[32*9+31:32*9];
		5'd10: do_a = mem[32*10+31:32*10];
		5'd11: do_a = mem[32*11+31:32*11];
		5'd12: do_a = mem[32*12+31:32*12];
		5'd13: do_a = mem[32*13+31:32*13];
		5'd14: do_a = mem[32*14+31:32*14];
		5'd15: do_a = mem[32*15+31:32*15];
`ifdef OR1200_RFRAM_16REG
`else
		5'd16: do_a = mem[32*16+31:32*16];
		5'd17: do_a = mem[32*17+31:32*17];
		5'd18: do_a = mem[32*18+31:32*18];
		5'd19: do_a = mem[32*19+31:32*19];
		5'd20: do_a = mem[32*20+31:32*20];
		5'd21: do_a = mem[32*21+31:32*21];
		5'd22: do_a = mem[32*22+31:32*22];
		5'd23: do_a = mem[32*23+31:32*23];
		5'd24: do_a = mem[32*24+31:32*24];
		5'd25: do_a = mem[32*25+31:32*25];
		5'd26: do_a = mem[32*26+31:32*26];
		5'd27: do_a = mem[32*27+31:32*27];
		5'd28: do_a = mem[32*28+31:32*28];
		5'd29: do_a = mem[32*29+31:32*29];
		5'd30: do_a = mem[32*30+31:32*30];
		5'd31: do_a = mem[32*31+31:32*31];
`endif
		default: do_a = 32'h0000_0000;
	endcase

//
// Read port B
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE) begin
		intaddr_b <=  5'h00;
	end
	else if (ce_b)
		intaddr_b <=  addr_b;

always @(mem or intaddr_b)
	case (intaddr_b)	// synopsys parallel_case
		5'd01: do_b = mem[32*1+31:32*1];
		5'd02: do_b = mem[32*2+31:32*2];
		5'd03: do_b = mem[32*3+31:32*3];
		5'd04: do_b = mem[32*4+31:32*4];
		5'd05: do_b = mem[32*5+31:32*5];
		5'd06: do_b = mem[32*6+31:32*6];
		5'd07: do_b = mem[32*7+31:32*7];
		5'd08: do_b = mem[32*8+31:32*8];
		5'd09: do_b = mem[32*9+31:32*9];
		5'd10: do_b = mem[32*10+31:32*10];
		5'd11: do_b = mem[32*11+31:32*11];
		5'd12: do_b = mem[32*12+31:32*12];
		5'd13: do_b = mem[32*13+31:32*13];
		5'd14: do_b = mem[32*14+31:32*14];
		5'd15: do_b = mem[32*15+31:32*15];
`ifdef OR1200_RFRAM_16REG
`else
		5'd16: do_b = mem[32*16+31:32*16];
		5'd17: do_b = mem[32*17+31:32*17];
		5'd18: do_b = mem[32*18+31:32*18];
		5'd19: do_b = mem[32*19+31:32*19];
		5'd20: do_b = mem[32*20+31:32*20];
		5'd21: do_b = mem[32*21+31:32*21];
		5'd22: do_b = mem[32*22+31:32*22];
		5'd23: do_b = mem[32*23+31:32*23];
		5'd24: do_b = mem[32*24+31:32*24];
		5'd25: do_b = mem[32*25+31:32*25];
		5'd26: do_b = mem[32*26+31:32*26];
		5'd27: do_b = mem[32*27+31:32*27];
		5'd28: do_b = mem[32*28+31:32*28];
		5'd29: do_b = mem[32*29+31:32*29];
		5'd30: do_b = mem[32*30+31:32*30];
		5'd31: do_b = mem[32*31+31:32*31];
`endif
		default: do_b = 32'h0000_0000;
	endcase

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Store Buffer                                       ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Implements store buffer.                                    ////
////                                                              ////
////  To Do:                                                      ////
////   - byte combining                                           ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2002 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//
// $Log: or1200_sb.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Minor update: 
// Bugs fixed. 

// synopsys translate_off
// synopsys translate_on

module or1200_sb(
	// RISC clock, reset
	clk, rst,

	// Internal RISC bus (SB)
	sb_en,

	// Internal RISC bus (DC<->SB)
	dcsb_dat_i, dcsb_adr_i, dcsb_cyc_i, dcsb_stb_i, dcsb_we_i, dcsb_sel_i, dcsb_cab_i,
	dcsb_dat_o, dcsb_ack_o, dcsb_err_o,

	// BIU bus
	sbbiu_dat_o, sbbiu_adr_o, sbbiu_cyc_o, sbbiu_stb_o, sbbiu_we_o, sbbiu_sel_o, sbbiu_cab_o,
	sbbiu_dat_i, sbbiu_ack_i, sbbiu_err_i
);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_OPERAND_WIDTH;

//
// RISC clock, reset
//
input			clk;		// RISC clock
input			rst;		// RISC reset

//
// Internal RISC bus (SB)
//
input			sb_en;		// SB enable

//
// Internal RISC bus (DC<->SB)
//
input	[dw-1:0]	dcsb_dat_i;	// input data bus
input	[aw-1:0]	dcsb_adr_i;	// address bus
input			dcsb_cyc_i;	// WB cycle
input			dcsb_stb_i;	// WB strobe
input			dcsb_we_i;	// WB write enable
input			dcsb_cab_i;	// CAB input
input	[3:0]		dcsb_sel_i;	// byte selects
output	[dw-1:0]	dcsb_dat_o;	// output data bus
output			dcsb_ack_o;	// ack output
output			dcsb_err_o;	// err output

//
// BIU bus
//
output	[dw-1:0]	sbbiu_dat_o;	// output data bus
output	[aw-1:0]	sbbiu_adr_o;	// address bus
output			sbbiu_cyc_o;	// WB cycle
output			sbbiu_stb_o;	// WB strobe
output			sbbiu_we_o;	// WB write enable
output			sbbiu_cab_o;	// CAB input
output	[3:0]		sbbiu_sel_o;	// byte selects
input	[dw-1:0]	sbbiu_dat_i;	// input data bus
input			sbbiu_ack_i;	// ack output
input			sbbiu_err_i;	// err output

`ifdef OR1200_SB_IMPLEMENTED

//
// Internal wires and regs
//
wire	[4+dw+aw-1:0]	fifo_dat_i;	// FIFO data in
wire	[4+dw+aw-1:0]	fifo_dat_o;	// FIFO data out
wire			fifo_wr;
wire			fifo_rd;
wire			fifo_full;
wire			fifo_empty;
wire			sel_sb;
reg			sb_en_reg;
reg			outstanding_store;
reg			fifo_wr_ack;

//
// FIFO data in/out
//
assign fifo_dat_i = {dcsb_sel_i, dcsb_dat_i, dcsb_adr_i};
assign {sbbiu_sel_o, sbbiu_dat_o, sbbiu_adr_o} = sel_sb ? fifo_dat_o : {dcsb_sel_i, dcsb_dat_i, dcsb_adr_i};

//
// Control
//
assign fifo_wr = dcsb_cyc_i & dcsb_stb_i & dcsb_we_i & ~fifo_full & ~fifo_wr_ack;
assign fifo_rd = ~outstanding_store;
assign dcsb_dat_o = sbbiu_dat_i;
assign dcsb_ack_o = sel_sb ? fifo_wr_ack : sbbiu_ack_i;
assign dcsb_err_o = sel_sb ? 1'b0 : sbbiu_err_i;	// SB never returns error
assign sbbiu_cyc_o = sel_sb ? outstanding_store : dcsb_cyc_i;
assign sbbiu_stb_o = sel_sb ? outstanding_store : dcsb_stb_i;
assign sbbiu_we_o = sel_sb ? 1'b1 : dcsb_we_i;
assign sbbiu_cab_o = sel_sb ? 1'b0 : dcsb_cab_i;
assign sel_sb = sb_en_reg & (~fifo_empty | (fifo_empty & outstanding_store));

//
// SB enable
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		sb_en_reg <= 1'b0;
	else if (sb_en & ~dcsb_cyc_i)
		sb_en_reg <=  1'b1; // enable SB when there is no dcsb transfer in progress
	else if (~sb_en & (~fifo_empty | (fifo_empty & outstanding_store)))
		sb_en_reg <=  1'b0; // disable SB when there is no pending transfers from SB

//
// Store buffer FIFO instantiation
//
or1200_sb_fifo or1200_sb_fifo (
	.clk_i(clk),
	.rst_i(rst),
	.dat_i(fifo_dat_i),
	.wr_i(fifo_wr),
	.rd_i(fifo_rd),
	.dat_o(fifo_dat_o),
	.full_o(fifo_full),
	.empty_o(fifo_empty)
);

//
// fifo_rd
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		outstanding_store <=  1'b0;
	else if (sbbiu_ack_i)
		outstanding_store <=  1'b0;
	else if (sel_sb | fifo_wr)
		outstanding_store <=  1'b1;

//
// fifo_wr_ack
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		fifo_wr_ack <=  1'b0;
	else if (fifo_wr)
		fifo_wr_ack <=  1'b1;
	else
		fifo_wr_ack <=  1'b0;

`else	// !OR1200_SB_IMPLEMENTED

assign sbbiu_dat_o = dcsb_dat_i;
assign sbbiu_adr_o = dcsb_adr_i;
assign sbbiu_cyc_o = dcsb_cyc_i;
assign sbbiu_stb_o = dcsb_stb_i;
assign sbbiu_we_o = dcsb_we_i;
assign sbbiu_cab_o = dcsb_cab_i;
assign sbbiu_sel_o = dcsb_sel_i;
assign dcsb_dat_o = sbbiu_dat_i;
assign dcsb_ack_o = sbbiu_ack_i;
assign dcsb_err_o = sbbiu_err_i;

`endif

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Store Buffer FIFO                                  ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/cores/or1k/                        ////
////                                                              ////
////  Description                                                 ////
////  Implementation of store buffer FIFO.                        ////
////                                                              ////
////  To Do:                                                      ////
////   - N/A                                                      ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2002 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_sb_fifo.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 
//
// Revision 1.3  2002/11/06 13:53:41  simons
// SB mem width fixed.
//
// Revision 1.2  2002/08/22 02:18:55  lampret
// Store buffer has been tested and it works. BY default it is still disabled until uClinux confirms correct operation on FPGA board.
//
// Revision 1.1  2002/08/18 19:53:08  lampret
// Added store buffer.
//
//

// synopsys translate_off
// synopsys translate_on

module or1200_sb_fifo(
	clk_i, rst_i, dat_i, wr_i, rd_i, dat_o, full_o, empty_o
);

parameter dw = 68;
parameter fw = `OR1200_SB_LOG;
parameter fl = `OR1200_SB_ENTRIES;

//
// FIFO signals
//
input			clk_i;	// Clock
input			rst_i;	// Reset
input	[dw-1:0]	dat_i;	// Input data bus
input			wr_i;	// Write request
input			rd_i;	// Read request
output [dw-1:0]	dat_o;	// Output data bus
output			full_o;	// FIFO full
output			empty_o;// FIFO empty

//
// Internal regs
//
reg	[dw-1:0]	mem [fl-1:0];
reg	[dw-1:0]	dat_o;
reg	[fw+1:0]	cntr;
reg	[fw-1:0]	wr_pntr;
reg	[fw-1:0]	rd_pntr;
reg			empty_o;
reg			full_o;

always @(posedge clk_i )
	if (rst_i == `OR1200_RST_VALUE) begin
		full_o <=  1'b0;
		empty_o <=  1'b1;
		wr_pntr <=  {fw{1'b0}};
		rd_pntr <=  {fw{1'b0}};
		cntr <=  {fw+2{1'b0}};
		dat_o <=  {dw{1'b0}};
	end
	else if (wr_i && rd_i) begin		// FIFO Read and Write
		mem[wr_pntr] <=  dat_i;
		if (wr_pntr >= fl-1)
			wr_pntr <=  {fw{1'b0}};
		else
			wr_pntr <=  wr_pntr + 1'b1;
		if (empty_o) begin
			dat_o <=  dat_i;
		end
		else begin
			dat_o <=  mem[rd_pntr];
		end
		if (rd_pntr >= fl-1)
			rd_pntr <=  {fw{1'b0}};
		else
			rd_pntr <=  rd_pntr + 1'b1;
	end
	else if (wr_i && !full_o) begin		// FIFO Write
		mem[wr_pntr] <=  dat_i;
		cntr <=  cntr + 1'b1;
		empty_o <=  1'b0;
		if (cntr >= (fl-1)) begin
			full_o <=  1'b1;
			cntr <=  fl;
		end
		if (wr_pntr >= fl-1)
			wr_pntr <=  {fw{1'b0}};
		else
			wr_pntr <=  wr_pntr + 1'b1;
	end
	else if (rd_i && !empty_o) begin	// FIFO Read
		dat_o <=  mem[rd_pntr];
		cntr <=  cntr - 1'b1;
		full_o <=  1'b0;
		if (cntr <= 1) begin
			empty_o <=  1'b1;
			cntr <=  {fw+2{1'b0}};
		end
		if (rd_pntr >= fl-1)
			rd_pntr <=  {fw{1'b0}};
		else
			rd_pntr <=  rd_pntr + 1'b1;
	end

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's interface to SPRs                                  ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  Decoding of SPR addresses and access to SPRs                ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// $Log: or1200_sprs.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 

// synopsys translate_off
// synopsys translate_on

module or1200_sprs(
		// Clk & Rst
		clk, rst,

		// Internal CPU interface
		flagforw, flag_we, flag, cyforw, cy_we, carry,
		addrbase, addrofs, dat_i, branch_op, ex_spr_read, ex_spr_write, 
		epcr, eear, esr, except_started,
		to_wbmux, epcr_we, eear_we, esr_we, pc_we, sr_we, to_sr, sr,
		spr_dat_cfgr, spr_dat_rf, spr_dat_npc, spr_dat_ppc, spr_dat_mac,
		boot_adr_sel_i,
		
		// Floating point SPR input
		fpcsr, fpcsr_we, spr_dat_fpu,

		// From/to other RISC units
		spr_dat_pic, spr_dat_tt, spr_dat_pm,
		spr_dat_dmmu, spr_dat_immu, spr_dat_du,
		spr_addr, spr_dat_o, spr_cs, spr_we,

		du_addr, du_dat_du, du_read,
		du_write, du_dat_cpu

);

parameter width = `OR1200_OPERAND_WIDTH;

//
// I/O Ports
//

//
// Internal CPU interface
//
input				clk; 		// Clock
input 				rst;		// Reset
input 				flagforw;	// From ALU
input 				flag_we;	// From ALU
output 				flag;		// SR[F]
input 				cyforw;		// From ALU
input 				cy_we;		// From ALU
output 				carry;		// SR[CY]
input	[width-1:0] 		addrbase;	// SPR base address
input	[15:0] 			addrofs;	// SPR offset
input	[width-1:0]		dat_i;		// SPR write data
input                           ex_spr_read;	// l.mfspr in EX
input                           ex_spr_write;	// l.mtspr in EX
input	[`OR1200_BRANCHOP_WIDTH-1:0]	branch_op;	// Branch operation
input	[width-1:0] 		epcr /* verilator public */;		// EPCR0
input	[width-1:0] 		eear /* verilator public */;		// EEAR0
input	[`OR1200_SR_WIDTH-1:0] 	esr /* verilator public */;		// ESR0
input 				except_started; // Exception was started
output	[width-1:0]		to_wbmux;	// For l.mfspr
output				epcr_we;	// EPCR0 write enable
output				eear_we;	// EEAR0 write enable
output				esr_we;		// ESR0 write enable
output				pc_we;		// PC write enable
output 				sr_we;		// Write enable SR
output	[`OR1200_SR_WIDTH-1:0]	to_sr;		// Data to SR
output	[`OR1200_SR_WIDTH-1:0]	sr /* verilator public */;		// SR
input	[31:0]			spr_dat_cfgr;	// Data from CFGR
input	[31:0]			spr_dat_rf;	// Data from RF
input	[31:0]			spr_dat_npc;	// Data from NPC
input	[31:0]			spr_dat_ppc;	// Data from PPC   
input	[31:0]			spr_dat_mac;	// Data from MAC
input				boot_adr_sel_i;

input 	[`OR1200_FPCSR_WIDTH-1:0]       fpcsr;	// FPCSR
output 				fpcsr_we;	// Write enable FPCSR   
input [31:0] 			spr_dat_fpu;    // Data from FPU
   
//
// To/from other RISC units
//
input	[31:0]			spr_dat_pic;	// Data from PIC
input	[31:0]			spr_dat_tt;	// Data from TT
input	[31:0]			spr_dat_pm;	// Data from PM
input	[31:0]			spr_dat_dmmu;	// Data from DMMU
input	[31:0]			spr_dat_immu;	// Data from IMMU
input	[31:0]			spr_dat_du;	// Data from DU
output	[31:0]			spr_addr;	// SPR Address
output	[31:0]			spr_dat_o;	// Data to unit
output	[31:0]			spr_cs;		// Unit select
output				spr_we;		// SPR write enable

//
// To/from Debug Unit
//
input	[width-1:0]		du_addr;	// Address
input	[width-1:0]		du_dat_du;	// Data from DU to SPRS
input				du_read;	// Read qualifier
input				du_write;	// Write qualifier
output	[width-1:0]		du_dat_cpu;	// Data from SPRS to DU

//
// Internal regs & wires
//
reg	[`OR1200_SR_WIDTH-1:0]	sr_reg;			// SR
reg				sr_reg_bit_eph;		// SR_EPH bit
reg				sr_reg_bit_eph_select;	// SR_EPH select
wire				sr_reg_bit_eph_muxed;	// SR_EPH muxed bit
reg	[`OR1200_SR_WIDTH-1:0]	sr;			// SR
reg	[width-1:0]		to_wbmux;	// For l.mfspr
wire				cfgr_sel;	// Select for cfg regs
wire				rf_sel;		// Select for RF
wire				npc_sel;	// Select for NPC
wire				ppc_sel;	// Select for PPC
wire 				sr_sel;		// Select for SR	
wire 				epcr_sel;	// Select for EPCR0
wire 				eear_sel;	// Select for EEAR0
wire 				esr_sel;	// Select for ESR0
wire 				fpcsr_sel;	// Select for FPCSR   
wire	[31:0]			sys_data;	// Read data from system SPRs
wire				du_access;	// Debug unit access
reg	[31:0]			unqualified_cs;	// Unqualified chip selects
   wire 			ex_spr_write; // jb
   
//
// Decide if it is debug unit access
//
assign du_access = du_read | du_write;

//
// Generate SPR address from base address and offset
// OR from debug unit address
//
assign spr_addr = du_access ? du_addr : (addrbase | {16'h0000, addrofs});

//
// SPR is written by debug unit or by l.mtspr
//
assign spr_dat_o = du_write ? du_dat_du : dat_i;

//
// debug unit data input:
//  - read of SPRS by debug unit
//  - write into debug unit SPRs by debug unit itself
//  - write into debug unit SPRs by l.mtspr
//
assign du_dat_cpu = du_read ? to_wbmux : du_write ? du_dat_du : dat_i;

//
// Write into SPRs when DU or l.mtspr
//
assign spr_we = du_write | ( ex_spr_write & !du_access );


//
// Qualify chip selects
//
assign spr_cs = unqualified_cs & {32{du_read | du_write | ex_spr_read | (ex_spr_write & sr[`OR1200_SR_SM])}};

//
// Decoding of groups
//
always @(spr_addr)
	case (spr_addr[`OR1200_SPR_GROUP_BITS])	// synopsys parallel_case
		`OR1200_SPR_GROUP_WIDTH'd00: unqualified_cs = 32'b00000000_00000000_00000000_00000001;
		`OR1200_SPR_GROUP_WIDTH'd01: unqualified_cs = 32'b00000000_00000000_00000000_00000010;
		`OR1200_SPR_GROUP_WIDTH'd02: unqualified_cs = 32'b00000000_00000000_00000000_00000100;
		`OR1200_SPR_GROUP_WIDTH'd03: unqualified_cs = 32'b00000000_00000000_00000000_00001000;
		`OR1200_SPR_GROUP_WIDTH'd04: unqualified_cs = 32'b00000000_00000000_00000000_00010000;
		`OR1200_SPR_GROUP_WIDTH'd05: unqualified_cs = 32'b00000000_00000000_00000000_00100000;
		`OR1200_SPR_GROUP_WIDTH'd06: unqualified_cs = 32'b00000000_00000000_00000000_01000000;
		`OR1200_SPR_GROUP_WIDTH'd07: unqualified_cs = 32'b00000000_00000000_00000000_10000000;
		`OR1200_SPR_GROUP_WIDTH'd08: unqualified_cs = 32'b00000000_00000000_00000001_00000000;
		`OR1200_SPR_GROUP_WIDTH'd09: unqualified_cs = 32'b00000000_00000000_00000010_00000000;
		`OR1200_SPR_GROUP_WIDTH'd10: unqualified_cs = 32'b00000000_00000000_00000100_00000000;
		`OR1200_SPR_GROUP_WIDTH'd11: unqualified_cs = 32'b00000000_00000000_00001000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd12: unqualified_cs = 32'b00000000_00000000_00010000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd13: unqualified_cs = 32'b00000000_00000000_00100000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd14: unqualified_cs = 32'b00000000_00000000_01000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd15: unqualified_cs = 32'b00000000_00000000_10000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd16: unqualified_cs = 32'b00000000_00000001_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd17: unqualified_cs = 32'b00000000_00000010_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd18: unqualified_cs = 32'b00000000_00000100_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd19: unqualified_cs = 32'b00000000_00001000_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd20: unqualified_cs = 32'b00000000_00010000_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd21: unqualified_cs = 32'b00000000_00100000_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd22: unqualified_cs = 32'b00000000_01000000_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd23: unqualified_cs = 32'b00000000_10000000_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd24: unqualified_cs = 32'b00000001_00000000_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd25: unqualified_cs = 32'b00000010_00000000_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd26: unqualified_cs = 32'b00000100_00000000_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd27: unqualified_cs = 32'b00001000_00000000_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd28: unqualified_cs = 32'b00010000_00000000_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd29: unqualified_cs = 32'b00100000_00000000_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd30: unqualified_cs = 32'b01000000_00000000_00000000_00000000;
		`OR1200_SPR_GROUP_WIDTH'd31: unqualified_cs = 32'b10000000_00000000_00000000_00000000;
	endcase

//
// SPRs System Group
//

//
// What to write into SR
//
assign to_sr[`OR1200_SR_FO:`OR1200_SR_OV] =
		(except_started) ? sr[`OR1200_SR_FO:`OR1200_SR_OV] :
		(branch_op == `OR1200_BRANCHOP_RFE) ? esr[`OR1200_SR_FO:`OR1200_SR_OV] :
		(spr_we && sr_sel) ? {1'b1, spr_dat_o[`OR1200_SR_FO-1:`OR1200_SR_OV]}:
		sr[`OR1200_SR_FO:`OR1200_SR_OV];
assign to_sr[`OR1200_SR_TED] =
		(except_started) ? 1'b1 :
		(branch_op == `OR1200_BRANCHOP_RFE) ? esr[`OR1200_SR_TED] :
		(spr_we && sr_sel) ? spr_dat_o[`OR1200_SR_TED]:
		sr[`OR1200_SR_TED];
assign to_sr[`OR1200_SR_CY] =
		(except_started) ? sr[`OR1200_SR_CY] :
		(branch_op == `OR1200_BRANCHOP_RFE) ? esr[`OR1200_SR_CY] :
		cy_we ? cyforw :
		(spr_we && sr_sel) ? spr_dat_o[`OR1200_SR_CY] :
		sr[`OR1200_SR_CY];
assign to_sr[`OR1200_SR_F] =
		(except_started) ? sr[`OR1200_SR_F] :
		(branch_op == `OR1200_BRANCHOP_RFE) ? esr[`OR1200_SR_F] :
		flag_we ? flagforw :
		(spr_we && sr_sel) ? spr_dat_o[`OR1200_SR_F] :
		sr[`OR1200_SR_F];
assign to_sr[`OR1200_SR_CE:`OR1200_SR_SM] =
		(except_started) ? {sr[`OR1200_SR_CE:`OR1200_SR_LEE], 2'b00, sr[`OR1200_SR_ICE:`OR1200_SR_DCE], 3'b001} :
		(branch_op == `OR1200_BRANCHOP_RFE) ? esr[`OR1200_SR_CE:`OR1200_SR_SM] :
		(spr_we && sr_sel) ? spr_dat_o[`OR1200_SR_CE:`OR1200_SR_SM]:
		sr[`OR1200_SR_CE:`OR1200_SR_SM];

//
// Selects for system SPRs
//
assign cfgr_sel = (spr_cs[`OR1200_SPR_GROUP_SYS] && (spr_addr[10:4] == `OR1200_SPR_CFGR));
assign rf_sel = (spr_cs[`OR1200_SPR_GROUP_SYS] && (spr_addr[10:5] == `OR1200_SPR_RF));
assign npc_sel = (spr_cs[`OR1200_SPR_GROUP_SYS] && (spr_addr[10:0] == `OR1200_SPR_NPC));
assign ppc_sel = (spr_cs[`OR1200_SPR_GROUP_SYS] && (spr_addr[10:0] == `OR1200_SPR_PPC));
assign sr_sel = (spr_cs[`OR1200_SPR_GROUP_SYS] && (spr_addr[10:0] == `OR1200_SPR_SR));
assign epcr_sel = (spr_cs[`OR1200_SPR_GROUP_SYS] && (spr_addr[10:0] == `OR1200_SPR_EPCR));
assign eear_sel = (spr_cs[`OR1200_SPR_GROUP_SYS] && (spr_addr[10:0] == `OR1200_SPR_EEAR));
assign esr_sel = (spr_cs[`OR1200_SPR_GROUP_SYS] && (spr_addr[10:0] == `OR1200_SPR_ESR));
assign fpcsr_sel = (spr_cs[`OR1200_SPR_GROUP_SYS] && (spr_addr[10:0] == `OR1200_SPR_FPCSR));


//
// Write enables for system SPRs
//
assign sr_we = (spr_we && sr_sel) | (branch_op == `OR1200_BRANCHOP_RFE) | flag_we | cy_we;
assign pc_we = (du_write && (npc_sel | ppc_sel));
assign epcr_we = (spr_we && epcr_sel);
assign eear_we = (spr_we && eear_sel);
assign esr_we = (spr_we && esr_sel);
assign fpcsr_we = (spr_we && fpcsr_sel);
   
//
// Output from system SPRs
//
assign sys_data = (spr_dat_cfgr & {32{cfgr_sel}}) |
		  (spr_dat_rf & {32{rf_sel}}) |
		  (spr_dat_npc & {32{npc_sel}}) |
		  (spr_dat_ppc & {32{ppc_sel}}) |
		  ({{32-`OR1200_SR_WIDTH{1'b0}},sr} & {32{sr_sel}}) |
		  (epcr & {32{epcr_sel}}) |
		  (eear & {32{eear_sel}}) |
		  ({{32-`OR1200_FPCSR_WIDTH{1'b0}},fpcsr} & {32{fpcsr_sel}}) |
		  ({{32-`OR1200_SR_WIDTH{1'b0}},esr} & {32{esr_sel}});

//
// Flag alias
//
assign flag = sr[`OR1200_SR_F];

//
// Carry alias
//
assign carry = sr[`OR1200_SR_CY];

//
// Supervision register
//
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		sr_reg <=  {2'h1, `OR1200_SR_EPH_DEF, {`OR1200_SR_WIDTH-4{1'b0}}, 1'b1};
	else if (except_started)
		sr_reg <=  to_sr[`OR1200_SR_WIDTH-1:0];
	else if (sr_we)
		sr_reg <=  to_sr[`OR1200_SR_WIDTH-1:0];

// EPH part of Supervision register
always @(posedge clk )
	// default value 
	if (rst == `OR1200_RST_VALUE) begin
		sr_reg_bit_eph <=  `OR1200_SR_EPH_DEF;
		sr_reg_bit_eph_select <=  1'b1;	// select async. value due to reset state
	end
	// selected value (different from default) is written into FF after reset state
	else if (sr_reg_bit_eph_select) begin
		sr_reg_bit_eph <=  boot_adr_sel_i;	// dynamic value can only be assigned to FF out of reset! 
		sr_reg_bit_eph_select <=  1'b0;	// select FF value 
	end
	else if (sr_we) begin
		sr_reg_bit_eph <=  to_sr[`OR1200_SR_EPH];
	end

// select async. value of EPH bit after reset 
assign	sr_reg_bit_eph_muxed = (sr_reg_bit_eph_select) ? boot_adr_sel_i : sr_reg_bit_eph;

// EPH part joined together with rest of Supervision register
always @(sr_reg or sr_reg_bit_eph_muxed)
	sr = {sr_reg[`OR1200_SR_WIDTH-1:`OR1200_SR_WIDTH-2], sr_reg_bit_eph_muxed, sr_reg[`OR1200_SR_WIDTH-4:0]};

`ifdef verilator
   // Function to access various sprs (for Verilator). Have to hide this from
   // simulator, since functions with no inputs are not allowed in IEEE
   // 1364-2001.

   function [31:0] get_sr;
      // verilator public
      get_sr = {{32-`OR1200_SR_WIDTH{1'b0}},sr};
   endfunction // get_sr

   function [31:0] get_epcr;
      // verilator public
      get_epcr = epcr;
   endfunction // get_epcr

   function [31:0] get_eear;
      // verilator public
      get_eear = eear;
   endfunction // get_eear

   function [31:0] get_esr;
      // verilator public
      get_esr = {{32-`OR1200_SR_WIDTH{1'b0}},esr};
   endfunction // get_esr

`endif

   
//
// MTSPR/MFSPR interface
//
always @(spr_addr or sys_data or spr_dat_mac or spr_dat_pic or spr_dat_pm or
	 spr_dat_fpu or
	spr_dat_dmmu or spr_dat_immu or spr_dat_du or spr_dat_tt) begin
		casez (spr_addr[`OR1200_SPR_GROUP_BITS]) // synopsys parallel_case
			`OR1200_SPR_GROUP_SYS:
				to_wbmux = sys_data;
			`OR1200_SPR_GROUP_TT:
				to_wbmux = spr_dat_tt;
			`OR1200_SPR_GROUP_PIC:
				to_wbmux = spr_dat_pic;
			`OR1200_SPR_GROUP_PM:
				to_wbmux = spr_dat_pm;
			`OR1200_SPR_GROUP_DMMU:
				to_wbmux = spr_dat_dmmu;
			`OR1200_SPR_GROUP_IMMU:
				to_wbmux = spr_dat_immu;
			`OR1200_SPR_GROUP_MAC:
				to_wbmux = spr_dat_mac;
		        `OR1200_SPR_GROUP_FPU:
			         to_wbmux = spr_dat_fpu;
			default: //`OR1200_SPR_GROUP_DU:
				to_wbmux = spr_dat_du;
		endcase
end

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200 Top Level                                            ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  OR1200 Top Level                                            ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_top.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered. 
//

// synopsys translate_off
// synopsys translate_on

module or1200_top(
	// System
	clk_i, rst_i, pic_ints_i, clmode_i,

	// Instruction WISHBONE INTERFACE
	iwb_rst_i, iwb_ack_i, iwb_err_i, iwb_rty_i, iwb_dat_i,
	iwb_cyc_o, iwb_adr_o, iwb_stb_o, iwb_we_o, iwb_sel_o, iwb_dat_o,
`ifdef OR1200_WB_CAB
	iwb_cab_o,
`endif
`ifdef OR1200_WB_B3
	iwb_cti_o, iwb_bte_o,
`endif
	// Data WISHBONE INTERFACE
	dwb_rst_i, dwb_ack_i, dwb_err_i, dwb_rty_i, dwb_dat_i,
	dwb_cyc_o, dwb_adr_o, dwb_stb_o, dwb_we_o, dwb_sel_o, dwb_dat_o,
`ifdef OR1200_WB_CAB
	dwb_cab_o,
`endif
`ifdef OR1200_WB_B3
	dwb_cti_o, dwb_bte_o,
`endif

	// External Debug Interface
	dbg_stall_i, dbg_ewt_i,	dbg_lss_o, dbg_is_o, dbg_wp_o, dbg_bp_o,
	dbg_stb_i, dbg_we_i, dbg_adr_i, dbg_dat_i, dbg_dat_o, dbg_ack_o,
	
`ifdef OR1200_BIST
	// RAM BIST
	mbist_si_i, mbist_so_o, mbist_ctrl_i,
`endif
	// Power Management
	pm_cpustall_i,
	pm_clksd_o, pm_dc_gate_o, pm_ic_gate_o, pm_dmmu_gate_o, 
	pm_immu_gate_o, pm_tt_gate_o, pm_cpu_gate_o, pm_wakeup_o, pm_lvolt_o

,sig_tick		  

);

parameter dw = `OR1200_OPERAND_WIDTH;
parameter aw = `OR1200_OPERAND_WIDTH;
parameter ppic_ints = `OR1200_PIC_INTS;

//
// I/O
//

//
// System
//
input			clk_i;
input			rst_i;
input	[1:0]		clmode_i;	// 00 WB=RISC, 01 WB=RISC/2, 10 N/A, 11 WB=RISC/4
input	[ppic_ints-1:0]	pic_ints_i;

//
// Instruction WISHBONE interface
//
wire			iwb_clk_i;	// clock input
input			iwb_rst_i;	// reset input
input			iwb_ack_i;	// normal termination
input			iwb_err_i;	// termination w/ error
input			iwb_rty_i;	// termination w/ retry
input	[dw-1:0]	iwb_dat_i;	// input data bus
output			iwb_cyc_o;	// cycle valid output
output	[aw-1:0]	iwb_adr_o;	// address bus outputs
output			iwb_stb_o;	// strobe output
output			iwb_we_o;	// indicates write transfer
output	[3:0]		iwb_sel_o;	// byte select outputs
output	[dw-1:0]	iwb_dat_o;	// output data bus
`ifdef OR1200_WB_CAB
output			iwb_cab_o;	// indicates consecutive address burst
`endif
`ifdef OR1200_WB_B3
output	[2:0]		iwb_cti_o;	// cycle type identifier
output	[1:0]		iwb_bte_o;	// burst type extension
`endif

//
// Data WISHBONE interface
//
wire			dwb_clk_i;	// clock input
input			dwb_rst_i;	// reset input
input			dwb_ack_i;	// normal termination
input			dwb_err_i;	// termination w/ error
input			dwb_rty_i;	// termination w/ retry
input	[dw-1:0]	dwb_dat_i;	// input data bus
output			dwb_cyc_o;	// cycle valid output
output	[aw-1:0]	dwb_adr_o;	// address bus outputs
output			dwb_stb_o;	// strobe output
output			dwb_we_o;	// indicates write transfer
output	[3:0]		dwb_sel_o;	// byte select outputs
output	[dw-1:0]	dwb_dat_o;	// output data bus
`ifdef OR1200_WB_CAB
output			dwb_cab_o;	// indicates consecutive address burst
`endif
`ifdef OR1200_WB_B3
output	[2:0]		dwb_cti_o;	// cycle type identifier
output	[1:0]		dwb_bte_o;	// burst type extension
`endif

//
// External Debug Interface
//
input			dbg_stall_i;	// External Stall Input
input			dbg_ewt_i;	// External Watchpoint Trigger Input
output	[3:0]		dbg_lss_o;	// External Load/Store Unit Status
output	[1:0]		dbg_is_o;	// External Insn Fetch Status
output	[10:0]		dbg_wp_o;	// Watchpoints Outputs
output			dbg_bp_o;	// Breakpoint Output
input			dbg_stb_i;      // External Address/Data Strobe
input			dbg_we_i;       // External Write Enable
input	[aw-1:0]	dbg_adr_i;	// External Address Input
input	[dw-1:0]	dbg_dat_i;	// External Data Input
output	[dw-1:0]	dbg_dat_o;	// External Data Output
output			dbg_ack_o;	// External Data Acknowledge (not WB compatible)

`ifdef OR1200_BIST
//
// RAM BIST
//
input mbist_si_i;
input [`OR1200_MBIST_CTRL_WIDTH - 1:0] mbist_ctrl_i;
output mbist_so_o;
`endif

//
// Power Management
//
input			pm_cpustall_i;
output	[3:0]		pm_clksd_o;
output			pm_dc_gate_o;
output			pm_ic_gate_o;
output			pm_dmmu_gate_o;
output			pm_immu_gate_o;
output			pm_tt_gate_o;
output			pm_cpu_gate_o;
output			pm_wakeup_o;
output			pm_lvolt_o;


//
// Internal wires and regs
//

//
// DC to SB
//
wire	[dw-1:0]	dcsb_dat_dc;
wire	[aw-1:0]	dcsb_adr_dc;
wire			dcsb_cyc_dc;
wire			dcsb_stb_dc;
wire			dcsb_we_dc;
wire	[3:0]		dcsb_sel_dc;
wire			dcsb_cab_dc;
wire	[dw-1:0]	dcsb_dat_sb;
wire			dcsb_ack_sb;
wire			dcsb_err_sb;

//
// SB to BIU
//
wire	[dw-1:0]	sbbiu_dat_sb;
wire	[aw-1:0]	sbbiu_adr_sb;
wire			sbbiu_cyc_sb;
wire			sbbiu_stb_sb;
wire			sbbiu_we_sb;
wire	[3:0]		sbbiu_sel_sb;
wire			sbbiu_cab_sb;
wire	[dw-1:0]	sbbiu_dat_biu;
wire			sbbiu_ack_biu;
wire			sbbiu_err_biu;

//
// IC to BIU
//
wire	[dw-1:0]	icbiu_dat_ic;
wire	[aw-1:0]	icbiu_adr_ic;
wire	[aw-1:0]	icbiu_adr_ic_word;
wire			icbiu_cyc_ic;
wire			icbiu_stb_ic;
wire			icbiu_we_ic;
wire	[3:0]		icbiu_sel_ic;
wire	[3:0]		icbiu_tag_ic;
wire			icbiu_cab_ic;
wire	[dw-1:0]	icbiu_dat_biu;
wire			icbiu_ack_biu;
wire			icbiu_err_biu;
wire	[3:0]		icbiu_tag_biu;

//
// SR Interface (this signal can be connected to the input pin)
//
wire 			boot_adr_sel = `OR1200_SR_EPH_DEF;

//
// CPU's SPR access to various RISC units (shared wires)
//
wire			supv;
wire	[aw-1:0]	spr_addr;
wire	[dw-1:0]	spr_dat_cpu;
wire	[31:0]		spr_cs;
wire			spr_we;
wire    		mtspr_dc_done;
   
//
// SB
//
wire			sb_en;

//
// DMMU and CPU
//
wire			dmmu_en;
wire	[31:0]		spr_dat_dmmu;

//
// DMMU and QMEM
//
wire			qmemdmmu_err_qmem;
wire	[3:0]		qmemdmmu_tag_qmem;
wire	[aw-1:0]	qmemdmmu_adr_dmmu;
wire			qmemdmmu_cycstb_dmmu;
wire			qmemdmmu_ci_dmmu;

//
// CPU and data memory subsystem
//
wire			dc_en;
wire	[31:0]		dcpu_adr_cpu;
wire			dcpu_cycstb_cpu;
wire			dcpu_we_cpu;
wire	[3:0]		dcpu_sel_cpu;
wire	[3:0]		dcpu_tag_cpu;
wire	[31:0]		dcpu_dat_cpu;
wire	[31:0]		dcpu_dat_qmem;
wire			dcpu_ack_qmem;
wire			dcpu_rty_qmem;
wire			dcpu_err_dmmu;
wire	[3:0]		dcpu_tag_dmmu;
wire    		dc_no_writethrough;
   
//
// IMMU and CPU
//
wire			immu_en;
wire	[31:0]		spr_dat_immu;

//
// CPU and insn memory subsystem
//
wire			ic_en;
wire	[31:0]		icpu_adr_cpu;
wire			icpu_cycstb_cpu;
wire	[3:0]		icpu_sel_cpu;
wire	[3:0]		icpu_tag_cpu;
wire	[31:0]		icpu_dat_qmem;
wire			icpu_ack_qmem;
wire	[31:0]		icpu_adr_immu;
wire			icpu_err_immu;
wire	[3:0]		icpu_tag_immu;
wire			icpu_rty_immu;

//
// IMMU and QMEM
//
wire	[aw-1:0]	qmemimmu_adr_immu;
wire			qmemimmu_rty_qmem;
wire			qmemimmu_err_qmem;
wire	[3:0]		qmemimmu_tag_qmem;
wire			qmemimmu_cycstb_immu;
wire			qmemimmu_ci_immu;

//
// QMEM and IC
//
wire	[aw-1:0]	icqmem_adr_qmem;
wire			icqmem_rty_ic;
wire			icqmem_err_ic;
wire	[3:0]		icqmem_tag_ic;
wire			icqmem_cycstb_qmem;
wire			icqmem_ci_qmem;
wire	[31:0]		icqmem_dat_ic;
wire			icqmem_ack_ic;

//
// QMEM and DC
//
wire	[aw-1:0]	dcqmem_adr_qmem;
wire			dcqmem_rty_dc;
wire			dcqmem_err_dc;
wire	[3:0]		dcqmem_tag_dc;
wire			dcqmem_cycstb_qmem;
wire			dcqmem_ci_qmem;
wire	[31:0]		dcqmem_dat_dc;
wire	[31:0]		dcqmem_dat_qmem;
wire			dcqmem_we_qmem;
wire	[3:0]		dcqmem_sel_qmem;
wire			dcqmem_ack_dc;

//
// Connection between CPU and PIC
//
wire	[dw-1:0]	spr_dat_pic;
wire			pic_wakeup;
wire			sig_int;

//
// Connection between CPU and PM
//
wire	[dw-1:0]	spr_dat_pm;

//
// CPU and TT
//
wire	[dw-1:0]	spr_dat_tt;
output wire			sig_tick; // jb

//
// Debug port and caches/MMUs
//
wire	[dw-1:0]	spr_dat_du;
wire			du_stall;
wire	[dw-1:0]	du_addr;
wire	[dw-1:0]	du_dat_du;
wire			du_read;
wire			du_write;
wire	[13:0]		du_except_trig;
wire	[13:0]		du_except_stop;
wire	[`OR1200_DU_DSR_WIDTH-1:0]     du_dsr;
wire	[24:0]		du_dmr1;
wire	[dw-1:0]	du_dat_cpu;
wire	[dw-1:0]	du_lsu_store_dat;
wire	[dw-1:0]	du_lsu_load_dat;
wire			du_hwbkpt;
wire			du_hwbkpt_ls_r = 1'b0;
wire			flushpipe;
wire			ex_freeze;
wire			wb_freeze;
wire			id_void;
wire			ex_void;
wire	[31:0]		id_insn;
wire	[31:0]		ex_insn;
wire	[31:0]		wb_insn;
wire	[31:0]		id_pc;
wire	[31:0]		ex_pc;
wire	[31:0]		wb_pc;
wire	[`OR1200_BRANCHOP_WIDTH-1:0]	branch_op;
wire	[31:0]		spr_dat_npc;
wire	[31:0]		rf_dataw;
wire			abort_ex;
wire			abort_mvspr;

`ifdef OR1200_BIST
//
// RAM BIST
//
wire			mbist_immu_so;
wire			mbist_ic_so;
wire			mbist_dmmu_so;
wire			mbist_dc_so;
wire			mbist_qmem_so;
wire			mbist_immu_si = mbist_si_i;
wire			mbist_ic_si = mbist_immu_so;
wire			mbist_qmem_si = mbist_ic_so;
wire			mbist_dmmu_si = mbist_qmem_so;
wire			mbist_dc_si = mbist_dmmu_so;
assign			mbist_so_o = mbist_dc_so;
`endif

wire  [3:0] icqmem_sel_qmem;
wire  [3:0] icqmem_tag_qmem;
wire  [3:0] dcqmem_tag_qmem;

assign dwb_clk_i = clk_i;
assign iwb_clk_i = clk_i;
//
// Instantiation of Instruction WISHBONE BIU
//
or1200_wb_biu iwb_biu(
	// RISC clk, rst and clock control
	.clk(clk_i),
	.rst(rst_i),
	.clmode(clmode_i),

	// WISHBONE interface
	.wb_clk_i(iwb_clk_i),
	.wb_rst_i(iwb_rst_i),
	.wb_ack_i(iwb_ack_i),
	.wb_err_i(iwb_err_i),
	.wb_rty_i(iwb_rty_i),
	.wb_dat_i(iwb_dat_i),
	.wb_cyc_o(iwb_cyc_o),
	.wb_adr_o(iwb_adr_o),
	.wb_stb_o(iwb_stb_o),
	.wb_we_o(iwb_we_o),
	.wb_sel_o(iwb_sel_o),
	.wb_dat_o(iwb_dat_o),
`ifdef OR1200_WB_CAB
	.wb_cab_o(iwb_cab_o),
`endif
`ifdef OR1200_WB_B3
	.wb_cti_o(iwb_cti_o),
	.wb_bte_o(iwb_bte_o),
`endif

	// Internal RISC bus
	.biu_dat_i(icbiu_dat_ic),
	.biu_adr_i(icbiu_adr_ic_word),
	.biu_cyc_i(icbiu_cyc_ic),
	.biu_stb_i(icbiu_stb_ic),
	.biu_we_i(icbiu_we_ic),
	.biu_sel_i(icbiu_sel_ic),
	.biu_cab_i(icbiu_cab_ic),
	.biu_dat_o(icbiu_dat_biu),
	.biu_ack_o(icbiu_ack_biu),
	.biu_err_o(icbiu_err_biu)
);
assign icbiu_adr_ic_word = {icbiu_adr_ic[31:2], 2'h0};

//
// Instantiation of Data WISHBONE BIU
//
or1200_wb_biu dwb_biu(
	// RISC clk, rst and clock control
	.clk(clk_i),
	.rst(rst_i),
	.clmode(clmode_i),

	// WISHBONE interface
	.wb_clk_i(dwb_clk_i),
	.wb_rst_i(dwb_rst_i),
	.wb_ack_i(dwb_ack_i),
	.wb_err_i(dwb_err_i),
	.wb_rty_i(dwb_rty_i),
	.wb_dat_i(dwb_dat_i),
	.wb_cyc_o(dwb_cyc_o),
	.wb_adr_o(dwb_adr_o),
	.wb_stb_o(dwb_stb_o),
	.wb_we_o(dwb_we_o),
	.wb_sel_o(dwb_sel_o),
	.wb_dat_o(dwb_dat_o),
`ifdef OR1200_WB_CAB
	.wb_cab_o(dwb_cab_o),
`endif
`ifdef OR1200_WB_B3
	.wb_cti_o(dwb_cti_o),
	.wb_bte_o(dwb_bte_o),
`endif

	// Internal RISC bus
	.biu_dat_i(sbbiu_dat_sb),
	.biu_adr_i(sbbiu_adr_sb),
	.biu_cyc_i(sbbiu_cyc_sb),
	.biu_stb_i(sbbiu_stb_sb),
	.biu_we_i(sbbiu_we_sb),
	.biu_sel_i(sbbiu_sel_sb),
	.biu_cab_i(sbbiu_cab_sb),
	.biu_dat_o(sbbiu_dat_biu),
	.biu_ack_o(sbbiu_ack_biu),
	.biu_err_o(sbbiu_err_biu)
);

//
// Instantiation of IMMU
//
or1200_immu_top or1200_immu_top(
	// Rst and clk
	.clk(clk_i),
	.rst(rst_i),

`ifdef OR1200_BIST
	// RAM BIST
	.mbist_si_i(mbist_immu_si),
	.mbist_so_o(mbist_immu_so),
	.mbist_ctrl_i(mbist_ctrl_i),
`endif

	// CPU and IMMU
	.ic_en(ic_en),
	.immu_en(immu_en),
	.supv(supv),
	.icpu_adr_i(icpu_adr_cpu),
	.icpu_cycstb_i(icpu_cycstb_cpu),
	.icpu_adr_o(icpu_adr_immu),
	.icpu_tag_o(icpu_tag_immu),
	.icpu_rty_o(icpu_rty_immu),
	.icpu_err_o(icpu_err_immu),

	// SR Interface
	.boot_adr_sel_i(boot_adr_sel),

	// SPR access
	.spr_cs(spr_cs[`OR1200_SPR_GROUP_IMMU]),
	.spr_write(spr_we),
	.spr_addr(spr_addr),
	.spr_dat_i(spr_dat_cpu),
	.spr_dat_o(spr_dat_immu),

	// QMEM and IMMU
	.qmemimmu_rty_i(qmemimmu_rty_qmem),
	.qmemimmu_err_i(qmemimmu_err_qmem),
	.qmemimmu_tag_i(qmemimmu_tag_qmem),
	.qmemimmu_adr_o(qmemimmu_adr_immu),
	.qmemimmu_cycstb_o(qmemimmu_cycstb_immu),
	.qmemimmu_ci_o(qmemimmu_ci_immu)
);

//
// Instantiation of Instruction Cache
//
or1200_ic_top or1200_ic_top(
	.clk(clk_i),
	.rst(rst_i),

`ifdef OR1200_BIST
	// RAM BIST
	.mbist_si_i(mbist_ic_si),
	.mbist_so_o(mbist_ic_so),
	.mbist_ctrl_i(mbist_ctrl_i),
`endif

	// IC and QMEM
	.ic_en(ic_en),
	.icqmem_adr_i(icqmem_adr_qmem),
	.icqmem_cycstb_i(icqmem_cycstb_qmem),
	.icqmem_ci_i(icqmem_ci_qmem),
	.icqmem_sel_i(icqmem_sel_qmem),
	.icqmem_tag_i(icqmem_tag_qmem),
	.icqmem_dat_o(icqmem_dat_ic),
	.icqmem_ack_o(icqmem_ack_ic),
	.icqmem_rty_o(icqmem_rty_ic),
	.icqmem_err_o(icqmem_err_ic),
	.icqmem_tag_o(icqmem_tag_ic),

	// SPR access
	.spr_cs(spr_cs[`OR1200_SPR_GROUP_IC]),
	.spr_write(spr_we),
	.spr_dat_i(spr_dat_cpu),

	// IC and BIU
	.icbiu_dat_o(icbiu_dat_ic),
	.icbiu_adr_o(icbiu_adr_ic),
	.icbiu_cyc_o(icbiu_cyc_ic),
	.icbiu_stb_o(icbiu_stb_ic),
	.icbiu_we_o(icbiu_we_ic),
	.icbiu_sel_o(icbiu_sel_ic),
	.icbiu_cab_o(icbiu_cab_ic),
	.icbiu_dat_i(icbiu_dat_biu),
	.icbiu_ack_i(icbiu_ack_biu),
	.icbiu_err_i(icbiu_err_biu)
);

//
// Instantiation of Instruction Cache
//
or1200_cpu or1200_cpu(
	.clk(clk_i),
	.rst(rst_i),

	// Connection QMEM and IFETCHER inside CPU
	.ic_en(ic_en),
	.icpu_adr_o(icpu_adr_cpu),
	.icpu_cycstb_o(icpu_cycstb_cpu),
	.icpu_sel_o(icpu_sel_cpu),
	.icpu_tag_o(icpu_tag_cpu),
	.icpu_dat_i(icpu_dat_qmem),
	.icpu_ack_i(icpu_ack_qmem),
	.icpu_rty_i(icpu_rty_immu),
	.icpu_adr_i(icpu_adr_immu),
	.icpu_err_i(icpu_err_immu),
	.icpu_tag_i(icpu_tag_immu),

	// Connection CPU to external Debug port
	.id_void(id_void),
	.id_insn(id_insn),
	.ex_void(ex_void),
	.ex_insn(ex_insn),
	.ex_freeze(ex_freeze),
	.wb_insn(wb_insn),
	.wb_freeze(wb_freeze),
	.id_pc(id_pc),
	.ex_pc(ex_pc),
	.wb_pc(wb_pc),
	.branch_op(branch_op),
	.rf_dataw(rf_dataw),
	.ex_flushpipe(flushpipe),
	.du_stall(du_stall),
	.du_addr(du_addr),
	.du_dat_du(du_dat_du),
	.du_read(du_read),
	.du_write(du_write),
	.du_except_trig(du_except_trig),
	.du_except_stop(du_except_stop),
	.du_dsr(du_dsr),
	.du_dmr1(du_dmr1),
	.du_hwbkpt(du_hwbkpt),
	.du_hwbkpt_ls_r(du_hwbkpt_ls_r),
	.du_dat_cpu(du_dat_cpu),
	.du_lsu_store_dat(du_lsu_store_dat),
	.du_lsu_load_dat(du_lsu_load_dat),
	.abort_mvspr(abort_mvspr),
	.abort_ex(abort_ex),

	// Connection IMMU and CPU internally
	.immu_en(immu_en),

	// Connection QMEM and CPU
	.dc_en(dc_en),
	.dcpu_adr_o(dcpu_adr_cpu),
	.dcpu_cycstb_o(dcpu_cycstb_cpu),
	.dcpu_we_o(dcpu_we_cpu),
	.dcpu_sel_o(dcpu_sel_cpu),
	.dcpu_tag_o(dcpu_tag_cpu),
	.dcpu_dat_o(dcpu_dat_cpu),
        .dcpu_dat_i(dcpu_dat_qmem),
	.dcpu_ack_i(dcpu_ack_qmem),
	.dcpu_rty_i(dcpu_rty_qmem),
	.dcpu_err_i(dcpu_err_dmmu),
	.dcpu_tag_i(dcpu_tag_dmmu),
	.dc_no_writethrough(dc_no_writethrough),

	// Connection DMMU and CPU internally
	.dmmu_en(dmmu_en),

	// SR Interface
	.boot_adr_sel_i(boot_adr_sel),

	// SB Enable
	.sb_en(sb_en),

	// Connection PIC and CPU's EXCEPT
	.sig_int(sig_int),
	.sig_tick(sig_tick),

	// SPRs
	.supv(supv),
	.spr_addr(spr_addr),
	.spr_dat_cpu(spr_dat_cpu),
	.spr_dat_pic(spr_dat_pic),
	.spr_dat_tt(spr_dat_tt),
	.spr_dat_pm(spr_dat_pm),
	.spr_dat_dmmu(spr_dat_dmmu),
	.spr_dat_immu(spr_dat_immu),
	.spr_dat_du(spr_dat_du),
	.spr_dat_npc(spr_dat_npc),
	.spr_cs(spr_cs),
	.spr_we(spr_we),
        .mtspr_dc_done(mtspr_dc_done)
);

//
// Instantiation of DMMU
//
or1200_dmmu_top or1200_dmmu_top(
	// Rst and clk
	.clk(clk_i),
	.rst(rst_i),

`ifdef OR1200_BIST
	// RAM BIST
	.mbist_si_i(mbist_dmmu_si),
	.mbist_so_o(mbist_dmmu_so),
	.mbist_ctrl_i(mbist_ctrl_i),
`endif

	// CPU i/f
	.dc_en(dc_en),
	.dmmu_en(dmmu_en),
	.supv(supv),
	.dcpu_adr_i(dcpu_adr_cpu),
	.dcpu_cycstb_i(dcpu_cycstb_cpu),
	.dcpu_we_i(dcpu_we_cpu),
	.dcpu_tag_o(dcpu_tag_dmmu),
	.dcpu_err_o(dcpu_err_dmmu),

	// SPR access
	.spr_cs(spr_cs[`OR1200_SPR_GROUP_DMMU]),
	.spr_write(spr_we),
	.spr_addr(spr_addr),
	.spr_dat_i(spr_dat_cpu),
	.spr_dat_o(spr_dat_dmmu),

	// QMEM and DMMU
	.qmemdmmu_err_i(qmemdmmu_err_qmem),
	.qmemdmmu_tag_i(qmemdmmu_tag_qmem),
	.qmemdmmu_adr_o(qmemdmmu_adr_dmmu),
	.qmemdmmu_cycstb_o(qmemdmmu_cycstb_dmmu),
	.qmemdmmu_ci_o(qmemdmmu_ci_dmmu)
);

//
// Instantiation of Data Cache
//
or1200_dc_top or1200_dc_top(
	.clk(clk_i),
	.rst(rst_i),

`ifdef OR1200_BIST
	// RAM BIST
	.mbist_si_i(mbist_dc_si),
	.mbist_so_o(mbist_dc_so),
	.mbist_ctrl_i(mbist_ctrl_i),
`endif

	// DC and QMEM
	.dc_en(dc_en),
	.dcqmem_adr_i(dcqmem_adr_qmem),
	.dcqmem_cycstb_i(dcqmem_cycstb_qmem),
	.dcqmem_ci_i(dcqmem_ci_qmem),
	.dcqmem_we_i(dcqmem_we_qmem),
	.dcqmem_sel_i(dcqmem_sel_qmem),
	.dcqmem_tag_i(dcqmem_tag_qmem),
	.dcqmem_dat_i(dcqmem_dat_qmem),
	.dcqmem_dat_o(dcqmem_dat_dc),
	.dcqmem_ack_o(dcqmem_ack_dc),
	.dcqmem_rty_o(dcqmem_rty_dc),
	.dcqmem_err_o(dcqmem_err_dc),
	.dcqmem_tag_o(dcqmem_tag_dc),

	.dc_no_writethrough(dc_no_writethrough),

	// SPR access
	.spr_cs(spr_cs[`OR1200_SPR_GROUP_DC]),
	.spr_addr(spr_addr),
	.spr_write(spr_we),
	.spr_dat_i(spr_dat_cpu),
        .mtspr_dc_done(mtspr_dc_done),

	// DC and BIU
	.dcsb_dat_o(dcsb_dat_dc),
	.dcsb_adr_o(dcsb_adr_dc),
	.dcsb_cyc_o(dcsb_cyc_dc),
	.dcsb_stb_o(dcsb_stb_dc),
	.dcsb_we_o(dcsb_we_dc),
	.dcsb_sel_o(dcsb_sel_dc),
	.dcsb_cab_o(dcsb_cab_dc),
	.dcsb_dat_i(dcsb_dat_sb),
	.dcsb_ack_i(dcsb_ack_sb),
	.dcsb_err_i(dcsb_err_sb)
);

//
// Instantiation of embedded memory - qmem
//
or1200_qmem_top or1200_qmem_top(
	.clk(clk_i),
	.rst(rst_i),

`ifdef OR1200_BIST
	// RAM BIST
	.mbist_si_i(mbist_qmem_si),
	.mbist_so_o(mbist_qmem_so),
	.mbist_ctrl_i(mbist_ctrl_i),
`endif

	// QMEM and CPU/IMMU
	.qmemimmu_adr_i(qmemimmu_adr_immu),
	.qmemimmu_cycstb_i(qmemimmu_cycstb_immu),
	.qmemimmu_ci_i(qmemimmu_ci_immu),
	.qmemicpu_sel_i(icpu_sel_cpu),
	.qmemicpu_tag_i(icpu_tag_cpu),
	.qmemicpu_dat_o(icpu_dat_qmem),
	.qmemicpu_ack_o(icpu_ack_qmem),
	.qmemimmu_rty_o(qmemimmu_rty_qmem),
	.qmemimmu_err_o(qmemimmu_err_qmem),
	.qmemimmu_tag_o(qmemimmu_tag_qmem),

	// QMEM and IC
	.icqmem_adr_o(icqmem_adr_qmem),
	.icqmem_cycstb_o(icqmem_cycstb_qmem),
	.icqmem_ci_o(icqmem_ci_qmem),
	.icqmem_sel_o(icqmem_sel_qmem),
	.icqmem_tag_o(icqmem_tag_qmem),
	.icqmem_dat_i(icqmem_dat_ic),
	.icqmem_ack_i(icqmem_ack_ic),
	.icqmem_rty_i(icqmem_rty_ic),
	.icqmem_err_i(icqmem_err_ic),
	.icqmem_tag_i(icqmem_tag_ic),

	// QMEM and CPU/DMMU
	.qmemdmmu_adr_i(qmemdmmu_adr_dmmu),
	.qmemdmmu_cycstb_i(qmemdmmu_cycstb_dmmu),
	.qmemdmmu_ci_i(qmemdmmu_ci_dmmu),
	.qmemdcpu_we_i(dcpu_we_cpu),
	.qmemdcpu_sel_i(dcpu_sel_cpu),
	.qmemdcpu_tag_i(dcpu_tag_cpu),
	.qmemdcpu_dat_i(dcpu_dat_cpu),
	.qmemdcpu_dat_o(dcpu_dat_qmem),
	.qmemdcpu_ack_o(dcpu_ack_qmem),
	.qmemdcpu_rty_o(dcpu_rty_qmem),
	.qmemdmmu_err_o(qmemdmmu_err_qmem),
	.qmemdmmu_tag_o(qmemdmmu_tag_qmem),

	// QMEM and DC
	.dcqmem_adr_o(dcqmem_adr_qmem),
	.dcqmem_cycstb_o(dcqmem_cycstb_qmem),
	.dcqmem_ci_o(dcqmem_ci_qmem),
	.dcqmem_we_o(dcqmem_we_qmem),
	.dcqmem_sel_o(dcqmem_sel_qmem),
	.dcqmem_tag_o(dcqmem_tag_qmem),
	.dcqmem_dat_o(dcqmem_dat_qmem),
	.dcqmem_dat_i(dcqmem_dat_dc),
	.dcqmem_ack_i(dcqmem_ack_dc),
	.dcqmem_rty_i(dcqmem_rty_dc),
	.dcqmem_err_i(dcqmem_err_dc),
	.dcqmem_tag_i(dcqmem_tag_dc)
);

//
// Instantiation of Store Buffer
//
or1200_sb or1200_sb(
	// RISC clock, reset
	.clk(clk_i),
	.rst(rst_i),

	// Internal RISC bus (SB)
	.sb_en(sb_en),

	// Internal RISC bus (DC<->SB)
	.dcsb_dat_i(dcsb_dat_dc),
	.dcsb_adr_i(dcsb_adr_dc),
	.dcsb_cyc_i(dcsb_cyc_dc),
	.dcsb_stb_i(dcsb_stb_dc),
	.dcsb_we_i(dcsb_we_dc),
	.dcsb_sel_i(dcsb_sel_dc),
	.dcsb_cab_i(dcsb_cab_dc),
	.dcsb_dat_o(dcsb_dat_sb),
	.dcsb_ack_o(dcsb_ack_sb),
	.dcsb_err_o(dcsb_err_sb),

	// SB and BIU
	.sbbiu_dat_o(sbbiu_dat_sb),
	.sbbiu_adr_o(sbbiu_adr_sb),
	.sbbiu_cyc_o(sbbiu_cyc_sb),
	.sbbiu_stb_o(sbbiu_stb_sb),
	.sbbiu_we_o(sbbiu_we_sb),
	.sbbiu_sel_o(sbbiu_sel_sb),
	.sbbiu_cab_o(sbbiu_cab_sb),
	.sbbiu_dat_i(sbbiu_dat_biu),
	.sbbiu_ack_i(sbbiu_ack_biu),
	.sbbiu_err_i(sbbiu_err_biu)
);

//
// Instantiation of Debug Unit
//
or1200_du or1200_du(
	// RISC Internal Interface
	.clk(clk_i),
	.rst(rst_i),
	.dcpu_cycstb_i(dcpu_cycstb_cpu),
	.dcpu_we_i(dcpu_we_cpu),
	.dcpu_adr_i(dcpu_adr_cpu),
	.dcpu_dat_lsu(dcpu_dat_cpu),
	.dcpu_dat_dc(dcpu_dat_qmem),
	.icpu_cycstb_i(icpu_cycstb_cpu),
	.ex_freeze(ex_freeze),
	.branch_op(branch_op),
	.ex_insn(ex_insn),
	.id_pc(id_pc),
	.du_dsr(du_dsr),
	.du_dmr1(du_dmr1),

	// For Trace buffer
	.spr_dat_npc(spr_dat_npc),
	.rf_dataw(rf_dataw),

	// DU's access to SPR unit
	.du_stall(du_stall),
	.du_addr(du_addr),
	.du_dat_i(du_dat_cpu),
	.du_dat_o(du_dat_du),
	.du_read(du_read),
	.du_write(du_write),
	.du_except_stop(du_except_stop),
	.du_hwbkpt(du_hwbkpt),

	// Access to DU's SPRs
	.spr_cs(spr_cs[`OR1200_SPR_GROUP_DU]),
	.spr_write(spr_we),
	.spr_addr(spr_addr),
	.spr_dat_i(spr_dat_cpu),
	.spr_dat_o(spr_dat_du),

	// External Debug Interface
	.dbg_stall_i(dbg_stall_i),
	.dbg_ewt_i(dbg_ewt_i),
	.dbg_lss_o(dbg_lss_o),
	.dbg_is_o(dbg_is_o),
	.dbg_wp_o(dbg_wp_o),
	.dbg_bp_o(dbg_bp_o),
	.dbg_stb_i(dbg_stb_i),
	.dbg_we_i(dbg_we_i),
	.dbg_adr_i(dbg_adr_i),
	.dbg_dat_i(dbg_dat_i),
	.dbg_dat_o(dbg_dat_o),
	.dbg_ack_o(dbg_ack_o)
);

//
// Programmable interrupt controller
//
or1200_pic or1200_pic(
	// RISC Internal Interface
	.clk(clk_i),
	.rst(rst_i),
	.spr_cs(spr_cs[`OR1200_SPR_GROUP_PIC]),
	.spr_write(spr_we),
	.spr_addr(spr_addr),
	.spr_dat_i(spr_dat_cpu),
	.spr_dat_o(spr_dat_pic),
	.pic_wakeup(pic_wakeup),
	.intr(sig_int), 

	// PIC Interface
	.pic_int(pic_ints_i)
);

//
// Instantiation of Tick timer
//
or1200_tt or1200_tt(
	// RISC Internal Interface
	.clk(clk_i),
	.rst(rst_i),
	.du_stall(du_stall),
	.spr_cs(spr_cs[`OR1200_SPR_GROUP_TT]),
	.spr_write(spr_we),
	.spr_addr(spr_addr),
	.spr_dat_i(spr_dat_cpu),
	.spr_dat_o(spr_dat_tt),
	.intr(sig_tick)
);

//
// Instantiation of Power Management
//
or1200_pm or1200_pm(
	// RISC Internal Interface
	.clk(clk_i),
	.rst(rst_i),
	.pic_wakeup(pic_wakeup),
	.spr_write(spr_we),
	.spr_addr(spr_addr),
	.spr_dat_i(spr_dat_cpu),
	.spr_dat_o(spr_dat_pm),

	// Power Management Interface
	.pm_cpustall(pm_cpustall_i),
	.pm_clksd(pm_clksd_o),
	.pm_dc_gate(pm_dc_gate_o),
	.pm_ic_gate(pm_ic_gate_o),
	.pm_dmmu_gate(pm_dmmu_gate_o),
	.pm_immu_gate(pm_immu_gate_o),
	.pm_tt_gate(pm_tt_gate_o),
	.pm_cpu_gate(pm_cpu_gate_o),
	.pm_wakeup(pm_wakeup_o),
	.pm_lvolt(pm_lvolt_o)
);


endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Tick Timer                                         ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/cores/or1k/                        ////
////                                                              ////
////  Description                                                 ////
////  TT according to OR1K architectural specification.           ////
////                                                              ////
////  To Do:                                                      ////
////   None                                                       ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
// CVS Revision History
//
// $Log: or1200_tt.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 
//
// Revision 1.5  2004/06/08 18:17:36  lampret
// Non-functional changes. Coding style fixes.
//
// Revision 1.4  2002/03/29 15:16:56  lampret
// Some of the warnings fixed.
//
// Revision 1.3  2002/02/12 01:33:47  lampret
// No longer using async rst as sync reset for the counter.
//
// Revision 1.2  2002/01/28 01:16:00  lampret
// Changed 'void' nop-ops instead of insn[0] to use insn[16]. Debug unit stalls the tick timer. Prepared new flag generation for add and and insns. Blocked DC/IC while they are turned off. Fixed I/D MMU SPRs layout except WAYs. TODO: smart IC invalidate, l.j 2 and TLB ways.
//
// Revision 1.1  2002/01/03 08:16:15  lampret
// New prefixes for RTL files, prefixed module names. Updated cache controllers and MMUs.
//
// Revision 1.10  2001/11/13 10:00:49  lampret
// Fixed tick timer interrupt reporting by using TTCR[IP] bit.
//
// Revision 1.9  2001/11/10 03:43:57  lampret
// Fixed exceptions.
//
// Revision 1.8  2001/10/21 17:57:16  lampret
// Removed params from generic_XX.v. Added translate_off/on in sprs.v and id.v. Removed spr_addr from dc.v and ic.v. Fixed CR+LF.
//
// Revision 1.7  2001/10/14 13:12:10  lampret
// MP3 version.
//
// Revision 1.1.1.1  2001/10/06 10:18:35  igorm
// no message
//
// Revision 1.2  2001/08/09 13:39:33  lampret
// Major clean-up.
//
// Revision 1.1  2001/07/20 00:46:23  lampret
// Development version of RTL. Libraries are missing.
//
//

// synopsys translate_off
// synopsys translate_on

module or1200_tt(
	// RISC Internal Interface
	clk, rst, du_stall,
	spr_cs, spr_write, spr_addr, spr_dat_i, spr_dat_o,
	intr
);

//
// RISC Internal Interface
//
input		clk;		// Clock
input		rst;		// Reset
input		du_stall;	// DU stall
input		spr_cs;		// SPR CS
input		spr_write;	// SPR Write
input	[31:0]	spr_addr;	// SPR Address
input	[31:0]	spr_dat_i;	// SPR Write Data
output	[31:0]	spr_dat_o;	// SPR Read Data
output		intr;		// Interrupt output

`ifdef OR1200_TT_IMPLEMENTED

//
// TT Mode Register bits (or no register)
//
`ifdef OR1200_TT_TTMR
reg	[31:0]	ttmr;	// TTMR bits
`else
wire	[31:0]	ttmr;	// No TTMR register
`endif

//
// TT Count Register bits (or no register)
//
`ifdef OR1200_TT_TTCR
reg	[31:0]	ttcr;	// TTCR bits
`else
wire	[31:0]	ttcr;	// No TTCR register
`endif

//
// Internal wires & regs
//
wire		ttmr_sel;	// TTMR select
wire		ttcr_sel;	// TTCR select
wire		match;		// Asserted when TTMR[TP]
				// is equal to TTCR[27:0]
wire		restart;	// Restart counter when asserted
wire		stop;		// Stop counter when asserted
reg	[31:0] 	spr_dat_o;	// SPR data out

//
// TT registers address decoder
//
assign ttmr_sel = (spr_cs && (spr_addr[`OR1200_TTOFS_BITS] == `OR1200_TT_OFS_TTMR)) ? 1'b1 : 1'b0;
assign ttcr_sel = (spr_cs && (spr_addr[`OR1200_TTOFS_BITS] == `OR1200_TT_OFS_TTCR)) ? 1'b1 : 1'b0;

//
// Write to TTMR or update of TTMR[IP] bit
//
`ifdef OR1200_TT_TTMR
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		ttmr <= 32'b0;
	else if (ttmr_sel && spr_write)
		ttmr <=  spr_dat_i;
	else if (ttmr[`OR1200_TT_TTMR_IE])
		ttmr[`OR1200_TT_TTMR_IP] <=  ttmr[`OR1200_TT_TTMR_IP] | (match & ttmr[`OR1200_TT_TTMR_IE]);
`else
assign ttmr = {2'b11, 30'b0};	// TTMR[M] = 0x3
`endif

//
// Write to or increment of TTCR
//
`ifdef OR1200_TT_TTCR
always @(posedge clk )
	if (rst == `OR1200_RST_VALUE)
		ttcr <= 32'b0;
	else if (restart)
		ttcr <=  32'b0;
	else if (ttcr_sel && spr_write)
		ttcr <=  spr_dat_i;
	else if (!stop)
		ttcr <=  ttcr + 32'd1;
`else
assign ttcr = 32'b0;
`endif

//
// Read TT registers
//
always @(spr_addr or ttmr or ttcr)
	case (spr_addr[`OR1200_TTOFS_BITS])	// synopsys parallel_case
`ifdef OR1200_TT_READREGS
		`OR1200_TT_OFS_TTMR: spr_dat_o = ttmr;
`endif
		default: spr_dat_o = ttcr;
	endcase

//
// A match when TTMR[TP] is equal to TTCR[27:0]
//
assign match = (ttmr[`OR1200_TT_TTMR_TP] == ttcr[27:0]) ? 1'b1 : 1'b0;

//
// Restart when match and TTMR[M]==0x1
//
assign restart = match && (ttmr[`OR1200_TT_TTMR_M] == 2'b01);

//
// Stop when match and TTMR[M]==0x2 or when TTMR[M]==0x0 or when RISC is stalled by debug unit
//
assign stop = match & (ttmr[`OR1200_TT_TTMR_M] == 2'b10) | (ttmr[`OR1200_TT_TTMR_M] == 2'b00) | du_stall;

//
// Generate an interrupt request
//
assign intr = ttmr[`OR1200_TT_TTMR_IP];

`else

//
// When TT is not implemented, drive all outputs as would when TT is disabled
//
assign intr = 1'b0;

//
// Read TT registers
//
`ifdef OR1200_TT_READREGS
assign spr_dat_o = 32'b0;
`endif

`endif

endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's WISHBONE BIU                                       ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://opencores.org/project,or1k                           ////
////                                                              ////
////  Description                                                 ////
////  Implements WISHBONE interface                               ////
////                                                              ////
////  To Do:                                                      ////
////   - if biu_cyc/stb are deasserted and wb_ack_i is asserted   ////
////   and this happens even before aborted_r is asssrted,        ////
////   wb_ack_i will be delivered even though transfer is         ////
////   internally considered already aborted. However most        ////
////   wb_ack_i are externally registered and delayed. Normally   ////
////   this shouldn't cause any problems.                         ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//
// $Log: or1200_wb_biu.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// Major update: 
// Structure reordered and bugs fixed. 
//

// synopsys translate_off
// synopsys translate_on

module or1200_wb_biu(
		     // RISC clock, reset and clock control
		     clk, rst, clmode,

		     // WISHBONE interface
		     wb_clk_i, wb_rst_i, wb_ack_i, wb_err_i, wb_rty_i, wb_dat_i,
		     wb_cyc_o, wb_adr_o, wb_stb_o, wb_we_o, wb_sel_o, wb_dat_o,
`ifdef OR1200_WB_CAB
		     wb_cab_o,
`endif
`ifdef OR1200_WB_B3
		     wb_cti_o, wb_bte_o,
`endif

		     // Internal RISC bus
		     biu_dat_i, biu_adr_i, biu_cyc_i, biu_stb_i, biu_we_i, biu_sel_i, biu_cab_i,
		     biu_dat_o, biu_ack_o, biu_err_o
		     );

   parameter dw = `OR1200_OPERAND_WIDTH;
   parameter aw = `OR1200_OPERAND_WIDTH;

   //
   // RISC clock, reset and clock control
   //
   input				clk;		// RISC clock
   input				rst;		// RISC reset
   input [1:0] 				clmode;		// 00 WB=RISC, 01 WB=RISC/2, 10 N/A, 11 WB=RISC/4

   //
   // WISHBONE interface
   //
   input				wb_clk_i;	// clock input
   input				wb_rst_i;	// reset input
   input				wb_ack_i;	// normal termination
   input				wb_err_i;	// termination w/ error
   input				wb_rty_i;	// termination w/ retry
   input [dw-1:0] 			wb_dat_i;	// input data bus
   output				wb_cyc_o;	// cycle valid output
   output [aw-1:0] 			wb_adr_o;	// address bus outputs
   output				wb_stb_o;	// strobe output
   output				wb_we_o;	// indicates write transfer
   output [3:0] 			wb_sel_o;	// byte select outputs
   output [dw-1:0] 			wb_dat_o;	// output data bus
`ifdef OR1200_WB_CAB
   output				wb_cab_o;	// consecutive address burst
`endif
`ifdef OR1200_WB_B3
   output [2:0] 			wb_cti_o;	// cycle type identifier
   output [1:0] 			wb_bte_o;	// burst type extension
`endif

   //
   // Internal RISC interface
   //
   input [dw-1:0] 			biu_dat_i;	// input data bus
   input [aw-1:0] 			biu_adr_i;	// address bus
   input				biu_cyc_i;	// WB cycle
   input				biu_stb_i;	// WB strobe
   input				biu_we_i;	// WB write enable
   input				biu_cab_i;	// CAB input
   input [3:0] 				biu_sel_i;	// byte selects
   output [31:0] 			biu_dat_o;	// output data bus
   output				biu_ack_o;	// ack output
   output				biu_err_o;	// err output

   //
   // Registers
   //
   wire 				wb_ack;		// normal termination
   reg [aw-1:0] 			wb_adr_o;	// address bus outputs
   reg 					wb_cyc_o;	// cycle output
   reg 					wb_stb_o;	// strobe output
   reg 					wb_we_o;	// indicates write transfer
   reg [3:0] 				wb_sel_o;	// byte select outputs
`ifdef OR1200_WB_CAB
   reg 					wb_cab_o;	// CAB output
`endif
`ifdef OR1200_WB_B3
   reg [2:0] 				wb_cti_o;	// cycle type identifier
   reg [1:0] 				wb_bte_o;	// burst type extension
`endif
`ifdef OR1200_NO_DC   
   reg [dw-1:0] 			wb_dat_o;	// output data bus
`else   
   assign wb_dat_o = biu_dat_i;    // No register on this - straight from DCRAM
`endif
   
`ifdef OR1200_WB_RETRY
   reg [`OR1200_WB_RETRY-1:0] 		retry_cnt;	// Retry counter
`else
   wire 				retry_cnt;
   assign retry_cnt = 1'b0;
`endif
`ifdef OR1200_WB_B3
   reg [1:0] 				burst_len;	// burst counter
`endif

   reg  				biu_stb_reg;	// WB strobe
   wire  				biu_stb;	// WB strobe
   reg 					wb_cyc_nxt;	// next WB cycle value
   reg 					wb_stb_nxt;	// next WB strobe value
   reg [2:0] 				wb_cti_nxt;	// next cycle type identifier value

   reg 					wb_ack_cnt;	// WB ack toggle counter
   reg 					wb_err_cnt;	// WB err toggle counter
   reg 					wb_rty_cnt;	// WB rty toggle counter
   reg 					biu_ack_cnt;	// BIU ack toggle counter
   reg 					biu_err_cnt;	// BIU err toggle counter
   reg 					biu_rty_cnt;	// BIU rty toggle counter
   wire 				biu_rty;	// BIU rty indicator

   reg [1:0] 				wb_fsm_state_cur;	// WB FSM - surrent state
   reg [1:0] 				wb_fsm_state_nxt;	// WB FSM - next state
   wire [1:0] 				wb_fsm_idle	= 2'h0;	// WB FSM state - IDLE
   wire [1:0] 				wb_fsm_trans	= 2'h1;	// WB FSM state - normal TRANSFER
   wire [1:0] 				wb_fsm_last	= 2'h2;	// EB FSM state - LAST transfer

   //
   // WISHBONE I/F <-> Internal RISC I/F conversion
   //
   //assign wb_ack = wb_ack_i;
   assign wb_ack = wb_ack_i & !wb_err_i & !wb_rty_i;

   //
   // WB FSM - register part
   // 
   always @(posedge wb_clk_i ) begin
      if (wb_rst_i == `OR1200_RST_VALUE) 
	wb_fsm_state_cur <=  wb_fsm_idle;
      else 
	wb_fsm_state_cur <=  wb_fsm_state_nxt;
   end

   //
   // WB burst tength counter
   // 
   always @(posedge wb_clk_i ) begin
      if (wb_rst_i == `OR1200_RST_VALUE) begin
	 burst_len <=  2'h0;
      end
      else begin
	 // burst counter
	 if (wb_fsm_state_cur == wb_fsm_idle)
	   burst_len <=  2'h2;
	 else if (wb_stb_o & wb_ack)
	   burst_len <=  burst_len - 1'b1;
      end
   end

   // 
   // WB FSM - combinatorial part
   // 
   always @(wb_fsm_state_cur or burst_len or wb_err_i or wb_rty_i or wb_ack or 
	    wb_cti_o or wb_sel_o or wb_stb_o or wb_we_o or biu_cyc_i or 
	    biu_stb or biu_cab_i or biu_sel_i or biu_we_i) begin
      // States of WISHBONE Finite State Machine
      case(wb_fsm_state_cur)
	// IDLE 
	wb_fsm_idle : begin
	   wb_cyc_nxt = biu_cyc_i & biu_stb;
	   wb_stb_nxt = biu_cyc_i & biu_stb;
	   wb_cti_nxt = {!biu_cab_i, 1'b1, !biu_cab_i};
	   if (biu_cyc_i & biu_stb)
	     wb_fsm_state_nxt = wb_fsm_trans;
	   else
	     wb_fsm_state_nxt = wb_fsm_idle;
	end
	// normal TRANSFER
	wb_fsm_trans : begin
	   wb_cyc_nxt = !wb_stb_o | !wb_err_i & !wb_rty_i & 
			!(wb_ack & wb_cti_o == 3'b111);
	   
	   wb_stb_nxt = !wb_stb_o | !wb_err_i & !wb_rty_i & !wb_ack | 
			!wb_err_i & !wb_rty_i & wb_cti_o == 3'b010 /*& !wb_we_o -- Removed to add burst write, JPB*/;
	   
	   wb_cti_nxt[2] = wb_stb_o & wb_ack & burst_len == 'h0 | wb_cti_o[2];
	   wb_cti_nxt[1] = 1'b1  ;
	   wb_cti_nxt[0] = wb_stb_o & wb_ack & burst_len == 'h0 | wb_cti_o[0];
	   
	   //if ((!biu_cyc_i | !biu_stb | !biu_cab_i) & wb_cti_o == 3'b010  | 
	   //     biu_sel_i != wb_sel_o | biu_we_i != wb_we_o)
	   
	   if ((!biu_cyc_i | !biu_stb | !biu_cab_i | biu_sel_i != wb_sel_o | 
		biu_we_i != wb_we_o) & wb_cti_o == 3'b010)
	     wb_fsm_state_nxt = wb_fsm_last;
	   else if ((wb_err_i | wb_rty_i | wb_ack & wb_cti_o==3'b111) & 
		    wb_stb_o)
	     wb_fsm_state_nxt = wb_fsm_idle;
	   else
	     wb_fsm_state_nxt = wb_fsm_trans;
	end
	// LAST transfer
	wb_fsm_last : begin
	   wb_cyc_nxt = !wb_stb_o | !wb_err_i & !wb_rty_i & 
			!(wb_ack & wb_cti_o == 3'b111);
	   wb_stb_nxt = !wb_stb_o | !wb_err_i & !wb_rty_i & 
			!(wb_ack & wb_cti_o == 3'b111);
	   wb_cti_nxt[2] = wb_ack & wb_stb_o | wb_cti_o[2];
	   wb_cti_nxt[1] = 1'b1                  ;
	   wb_cti_nxt[0] = wb_ack & wb_stb_o | wb_cti_o[0];
	   if ((wb_err_i | wb_rty_i | wb_ack & wb_cti_o == 3'b111) & wb_stb_o)
	     wb_fsm_state_nxt = wb_fsm_idle;
	   else
	     wb_fsm_state_nxt = wb_fsm_last;
	end
	// default state
	default:begin
	   wb_cyc_nxt = 1'bx;
	   wb_stb_nxt = 1'bx;
	   wb_cti_nxt = 3'bxxx;
	   wb_fsm_state_nxt = 2'bxx;
	end
      endcase
   end

   //
   // WB FSM - output signals
   // 
   always @(posedge wb_clk_i ) begin
      if (wb_rst_i == `OR1200_RST_VALUE) begin
	 wb_cyc_o	<=  1'b0;
	 wb_stb_o	<=  1'b0;
	 wb_cti_o	<=  3'b111;
	 wb_bte_o	<=  2'b01;	// 4-beat wrap burst = constant
`ifdef OR1200_WB_CAB
	 wb_cab_o	<=  1'b0;
`endif
	 wb_we_o		<=  1'b0;
	 wb_sel_o	<=  4'hf;
	 wb_adr_o	<=  {aw{1'b0}};
`ifdef OR1200_NO_DC	 
	 wb_dat_o	<=  {dw{1'b0}};
`endif	 
      end
      else begin
	 wb_cyc_o	<=  wb_cyc_nxt;
	 //		wb_stb_o	<=  wb_stb_nxt;
         if (wb_ack & wb_cti_o == 3'b111) 
           wb_stb_o        <=  1'b0;
         else
           wb_stb_o        <=  wb_stb_nxt;
	 wb_cti_o	<=  wb_cti_nxt;
	 wb_bte_o	<=  2'b01;	// 4-beat wrap burst = constant
`ifdef OR1200_WB_CAB
	 wb_cab_o	<=  biu_cab_i;
`endif
	 // we and sel - set at beginning of access 
	 if (wb_fsm_state_cur == wb_fsm_idle) begin
	    wb_we_o		<=  biu_we_i;
	    wb_sel_o	<=  biu_sel_i;
	 end
	 // adr - set at beginning of access and changed at every termination 
	 if (wb_fsm_state_cur == wb_fsm_idle) begin
	    wb_adr_o	<=  biu_adr_i;
	 end 
	 else if (wb_stb_o & wb_ack) begin
	    wb_adr_o[3:2]	<=  wb_adr_o[3:2] + 1'b1;
	 end
`ifdef OR1200_NO_DC	 
	 // dat - write data changed after avery subsequent write access
	 if (!wb_stb_o) begin
	    wb_dat_o 	<=  biu_dat_i;
	 end
`endif	 
      end
   end

   //
   // WB & BIU termination toggle counters
   // 
   always @(posedge wb_clk_i ) begin
      if (wb_rst_i == `OR1200_RST_VALUE) begin
	 wb_ack_cnt	<=  1'b0;
	 wb_err_cnt	<=  1'b0;
	 wb_rty_cnt	<=  1'b0;
      end
      else begin
	 // WB ack toggle counter
	 if (wb_fsm_state_cur == wb_fsm_idle | !(|clmode))
	   wb_ack_cnt	<=  1'b0;
	 else if (wb_stb_o & wb_ack)
	   wb_ack_cnt	<=  !wb_ack_cnt;
	 // WB err toggle counter
	 if (wb_fsm_state_cur == wb_fsm_idle | !(|clmode))
	   wb_err_cnt	<=  1'b0;
	 else if (wb_stb_o & wb_err_i)
	   wb_err_cnt	<=  !wb_err_cnt;
	 // WB rty toggle counter
	 if (wb_fsm_state_cur == wb_fsm_idle | !(|clmode))
	   wb_rty_cnt	<=  1'b0;
	 else if (wb_stb_o & wb_rty_i)
	   wb_rty_cnt	<=  !wb_rty_cnt;
      end
   end

   always @(posedge clk ) begin
      if (rst == `OR1200_RST_VALUE) begin
         biu_stb_reg	<=  1'b0;
	 biu_ack_cnt	<=  1'b0;
	 biu_err_cnt	<=  1'b0;
	 biu_rty_cnt	<=  1'b0;
`ifdef OR1200_WB_RETRY
	 retry_cnt	<= {`OR1200_WB_RETRY{1'b0}};
`endif
      end
      else begin
	 // BIU strobe
	 if (biu_stb_i & !biu_cab_i & biu_ack_o)
	   biu_stb_reg	<=  1'b0;
	 else
	   biu_stb_reg	<=  biu_stb_i;
	 // BIU ack toggle counter
	 if (wb_fsm_state_cur == wb_fsm_idle | !(|clmode))
	   biu_ack_cnt	<=  1'b0 ;
	 else if (biu_ack_o)
	   biu_ack_cnt	<=  !biu_ack_cnt ;
	 // BIU err toggle counter
	 if (wb_fsm_state_cur == wb_fsm_idle | !(|clmode))
	   biu_err_cnt	<=  1'b0 ;
	 else if (wb_err_i & biu_err_o)
	   biu_err_cnt	<=  !biu_err_cnt ;
	 // BIU rty toggle counter
	 if (wb_fsm_state_cur == wb_fsm_idle | !(|clmode))
	   biu_rty_cnt	<=  1'b0 ;
	 else if (biu_rty)
	   biu_rty_cnt	<=  !biu_rty_cnt ;
`ifdef OR1200_WB_RETRY
	 if (biu_ack_o | biu_err_o)
	   retry_cnt	<=  {`OR1200_WB_RETRY{1'b0}};
	 else if (biu_rty)
	   retry_cnt	<=  retry_cnt + 1'b1;
`endif
      end
   end

   assign biu_stb = biu_stb_i & biu_stb_reg;

   //
   // Input BIU data bus
   //
   assign	biu_dat_o	= wb_dat_i;

   //
   // Input BIU termination signals 
   //
   assign	biu_rty		= (wb_fsm_state_cur == wb_fsm_trans) & wb_rty_i & wb_stb_o & (wb_rty_cnt ~^ biu_rty_cnt);
   assign	biu_ack_o	= (wb_fsm_state_cur == wb_fsm_trans) & wb_ack & wb_stb_o & (wb_ack_cnt ~^ biu_ack_cnt);
   assign	biu_err_o	= (wb_fsm_state_cur == wb_fsm_trans) & wb_err_i & wb_stb_o & (wb_err_cnt ~^ biu_err_cnt)
`ifdef OR1200_WB_RETRY
     | biu_rty & retry_cnt[`OR1200_WB_RETRY-1];
`else
   ;
`endif


endmodule


//////////////////////////////////////////////////////////////////////
////                                                              ////
////  OR1200's Write-back Mux                                     ////
////                                                              ////
////  This file is part of the OpenRISC 1200 project              ////
////  http://www.opencores.org/project,or1k                       ////
////                                                              ////
////  Description                                                 ////
////  CPU's write-back stage of the pipeline                      ////
////                                                              ////
////  To Do:                                                      ////
////   - make it smaller and faster                               ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2000 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
//
//
// $Log: or1200_wbmux.v,v $
// Revision 1.1.1.1  2010/12/06 23:48:43  schan
// Initial import of OR1200 CPU core RTL and synthesis script along with ARM high-speed 1-port SRAM compiled memory macros. 
//
// Revision 2.0  2010/06/30 11:00:00  ORSoC
// No update 

// synopsys translate_off
// synopsys translate_on

module or1200_wbmux(
	// Clock and reset
	clk, rst,

	// Internal i/f
	wb_freeze, rfwb_op,
	muxin_a, muxin_b, muxin_c, muxin_d, muxin_e,
	muxout, muxreg, muxreg_valid
);

parameter width = `OR1200_OPERAND_WIDTH;

//
// I/O
//

//
// Clock and reset
//
input				clk;
input				rst;

//
// Internal i/f
//
input				wb_freeze;
input	[`OR1200_RFWBOP_WIDTH-1:0]	rfwb_op;
input	[width-1:0]		muxin_a;
input	[width-1:0]		muxin_b;
input	[width-1:0]		muxin_c;
input	[width-1:0]		muxin_d;
input	[width-1:0]		muxin_e;   
output	[width-1:0]		muxout;
output	[width-1:0]		muxreg;
output				muxreg_valid;

//
// Internal wires and regs
//
reg	[width-1:0]		muxout;
reg	[width-1:0]		muxreg;
reg				muxreg_valid;

//
// Registered output from the write-back multiplexer
//
always @(posedge clk ) begin
	if (rst == `OR1200_RST_VALUE) begin
		muxreg <=  32'd0;
		muxreg_valid <=  1'b0;
	end
	else if (!wb_freeze) begin
		muxreg <=  muxout;
		muxreg_valid <=  rfwb_op[0];
	end
end

//
// Write-back multiplexer
//
always @(muxin_a or muxin_b or muxin_c or muxin_d or muxin_e or rfwb_op) begin
`ifdef OR1200_ADDITIONAL_SYNOPSYS_DIRECTIVES
	casez(rfwb_op[`OR1200_RFWBOP_WIDTH-1:1]) // synopsys parallel_case infer_mux
`else
	casez(rfwb_op[`OR1200_RFWBOP_WIDTH-1:1]) // synopsys parallel_case
`endif
		`OR1200_RFWBOP_ALU: muxout = muxin_a;
		`OR1200_RFWBOP_LSU: begin
			muxout = muxin_b;
`ifdef OR1200_VERBOSE
// synopsys translate_off
			$display("  WBMUX: muxin_b %h", muxin_b);
// synopsys translate_on
`endif
		end
		`OR1200_RFWBOP_SPRS: begin
			muxout = muxin_c;
`ifdef OR1200_VERBOSE
// synopsys translate_off
			$display("  WBMUX: muxin_c %h", muxin_c);
// synopsys translate_on
`endif
		end
		`OR1200_RFWBOP_LR: begin
			muxout = muxin_d + 32'h8;
`ifdef OR1200_VERBOSE
// synopsys translate_off
			$display("  WBMUX: muxin_d %h", muxin_d + 4'h8);
// synopsys translate_on
`endif
		end
`ifdef OR1200_FPU_IMPLEMENTED
	        `OR1200_RFWBOP_FPU : begin
	     muxout = muxin_e;	     
 `ifdef OR1200_VERBOSE
// synopsys translate_off
			$display("  WBMUX: muxin_e %h", muxin_e);
// synopsys translate_on
`endif
	       end		      
`endif
	  default : begin
	     muxout = 0;
	  end
	  
	endcase
end

endmodule


