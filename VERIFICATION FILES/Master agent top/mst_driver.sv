class mst_driver extends uvm_driver #(write_xtn) ;
 `uvm_component_utils(mst_driver) 
 
 virtual AHB_if.WR_DRV_MP mvif ;

 mst_agt_config mcfg ;

 function new (string name = "mst_driver"  , uvm_component parent = null ) ;
 super.new(name,parent) ;
 endfunction 


 function void build_phase(uvm_phase phase) ;
 
   if(!uvm_config_db #(mst_agt_config)::get(this ,"" ,"mst_agt_config", mcfg))
   `uvm_fatal("MST_DRV" ," failed in getting config")

 super.build_phase(phase) ;
 endfunction 


 function void connect_phase(uvm_phase phase);
 mvif = mcfg.mvif ;
 endfunction 


task run_phase(uvm_phase phase) ;

@(mvif.wr_drv_cb);
  mvif.wr_drv_cb.HRESETN <= 0;
repeat(1)
begin
@(mvif.wr_drv_cb);
  mvif.wr_drv_cb.HRESETN <= 1;
end
 
forever 
begin
  seq_item_port.get_next_item(req);  
  send_to_DUT(req);
  seq_item_port.item_done();
end

endtask 



task send_to_DUT(write_xtn xtn);

`uvm_info("MST_DRIVER",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW)
mvif.wr_drv_cb.HTRANS[1:0] <= xtn.HTRANS[1:0];
mvif.wr_drv_cb.HADDR[31:0]  <= xtn.HADDR[31:0];
mvif.wr_drv_cb.HSIZE[2:0] <= xtn.HSIZE[2:0] ;
mvif.wr_drv_cb.HWRITE <= xtn.HWRITE;
mvif.wr_drv_cb.HBURST[2:0] <= xtn.HBURST[2:0];
mvif.wr_drv_cb.HREADYIN <= 1 ;
@(mvif.wr_drv_cb);
wait(mvif.wr_drv_cb.HREADYOUT)
 if(xtn.HWRITE)
  mvif.wr_drv_cb.HWDATA[31:0] <= xtn.HWDATA[31:0] ;
 else 
  mvif.wr_drv_cb.HWDATA[31:0] <= 32'd0 ;

endtask 

endclass
