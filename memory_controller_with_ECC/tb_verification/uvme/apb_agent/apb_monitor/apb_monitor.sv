
class apb_monitor extends uvm_monitor;

//factory registration
 `uvm_component_utils(apb_monitor)

    apb_tx  tx;
    virtual apb_interface apb_vif;

    uvm_analysis_port #(apb_tx )analysis_port;

//new constructor
    function new(string name="apb_monitor",uvm_component parent=null);
        super.new(name,parent);
          endfunction


function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     analysis_port=new("analysis_port",this);

    if (!uvm_config_db#(virtual apb_interface)::get(this, "", "apb_interface", apb_vif))
      `uvm_fatal("NOVIF", "Virtual interface not found in monitor")
  endfunction


   task run_phase(uvm_phase phase);
        fork
            forever begin
               @(posedge apb_vif.zmc_top_clk);
                  if(apb_vif.i_psel && apb_vif.i_penable && apb_vif.zmc_top_rstn) begin
                  tx = apb_tx::type_id::create("tx",this);
                  tx.i_paddr  = apb_vif.apb_monitor_cb.i_paddr;
                  tx.i_pwrite = apb_vif.apb_monitor_cb.i_pwrite;
                  tx.i_pstrb  = apb_vif.apb_monitor_cb.i_pstrb;
                  tx.i_psel   =  apb_vif.apb_monitor_cb.i_psel;
                  tx.i_penable =apb_vif.apb_monitor_cb.i_penable;
                  tx.zmc_top_rstn = apb_vif.apb_monitor_cb.zmc_top_rstn;

                  tx.i_ECC_STAUS_REG_clear = apb_vif.apb_monitor_cb.i_ECC_STAUS_REG_clear;
                      if (apb_vif.i_pwrite)
                       begin
                        tx.i_pwdata = apb_vif.i_pwdata;
                        @(posedge apb_vif.zmc_top_clk);
                        `uvm_info("MON", $sformatf("Mode : Write WDATA : %h ADDR : %0d", apb_vif.apb_monitor_cb.i_pwdata, apb_vif.apb_monitor_cb.i_paddr), UVM_NONE);
                       end
                       analysis_port.write(tx);
                end 
            end
        join_none
    endtask 
 
endclass    

