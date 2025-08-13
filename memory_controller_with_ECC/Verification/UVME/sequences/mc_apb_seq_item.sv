class mc_apb_seq_item extends uvm_sequence_item;

                  logic                        i_psel                                   ;
                  logic                        i_penable                                ;
                  logic                        i_pwrite                                 ;
                  logic [31:0]                 i_pwdata                                 ;
                  logic [9:0]                  i_paddr                                  ;
                  logic [3:0]                  i_pstrb                                  ;
                  logic                        i_ECC_STAUS_REG_clear                    ;
 
 //factory registration
 `uvm_object_utils_begin(mc_apb_seq_item)
                        `uvm_field_int(i_psel               ,UVM_ALL_ON) 
                        `uvm_field_int(i_penable            ,UVM_ALL_ON)
                        `uvm_field_int(i_pwrite             ,UVM_ALL_ON)
                        `uvm_field_int(i_pwdata             ,UVM_ALL_ON)
                        `uvm_field_int(i_paddr              ,UVM_ALL_ON)
                        `uvm_field_int(i_pstrb              ,UVM_ALL_ON)
                        `uvm_field_int(i_ECC_STAUS_REG_clear,UVM_ALL_ON)

 `uvm_object_utils_end


 //constructor
  function new(string name="mc_apb_seq_item");
   super.new(name);
  endfunction
constraint c_paddr {i_paddr inside {0, 4, 8}; }

endclass
