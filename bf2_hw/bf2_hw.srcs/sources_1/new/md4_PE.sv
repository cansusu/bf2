module md4_PE #(
    parameter PWD_SIZE = 3
)(
    input  wire                 clk_i,
    input  wire                 rst_n_i,
    input  wire                 en,

    input  wire [7*PWD_SIZE-1:0] data_i,
    input  wire                 valid_i,
    input  wire                 gen_pipeline_i,
    output reg                  gen_pipeline_o,

    input  wire [5:0]           round_i,

    input  wire [31:0]          state_A_i,
    input  wire [31:0]          state_B_i,
    input  wire [31:0]          state_C_i,
    input  wire [31:0]          state_D_i,

    output reg  [7*PWD_SIZE-1:0] data_o,
    output reg                  valid_o,

    output reg  [31:0]          state_A_o,
    output reg  [31:0]          state_B_o,
    output reg  [31:0]          state_C_o,
    output reg  [31:0]          state_D_o
);

    localparam integer DW = 7*PWD_SIZE;
    localparam integer EXPW = 16*PWD_SIZE;
    localparam integer PAD_ZEROS = 448 - EXPW - 1;

    localparam [7:0] MSG_LEN = PWD_SIZE * 16;

    // Expand password into 16-bit chunks: {0, 7-bit char, 8'b0}
    wire [EXPW-1:0] expanded_password;

    genvar k;
    generate
        for (k = 0; k < PWD_SIZE; k = k + 1) begin : EXPAND
            assign expanded_password[k*16 +: 16] = {1'b0, data_i[k*7 +: 7], 8'b0};
        end
    endgenerate

    // padded_message[447:0] = {expanded_password at top, 1'b1, zeros}
    wire [447:0] padded_message;
    generate
        if (PAD_ZEROS > 0) begin : PADN
            assign padded_message = {expanded_password, 1'b1, {PAD_ZEROS{1'b0}}};
        end else begin : PAD0
            assign padded_message = {expanded_password, 1'b1};
        end
    endgenerate

    // message = {padded_message, msg_length, 56'd0}
    wire [511:0] message;
    assign message = {padded_message, MSG_LEN, 56'd0};

    wire [16*32-1:0] X_bus;
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : XWORDS
            wire [31:0] w = message[i*32 +: 32];
            wire [31:0] w_swapped = {w[7:0], w[15:8], w[23:16], w[31:24]};
            assign X_bus[(15-i)*32 +: 32] = w_swapped;
        end
    endgenerate


    reg [31:0] function_result;
    reg [31:0] K;
    reg [4:0]  shift_amount;
    reg [3:0]  data_block;

    always @* begin
        shift_amount = 5'd0;
        data_block   = 4'd0;

        case (round_i[5:4])
            2'b00: begin // Round 1
                case (round_i[1:0])
                    2'b00: shift_amount = 5'd3;
                    2'b01: shift_amount = 5'd7;
                    2'b10: shift_amount = 5'd11;
                    default: shift_amount = 5'd19;
                endcase
                data_block = round_i[3:0];
            end

            2'b01: begin // Round 2
                case (round_i[1:0])
                    2'b00: shift_amount = 5'd3;
                    2'b01: shift_amount = 5'd5;
                    2'b10: shift_amount = 5'd9;
                    default: shift_amount = 5'd13;
                endcase
                data_block = {round_i[1], round_i[0], round_i[3], round_i[2]};
            end

            2'b10: begin // Round 3
                case (round_i[1:0])
                    2'b00: shift_amount = 5'd3;
                    2'b01: shift_amount = 5'd9;
                    2'b10: shift_amount = 5'd11;
                    default: shift_amount = 5'd15;
                endcase
                data_block = {round_i[0], round_i[1], round_i[2], round_i[3]};
            end
        endcase
    end

    always @* begin
        function_result = 32'h0;
        K = 32'h0;

        case (round_i[5:4])
            2'b00: begin
                function_result = (state_B_i & state_C_i) | (~state_B_i & state_D_i);
                K = 32'h00000000;
            end
            2'b01: begin
                function_result = (state_B_i & state_C_i) | (state_B_i & state_D_i) | (state_C_i & state_D_i);
                K = 32'h5A827999;
            end
            2'b10: begin
                function_result = state_B_i ^ state_C_i ^ state_D_i;
                K = 32'h6ED9EBA1;
            end
        endcase
    end

    wire [31:0] X_sel = X_bus[data_block*32 +: 32];
    
    wire [31:0] sum1 = state_A_i + function_result;
    wire [31:0] sum2 = X_sel + K;
    wire [31:0] temp = sum1 + sum2;

    wire [31:0] rotl =
        (shift_amount == 5'd0) ? temp :
        ((temp << shift_amount) | (temp >> (32 - shift_amount)));


    always @(posedge clk_i or negedge rst_n_i) begin
        if (!rst_n_i) begin
            state_A_o  <= 0;
            state_B_o  <= 0;
            state_C_o  <= 0;
            state_D_o  <= 0;
            data_o     <= 0;
            gen_pipeline_o  <= 0;
            valid_o  <= 0;
        end else if (en) begin
            state_A_o      <= state_D_i;
            state_B_o      <= rotl;
            state_C_o      <= state_B_i;
            state_D_o      <= state_C_i;

            data_o         <= data_i;
            gen_pipeline_o <= gen_pipeline_i;
            valid_o        <= valid_i;
        end
    end

endmodule
