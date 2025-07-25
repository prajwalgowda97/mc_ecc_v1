class incremental_burst_wr_rd_tx_test extends zmc_base_test;

  // Factory registration
  `uvm_component_utils(incremental_burst_wr_rd_tx_test)
   ecc_frontdoor_seq seq;
   int scenario;

  // Constructor
  function new(string name = "incremental_burst_wr_rd_tx_test", uvm_component parent = null);
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
    `uvm_info(get_full_name(), "Inside the incremental_burst_wr_rd_tx_test test", UVM_MEDIUM)
    // Set the block handle
    seq.regmodel = env.regmodel; // block handle path

    wr_seq_inst.scenario=10;
    seq.scenario = 10;
    fork
   seq.start(env.apb_agent_inst.apb_sequencer_inst);
   begin
   #100;
   wr_seq_inst.start(env.magent.msequencer);
   end
   join
      #1000;
     phase.drop_objection(this);
    uvm_test_done.set_drain_time(this, 200);
    `uvm_info(get_full_name(), "Inside the incremental_burst_wr_rd_tx_test test done ", UVM_MEDIUM)
  endtask

endclass  

