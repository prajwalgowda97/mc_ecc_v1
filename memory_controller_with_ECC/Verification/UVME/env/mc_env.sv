class mc_env extends uvm_env;

  //factory registration
  `uvm_component_utils(mc_env)

  //creating agent handle
  mc_apb_agent apb_agent;
  mc_axi_agent axi_agent;
  ral_adapter adapter_inst;
  mc_register_block regmodel;
  uvm_reg_predictor   #(mc_axi_seq_item)  predictor_inst;
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

           regmodel = mc_register_block::type_id::create("regmodel",this);
           if (regmodel == null) begin
           `uvm_fatal("SEQ", "Register model handle is null")
      end else begin
         regmodel.build();
         `uvm_info("SEQ", $sformatf("Register model handle is valid: %s", regmodel.get_name()), UVM_NONE)
      end
           adapter_inst = ral_adapter::type_id::create("adapter_inst",this);
           predictor_inst = uvm_reg_predictor#(mc_axi_seq_item)::type_id::create("predictor_inst", this);
   
   `uvm_info("env_class", "Inside Build Phase!", UVM_MEDIUM)
  endfunction

  //connect phase
  function void connect_phase(uvm_phase phase);
          // agent.mon_inst.ap.connect(cov_model.analysis_export);
          // uvm_test_top.print_topology();
          // agent.mon_inst.ap.connect(cov_model.analysis_export);
           
           regmodel.default_map.set_sequencer(apb_agent.apb_seqr, adapter_inst);
           regmodel.default_map.set_base_addr(0);
          
          predictor_inst.map       = regmodel.default_map;
          predictor_inst.adapter   = adapter_inst; 
  endfunction

endclass

