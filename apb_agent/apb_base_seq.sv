`ifndef APB_BASE_SEQ_INCLUDED
`define APB_BASE_SEQ_INCLUDED

class apb_base_seq extends uvm_sequence;
  apb_seq_item tx;

  function new(string name="apb_base_seq");
    super.new(name);
  endfunction

  virtual task body();
    tx=apb_seq_item::type_id::create("tx");
    start_item(tx);
      assert(tx.randomize());
    finish_item(tx);
  endtask

endclass
`endif
