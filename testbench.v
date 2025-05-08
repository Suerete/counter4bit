module testbench;
    reg clk;
    reg rst_n;
    reg sel;
    wire [3:0] out;
    
    synth_wrapper uut (
        .clk(clk),
        .rst_n(rst_n),
        .sel(sel),
        .out(out)
    );
    
    // Tạo xung nhịp
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        // Khởi tạo
        rst_n = 0; sel = 1;
        #20;
        
        // Test đếm lên
        rst_n = 1;
        #180; // Đợi đủ 16 chu kỳ
        
        // Test đếm xuống
        sel = 0;
        #180;
        
        // Test chuyển chế độ
        sel = 1; #40;
        sel = 0; #40;
        
        $finish;
    end
    
    initial begin
        $monitor("Time = %0t, Mode = %s, Out = %b (%0d)",
                $time,
                sel ? "UP" : "DOWN",
                out, out);
    end
endmodule