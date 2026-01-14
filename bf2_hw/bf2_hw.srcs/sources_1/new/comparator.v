module comparator(
    input        clk,
    input        rst_n,
    input  [31:0] write_count,     
    input  [31:0] read_count,      
    output wire   stall 
);

    assign stall = (write_count >= read_count + 1021) || (read_count - write_count == 2) ? 1'b1 : 1'b0;

endmodule