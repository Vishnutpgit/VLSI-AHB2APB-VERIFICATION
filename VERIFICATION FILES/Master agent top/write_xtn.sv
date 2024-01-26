class write_xtn extends uvm_sequence_item ;
 `uvm_object_utils(write_xtn)

function new(string name = "write_xtn");
super.new(name);
endfunction

rand bit HWRITE       ;
rand bit[31:0] HADDR  ;
rand bit[2:0] HSIZE   ;
rand bit[31:0]HWDATA  ; 
bit[31:0]HRDATA       ;
rand bit[1:0]HTRANS   ;
rand bit[9:0]LENGTH   ;
bit HRESETN           ;
bit HREADYOUT         ;
bit HREADYIN          ; 
bit[1:0]HRESP         ;
rand bit[2:0] HBURST  ;

constraint valid_hsize { HSIZE inside {[0:2]} ;}
constraint valid_length { (2**HSIZE)*LENGTH <=1024 ;}
constraint valid_addr { HSIZE ==1 -> HADDR%2 == 0 ;
                        HSIZE ==2 -> HADDR%4 == 0 ; }
 constraint Haddr_range{ HADDR inside {[32'h8000_0000 : 32'h8000_03FF],
                                      [32'h8400_0000 : 32'h8400_03FF],
                                      [32'h8800_0000 : 32'h8800_03FF],
                                      [32'h8c00_0000 : 32'h8c00_03FF] };}


function void do_print(uvm_printer printer);
super.do_print(printer);

printer.print_field("HWRITE",   this.HWRITE , 1 ,UVM_DEC);
printer.print_field("HADDR" ,   this.HADDR  , 32 , UVM_HEX);
printer.print_field("HWDATA",   this.HWDATA , 32 , UVM_HEX);
printer.print_field("HRDATA",   this.HRDATA , 32 , UVM_HEX);
printer.print_field("HSIZE" ,   this.HSIZE  , 3  , UVM_DEC);
printer.print_field("HTRANS",   this.HTRANS , 2  , UVM_DEC);
printer.print_field("LENGTH",   this.LENGTH , 10 , UVM_DEC);
printer.print_field("HRESETN",  this.HRESETN, 1  , UVM_DEC);
printer.print_field("HREADYOUT",this.HREADYOUT , 1 , UVM_DEC);
printer.print_field("HREADYIN", this.HREADYIN , 1 , UVM_DEC);
printer.print_field("HRESP"   , this.HRESP , 2  , UVM_DEC);
printer.print_field("HBURST"  , this.HBURST , 3, UVM_DEC);

endfunction 


endclass  

  
