module test;
Exercise1 ex = new();
initial begin
    for(int i =0; i<10; i++) begin
        if(!bit'(ex.randomize()))
            $finish;
        else begin
            $display("%d, %d",ex.data, ex.address);
        end
    end
    $finish;
end
endmodule
