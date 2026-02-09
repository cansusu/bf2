module multi_cores_top #(
    parameter PWD_SIZE     = 5,
    parameter EXP_PWD_SIZE = 80,
    parameter NUM_CORES    = 16,
    parameter BRAM_DEPTH   = 1024
)(
    input  wire         clk_i,
    input  wire         rst_n,
    input  wire         start_i,
    input  wire         host_ready,
    input  wire [3:0]   number_of_hashes,  // 1-15 hashes

    input  wire [31:0]  prog_data_i,       // [31:16]=addr, [15:0]=data
    output reg          prog_done_o,       // programming complete signal

    // BRAM interface
    output wire [31:0]  bram_addrb,
    output wire [127:0] bram_dinb,
    output wire [15:0]  bram_web,
    output reg  [31:0]  write_count
);

    function integer clog2;
        input integer value;
        integer v;
        begin
            v = value - 1;
            clog2 = 0;
            while (v > 0) begin
                clog2 = clog2 + 1;
                v = v >> 1;
            end
        end
    endfunction

    wire [NUM_CORES-1:0] hash_match;
    wire                 pwd_gen_finish;
    wire [7*PWD_SIZE-1:0] captured_pwd;


    wire pipeline_enable = (~start_i) & prog_done_o & host_ready;


    assign bram_dinb = {
        pwd_gen_finish, 7'b0,
        48'b0,
        1'b0, captured_pwd[6:0],
        1'b0, captured_pwd[13:7],
        1'b0, captured_pwd[20:14],
        1'b0, captured_pwd[27:21],
        1'b0, captured_pwd[34:32], 4'b0,
        16'b0, hash_match[15:0]
    };

    reg gen_finish;
    wire bram_we_1b = ( ((|hash_match) | pwd_gen_finish) & (~start_i) ) & (~gen_finish);
    assign bram_web = {16{bram_we_1b}};


    // Bloom filter programming logic
    wire [15:0] gpio_addr = prog_data_i[31:16];
    wire [15:0] gpio_data = prog_data_i[15:0];

    reg  [8:0]  prog_word_idx;     // BRAM word index
    reg  [15:0] prev_gpio_addr;
    reg  [63:0] bram_word_buffer;
    reg         prog_active;

    wire data_valid = (gpio_addr != prev_gpio_addr) &&
                      (gpio_addr >= 16'd1) &&
                      (gpio_addr <= 16'd2048);

    wire [1:0] word_slot = gpio_addr[1:0] - 2'd1;

    always @(posedge clk_i) begin
        if (~rst_n) begin
            gen_finish <= 1'b0;
        end else begin
            gen_finish <= pwd_gen_finish;
        end
    end

    always @(posedge clk_i) begin
        if (~rst_n) begin
            prog_word_idx    <= 9'b111111111;
            prev_gpio_addr   <= 16'd0;
            bram_word_buffer <= 64'd0;
            prog_active      <= 1'b0;
            prog_done_o      <= 1'b0;
        end else begin
            prev_gpio_addr <= gpio_addr;
            prog_active <= 1'b0;

            if (data_valid) begin
                case (word_slot)
                    2'd0: bram_word_buffer[15:0]   <= gpio_data;
                    2'd1: bram_word_buffer[31:16]  <= gpio_data;
                    2'd2: bram_word_buffer[47:32]  <= gpio_data;
                    2'd3: bram_word_buffer[63:48]  <= gpio_data;
                    default: ; 
                endcase

                // Trigger write when we complete a 64-bit word
                if (gpio_addr[1:0] == 2'd0) begin
                    prog_active   <= 1'b1;
                    prog_word_idx <= prog_word_idx + 1'b1;

                    if (gpio_addr == 16'd2048) begin
                        prog_done_o <= 1'b1;
                    end
                end
            end
        end
    end

    wire [63:0] bf_word = bram_word_buffer;

    // Core 0 (captures pwd + finish)
    wire [14:0] c0_idx1,  c0_idx2,  c0_idx3,  c0_idx4,  c0_idx5;
    wire [14:0] c0_idx6,  c0_idx7,  c0_idx8,  c0_idx9,  c0_idx10;
    wire [14:0] c0_idx11, c0_idx12, c0_idx13, c0_idx14, c0_idx15;
    wire        c0_idx_valid;
    wire [127:0] hash_out_debug;

    hash_pipeline #(
        .PWD_SIZE(PWD_SIZE),
        .EXP_PWD_SIZE(EXP_PWD_SIZE)
    ) hash_pipeline_0 (
        .clk_i(clk_i),
        .en(pipeline_enable),
        .rst_n_i(rst_n),
        .start_i(pipeline_enable),
        .core_id(4'd0),
        .number_of_hashes(number_of_hashes),

        .hash_idx1 (c0_idx1),
        .hash_idx2 (c0_idx2),
        .hash_idx3 (c0_idx3),
        .hash_idx4 (c0_idx4),
        .hash_idx5 (c0_idx5),
        .hash_idx6 (c0_idx6),
        .hash_idx7 (c0_idx7),
        .hash_idx8 (c0_idx8),
        .hash_idx9 (c0_idx9),
        .hash_idx10(c0_idx10),
        .hash_idx11(c0_idx11),
        .hash_idx12(c0_idx12),
        .hash_idx13(c0_idx13),
        .hash_idx14(c0_idx14),
        .hash_idx15(c0_idx15),

        .bf_idx_valid_o(c0_idx_valid),
        .gen_finish(pwd_gen_finish),
        .data_o(captured_pwd),
        .hash_out(hash_out_debug)
    );

    bloom_bram_lookup #(
        .BF_BITS(32768),
        .BF_WORD_WIDTH(64)
    ) bf_0 (
        .clk_i(clk_i),
        .rst_n(rst_n),
        .en(pipeline_enable),
        .number_of_hashes(number_of_hashes),

        .idx1 (c0_idx1),
        .idx2 (c0_idx2),
        .idx3 (c0_idx3),
        .idx4 (c0_idx4),
        .idx5 (c0_idx5),
        .idx6 (c0_idx6),
        .idx7 (c0_idx7),
        .idx8 (c0_idx8),
        .idx9 (c0_idx9),
        .idx10(c0_idx10),
        .idx11(c0_idx11),
        .idx12(c0_idx12),
        .idx13(c0_idx13),
        .idx14(c0_idx14),
        .idx15(c0_idx15),

        .idx_valid(c0_idx_valid),
        .bf_bit_and_out_reg(hash_match[0]),
        .bf_valid(), 

        .load_i(prog_active),
        .load_addr_i(prog_word_idx),
        .load_data_i(bf_word)
    );

    // Remaining cores
    genvar i;
    generate
        for (i = 1; i < NUM_CORES; i = i + 1) begin : core_gen
            wire [14:0] idx1,  idx2,  idx3,  idx4,  idx5;
            wire [14:0] idx6,  idx7,  idx8,  idx9,  idx10;
            wire [14:0] idx11, idx12, idx13, idx14, idx15;
            wire        idx_valid;

            localparam [3:0] CORE_ID = i;

            hash_pipeline #(
                .PWD_SIZE(PWD_SIZE),
                .EXP_PWD_SIZE(EXP_PWD_SIZE)
            ) hash_pipeline_i (
                .clk_i(clk_i),
                .en(pipeline_enable),
                .rst_n_i(rst_n),
                .start_i(pipeline_enable),
                .core_id(CORE_ID),
                .number_of_hashes(number_of_hashes),

                .hash_idx1 (idx1),
                .hash_idx2 (idx2),
                .hash_idx3 (idx3),
                .hash_idx4 (idx4),
                .hash_idx5 (idx5),
                .hash_idx6 (idx6),
                .hash_idx7 (idx7),
                .hash_idx8 (idx8),
                .hash_idx9 (idx9),
                .hash_idx10(idx10),
                .hash_idx11(idx11),
                .hash_idx12(idx12),
                .hash_idx13(idx13),
                .hash_idx14(idx14),
                .hash_idx15(idx15),

                .bf_idx_valid_o(idx_valid),
                .gen_finish(),
                .data_o(),
                .hash_out()
            );

            bloom_bram_lookup #(
                .BF_BITS(32768),
                .BF_WORD_WIDTH(64)
            ) bf_i (
                .clk_i(clk_i),
                .rst_n(rst_n),
                .en(pipeline_enable),
                .number_of_hashes(number_of_hashes),

                .idx1 (idx1),
                .idx2 (idx2),
                .idx3 (idx3),
                .idx4 (idx4),
                .idx5 (idx5),
                .idx6 (idx6),
                .idx7 (idx7),
                .idx8 (idx8),
                .idx9 (idx9),
                .idx10(idx10),
                .idx11(idx11),
                .idx12(idx12),
                .idx13(idx13),
                .idx14(idx14),
                .idx15(idx15),

                .idx_valid(idx_valid),
                .bf_bit_and_out_reg(hash_match[i]),
                .bf_valid(), 

                .load_i(prog_active),
                .load_addr_i(prog_word_idx),
                .load_data_i(bf_word)
            );
        end
    endgenerate

    localparam integer WC_W = (BRAM_DEPTH <= 2) ? 1 : clog2(BRAM_DEPTH);
    localparam integer WA_W = ((BRAM_DEPTH*16) <= 2) ? 1 : clog2(BRAM_DEPTH*16);

    reg [WA_W-1:0] write_addr_s;
    reg [WC_W-1:0] write_count_s;

    assign bram_addrb = {{(32-WA_W){1'b0}}, write_addr_s};

    always @(posedge clk_i) begin
        if (~rst_n) begin
            write_addr_s  <= {WA_W{1'b0}};
            write_count_s <= {WC_W{1'b0}};
            write_count   <= 32'h0;
        end else if (bram_we_1b) begin
            if (write_count_s == (BRAM_DEPTH-1)) begin
                write_addr_s  <= {WA_W{1'b0}};
                write_count_s <= {WC_W{1'b0}};
                write_count   <= 32'h0;
            end else begin
                write_addr_s  <= write_addr_s + 16;
                write_count_s <= write_count_s + 1'b1;
                write_count   <= {{(32-WC_W){1'b0}}, (write_count_s + 1'b1)};
            end
        end
    end

endmodule
