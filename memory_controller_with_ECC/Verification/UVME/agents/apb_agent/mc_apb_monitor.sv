class mc_apb_monitor extends uvm_monitor;

    `uvm_component_utils(mc_apb_monitor)

    virtual mc_apb_interface apb_intf;
    mc_apb_seq_item apb_seq_item;
    
    // Analysis port to send transactions to the scoreboard
    uvm_analysis_port #(mc_apb_seq_item) apb_analysis_port;
    

    //constructor
    function new (string name ="mc_apb_monitor", uvm_component parent =null);
        super.new(name, parent);
        `uvm_info("apb_Monitor_class", "Inside Constructor!", UVM_MEDIUM)
    endfunction

    //build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        `uvm_info("APB_Monitor_class", "Inside Build Phase!", UVM_MEDIUM)
        if (!uvm_config_db#(virtual mc_apb_interface)::get(this, "*", "mc_apb_interface", apb_intf)) 
        begin
            `uvm_fatal(get_full_name(), "Error while getting read interface from top apb monitor")
        end

        apb_analysis_port = new("apb_analysis_port", this);
    
    endfunction

    //run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);

    endtask

endclass
