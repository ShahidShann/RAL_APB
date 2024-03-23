class reg_block extends uvm_reg_block;
  `uvm_object_utils(reg_block)

  rand chip_enable_reg ce;
  rand chip_id_reg cid;
  rand output_port_enable_reg op;


  function new(string name="reg_block");
    super.new(name,UVM_NO_COVERAGE);
  endfunction

  function void build();
    this.default_map=create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);

    this.ce=chip_enable_reg::type_id::create("ce");
    this.cid=chip_id_reg::type_id::create("cid");
    this.op=output_port_enable_reg::type_id::create("op");

    this.ce.configure(this,null,"");
    this.cid.configure(this,null,"");
    this.op.configure(this,null,"");
   
    //call the build_function to register all the fields
    this.ce.build();
    this.cid.build();
    this.op.build();

    this.default_map.add_reg(this.ce,`UVM_REG_ADDR_WIDTH'h0,"RW",0);
    this.default_map.add_reg(this.cid,`UVM_REG_ADDR_WIDTH'h4,"RO",0);
    this.default_map.add_reg(this.op,`UVM_REG_ADDR_WIDTH'h8,"RW",0);
  endfunction
endclass




