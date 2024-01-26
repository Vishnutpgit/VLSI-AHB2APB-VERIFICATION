class slv_monitor extends uvm_monitor ;
 `uvm_component_utils(slv_monitor)

 virtual APB_if.RD_MON_MP svif ;

 slv_agt_config scfg ;

 read_xtn xtn ; 

 uvm_analysis_port #(read_xtn) rd_mon_port ;

 function new (string name = "slv_monitor"  , uvm_component parent = null ) ;
 super.new(name,parent) ;
  rd_mon_port = new("rd_mon_port" ,this);
 endfunction

function void build_phase(uvm_phase phase) ;

   if(!uvm_config_db #(slv_agt_config)::get(this ,"" ,"slv_agt_config", scfg))
   `uvm_fatal("SLV_MON" ," failed in getting config")

 super.build_phase(phase) ;
 endfunction



 function void connect_phase(uvm_phase phase);
 svif = scfg.svif ;
 endfunction


task run_phase(uvm_phase phase);

forever 
collect_data();

endtask


task collect_data();

 xtn = read_xtn::type_id::create("xtn");

wait(svif.rd_mon_cb.PENABLE)

     xtn.PADDR[31:0] = svif.rd_mon_cb.PADDR[31:0] ;
     xtn.PWRITE = svif.rd_mon_cb.PWRITE ;
     xtn.PSELX[3:0] = svif.rd_mon_cb.PSELX[3:0] ;
 
if(xtn.PWRITE == 1)
  xtn.PWDATA[31:0] = svif.rd_mon_cb.PWDATA[31:0] ;
else
  xtn.PRDATA[31:0] = svif.rd_mon_cb.PRDATA[31:0] ;



@(svif.rd_mon_cb);
 rd_mon_port.write(xtn);
`uvm_info("SLV_MONITOR",$sformatf("printing from monitor \n %s", xtn.sprint()),UVM_LOW)

endtask






endclass
