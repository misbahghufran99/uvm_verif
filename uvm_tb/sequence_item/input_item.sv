class input_item extends uvm_sequence_item;

//`uvm_component_utils(input_item)

	function new(string name = "input_item");
    super.new(name);
  endfunction // new


rand bit      [16-1:0] length    ;
rand bit      [16-1:0] width     ;
rand bit      [16-1:0] height    ;
cuboid_config          cboid_cfg ;

  `uvm_object_utils_begin(input_item)
    `uvm_field_int(length, UVM_ALL_ON|UVM_NOCOMPARE)
    `uvm_field_int(width,  UVM_ALL_ON|UVM_NOCOMPARE)
    `uvm_field_int(height, UVM_ALL_ON|UVM_NOCOMPARE)
  `uvm_object_utils_end

    function input_item clone;
    input_item p;
    $cast(p, super.clone());
    return p;
  endfunction // clone

    virtual function void display_cuboid(string name);
    string msg;
    
    msg = $sformatf("\n This is being displayed  from %s \n", name);
    msg = {msg, $sformatf("================================================================\n")};
    msg = {msg, $sformatf("Length = %h, Width = %h, Height =%h \n", length, width, height)};
    `uvm_info(name, msg, UVM_MEDIUM)
  endfunction // display_pkt
	
endclass : input_item