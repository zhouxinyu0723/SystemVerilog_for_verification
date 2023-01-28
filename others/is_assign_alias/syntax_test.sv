
`timescale 1ns/1ps

module syntax_test();
    wire trigger = '0;
    wire alias_of_trigger_or_not = '0;
    assign alias_of_trigger_or_not = trigger;
    initial begin
        $display("%b", trigger);
        $display("%b",     alias_of_trigger_or_not);
        #10 ;
        $display("%b", trigger);
    end
endmodule
