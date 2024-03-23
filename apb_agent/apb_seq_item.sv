`ifndef APB_SEQ_ITEM_INCLUDED_
`define APB_SEQ_ITEM_INCLUDED_

class apb_seq_item extends uvm_sequence_item;
  rand bit[31:0] paddr;
  rand bit[31:0] pwdata;
  rand bit[31:0] prdata;
  rand bit psel;
  rand bit pwrite;
  rand bit pen;

  `uvm_object_utils_begin(apb_seq_item)
    `uvm_field_int(paddr,UVM_DEFAULT)
    `uvm_field_int(pwdata,UVM_DEFAULT)
    `uvm_field_int(prdata,UVM_DEFAULT)
    `uvm_field_int(psel,UVM_DEFAULT)
    `uvm_field_int(pwrite,UVM_DEFAULT)
    `uvm_field_int(pen,UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name="apb_seq_item");
    super.new(name);
  endfunction
endclass
`endif
