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

module tb_gray_code_adder;

parameter WIDTH=4;
logic [WIDTH-1:0] a, b, sum, a_bin, b_bin, sum_gray, sum_dummy;
logic ci, co, co_dummy;

gray_code_adder DUT(.*);
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
			$display("input gray => %b,%b || calculated bin => %b,%b || sum bin => %b || sum gray (tb,module) =>%b,%b", a, b, a_bin, b_bin, sum_dummy, sum_gray, sum);
		end
	end
	$finish;
end

endmodule : tb_gray_code_adder
