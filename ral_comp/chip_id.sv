class chip_id_reg extends uvm_reg;
  `uvm_object_utils(chip_id_reg)

  rand uvm_reg_field chip_id;

  function new(string name="chip_id_reg");
    super.new(name,32,UVM_NO_COVERAGE);
  endfunction

  function void build();
    //create object to reg_field
    this.chip_id=uvm_reg_field::type_id::create("chip_id");

    //configure the reg_field
    // configure(parent, size, lsb_pos, access, volatile, reset, has_reset, is_rand, individually_accessible);
//    this.chip_id.configure(this,8,0,"RO",0,8'hAA,1,1,1);
   this.chip_id.configure(this,8,0,"RO",0,1'h0,1,1,1);
  endfunction
endclass


