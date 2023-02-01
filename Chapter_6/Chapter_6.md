### 1. Write the SystemVerilog code for the following items.
#### a. Create a class `Exercise1` containing two random variables, 8-bit `data` and 4-bit `address`. Create a constraint block that keeps `address` to 3 or 4.
```
class Exercise1;
    rand [7:0] data;
    rand [3:0] address;
    constraint{
        address inside {3,4};
    }
endclass
```
#### b. In an initial block, construct an Exercise1 object and randomize it. Check the status from randomization.
```
module test;
    initial begin
        Exercise1 ex = new();
        if(!ex.randomize())
            $finish;
        $finish;
    end
endmodule
```
### 2. Modify the solution for Exercise 1 to create a new class Exercise2 so that:
#### a. data is always equal to 5
#### b. The probability of address==0 is 10%
#### c. The probability of address being between [1:14] is 80%
#### d. The probability of address==15 is 10%
```
class Exercise2;
    rand [7:0] data;
    rand [3:0] address;
    constraint{
        address dist {0:/10, [1:14]:/80, 15:/10};
        data == 5;
    }
endclass
```
### 3. Using the solution to either Exercise 1 or 2, demonstrate its usage by generating 20 new data and address values and check for success from the constraint solver.
```
initial begin
    repeat(20) begin
        Exercise1 ex = new();
        assert ex.randomize() else $fatal(0, "Exercise1 randomize failed");
        $display("data: %d, address %d", ex.data, ex.address);
    end
end
```
### 4. Create a testbench that randomizes the Exercise2 class 1000 times.
#### a. Count the number of times each address value occurs and print the results in a histogram. Do you see an exact 10% / 80% / 10% distribution? Why or why not?
#### b. Run the simulation with 3 different random seeds, creating histograms, and then comment on the results. Here is how to run a simulation with the seed 42.
```
VCS: > simv +ntb_random_seed=42
IUS: > irun exercise4.sv −svseed 42
Questa: > vsim −sv_seed 42
```
`Not answered`
### 5. For the code in Sample 6.4, describe the constraints on the len, dst, and src variables.
```
len should be larger than 0 and smaller than 1000
dst should between CONGEST_ADDR-10 AND CONGET_ADDR+10 (including)
src is exactly CONGEST_ADDR 
```
### 6. Complete Table 6.9 below for the following constraints.
```
class MemTrans;
    rand bit x;
    rand bit [1:0] y;
    constraint c_xy{
        y inside {[x:3]};
        solve x before y;
    }
endclass
```
### 7. For the following class
```
class MemTrans;
    rand bit rw;
    rand bit [7:0] data_in;
    rand bit [3:0] address;
endclass
```
### , create:
#### a. A constraint that limits read transaction addresses to the range 0 to 7, inclusive.
```
constraint c{
    (rw == 0) -> address inside {[0:7]};
}
```
#### b. Write behavioral code to turn off the above constraint. Construct and randomize a MemTrans object with an in-line constraint that limits read transaction addresses to the range 0 to 8, inclusive. Test that the in-line constraint is working 
```
initial begin
    MemTrans memtrans = new();
    memtrans.c.constraint_mode(0);
    memtrans.randomize() with {(rw == 0) -> address inside {[0:8]};}

end
```
### 8. Create a class for a graphics image that is 10x10 pixels. The value for each pixel can be randomized to black or white. Randomly generate an image that is, on average, 20% white. Print the image and report the number of pixels of each type.
```
class Image
    bit [9:0][9:0] pixels;
    function void pre_randomize();
        foreach(pixels[i, j])
            pixels[i][j] = bit'($urandom(1));
    endfunction
```
Answer from internet
```
    typedef enum bit {BLACK, WHITE} colors_t;
    class Screen;
        rand colors_pixels [10][10];
        constraint colors_c {
            foreach (pixels[i,j])
                pixels[i][j] dist {BLACK:=90 WIHTE:=10};
        }
```
### 9. Create a class, StimData, containing an array of integer samples. Randomize the size and contents of the array, constraining the size to be between 1 and 1000. Test the constraint by generating 20 transactions and reporting the size.
```
class StimData;
    rand int my_array[];
    constraint{
        my_array.size() inside {[1: 1000]};
    }

    function StimData copy();
        copy = new();
        copy.my_array = this.my_array;
    endfunction
endclass

initial begin
    repeat(20) begin
        StimData stimData = new();
        stimData.randomize();
        $display("%d", stimData.size());
    end
end
```
### 10. Expand the Transaction class below so back-to-back transactions of the same type do not have the same address. Test the constraint by generating 20 transactions.
In class Transaction, add line
```
bit [31:0] old_addr;
```
In function void post_randomize, add
```
    old_addr = addr;
```
in constraint, add line
```
(old_rw == rw) -> (old_addr != addr);
```
### 11. Expand the RandTransaction class below so back-to-back transactions of the same type do not have the same address. Test the constraint by generating 20 transactions.
In the constraint add
```
foreach (trans_array[i]) begin
    if ((i>0) && (trans_array[i-1].rw == trans_array[i].rw))
        trans_array[i-1].addr != trans_array[i-1].addr;
end
```