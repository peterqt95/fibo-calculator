/******************************************
*
* ECE111 Project 1: Fibonacci Calculator
* Author: Derek Tran A10543575
*         Peter Tran A11163016
*
*******************************************/
module fibonacci_calculator (input_s, reset_n, begin_fibo, clk, done, fibo_out) ; 
	input  [4:0] input_s ;
	input  reset_n ;
	input  begin_fibo ;
	input  clk ;
	output done ;
	output [15:0] fibo_out ;

	reg [15:0] fib_a;
	reg [15:0] fib_b;
	reg [15:0] fibo_out;
	reg [4:0] counter;
	reg done;
	reg [1:0] STATE;
	
	parameter [1:0] s0 = 0,
	                s1 = 1,
						 s2 = 2;
						 
	always@(posedge clk or negedge reset_n)
	begin
		if(! reset_n)
			begin
				fib_a <= 1;
				fib_b <= 1;
				fibo_out <= 0;
				counter <= 0;
				done <= 0;
				STATE <= s0;
			end
		else
			begin
				case (STATE)
					s0: begin
							if(begin_fibo)
							begin
								counter <= input_s;
								STATE <= s1;
							end
						 end
					s1: begin
							if(counter == 0)
								begin
									STATE <= s2;
								end
							else
								begin
									counter <= counter - 1;
									fibo_out <= fib_a;
									fib_a <= fib_b;
									fib_b <= fib_a + fib_b;
								end
						 end
					s2: begin
							done <= 1;
					    end
				endcase
			end
	end
endmodule