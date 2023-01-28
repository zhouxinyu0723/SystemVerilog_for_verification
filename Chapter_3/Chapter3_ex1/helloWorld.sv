/* verilator lint_off UNUSEDSIGNAL */
module helloWorld();
    integer my_array[512];
    bit [8:0] my_address=0;
    initial begin
        my_array[$size(my_array)-1] = 5;
        my_task(my_array, my_address);
        print_int(20);
        $finish;
    end
endmodule


function void my_task(ref integer arg_array[512], ref bit[8:0] arg_address);
    arg_address = arg_address - 1;
    $display("%d", arg_address);
    $display("%d", arg_array[arg_address]);
endfunction

function void print_int(input integer arg_input);
    $display("%t", $time);
    $display("%0d", arg_input);
endfunction
