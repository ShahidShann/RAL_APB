`ifndef RAL_PKG_INCLUDED_
`define RAL_PKG_INCLUDED_

package ral_pkg;
   
`include "uvm_macros.svh" 
 import uvm_pkg::*;
 
  `include "chip_enable.sv"
  `include "chip_id.sv"
  `include "output_port_enable.sv"
  `include "reg_block.sv"
  
endpackage
`endif
