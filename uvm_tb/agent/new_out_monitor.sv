////////////////////////////////////////////////////////////////////////////////
//
//  Filename      : out_monitor.sv
//  Author        : MR
//  Creation Date : 10/07/2020
//
//  Copyright 2020 Sahil Semiconductor. All Rights Reserved.
//
//  No portions of this material may be reproduced in any form without
//  the written permission of:
//
//    Sahil Semiconductor
//    1601 McCarthy Blvd
//    Milpitas CA – 95035
//
//  All information contained in this document is Sahil Semiconductor
//  company private, proprietary and trade secret.
//
//  Description
//  ===========
//  This is the Monitor for output interface of cuboid module
////////////////////////////////////////////////////////////////////////////////

class new_out_monitor extends uvm_monitor;
  `uvm_component_utils(new_out_monitor)

  // =============================
  // Constructor Method
  // =============================
  function new(string name="out_monitor", uvm_component parent=null);
    super.new(name, parent);
  endfunction // new

  uvm_analysis_port#(output_item) mon_analysis_port;
  virtual new_cuboid_out_intf    vif   ;
  
  //cuboid    cboid      ;
  output_item    cboid      ;
  
  // =============================
  // Build Phase Method
  // =============================
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual new_cuboid_out_intf)::get(this, "", "cuboid_o_intf", vif))
      `uvm_fatal("NEW OUT_MONITOR", "Could not get vif")
    mon_analysis_port = new ("mon_analysis_port", this);
  endfunction // build_phase


  // =============================
  // Main Phase Method
  // =============================
  virtual task main_phase(uvm_phase phase);
    super.main_phase(phase);
    fork
      collect_data();
    join_none
    
  endtask // main_phase

  // =============================
  // Collecting data
  // =============================
  task collect_data ;
    forever begin
      //======================================================//
      // collecting cuboid at valid                           //
      //======================================================//
      if (vif.valid) begin
        //cboid.display_cuboid("NEW OUTPUT_MONOTOR Chal gya");   
        cboid       = output_item::type_id::create("Output Monitor Pkt");
        cboid.area  = vif.out_data;
        @(posedge vif.clk);
        cboid.volm  = vif.out_data;
        cboid.display_cuboid("NEW OUTPUT_MONOTOR");      
        mon_analysis_port.write(cboid);
      end
      @(posedge vif.clk);
    end
  endtask

endclass 
