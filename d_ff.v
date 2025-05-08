// Module chốt D (D Flip-Flop) với reset không đồng bộ
module d_ff (
    input clk,
    input rst_n,
    input d,
    output reg q
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        q <= 1'b0;  // Reset về 0
    end else begin
        q <= d;     // Chốt giá trị đầu vào
    end
end

endmodule