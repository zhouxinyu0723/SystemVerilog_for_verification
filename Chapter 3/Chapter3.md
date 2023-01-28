### 1. Create the SystemVerilog code with the following requirements:
#### a. Create a 512 element integer array
```
integer my_array[512];
```
#### b. Create a 9-bit address variable to index into the array
```
bit [8:0] my_address;
```
#### c. Initialize the last location in the array to 5
```
my_array[$size(my_array)] = 5;
```
#### d. Call a task, my_task(), and pass the array and the address
```
my_task(my_array, my_address);
```
#### e. Create my_task() that takes two inputs: a constant 512-element integer array passed by reference, and a 9-bit address. The task calls a function, print_int(), and passes the array element indexed by the address, pre-decrementing the address.
```
function void my_task(ref integer arg_array[512], ref bit[8:0] arg_address)
    arg_address = arg_address - 1;
    $display("%d", arg_array[arg_address]);
endfunction
```
#### f. Create print_int() that prints out the simulation time and the value of the input. The function has no return value.
```
function void print_int(input integer arg_input);
    $display("%t", $time);
    $display("%d", arg_input);
endfunction
```
### 2. For the following SystemVerilog code, what is displayed if the task my_task2() is automatic?
```
Output:
new_address_1 = 21
new_address_2 = 20
```
### 3. For the same SystemVerilog code in Exercise 2, what is displayed if the task my_task2() is not automatic?
Two possibilites, if process 1 is excuted earlier:
```
Output:
new_address_1 = 20
new_address_2 = 20
```
if process 2 is excuted earlier:
```
Output:
new_address_1 = 21
new_address_2 = 21
```
### 4. Create the SystemVerilog code to specify that the time should be printed in ps (picoseconds), display 2 digits to the right of the decimal point, and use as few characters as possible
```
$timeformat(-12, 2, "ps", 0);
```