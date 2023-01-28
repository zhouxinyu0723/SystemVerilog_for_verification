module helloWorld();
    bit[23:0] my_ass [bit[19:0]];
    bit[19:0] ISR = 20'b10000;
    initial begin
        my_ass[20'h000] = 24'hA50400;
        my_ass[20'h400] = 24'h123456;
        my_ass[20'h401] = 24'h789ABC;
        my_ass[ISR] = 24'h0F1E2D;
        $display("Hello World.");
        $display("%h",my_ass[ISR]);
        $finish;
    end
endmodule
