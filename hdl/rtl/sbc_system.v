`include "CPU_6502.v"
`include "ACIA_6551.v"

// Check if we need to compile fake memory, ie. we are compiling from
// iverilog and cannot compile vendor (like Altera altsyncram)
// specific BRAM
`ifdef FAKE_BRAM
// TODO - Include some fake memory here
`else
`include "ROM.v"
`include "RAM.v"
`endif

module sbc_system (
    input               fst_clk,
    input               phi2,
    input               uart_clk,
    input               res_n,

    // ACIA1 connections
    input               acia_rx,
    input               acia_cts_n,
    input               acia_dcd_n,
    input               acia_dsr_n,
    output              acia_tx,
    output              acia_rts_n,
    output              acia_dtr_n
);

// Wire/Reg declarations
wire				rw_n;
wire                irq_n;
wire                acia_irq_n;

wire    [15:0]	    cpu_addr_out;
wire	[7:0]		cpu_data_in;
wire	[7:0]		cpu_data_out;
wire	[7:0]		rom_data_out;
wire	[7:0]		ram_data_out;
wire    [7:0]       acia_data_out;

wire				rom_sel_n;
wire				ram_sel_n;
wire				io_sel_n;
wire                rom_rd_en;
wire                ram_rd_en;
wire                ram_wr_en;

// Structural code

CPU_6502 cpu(
    .clk(fst_clk),
    .phi(phi2),
    .res(res_n),
    .so(1),
    .rdy(1),
    .nmi(1),
    .irq(irq_n),
    .dbi(cpu_data_in),

    .rw(rw_n),
    .ab(cpu_addr_out),
    .dbo(cpu_data_out)
);

ACIA_6551 acia1(
    .PH_2(phi2),
    .XTAL_CLK_IN(uart_clk),
    .RESET_N(res_n),
    .RW_N(rw_n),
    .IRQ(acia_irq_n),
    .CS({io_sel_n, ~io_sel_n}),
    .DI(cpu_data_out),
    .RXDATA_IN(acia_rx),
    .CTS(acia_cts_n),
    .DCD(0),
    .DSR(0),
    .RS(cpu_addr_out[1:0]),

    .DO(acia_data_out),
    .TXDATA_OUT(acia_tx),
    .RTS(acia_rts_n)
);

`ifdef FAKE_BRAM
// TODO - Instantiate some fake memory here
`else
RAM ram(
	.clock(fst_clk),
 	.address(cpu_addr_out[14:0]),
    .rden(ram_rd_en),
    .wren(ram_wr_en),
	.data(cpu_data_out),

	.q(ram_data_out)
);

ROM rom(
	.clock(fst_clk),
	.rden(rom_rd_en),
	.address(cpu_addr_out[13:0]),
	
	.q(rom_data_out)
);
`endif

endmodule
