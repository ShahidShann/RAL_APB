`ifndef APB_TEST1_INCLUDED_
`define APB_TEST1_INCLUDED_

class apb_test1 extends apb_base_test;
   `uvm_component_utils(apb_test1)

   apb_reg_seq rseq;
   seq         s_a;
  // apb_rst_seq rst_seq;

   function new (string name = "apb_test1", uvm_component parent);
      super.new (name, parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      rseq = apb_reg_seq::type_id::create ("rseq", this);
      s_a = seq::type_id::create ("s_a", this);
     // rst_seq = apb_rst_seq::type_id::create ("rst_seq", this);
      
   endfunction
  
/*   virtual task reset_phase(uvm_phase phase);
    super.reset_phase(phase);
    phase.raise_objection (this);
    rst_seq.start (e.a.m_seqr);
    phase.drop_objection (this);
  endtask*/

   virtual task main_phase (uvm_phase phase);
      phase.raise_objection (this);
      fork
       rseq.start(e.a.m_seqr);
       s_a.start(e.a1.seqr_a);
      join
      #2000;
      phase.drop_objection (this);
   endtask
endclass
`endif
