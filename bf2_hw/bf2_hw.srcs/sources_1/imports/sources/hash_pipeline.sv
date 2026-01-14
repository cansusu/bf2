module hash_pipeline #(
    parameter PWD_SIZE     = 5,
    parameter EXP_PWD_SIZE = 80
)(
    input  wire clk_i,
    input  wire rst_n_i,
    input  wire en,
    input  wire [3:0] number_of_hashes, 

    output reg [14:0] hash_idx1,
    output reg [14:0] hash_idx2,
    output reg [14:0] hash_idx3,
    output reg [14:0] hash_idx4,
    output reg [14:0] hash_idx5,
    output reg [14:0] hash_idx6,
    output reg [14:0] hash_idx7,
    output reg [14:0] hash_idx8,
    output reg [14:0] hash_idx9,
    output reg [14:0] hash_idx10,
    output reg [14:0] hash_idx11,
    output reg [14:0] hash_idx12,
    output reg [14:0] hash_idx13,
    output reg [14:0] hash_idx14,
    output reg [14:0] hash_idx15,

    output reg        bf_idx_valid_o,

    input  wire       start_i,
    input  wire [3:0] core_id,

    output reg       gen_finish,
    output reg [7*PWD_SIZE-1:0] data_o,
    output wire [127:0] hash_out
);

    wire                 pwd_gen_valid;
    wire                 pwd_gen_finish;
    wire [7*PWD_SIZE-1:0] password_out;
    wire [7*PWD_SIZE-1:0] md4_data_o;
    wire                 md4_valid_o;
    wire                 md4_gen_finish;


    pwd_generator #(
        .PWD_SIZE(PWD_SIZE)
    ) pwd_gen_inst (
        .clk_i(clk_i),
        .rst_n(rst_n_i),
        .en(en),
        .start_gen_i(start_i),
        .core_id(core_id),
        .valid_o(pwd_gen_valid),
        .gen_finish(pwd_gen_finish),
        .password_out(password_out)
    );


    md4_top #(
        .PWD_SIZE(PWD_SIZE),
        .EXP_PWD_SIZE(EXP_PWD_SIZE)
    ) md4_inst (
        .clk_i(clk_i),
        .rst_n_i(rst_n_i),
        .en(en & start_i),
        .md4_pwd_gen_finish(pwd_gen_finish),
        .data_i(password_out),
        .valid_i(pwd_gen_valid),
        .data_o(md4_data_o),
        .hash_o(hash_out),
        .md4_gen_finish(md4_gen_finish),
        .valid_o(md4_valid_o)
    );


    always @(posedge clk_i) begin
        if (~rst_n_i) begin
            hash_idx1       <= 15'd0;
            hash_idx2       <= 15'd0;
            hash_idx3       <= 15'd0;
            hash_idx4       <= 15'd0;
            hash_idx5       <= 15'd0;
            hash_idx6       <= 15'd0;
            hash_idx7       <= 15'd0;
            hash_idx8       <= 15'd0;
            hash_idx9       <= 15'd0;
            hash_idx10      <= 15'd0;
            hash_idx11      <= 15'd0;
            hash_idx12      <= 15'd0;
            hash_idx13      <= 15'd0;
            hash_idx14      <= 15'd0;
            hash_idx15      <= 15'd0;
            bf_idx_valid_o  <= 1'b0;
        end else if (en) begin
            hash_idx1  <= hash_out[14:0];
            hash_idx2  <= hash_out[24:10];
            hash_idx3  <= hash_out[34:20];
            hash_idx4  <= hash_out[44:30];
            hash_idx5  <= hash_out[54:40];
            hash_idx6  <= hash_out[64:50];
            hash_idx7  <= hash_out[74:60];
            hash_idx8  <= hash_out[84:70];
            hash_idx9  <= hash_out[94:80];
            hash_idx10 <= hash_out[104:90];
            hash_idx11 <= hash_out[114:100];
            hash_idx12 <= hash_out[124:110];
            hash_idx13 <= {hash_out[127:115], hash_out[1:0]};
            hash_idx14 <= {hash_out[126:114], hash_out[11:10]};
            hash_idx15 <= {hash_out[125:113], hash_out[21:20]};

            bf_idx_valid_o <= md4_valid_o;
        end
    end


    reg [7*PWD_SIZE-1:0] data_r1, data_r2, data_r3, data_r4, data_r5;
    reg gen_finish_r1, gen_finish_r2, gen_finish_r3, gen_finish_r4, gen_finish_r5;
    always @(posedge clk_i) begin
        if (~rst_n_i) begin
            data_r1 <= {7*PWD_SIZE{1'b0}};
            data_r2 <= {7*PWD_SIZE{1'b0}};
            data_r3 <= {7*PWD_SIZE{1'b0}};
            data_r4 <= {7*PWD_SIZE{1'b0}};
            data_r5 <= {7*PWD_SIZE{1'b0}};
            data_o  <= {7*PWD_SIZE{1'b0}};
            gen_finish      <= 1'b0;
            gen_finish_r1   <= 1'b0;
            gen_finish_r2   <= 1'b0;
            gen_finish_r3   <= 1'b0;
            gen_finish_r4   <= 1'b0;
            gen_finish_r5   <= 1'b0;
        end else if (en) begin
            data_r1 <= md4_data_o;
            data_r2 <= data_r1;
            data_r3 <= data_r2;
            data_r4 <= data_r3;
            data_r5 <= data_r4;
            data_o  <= data_r5;
            gen_finish_r1 <= md4_gen_finish;
            gen_finish_r2 <= gen_finish_r1;
            gen_finish_r3 <= gen_finish_r2;
            gen_finish_r4 <= gen_finish_r3;
            gen_finish_r5 <= gen_finish_r4;
            gen_finish    <= gen_finish_r5;
        end
    end

endmodule
