`ifndef TOP_INCLUDED_
`define TOP_INCLUDED_
`timescale 1ns/1ns
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import apb_pkg::*;
  import test_pkg::*;


module top();


  initial begin
    $display("Top");
  end

  bit pclk;
  bit presetn;
  always #10 pclk= ~pclk;

    apb_if vif(.pclk(pclk));

  switch  d1 (.clk(pclk),
                .rst (vif.presetn),
                .paddr   (vif.paddr),
                .p_wdata  (vif.pwdata),
                .prdata  (vif.prdata),
                .psel    (vif.psel),
                .p_write  (vif.pwrite),
                .pen (vif.penable),
                .valid_in(vif.valid_in),
                .data_in(vif.data_in),
                .valid_out(vif.valid_out),
                .out_port1(vif.out_port1),
                .out_port2(vif.out_port2),
                .out_port3(vif.out_port3),
                .out_port4(vif.out_port4));
                
    initial begin
     uvm_config_db #(virtual apb_if)::set (null, "uvm_test_top.*", "vif", vif);
    end

  // Call run_test
    initial begin 
      run_test("apb_base_test");
    end
 
endmodule
`endif
