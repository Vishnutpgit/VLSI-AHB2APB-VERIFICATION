class slv_sequencer extends uvm_sequencer ;// #(read_xtn) ;
 `uvm_component_utils(slv_sequencer)

  function new (string name = "slv_sequencer" ,uvm_component parent = null) ;
  super.new(name,parent) ;
  endfunction

endclass
