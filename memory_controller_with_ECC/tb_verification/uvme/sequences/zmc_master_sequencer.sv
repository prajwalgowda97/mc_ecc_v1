

//master sequencer class


//typedef uvm_sequencer#(zmc_master_tx)zmc_master_sequencer

class zmc_master_sequencer extends uvm_sequencer#(zmc_master_tx);
 
    //zmc_master_tx tx;
//factory registration
    `uvm_component_utils(zmc_master_sequencer)

//new constructor
  	function new(string name="zmc_master_sequencer", uvm_component parent);
    		super.new(name,parent);
  	endfunction


endclass
