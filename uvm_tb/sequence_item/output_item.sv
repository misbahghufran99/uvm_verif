class output_item extends uvm_sequence_item;

//`uvm_component_utils(output_item)

	function new(string name = "output_item");
    super.new(name);
  endfunction // new


	bit           [32-1:0] area      ;
  bit           [32-1:0] volm      ;
  cuboid_config          cboid_cfg ;

    `uvm_object_utils_begin(output_item)
    `uvm_field_int(area,   UVM_ALL_ON)
    `uvm_field_int(volm,   UVM_ALL_ON)
  `uvm_object_utils_end

    function output_item clone;
    output_item p;
    $cast(p, super.clone());
    return p;
  endfunction // clone


    virtual function void display_cuboid(string name);
    string msg;
    
    msg = $sformatf("\n This is being displayed  from %s \n", name);
    msg = {msg, $sformatf("================================================================\n")};
   
    msg = {msg, $sformatf("Area = %h, volm = %h \n", area, volm)};
    `uvm_info(name, msg, UVM_MEDIUM)
  endfunction // display_pkt
	
endclass : output_item