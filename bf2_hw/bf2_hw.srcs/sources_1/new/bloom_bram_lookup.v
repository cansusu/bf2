module bloom_bram_lookup #(
    parameter BF_BITS = 2048,
    parameter BF_WORD_WIDTH = 64
)(
    input  wire clk_i,
    input  wire rst_n,
    input  wire en,
    input  wire [3:0] number_of_hashes,  // 1-15
    input  wire [14:0] idx1,
    input  wire [14:0] idx2,
    input  wire [14:0] idx3,
    input  wire [14:0] idx4,
    input  wire [14:0] idx5,
    input  wire [14:0] idx6,
    input  wire [14:0] idx7,
    input  wire [14:0] idx8,
    input  wire [14:0] idx9,
    input  wire [14:0] idx10,
    input  wire [14:0] idx11,
    input  wire [14:0] idx12,
    input  wire [14:0] idx13,
    input  wire [14:0] idx14,
    input  wire [14:0] idx15,
    input  wire idx_valid,

    output reg  bf_bit_and_out_reg,   
    output reg  bf_valid,            
    

    input  wire load_i,
    input  wire [$clog2(BF_BITS/BF_WORD_WIDTH)-1:0] load_addr_i,
    input  wire [BF_WORD_WIDTH-1:0] load_data_i
);

    localparam DEPTH = BF_BITS / BF_WORD_WIDTH; 
    localparam ADDR_WIDTH = $clog2(DEPTH);

    (* ram_style = "block" *) reg [BF_WORD_WIDTH-1:0] mem [0:DEPTH-1];

    reg [ADDR_WIDTH-1:0] addr [0:14];
    reg [5:0] bitpos [0:14];

    reg [BF_WORD_WIDTH-1:0] word_r1 [0:14];
    reg [5:0] bitpos_r1 [0:14];
    reg idx_valid_reg;
    reg [3:0] num_hashes_r1;

    reg [BF_WORD_WIDTH-1:0] word_r2 [0:14];
    reg [5:0] bitpos_r2 [0:14];

    reg [14:0] bit_results;

    integer i;

    always @(posedge clk_i) begin
        if (!rst_n) begin
            // reset pipeline registers
            for (i = 0; i < 15; i = i + 1) begin
                addr[i]      <= 0;
                bitpos[i]    <= 0;
                word_r1[i]   <= 0;
                bitpos_r1[i] <= 0;
                word_r2[i]   <= 0;
                bitpos_r2[i] <= 0;
            end

            idx_valid_reg <= 0;
            num_hashes_r1 <= 0;
            bit_results <= 0;

            bf_bit_and_out_reg <= 0;
            bf_valid <= 0;

        end else begin

            // BRAM load
            if (load_i) begin
                mem[load_addr_i] <= load_data_i;
            end

            if (en) begin
                
                addr[0]   <= idx1[14:6];   bitpos[0]  <= idx1[5:0];
                addr[1]   <= idx2[14:6];   bitpos[1]  <= idx2[5:0];
                addr[2]   <= idx3[14:6];   bitpos[2]  <= idx3[5:0];
                addr[3]   <= idx4[14:6];   bitpos[3]  <= idx4[5:0];
                addr[4]   <= idx5[14:6];   bitpos[4]  <= idx5[5:0];
                addr[5]   <= idx6[14:6];   bitpos[5]  <= idx6[5:0];
                addr[6]   <= idx7[14:6];   bitpos[6]  <= idx7[5:0];
                addr[7]   <= idx8[14:6];   bitpos[7]  <= idx8[5:0];
                addr[8]   <= idx9[14:6];   bitpos[8]  <= idx9[5:0];
                addr[9]   <= idx10[14:6];  bitpos[9]  <= idx10[5:0];
                addr[10]  <= idx11[14:6];  bitpos[10] <= idx11[5:0];
                addr[11]  <= idx12[14:6];  bitpos[11] <= idx12[5:0];
                addr[12]  <= idx13[14:6];  bitpos[12] <= idx13[5:0];
                addr[13]  <= idx14[14:6];  bitpos[13] <= idx14[5:0];
                addr[14]  <= idx15[14:6];  bitpos[14] <= idx15[5:0];

                for (i = 0; i < 15; i = i + 1) begin
                    word_r1[i] <= mem[addr[i]];
                    
                    bitpos_r1[i] <= bitpos[i];
                end

                idx_valid_reg <= idx_valid;
                num_hashes_r1 <= number_of_hashes;

                for (i = 0; i < 15; i = i + 1) begin
                    word_r2[i] <= word_r1[i];
                    bitpos_r2[i] <= bitpos_r1[i];
                end

                bf_valid <= idx_valid_reg;

                if (idx_valid_reg) begin

                    for (i = 0; i < 15; i = i + 1) begin
                        bit_results[i] <= (word_r2[i] >> bitpos_r2[i]) & 1'b1;
                    end

                    case (num_hashes_r1)
                        4'd1:  bf_bit_and_out_reg <= bit_results[0];
                        4'd2:  bf_bit_and_out_reg <= &bit_results[1:0];
                        4'd3:  bf_bit_and_out_reg <= &bit_results[2:0];
                        4'd4:  bf_bit_and_out_reg <= &bit_results[3:0];
                        4'd5:  bf_bit_and_out_reg <= &bit_results[4:0];
                        4'd6:  bf_bit_and_out_reg <= &bit_results[5:0];
                        4'd7:  bf_bit_and_out_reg <= &bit_results[6:0];
                        4'd8:  bf_bit_and_out_reg <= &bit_results[7:0];
                        4'd9:  bf_bit_and_out_reg <= &bit_results[8:0];
                        4'd10: bf_bit_and_out_reg <= &bit_results[9:0];
                        4'd11: bf_bit_and_out_reg <= &bit_results[10:0];
                        4'd12: bf_bit_and_out_reg <= &bit_results[11:0];
                        4'd13: bf_bit_and_out_reg <= &bit_results[12:0];
                        4'd14: bf_bit_and_out_reg <= &bit_results[13:0];
                        4'd15: bf_bit_and_out_reg <= &bit_results[14:0];
                        default: bf_bit_and_out_reg <= 1'b0;
                    endcase
                end

            end
        end
    end
endmodule
