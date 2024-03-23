`ifndef PAS_MONITOR_INCLUDED_
`define PAS_MONITOR_INCLUDED_

class pas_monitor extends uvm_monitor;
  `uvm_component_utils(pas_monitor)
  seq_item si;
  virtual apb_if vif;
  bit a;
  uvm_analysis_port #(seq_item) pas_port;

  function new(string name="pas_monitor",uvm_component parent=null);
    super.new(name,parent);
    pas_port=new("pas_port",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    si=seq_item::type_id::create("si");
    if(! uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
      `uvm_fatal(get_type_name(),"Failed to get intf in pas_monitor")

  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      @(posedge(vif.pclk))
      
       if(vif.valid_out)begin
        case(vif.prdata[3:0])
          4'b0001: begin
            repeat(64)begin
              a=vif.out_port1;
              si.actual_pkt=si.actual_pkt <<1;
              si.actual_pkt+=a;
              @(posedge(vif.pclk));
            end
          `uvm_info(get_type_name(),$sformatf("from port 1 packet=%h",si.actual_pkt),UVM_NONE)
          end

          4'b0010: begin
            repeat(64)begin
              a=vif.out_port2;
              si.actual_pkt=si.actual_pkt <<1;
              si.actual_pkt+=a;
              @(posedge(vif.pclk));
            end
          `uvm_info(get_type_name(),$sformatf("from port 2 packet=%h",si.actual_pkt),UVM_NONE)
          end

         4'b0100: begin
            repeat(64)begin
              a=vif.out_port3;
              si.actual_pkt=si.actual_pkt <<1;
              si.actual_pkt+=a;
              @(posedge(vif.pclk));
            end
          `uvm_info(get_type_name(),$sformatf("from port 3 packet=%h",si.actual_pkt),UVM_NONE)
          end

        4'b1000: begin
            repeat(64)begin
              a=vif.out_port4;
              si.actual_pkt=si.actual_pkt <<1;
              si.actual_pkt+=a;
              @(posedge(vif.pclk));
            end
          `uvm_info(get_type_name(),$sformatf("from port 4 packet=%h",si.actual_pkt),UVM_NONE)
          end
     endcase
     pas_port.write(si);
    end
   end

 endtask
endclass
`endif
