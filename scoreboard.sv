`ifndef SCOREBOARD_INCLUDED_
`define SCOREBOARD_INCLUDED_
`uvm_analysis_imp_decl(_active)
`uvm_analysis_imp_decl(_passive)


class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)


  uvm_analysis_imp_active #(seq_item,scoreboard) active_imp;
  uvm_analysis_imp_passive #(seq_item,scoreboard) pas_imp;
  seq_item si;
  bit[63:0] expected_pkt;
  bit[63:0] actual_pkt;


  function new(string name="scoreboard", uvm_component parent =null);
    super.new(name,parent);
    active_imp=new("active_imp",this);
    pas_imp=new("pas_imp",this);
    `uvm_info(get_type_name(),"In the scoreboard",UVM_NONE)
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    si=seq_item::type_id::create("si");
  endfunction

  virtual function void write_active(seq_item si);
    expected_pkt=si.dup_pkt;
    `uvm_info(get_type_name(),$sformatf("expected packet=%h",expected_pkt),UVM_NONE)
  endfunction

  virtual function void write_passive(seq_item si);
    actual_pkt=si.actual_pkt;
    `uvm_info(get_type_name(),$sformatf("actual packet=%h",actual_pkt),UVM_NONE)
  endfunction

  virtual function void check_phase(uvm_phase phase);
    super.check_phase(phase);
    if(expected_pkt[63:48]==actual_pkt[47:32])
      `uvm_info(get_type_name(),"TEST PASSED",UVM_NONE)
    else
      `uvm_info(get_type_name(),"TEST FAILED",UVM_NONE)
  endfunction


endclass
`endif

