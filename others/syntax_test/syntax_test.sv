module syntax_test();
    logic my_array1[5][32];
    bit [4:0][31:0] my_array2 = '0;
    int my_queue[$] = {-2,1,127}, max_q[$], min_q[$], pos_ind[$];


    typedef bit [6:0] my_7bits;
    struct packed {my_7bits header, cmd, data, crc;} my_struct_ins = '0;
    
    initial begin
        $display("Hello World.");
        $display("chapter 2, 5.b");
        my_array1[4][31] = 1'b1;    
        $display("%p",my_array1);
        
        
        $display("chapter 2, 5.b");
        my_array2[3] = 32'b1;
        
        $display("%b",my_array2);
        $display("%b",32'b1);

        $display("chapter 2, 8.c");
        $display("sum is %0d", my_queue.sum());
        
        max_q = my_queue.max();
        $display("max is %0d", max_q[0]);
        min_q = my_queue.min();
        $display("min is %0d", min_q[0]);
        $display("index of negative is %p", my_queue.find_index with (item<0));
        pos_ind = my_queue.find_index with (item > 0);
        $display("The following is the positive values in the queue");
        foreach(pos_ind[i]) begin
            $display("%0d",   my_queue[pos_ind[i]]   );
        end
        $display("The following is the reverse of the sorted queue.");
        my_queue.reverse();
        foreach(my_queue[i]) begin
            $display("%0d",   my_queue[i]   );
        end

        $display("chapter 2 9");
        my_struct_ins.header = 7'h5A;
        $display("%p", my_struct_ins);
        $finish;
    end
endmodule
