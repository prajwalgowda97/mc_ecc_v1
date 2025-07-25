
class zmc_cov1 extends uvm_subscriber#(zmc_master_tx);
zmc_master_tx axi_tx;
int i;

//factory registration
    `uvm_component_utils(zmc_cov1)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

       // Covergroup for Input Signals
    covergroup input_signals_cg();
        option.per_instance = 1;

       
        cp_rst: coverpoint axi_tx.zmc_top_rstn
        {bins active = {1}; 
                bins low = {0}; 
               } 

        // Control Signals
         cp_soft_reset: coverpoint axi_tx.zmc_top_sw_rst
         { bins active = {1}; 
          bins low  = {0}; 
        
                }
        cp_mem_init: coverpoint axi_tx.zmc_top_mem_init
        {  bins low  = {0}; 
        bins high = {1}; 
               }

        // AXI4 Inputs
        cp_awaddr: coverpoint axi_tx.awaddr { bins low_range   = {[32'h0000_0000 : 32'h0000_FFFF]};  
                                             bins mid_range   = {[32'h0001_0000 : 32'h0FFF_FFFF]};  
                                             bins high_range  = {[32'h1000_0000 : 32'hFFFF_FFFF]};  
        } 
        cp_awlen: coverpoint axi_tx.awlen {  bins all_values = {0,3,7 };
                                             ignore_bins invalid_bins = {[1:2], [4:6], [8:15]};
        }
        cp_awburst: coverpoint axi_tx.awburst { bins burst[] = {[0:1]};}
        cp_awvalid: coverpoint axi_tx.awvalid { bins valid = {1};}

     cp_wdata: coverpoint axi_tx.wdata[i]
                                    {
                       bins auto_bin_max={[0:$]};
            } 
  
        cp_wlast: coverpoint axi_tx.wlast { bins last = {1};}

       cp_wstrb: coverpoint axi_tx.wstrb { bins fullword  = {4'b1111};  
                                       }

        cp_wvalid: coverpoint axi_tx.wvalid { bins valid = {1}; }

        cp_bready: coverpoint axi_tx.bready { bins ready = {1}; }

        cp_araddr: coverpoint axi_tx.araddr { bins low_range   = {[32'h0000_0000 : 32'h0000_FFFF]};  
                                       bins mid_range   = {[32'h0001_0000 : 32'h0FFF_FFFF]};  
                                       bins high_range  = {[32'h1000_0000 : 32'hFFFF_FFFF]};  
                                       }
        cp_arlen: coverpoint axi_tx.arlen { 
                                            bins all_values = {0,3,7 };
                                            ignore_bins invalid_bins = {[1:2], [4:6], [8:15]};

        }
        cp_arburst: coverpoint axi_tx.arburst { bins burst[]={[0:1]}; }
        cp_arvalid: coverpoint axi_tx.arvalid { bins valid = {1}; }

        cp_rready: coverpoint axi_tx.rready { bins ready = {1};}

           endgroup

          
    
     // Covergroup for Output Signals
    covergroup output_signals_cg();
        option.per_instance = 1;

        // AXI4 Outputs
        cp_awready: coverpoint axi_tx.awready { bins awready = {1}; }
        cp_wready: coverpoint axi_tx.wready { bins wready = {1}; }

        cp_bvalid: coverpoint axi_tx.bvalid { bins valid = {1}; }
        cp_bresp: coverpoint axi_tx.bresp { bins okay = {2'b00};
    
        }

        cp_arready: coverpoint axi_tx.arready { bins ready = {1}; }
        cp_rdata: coverpoint axi_tx.rdata[i]{
                             bins auto_bin_max={[0:$]};
            }
        cp_rlast: coverpoint axi_tx.rlast { bins last = {1};}
        cp_rvalid: coverpoint axi_tx.rvalid { bins valid = {1};  }
        cp_rresp: coverpoint axi_tx.rresp { bins okay = {2'b00};
              }

        // ECC Outputs
        cp_ecc_interrupt: coverpoint axi_tx.ECC_interrupt { bins active = {1};  }
        cp_mem_init_ack: coverpoint axi_tx.MEM_init_ACK
        {bins  ack_received = {1};
        bins not_ack_received ={0};
             }

        // ECC Status Register
        cp_ecc_status: coverpoint  axi_tx.o_ECC_STAUS_REG
 {
            bins no_error = {32'h00000000};
            bins single_bit_error = {32'h00000001};
            bins double_bit_error = {32'h00000002};
        }

     endgroup
    

         
  function new(string name,uvm_component parent);
        super.new(name,parent);

        input_signals_cg = new();
        output_signals_cg = new();
        
  endfunction
    

   

  virtual function void write(zmc_master_tx t);
     this.axi_tx = t;

     if (t != null) begin
                  input_signals_cg.sample();
                  output_signals_cg.sample(); 
                  end
 endfunction
endclass




class zmc_cov2 extends uvm_subscriber#(apb_tx);
apb_tx txn;
int i;
//factory registration
    `uvm_component_utils(zmc_cov2)

          
    covergroup apb_config_regs_cg();
        option.per_instance = 1;

        cp_apb_sel: coverpoint txn.i_psel { bins select = {1'b1};
                                        
        }
        cp_apb_enable: coverpoint txn.i_penable { bins enable = {1'b1};
                                                 bins disabled ={1'b0};                                     
                                                }
        cp_apb_write: coverpoint txn.i_pwrite { bins write = {1};}
        cp_apb_wdata: coverpoint txn.i_pwdata {  bins enable = {32'b00000001};
                                            bins disabled = {32'b00000000};
            }
        cp_apb_addr: coverpoint txn.i_paddr {ignore_bins addr_0x00 = {32'h00000000}; 
                                          bins addr_0x04 = {32'h00000004};  
                                          bins addr_0x08 = {32'h00000008};  
            }
        cp_apb_strobe: coverpoint txn.i_pstrb {  bins fullword  = {4'b1111}; }
        cp_ecc_clear:coverpoint txn.i_ECC_STAUS_REG_clear{ bins disabled ={1'b0}; }


    endgroup

  function new(string name,uvm_component parent);
             super.new(name,parent);
            apb_config_regs_cg = new();
  endfunction
    

   

  virtual function void write(apb_tx t);
     this.txn = t;

     if (t != null) begin
        
         `uvm_info("COVERAGE", "Sampling APB Transactions", UVM_MEDIUM)
          apb_config_regs_cg.sample();
     end
 endfunction
endclass


