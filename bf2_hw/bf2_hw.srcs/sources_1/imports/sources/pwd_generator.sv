module pwd_generator #(
    parameter PWD_SIZE = 5
)(
    input  wire                  clk_i,
    input  wire                  rst_n,          
    input  wire                  en,
    input  wire                  start_gen_i,
    input  wire [3:0]            core_id,
    output reg                   valid_o,
    output reg                   gen_finish,
    output reg [7*PWD_SIZE-1:0]  password_out
);

    reg [6:0] count [0:PWD_SIZE-2];
    reg [2:0] count_mask;

    reg [1:0] state;
    localparam [1:0] IDLE = 2'd0,
                     GEN  = 2'd1,
                     DONE = 2'd2;

    reg [6:0] next_count [0:PWD_SIZE-2];
    reg [2:0] next_count_mask;

    integer i;
    integer j;


    always @* begin
        for (j = 0; j < PWD_SIZE-1; j = j + 1) begin
            next_count[j] = count[j];
        end
        next_count_mask = count_mask;

        if (state == GEN) begin
            reg carry;
            carry = 1'b1;

            if (carry) begin
                if (count[0] == 7'h7e) begin
                    next_count[0] = 7'h20;
                    carry = 1'b1;
                end else begin
                    next_count[0] = count[0] + 7'd1;
                    carry = 1'b0;
                end
            end

            for (j = 1; j < PWD_SIZE-1; j = j + 1) begin
                if (carry) begin
                    if (count[j] == 7'h7e) begin
                        next_count[j] = 7'h20;
                        carry = 1'b1;
                    end else begin
                        next_count[j] = count[j] + 7'd1;
                        carry = 1'b0;
                    end
                end else begin
                    next_count[j] = count[j];
                end
            end

            if (carry) begin
                next_count_mask = count_mask + 3'd1;
            end
        end
    end


    always @(posedge clk_i) begin
        if (~rst_n) begin
            state      <= IDLE;
            valid_o    <= 1'b0;
            gen_finish <= 1'b0;

            for (i = 0; i < PWD_SIZE-1; i = i + 1)
                count[i] <= 7'h20;

            count_mask   <= 3'b010;
            password_out <= {PWD_SIZE{7'h20}};
            password_out[(7*PWD_SIZE)-4 -: 4] <= core_id;

        end else if (en && start_gen_i) begin
            case (state)
                IDLE: begin
                    state      <= GEN;
                    valid_o    <= 1'b1;
                    gen_finish <= 1'b0;

                    for (i = 0; i < PWD_SIZE-1; i = i + 1)
                        count[i] <= 7'h20;

                    count_mask   <= 3'b010;
                    password_out <= {PWD_SIZE{7'h20}};
                    password_out[(7*PWD_SIZE)-4 -: 4] <= core_id;
                end

                GEN: begin
                    valid_o <= 1'b1;

                    for (i = 0; i < PWD_SIZE-1; i = i + 1)
                        count[i] <= next_count[i];

                    count_mask <= next_count_mask;

                    for (i = 0; i < PWD_SIZE-1; i = i + 1)
                        password_out[7*i +: 7] <= next_count[i];

                    password_out[7*PWD_SIZE-1 -: 3] <= next_count_mask;
                    password_out[(7*PWD_SIZE)-4 -: 4] <= core_id;

                    if (next_count_mask == 3'b000) begin
                        state      <= DONE;
                        gen_finish <= 1'b1; 
                    end
                end

                DONE: begin
                    valid_o <= 1'b0;
                    state   <= DONE;

                    for (i = 0; i < PWD_SIZE-1; i = i + 1)
                        count[i] <= 7'h20;

                    count_mask   <= 3'b010;
                    password_out <= {PWD_SIZE{7'h20}};
                    password_out[(7*PWD_SIZE)-4 -: 4] <= core_id;
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
