module Sys_top (
input wire [3: 0] data_in,
output reg [3: 0] data_out_external
);
reg [3: 0] data_out;
Gray_2_Binary U0 (
.data_in(data_in),
.data_out(data_out)
);

Binary_7segmant U1 (
.data_in(data_out),
.data_out_external(data_out_external)
);
endmodule