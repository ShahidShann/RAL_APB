class env extends uvm_env;
  `uvm_component_utils(env)

  agent a1;
  pas_agent pas_a1;
  reg_block rb;
  apb_agent a;
  uvm_reg_predictor #(apb_seq_item) reg_pr;
  adapter reg_ad;
  scoreboard sb;

  function new(string name="env",uvm_component parent =null);
    super.new(name,parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a = apb_agent::type_id::create("a",this);
    a1 = agent::type_id::create("a1",this);
    pas_a1 = pas_agent::type_id::create("pas_a1",this);
    sb = scoreboard::type_id::create("sb",this);
    rb=reg_block::type_id::create("rb",this);
    reg_ad=adapter::type_id::create("reg_ad",this);
    rb.build();
   // rb.default_map.set_check_on_read(1);

    rb.lock_model();
    reg_pr=uvm_reg_predictor#(apb_seq_item)::type_id::create("reg_pr",this);
    
    //rb.build();

     uvm_config_db#(reg_block)::set(null,"*","rb",rb);
     //`uvm_fatal("apb_driver","Failed setting reg_block") 

  endfunction

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    rb.default_map.set_auto_predict(0);
    reg_pr.map=rb.default_map;
    reg_pr.adapter=reg_ad;

    rb.default_map.set_sequencer(a.m_seqr,reg_ad);

    //we connect monitor to recieve apb_seq_items
    a.apb_ap.connect(reg_pr.bus_in);

    a1.mon_a.active_port.connect(sb.active_imp);
    pas_a1.mon_pas.pas_port.connect(sb.pas_imp);
    
  endfunction
endclass
