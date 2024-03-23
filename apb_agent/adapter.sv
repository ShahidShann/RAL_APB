class adapter extends uvm_reg_adapter;
  `uvm_object_utils(adapter)

  function new(string name="adapter");
    super.new(name);
  endfunction

  //converting register transaction to apb transaction
  virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
    apb_seq_item tx;
    tx= apb_seq_item::type_id::create("tx");
    tx.pwrite=(rw.kind==UVM_WRITE) ? '1:'0;
    tx.paddr=rw.addr;
    tx.pwdata=rw.data;


   /*  if(tx.pwrite)
      tx.pwdata=rw.data;
      else
        tx.P_rdata=rw.data;*/

    return tx;
  endfunction

  //converting apb transaction to register transaction
  virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
  apb_seq_item tx;

    if(!$cast(tx,bus_item))begin
      `uvm_fatal("Not apb_seq_item type","Provide bus_item type is not correct")
    end

    rw.kind=(tx.pwrite) ? UVM_WRITE : UVM_READ;
    rw.addr=tx.paddr;
    rw.data=tx.pwdata;
    rw.status=UVM_IS_OK;
  endfunction
endclass


