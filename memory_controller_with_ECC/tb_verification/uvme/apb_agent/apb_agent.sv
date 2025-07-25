

class apb_agent extends uvm_agent;


//declaring agent components
  apb_driver  apb_driver_inst;
  apb_sequencer apb_sequencer_inst;
  apb_monitor   apb_monitor_inst;

// factory registration
  `uvm_component_utils(apb_agent)

// new constructor
  	function new (string name="apb_agent", uvm_component parent=null);
    		super.new(name, parent);
  	endfunction 

// build_phase
  	function void build_phase(uvm_phase phase);
    		super.build_phase(phase);
      		apb_driver_inst    = apb_driver::type_id::create("apb_driver_inst", this);
      		apb_sequencer_inst = apb_sequencer::type_id::create("apb_sequencer_inst", this);
            apb_monitor_inst   = apb_monitor::type_id::create("apb_monitor_inst", this);
        endfunction 


//connect phase
        function void connect_phase(uvm_phase phase);
            	apb_driver_inst.seq_item_port.connect(apb_sequencer_inst.seq_item_export);
        endfunction


endclass
