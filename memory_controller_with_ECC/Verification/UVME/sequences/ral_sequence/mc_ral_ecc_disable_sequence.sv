class mc_ral_ecc_disable_sequence extends uvm_sequence;

  // RAL block handle
  mc_register_block regmodel;

  // Scenario selector
  int scenario;

  `uvm_object_utils(mc_ral_ecc_disable_sequence)

  // Constructor
  function new(string name = "mc_ral_ecc_disable_sequence");
    super.new(name);
  endfunction

  // Body phase
  task body;
    uvm_status_e     status;
    uvm_reg_data_t   rdata2;

    if (scenario == 3) begin  // ECC Disable Scenario

      if (regmodel == null) begin
        `uvm_fatal("SEQ", "Register model handle is null")
        return;
      end

      `uvm_info("RAL_SEQ", "Scenario 3: Configuring ECC to DISABLE mode", UVM_MEDIUM)

      // Write 0 to ECC ON/OFF register to disable ECC
      regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000000);
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("Frontdoor write failed with status=%s", status.name()));
        return;
      end

      // Read ECC Status Register
      regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("Register read failed with status=%s", status.name()));
        return;
      end

      `uvm_info("RAL_SEQ", $sformatf("ECC Status Register Value: 0x%08x", rdata2), UVM_MEDIUM)

    end // scenario == 3

  endtask

endclass

