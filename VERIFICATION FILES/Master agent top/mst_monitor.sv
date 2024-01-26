class mst_monitor extends uvm_monitor ;
 `uvm_component_utils(mst_monitor) 

 virtual AHB_if.WR_MON_MP mvif ;

 mst_agt_config mcfg ;

 uvm_analysis_port #(write_xtn) wr_mon_port;

 function new (string name = "mst_monitor"  , uvm_component parent = null ) ;
 super.new(name,parent) ;
 wr_mon_port  = new("wr_mon_port" ,this);
 endfunction

function void build_phase(uvm_phase phase) ;

   if(!uvm_config_db #(mst_agt_config)::get(this ,"" ,"mst_agt_config", mcfg))
   `uvm_fatal("MST_MON" ," failed in getting config")

 super.build_phase(phase) ;
 endfunction

function void end_of_elaboration_phase(uvm_phase phase);
 uvm_top.print_topology;
endfunction

 function void connect_phase(uvm_phase phase);
 mvif = mcfg.mvif ;
 endfunction

 task run_phase(uvm_phase phase) ;
 
 forever 
  collect_data();

 endtask


 task  collect_data();

 write_xtn xtn ;
 xtn = write_xtn::type_id::create("xtn");
 
/* wait(mvif.wr_mon_cb.HTRANS == 2'b10 || mvif.wr_mon_cb.HTRANS == 2'b11 )
 xtn.HADDR = mvif.wr_mon_cb.HADDR ;
 xtn.HTRANS = mvif.wr_mon_cb.HTRANS ;
 xtn.HSIZE = mvif.wr_mon_cb.HSIZE ;
 xtn.HWRITE = mvif.wr_mon_cb.HWRITE ;
 xtn.HBURST = mvif.wr_mon_cb.HBURST ;

*/
repeat(2)
@(mvif.wr_mon_cb) ;

wait(mvif.wr_mon_cb.HREADYOUT && (mvif.wr_mon_cb.HTRANS== 2'b10 || mvif.wr_mon_cb.HTRANS==2'b11))
  if(mvif.wr_mon_cb.HWRITE) 
  begin
  xtn.HWDATA[31:0] = mvif.wr_mon_cb.HWDATA[31:0];
  end
  else 
  xtn.HRDATA[31:0] = mvif.wr_mon_cb.HRDATA[31:0];

 xtn.HADDR[31:0] = mvif.wr_mon_cb.HADDR[31:0] ;
 xtn.HTRANS[1:0] = mvif.wr_mon_cb.HTRANS[1:0] ;
xtn.HSIZE[2:0] = mvif.wr_mon_cb.HSIZE[2:0] ;
 xtn.HWRITE = mvif.wr_mon_cb.HWRITE ;
 xtn.HBURST[2:0] = mvif.wr_mon_cb.HBURST[2:0] ;
 xtn.HRESP[1:0] = mvif.wr_mon_cb.HRESP[1:0];
 xtn.HREADYOUT = mvif.wr_mon_cb.HREADYOUT;
 xtn.HREADYIN = mvif.wr_mon_cb.HREADYIN ;
`uvm_info("MST_MONITOR",$sformatf("printing from sequence \n %s", xtn.sprint()),UVM_LOW)  
 wr_mon_port.write(xtn);

 endtask 


endclass
