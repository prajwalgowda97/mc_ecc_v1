
//master_transaction_class

class zmc_master_tx extends uvm_sequence_item; 
     rand bit wr_rd;
     rand logic zmc_top_rstn;
     rand logic zmc_top_sw_rst;
    // Write Address Channel
     rand bit [31:0] awaddr;
     rand bit [3:0]  awlen;
     rand bit [1:0]  awburst;
     rand bit        awvalid;
          bit        awready;
     // Write Data Channel
     rand bit [31:0] wdata[$];
     rand bit [3:0]  wstrb;
     rand bit        wlast;
     rand bit        wvalid;
     bit             wready;

  
  // Write Response Channel
     bit [1:0]  bresp;          
     bit        bvalid;  
    rand bit      bready;
 // Read Address Channel
    rand bit [31:0] araddr;    
    rand bit [3:0]  arlen;     
    rand bit [1:0]  arburst; 
    rand bit        arvalid;
        bit         arready;
 
 // Read Data Channel
    bit [31:0] rdata[$];        
    bit [1:0]  rresp;          
    bit        rlast;          
    bit        rvalid;     
    rand bit       rready;
    rand bit                     zmc_top_mem_init;
     bit                             ECC_interrupt;
     bit [31:0]                      o_ECC_STAUS_REG;
     bit                             MEM_init_ACK;

    
 
//factory registration
   `uvm_object_utils_begin(zmc_master_tx)

        `uvm_field_int(awaddr, UVM_ALL_ON)
        `uvm_field_int(awlen, UVM_ALL_ON)
        `uvm_field_int(awburst, UVM_ALL_ON)
        `uvm_field_int(awvalid, UVM_ALL_ON)
        `uvm_field_int(awready, UVM_ALL_ON)

        // Write Data Channel
        `uvm_field_queue_int(wdata, UVM_ALL_ON)
        `uvm_field_int(wstrb, UVM_ALL_ON)
        `uvm_field_int(wlast, UVM_ALL_ON)
        `uvm_field_int(wvalid, UVM_ALL_ON)
        `uvm_field_int(wready, UVM_ALL_ON)

        // Write Response Channel
        `uvm_field_int(bresp, UVM_ALL_ON)
        `uvm_field_int(bvalid, UVM_ALL_ON)
        `uvm_field_int(bready, UVM_ALL_ON)

        // Read Address Channel
        `uvm_field_int(araddr, UVM_ALL_ON)
        `uvm_field_int(arlen, UVM_ALL_ON)
        `uvm_field_int(arburst, UVM_ALL_ON)
        `uvm_field_int(arvalid, UVM_ALL_ON)
        `uvm_field_int(arready, UVM_ALL_ON)
        // Read Data Channel
        `uvm_field_queue_int(rdata, UVM_ALL_ON)
        `uvm_field_int(rresp, UVM_ALL_ON)
        `uvm_field_int(rlast, UVM_ALL_ON) 
        `uvm_field_int(rready, UVM_ALL_ON)
        `uvm_field_int(rvalid, UVM_ALL_ON)
        `uvm_field_int(zmc_top_mem_init,UVM_ALL_ON)


         `uvm_object_utils_end

//new constructor
	function new(string name="zmc_master_tx");
    		super.new(name);
  	endfunction


constraint valid_init 
{ zmc_top_mem_init inside {0, 1}; }


    constraint data_c{
        wdata.size() == awlen+1;
    }



endclass
