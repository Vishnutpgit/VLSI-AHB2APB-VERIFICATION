class test extends uvm_test ;

 `uvm_component_utils(test)

  single_sequence sngl_seqh ;
  env envh ;
  env_config env_cfg;
  bit has_scoreboard = 1;
  bit has_mst_agt = 1;
  bit has_slv_agt = 1; 
  bit has_virtual_sequencer = 0;



function new(string name = "test", uvm_component parent = null ) ;
super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase) ;

super.build_phase(phase);
  env_cfg = env_config::type_id::create("env_cfg");
  env_cfg.has_scoreboard = has_scoreboard ;
  env_cfg.has_mst_agt  = has_mst_agt ;
  env_cfg.has_slv_agt  = has_slv_agt ;
  env_cfg.mcfg = mst_agt_config::type_id::create("mcfg");
  env_cfg.scfg = slv_agt_config::type_id::create("scfg");
  env_cfg.mcfg.is_active = UVM_ACTIVE;
  env_cfg.scfg.is_active = UVM_ACTIVE;  

  if(!uvm_config_db #(virtual AHB_if)::get(this, "", "mvif", env_cfg.mcfg.mvif))
   `uvm_fatal("MVIF","failed in getting the config")

  if(!uvm_config_db #(virtual APB_if)::get(this, "", "svif", env_cfg.scfg.svif))
   `uvm_fatal("SVIF","failed in getting the config")

	
  env_cfg.has_virtual_sequencer = has_virtual_sequencer;
  uvm_config_db #(env_config)::set(this,"*","env_config",env_cfg);    
  envh = env::type_id::create("envh",this);
endfunction


endclass






class single_test extends test ; 

`uvm_component_utils(single_test)

//single_sequence sngl_seqh ;

function new(string name = "single_test",uvm_component parent = null);
super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase );
 super.build_phase(phase);
endfunction


task run_phase(uvm_phase phase);

phase.raise_objection(this);

 sngl_seqh = single_sequence::type_id::create("sngl_seqh",this);
 sngl_seqh.start(envh.magt.mst_seqr);

phase.drop_objection(this);

endtask


endclass  









class incr_test extends test ;

`uvm_component_utils(incr_test)

incr_sequence incr_seqh ;

function new(string name = "incr_test" ,uvm_component parent = null );
super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase );
 super.build_phase(phase);
endfunction


task run_phase(uvm_phase phase);

phase.raise_objection(this);
 
 incr_seqh = incr_sequence::type_id::create("incr_seqh");

 incr_seqh.start(envh.magt.mst_seqr);

#100;

phase.drop_objection(this);

endtask


endclass












class wrap_test extends test ;

`uvm_component_utils(wrap_test)

wrap_sequence wrap_seqh ;

function new(string name = "wrap_test" ,uvm_component parent = null );
super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase );
 super.build_phase(phase);
endfunction


task run_phase(uvm_phase phase);

phase.raise_objection(this);

 wrap_seqh = wrap_sequence::type_id::create("wrap_seqh");

 wrap_seqh.start(envh.magt.mst_seqr);

#100;

phase.drop_objection(this);

endtask


endclass



















class undf_test extends test ;

`uvm_component_utils(undf_test)

undf_sequence undf_seqh ;

function new(string name = "undf_test" ,uvm_component parent = null );
super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase );
 super.build_phase(phase);
endfunction


task run_phase(uvm_phase phase);

phase.raise_objection(this);

 undf_seqh = undf_sequence::type_id::create("undf_seqh");

 undf_seqh.start(envh.magt.mst_seqr);

#100;

phase.drop_objection(this);

endtask


endclass
