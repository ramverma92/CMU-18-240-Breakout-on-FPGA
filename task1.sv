module range_check
  #(parameter WIDTH = 10)
  (input  logic [WIDTH-1:0] low, high, val,
   output logic             is_between);

  assign is_between = ((val>low || val==low) && (val<high || val==high));

endmodule: range_check

module offset_check
  #(parameter WIDTH = 10)  
  (input  logic [WIDTH-1:0] low, delta, val,
   output logic             is_between);

  range_check #(WIDTH) ran(low,low+delta,val,is_between);

endmodule: offset_check
/*
module tester;
  logic [15:0] low, high, val;
  logic is_between_r, is_between_o;

  range_check  #(16) r(low,high,val,is_between_r);
  offset_check #(16) o(low,high,val,is_between_o);
  
  initial begin
    $monitor ($time, " low(%d) high(%d) val(%d) range(%b) offset(%b)", low, high, val, is_between_r, is_between_o);
    	low = 16'd0;
	high = 16'd0;
	val = 16'd0;
	#5 low = 16'd5;
	#5 high = 16'd10;
	#5 val = 16'd7;
	#5 low = 16'd11;
	#5 high = 16'd13;
	#5 val = 16'd12;
        #5 val=16'd8;low=16'd0;high=16'd192;
	#5 $finish;
    end
endmodule: tester
 */
