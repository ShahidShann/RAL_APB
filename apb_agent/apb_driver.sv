`ifndef APB_DRIVER_INCLUDED_
`define APB_DRIVER_INCLUDED_

class apb_driver extends uvm_driver#(apb_seq_item);

  `uvm_component_utils(apb_driver)
  apb_seq_item tx;
  virtual apb_if vif;

  function new(string name="apb_driver",uvm_component parent =null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tx=apb_seq_item::type_id::create("tx");
    if(! uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
      `uvm_fatal("apb_driver","Failed getting interface")

  endfunction

  virtual task run_phase(uvm_phase phase);
      bit [31:0] data;
 
      vif.psel <= 0;
      vif.penable <= 0;
      vif.pwrite <= 0;
      vif.paddr <= 0;
      vif.pwdata <= 0;
      forever begin
         @(posedge vif.pclk);
         seq_item_port.get_next_item (tx);
         if (tx.pwrite)
            write (tx.paddr, tx.pwdata);
         else begin
            read (tx.paddr, data);
            tx.pwdata = data;
         end
         seq_item_port.item_done ();
      end
   endtask
 
   virtual task read (  input bit    [31:0] addr, 
                        output logic [31:0] data);
      vif.paddr <= addr;
      vif.pwrite <= 0;
      vif.psel <= 1;
      @(posedge vif.pclk);
      vif.penable <= 1;
      @(posedge vif.pclk);
      @(posedge vif.pclk);  //1 more clk cycle as adapter will take some time to convert reg2bus or bus2reg
      data = vif.prdata;
      vif.psel <= 0;
      vif.penable <= 0;
   endtask
 
   virtual task write ( input bit [31:0] addr,
                        input bit [31:0] data);
      vif.paddr <= addr;
      vif.pwdata <= data;
      vif.pwrite <= 1;
      vif.psel <= 1;
      @(posedge vif.pclk);
      vif.penable <= 1;
      @(posedge vif.pclk);
      vif.psel <= 0;
      vif.penable <= 0;
      @(posedge vif.pclk);
   endtask
endclass
`endif
