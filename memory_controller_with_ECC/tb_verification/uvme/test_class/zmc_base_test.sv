
//test_lib class
class zmc_base_test extends uvm_test;
	zmc_env env;
    zmc_wr_seq wr_seq_inst;
//factory registration
	`uvm_component_utils(zmc_base_test)
	
//new construct
	function new(string name="zmc_base_test",uvm_component parent=null);
		super.new(name,parent);
	endfunction

//build phase
	function void build_phase(uvm_phase phase);
		env=zmc_env::type_id::create("env",this);
        wr_seq_inst =zmc_wr_seq::type_id::create("wr_seq_inst");
     endfunction

//end of elaboration phase
	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();
    endfunction

task run_phase(uvm_phase phase);
    phase.raise_objection(this);
  //  seq.regmodel = env.regmodel;
       #1000;
   `uvm_info(get_name(),$sformatf("inside the base test"),UVM_MEDIUM)
    phase.drop_objection(this);
  endtask

endclass 

