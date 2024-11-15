////////////////////////////////////////////////////////////////////////////////
//
//  Filename      : inp_driver.sv
//  Author        : MR
//  Creation Date : 08/01/2020
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
//  Driver Class for cuboid ingress port
////////////////////////////////////////////////////////////////////////////////

class new_inp_driver extends uvm_driver #(input_item);
  `uvm_component_utils(new_inp_driver)

  // =============================
  // Constructor Method
  // =============================
  function new(string name = "new_inp_driver", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual new_cuboid_inp_intf  vif      ;
  //cuboid                   cboid    ;
  input_item                   cboid    ;
  // uvm_sequencer #(cuboid)  sqncr    ;     // Sequencer Handle

  // =============================
  // Build Phase Method
  // =============================  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cboid = input_item::type_id::create("cboid", this);
    // sqncr = uvm_sequencer#(cuboid)::type_id::create("sqncr", this);
    if (!uvm_config_db#(virtual new_cuboid_inp_intf)::get(this, "", "cuboid_in_intf", vif))
      `uvm_fatal("INP_DRIVER", "Could not get vif")
   endfunction // build_phase

  // =============================
  // Main Phase Method
  // =============================
  virtual task main_phase(uvm_phase phase);
    super.main_phase(phase);
 
    forever begin
      seq_item_port.get_next_item(cboid);
      drive_item(cboid);
      seq_item_port.item_done();
    end

  endtask // main_phase

  // =============================
  // Driver Item
  // =============================
  virtual task drive_item(input_item drv_cboid);
    vif.valid  <= 1 ;
    vif.start  <= 1 ;
    vif.in_data <= drv_cboid.length ;
    @(posedge vif.clk);
    vif.in_data  <= drv_cboid.width  ;
    @(posedge vif.clk);
    vif.in_data <= drv_cboid.height ;
    @(posedge vif.clk);
    vif.valid  <= 0 ;
    vif.start <= 0 ;
    vif.in_data  <= 0 ;  

  endtask // drive_item  

endclass// inp_driver

