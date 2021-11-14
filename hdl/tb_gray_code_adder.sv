/****************************************************************
 * tb_gray_code_adder.sv - testbench for gray code adder
 *
 * Author        : Viraj Khatri (vk5@pdx.edu)
 * Last Modified : 10th November, 2021
 *
 * Description   :
 * -----------
 * as title states
 ****************************************************************/

`timescale 1ns/10ps
module tb_gray_code_adder;

parameter WIDTH=4;
logic [WIDTH-1:0] a, b, sum, a_bin, b_bin, sum_gray, sum_dummy, sum_syn;
logic ci, co, co_dummy;

gray_code_adder_sv DUT0(.*);
gray_code_adder    DUT1(.*, .sum(sum_syn));
gray2bin a2bin(.bin(a_bin), .gray(a));
gray2bin b2bin(.bin(b_bin), .gray(b));
bin2gray sum2gray(.gray(sum_gray), .bin(sum_dummy));

initial begin
	fork
		ci = 0;
		a = 0;
		b = 0;
	join
	for (int i=0; i<2**WIDTH;i++) begin

		a = i;
		for (int j=0; j<2**WIDTH;j++) begin
			b = j;
			#10;
			{co_dummy, sum_dummy} = a_bin+b_bin;
			#10;
			$display("input gray => %b,%b || sum gray (tb,module,synthesized) =>%b,%b,%b", a, b, sum_gray, sum, sum_syn);
		end
	end
	$finish;
end

endmodule : tb_gray_code_adder
