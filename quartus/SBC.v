
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module SBC(

	//////////// CLOCK //////////
	input 		          		ADC_CLK_10,
	input 		          		MAX10_CLK1_50,
	input 		          		MAX10_CLK2_50,

	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,

	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,

	//////////// KEY //////////
	input 		     [1:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// VGA //////////
	output		     [3:0]		VGA_B,
	output		     [3:0]		VGA_G,
	output		          		VGA_HS,
	output		     [3:0]		VGA_R,
	output		          		VGA_VS,

	//////////// Accelerometer //////////
	output		          		GSENSOR_CS_N,
	input 		     [2:1]		GSENSOR_INT,
	output		          		GSENSOR_SCLK,
	inout 		          		GSENSOR_SDI,
	inout 		          		GSENSOR_SDO,

	//////////// Arduino //////////
	inout 		    [15:0]		ARDUINO_IO,
	inout 		          		ARDUINO_RESET_N,

	//////////// GPIO, GPIO connect to GPIO Default //////////
	inout 		    [35:0]		GPIO
);

//=======================================================
//  REG/WIRE declarations
//=======================================================

wire				res_n;
wire				clk_200M;
wire				PHI2_1M;
wire				PHI1_1M;
wire				uart_clk_1M832;
wire 				cpuclk_Locked;
wire 				uartclk_Locked;

wire				acia1_rx;
wire				acia1_tx;
wire				acia1_cts_n;
wire				acia1_rts_n;

//=======================================================
//  Structural coding
//=======================================================

assign res_n = KEY[0] && (cpuclk_Locked && uartclk_Locked) ? 1 : 0;
assign acia1_cts_n = GPIO[6];
assign GPIO[7] = acia1_rts_n;
assign acia1_rx = GPIO[8];
assign GPIO[9] = acia1_tx;

sys_clk sysclk(
	.inclk0(MAX10_CLK1_50),
	.areset(~KEY[0]),
	
	.locked(cpuclk_Locked),
	.c0(clk_200M),
	.c1(PHI2_1M),
	.c2(PHI1_1M)
);

uart_clk uartclk(
	.inclk0(MAX10_CLK1_50),
	.areset(~KEY[0]),
	
	.locked(uartclk_Locked),
	.c0(uart_clk_1M832)
);

sbc_system sbc(
	.fst_clk(MAX10_CLK1_50),
	.phi2(PHI2_1M),
	.uart_clk(uart_clk_1M832),
	.res_n(res_n),
	
	.acia1_rx(acia1_rx),
	.acia1_tx(acia1_tx),
	.acia1_cts_n(acia1_cts_n),
	.acia1_rts_n(acia1_rts_n),
	.acia1_dcd_n(0),
	.acia1_dsr_n(0),
);

endmodule