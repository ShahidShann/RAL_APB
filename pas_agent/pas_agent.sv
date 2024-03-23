`ifndef PAS_AGENT_INCLUDED_
`define PAS_AGENT_INCLUDED_

class pas_agent extends uvm_agent;
   `uvm_component_utils(pas_agent)


   pas_monitor              mon_pas;
   
   function new (string name="pas_agent",uvm_component parent);
      super.new (name, parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      mon_pas = pas_monitor::type_id::create ("mon_pas", this);
   endfunction

   virtual function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);
   endfunction
endclass
`endif
