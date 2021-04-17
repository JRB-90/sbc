// Check if we need to compile fake memory, ie. we are compiling from
// iverilog and cannot compile vendor (like Altera altsyncram)
// specific BRAM
`ifdef FAKE_BRAM
// TODO - Include some fake memory here
`else
//`include "ROM.v"
//`include "RAM.v"
`endif

module sbc_system (
    input               fst_clk,
    input               phi2,
    input               uart_clk,
    input               res_n,

    // ACIA1 connections
    input               acia1_rx,
    input               acia1_cts_n,
    input               acia1_dcd_n,
    input               acia1_dsr_n,
    output              acia1_tx,
    output              acia1_rts_n,
    output              acia1_dtr_n
);

endmodule
