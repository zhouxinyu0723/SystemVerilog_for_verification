## Note
bit, byte, int, shortint, longint are 2-state type
reg, wire, logic, integer are 4-state type

### 1. Given the following code sample:

```
byte my_byte;
integer my_integer;
int my_int;
bit [15:0] my_bit;
shortint my_short_int1;
shortint my_short_int2;

my_integer = 32’b000_1111_xxxx_zzzz;
my_int = my_integer;
my_bit = 16’h8000;
my_short_int1= my_bit;
my_short_int2 = my_short_int1-1;

```
#### a. what is the range of values `my_byte` can take?
-128 ~ 127 because it is signed type.
#### b. what is the value of `my_int` in hex?
32'h00000F00
because of int is 2-state
#### c. what is the value of 'my_bit' in demical?
32768
#### d. what is the value of 'my_short_int1' in demical?
-32768
#### e. what is the value of 'my_short_int2' in demical?
32767

### 2. Given the following code sample:
```
bit [7:0] my_mem [3];
logic [3:0] my_logicmem [4];
logic [3:0] my_logic;
my_mem = '{default:8'hA5};
my_logicmem = '{0,1,2,3};
my_logic = 4’hF;
```
evaluate

a. `my_mem[2] = my_logicmem[4]`;

my_mem[2] will becomes 8'h00
Because 4 is out of boundary and right hand side is 4'hx
but left hand side is 2-state, so it is converted to 8'h00

b. `my_logic = my_logicmem[4];`

my_logic will becomes 4'hx
Because 4 is out of boundary and right hand side is 4'hx

c. my_logicmem[3] = my_mem[3];

my_logicmem[3] becomes 4'h0
Because right hand side is 0

d. my_mem[3] = my_logic;

`my_mem will not change`

e. my_logic = my_logicmem[1];

4'h1

f. my_logic = my_mem[1];

4'h5

g. my_logic = my_logicmem[my_logicmem[4]];

x

### 3. Write the SystemVerilog code to:
#### a. Declare a 2-state arry, my_arry, that holds four 12-bit values:
```
bit [11:0] my_array [4];
```
#### b.initialize my_arrayso that:
```
my_array[0] = 12’h012
my_array[1] = 12’h345
my_array[2] = 12’h678
my_array[3] = 12’h9AB;
```
```
bit [11:0] my_array [4] = '{12’h012, 12’h345, 12’h678, 12’h9ab};
```
#### c. Traverse my_arrayand print out bits [5:4] of each 12-bit elementa.Using a for loopb.Using a foreach loop
```
for (int i= 0;  i<$size(my_array); i++)
    $display("my_array[%0d]=12'b%b", i, my_array[i][5:4])
```
```
foreach(my_array[i])
    $display("my_array[%0d]=12'b%b", i, my_array[i][5:4])
```

### 4. Declare a 5 by 31 multi-dimensional unpacked array, my_array1. Each element of the unpacked array holds a 2-state value.
```
logic my_array1[5][31];
```
#### a. Which of the following assignment sattements are legal and not out of bounds
```
my_array1[4][30] = 1'b1;
```
legal
```
my_array1[29][4] = 1'b1
```
`legal but out of boundary`
```
my_array1[4] = 31'b1;
```
`Illegal !! right hand side is of a packed type, cannot assign to an unpacked type`

#### b. Draw `my_array2` after the assignment statements complete.
There are 5*31 words used to store the array.
The first bit of the last word is 1;

5. Declare a 5 by 31 multi-dimensional packed array, my_array2.  Each element of the packed array holds a 2-state value
```
bit [4:0][30:0] my_array2;
```

a. Which of the following assignment statements are legal and not out of bounds?
```
my_array2[4][30] = 1'b1;
```
legal
```
my_array2[29][4] = 1'b1;
```
`legal but out of boundary`
```
my_array2[3] = 32'b1;
```
`legal and the last bit is assigned with 1'b1

### 6. Given the following code, determine what will be displayed

```
module test;
    string street[$];

    initial begin
        street= {"Tejon", "Bijou", "Boulder"};
        $display("Street[0] = %s", street[0]);
        street.insert(2, "Platte");
        $display("Street[2] = %s", street[2]);
        street.push_front("St. Vrain");
        $display("Street[2] = %s", street[2]);
        $display("pop_back = %s", street.pop_back);
        $display("street.size = %0d", street.size);
    end
endendmodule // test
```
Street[0] = Tejon
Street[2] = Platte
Street[2] = Bijou
pop_back = Boulder
street.size = 4

### 7. Write code for the following problems.
#### a. Create memory using an associative array for a processor with a word width of 24 bits and an address space of 2^20 words. Assume the PC starts at address 0 at reset. Program space starts at 0´400. The ISR is at the maximum address.
```
bit[24:0] processor_mem [bit[30:0]];
```
b. Fill the memory with the following instructions:
```
24'hA50400; // Jump to location 0x400 for the main code
* 24'h123456; // Instruction 1 located at location 0´400
* c // Instruction 2 located at location 0´401
* 24'h0F1E2D;
```
```
processor_mem[0] = 24'hA50400;
processor_mem[400] = 24'h123456;
processor_mem[401] = 24'h789ABC;
processor_mem[ISR] = 24'h0F1E2D;
```

### 8. Create the SystemVerilog code for the following requirements
#### a. Create a 3-byte queue and initialize it with 2, −1, and 127
```
int my_queue[$] = {2, -1, 127}
```
#### b. Print out the sum of the queue in the decimal radix
```
$display("The sum is %0d.", my_queue.sum());
```

#### c. Print out the min and max values in the queue
```
$display("The sum is %p.", my_queue.max());
$display("The sum is %p.", my_queue.min();
```

#### d. Sort all values in the queue and print out the resulting queue
```
my_queue.sort()
$display("The sum is %p.", my_queue);
```
#### e. Print out the index of any negative values in the queue
```
tq=my_queuefind_index with (item < 0);
```

#### f. Print out the positive values in the queue
```
$display("The following is the positive values in the queue");
foreach(pos_ind[i]) begin
    $display("%0d",   my_queue[pos_ind[i]]   );
end
```

#### g. Reverse sort all values in the queue and print out the resulting queue
```
$display("The following is the reverse of the sorted queue.");
my_queue.reverse();
foreach(my_queue[i]) begin
    $display("%0d",   my_queue[i]   );
end
```

### 9. Define a user defined 7-bit type and encapsulate the fields of the following
packet in a structure using your new type. Lastly, assign the header to 7 ' h5A.
```
typedef bit [6:0] my_7bits;
struct packed {my_7bits header, cmd, data, crc} my_struct_ins;
my_struct_ins.header = 7'h5A;
```

### 10. Create the SystemVerilog code for the following requirements
#### a. Create a user-defined type, nibble, of 4 bits
typedef [3:0] bit nibble;
#### b. Create a real variable, r, and initialize it to 4.33
real r = 4.33;
#### c. Create a short int variable, i_pack
shortint i_pack;
#### d. Create an unpacked array, k, containing 4 elements of your user defined type nibble and initialize it to 4 ' h0, 4 ' hF, 4 ' hE, and 4 ' hD
nibble k [4]  = '{4'h0, 4'hF, 4'he, 4'hd}
#### e. Print out k
```
$display("%p", k)
```
#### f. Stream k into i_pack right to left on a bit basis and print it out
```
k = {<<{i_pack}}
```
#### g. Stream k into i_pack right to left on a nibble basis and print it out
i_pack = {<< nibble{k}}
#### h. Type convert real r into a nibble, assign it to k[0], and print out k
```
k[0] = nibble'(r)
$display("%p", k)
```

### 11. An ALU has the opcodes shown in Table 2.1.
Write a testbench that performs the following tasks.
#### a. Create an enumerated type of the opcodes: opcode_e
typedef enum {ADD, SUB, INVERT, REDUCTION} opcode_e;
#### b. Create a variable, opcode, of type opcode_e
opcode_e opcode;
#### c. Loop through all the values of variable opcode every 10ns
```
@always 10ns
do
    begin
    opcode = opcode.next;
    end
while(opcode ~= opcode.first);
```
#### d. Instantiate an ALU with one 2-bit input opcode
initial_value = ?
opcode = $cast(opcode, initial_value);