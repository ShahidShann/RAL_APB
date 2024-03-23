`ifndef SEQ_INCLUDED_
`define SEQ_INCLUDED_

class seq extends uvm_sequence;
  `uvm_object_utils(seq)

  seq_item si;

  function new(string name="seq");
    super.new(name);
  endfunction

  virtual task body();
    begin
      //repeat(2)begin
        si=seq_item::type_id::create("si");
        start_item(si);
         assert(si.randomize());
        finish_item(si);
    //  end
    end
  endtask
endclass
`endif


