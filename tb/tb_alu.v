module tb_alu;

reg  [7:0] a, b;
reg  [2:0] op;
wire [7:0] result;
wire       zero, carry;

alu uut (
    .a(a), .b(b), .op(op),
    .result(result), .zero(zero), .carry(carry)
);

initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, tb_alu);
end

task check;
    input [7:0] exp;
    input [7:0] a_in, b_in;
    input [2:0] op_in;
    input [7:0] res;
    begin
        if (res === exp)
            $display("PASS | a=%0d b=%0d op=%0b | result=%0d", a_in, b_in, op_in, res);
        else
            $display("FAIL | a=%0d b=%0d op=%0b | expected=%0d got=%0d", a_in, b_in, op_in, exp, res);
    end
endtask

initial begin
    // ADD
    a=8'd10;  b=8'd20;  op=3'b000; #10; check(8'd30,  a,b,op,result);
    // SUB
    a=8'd50;  b=8'd20;  op=3'b001; #10; check(8'd30,  a,b,op,result);
    // AND
    a=8'hFF;  b=8'h0F;  op=3'b010; #10; check(8'h0F,  a,b,op,result);
    // OR
    a=8'hF0;  b=8'h0F;  op=3'b011; #10; check(8'hFF,  a,b,op,result);
    // XOR
    a=8'hFF;  b=8'hFF;  op=3'b100; #10; check(8'h00,  a,b,op,result);
    // NOT
    a=8'h00;  b=8'h00;  op=3'b101; #10; check(8'hFF,  a,b,op,result);
    // L SHIFT
    a=8'b00000001; b=8'h00; op=3'b110; #10; check(8'b00000010, a,b,op,result);
    // R SHIFT
    a=8'b10000000; b=8'h00; op=3'b111; #10; check(8'b01000000, a,b,op,result);
    // ZERO flag
    a=8'd0; b=8'd0; op=3'b010; #10;
    if (zero) $display("PASS | zero flag works");
    else      $display("FAIL | zero flag broken");

    $finish;
end

endmodule
