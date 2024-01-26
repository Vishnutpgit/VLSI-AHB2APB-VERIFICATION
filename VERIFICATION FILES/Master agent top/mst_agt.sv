class mst_agt extends uvm_agent ;
 `uvm_component_utils(mst_agt)

 mst_monitor mst_mon ;
 mst_driver mst_drv ;
 mst_sequencer mst_seqr ;

 mst_agt_config mfg ;

 function new (string name = "mst_agt" , uvm_component parent = null);
 super.new(name,parent);
 endfunction


 function void build_phase(uvm_phase phase) ;

  mst_mon = mst_monitor::type_id::create("mst_mon",this);

  if(!uvm_config_db #(mst_agt_config)::get(this ,"" ,"mst_agt_config", mfg))
   `uvm_fatal("SRC_AGENT" ," failed in getting config")

  if(mfg.is_active == UVM_ACTIVE )
   begin

   mst_drv = mst_driver::type_id::create("mst_drv",this);

   mst_seqr =mst_sequencer::type_id::create("mst_seqr", this) ;

  end
 super.build_phase(phase) ;
 endfunction


 function void connect_phase(uvm_phase phase);

 if(mfg.is_active == UVM_ACTIVE )
  mst_drv.seq_item_port.connect(mst_seqr.seq_item_export);

 endfunction

endclass
