module fakeclock
  (input logic clock,reset,
   output fclock);
	
	logic [31:0] out2;
	logic reset2;
	counter #(32) count2(clock, reset2|reset,1, out2); // counting row
	
	assign reset2 = (out2 == 32'd833599) ? 1'b1 : 1'b0;
	
	always_ff @(posedge clock)
	if (reset)
     fclock <= 0;	
	else if (out2 == 32'd833599)
	   fclock <= 1;
	else 
      fclock <= 0;	
	
endmodule: fakeclock

module fakeclock2
  (input logic clock,reset,
   output fclock);
	
	logic [31:0] out2;
	logic reset2;
	counter #(32) count2(clock, reset2|reset,1, out2); // counting row
	
	assign reset2 = (out2 == 32'd2500799) ? 1'b1 : 1'b0;
	
	always_ff @(posedge clock)
	if (reset)
     fclock <= 0;	
	else if (out2 == 32'd2500799)
	   fclock <= 1;
	else 
      fclock <= 0;	
	
endmodule: fakeclock2


module fakeclock3
  (input logic clock,reset,
   output fclock);
	
	logic [31:0] out2;
	logic reset2;
	counter #(32) count2(clock, reset2|reset,1, out2); // counting row
	
	assign reset2 = (out2 == 32'd41679999) ? 1'b1 : 1'b0;
	
	always_ff @(posedge clock)
	if (reset)
     fclock <= 0;	
	else if (out2 == 32'd41679999)
	   fclock <= 1;
	else 
      fclock <= 0;	
	
endmodule: fakeclock3

module wall
  (input  logic [8:0] row,
   input  logic [9:0] col,
	input  logic clock, reset,right,left,shoot,
   output logic [23:0] color,
	output logic [3:0] score,
	output logic win, lose,
	input logic slow,control);
	
	logic [9:0] coll,colr;
	paddle p(coll,colr,right,left,clock,reset,slow,bcol,brow,control);
	
	logic prow,pcol;
	range_check #(9) r(9'd440,9'd459,row,prow);
	range_check #(10) rr2(coll,colr,col,pcol);
	
	logic e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,ea,eb, bl0,bl1,bl2,bl3,bl4,bl5,bl6,bl7,bl8,bl9,bla,blb,t0,b0,l0,r0,t1,b1,l1,r1,t2,b2,l2,r2,t3,b3,l3,r3,t4,b4,l4,r4,t5,b5,l5,r5,t6,b6,l6,r6,t7,b7,l7,r7,t8,b8,l8,r8,t9,b9,l9,r9,ta,ba,la,ra,tb,bb,lb,rb;
	bricks br(clock,reset,col,bcol,row,brow,e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,ea,eb, bl0,bl1,bl2,bl3,bl4,bl5,bl6,bl7,bl8,bl9,bla,blb,
	t0,b0,l0,r0,t1,b1,l1,r1,t2,b2,l2,r2,t3,b3,l3,r3,t4,b4,l4,r4,t5,b5,l5,r5,t6,b6,l6,r6,t7,b7,l7,r7,t8,b8,l8,r8,t9,b9,l9,r9,ta,ba,la,ra,tb,bb,lb,rb,shoot,win,lose);
	
	
	logic [9:0] bcol,bcolv;
	logic [8:0] brow,browv;
	
	ball b(clock, reset,shoot,coll,colr,bcol,brow,t0,b0,l0,r0,t1,b1,l1,r1,t2,b2,l2,r2,t3,b3,l3,r3,t4,b4,l4,r4,t5,b5,l5,r5,t6,b6,l6,r6,t7,b7,l7,r7,t8,b8,l8,r8,t9,b9,l9,r9,ta,ba,la,ra,tb,bb,lb,rb,
	       bl0,bl1,bl2,bl3,bl4,bl5,bl6,bl7,bl8,bl9,bla,blb,
	       score,
	      win,lose,slow);
	
	offset_check #(9)  of2(brow,10'd4,row,browv);
   offset_check #(10) of3(bcol,10'd4,col,bcolv);
	
  always_ff @(posedge clock) begin
    if ((col>10'd19 & col<10'd40 & row>9'd9 & row<9'd470) | (col>10'd589 & col<10'd610 & row>9'd9 & row<9'd470) | (col>10'd19 & col<10'd610 & row>9'd9 & row<9'd30))
      if (win)
		  color <= 24'h00FF00;
		else if (lose)
		  color <= 24'hFF0000;
		else  
		  color <= 24'hCCCCCC;
	else if (prow & pcol) 
      color <= 24'h00FF00;	
	else if (e0 & ~bl0 & ~win & ~lose)
      color = 24'hFFFF00;
	else if (e2 & ~bl2 & ~win & ~lose)
      color = 24'hFFFF00;
	else if (e4 & ~bl4 & ~win & ~lose)
      color = 24'hFFFF00;
	else if (e6 & ~bl6 & ~win & ~lose)
      color = 24'hFFFF00;
	else if (e8 & ~bl8 & ~win & ~lose)
      color = 24'hFFFF00;
	else if (ea & ~bla & ~win & ~lose)
      color = 24'hFFFF00;
	else if (e1 & ~bl1 & ~win & ~lose)
      color = 24'hFF00FF;	
	else if (e3 & ~bl3 & ~win & ~lose)
      color = 24'hFF00FF;
	else if (e5 & ~bl5 & ~win & ~lose)
      color = 24'hFF00FF;
	else if (e7 & ~bl7 & ~win & ~lose)
      color = 24'hFF00FF;
	else if (e9 & ~bl9 & ~win & ~lose)
      color = 24'hFF00FF;
	else if (eb & ~blb & ~win & ~lose)
      color = 24'hFF00FF;	
	else if (bcolv & browv & ~win & ~lose)
      color = 24'hFFFFFF;	
   else
	   color <= 24'h000000;
	end

endmodule: wall

module paddle
  (output  logic [9:0] coll,colr,
	input  logic       right,left,clock,reset,slow,
	input logic [9:0] bcol,
	input logic [8:0] brow,
	input logic control);
	
		
	logic fclock,fclock1;
	fakeclock f(clock,reset,fclock1);

	logic fclock2;
	fakeclock2 f2(clock,reset,fclock2);
	
	assign fclock = (slow) ? fclock1 : fclock2;
	
	always_ff @(posedge clock) begin
	  if (reset) begin
       coll <= 10'd193;
       colr <= 10'd257;		 
     end
	  //else if (control) begin
		 //coll <= (bcol - 10'd30);
		 //colr <= coll + 10'd64;
	  //end	
	  else if (fclock & right & ~left & colr<10'd591) begin
       coll <= coll + 10'd5;
       colr <= colr + 10'd5;
		end
	  else if (fclock & left & ~right & coll>10'd39) begin
       coll <= coll - 10'd5;
       colr <= colr - 10'd5;	 
	  end
	  else begin
		 coll <= coll;
		 colr <= colr;
	  end
	end  
	
endmodule: paddle

module brick
  #(parameter leftcol=10'd40,toprow=9'd100,width=10'd100,height=9'd30)
  (input logic clock, reset,
   input logic [9:0] col,bcol,
	input logic [8:0] row,brow,
	input logic shoot,win,lose,
	output logic display,ballin,t,b,l,r);
	
	logic displayc,displayr,ballcol,ballrow;
	offset_check #(10) off(leftcol,width,col,displayc);
	offset_check  #(9) off2(toprow,height,row,displayr);
	
	offset_check #(10) rr0(leftcol,width,bcol,ballcol);
	offset_check #(9)  rr1(toprow,height,brow,ballrow);
	
	logic newgame;
	
	always_ff @(posedge clock)
	  if (reset) begin
	    ballin <= 0;
		 t <= 0;
	    b <= 0;
	    l <= 0;
	    r <= 0;
		 newgame <= 0;
	  end
	  else if (ballcol & ballrow)	 begin
	    ballin <= 1;
		  t <= (ballcol &  (brow+9'd3)>(toprow-9'd1) & ~ballin);
	     b <= (ballcol & brow==(toprow+height) & ~ballin);
	     l <= (ballrow & (bcol+10'd3)==(leftcol-10'd1) & ~ballin);
	     r <= (ballrow & bcol==(leftcol+width) & ~ballin);
		end
		else if(shoot) 
		  newgame <= (win|lose);
		else if (newgame) begin
		  newgame <= 0;
		  ballin <= 0;
		end  
		
	
	assign display = displayc & displayr;
	

 	
endmodule: brick

module bricks
  (input logic clock, reset,
   input logic [9:0] col,bcol,
	input logic [8:0] row,brow,
   output logic e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,ea,eb,
	output logic bl0,bl1,bl2,bl3,bl4,bl5,bl6,bl7,bl8,bl9,bla,blb,
	output logic t0,b0,l0,r0,
	output logic t1,b1,l1,r1,
	output logic t2,b2,l2,r2,
	output logic t3,b3,l3,r3,
	output logic t4,b4,l4,r4,
	output logic t5,b5,l5,r5,
	output logic t6,b6,l6,r6,
	output logic t7,b7,l7,r7,
	output logic t8,b8,l8,r8,
	output logic t9,b9,l9,r9,
	output logic ta,ba,la,ra,
	output logic tb,bb,lb,rb,
	input logic shoot,win,lose);
	
	brick #(40, 100,100,30) bb0(.display(e0), .ballin(bl0), .t(t0), .b(b0), .l(l0), .r(r0), .*);
	brick #(140, 100,100, 30) bb1(.display(e1), .ballin(bl1), .t(t1), .b(b1), .l(l1), .r(r1), .*);
	brick #(240, 100,100, 30) bb2(.display(e2), .ballin(bl2), .t(t2), .b(b2), .l(l2), .r(r2), .*);
	brick #(340, 100,100, 30) bb3(.display(e3), .ballin(bl3),.t(t3), .b(b3), .l(l3), .r(r3),  .*);
	brick #(440, 100,100, 30) bb4(.display(e4), .ballin(bl4),.t(t4), .b(b4), .l(l4), .r(r4),  .*);
	brick #(540, 100,50 ,30) bb5(.display(e5), .ballin(bl5), .t(t5), .b(b5), .l(l5), .r(r5), .*);
	brick #(40, 150,50 ,30) bb6(.display(e6), .ballin(bl6), .t(t6), .b(b6), .l(l6), .r(r6), .*);
	brick #(90, 150,100 ,30) bb7(.display(e7), .ballin(bl7),.t(t7), .b(b7), .l(l7), .r(r7),  .*);
	brick #(190, 150,100 ,30) bb8(.display(e8), .ballin(bl8), .t(t8), .b(b8), .l(l8), .r(r8), .*);
	brick #(290, 150,100 ,30) bb9(.display(e9), .ballin(bl9), .t(t9), .b(b9), .l(l9), .r(r9), .*);
	brick #(390, 150,100 ,30) bbA(.display(ea), .ballin(bla),.t(ta), .b(ba), .l(la), .r(ra),  .*);
	brick #(490, 150,100 ,30) bbB(.display(eb), .ballin(blb), .t(tb), .b(bb), .l(lb), .r(rb), .*);
	
endmodule: bricks
	
	
module ball
  (input logic clock, reset,shoot,
   input logic [9:0] pcoll,pcolr, 
   output logic [9:0] bcol,
	output logic [8:0] brow,
	input logic t0,b0,l0,r0,t1,b1,l1,r1,t2,b2,l2,r2,t3,b3,l3,r3,t4,b4,l4,r4,t5,b5,l5,r5,t6,b6,l6,r6,t7,b7,l7,r7,t8,b8,l8,r8,t9,b9,l9,r9,ta,ba,la,ra,tb,bb,lb,rb,
	input logic bl0,bl1,bl2,bl3,bl4,bl5,bl6,bl7,bl8,bl9,bla,blb,
	output logic [3:0] score,
	output logic win,lose,
	input  logic slow);
	
	logic move;
	logic fclock,fclock1;
	fakeclock f(clock,reset,fclock1);

	logic fclock2;
	fakeclock2 f2(clock,reset,fclock2);
	
	assign fclock = (slow) ? fclock1 : fclock2;
	
	
	logic fclock3;
	fakeclock3 f3(clock,reset,fclock3);
	
	logic paddle, paddlel, paddler, paddleleft,paddleright;
	range_check rc(pcoll,pcolr,bcol,paddle);
	offset_check #(10) occ(pcoll,10'd32,bcol,paddleleft);
	offset_check #(10) occ2(pcoll+10'd32,10'd31,bcol,paddleright);
	
	assign paddlel = 0;//(((bcol+10'd3)>(pcoll)) & (brow>9'd436)) & right & ~paddle;
	assign paddler = 0;//((bcol<(pcolr+10'd1)) & (brow>9'd436)) & left & ~paddle;
	
	always_ff @(posedge clock) begin
	  if (reset | (brow>10'd474)) begin
	    left <=0;
	    right <=1;
	    up <= 1;
		 down <= 0;
	  end	 
	  else if (bcol<10'd40 |r0|r1|r2|r3|r4|r5|r6|r7|r8|r9|ra|rb|paddler) begin//left wall
	    left <= 0;
		 right <= 1;
		 up <= up;
		 down <= down;
	  end
	  else if (bcol>10'd585 | l0|l1|l2|l3|l4|l5|l6|l7|l8|l9|la|lb|paddlel) begin//right wall
	    left <= 1;
		 right <= 0;
		 up <= up;
		 down <= down;
	  end
	  else if (brow<9'd30 | b0|b1|b2|b3|b4|b5|b6|b7|b8|b9|ba|bb) begin//top wall
	    up <= 0;
		 down <= 1;
		 left <= left;
		 right <= right;
	  end	 
	  else if ((brow>9'd436)&paddle&(paddleleft|paddleright)) begin
	    up <= 1;
		 down <= 0;
		 left <= paddleleft;
		 right <= paddleright;
	  end
	  else if (((brow>9'd436) & paddle) |t0|t1|t2|t3|t4|t5|t6|t7|t8|t9|ta|tb) begin//paddle top
	    up <= 1;
		 down <= 0;
		 right <= right;
		 left <= left;
	  end	 
	end

	assign lose =  (score==2'd0);
	assign win = (score==4'd3 & ~move) ? 0 : (score>2'd0 & bl0 & bl1 & bl2 & bl3 & bl4 & bl5 & bl6 & bl7 & bl8 & bl9 & bla & blb) ? 1:0;
	
	logic newgame;
	
	logic left, right, up, down;
	logic [9:0] hvelocity;
	logic [8:0] vvelocity;
	always_ff @(posedge clock)
		if (shoot) begin
		  move <= 1;
		  newgame <= (win|lose);
		end  
		else if(reset | newgame) begin
			bcol <= 10'd400;
			brow <= 9'd420;
			move <= 0;
			hvelocity <= 10'd1;
			vvelocity <= 9'd2;
			score <= 4'd3;
			newgame <= 0;
		end 
		else if (win) begin
		 bcol <= 10'd400;
		 brow <= 9'd420;
		end 
		else if (brow>10'd474) begin
		  bcol <= 10'd400;
		  brow <= 9'd420;
		  move <= 0;
		  score <= score - 4'd1;
		end  
		else if(fclock & move & up & left) begin
		   hvelocity <= (fclock3 & move & (hvelocity<10'd9)) ? hvelocity + 10'd1 : hvelocity;
	    vvelocity <= (fclock3 & move & (vvelocity<9'd10)) ? vvelocity + 9'd1 : vvelocity;
			brow <= brow - vvelocity;
			bcol <= bcol - hvelocity;
		  end
		else if(fclock & move & up & right) begin
       hvelocity <= (fclock3 & move & (hvelocity<10'd9)) ? hvelocity + 10'd1 : hvelocity;
	    vvelocity <= (fclock3 & move & (vvelocity<9'd10)) ? vvelocity + 9'd1 : vvelocity;
			brow <= brow - vvelocity;
			bcol <= bcol + hvelocity;
		  end
		else if (fclock & move & down & left) begin
		hvelocity <= (fclock3 & move & (hvelocity<10'd9)) ? hvelocity + 10'd1 : hvelocity;
	    vvelocity <= (fclock3 & move & (vvelocity<9'd10)) ? vvelocity + 9'd1 : vvelocity;
			brow <= brow + vvelocity;
			bcol <= bcol - hvelocity;
		  end
		else if (fclock & move & down & right) begin	
		hvelocity <= (fclock3 & move & (hvelocity<10'd9)) ? hvelocity + 10'd1 : hvelocity;
	    vvelocity <= (fclock3 & move & (vvelocity<9'd10)) ? vvelocity + 9'd1 : vvelocity;
			brow <= brow + vvelocity;
			bcol <= bcol + hvelocity;
			end
	
endmodule: ball
