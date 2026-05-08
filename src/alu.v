module alu (
    input  [7:0] a,
    input  [7:0] b,
    input  [2:0] op,
    output reg [7:0] result,
    output reg       zero,
    output reg       carry
);

always @(*) begin
    carry = 0;
    case (op)
        3'b000: {carry, result} = a + b;   // ADD
        3'b001: {carry, result} = a - b;   // SUB
        3'b010: result = a & b;            // AND
        3'b011: result = a | b;            // OR
        3'b100: result = a ^ b;            // XOR
        3'b101: result = ~a;               // NOT
        3'b110: result = a << 1;           // L SHIFT
        3'b111: result = a >> 1;           // R SHIFT
        default: result = 8'b0;
    endcase
    zero = (result == 8'b0);
end

endmodule
