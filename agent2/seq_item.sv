`ifndef SEQ_ITEM_INCLUDED_
`define SEQ_ITEM_INCLUDED_

class seq_item extends uvm_sequence_item;
  rand bit[15:0] src_addr; 
  rand bit[15:0] dest_addr; 
  rand bit[15:0] id; 
  rand bit[15:0] data;
  bit[63:0]      ip_pkt;
  bit[63:0]      dup_pkt;
  bit[63:0]      actual_pkt;

  `uvm_object_utils_begin(seq_item)
    `uvm_field_int(src_addr,UVM_DEFAULT)
    `uvm_field_int(dest_addr,UVM_DEFAULT)
    `uvm_field_int(id,UVM_DEFAULT)
    `uvm_field_int(data,UVM_DEFAULT)
    `uvm_field_int(ip_pkt,UVM_DEFAULT)
    `uvm_field_int(dup_pkt,UVM_DEFAULT)
    `uvm_field_int(actual_pkt,UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name="seq_item");
    super.new(name);
  endfunction
endclass
`endif


