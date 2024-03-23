interface apb_if (input pclk);
   logic [31:0]   paddr;
   logic [31:0]   pwdata;
   logic [31:0]   prdata;
   logic          pwrite;
   logic          psel;
   logic          penable;
   logic          presetn;
   logic          valid_in;
   logic          data_in;
   logic          valid_out;
   logic          out_port1;
   logic          out_port2;
   logic          out_port3;
   logic          out_port4;
endinterface
