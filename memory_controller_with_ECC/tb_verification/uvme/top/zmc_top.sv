
module zmc_top;

    
    import uvm_pkg::*;
    import test_pkg::*;
    
     logic zmc_top_clk,zmc_top_rstn;
     logic zmc_top_sw_rst;
    
zmc_master_axi_interface vif(zmc_top_clk,zmc_top_rstn,zmc_top_sw_rst);
apb_interface apb_vif(zmc_top_clk,zmc_top_rstn);


//dut instantiation
zmc_axi4_top  dut (.zmc_top_clk(vif.zmc_top_clk),
			            .zmc_top_rstn(vif.zmc_top_rstn),
			           .zmc_top_sw_rst(vif.zmc_top_sw_rst),
			            .zmc_top_mem_init(vif.zmc_top_mem_init),      
			            
			     	    .ECC_interrupt(vif.ECC_interrupt),
			            .MEM_init_ACK(vif.MEM_init_ACK),
			            .o_ECC_STAUS_REG(vif.o_ECC_STAUS_REG),
			//axi connections
			
			
			.awaddr(vif.awaddr),
			.awlen(vif.awlen),
			.awburst(vif.awburst),
			.awvalid(vif.awvalid),
			.awready(vif.awready),
			.wdata(vif.wdata),
			.wlast(vif.wlast),
			.wstrb(vif.wstrb),
			.wvalid(vif.wvalid),
			.wready(vif.wready),
			.bvalid(vif.bvalid),
			.bready(vif.bready),
			.bresp(vif.bresp),
			.araddr(vif.araddr),
			.arlen(vif.arlen),
			.arburst(vif.arburst),
			.arvalid(vif.arvalid),
			.rready(vif.rready),
			.arready(vif.arready),
			.rdata(vif.rdata),
			.rlast(vif.rlast),
			.rresp(vif.rresp),
			.rvalid(vif.rvalid),
 
			//registers
           	.i_psel(apb_vif.i_psel),
			.i_penable(apb_vif.i_penable),
			.i_pwrite(apb_vif.i_pwrite),
			.i_pwdata(apb_vif.i_pwdata),
			.i_paddr(apb_vif.i_paddr),
			.i_pstrb(apb_vif.i_pstrb),
            .i_ECC_STAUS_REG_clear(apb_vif.i_ECC_STAUS_REG_clear));

initial 
begin
  zmc_top_clk= 1'b0;
  forever begin #5 zmc_top_clk = 1'b1;

//`uvm_info("SAMPLE",$sformatf("vif.zmc_top_clk=%b,zmc_top_clk=%b",vif.zmc_top_clk,zmc_top_clk),UVM_MEDIUM)
//`uvm_info("SAMPLE",$sformatf("vif.zmc_top_clk=%b,zmc_top_clk=%b",vif.zmc_top_clk,zmc_top_clk),UVM_MEDIUM)

  #5 zmc_top_clk =1'b0;
 //`uvm_info("SAMPLE",$sformatf("vif.zmc_top_clk=%b,zmc_top_clk=%b",vif.zmc_top_clk,zmc_top_clk),UVM_MEDIUM)

end
 end

//Reset logic
initial begin
   @(posedge zmc_top_clk)
    zmc_top_rstn <= 0;//Initial reset
    #5;
    @(posedge zmc_top_clk)
    zmc_top_rstn<=1;

end







//soft reset
/*initial begin
  //  @(posedge zmc_top_clk)
    zmc_top_sw_rst <= 1;//Initial reset
    #5;
    //@(posedge zmc_top_clk)
    zmc_top_sw_rst<=0;
   #5;
    zmc_top_sw_rst <= 1;//Initial reset
    #5;
    //@(posedge zmc_top_clk)
    zmc_top_sw_rst<=0;


end*/



initial begin
    string test_name;
    if ($value$plusargs("UVM_TESTNAME=%s", test_name)) begin
        if (test_name == "double_bit_error_injection_test") begin
            force dut.dual_port_ram_inst.RAM_rd_data[13:12] =2'b00;
        end
    end
end

initial begin
    string test_name;
    if ($value$plusargs("UVM_TESTNAME=%s", test_name)) begin
        if (test_name == "single_bit_error_injection_test") begin
            force dut.dual_port_ram_inst.RAM_rd_data[24] = 1'b0;
        end
    end
end

initial begin
    string test_name;
    if ($value$plusargs("UVM_TESTNAME=%s", test_name)) begin
        if (test_name == "interrupt_enable_test") begin
            force dut.dual_port_ram_inst.RAM_rd_data[13:12] = 2'b00;
        end
    end
end


initial begin
    string test_name;
    if ($value$plusargs("UVM_TESTNAME=%s", test_name)) begin
        if (test_name == "interrupt_disable_test") begin
            force dut.dual_port_ram_inst.RAM_rd_data[13:12] = 2'b00;
        end
    end
end




initial begin

  uvm_config_db#(virtual zmc_master_axi_interface)::set(null,"*","zmc_master_axi_interface",vif);
   uvm_config_db#(virtual apb_interface)::set(null, "*", "apb_interface", apb_vif);
   end

//Run the test
initial begin
    run_test("zmc_base_test");
end
 
//wavedump
initial begin
	$shm_open("wave.shm");
	$shm_probe("AS");
end







endmodule
