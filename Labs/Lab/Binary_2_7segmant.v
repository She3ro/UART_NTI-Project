module Binary_7segmant(
input wire [3: 0] data_in,
output wire [3: 0] data_out_external
);

reg [3: 0] data_out;
always @ (*)
begin
case (data_in)
4'b0000: data_out = 'h0;
4'b0001: data_out = 'h1;
4'b0010: data_out = 'h2;
4'b0011: data_out = 'h3;
4'b0100: data_out = 'h4;
4'b0101: data_out = 'h5;
4'b0110: data_out = 'h6;
4'b0111: data_out = 'h7;
4'b1000: data_out = 'h8;
4'b1001: data_out = 'h9;
4'b1010: data_out = 'ha;
4'b1011: data_out = 'hb;
4'b1100: data_out = 'hc;
4'b1101: data_out = 'hd;
4'b1110: data_out = 'he;
4'b1111: data_out = 'hf;
default: data_out = 'h0;
endcase
end
assign data_out_external = ~ data_out;
endmodule