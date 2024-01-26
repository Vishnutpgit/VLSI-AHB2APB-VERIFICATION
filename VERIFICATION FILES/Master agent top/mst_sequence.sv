class mst_sequence extends uvm_sequence #(write_xtn) ;

`uvm_object_utils(mst_sequence)

 bit [2:0]hburst;
 bit [2:0]hsize;
 bit [31:0]haddr;
 bit hwrite;
 bit  [9:0] length;

function new(string name = "mst_sequence");
super.new(name);
endfunction

endclass










class single_sequence extends mst_sequence ;

`uvm_object_utils(single_sequence)
function new(string name = "single_sequence");
super.new(name);
endfunction

task body();

begin
 req = write_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with {HTRANS == 2'b10 ;
                              HBURST == 3'b000 ;
                              HWRITE == 1'b1 ; });
hburst = $urandom_range(2,3) ;
$display("hburst : %0d ",hburst, $time);
hsize = req.HSIZE;
haddr = req.HADDR;
hwrite = req.HWRITE;
length = req.LENGTH;
`uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW) 
 finish_item(req);
end

endtask


endclass
















class incr_sequence extends mst_sequence ;

`uvm_object_utils(incr_sequence)
function new(string name = "incr_sequence");
super.new(name);
endfunction

task body();
begin
 req = write_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with {HTRANS == 2'b10 ;
                              HBURST inside{3,5,7} ;
                              HWRITE == 1'b1 ; });
hburst = req.HBURST;
//$display("hburst : %0d ",hburst, $time);
hsize = req.HSIZE;
haddr = req.HADDR;
hwrite = req.HWRITE;
length = req.LENGTH;
`uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
 finish_item(req);
end


begin

 if(hburst == 3'b011)//INCR4
 begin 
          for(int i =0 ; i<3 ; i++)
             begin 
              //    req = write_xtn::type_id::create("req");
                  start_item(req);
                     if(hsize == 3'b000) 
                      begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == haddr + 1'b1; });
                     `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                      end
                     if(hsize == 3'b001)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == haddr + 2'b10; });
                      `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                       end
                     if(hsize == 3'b010)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == haddr + 3'b100 ;});
                       `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                       end
                  finish_item(req);
                  haddr = req.HADDR;
          end
    end




 else if(hburst == 3'b101)//INCR8
 begin
          for(int i =0 ; i<7 ; i++)
             begin
             //  req = write_xtn::type_id::create("req");
                  start_item(req);
                     if(hsize == 3'b000)
                      begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == haddr + 1'b1 ;});
                      `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                      end
                     if(hsize == 3'b001)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;   
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == haddr + 2'b10 ;});
                       `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                       end
                     if(hsize == 3'b010)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == haddr + 3'b100 ;});
                       `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                       end
                  finish_item(req);
                  haddr = req.HADDR;
          end
    end




else  if(hburst == 3'b111)//INCR16
 begin
          for(int i =0 ; i<15 ; i++)
             begin
             //  req = write_xtn::type_id::create("req");
                  start_item(req);
                     if(hsize == 3'b000)
                      begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == haddr + 1'b1 ;});
                    `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                      end
                     if(hsize == 3'b001)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == haddr + 2'b10 ;});
                      `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)

                       end
                     if(hsize == 3'b010)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == haddr + 3'b100 ;});
                      `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                       end
                  finish_item(req);
                  haddr = req.HADDR;
          end
    end







end

endtask

endclass



















class wrap_sequence extends mst_sequence ;

`uvm_object_utils(wrap_sequence)
function new(string name = "wrap_sequence");
super.new(name);
endfunction

task body();
begin
 req = write_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with {HTRANS == 2'b10 ;
                              HBURST inside{2,4,6} ;
                              HWRITE == 1'b1 ; });
hburst = req.HBURST;
//$display("hburst : %0d ",hburst, $time);
hsize = req.HSIZE;
haddr = req.HADDR;
hwrite = req.HWRITE;
length = req.LENGTH;
`uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
 finish_item(req);
end


begin
 if(hburst == 3'b010)//WRAP4
 begin 
          for(int i =0 ; i<3 ; i++)
             begin 
               //   req = write_xtn::type_id::create("req");
                  start_item(req);
                     if(hsize == 3'b000) 
                      begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == {haddr[31:2],haddr[1:0]+ 1'b1} ;});
                      `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                      end
                     if(hsize == 3'b001)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == {haddr[31:3],haddr[2:0]+ 2'b10} ;});
                       `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                       end
                     if(hsize == 3'b010)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == {haddr[31:4],haddr[3:0]+ 3'b100} ;});
                       `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                       end
                  finish_item(req);
                 haddr = req.HADDR;
          end
    end




else if(hburst == 3'b100)//WRAP8
 begin
          for(int i =0 ; i<7 ; i++)
             begin
            //   req = write_xtn::type_id::create("req");
                  start_item(req);
                     if(hsize == 3'b000)
                      begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == {haddr[31:3],haddr[2:0]+ 1'b1} ;});
                      `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                      end
                     if(hsize == 3'b001)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == {haddr[31:4],haddr[3:0]+ 2'b10} ;});
                      `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                       end
                     if(hsize == 3'b010)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == {haddr[31:5],haddr[4:0]+ 3'b100} ;});
                      `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                       end
                  finish_item(req);
                   haddr = req.HADDR;
          end
    end





else if(hburst == 3'b110)//WRAP16
 begin
          for(int i =0 ; i<15 ; i++)
             begin
            //   req = write_xtn::type_id::create("req");
                  start_item(req);
                     if(hsize == 3'b000)
                      begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == {haddr[31:4],haddr[3:0]+ 1'b1} ;});
                     `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                      end
                     if(hsize == 3'b001)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == {haddr[31:5],haddr[4:0]+ 1'b10} ;});
                     `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                       end
                     if(hsize == 3'b010)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == {haddr[31:6],haddr[5:0]+ 3'b100} ;});
                      `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                       end
                  finish_item(req);
                   haddr = req.HADDR;
          end
    end

end

endtask

endclass
















class undf_sequence extends mst_sequence ;

`uvm_object_utils(undf_sequence)
function new(string name = "undf_sequence");
super.new(name);
endfunction

task body();
begin
 req = write_xtn::type_id::create("req");
 start_item(req);
 assert(req.randomize() with {HTRANS == 2'b10 ;
                              HBURST == 1  ;
                              HWRITE == 1'b1 ; });
hburst = req.HBURST;
//$display("hburst : %0d ",hburst, $time);
hsize = req.HSIZE;
haddr = req.HADDR;
hwrite = req.HWRITE;
length = req.LENGTH;
`uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
 finish_item(req);
end



begin 
 if(hburst == 3'b001)//UNDEFINED_INCR
 begin
          for(int i =0 ; i< length   ; i++)
             begin
            //      req = write_xtn::type_id::create("req");
                  start_item(req);
                     if(hsize == 3'b000)
                      begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == haddr + 1'b1 ;});
                      `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                      end
                     if(hsize == 3'b001)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == haddr + 2'b10 ;});
                        `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
                       end
                     if(hsize == 3'b010)
                       begin
                           assert(req.randomize() with {HTRANS == 3'b011 ;
                              LENGTH == length ;
                              HSIZE == hsize ;
                              HBURST == hburst ;
                              HWRITE == hwrite ;
                              HADDR == haddr + 3'b100 ;});
                       `uvm_info("MST_SEQUENCE",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)

                       end
                  finish_item(req);
                 haddr = req.HADDR;
          end
    end

end

endtask 

endclass
