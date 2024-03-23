`ifndef DRIVER_INCLUDED_
`define DRIVER_INCLUDED_

class driver extends uvm_driver#(seq_item);
  `uvm_component_utils(driver)
  
  seq_item si;
  virtual apb_if vif;

  function new(string name="driver",uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    si=seq_item::type_id::create("si");
    if(! uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
      `uvm_fatal("Agent2 driver","Failed to get interface")

  endfunction
    
  virtual task run_phase(uvm_phase phase);
   super.run_phase(phase);
   @(posedge(vif.pclk))
   vif.presetn<=1'b0;
   @(posedge(vif.pclk))
   vif.presetn<=1'b1;

   forever begin
    @(posedge(vif.pclk))
    seq_item_port.get_next_item(si);
        send_pkt();
    seq_item_port.item_done();
  end
 endtask

  task send_pkt();
    `uvm_info(get_type_name(),$sformatf("src addr is=%0h",si.src_addr),UVM_NONE)
    `uvm_info(get_type_name(),$sformatf("dest addr is=%0h",si.dest_addr),UVM_NONE)
    `uvm_info(get_type_name(),$sformatf("id is=%0h",si.id),UVM_NONE)
    `uvm_info(get_type_name(),$sformatf("data is=%0h",si.data),UVM_NONE)

    si.ip_pkt = {si.src_addr,si.dest_addr,si.id,si.data};
    `uvm_info(get_type_name(),$sformatf("input packet is=%h",si.ip_pkt),UVM_NONE)
   // `uvm_info(get_type_name(),$sformatf("input packet is=%b",si.ip_pkt),UVM_NONE)

    @(posedge(vif.pclk))
     vif.valid_in <= 1'b1;
     
    foreach(si.ip_pkt[i])begin
       vif.data_in <= si.ip_pkt[i];
       @(posedge(vif.pclk));
     end
      vif.valid_in <=0;
      si.ip_pkt<=0;
  endtask
endclass
`endif
