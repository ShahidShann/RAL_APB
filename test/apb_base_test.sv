`ifndef APB_BASE_TEST_INCLUDED_
`define APB_BASE_TEST_INCLUDED_

class apb_base_test extends uvm_test;
   `uvm_component_utils (apb_base_test)

   env        e;
   apb_base_seq bseq;
   apb_rst_seq rst_seq;

   function new (string name = "apb_base_test", uvm_component parent);
      super.new (name, parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      e = env::type_id::create ("e", this);
      rst_seq = apb_rst_seq::type_id::create ("rst_seq", this);
   endfunction

  virtual task reset_phase(uvm_phase phase);
    super.reset_phase(phase);
    phase.raise_objection (this);
    rst_seq.start (e.a.m_seqr);
    phase.drop_objection (this);
  endtask


   virtual task main_phase (uvm_phase phase);
      phase.raise_objection (this);
      bseq.start(e.a.m_seqr);
      phase.drop_objection (this);
   endtask
endclass
`endif
