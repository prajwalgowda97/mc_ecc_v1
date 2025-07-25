// o_ECC_STAUS_REG_ECC_STAUS: Status Register (0x00)
class o_ECC_STAUS_REG_ECC_STAUS extends uvm_reg;

 `uvm_object_utils(o_ECC_STAUS_REG_ECC_STAUS)
   
 

  // Constructor
  function new(string name = "o_ECC_STAUS_REG_ECC_STAUS");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  // Build the register
  virtual function void build();
    // No fields to configure 
    endfunction

endclass

// o_ECC_EN_IRQ_REG_ECC_EN_IRQ_REG: Interrupt Enable Register (0x04)
class o_ECC_EN_IRQ_REG_ECC_EN_IRQ_REG extends uvm_reg;

 `uvm_object_utils(o_ECC_EN_IRQ_REG_ECC_EN_IRQ_REG)
   
 

  // Constructor
  function new(string name = "o_ECC_EN_IRQ_REG_ECC_EN_IRQ_REG");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  // Build the register
  virtual function void build();
    // No fields to configure 
  endfunction

endclass

// o_ECC_ONOFF_REG_ECC_ONOFF_REG: ECC Enable Register (0x08)
class o_ECC_ONOFF_REG_ECC_ONOFF_REG extends uvm_reg;

`uvm_object_utils(o_ECC_ONOFF_REG_ECC_ONOFF_REG)
   
 

  // Constructor
  function new(string name = "o_ECC_ONOFF_REG_ECC_ONOFF_REG");
    super.new(name, 32, UVM_NO_COVERAGE);
  endfunction

  // Build the register
  virtual function void build();
    // No fields to configure 
    endfunction

endclass



class ecc_block extends uvm_reg_block;

 `uvm_object_utils(ecc_block) 
  // Register instances
  o_ECC_STAUS_REG_ECC_STAUS            o_ecc_staus_reg_ecc_staus;
  o_ECC_EN_IRQ_REG_ECC_EN_IRQ_REG       o_ecc_en_irq_reg_ecc_en_irq_reg;
  o_ECC_ONOFF_REG_ECC_ONOFF_REG        o_ecc_onoff_reg_ecc_onoff_reg;

  // Default map
    uvm_reg_map default_map;

  // Constructor
  function new(string name = "ecc_block");
    super.new(name, UVM_NO_COVERAGE);
  endfunction

  // Build the block
  virtual function void build();

   default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN,0);
    // Create and map o_ECC_STAUS_REG_ECC_STAUS
    o_ecc_staus_reg_ecc_staus = o_ECC_STAUS_REG_ECC_STAUS::type_id::create(" o_ecc_staus_reg_ecc_staus");
    o_ecc_staus_reg_ecc_staus.build();
    o_ecc_staus_reg_ecc_staus. configure(this,null,"");
    //o_ecc_staus_reg_ecc_staus.add_hdl_path_slice("o_ECC_STAUS_REG_ECC_STAUS",0, 32);
   default_map.add_reg( o_ecc_staus_reg_ecc_staus,'h0, "RO"); // Address: 0x00 (Read-Only)

    // Create and map o_ECC_EN_IRQ_REG_ECC_EN_IRQ_REG
    o_ecc_en_irq_reg_ecc_en_irq_reg= o_ECC_EN_IRQ_REG_ECC_EN_IRQ_REG::type_id::create("o_ecc_en_irq_reg_ecc_en_irq_reg");
    o_ecc_en_irq_reg_ecc_en_irq_reg.build();
    o_ecc_en_irq_reg_ecc_en_irq_reg.configure(this,null,"");
   // o_ecc_en_irq_reg_ecc_en_irq_reg.add_hdl_path_slice("o_ECC_EN_IRQ_REG_ECC_EN_IRQ_REG",0, 32);//reg name,startiing bit position,size
    default_map.add_reg(o_ecc_en_irq_reg_ecc_en_irq_reg, 'h4, "RW"); // Address: 0x04 (Read-Write)

    // Create and map o_ECC_ONOFF_REG_ECC_ONOFF_REG
    o_ecc_onoff_reg_ecc_onoff_reg = o_ECC_ONOFF_REG_ECC_ONOFF_REG::type_id::create("o_ecc_onoff_reg_ecc_onoff_reg");
    o_ecc_onoff_reg_ecc_onoff_reg.build();
    o_ecc_onoff_reg_ecc_onoff_reg.configure(this,null,"");
   // o_ecc_onoff_reg_ecc_onoff_reg.add_hdl_path_slice("o_ECC_ONOFF_REG_ECC_ONOFF_REG",0, 32);
    default_map.add_reg(o_ecc_onoff_reg_ecc_onoff_reg, 'h8, "RW"); // Address: 0x08 (Read-Write)
    
   //   add_hdl_path("zmc_top.dut.mem_ctrl_inst.CSR_registers_inst","RTL");
    lock_model();
  endfunction
endclass



