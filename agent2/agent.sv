`ifndef AGENT_INCLUDED_
`define AGENT_INCLUDED_

class agent extends uvm_agent;
   `uvm_component_utils(agent)


   driver                     d_a;
   monitor                    mon_a;
   uvm_sequencer #(seq_item)  seqr_a; 
   
   function new (string name="agent",uvm_component parent);
      super.new (name, parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      d_a = driver::type_id::create ("d_a", this);
      seqr_a = uvm_sequencer#(seq_item)::type_id::create ("seqr_a", this);
      mon_a = monitor::type_id::create ("mon_a", this);
   endfunction

   virtual function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);
      d_a.seq_item_port.connect(seqr_a.seq_item_export);
   endfunction
endclass
`endif
