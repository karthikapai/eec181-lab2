module lab2(
//FPGA Pins
//Clock Pins
CLOCK_50,
DRAM_CLK,

//SEVEN Segment Display
HEX0,
HEX1,
HEX2,
HEX3,
HEX4,
HEX5,

//Pushbuttons
KEY,

//LEDs
LEDR,

//Slider Switches
//SW,

//MPS Pins
//DDR3 SDRAM
HPS_DDR3_ADDR,
HPS_DDR3_BA,
HPS_DDR3_CAS_N,
HPS_DDR3_CKE,
HPS_DDR3_CK_N,
HPS_DDR3_CK,
HPS_DDR3_CS_N,
HPS_DDR3_DM,
HPS_DDR3_DQ,
HPS_DDR3_DQS_N,
HPS_DDR3_DQS,
HPS_DDR3_ODT,
HPS_DDR3_RAS_N,
HPS_DDR3_RESET_N,
HPS_DDR3_RZQ,
HPS_DDR3_WE_N
);

//Port Declaration
//FPGA Pins
input CLOCK_50;
input DRAM_CLK;
output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
input [3:0] KEY;
output [9:0] LEDR;
//input [9:0] SW;

//HPS Pins
//DDR3 SDRAM
output[14:0] HPS_DDR3_ADDR;
output [2:0] HPS_DDR3_BA;
output HPS_DDR3_CAS_N;
output HPS_DDR3_CKE;
output HPS_DDR3_CK_N;
output HPS_DDR3_CK;
output HPS_DDR3_CS_N;
output [3:0] HPS_DDR3_DM;
inout [31:0] HPS_DDR3_DQ;
inout [3:0] HPS_DDR3_DQS_N;
inout [3:0] HPS_DDR3_DQS;
output HPS_DDR3_ODT;
output HPS_DDR3_RAS_N;
output HPS_DDR3_RESET_N;
input HPS_DDR3_RZQ;
output HPS_DDR3_WE_N;

//REG/WIRE declarations
wire [31:0] hex5_0bus;
//wire [31:0] hex5_4;
//wire [15:0] hex3_0;
reg [6:0] seg;
//wire[9:0] led;
//wire [9:0] led_out;
wire [31:0] thirty2bit_in;
wire [31:0] Hex0_Hex5; 

fourToSeven f1(.hex(Hex0_Hex5[3:0]), .seg(HEX0));
fourToSeven f2(.hex(Hex0_Hex5[7:4]), .seg(HEX1));
fourToSeven f3(.hex(Hex0_Hex5[11:8]), .seg(HEX2));     // QUY: the TA want us to put the .hec(), .seg() in to make isntantiation clear, so i did
 
fourToSeven f4(.hex(Hex0_Hex5[15:12]), .seg(HEX3));
fourToSeven f5(.hex(Hex0_Hex5[19:16]), .seg(HEX4));
fourToSeven f6(.hex(Hex0_Hex5[23:20]), .seg(HEX5));


assign  thirty2bit_in[31:0] = Hex0_Hex5[31:0];
//assign led [7:0] = Hex0_Hex5[31:24]; //led_out [9:0];
//assign led_out[7:0] = Hex0_Hex5[31:24];
//assign LEDR[7:0] = Hex0_Hex5[31:24]; //led_out [7:0];
to_led u1(.input_bit(Hex0_Hex5[24]), .led(LEDR[0]));
to_led u2(.input_bit(Hex0_Hex5[25]), .led(LEDR[1]));
to_led u3(.input_bit(Hex0_Hex5[26]), .led(LEDR[2]));
to_led u4(.input_bit(Hex0_Hex5[27]), .led(LEDR[3]));
to_led u5(.input_bit(Hex0_Hex5[28]), .led(LEDR[4]));
to_led u6(.input_bit(Hex0_Hex5[29]), .led(LEDR[5]));
to_led u7(.input_bit(Hex0_Hex5[30]), .led(LEDR[6]));
to_led u8(.input_bit(Hex0_Hex5[31]), .led(LEDR[7]));

//EVERYTHING BELOW HERE WAS (mostly) GENERATED BY QSYS
//Structural Coding


    mysystem u0 (
        .system_ref_clk_clk     (CLOCK_50),                                           //   system_ref_clk.clk
        .system_ref_reset_reset (~KEY[0]),                                               // system_ref_reset.reset
        .to_hex_to_led_export   (thirty2bit_in),    //    to_hex_to_led.export
        .sdram_clk_clk          (DRAM_CLK),                                           //        sdram_clk.clk
        .pushbutton_export      (~KEY[3:1]),                                          //       pushbutton.export
        .hex5_0bus_export       (hex5_0bus),                                          //        hex5_0bus.export
		  //.rled_export            (led),                         //             rled.export
        .memory_mem_a           (HPS_DDR3_ADDR),                                      //           memory.mem_a
        .memory_mem_ba          (HPS_DDR3_BA),          //                 .mem_ba
        .memory_mem_ck          (HPS_DDR3_CK),          //                 .mem_ck
        .memory_mem_ck_n        (HPS_DDR3_CK_N),        //                 .mem_ck_n
        .memory_mem_cke         (HPS_DDR3_CKE),         //                 .mem_cke
        .memory_mem_cs_n        (HPS_DDR3_CS_N),        //                 .mem_cs_n
        .memory_mem_ras_n       (HPS_DDR3_RAS_N),       //                 .mem_ras_n
        .memory_mem_cas_n       (HPS_DDR3_CAS_N),       //                 .mem_cas_n
        .memory_mem_we_n        (HPS_DDR3_WE_N),        //                 .mem_we_n
        .memory_mem_reset_n     (HPS_DDR3_RESET_N),     //                 .mem_reset_n
        .memory_mem_dq          (HPS_DDR3_DQ),          //                 .mem_dq
        .memory_mem_dqs         (HPS_DDR3_DQS),         //                 .mem_dqs
        .memory_mem_dqs_n       (HPS_DDR3_DQS_N),       //                 .mem_dqs_n
        .memory_mem_odt         (HPS_DDR3_ODT),         //                 .mem_odt
        .memory_mem_dm          (HPS_DDR3_DM),          //                 .mem_dm
        .memory_oct_rzqin       (HPS_DDR3_RZQ),         //                 .oct_rzqin
		  
    );

	 
	 
endmodule

