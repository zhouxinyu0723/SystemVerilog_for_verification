/* verilator lint_off UNUSEDSIGNAL */
class Exercise1;
    rand bit [7:0] data;
    rand bit [3:0] address;
    constraint c{
        address inside {3,4};
    }
endclass

