class zmc_master_monitor extends uvm_monitor;

  `uvm_component_utils(zmc_master_monitor)

  virtual zmc_master_axi_interface vif;  
  uvm_analysis_port#(zmc_master_tx) analysis_port;
 zmc_master_tx tx;

  // Constructor
  function new(string name = "zmc_master_monitor", uvm_component parent = null);
    super.new(name, parent);
     endfunction

  // Build phase to configure the interface
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     analysis_port = new("analysis_port", this);

    if (!uvm_config_db#(virtual zmc_master_axi_interface)::get(this, "", "zmc_master_axi_interface", vif))
      `uvm_fatal("ZMC_MON_ERR", "Virtual interface not set for monitor")
  endfunction

  task run_phase(uvm_phase phase);
 begin
tx=zmc_master_tx ::type_id::create("tx");

       forever begin
          @(posedge vif.zmc_top_clk);

      tx.zmc_top_sw_rst        = vif.master_monitor_cb.zmc_top_sw_rst;
      tx.zmc_top_rstn          = vif.master_monitor_cb.zmc_top_rstn;
      tx.zmc_top_mem_init      = vif.master_monitor_cb.zmc_top_mem_init;
      tx.ECC_interrupt         = vif.master_monitor_cb.ECC_interrupt;
      tx.MEM_init_ACK          = vif.master_monitor_cb.MEM_init_ACK;
      tx.o_ECC_STAUS_REG       = vif.master_monitor_cb.o_ECC_STAUS_REG;


      // Wait for valid and handshake
      if (vif.master_monitor_cb.awvalid && vif.master_monitor_cb.awready) begin
          tx.wr_rd =1;
        tx.awaddr = vif.master_monitor_cb.awaddr;
        tx.awburst = vif.master_monitor_cb.awburst;
        tx.awlen =   vif.master_monitor_cb.awlen;
        tx.awvalid = vif.master_monitor_cb.awvalid;
        tx.awready = vif.master_monitor_cb.awready;

        `uvm_info("ZMC_MON_INFO",  $sformatf("WRITE ADDR | Addr: 0x%h, Burst: %b, Length: %0d",  tx.awaddr, tx.awburst, tx.awlen), UVM_LOW)
               end
//write data channel
      if (vif.master_monitor_cb.wvalid && vif.master_monitor_cb.wready) begin
        tx.wdata.push_back(vif.master_monitor_cb.wdata);
        tx.wstrb = vif.master_monitor_cb.wstrb;
        tx.wlast = vif.master_monitor_cb.wlast;
        tx.wvalid = vif.master_monitor_cb.wvalid;
        tx.wready = vif.master_monitor_cb.wready;
       `uvm_info("ZMC_MON_INFO",  $sformatf("WRITE DATA | Data: %p, Strb: 0x%h, WLAST: %b",  tx.wdata, tx.wstrb, tx.wlast),  UVM_LOW)
        end

//write response
      if (vif.master_monitor_cb.bvalid && vif.master_monitor_cb.bready) begin
      tx.bresp = vif.bresp;
         tx.bvalid = vif.master_monitor_cb.bvalid;
        tx.bready = vif.master_monitor_cb.bready;
       `uvm_info("ZMC_MON_INFO", $sformatf("WRITE RESPONSE | BRESP: %b", tx.bresp),  UVM_LOW)              
      analysis_port.write(tx);
      `uvm_info(get_type_name(), $sformatf("FIFO Size: %0d", analysis_port.size()), UVM_MEDIUM)

       `uvm_info("ZMC_MON_INFO", $sformatf("WRITE RESPONSE | BRESP: %b", tx.bresp),  UVM_LOW)
    end
//read adress channel
      if (vif.master_monitor_cb.arvalid && vif.master_monitor_cb.arready) begin
          tx.wr_rd =0;
        tx.araddr = vif.master_monitor_cb.araddr;
        tx.arburst= vif.master_monitor_cb.arburst;
        tx.arlen = vif.master_monitor_cb.arlen;
        tx.arvalid = vif.master_monitor_cb.arvalid;
        tx.arready = vif.master_monitor_cb.arready;
       `uvm_info("ZMC_MON_INFO",  $sformatf("READ ADDR | Addr: 0x%h, Burst: %b, Length: %0d",  tx.araddr, tx.arburst, tx.arlen), UVM_LOW)
            end               
       //read data channel
      if (vif.master_monitor_cb.rvalid && vif.master_monitor_cb.rready) begin
        tx.rdata.push_back( vif.master_monitor_cb.rdata);
        tx.rlast =vif.master_monitor_cb.rlast;
        tx.rresp = vif.master_monitor_cb.rresp;
        tx.rvalid = vif.master_monitor_cb.rvalid;
        tx.rready = vif.master_monitor_cb.rready;
        `uvm_info("ZMC_MON_INFO",  $sformatf("READ DATA | Data:%p, RLAST: %0b, RRESP: %b",  tx.rdata, tx.rlast, tx.rresp),  UVM_LOW)
              analysis_port.write(tx);
              
        `uvm_info("ZMC_MON_INFO",  $sformatf("READ DATA | Data:%p, RLAST: %0b, RRESP: %b",  tx.rdata, tx.rlast, tx.rresp),  UVM_LOW)
      end
        end    
    end
  endtask
endclass


