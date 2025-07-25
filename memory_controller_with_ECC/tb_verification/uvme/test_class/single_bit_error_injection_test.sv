class single_bit_error_injection_test extends zmc_base_test;

  // Factory registration
  `uvm_component_utils(single_bit_error_injection_test)
   ecc_frontdoor_seq seq;
   int scenario;
//virtual  local_intf l_f;
//bit corrupt_enable;

  // Constructor
  function new(string name = "single_bit_error_injection_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build Phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // uvm_config_db#(bit)::set(null, "", "inject_error", 1);
     seq = ecc_frontdoor_seq::type_id::create("seq",this);
       // uvm_config_db#(virtual local_intf)::get(this, "*", "local_intf",l_f )
      /* if (!uvm_config_db #(virtual local_intf)::get(this, "*", "local_intf", l_f)) begin
      `uvm_fatal("NOVIF", "Virtual  local interface not set for test class")
    end*/

      endfunction
    
  // Run Phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info(get_full_name(), "Inside the single_bit_error_injection_test test", UVM_MEDIUM)
    // Set the block handle
  seq.regmodel = env.regmodel; // block handle path

   wr_seq_inst.scenario=12;
   seq.scenario = 12;
         
//try -1
                     //  l_f.data_c = dut.dual_port_ram_inst.RAM_rd_data[13:12];
                     //  corrupt_enable = 1;
    // Start the sequence
   fork
   seq.start(env.apb_agent_inst.apb_sequencer_inst);
   begin
   #100;
   wr_seq_inst.start(env.magent.msequencer);
   end
   join
      #1000;
      //#500;
     //   inject_single_bit_error(1024, 5);
     phase.drop_objection(this);
    uvm_test_done.set_drain_time(this, 200);
    `uvm_info(get_full_name(), "Inside the single_bit_error_injection_test test done ", UVM_MEDIUM)
  endtask

endclass  

