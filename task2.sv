module counter
  # (parameter WIDTH=32)
  (input  logic        clock, reset,en, 
   output logic [WIDTH-1:0] out);

  always_ff @(posedge clock)
    if (reset)
      out <= 0;
    else if (en)
      out <= out+ 1;

endmodule: counter

module vga
  (input  logic CLOCK_50, reset,
   output logic HS, VS, blank,
   output logic [8:0] row,
   output logic [9:0] col);
 
  logic [15:0] column,out1;
  logic [31:0] rown;
  logic [31:0] out2;
  logic reset1, reset2;
  logic en;
  assign en= 1;

  counter #(16) count1(CLOCK_50, reset1|reset,en, out1); // counting column
  counter #(32) count2(CLOCK_50, reset2|reset,en, out2); // counting row
 
  assign column = out1;
  assign reset1 = (out1==16'd1599) ? 1'b1 : 1'b0;

  assign rown = out2; 
  assign reset2 = (out2 == 32'd833599) ? 1'b1 : 1'b0;

  logic ts, tdisp, tpw, tfp, tbp, TS, TDISP, TPW, TFP, TBP;
  
  offset_check #(16)	check (16'd0, 16'd191, column, tpw),
			check2(16'd192, 16'd95, column, tbp),
			check3(16'd288, 16'd1279, column, tdisp),
			check4(16'd1568,16'd31, column, tfp);
		
  offset_check #(32)	check5(32'd0, 32'd3199, rown, TPW),
			check6(32'd3200, 32'd46399, rown,TBP),
			check7(32'd49600, 32'd767999, rown, TDISP),
			check8(32'd817600, 32'd833599, rown, TFP);

  assign blank = tpw||tfp||tbp||TPW||TFP||TBP;
  assign HS = (tbp||tdisp||tfp) ? 1'b1 : 1'b0;
  assign VS = (TBP||TDISP||TFP) ? 1'b1 : 1'b0;

  logic reset3,reset4;
  logic en3,en4;
  counter #(10) count3(CLOCK_50,reset3|reset,en3,col);
  counter #(9)  count4(CLOCK_50,reset4|reset,en4,row);

  assign en3 = (~(out1[0])||out1==16'd287);
  assign en4 = (out1==16'd1599);
  assign reset3 = (tdisp) ? 1'b0 : 1'b1; 
  assign reset4 = (TDISP) ? 1'b0 : 1'b1;

endmodule: vga

module tester;
  logic clk,reset,HS,VS,blank;
  logic [8:0] row;
  logic [9:0] col;

  vga v(.CLOCK_50(clk), .*);

  initial begin
	clk = 1;
	forever #1 clk = ~clk;
  end

  initial begin
    $monitor ($time,, "HS %b, VS %b, blank %b, row %d, col %d", HS, VS, blank, row, col);
	reset <= 1;
	@(posedge clk);
	reset <= 0;
        @(posedge clk);
	#2000000 $finish;
	end
endmodule: tester 
