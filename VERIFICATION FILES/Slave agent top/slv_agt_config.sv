class slv_agt_config extends uvm_object;


  `uvm_object_utils(slv_agt_config)

virtual APB_if svif; 

uvm_active_passive_enum is_active = UVM_ACTIVE;

// Declare the mon_rcvd_xtn_cnt as static int and initialize it to zero
static int mon_rcvd_xtn_cnt = 0;

// Declare the drv_data_sent_cnt as static int and initialize it to zero
static int drv_data_sent_cnt = 0;

function new(string name = "slv_agt_config");
  super.new(name);
endfunction

endclass
