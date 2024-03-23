`ifndef APB_TEST2_INCLUDED_
`define APB_TEST2_INCLUDED_

class apb_test2 extends apb_base_test;
   `uvm_component_utils(apb_test2)

   apb_reg_seq rseq;
   apb_rst_seq rst_seq;

   function new (string name = "apb_test2", uvm_component parent);
      super.new (name, parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      rseq = apb_reg_seq::type_id::create ("rseq", this);
      rst_seq = apb_rst_seq::type_id::create ("rst_seq", this);
      
   endfunction
  
  /* virtual task reset_phase(uvm_phase phase);
    super.reset_phase(phase);
    phase.raise_objection (this);
    rst_seq.start (e.a.m_seqr);
    phase.drop_objection (this);
  endtask*/

   virtual task main_phase (uvm_phase phase);
      phase.raise_objection (this);
      rst_seq.start(e.a.m_seqr);
      rseq.start(e.a.m_seqr);
      phase.drop_objection (this);
   endtask
endclass
`endif
