module helloWorld();
    byte my_queue[$] = {2, -1, 127};
    int tq[$];
    initial begin
        foreach(my_queue[i])
            $display("%d", my_queue[i]);
        $display("%d", my_queue.sum());
        tq = my_queue.find_index with (item<0);
        $display("%d", tq[0]);
        $display("%d", my_queue.max());
        $display("%d", my_queue.min());
        my_queue.sort();
        foreach(my_queue[i])
            $display("%d", my_queue[i]);
        $display("Hello World.");
        $finish;
    end
endmodule
