### 1.

Three layered test bench should be created.
The signal and command layer contains a driver which provides the clock signal, reset and other control signals and a monitor which read the output of the DUT.
The functional layer contains a agent which can carry out the following commands: 
add A and B
sub A and B
inverse A
reduction Or B
reset
Test layer generate randomly the commands and send it to the agent.

### 2.

Advantages: 
Errors are very easy to target.
Test can run very fast.

Divantages:
The errors in interconnection cannot be found
Testbench cound be very completed in order to simulate the surrounding of the block.

### 3.

Advantages:
Testbench cound be simple.
Erros in the interconnection can be found.

Disadvantages:
Errors are difficult to target.
Test is slow.

### 4.

Advantage:
Can get first running version very fast.

Disadvantage:
Creating new test case is very time consuming.
Coverage is difficult to increase.

### 5

Advantage:
Creating new test case is almost automated.
Code can be reused in new projects.

Disadvantage:
The first running version is a big project.