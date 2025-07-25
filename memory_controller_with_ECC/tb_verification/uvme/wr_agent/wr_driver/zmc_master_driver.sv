class zmc_master_driver extends uvm_driver #(zmc_master_tx);

  `uvm_component_utils(zmc_master_driver)

  // Interface handle
  virtual zmc_master_axi_interface vif;

  // Constructor
  function new(string name = "zmc_master_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db #(virtual zmc_master_axi_interface)::get(this, "", "zmc_master_axi_interface", vif)) begin
      `uvm_fatal("NOVIF", "Virtual interface not set for driver")
    end
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    zmc_master_tx tx;

            reset_signals();
            drive_mem_init(tx);
            forever begin
            seq_item_port.get_next_item(tx);

      
           if (tx.wr_rd) begin
           drive_write(tx);
           end
           else  begin
            drive_read(tx);
            end

      seq_item_port.item_done();
    end
  endtask


task reset_signals;
  begin
    // Assert reset
    @(posedge vif.zmc_top_clk);
    vif.master_driver_cb.zmc_top_rstn <= 0; 
    // Reset all signals to 0
    vif.master_driver_cb.zmc_top_mem_init <=0;
    vif.master_driver_cb.awaddr  <= 0;
    vif.master_driver_cb.awlen   <= 0;
    vif.master_driver_cb.awburst <= 0;
    vif.master_driver_cb.awvalid <= 0;
    vif.master_driver_cb.wdata   <= 0;
    vif.master_driver_cb.wstrb   <= 0;
    vif.master_driver_cb.wlast   <= 0;
    vif.master_driver_cb.wvalid  <= 0;
    vif.master_driver_cb.bready  <= 0;
    vif.master_driver_cb.araddr  <= 0;
    vif.master_driver_cb.arlen   <= 0;
    vif.master_driver_cb.arburst <= 0;
    vif.master_driver_cb.arvalid <= 0;
    vif.master_driver_cb.rready  <= 0;
    // Wait for a few clock cycles
  //repeat(2)
  //@(posedge vif.zmc_top_clk);
    // De-assert reset
    @(posedge vif.zmc_top_clk);
    vif.master_driver_cb.zmc_top_rstn <= 1; // Set reset to 1
  end
endtask



task drive_mem_init(zmc_master_tx tx);
  @(vif.master_driver_cb); // Synchronize with the appropriate scope

  // Step 1: Drive zmc_top_mem_init high
  vif.master_driver_cb.zmc_top_mem_init <= 1;

  // Step 2: Wait for MEM_init_ACK to be asserted
  wait(vif.master_driver_cb.MEM_init_ACK == 1);

  // Step 3: Capture the acknowledgment in tx structure
 // tx.MEM_init_ACK = vif.master_driver_cb.MEM_init_ACK;

  // Step 4: Deassert zmc_top_mem_init after acknowledgment
  vif.master_driver_cb.zmc_top_mem_init <= 0;

  // Step 5: Wait for MEM_init_ACK to be deasserted
  wait(vif.master_driver_cb.MEM_init_ACK == 0);

  // Ensure no retriggering happens
  @(posedge vif.zmc_top_clk); // Add a clock cycle delay if necessary
endtask
     
  // Drive AXI Write Transaction
  task drive_write(zmc_master_tx tx);
  begin
   repeat(4) @(posedge vif.zmc_top_clk);
    vif.master_driver_cb.awaddr <= tx.awaddr;
    vif.master_driver_cb.awlen <= tx.awlen;
    vif.master_driver_cb.awburst <= tx.awburst;
    vif.master_driver_cb.awvalid <= 1;
    @(posedge vif.zmc_top_clk);
    wait (vif.master_driver_cb.awready == 1);
    // Wait for handshake
     vif.master_driver_cb.awvalid <= 0;
    vif.master_driver_cb.awaddr <=0;
    vif.master_driver_cb.awlen <=0;
    vif.master_driver_cb.awburst <= 0;

    // Write data channel
    for (int i = 0; i < tx.awlen + 1; i++) begin
   
      vif.master_driver_cb.wdata <= tx.wdata[i];
      vif.master_driver_cb.wstrb <= tx.wstrb;
      vif.master_driver_cb.wlast <= (i == tx.awlen);
      vif.master_driver_cb.wvalid <= 1;
      @(posedge vif.zmc_top_clk);
      end
      wait (vif.master_driver_cb.wready == 1); 
       vif.master_driver_cb.wvalid <= 0;
       vif.master_driver_cb.wdata <= 0;
       vif.master_driver_cb.wstrb <= 0;
       vif.master_driver_cb.wlast <= 0;
       
    repeat(2) @(posedge vif.zmc_top_clk);
  vif.master_driver_cb.bready<=tx.bready;
 @(posedge vif.zmc_top_clk);
wait(vif.master_driver_cb.bvalid);
vif.master_driver_cb.bready<=0;
end
endtask

  // Drive AXI Read Transaction
  task drive_read(zmc_master_tx tx);
  begin
   repeat(4) @(posedge vif.zmc_top_clk);
    vif.master_driver_cb.araddr <= tx.araddr;
    vif.master_driver_cb.arlen <= tx.arlen;
    vif.master_driver_cb.arburst <= tx.arburst;
    vif.master_driver_cb.arvalid <= 1;
    wait (vif.master_driver_cb.arready == 1);
    vif.master_driver_cb.arvalid <= 0;
    vif.master_driver_cb.araddr <=0;
    vif.master_driver_cb.arlen <=0;
    vif.master_driver_cb.arburst <= 0;
 
vif.master_driver_cb.rready<=1;
for(int i=0;i<tx.arlen+1;i++)begin
@(posedge vif.zmc_top_clk);
wait(vif.master_driver_cb.rvalid);
    end
vif.master_driver_cb.rready<=1'b0;
end

  endtask
endclass

