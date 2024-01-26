class env_config extends uvm_object;
bit has_scoreboard = 1;
bit has_mst_agt = 1;
bit has_slv_agt = 1;
bit has_virtual_sequencer = 1;

mst_agt_config mcfg ;
slv_agt_config scfg ;

`uvm_object_utils(env_config)
//------------------------------------------
extern function new(string name = "env_config");

endclass: env_config
//-----------------  constructor new method  -------------------//

function env_config::new(string name = "env_config");
  super.new(name);
endfunction
