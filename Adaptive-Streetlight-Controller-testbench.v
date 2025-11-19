 module tb_street_light_project;

    reg clk, rst, day, veh_detect;
    wire R, G, B;

    street_light_project uut(clk, rst, day, veh_detect, R, G, B);

    always #5 clk = ~clk;

    initial begin
        clk = 0; rst = 1; day = 1; veh_detect = 0;
        #20 rst = 0;

        #100 day = 0;
        #200 veh_detect = 1;
        #200 veh_detect = 0;
        #200 day = 1;

        #200 $finish;
    end

endmodule
