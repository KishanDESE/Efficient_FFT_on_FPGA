`timescale 1ns/1ps

module fft_tb();

  reg CLK;
  reg [3:0] state;
  reg en_a, en_b;
  reg write, start;
  reg RST_N;

  reg signed [15:0] inwr1, inwr2, inwr3, inwr4, inwr5, inwr6, inwr7, inwr8, inwc1, inwc2, inwc3, inwc4, inwc5, inwc6, inwc7, inwc8;
  wire signed [15:0]w3r_1, w3r_2, w3r_3, w3r_4, w3r_5, w3r_6, w3r_7, w3r_8, w3c_1, w3c_2, w3c_3, w3c_4, w3c_5, w3c_6, w3c_7, w3c_8;
  wire ready;

  fft_8 DUT (
    .CLK(CLK),
    .RST_N(RST_N),
    .write(write),
    .ready(ready),
    .start(start),
    .inwr1(inwr1),
    .inwr2(inwr2),
    .inwr3(inwr3),
    .inwr4(inwr4),
    .inwr5(inwr5),
    .inwr6(inwr6),
    .inwr7(inwr7),
    .inwr8(inwr8),
    .inwc1(inwc1),
    .inwc2(inwc2),
    .inwc3(inwc3),
    .inwc4(inwc4),
    .inwc5(inwc5),
    .inwc6(inwc6),
    .inwc7(inwc7),
    .inwc8(inwc8),
    .w3r_1(w3r_1),
    .w3r_2(w3r_2),
    .w3r_3(w3r_3),
    .w3r_4(w3r_4),
    .w3r_5(w3r_5),
    .w3r_6(w3r_6),
    .w3r_7(w3r_7),
    .w3r_8(w3r_8),
    .w3c_1(w3c_1),
    .w3c_2(w3c_2),
    .w3c_3(w3c_3),
    .w3c_4(w3c_4),
    .w3c_5(w3c_5),
    .w3c_6(w3c_6),
    .w3c_7(w3c_7),
    .w3c_8(w3c_8)
  );

  initial begin
    CLK = 1'b0; #50
    RST_N = 1'b1; #100
    write = 1'b1; #200
    start = 1'b1;
  end

  always #50 CLK = ~CLK;

always @(posedge write) begin
    inwr1 = 16'b00000000_00000000;
    inwr2 = 16'b00000001_00000000;
    inwr3 = 16'b00000010_00000000;
    inwr4 = 16'b00000011_00000000;
    inwr5 = 16'b00000100_00000000;
    inwr6 = 16'b00000101_00000000;
    inwr7 = 16'b00000110_00000000;
    inwr8 = 16'b00000111_00000000;
    inwc1 = 16'b00000000_00000000;
    inwc2 = 16'b00000000_00000000;
    inwc3 = 16'b00000000_00000000;
    inwc4 = 16'b00000000_00000000;
    inwc5 = 16'b00000000_00000000;
    inwc6 = 16'b00000000_00000000;
    inwc7 = 16'b00000000_00000000;
    inwc8 = 16'b00000000_00000000;
  end

  initial begin
    $dumpfile("fft_result.vcd");
    $dumpvars(0, fft_tb);
    #1000 $finish;
  end



endmodule

