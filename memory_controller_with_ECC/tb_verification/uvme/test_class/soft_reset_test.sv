
class soft_reset_test extends zmc_base_test;

  // Factory registration
  `uvm_component_utils(soft_reset_test)

  // Constructor
  function new(string name = "soft_reset_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
  endfunction

  // Run Phase
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info(get_full_name(), $sformatf("Inside the soft reset test"), UVM_MEDIUM)

    begin
      wr_seq_inst.scenario = 16;
      wr_seq_inst.start(env.magent.msequencer);
    end

       `uvm_info(get_full_name(), $sformatf("Inside the  soft reset test done"), UVM_MEDIUM)
    #1000;
    phase.drop_objection(this);
    uvm_test_done.set_drain_time(this, 100);
  endtask

endclass

