module synth_wrapper (
    input clk,          // Xung nhịp
    input rst_n,        // Tín hiệu reset tích cực mức thấp
    input sel,          // Chọn chế độ đếm (1: lên, 0: xuống)
    output [3:0] out    // Ngõ ra 4 bit
);

    wire [3:0] d_input;
    wire [3:0] q_output;

    assign out = q_output;

    // Tạo logic cho d_input phụ thuộc vào chế độ sel
    // Bit 0 luôn toggle mỗi chu kỳ
    assign d_input[0] = ~q_output[0];

    // Bit 1 toggle nếu bit 0 = 1 (count up) hoặc bit 0 = 0 (count down)
    assign d_input[1] = sel ? (q_output[0] ^ q_output[1]) :
                             (~q_output[0] ^ q_output[1]);

    assign d_input[2] = sel ? ((q_output[0] & q_output[1]) ^ q_output[2]) :
                             ((~q_output[0] & ~q_output[1]) ^ q_output[2]);

    assign d_input[3] = sel ? ((q_output[0] & q_output[1] & q_output[2]) ^ q_output[3]) :
                             ((~q_output[0] & ~q_output[1] & ~q_output[2]) ^ q_output[3]);

    // Các flip-flop D
    d_ff ff0 (
        .clk(clk),
        .rst_n(rst_n),
        .d(d_input[0]),
        .q(q_output[0])
    );

    d_ff ff1 (
        .clk(clk),
        .rst_n(rst_n),
        .d(d_input[1]),
        .q(q_output[1])
    );

    d_ff ff2 (
        .clk(clk),
        .rst_n(rst_n),
        .d(d_input[2]),
        .q(q_output[2])
    );

    d_ff ff3 (
        .clk(clk),
        .rst_n(rst_n),
        .d(d_input[3]),
        .q(q_output[3])
    );

endmodule
