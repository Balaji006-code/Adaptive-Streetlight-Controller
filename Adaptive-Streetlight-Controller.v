`timescale 1ns / 1ps
module street_light_project(
    input clk,
    input rst,
    input day,
    input veh_detect,
    output reg R,
    output reg G,
    output reg B
);

    parameter off = 2'b00;
    parameter dim = 2'b01;
    parameter bright = 2'b10;

    reg [1:0] current_state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= off;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            off:    next_state = day ? off : dim;
            dim:    next_state = day ? off : (veh_detect ? bright : dim);
            bright: next_state = day ? off : (!veh_detect ? dim : bright);
            default: next_state = off;
        endcase
    end

    always @(*) begin
        case (current_state)
            off:    begin R = 1; G = 0; B = 0; end
            dim:    begin R = 0; G = 1; B = 0; end
            bright: begin R = 0; G = 0; B = 1; end
            default: begin R = 0; G = 0; B = 0; end
        endcase
    end

endmodule
