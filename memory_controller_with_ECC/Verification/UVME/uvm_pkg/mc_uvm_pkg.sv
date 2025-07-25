package mc_uvm_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"


    `include "./../UVME/sequences/mc_axi_seq_item.sv"
    `include "./../UVME/sequences/mc_apb_seq_item.sv"
    `include "./../UVME/agents/apb_agent/mc_apb_driver.sv"
    `include "./../UVME/agents/axi_agent/mc_axi_driver.sv"
    `include "./../UVME/agents/apb_agent/mc_apb_monitor.sv"
    `include "./../UVME/agents/axi_agent/mc_axi_monitor.sv"
    `include "./../UVME/agents/apb_agent/mc_apb_sequencer.sv"
    `include "./../UVME/agents/axi_agent/mc_axi_sequencer.sv"
    `include "./../UVME/agents/apb_agent/mc_apb_agent.sv"
    `include "./../UVME/agents/axi_agent/mc_axi_agent.sv"
    //`include "./../UVME/env/mc_scoreboard.sv"
    `include "./../UVME/env/mc_env.sv"
    `include "./../UVME/sequences/mc_base_sequence.sv"
    `include "./../UVME/sequences/mc_reset_sequence.sv"
    `include "./../UVME/sequences/mc_soft_reset_sequence.sv"
    `include "./../UVME/sequences/mc_mem_initial_sequence.sv"

    `include "./../UVME/tests/mc_base_test.sv"
    `include "./../UVME/tests/mc_reset_test.sv"
    `include "./../UVME/tests/mc_soft_reset_test.sv"
    `include "./../UVME/tests/mc_mem_initial_test.sv"

    endpackage
