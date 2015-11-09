module BCDtoSevenSegment
    (input logic [3:0] bcd,
     output logic [6:0] segment);

    always_comb
      case (bcd)
        4'b0000: segment=7'b1000000;
        4'b0001: segment=7'b1111001;
        4'b0010: segment=7'b0100100;
        4'b0011: segment=7'b0110000;
        4'b0100: segment=7'b0011001;
        4'b0101: segment=7'b0010010;
        4'b0110: segment=7'b0000010;
        4'b0111: segment=7'b1111000;
        4'b1000: segment=7'b0000000;
        4'b1001: segment=7'b0011000;
                  default: segment=7'b1111111;
      endcase

endmodule: BCDtoSevenSegment

module ChipInterface
	(input logic         CLOCK_50,
	input logic [3:0] KEY,
	input logic [17:0] SW,
	output logic [6:0] HEX6,
	output logic [7:0] VGA_R, VGA_G, VGA_B,
	output logic 		VGA_BLANK_N, VGA_CLK, VGA_SYNC_N,
	output logic 		VGA_VS, VGA_HS);

    
        logic [8:0] row;
        logic [9:0] col;
        logic blank;
        
        assign VGA_BLANK_N = ~blank;
        assign VGA_SYNC_N=0;
        assign VGA_CLK = ~CLOCK_50;      
    
        vga v(CLOCK_50,~KEY[2],VGA_HS,VGA_VS,blank,row,col); 

        logic [23:0] vg;
        assign {VGA_R,VGA_G,VGA_B}=vg;
    
	     logic [3:0] score;
		  logic win,lose; 
        wall w(row,col,CLOCK_50,~KEY[2],~KEY[0],~KEY[3],(~KEY[1]|SW[17]),vg,score,win,lose,SW[0],SW[1]);
		  BCDtoSevenSegment seven(score,HEX6);

endmodule: ChipInterface 
