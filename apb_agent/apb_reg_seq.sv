`ifndef APB_REG_SEQ_INCLUDED
`define APB_REG_SEQ_INCLUDED

class apb_reg_seq extends uvm_reg_sequence;
  `uvm_object_utils(apb_reg_seq)

  reg_block rb;
  uvm_reg_data_t op_rdata;
  uvm_reg_data_t ce_rdata;
  uvm_reg_data_t ci_rdata;
  uvm_status_e   status;

  
  function new(string name="apb_reg_seq");
    super.new(name);
  endfunction

  virtual task body();
  if(! uvm_config_db#(reg_block)::get(null,"*","rb",rb))
    `uvm_fatal(get_type_name(),"Failed to get regblock from root which is set in env")

    rb.ce.write(status,1'b1);
    `uvm_info("REG_SEQ_CHIP_ENABLE",$sformatf("chip_enable written value=1"),UVM_NONE)
    
    rb.ce.read(status,ce_rdata);
    `uvm_info("REG_SEQ_CHIP_ENABLE",$sformatf("chip_enable read value=%h",ce_rdata),UVM_NONE)

    if(ce_rdata==1'b1)
     `uvm_info("CHIP_ENABLE","Test passed for ce_rdata",UVM_NONE)
    
     rb.cid.read(status,ci_rdata);
    `uvm_info("chip id",$sformatf("chip id read value(ci_rdata)=%h",ci_rdata),UVM_NONE)


    rb.op.write(status,4'b0010);
    `uvm_info("REG_SEQ_OUTPUT_PORT_ENABLE",$sformatf("output_port_enable written value=2"),UVM_NONE)
    
    rb.op.read(status,op_rdata);
    `uvm_info("REG_SEQ_OUTPUT_PORT_ENABLE",$sformatf("output_port_enable read value(rdata)=%h",op_rdata),UVM_NONE)
    
    if(op_rdata==4'b0010)
     `uvm_info("OUTPUT_PORT_ENABLE","Test passed for op_rdata",UVM_NONE)


  endtask
endclass
`endif
