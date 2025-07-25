

package test_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "./../uvme/sequences/zmc_master_tx.sv"
    `include "./../uvme/sequences/apb_tx.sv"
    `include "./../uvme/sequences/zmc_master_sequencer.sv"
    `include "./../uvme/sequences/apb_sequencer.sv"
    `include "./../uvme/wr_agent/wr_driver/zmc_master_driver.sv"
    `include "./../uvme/apb_agent/apb_driver/apb_driver.sv"
    `include "./../uvme/wr_agent/wr_monitor/zmc_master_monitor.sv"
    `include "./../uvme/apb_agent/apb_monitor/apb_monitor.sv"

    `include "./../uvme/wr_agent/zmc_master_agent.sv"
    `include "./../uvme/apb_agent/apb_agent.sv"
      
    `include "./../uvme/env/scoreboard/zmc_sbd.sv"
    `include "./../uvme/env/coverage/zmc_cov.sv"
    `include "./../uvme/env/ecc_block.sv"
    `include "./../uvme/env/ral_adapter.sv"
    `include "./../uvme/sequences/zmc_wr_seq.sv"
    `include "./../uvme/sequences/ecc_frontdoor_seq.sv"

    `include "./../uvme/env/zmc_env.sv"

 
    `include  "./../uvme/test_class/zmc_base_test.sv"
    `include "./../uvme/test_class/zmc_reset_test.sv"
    `include "./../uvme/test_class/mem_initialisation_test.sv"
    `include "./../uvme/test_class/ECC_disable_test.sv"
    `include "./../uvme/test_class/ECC_enable_test.sv"
    `include "./../uvme/test_class/parity_generator_test.sv"
   
    `include "./../uvme/test_class/interrupt_enable_test.sv"
    `include "./../uvme/test_class/interrupt_disable_test.sv"
    `include "./../uvme/test_class/single_wr_rd_tx_test.sv"
    `include "./../uvme/test_class/fixed_burst_wr_rd_tx_test.sv"
    `include "./../uvme/test_class/incremental_burst_wr_rd_tx_test.sv"
    `include "./../uvme/test_class/wrap_burst_wr_rd_tx_test.sv"
    `include "./../uvme/test_class/random_wr_rd_test.sv"
    `include "./../uvme/test_class/single_bit_error_injection_test.sv"
    `include "./../uvme/test_class/double_bit_error_injection_test.sv"
    `include "./../uvme/test_class/random_wr_test.sv"
     //`include "./../uvme/test_class/soft_reset_test.sv"
    `include "./../uvme/test_class/reset_zero_test.sv"
    // `include "./../uvme/test_class/random_rd_test.sv"
 
endpackage
