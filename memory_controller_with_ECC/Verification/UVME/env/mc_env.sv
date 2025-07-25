class mc_env extends uvm_env;

  //factory registration
  `uvm_component_utils(mc_env)

  //creating agent handle
  mc_apb_agent apb_agent;
  mc_axi_agent axi_agent;
  //axi4_slave_cov_model cov_model;

  //constructor
  function new(string name = "mc_env",uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("env_class", "Inside constructor!", UVM_MEDIUM)
  endfunction

  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    apb_agent = mc_apb_agent::type_id::create("mc_apb_agent",this); 
    axi_agent = mc_axi_agent::type_id::create("mc_axi_agent",this); 
   // cov_model = axi4_slave_cov_model::type_id::create("cov_model",this);
   `uvm_info("env_class", "Inside Build Phase!", UVM_MEDIUM)
  endfunction

  //connect phase
  function void connect_phase(uvm_phase phase);
   // agent.mon_inst.ap.connect(cov_model.analysis_export);
   // uvm_test_top.print_topology();
   // agent.mon_inst.ap.connect(cov_model.analysis_export);
  endfunction

endclass

