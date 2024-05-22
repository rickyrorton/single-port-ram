module ram16x8 (
    input [7:0]data_in,
    input we,cs,clk,
    input [3:0]addr,
    output [7:0]data_out);

    reg [7:0] mem [16];

    always @(posedge clk) begin
        if (cs & we)begin
            mem[addr] <= data_in;
        end
    end

    assign data_out = (cs & !we)? mem[addr] : 'hz ;
    
endmodule