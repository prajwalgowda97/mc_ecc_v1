class apb_driver extends uvm_driver#(apb_tx);

//factory registration
    	`uvm_component_utils(apb_driver)
     	apb_tx tx;

 virtual apb_interface apb_vif; // Virtual interface



//new constructor

  	function new(string name="apb_driver", uvm_component parent=null);
    		super.new(name,parent);
  	endfunction


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual apb_interface)::get(this,"","apb_interface",apb_vif))
	`uvm_error("apb_driver","virtual interface not set for apb driver")
	endfunction


  task write(apb_tx tx);
  
    @(posedge apb_vif.zmc_top_clk);
    apb_vif.apb_driver_cb.i_paddr   <= tx.i_paddr;
    apb_vif.apb_driver_cb.i_pwdata  <= tx.i_pwdata;
    apb_vif.apb_driver_cb.i_pwrite  <= 1'b1;
    apb_vif.apb_driver_cb.i_psel    <= 1'b1;
    apb_vif.apb_driver_cb.i_pstrb    <= 4'b1111;
    apb_vif.apb_driver_cb.i_ECC_STAUS_REG_clear  <= 1'b0;
    @(posedge apb_vif.zmc_top_clk);
    apb_vif.apb_driver_cb.i_penable <= 1'b1;
    `uvm_info("DRV", $sformatf("Mode : Write WDATA : %h ADDR : %0d", apb_vif.apb_driver_cb.i_pwdata, apb_vif.apb_driver_cb.i_paddr), UVM_NONE)        
    @(posedge apb_vif.zmc_top_clk);
    apb_vif.apb_driver_cb.i_psel    <= 1'b0;
    apb_vif.apb_driver_cb.i_penable <= 1'b0;
    apb_vif.apb_driver_cb.i_paddr   <= '0;
    apb_vif.apb_driver_cb.i_pwdata  <= '0;
    apb_vif.apb_driver_cb.i_pwrite  <= 1'b0;
    apb_vif.apb_driver_cb.i_pstrb   <= '0;
   // apb_vif.apb_driver_cb.i_ECC_STATUS_REG_clear <= 1'b0;
endtask
      
/////////////////////////////////////////

 task run_phase(uvm_phase phase);
    bit [31:0] data;
  // apb_vif.apb_driver_cb.zmc_top_rstn <= 1'b0;
  // apb_vif.apb_driver_cb.i_psel <= 0;
  // apb_vif.apb_driver_cb.i_penable <= 0;
  // apb_vif.apb_driver_cb.i_pwrite <= 0;
  // apb_vif.apb_driver_cb.i_paddr <= 0;
  // apb_vif.apb_driver_cb.i_pwdata <= 0;
  // apb_vif.apb_driver_cb.i_pstrb <= 0;
  // apb_vif.apb_driver_cb.i_ECC_STAUS_REG_clear  <= 0;
    forever begin
        seq_item_port.get_next_item(tx);
        if (tx.i_pwrite)
        begin
            write(tx);
        end
               seq_item_port.item_done();
    end
endtask
endclass
