
class ECC_enable_test extends zmc_base_test;

  // Factory registration
  `uvm_component_utils(ECC_enable_test)
   ecc_frontdoor_seq seq;
   int scenario;

  // Constructor
  function new(string name = "ECC_enable_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     seq = ecc_frontdoor_seq::type_id::create("seq",this);
      endfunction

  // Run Phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info(get_full_name(), "Inside the ECC_enable_test test", UVM_MEDIUM)
    // Set the block handle
  seq.regmodel = env.regmodel; // block handle path
   wr_seq_inst.scenario=4;
   seq.scenario = 4;
    // Start the sequence
   
   seq.start(env.apb_agent_inst.apb_sequencer_inst);
  begin
   #100;
   wr_seq_inst.start(env.magent.msequencer);
   end
   


      #1000;
     phase.drop_objection(this);
    uvm_test_done.set_drain_time(this, 200);
    `uvm_info(get_full_name(), "Inside the ECC_enable_test test done ", UVM_MEDIUM)
  endtask

endclass  


