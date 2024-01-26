class read_xtn extends uvm_sequence_item ;

 `uvm_object_utils(read_xtn)

function new(string name = "read_xtn");
super.new(name);
endfunction

bit [31:0] PADDR ;
bit [31:0] PWDATA;
rand bit [31:0] PRDATA;
bit PWRITE ;
bit [3:0]PSELX ;
bit PENABLE ;



function void do_print(uvm_printer printer);

super.do_print(printer);

printer.print_field("PADDR"   , this.PADDR    , 32  , UVM_HEX);
printer.print_field("PWDATA"  , this.PWDATA   , 32  , UVM_HEX);
printer.print_field("PRDATA"  , this.PRDATA   , 32  , UVM_HEX);
printer.print_field("PWRITE"  , this.PWRITE   , 1   , UVM_DEC);
printer.print_field("PSELX"   , this.PSELX    , 3   , UVM_BIN);
printer.print_field("PENABLE" , this.PENABLE  , 1   , UVM_DEC);

endfunction 


endclass 
