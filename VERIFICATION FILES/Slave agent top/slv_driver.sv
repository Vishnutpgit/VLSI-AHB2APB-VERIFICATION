class slv_driver extends uvm_driver  #(read_xtn) ;
 `uvm_component_utils(slv_driver)

 virtual APB_if.RD_DRV_MP svif ;

 slv_agt_config scfg ;

 function new (string name = "slv_driver"  , uvm_component parent = null ) ;
 super.new(name,parent) ;
 endfunction


 function void build_phase(uvm_phase phase) ;

   if(!uvm_config_db #(slv_agt_config)::get(this ,"" ,"slv_agt_config", scfg))
   `uvm_fatal("SLV_DRV" ," failed in getting config")

 super.build_phase(phase) ;
 endfunction


 function void connect_phase(uvm_phase phase);
 svif = scfg.svif ;
 endfunction


task run_phase(uvm_phase phase) ;
forever  begin
 send_to_DUT();
 end
endtask


task send_to_DUT() ;

`uvm_info("SLV_DRIVER","Driving the slave ",UVM_LOW)
 

wait(svif.rd_drv_cb.PSELX != 0 ) 
 
 if(svif.rd_drv_cb.PWRITE == 0)
  begin
   if(svif.rd_drv_cb.PENABLE == 1)
     svif.rd_drv_cb.PRDATA[31:0] <= $random ;
  end  
repeat(2)
@(svif.rd_drv_cb);

endtask
 
endclass
