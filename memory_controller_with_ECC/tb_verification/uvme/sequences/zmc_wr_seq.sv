 class zmc_wr_seq extends uvm_sequence#(zmc_master_tx);
 //factory registration
  `uvm_object_utils (zmc_wr_seq)
rand bit [31:0] addr;

  constraint addr_c {
    addr < 32'h1000_0000;
  }

  zmc_master_tx tx;        
  int scenario;
  
//constructor
 function new (string name= "zmc_wr_seq" );
    super.new(name);
  
  endfunction
  
  // build phase
  function void build_phase(uvm_phase phase);
        tx = zmc_master_tx::type_id::create("tx");
  endfunction

  task body();
   //reset scenario
      if(scenario == 1)
         begin
                   `uvm_do_with(tx,{tx.zmc_top_rstn == 1;
                         tx.wr_rd == 1;                 
                         tx.awaddr == 32'h100;            
                         tx.awlen == 0;                    
                         tx.wstrb == 4'b1111;                 
                         tx.wlast == 1;       }) 


 #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                           tx.zmc_top_mem_init == 1;
                            tx.wr_rd == 0;                  
                            tx.araddr == 32'h100;            
                            tx.arlen == 0;

                           })
          `uvm_info("SAMPLE",$sformatf("tx.zmc_top_rstn=%b,tx.wr_rd=%b",tx.zmc_top_rstn,tx.wr_rd),UVM_MEDIUM)                  
           end
 /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// reset zero 
if(scenario == 17)
         begin
       //  repeat(1)begin
                    `uvm_do_with(tx,{ tx.zmc_top_rstn == 0;
                         tx.zmc_top_sw_rst==1;
                         tx.zmc_top_mem_init == 0;
                         tx.wr_rd == 1;                    
                         tx.awaddr ==0;         
                         tx.awlen == 0;                    
                         tx.awburst == 0;              
                         tx.wdata[0] == 0;     
                         tx.wstrb ==0;                 
                         tx.wlast == 0;        })
                    
          `uvm_info("SAMPLE",$sformatf("tx.zmc_top_rstn=%b,tx.wr_rd=%b",tx.zmc_top_rstn,tx.wr_rd),UVM_MEDIUM) 
            #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                           tx.zmc_top_rstn == 0;
                           tx.zmc_top_sw_rst==1;
                           tx.zmc_top_mem_init == 0;
                           tx.wr_rd == 0;                   
                           tx.araddr == 0;            
                           tx.arlen == 0;                 
                           tx.arburst ==0;         
    })

        //   end
end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//soft reset
/*/if(scenario == 16)
         begin
       //  repeat(1)begin
                    `uvm_do_with(tx,{tx.zmc_top_sw_rst == 0;
                   tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;                    // Write operation
                         tx.awaddr == 32'h100;            // Memory address
                         tx.awlen == 0;                    // Single transfer
                        // tx.awburst == 2'b00;              // INCR burst type
                        // tx.wdata[0] == 32'h55AA55AA;      // Test pattern
                         tx.wstrb == 4'b1111;                 
                         tx.wlast == 1;        })
          `uvm_info("SAMPLE",$sformatf("tx.zmc_top_sw_rst=%b,tx.wr_rd=%b",tx.zmc_top_sw_rst,tx.wr_rd),UVM_MEDIUM) 
            #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                           tx.zmc_top_mem_init == 1;
                           tx.zmc_top_sw_rst==0;
                            tx.wr_rd == 0;                    // Read operation
                            tx.araddr == 32'h100;            // Same memory address
                            tx.arlen == 0;                    // Single transfer
                            //tx.arburst == 2'b00;              // INCR burst type
    })

          //   end
end*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//mem initialisation scenario

      
       if(scenario == 2)
          // begin
          repeat(1) begin
        `uvm_info(get_type_name(), "Starting memory initialization test...", UVM_MEDIUM)

        `ifdef GLOBAL_MEM_INIT_0
            `uvm_info(get_type_name(), "GLOBAL_MEM_INIT is 0. Memory will be initialized to 32'h00000000.", UVM_MEDIUM)
        `else
            `uvm_info(get_type_name(), "GLOBAL_MEM_INIT is 1. Memory will be initialized to 32'h11111111.", UVM_MEDIUM)
        `endif

 `uvm_do_with(tx, { tx.zmc_top_rstn ==1 ;tx.zmc_top_mem_init == 1; tx.wr_rd == 1;                  
                         tx.awaddr == 32'h100;         
                         tx.awlen == 0;                  
                         tx.wstrb == 4'b1111;                 
                         tx.wlast == 1;       }) 


 #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                           tx.zmc_top_mem_init == 1;
                            tx.wr_rd == 0;                
                            tx.araddr == 32'h100;            
                            tx.arlen == 0;            
                              })

             `uvm_info("SAMPLE",$sformatf("tx.zmc_top_mem_init=%b",tx.zmc_top_mem_init),UVM_MEDIUM) 
                    end
                    // end
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//ecc disable scenario

     if(scenario == 3)
           begin

                         `uvm_do_with(tx, {
                         // Write transaction
                         tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;                
                         tx.awaddr == 32'h100;            
                         tx.awlen == 0;                   
                         tx.wstrb == 4'b1111;                 
                         tx.wlast == 1;               
    })




                       #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                           tx.zmc_top_mem_init == 1;
                            tx.wr_rd == 0;                    
                            tx.araddr == 32'h100;            
                            tx.arlen == 0;             
                               })
                           `uvm_info("WR_SEQ", "write and rd transaction are completed", UVM_MEDIUM)

         end



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//ecc enable scenario
         if(scenario == 4)
           begin

                         `uvm_do_with(tx, {
                         // Write transaction
                         tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;                    
                         tx.awaddr == 32'h100;            
                         tx.awlen == 0;                       
                         tx.wstrb == 4'b1111;                 
                         tx.wlast == 1;             
    })




                       #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                           tx.zmc_top_mem_init == 1;
                            tx.wr_rd == 0;                  
                            tx.araddr == 32'h100;            
                            tx.arlen == 0;                   
                                    
    })
                           `uvm_info("WR_SEQ", "write and rd transaction are completed", UVM_MEDIUM)

         end


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //parity generatorscenario
           if(scenario==5)begin
                    // First pattern
   		   `uvm_do_with(tx, {
 			 tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;
   		                 tx.awaddr == 'h100;
                         tx.awlen == 3;
   		                 tx.wstrb  == 4'hF;
   		                 tx.wlast == 1;   		   })
    
               end

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//interrupt enable scenario
 if(scenario==6)begin
    
                        `uvm_do_with(tx, {
 			             tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;
   		                 tx.awaddr == 32'h1000_0010;
                         tx.awlen == 0;
   		                 tx.wdata[0] == 32'h1122_3344;
                         tx.wstrb  == 4'b1111;
   		                 tx.wlast == 1;   		   })
   

   

                
               #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                            tx.zmc_top_mem_init == 1;
                            tx.wr_rd == 0;                   
                            tx.araddr == 32'h1000_0010;            
                            tx.arlen == 0;                   
                                       })
#100;
                           `uvm_info("WR_SEQ", "  interrupt enable double bit error injection and detection is completed", UVM_MEDIUM)

         end


////////////////////////////////////////////////////////////////////////////////////////////////////////////
//interrupt disable scenario
 if(scenario==7)begin
    
                    
   		   `uvm_do_with(tx, {
 			             tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;
   		                 tx.awaddr == 32'h1000_0010;
                         tx.awlen == 0;
   		                 tx.wdata[0] == 32'h1122_3344;
                         tx.wstrb  == 4'b1111;
   		                 tx.wlast == 1;   		   })
   

   

                
               #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                            tx.zmc_top_mem_init == 1;
                            tx.wr_rd == 0;                    
                            tx.araddr == 32'h1000_0010;            
                            tx.arlen == 0;                   
                                       })
#100;
                           `uvm_info("WR_SEQ", "interrupt disable  double bit error injection and detection is completed", UVM_MEDIUM)

         end

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//single wr_rd tx scenario
  if(scenario == 8)
           begin

                    // Write data pattern to test ECC
                       `uvm_do_with(tx, {
                         // Write transaction
                         tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;                   
                         tx.awaddr == 32'h101;            
                         tx.awlen == 0;                 
                         tx.wstrb == 4'b1111;                 
                         tx.wlast == 1;                   
    })



                       #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                           tx.zmc_top_mem_init == 1;
                            tx.wr_rd == 0;                 
                            tx.araddr == 32'h101;            
                            tx.arlen == 0;                    
                               
    })
                           `uvm_info("WR_SEQ", " single write and rd transaction are completed", UVM_MEDIUM)

         end
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//fixed burst wr rd tx

           if(scenario==9)begin
                        `uvm_do_with(tx, {
 			             tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;
   		                 tx.awaddr ==32'h110;
                         tx.awlen == 0;
   		                 tx.awburst == 2'b00;
                         tx.wstrb  == 4'b1111;
   		                 tx.wlast == 1;   		   })
    
               #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                            tx.zmc_top_mem_init == 1;
                            tx.wr_rd == 0;                    
                            tx.araddr == 32'h110;            
                            tx.arlen == 0;                    
                            tx.arburst == 2'b00;              
    })
#100;
                           `uvm_info("WR_SEQ", " fixed burts write and rd transaction are completed", UVM_MEDIUM)

         end

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//incremental burst wr rd scenario

           if(scenario==10)begin
                    // First pattern
   		   `uvm_do_with(tx, {
 			             tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;
   		                 tx.awaddr ==32'h100;
                         tx.awlen == 3;
   		                 tx.awburst == 2'b01;
                         tx.wstrb  == 4'b1111;
   		                 tx.wlast == 1;   		   })
    
               #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                            tx.zmc_top_mem_init == 1;
                            tx.wr_rd == 0;                   
                            tx.araddr == 32'h100;            
                            tx.arlen == 3;                    
                            tx.arburst == 2'b01;              
    })
#100;
                           `uvm_info("WR_SEQ", " incremental burts write and rd transaction are completed", UVM_MEDIUM)

         end
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//wrap burst wr_rd scenario

           if(scenario==11)begin
                    // First pattern
   		   `uvm_do_with(tx, {
 			             tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;
   		                 tx.awaddr ==32'h1000_0010;
                         tx.awlen == 5;                       
                         tx.awburst == 2'b10;
                         tx.wstrb  == 4'b1111;
   		                 tx.wlast == 1;   		   })
    
               #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                            tx.zmc_top_mem_init == 1;
                            tx.wr_rd == 0;                    
                            tx.araddr == 32'h1000_0010;          
                            tx.arlen == 5;                    
                            tx.arburst == 2'b10;              
    })
#100;
                           `uvm_info("WR_SEQ", " wrap burts write and rd transaction are completed", UVM_MEDIUM)

         end


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//single bit error injection

 if(scenario==12)begin
    
                          `uvm_do_with(tx, {
 			             tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;
   		                 tx.awaddr == 32'h1000_0010;
                         tx.awlen == 0;
   		                 tx.wdata[0] == 32'h1122_3344;
                         tx.wstrb  == 4'b1111;
   		                 tx.wlast == 1;   		   })
               
               #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                            tx.zmc_top_mem_init == 1;
                            tx.wr_rd == 0;                   
                            tx.araddr == 32'h1000_0010;            
                            tx.arlen == 0;                    
                                       })
#100;
                           `uvm_info("WR_SEQ", " single bit error injection and detection is completed", UVM_MEDIUM)

         end
         
         
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//double bit error injectiion
 if(scenario==13)begin
    
                         `uvm_do_with(tx, {
 			             tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;
   		                 tx.awaddr == 32'h1000_0010;
                         tx.awlen == 0;
   		                 tx.wdata[0] == 32'h1122_3344;
                         tx.wstrb  == 4'b1111;
   		                 tx.wlast == 1;   		   })
   

   

                
               #200;
                        // Read back the data to verify
                          `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                            tx.zmc_top_mem_init == 1;
                            tx.wr_rd == 0;                   
                            tx.araddr == 32'h1000_0010;           
                            tx.arlen == 0;                    
                                       })
#100;
                           `uvm_info("WR_SEQ", " double bit error injection and detection is completed", UVM_MEDIUM)

         end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//random wr rd test

 if(scenario==14)begin
     
     this.randomize();
                        `uvm_do_with(tx, {
 			             tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;
   		                 tx.awaddr ==local::addr; 
                         tx.awlen == 0;
   		                 tx.wstrb  == 4'b1111;
   		                 tx.wlast == 1;   
                        })
    
               #200;
                           `uvm_do_with(tx, {
                            // Read transaction
                            tx.zmc_top_rstn == 1;
                            tx.zmc_top_mem_init == 1;
                            tx.wr_rd == 0;                    
                            tx.araddr ==local::addr;             
                            tx.arlen == 0;                    
                             })
#100;
                           `uvm_info("WR_SEQ", " random write and rd transaction are completed", UVM_MEDIUM)

         end
         //////////////////////////////////////////////////////////////////////////////////////////////////////////////
//random wr test

 if(scenario==15)begin
    
                    // First pattern
   		   `uvm_do_with(tx, {
 			             tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 1;
   		                	   })
  
     
         end


         
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//random_rd_test
if(scenario==16)begin
    
                    // First pattern
   		   `uvm_do_with(tx, {
 			             tx.zmc_top_rstn == 1;
                         tx.zmc_top_mem_init == 1;
                         tx.wr_rd == 0;
   		                	   })
  
     
         end



   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 endtask
 endclass


