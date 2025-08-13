class mc_axi_monitor extends uvm_monitor;

    `uvm_component_utils(mc_axi_monitor)

    virtual mc_interface intf;
    mc_axi_seq_item axi_seq_item;
    
    // Analysis port to send transactions to the scoreboard
    uvm_analysis_port #(mc_axi_seq_item) axi_analysis_port;
    

    //constructor
    function new (string name ="mc_axi_monitor", uvm_component parent =null);
        super.new(name, parent);
        `uvm_info("AXI_Monitor_class", "Inside Constructor!", UVM_MEDIUM)
    endfunction

    //build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        `uvm_info("AXI_Monitor_class", "Inside Build Phase!", UVM_MEDIUM)
        if (!uvm_config_db#(virtual mc_interface)::get(this, "*", "mc_interface", intf)) 
        begin
            `uvm_fatal(get_full_name(), "Error while getting read interface from top axi monitor")
        end

        axi_analysis_port = new("axi_analysis_port", this);
    
    endfunction

    //run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

    endtask

endclass
