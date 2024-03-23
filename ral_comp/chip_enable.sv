class chip_enable_reg extends uvm_reg;
  `uvm_object_utils(chip_enable_reg)

  rand uvm_reg_field chip_enable;

  function new(string name="chip_enable_reg");
    super.new(name,32,UVM_NO_COVERAGE);
  endfunction

  function void build();
    //create object for reg_fields
    this.chip_enable=uvm_reg_field::type_id::create("chip_enable");

    //configure the reg_field
    // configure(parent, size, lsb_pos, access, volatile, reset, has_reset, is_rand, individually_accessible);
    this.chip_enable.configure(this,1,0,"RW",0,1'h0,1,1,1);
  endfunction
endclass


