/****************************************************************
 * gray_code_adder.sv - cla for gray code inputs
 *
 * Author        : Viraj Khatri (vk5@pdx.edu)
 * Last Modified : 10th November, 2021
 *
 * Description   :
 * ===============
 * 3 steps
 * -------
 * 1. convert to binary
 * 2. add
 * 3. convert sum to gray code
 * ---------
 * 3 modules
 * ---------
 * 1. binary to gray converter
 * 2. adder (not really required)
 * 3. gray to binary converter
 ****************************************************************/

// binary to gray code
module bin2gray
#(
	WIDTH = 4
)
(
	input  logic [WIDTH-1:0] bin,
	output logic [WIDTH-1:0] gray
);

assign gray = bin ^ (bin >> 1);

endmodule : bin2gray

// gray code to binary
module gray2bin
#(
	WIDTH = 4
)
(
	input  logic [WIDTH-1:0] gray,
	output logic [WIDTH-1:0] bin
);

for (genvar i=0; i<WIDTH; i++) begin
	assign bin[i] = ^(gray >> i);
end

endmodule : gray2bin

// gray code adder
module gray_code_adder_sv
#(
	WIDTH = 4
)
(
	input  logic [WIDTH-1:0] a,b,
	input  logic             ci,
	output logic [WIDTH-1:0] sum,
	output logic             co
);

logic [WIDTH-1:0] a_bin, b_bin, sum_bin;

gray2bin bin_a(.bin(a_bin), .gray(a));
gray2bin bin_b(.bin(b_bin), .gray(b));
assign {co, sum_bin} = { a_bin + b_bin + ci };
bin2gray gray_sum(.gray(sum), .bin(sum_bin));

endmodule : gray_code_adder_sv
