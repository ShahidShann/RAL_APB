`ifndef APB_AGENT_INCLUDED_
`define APB_AGENT_INCLUDED_

class apb_agent extends uvm_agent;
   `uvm_component_utils (apb_agent)

   uvm_analysis_port #(apb_seq_item) apb_ap;

   apb_driver                     dr;
   apb_monitor                    mon;
   sequencer                      m_seqr; 
   
   function new (string name="apb_agent", uvm_component parent);
      super.new (name, parent);
      apb_ap = new("apb_ap", this);
   endfunction

   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      dr = apb_driver::type_id::create ("dr", this);
      m_seqr = sequencer::type_id::create ("m_seqr", this);
      mon = apb_monitor::type_id::create ("mon", this);
   endfunction

   virtual function void connect_phase (uvm_phase phase);
      super.connect_phase (phase);
      dr.seq_item_port.connect(m_seqr.seq_item_export);
      mon.mon_ap.connect(apb_ap);
   endfunction
endclass
`endif
