class env extends uvm_env ;

 `uvm_component_utils(env)

  mst_agt magt;
  slv_agt  sagt;

  env_config env_cfg;

  sb sbh;


function new(string name = "env",uvm_component parent = null);
 super.new(name,parent);
endfunction


function void build_phase(uvm_phase phase);
 super.build_phase(phase);


 if(!uvm_config_db #(env_config)::get(this, "", "env_config",env_cfg ))
    `uvm_fatal("ENV","failed in getting config")

 if(env_cfg.has_mst_agt) begin
 uvm_config_db #(mst_agt_config)::set(this,"*","mst_agt_config",env_cfg.mcfg);

 magt =  mst_agt::type_id::create(" magt ", this);
 end








  if(env_cfg.has_slv_agt) begin
 uvm_config_db #(slv_agt_config)::set(this,"*","slv_agt_config",env_cfg.scfg);

  sagt =  slv_agt::type_id::create(" sagt ", this);
 end

 if(env_cfg.has_scoreboard)
  sbh = sb::type_id::create("sbh",this);

// if(env_cfg.has_virtual_sequencer)
  
endfunction


function void connect_phase(uvm_phase phase);

  magt.mst_mon.wr_mon_port.connect(sbh.fifo_wr.analysis_export);

  sagt.slv_mon.rd_mon_port.connect(sbh.fifo_rd.analysis_export);


endfunction


endclass
