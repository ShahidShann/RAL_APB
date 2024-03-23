`ifndef MONITOR_INCLUDED_
`define MONITOR_INCLUDED_

class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  seq_item si;
  virtual apb_if vif;
  bit a;
  uvm_analysis_port #(seq_item) active_port;

  function new(string name="monitor",uvm_component parent=null);
    super.new(name,parent);
    active_port=new("active_port",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    si=seq_item::type_id::create("si");
    if(! uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
      `uvm_fatal(get_type_name(),"Failed to get intf in monitor")

  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      @(posedge(vif.pclk))
       repeat(67) begin
     @(posedge(vif.pclk))

      if(vif.valid_in)begin
        a=vif.data_in;
        si.dup_pkt=si.dup_pkt <<1;
        si.dup_pkt+=a;
      end
    end
    `uvm_info(get_type_name(),$sformatf("1. expected packet=%h",si.dup_pkt),UVM_NONE)
    active_port.write(si);
  end
 endtask
endclass
`endif
