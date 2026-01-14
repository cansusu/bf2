`timescale 1ns/1ps

module tb_multi_cores_top;

    localparam PWD_SIZE      = 5;
    localparam EXP_PWD_SIZE  = 80;
    localparam NUM_CORES     = 16;
    localparam BRAM_DEPTH    = 1024;


    reg         clk_i;
    reg         rst_n;
    reg         start_i;
    reg         host_ready;
    reg [31:0]  prog_data_i;
    wire        prog_done_o;
    wire [31:0] bram_addrb;
    wire [127:0] bram_dinb;
    wire [15:0] bram_web;
    wire [31:0] write_count;
    reg  [3:0]  number_of_hashes;

    multi_cores_top #(
        .PWD_SIZE(PWD_SIZE),
        .EXP_PWD_SIZE(EXP_PWD_SIZE),
        .NUM_CORES(NUM_CORES),
        .BRAM_DEPTH(BRAM_DEPTH)
    ) dut (
        .clk_i(clk_i),
        .rst_n(rst_n),
        .start_i(start_i),
        .host_ready(host_ready),
        .prog_data_i(prog_data_i),
        .number_of_hashes(number_of_hashes),
        .prog_done_o(prog_done_o),
        .bram_addrb(bram_addrb),
        .bram_dinb(bram_dinb),
        .bram_web(bram_web),
        .write_count(write_count)
    );

    always #5 clk_i = ~clk_i;

    reg [31:0] bloom_msgs [0:2047];


    task program_bloom_filter;
        integer addr_idx;
        begin
            host_ready  = 0;     
            prog_data_i = 32'h0;
            repeat(2) @(posedge clk_i);

            $display("[%0t] Starting bloom filter programming...", $time);

            for (addr_idx = 0; addr_idx < 2048; addr_idx = addr_idx + 1) begin
                prog_data_i = bloom_msgs[addr_idx];
                @(posedge clk_i);
                if ((addr_idx + 1) % 8 == 0)
                    $display("[%0t] Programmed %0d/2048 messages", $time, addr_idx + 1);
            end

            wait(prog_done_o == 1'b1);
            repeat(5) @(posedge clk_i);
            $display("[%0t] Bloom filter programming complete", $time);
        end
    endtask

    task start_operation;
        input integer duration_cycles;
        begin
            host_ready = 1;
            start_i    = 0;
            $display("[%0t] Starting operation for %0d cycles...", $time, duration_cycles);
            repeat(duration_cycles) @(posedge clk_i);
            //start_i    = 1;
            $display("[%0t] Operation stopped", $time);
        end
    endtask

    task pulse_host_ready_low_1cy;
        begin
            $display("[%0t] Pulsing host_ready low for 1 cycle...", $time);
            host_ready = 0;
            repeat(5) @(posedge clk_i);
            
            $display("[%0t] host_ready pulse done", $time);
        end
    endtask

    task one_full_run;
        input integer op_cycles;
        begin
            program_bloom_filter();
            start_operation(op_cycles);
        end
    endtask
    
    initial begin
        $readmemh("bloom_msgs.mem", bloom_msgs);
        $display("[%0t] Loaded bloom_msgs.mem into bloom_msgs[0:2047]", $time);
    end

    initial begin
        clk_i        = 0;
        rst_n        = 0;
        start_i      = 0;
        host_ready   = 0;
        prog_data_i  = 0;
        number_of_hashes = 4;

        repeat(10) @(posedge clk_i);
        rst_n = 1;
        $display("[%0t] Reset deasserted", $time);

        one_full_run(100);

        repeat(50000) @(posedge clk_i);


        pulse_host_ready_low_1cy();

        prog_data_i = 32'h0;
        repeat(2) @(posedge clk_i);

        one_full_run(100);

        repeat(50) @(posedge clk_i);
        $display("[%0t] Simulation complete", $time);
        $finish;
    end

endmodule
