
class zmc_env extends uvm_env;	
	zmc_master_agent magent;
	apb_agent apb_agent_inst;
    ecc_block regmodel;
    ral_adapter adapter_inst;
    uvm_reg_predictor   #(apb_tx)  predictor_inst;
  	zmc_sbd sbd;
	zmc_cov1 cov1;
    zmc_cov2 cov2;
   //factory registration
	`uvm_component_utils(zmc_env)

//new constructor
	function new(string name, uvm_component parent);
    		super.new(name, parent);
	endfunction 

//build phase
	function void build_phase(uvm_phase phase);
    		super.build_phase(phase);
		    magent = zmc_master_agent::type_id::create("magent", this);
    	    apb_agent_inst = apb_agent::type_id::create("apb_agent_inst", this);
            sbd    = zmc_sbd::type_id::create("sbd", this);
		    cov1    = zmc_cov1::type_id::create("cov1",this);
            cov2    = zmc_cov2::type_id::create("cov2",this);

           regmodel = ecc_block::type_id::create("regmodel",this);
           if (regmodel == null) begin
         `uvm_fatal("SEQ", "Register model handle is null")
      end else begin
         regmodel.build();
         `uvm_info("SEQ", $sformatf("Register model handle is valid: %s", regmodel.get_name()), UVM_NONE)
      end
           adapter_inst = ral_adapter::type_id::create("adapter_inst",this);
           predictor_inst = uvm_reg_predictor#(apb_tx)::type_id::create("predictor_inst", this);
          	endfunction 

//connect_phase - connecting monitor and scoreboard port
  
  	function void connect_phase(uvm_phase phase);
    	   	magent.mmonitor.analysis_port.connect(sbd.axi_fifo.analysis_export);
            apb_agent_inst.apb_monitor_inst.analysis_port.connect(sbd.apb_fifo.analysis_export);
            magent.mmonitor.analysis_port.connect(cov1.analysis_export); 
  		    apb_agent_inst.apb_monitor_inst.analysis_port.connect(cov2.analysis_export);

           regmodel.default_map.set_sequencer( apb_agent_inst.apb_sequencer_inst, adapter_inst);
            regmodel.default_map.set_base_addr(0);
            
            apb_agent_inst.apb_monitor_inst.analysis_port.connect(predictor_inst.bus_in);
            predictor_inst.map       = regmodel.default_map;
            predictor_inst.adapter   = adapter_inst;
  	endfunction 	
endclass
