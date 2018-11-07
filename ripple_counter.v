// https://www.jdoodle.com/execute-verilog-online
// https://maxeler.mi.sanu.ac.rs/#/login

module ff (q, clk, reset);

  output q;
  input clk, reset;
  
  reg q;
  
  always @(posedge reset or posedge clk) begin
    if (reset)
      q <= 1'b0;
    else
      q <= ~q;
  end
  
endmodule


module ripple_carry_counter (q, clk, reset);

  output [3:0] q;
  input clk, reset;
  
  ff ff0(q[0], ~clk, reset);
  ff ff1(q[1], ~q[0], reset);
  ff ff2(q[2], ~q[1], reset);
  ff ff3(q[3], ~q[2], reset);
  
endmodule


module test;

  reg clk, reset;
  wire [3:0] q;
  
  ripple_carry_counter rcc (q, clk, reset);
  
  initial begin
    clk = 1'b0;
    reset = 1'b1;
    #10 reset = 1'b0;
    #150;
    $finish;
  end
  
  always @( posedge clk)
    $display("Count = %b", q );

  always #5 clk = ~clk;

endmodule