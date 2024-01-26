class sb extends uvm_scoreboard ;

 `uvm_component_utils(sb)


 int data_verified ;
 write_xtn que_w[$] ;
 read_xtn que_r[$];

 uvm_tlm_analysis_fifo #(write_xtn) fifo_wr ;

 uvm_tlm_analysis_fifo #(read_xtn) fifo_rd ;

 write_xtn wxtn , wxtn1 ,hcov;
 read_xtn rxtn,  rxtn1  ,pcov;



covergroup ahb_cg ;
  option.per_instance =1 ;
 HB: coverpoint hcov.HBURST{bins hburst_bin[] = {[0:7]};}
 HS: coverpoint hcov.HSIZE{bins hsize_bin[] = {[0:2]};}
 HT: coverpoint hcov.HTRANS{bins htrans_bin[] = {[2:3]};}
 HW: coverpoint hcov.HWRITE{bins hwrite_bin = {1}; }
 HA: coverpoint hcov.HADDR{bins haddr_bin1 = {[32'h8000_0000:32'h8000_03ff]};
                           bins haddr_bin2 = {[32'h8400_0000:32'h8400_03ff]};
                           bins haddr_bin3 = {[32'h8800_0000:32'h8800_03ff]};
                           bins haddr_bin4 = {[32'h8c00_0000:32'h8c00_03ff]};
                                                     }
 HWD: coverpoint hcov.HWDATA{bins hwdata_bin = {[32'h0000_0000:32'hffff_ffff]};}
 HR: coverpoint hcov.HRDATA{bins hrdata_bin = {[32'h0000_0000:32'hffff_ffff]};}

 C1:cross HS,HW,HT,HWD;
 C2:cross HS,HW,HR;

endgroup 



covergroup apb_cg;
  option.per_instance =1 ;
  ENABLE:coverpoint pcov.PENABLE{bins penable_bin = {1} ;}
  PWDATA:coverpoint pcov.PWDATA{bins pwdata_bin = {[32'h0000_0000:32'hffff_ffff]};}
  PWRITE: coverpoint pcov.PWRITE{bins pwrite_bin = {[0:1]};}
  PA: coverpoint pcov.PADDR{bins paddr_bin1 = {[32'h8000_0000:32'h8000_03ff]};
                            bins paddr_bin2 = {[32'h8400_0000:32'h8400_03ff]};
                            bins paddr_bin3 = {[32'h8800_0000:32'h8800_03ff]};
                            bins paddr_bin4 = {[32'h8c00_0000:32'h8c00_03ff]};
                                                     }
 
  PSEL:coverpoint pcov.PSELX{bins slave1 = {4'b0001};
                            bins slave2 = {4'b0010};
                            bins slave3 = {4'b0100};
                            bins slave4 = {4'b1000};
                                                     }
  
endgroup 






  function new(string name = "sb", uvm_component parent = null );
  super.new(name,parent);
  ahb_cg = new();
  apb_cg = new();
  endfunction






 function void build_phase(uvm_phase phase);
 super.build_phase(phase);
 fifo_wr = new("fifo_wr",this);
 fifo_rd = new("fifo_rd",this);
 endfunction

 task run_phase(uvm_phase phase);
 
 forever 
 begin
  fork
    begin
     fifo_wr.get(wxtn);
     que_w.push_back(wxtn);
     hcov = wxtn;
     ahb_cg.sample();
     $display("AHB coverage : %0d " , ahb_cg.get_coverage() );
    end
    begin 
     fifo_rd.get(rxtn);
     pcov = rxtn;
     apb_cg.sample();
      $display("APB coverage : %0d " , apb_cg.get_coverage() );
//     que_r.push_back(rxtn);
    end
  join
 wxtn1 = que_w.pop_front();
// rxtn1 = que_r.pop_front();
 check_data(wxtn1,rxtn);

 end



 endtask
    



function void check_data(write_xtn ahb_data,read_xtn apb_data);

  if(ahb_data.HWRITE)
  begin
    case(ahb_data.HSIZE)

    2'b00:
                begin
                        if(ahb_data.HADDR[1:0] == 2'b00)
                                compare_data(ahb_data.HWDATA[7:0], apb_data.PWDATA[7:0], ahb_data.HADDR, apb_data.PADDR);
                        if(ahb_data.HADDR[1:0] == 2'b01)
                                compare_data(ahb_data.HWDATA[15:8], apb_data.PWDATA[7:0], ahb_data.HADDR, apb_data.PADDR);
                        if(ahb_data.HADDR[1:0] == 2'b10)
                                compare_data(ahb_data.HWDATA[23:16], apb_data.PWDATA[7:0], ahb_data.HADDR, apb_data.PADDR);
                        if(ahb_data.HADDR[1:0] == 2'b11)
                                compare_data(ahb_data.HWDATA[31:24], apb_data.PWDATA[7:0], ahb_data.HADDR, apb_data.PADDR);

                end

    2'b01:
                begin
                        if(ahb_data.HADDR[1:0] == 2'b00)
                                compare_data(ahb_data.HWDATA[15:0], apb_data.PWDATA[15:0], ahb_data.HADDR, apb_data.PADDR);
                        if(ahb_data.HADDR[1:0] == 2'b10)
                                compare_data(ahb_data.HWDATA[31:16], apb_data.PWDATA[15:0], ahb_data.HADDR, apb_data.PADDR);
                end

                2'b10:
                        compare_data(ahb_data.HWDATA, apb_data.PWDATA, ahb_data.HADDR, apb_data.PADDR);

                endcase
        end

        else
        begin
                case(ahb_data.HSIZE)

                2'b00:
                begin
                        if(ahb_data.HADDR[1:0] == 2'b00)
                                compare_data(ahb_data.HRDATA[7:0], apb_data.PRDATA[7:0], ahb_data.HADDR, apb_data.PADDR);
                        if(ahb_data.HADDR[1:0] == 2'b01)
                                compare_data(ahb_data.HRDATA[7:0], apb_data.PRDATA[15:8], ahb_data.HADDR, apb_data.PADDR);
                        if(ahb_data.HADDR[1:0] == 2'b10)
                                compare_data(ahb_data.HRDATA[7:0], apb_data.PRDATA[23:16], ahb_data.HADDR, apb_data.PADDR);
                        if(ahb_data.HADDR[1:0] == 2'b11)
                                compare_data(ahb_data.HRDATA[7:0], apb_data.PRDATA[31:24], ahb_data.HADDR, apb_data.PADDR);

                end

                2'b01:
                begin
      if(ahb_data.HADDR[1:0] == 2'b00)
                                compare_data(ahb_data.HRDATA[15:0], apb_data.PRDATA[15:0], ahb_data.HADDR, apb_data.PADDR);
      if(ahb_data.HADDR[1:0] == 2'b10)
                                compare_data(ahb_data.HRDATA[15:0], apb_data.PRDATA[31:16], ahb_data.HADDR, apb_data.PADDR);
                end

                2'b10:
                        compare_data(ahb_data.HRDATA, apb_data.PRDATA, ahb_data.HADDR, apb_data.PADDR);

                endcase
        end
endfunction

function void compare_data(bit [31:0]HDATA,[31:0]PDATA,[31:0]HADDR,[31:0]PADDR);

  if(HADDR == PADDR)
    begin
                  $display("SB: Address Compared SUCCESSFULLY");
      $display("HADDR=%h, PADDR=%h", HADDR, PADDR);
    end
        else
          begin
                  $display("SB: Address Compared UNSUCCESSFULLY");
      $display("HADDR=%h, PADDR=%h", HADDR, PADDR);
           end



        if(HDATA == PDATA) 
    begin
                  $display("SB: Data Compared  SUCCESSFULLY");
      $display("HDATA=%h, PDATA=%h", HDATA, PDATA);
    end
        else
          begin
                   $display("SB: Data Compared UNSUCCESSFULLY");
      $display("HDATA=%h, PDATA=%h", HDATA, PDATA);
                 end

        data_verified ++;
  $display ("Data verified = %d", data_verified);
endfunction




 endclass
