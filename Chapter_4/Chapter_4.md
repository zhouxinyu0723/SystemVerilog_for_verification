### 1. Design an interface and testbench for the ARM Advanced High-performance Bus (AHB). You are provided a bus master as verification IP that can initiate AHB transactions. You are testing a slave design. The testbench instantiates the interface, slave, and master. Your interface will display an error if the transaction type is not IDLE or NONSEQ on the negative edge of HCLK. The AHB signals are described in Table 4.2.
```
interface AHB(input bit clk);
    logic [20:0] addr;
    logic write;
    logic [1:0] trans;
    logic [7:0] wdata;
    logic [7:0] rdata;

    modport MASTER(input clk, output addr, write, trans, wdata, input rdata);

    modport SLAVE(input clk, addr, write, trans, wdata, output rdata);

    property trans_is_enum;
        @(negedge clk) disable iff (rst)
        trans == 2'b00 or 2'b10
    endproperty
    assert_trans_is_enum: asser property (trans_is_enum) else $error("Trans should be either 2'b00. or 2'b10");

endinterface
```
### 2. For the following interface, add the following code.
```
interface my_if (input bit clk);
    bit wire;
    bit [15:0] data_in;
    bit [7:0] address;
    logic [15:0] data_out;
endinterface
```
#### a. A clocking block that is sensitive to the negative edge of the clock, and all I/O that are synchronous to the clock.
Consider the DUT as a memory.
```
interface my_if (input bit clk);
    bit wire;
    bit [15:0] data_in;
    bit [7:0] address;
    logic [15:0] data_out;
    clocking cb @ (posedge);
        input write, data_in, address;
        output data_out;
    endclocking
endinterface
```
#### b. A modport for the testbench called master, and a modport for the DUT called slave
```
interface my_if (input bit clk);
    bit wire;
    bit [15:0] data_in;
    bit [7:0] address;
    logic [15:0] data_out;
    clocking cb @ (posedge);
        input write, data_in, address;
        output data_out;
    endclocking
    modport MASTER(input clk, output write, data_in, address, input data_out);
    modport SLAVE(input clk, output write, data_in, address, input data_out);
endinterface
```
#### c. Use the clocking block in the I/O list for the master modport
```
interface my_if (input bit clk);
    bit wire;
    bit [15:0] data_in;
    bit [7:0] address;
    logic [15:0] data_out;
    clocking cb @ (posedge);
        input write, data_in, address;
        output data_out;
    endclocking
    modport MASTER(clocking cb);
    modport SLAVE(input clk, output write, data_in, address, input data_out);
endinterface
```