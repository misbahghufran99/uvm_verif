module tb_cuboid_prcr;
  import uvm_pkg::*;
  import cuboid_pkg::*;

// ====================================
// testbench signals
// ====================================
bit clk;

// ====================================
// Interface instant
// ====================================

new_cuboid_inp_intf cuboid_inp_if (.clk(clk));
new_cuboid_out_intf cuboid_out_if (.clk(clk));


// ====================================
// Design instant
// ====================================
  cuboid_prcr cuboid_prcr_inst(
  .clk         (clk),
  .in_valid    (cuboid_inp_if.valid  ),
  .in_data     (cuboid_inp_if.in_data ),
  .in_start       (cuboid_inp_if.start  ),
  //.height      (cuboid_inp_if.height ),
  .out_data        (cuboid_out_if.out_data   ),
  .out_start        (cuboid_out_if.start   ),
  .out_valid   (cuboid_out_if.valid  )
  );

// ====================================
// Initial Block
// ====================================
initial 
begin
  uvm_config_db #(virtual new_cuboid_inp_intf)::set(null, "uvm_test_top.env.ingr_agnt.drvr" , "cuboid_in_intf", cuboid_inp_if);
  uvm_config_db #(virtual new_cuboid_inp_intf)::set(null, "uvm_test_top.env.ingr_agnt.mntr", "cuboid_in_intf", cuboid_inp_if);
  uvm_config_db #(virtual new_cuboid_out_intf)::set(null, "uvm_test_top.env.egrs_agnt.mntr", "cuboid_o_intf" , cuboid_out_if);
  uvm_config_db #(virtual new_cuboid_inp_intf)::set(null, "uvm_test_top"                   , "cuboid_in_intf", cuboid_inp_if);
  run_test ();
end

// ====================================
// Interface instant
// ====================================
always 
  #5 clk = ~clk ;

endmodule : tb_cuboid_prcr         