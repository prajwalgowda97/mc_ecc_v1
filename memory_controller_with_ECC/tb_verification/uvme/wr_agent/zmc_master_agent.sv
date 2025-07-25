//master agent class

class zmc_master_agent extends uvm_agent;

//declaring agent components
  zmc_master_driver  mdriver;
  zmc_master_sequencer msequencer;
  zmc_master_monitor   mmonitor;

// factory registration
  `uvm_component_utils(zmc_master_agent)

// new constructor
  	function new (string name="zmc_master_agent", uvm_component parent);
    		super.new(name, parent);
  	endfunction 

// build_phase
  	function void build_phase(uvm_phase phase);
    		super.build_phase(phase);
      		mdriver    = zmc_master_driver::type_id::create("mdriver", this);
      		msequencer = zmc_master_sequencer::type_id::create("msequencer", this);
           	mmonitor   = zmc_master_monitor::type_id::create("mmonitor", this);
        endfunction 


//connect phase
        function void connect_phase(uvm_phase phase);
                mdriver.seq_item_port.connect(msequencer.seq_item_export);
        endfunction

endclass
