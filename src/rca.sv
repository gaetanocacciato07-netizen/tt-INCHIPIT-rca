//  Module: rca
//
module rca
    (
        input logic [3:0] a,
        input logic [3:0] b,
        input logic cin,
        output logic [3:0] sum,
        output logic cout
    );

    // Internals
    logic [3:0] carry;

    genvar i;
    generate;
        for(i = 0; i < 4; i = i + 1) begin: gen_rca 
            if(i == 0) begin: gen_0
                fa_module u(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cin),
                    .y(sum[i]),
                    .cout(carry[i])
                );
            end else begin: gen_gt0
                fa_module u(
                    .a(a[i]),
                    .b(b[i]),
                    .cin(carry[i-1]),
                    .y(sum[i]),
                    .cout(carry[i])
                );
            end
        end
    endgenerate

    assign cout = carry[3];

endmodule: rca
