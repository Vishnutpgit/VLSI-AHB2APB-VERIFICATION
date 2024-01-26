class slv_agt extends uvm_agent ;
 `uvm_component_utils(slv_agt)

 slv_monitor slv_mon ;
 slv_driver slv_drv ;
 slv_sequencer slv_seqr ;

 slv_agt_config sfg ;

 function new (string name = "slv_agt" , uvm_component parent = null);
 super.new(name,parent);
 endfunction


 function void build_phase(uvm_phase phase) ;

  slv_mon = slv_monitor::type_id::create("slv_mon",this);

  if(!uvm_config_db #(slv_agt_config)::get(this ,"" ,"slv_agt_config", sfg))
   `uvm_fatal("SRC_AGENT" ," failed in getting config")

  if(sfg.is_active == UVM_ACTIVE )
   begin

   slv_drv = slv_driver::type_id::create("slv_drv",this);

   slv_seqr =slv_sequencer::type_id::create("slv_seqr", this) ;

  end
 super.build_phase(phase) ;
 endfunction

/* function void connect_phase(uvm_phase phase);
 
  if(sfg.is_active == UVM_ACTIVE )
    slv_drv.seq_item_port.connect(slv_seqr.seq_item_export) ;

 endfunction
*/
endclass
