module md4_top #(
    parameter PWD_SIZE     = 5,
    parameter EXP_PWD_SIZE = 80
)(
    input  wire                 clk_i,
    input  wire                 rst_n_i,
    input  wire                 en,

    input  wire                 md4_pwd_gen_finish,
    input  wire [7*PWD_SIZE-1:0] data_i,
    input  wire                 valid_i,

    output reg  [7*PWD_SIZE-1:0] data_o,
    output reg  [127:0]          hash_o,

    output wire                 md4_gen_finish,
    output reg                  valid_o
);

    localparam integer NUM_PES = 48;


    wire [ (NUM_PES+1)*7*PWD_SIZE-1 : 0 ] data_pipe;
    wire [ NUM_PES : 0 ] gen_pipe;
    wire [ NUM_PES : 0 ] vld_pipe;

    wire [ (NUM_PES+1)*32-1 : 0 ] A_pipe;
    wire [ (NUM_PES+1)*32-1 : 0 ] B_pipe;
    wire [ (NUM_PES+1)*32-1 : 0 ] C_pipe;
    wire [ (NUM_PES+1)*32-1 : 0 ] D_pipe;


    localparam integer DW = 7*PWD_SIZE;

    assign data_pipe[DW-1:0] = data_i;
    assign gen_pipe[0]       = md4_pwd_gen_finish;
    assign vld_pipe[0]       = valid_i;


    assign A_pipe[31:0] = 32'h67452301;
    assign B_pipe[31:0] = 32'hefcdab89;
    assign C_pipe[31:0] = 32'h98badcfe;
    assign D_pipe[31:0] = 32'h10325476;


    genvar i;
    generate
        for (i = 0; i < NUM_PES; i = i + 1) begin : pe_gen
            wire [DW-1:0] data_i_s;
            wire [DW-1:0] data_o_s;

            wire          gen_i_s;
            wire          gen_o_s;

            wire          vld_i_s;
            wire          vld_o_s;

            wire [31:0]   Ai_s, Bi_s, Ci_s, Di_s;
            wire [31:0]   Ao_s, Bo_s, Co_s, Do_s;

            assign data_i_s = data_pipe[(i+1)*DW-1 -: DW];
            assign gen_i_s  = gen_pipe[i];
            assign vld_i_s  = vld_pipe[i];

            assign Ai_s = A_pipe[(i+1)*32-1 -: 32];
            assign Bi_s = B_pipe[(i+1)*32-1 -: 32];
            assign Ci_s = C_pipe[(i+1)*32-1 -: 32];
            assign Di_s = D_pipe[(i+1)*32-1 -: 32];

            md4_PE #(
                .PWD_SIZE(PWD_SIZE)
            ) pe_inst (
                .clk_i(clk_i),
                .rst_n_i(rst_n_i),
                .en(en),

                .data_i(data_i_s),
                .valid_i(vld_i_s),

                .gen_pipeline_i(gen_i_s),
                .gen_pipeline_o(gen_o_s),
                .round_i(i[5:0]),

                .state_A_i(Ai_s),
                .state_B_i(Bi_s),
                .state_C_i(Ci_s),
                .state_D_i(Di_s),

                .data_o(data_o_s),
                .valid_o(vld_o_s),

                .state_A_o(Ao_s),
                .state_B_o(Bo_s),
                .state_C_o(Co_s),
                .state_D_o(Do_s)
            );

            assign data_pipe[(i+2)*DW-1 -: DW] = data_o_s;
            assign gen_pipe[i+1]               = gen_o_s;
            assign vld_pipe[i+1]               = vld_o_s;

            assign A_pipe[(i+2)*32-1 -: 32] = Ao_s;
            assign B_pipe[(i+2)*32-1 -: 32] = Bo_s;
            assign C_pipe[(i+2)*32-1 -: 32] = Co_s;
            assign D_pipe[(i+2)*32-1 -: 32] = Do_s;
        end
    endgenerate


    wire [31:0] A48 = A_pipe[(NUM_PES+1)*32-1 -: 32];
    wire [31:0] B48 = B_pipe[(NUM_PES+1)*32-1 -: 32];
    wire [31:0] C48 = C_pipe[(NUM_PES+1)*32-1 -: 32];
    wire [31:0] D48 = D_pipe[(NUM_PES+1)*32-1 -: 32];

    wire [31:0] A = A48 + 32'h67452301;
    wire [31:0] B = B48 + 32'hefcdab89;
    wire [31:0] C = C48 + 32'h98badcfe;
    wire [31:0] D = D48 + 32'h10325476;

    assign md4_gen_finish = gen_pipe[NUM_PES];


    always @(posedge clk_i or negedge rst_n_i) begin
        if (!rst_n_i) begin
            hash_o  <= 128'd0;
            data_o  <= {DW{1'b0}};
            valid_o <= 1'b0;
        end else if (en) begin
            hash_o <= {
                A[7:0],  A[15:8],  A[23:16],  A[31:24],
                B[7:0],  B[15:8],  B[23:16],  B[31:24],
                C[7:0],  C[15:8],  C[23:16],  C[31:24],
                D[7:0],  D[15:8],  D[23:16],  D[31:24]
            };
            data_o  <= data_pipe[(NUM_PES+1)*DW-1 -: DW];
            valid_o <= vld_pipe[NUM_PES];
        end
    end

endmodule
