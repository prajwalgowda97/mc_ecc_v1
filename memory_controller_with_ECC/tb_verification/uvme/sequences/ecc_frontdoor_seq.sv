

class ecc_frontdoor_seq extends uvm_sequence;
  // RAL block handle
   ecc_block regmodel;

  `uvm_object_utils(ecc_frontdoor_seq)

  int scenario;

  // Constructor
  function new(string name = "ecc_frontdoor_seq");
    super.new(name);
  endfunction

  // Body phase
  task body;  
    uvm_status_e   status;
    uvm_reg_data_t rdata1,rdata2;
    

//ecc_disable_scenario
if(scenario==3)begin
    
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end
  
  //ECC disable condition
     `uvm_info("RAL_SEQ", "Configuring ECC to DISABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000000);  
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end   

    
     regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
    `uvm_info("RAL_SEQ", $sformatf("Read value from ECC status  Register: 0x%08x", rdata2), UVM_MEDIUM)


    end
//////////////////////////////////////////////////////////////////////////////////////////////
//ecc enable scenario
     if(scenario==4)begin
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end



     //ECC enable condition
      `uvm_info("RAL_SEQ", "Configuring ECC to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h000000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end 
#10;
    // Read back the written value from the ECC On/Off Register
  regmodel.o_ecc_onoff_reg_ecc_onoff_reg.read(status,rdata1);
  if (status != UVM_IS_OK) begin
    `uvm_error("SEQ", $sformatf("Register read failed with status=%0s", status.name()));
    return;
  end

  // Print the read value
  `uvm_info("RAL_SEQ", $sformatf("Read value from ECC On/Off Register: 0x%08x", rdata1), UVM_MEDIUM)
`uvm_info("RAL_SEQ", $sformatf("Register Address: %s", regmodel.o_ecc_onoff_reg_ecc_onoff_reg.get_full_name()), UVM_MEDIUM)

     regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
    `uvm_info("RAL_SEQ", $sformatf("Read value from ECC status  Register: 0x%08x", rdata2), UVM_MEDIUM)


      end
/////////////////////////////////////////////////////////////////////////////////////////
//parity generator scenario
   if(scenario==5)begin
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end

 //ECC enable condition
      `uvm_info("RAL_SEQ", "Configuring ECC to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end
    end
///////////////////////////////////////////////////////////////////////////////////
//interrupt enable scenario
     if(scenario==6)begin
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end


        
 //ECC enable condition
      `uvm_info("RAL_SEQ", "Configuring ECC to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end


 //ECC interrupt  enable condition
    `uvm_info("RAL_SEQ", "Configuring ECC interrupt to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_en_irq_reg_ecc_en_irq_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end
   /////read the status reg 
   regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
   
        `uvm_info("RAL_SEQ", $sformatf("Read value from ECC status  Register: 0x%08x", rdata2), UVM_MEDIUM)


   end

///////////////////////////////////////////////////////////////////////////////////////////

//interrupt disable scenario
 if(scenario==7)begin
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end


        
 //ECC enable condition
      `uvm_info("RAL_SEQ", "Configuring ECC to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end


 //ECC interrupt disable condition
    `uvm_info("RAL_SEQ", "Configuring ECC interrupt to DiSABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_en_irq_reg_ecc_en_irq_reg.write(status, 32'h00000000);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end
   /////read the status reg 
   
     regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
    `uvm_info("RAL_SEQ", $sformatf("Read value from ECC status  Register: 0x%08x", rdata2), UVM_MEDIUM)


   end
////////////////////////////////////////////////////////////////////////////////////////////

   /////////////////////////////////////////////////////////////////////////////////////////////
   //single_wr_rd_tx scenario
if(scenario==8)begin
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end


        
 //ECC enable condition
      `uvm_info("RAL_SEQ", "Configuring ECC to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end


   /////read the status reg 
   regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
   
     
    `uvm_info("RAL_SEQ", $sformatf("Read value from ECC status  Register: 0x%08x", rdata2), UVM_MEDIUM)


   end
   ////////////////////////////////////////////////////////////////////////////////////////////
   //fixed burst scenario
if(scenario==9)begin
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end


        
 //ECC enable condition
      `uvm_info("RAL_SEQ", "Configuring ECC to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end


   /////read the status reg 
  
   
     regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
    `uvm_info("RAL_SEQ", $sformatf("Read value from ECC status  Register: 0x%08x", rdata2), UVM_MEDIUM)


   end


////////////////////////////////////////////////////////////////////////////////////////////////

//incremental_burst_scenario
if(scenario==10)begin
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end


        
 //ECC enable condition
      `uvm_info("RAL_SEQ", "Configuring ECC to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end


   /////read the status reg 
     
     regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
    `uvm_info("RAL_SEQ", $sformatf("Read value from ECC status  Register: 0x%08x", rdata2), UVM_MEDIUM)


   end
/////////////////////////////////////////////////////////////////////////////////////////////
//wrap_burst_scenario
if(scenario==11)begin
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end


        
 //ECC enable condition
      `uvm_info("RAL_SEQ", "Configuring ECC to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end


   /////read the status reg 
     
     regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
    `uvm_info("RAL_SEQ", $sformatf("Read value from ECC status  Register: 0x%08x", rdata2), UVM_MEDIUM)


   end

/////////////////////////////////////////////////////////////////////////////////////////////
//single bit error injection scenario
 if(scenario==12)begin
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end


        
 //ECC enable condition
      `uvm_info("RAL_SEQ", "Configuring ECC to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end


 //ECC interrupt  enable condition
    `uvm_info("RAL_SEQ", "Configuring ECC interrupt to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_en_irq_reg_ecc_en_irq_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end
   /////read the status reg 
      
     regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
    `uvm_info("RAL_SEQ", $sformatf("Read value from ECC status  Register: 0x%08x", rdata2), UVM_MEDIUM)


   end
   /////////////////////////////////////////////////////////////////////////////////////////////////
   //double bit error injection
if(scenario==13)begin
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end


        
 //ECC enable condition
      `uvm_info("RAL_SEQ", "Configuring ECC to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end


 //ECC interrupt  enable condition
    `uvm_info("RAL_SEQ", "Configuring ECC interrupt to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_en_irq_reg_ecc_en_irq_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end
   /////read the status reg 
      
     regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
    `uvm_info("RAL_SEQ", $sformatf("Read value from ECC status  Register: 0x%08x", rdata2), UVM_MEDIUM)


   end


///////////////////////////////////////////////////////////////////////////////////////////////////
//random wr_rd tx test

if(scenario==14)begin
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end


        
 //ECC enable condition
      `uvm_info("RAL_SEQ", "Configuring ECC to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end


   /////read the status reg 
     
     regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
    `uvm_info("RAL_SEQ", $sformatf("Read value from ECC status  Register: 0x%08x", rdata2), UVM_MEDIUM)


   end
////////////////////////////////////////////////////////////////////////////////////////////////////////
//random wr test
if(scenario==15)begin
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end


        
 //ECC enable condition
      `uvm_info("RAL_SEQ", "Configuring ECC to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end


   /////read the status reg 
     
     regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
    `uvm_info("RAL_SEQ", $sformatf("Read value from ECC status  Register: 0x%08x", rdata2), UVM_MEDIUM)

end
/////////////////////////////////////////////////////////////////////////////////////////////////////
//random rd test
if(scenario==16)begin
   if (regmodel == null) begin
            `uvm_fatal("SEQ", "Register model handle is null")
            return;
        end


        
 //ECC enable condition
      `uvm_info("RAL_SEQ", "Configuring ECC to ENABLE mode", UVM_MEDIUM)
     regmodel.o_ecc_onoff_reg_ecc_onoff_reg.write(status, 32'h00000001);      
      if (status != UVM_IS_OK) begin
        `uvm_error("SEQ", $sformatf("frontdoor write failed with status=%0s", status.name()));
        return;
    end


   /////read the status reg 
     
     regmodel.o_ecc_staus_reg_ecc_staus.read(status, rdata2);
    `uvm_info("RAL_SEQ", $sformatf("Read value from ECC status  Register: 0x%08x", rdata2), UVM_MEDIUM)

end

    endtask
endclass


