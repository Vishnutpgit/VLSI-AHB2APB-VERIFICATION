class mst_sequencer extends uvm_sequencer  #(write_xtn) ;
 `uvm_component_utils(mst_sequencer) 
 
  function new (string name = "mst_sequencer" ,uvm_component parent = null) ;
  super.new(name,parent) ;
  endfunction 

endclass 
