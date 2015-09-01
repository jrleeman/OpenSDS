$fn=100;

//http://forum.openscad.org/rounded-corners-td3843.html
module fillet(r, h) {
    translate([r / 2, r / 2, 0])

        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);

            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);

        }
}


//
// Dimension Definitions
//
in_to_mm = 25.4;

soil_z = 0.75 * in_to_mm;
soil_r = 1.0075 * in_to_mm;

box_x = 2.625 * in_to_mm;
box_y = 2.625 * in_to_mm; 
box_z = 1 * in_to_mm;


quarter_20_tap = 0.2010/2 * in_to_mm;
ten_32_tap = 0.159/2 * in_to_mm;

sample_wall_thickness = 0.25 * in_to_mm;

plate_thickness = box_z-soil_z;

// Box clamp screws (1/4-20)
clamp_screw_depth = 0.5 * in_to_mm;
clamp_to_edge = 0.5 * in_to_mm;

fillet_r = (1/8) * in_to_mm;

//
// Load Cell End Plate
//
end_plate_thickness = 0.5 * in_to_mm;

// Main block on outside of existing sample ring
difference()
{
    // Block to mount things to
    cube([end_plate_thickness, 0.75*box_y, soil_z+plate_thickness]);
    
    
    // Fillet
    translate([end_plate_thickness, 0, box_z/2])
    rotate([0, 0, 90])
    fillet(fillet_r, box_z*1.1);
    
    // Fillet
    translate([end_plate_thickness, box_y*0.75, box_z/2])
    rotate([0, 0, 180])
    fillet(fillet_r, box_z*1.1);
    
    // Mounting Screw for Push Retainer
    retainer_screw_depth = end_plate_thickness;
    screw_z_offset = 0.25*in_to_mm;
    screw_y_offset = 0.625*in_to_mm;
    
    translate([end_plate_thickness, box_y*0.75/2+screw_y_offset, box_z/2 + screw_z_offset])
    rotate([0, -90, 0])
    cylinder(r=ten_32_tap, h=retainer_screw_depth);
    
    translate([end_plate_thickness, box_y*0.75/2-screw_y_offset, box_z/2 + screw_z_offset])
    rotate([0, -90, 0])
    cylinder(r=ten_32_tap, h=retainer_screw_depth);
    
    translate([end_plate_thickness, box_y*0.75/2+screw_y_offset, box_z/2 - screw_z_offset])
    rotate([0, -90, 0])
    cylinder(r=ten_32_tap, h=retainer_screw_depth);
    
    translate([end_plate_thickness, box_y*0.75/2-screw_y_offset, box_z/2 - screw_z_offset])
    rotate([0, -90, 0])
    cylinder(r=ten_32_tap, h=retainer_screw_depth);
    
    // Recess spots for screw heads
    recess_depth = 0.2 * in_to_mm;
    recess_radius = 0.32/2 * in_to_mm;
    
    translate([end_plate_thickness, box_y*0.75/2+screw_y_offset, box_z/2 + screw_z_offset])
    rotate([0, -90, 0])
    cylinder(r=recess_radius, h=recess_depth);
    
    translate([end_plate_thickness, box_y*0.75/2-screw_y_offset, box_z/2 + screw_z_offset])
    rotate([0, -90, 0])
    cylinder(r=recess_radius, h=recess_depth);
    
    translate([end_plate_thickness, box_y*0.75/2+screw_y_offset, box_z/2 - screw_z_offset])
    rotate([0, -90, 0])
    cylinder(r=recess_radius, h=recess_depth);
    
    translate([end_plate_thickness, box_y*0.75/2-screw_y_offset, box_z/2 - screw_z_offset])
    rotate([0, -90, 0])
    cylinder(r=recess_radius, h=recess_depth);
    
    // Slot for push peg key
    slot_width = 0.875 * in_to_mm;
    slot_height = 0.5 * in_to_mm;
    slot_depth = 0.25 * in_to_mm;
    
    translate([0, 0.75*box_y/2-slot_width/2,0])
    cube([slot_depth, slot_width, slot_height]);

    translate([0, 0.75*box_y/2,slot_height])
    rotate([0,90,0])
    cylinder(r=slot_width/2, h=slot_depth);
    
    // Slot for push peg rod
    rod_slot_width = 0.5 * in_to_mm;
    rod_slot_height = 0.5 * in_to_mm;
    rod_slot_depth = 0.25 * in_to_mm;
    
    translate([end_plate_thickness-rod_slot_depth, 0.75*box_y/2-rod_slot_width/2,0])
    #cube([rod_slot_depth, rod_slot_width, rod_slot_height]);

    translate([end_plate_thickness-rod_slot_depth, 0.75*box_y/2,rod_slot_height])
    rotate([0,90,0])
    cylinder(r=rod_slot_width/2, h=rod_slot_depth);
}


