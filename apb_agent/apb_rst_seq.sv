`ifndef APB_RST_SEQ_INCLUDED
`define APB_RST_SEQ_INCLUDED

class apb_rst_seq extends uvm_sequence;
   `uvm_object_utils (apb_rst_seq)
   function new (string name = "apb_rst_seq");
      super.new (name);
   endfunction

   virtual apb_if vif;

   virtual task body();
      if (!uvm_config_db #(virtual apb_if) ::get (null, "uvm_test_top.*", "vif", vif)) 
         `uvm_fatal ("RESET SEQ", "Not able to get vif")

      `uvm_info ("RESET", "Running reset ...", UVM_MEDIUM);
      vif.presetn <= 0;
      @(posedge vif.pclk) 
        vif.presetn <= 1;
      @(posedge vif.pclk);
   endtask
endclass
`endif
