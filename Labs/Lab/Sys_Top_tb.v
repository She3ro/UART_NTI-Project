module Sys_top_tb;
  reg  [3: 0] data_in_tb;
  wire [3: 0] data_out_tb;
  
Sys_top U0 (
.data_in(data_in_tb),
.data_out_external(data_out_tb)
);

initial
begin
  data_in_tb = 'b0;
  $display("Test Case 1");
  #10
  data_in_tb = 'b0000;
  if(data_out_tb == 'h0)
    $display("Test Case 1 Succeeded");
else begin
  $display("Test Case 1 Failed");
end
#10
$display("Test Case 2");
data_in_tb = 'b1111;
if(data_out_tb == 'ha)
  $display("Test Case 2 Succeeded");
else begin
  $display("Test Case 2 Failed");
end
end
endmodule
