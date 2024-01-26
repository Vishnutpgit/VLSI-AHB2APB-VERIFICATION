module top;
  import uvm_pkg::*;
  import bus_pkg::*;

bit clock ;
  always 
    #10 clock = !clock ;

AHB_if ahb_if(clock);
APB_if apb_if(clock);


rtl_top DUT(  .Hclk(clock),
             .Hresetn(ahb_if.HRESETN),
                 .Htrans(ahb_if.HTRANS),
                   .Hsize(ahb_if.HSIZE),
                     .Hreadyin(ahb_if.HREADYIN),
                        .Hwdata(ahb_if.HWDATA),
                           .Haddr(ahb_if.HADDR),
                             .Hwrite(ahb_if.HWRITE),
                               .Prdata(apb_if.PRDATA),
                                  .Hrdata(ahb_if.HRDATA),
                                    .Hresp(ahb_if.HRESP),
                                      .Hreadyout(ahb_if.HREADYOUT),
                                         .Pselx(apb_if.PSELX),
                                           .Pwrite(apb_if.PWRITE),
                                             .Penable(apb_if.PENABLE),
                                                .Paddr(apb_if.PADDR),
                                                   .Pwdata(apb_if.PWDATA)
                    ) ;





 initial 
      begin 
        `ifdef VCS
          $fsdbDumpvars(0, top);
      	`endif

       uvm_config_db #(virtual AHB_if)::set(null , "*" , "mvif", ahb_if );
       uvm_config_db #(virtual APB_if)::set(null , "*" , "svif", apb_if );

       run_test();
      end
 
endmodule

 
