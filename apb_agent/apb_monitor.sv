`ifndef APB_MONITOR_INCLUDED_
`define APB_MONITOR_INCLUDED_

class apb_monitor extends uvm_monitor;
   `uvm_component_utils (apb_monitor)
     apb_seq_item tx;

   function new (string name="apb_monitor", uvm_component parent);
      super.new (name, parent);
   endfunction
 
   uvm_analysis_port #(apb_seq_item)  mon_ap;
   virtual apb_if  vif;
 
   virtual function void build_phase (uvm_phase phase);
      super.build_phase (phase);
      mon_ap = new ("mon_ap", this);
      if(! uvm_config_db #(virtual apb_if)::get (this, "", "vif", vif))
         `uvm_fatal("apb_driver","Failed getting interface")

   endfunction
 
   virtual task run_phase (uvm_phase phase);
      fork
        // @(posedge vif.presetn);
         forever begin
            @(posedge vif.pclk);
            if (vif.psel & vif.penable & vif.presetn) begin
               tx = apb_seq_item::type_id::create ("tx");
               tx.paddr = vif.paddr;
               if (vif.pwrite)
                  tx.pwdata = vif.pwdata;
               else
                  tx.pwdata = vif.prdata;
               tx.pwrite = vif.pwrite;
               mon_ap.write(tx);
            end 
         end
      join_none
   endtask
 endclass
`endif
