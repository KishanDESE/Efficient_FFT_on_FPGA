//Approximation FFT (8-Point)
`timescale 1 ns/1 ns

module fft_8(CLK, RST_N, write, ready, start, inwr1, inwr2, inwr3, inwr4, inwr5, inwr6, inwr7, inwr8, inwc1, inwc2, inwc3, inwc4, inwc5, inwc6, inwc7, inwc8, w3r_1, w3r_2, w3r_3, w3r_4, w3r_5, w3r_6, w3r_7, w3r_8, w3c_1, w3c_2, w3c_3, w3c_4, w3c_5, w3c_6, w3c_7, w3c_8);

  input CLK;
  input RST_N;
  input start, write;
  output reg ready;

  input signed [15:0] inwr1, inwr2, inwr3, inwr4, inwr5, inwr6, inwr7, inwr8, inwc1, inwc2, inwc3, inwc4, inwc5, inwc6, inwc7, inwc8;

  reg signed [15:0] inr0, inr1, inr2, inr3, inr4, inr5, inr6, inr7,inc0, inc1, inc2, inc3, inc4, inc5, inc6, inc7;

  reg [2:0] current_state;

  //stage1 wires

  //stage 2 wires
  reg signed [15:0] w2r_1,w2r_2,w2r_3,w2r_4,w2r_5,w2r_6,w2r_7,w2r_8,w2c_1,w2c_2,w2c_3,w2c_4,w2c_5,w2c_6,w2c_7,w2c_8;

  //wire formed
  output reg signed [15:0] w3r_1, w3r_2, w3r_3, w3r_4, w3r_5, w3r_6, w3r_7, w3r_8, w3c_1, w3c_2, w3c_3, w3c_4, w3c_5, w3c_6, w3c_7, w3c_8;

  //wire formed
  always @(posedge CLK) begin
    if (~RST_N) begin
      inr0 <= 16'b0;
      inr1 <= 16'b0;
      inr2 <= 16'b0;
      inr3 <= 16'b0;
      inr4 <= 16'b0;
      inr5 <= 16'b0;
      inr6 <= 16'b0;
      inr7 <= 16'b0;
      inc0 <= 16'b0;
      inc1 <= 16'b0;
      inc2 <= 16'b0;
      inc3 <= 16'b0;
      inc4 <= 16'b0;
      inc5 <= 16'b0;
      inc6 <= 16'b0;
      inc7 <= 16'b0;


      w3r_1 <= 16'b0;
      w3r_2 <= 16'b0;
      w3r_3 <= 16'b0;
      w3r_4 <= 16'b0;
      w3r_5 <= 16'b0;
      w3r_6 <= 16'b0;
      w3r_7 <= 16'b0;
      w3r_8 <= 16'b0;
      w3c_1 <= 16'b0;
      w3c_2 <= 16'b0;
      w3c_3 <= 16'b0;
      w3c_4 <= 16'b0;
      w3c_5 <= 16'b0;
      w3c_6 <= 16'b0;
      w3c_7 <= 16'b0;
      w3c_8 <= 16'b0;

      ready <= 1'b0;
    end else begin
      if (write) begin
        inr0 <= inwr1;
        inr1 <= inwr2;
        inr2 <= inwr3;
        inr3 <= inwr4;
        inr4 <= inwr5;
        inr5 <= inwr6;
        inr6 <= inwr7;
        inr7 <= inwr8;
        inc0 <= inwc2;
        inc1 <= inwc2;
        inc2 <= inwc3;
        inc3 <= inwc4;
        inc4 <= inwc5;
        inc5 <= inwc6;
        inc6 <= inwc7;
        inc7 <= inwc8;
      end

      if (start) begin
        current_state <= 0;

        // stage1
        case (current_state)
          0: begin
            // wire assigned
		w2r_1 <= inr0 + inr4 + (inr2 + inr6);
		w2r_2 <= inr0 - inr4 + (inc2 - inc6);
		w2r_3 <= inr0 + inr4 - (inr2 + inr6);
		w2r_4 <= inr0 - inr4 - (inc2 - inc6);
		w2r_5 <= inr1 + inr5 + (inr3 + inr7);
		w2r_6 <= inr1 - inr5 + (inc3 - inc7);
		w2r_7 <= inr1 + inr5 - (inr3 + inr7);
		w2r_8 <= inr1 - inr5 - (inc3 - inc7);
		w2c_1 <= inc0 + inc4 + (inc2 + inc6);
		w2c_2 <= inc0 - inc4 - (inr2 - inr6);
		w2c_3 <= inc0 + inc4 - (inc2 + inc6);
		w2c_4 <= inr2 - inr6 + (inc0 - inc4);
		w2c_5 <= inc1 + inc5 + (inc3 + inc7);
		w2c_6 <= inc1 - inc5 - (inr3 - inr7);
		w2c_7 <= inc1 + inc5 - (inc3 + inc7);
		w2c_8 <= inc1 - inc5 + (inr3 - inr7);
            current_state <= 1;
          end


          // stage 2
          1: begin
		  w3r_1 = w2r_1 + w2r_5;
		  w3r_2 = w2r_2 + (w2r_6 >>> 1 ) + (w2r_6 >>> 2) + (w2c_6 >>> 1) + (w2c_6 >>> 2);
		  w3r_3 = w2r_3 - w2c_7;
		  w3r_4 = w2r_4 + (w2c_8 >>> 1) + (w2c_8 >>> 2) - (w2r_8 >>> 1) - (w2r_8 >>> 2);
		  w3r_5 = w2r_1 - w2r_5;
		  w3r_6 = w2r_2 - (w2r_6 >>> 1) - (w2r_6 >>> 2) - (w2c_6 >>> 1) - (w2c_6 >>> 2);
		  w3r_7 = w2r_3 - w2c_7;
		  w3r_8 = w2r_4 - (w2c_8 >>> 1) - (w2c_8 >>> 2) + (w2r_8 >>> 1) + (w2r_8 >>> 2);

		  w3c_1 = w2c_1 + w2c_5;
		  w3c_2 = w2c_2 + (w2c_6 >>> 1) + (w2c_6 >>> 2) - (w2r_6 >>> 1) - (w2r_6 >>> 2);
		  w3c_3 = w2c_3 - w2r_7;
		  w3c_4 = w2c_4 - (w2r_8 >>> 1) - (w2r_8 >>> 2) - (w2c_8 >>> 1) - (w2c_8 >>> 2);
		  w3c_5 = w2c_1 + w2c_5;
		  w3c_6 = w2c_2 + (w2r_6 >>> 1) + (w2r_6 >>> 2) - (w2c_6 >>> 1) - (w2c_6 >>> 2);
		  w3c_7 = w2c_3 + w2r_7;
		  w3c_8 = w2c_4 + (w2c_8 >>> 1) + (w2c_8 >>> 2) + (w2r_8 >>> 1) + (w2r_8 >>> 2);

            // ready to get output
            ready <= 1'b1;
          end
        endcase
      end
    end
  end
endmodule

