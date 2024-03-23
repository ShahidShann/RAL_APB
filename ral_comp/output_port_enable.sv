class output_port_enable_reg extends uvm_reg;
  `uvm_object_utils(output_port_enable_reg)

  rand uvm_reg_field output_port_enable;

  function new(string name="output_port_enable_reg");
    super.new(name,32,UVM_NO_COVERAGE);
  endfunction

  function void build();
    //create object for reg_fields
    this.output_port_enable=uvm_reg_field::type_id::create("output_port_enable");

    //configure the reg_field
    // configure(parent, size, lsb_pos, access, volatile, reset, has_reset, is_rand, individually_accessible);
    this.output_port_enable.configure(this,4,0,"RW",0,1'h0,1,1,1);
  endfunction
endclass


