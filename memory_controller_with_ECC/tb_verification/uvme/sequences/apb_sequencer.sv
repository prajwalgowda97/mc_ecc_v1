


class apb_sequencer extends uvm_sequencer#(apb_tx);
    
    apb_tx tx;
//factory registration
       `uvm_component_utils(apb_sequencer)

//new constructor
  	function new(string name="apb_sequencer", uvm_component parent=null);
    		super.new(name,parent);
  	endfunction



endclass
