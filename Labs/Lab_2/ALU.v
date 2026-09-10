module ALU # ( parameter width = 8) (
  input wire [width - 1: 0] a,
  input wire [width - 1: 0] b,
  input wire [2: 0] opt,
  output reg [width : 0] out,
  output reg zero
  );
  
  always @ (*)
  begin
    case (opt)
      3'b000: out = a;
      3'b001: out = b - a;
      3'b010: out = a + b;
      3'b011: out = a & b;
      3'b100: out = a ^ b;
      3'b101: out = b;
      3'b110: out = a;
      3'b111: out = a;
      default: begin
        out = 1'b0;
      end
    endcase
end

always @ (*)
begin
if (a == 0)
zero = 1'b1;
else
zero = 1'b0;
end
   
endmodule