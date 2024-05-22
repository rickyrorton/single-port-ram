`timescale 1ns / 1ps
`include "ram.v"
module ram16x8_tb;

    // Inputs
    reg [7:0] data_in;
    reg we;
    reg cs;
    reg clk;
    reg [3:0] addr;

    // Outputs
    wire [7:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    ram16x8 uut (
        .data_in(data_in), 
        .we(we), 
        .cs(cs), 
        .clk(clk), 
        .addr(addr), 
        .data_out(data_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test stimulus
    initial begin
        // Initialize Inputs
        data_in = 0;
        we = 0;
        cs = 0;
        addr = 0;

        // Wait for global reset to finish
        #10;
        
        // Write and Read Test
        cs = 1;
        
        // Write 8'hAA to address 4
        addr = 4;
        data_in = 8'hAA;
        we = 1;
        #10; // wait for the clock edge

        // Write 8'hBB to address 5
        addr = 5;
        data_in = 8'hBB;
        #10; // wait for the clock edge

        // Disable write
        we = 0;
        
        // Read from address 4
        addr = 4;
        $display(data_out);
        #10; // wait for the clock edge
        if (data_out !== 8'hAA) $display("Read error at address 4: expected 8'hAA, got %h", data_out);
        
        // Read from address 5
        addr = 5;
        $display(data_out);
        #10; // wait for the clock edge
        if (data_out !== 8'hBB) $display("Read error at address 5: expected 8'hBB, got %h", data_out);
        
        // Read from uninitialized address 0
        addr = 0;
        #10; // wait for the clock edge
        if (data_out !== 8'h00) $display("Read error at address 0: expected 8'h00, got %h", data_out);
        
        // Additional tests can be added here
        
        // Finish simulation
        $finish;
end

endmodule
