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
ten_32_free_fit = 0.2010/2 * in_to_mm;
sample_wall_thickness = 0.25 * in_to_mm;

plate_thickness = box_z-soil_z;

// Box clamp screws (1/4-20)
clamp_screw_depth = 0.5 * in_to_mm;
clamp_to_edge = 0.5 * in_to_mm;

fillet_r = (1/8) * in_to_mm;


//
// Top plate and holes
//
difference()
{
    // Top Plate
    translate([0, 0, soil_z])
    cube([box_x, box_y, plate_thickness]);
    
    // Sample hole
    translate([box_x/2, box_y/2, soil_z])
    cylinder(h=soil_z, r=soil_r);
    
    // Hole for slider feet screws (10-32)
    slider_hole_offset = 1/8 * in_to_mm;
    translate([box_x/2+soil_r+slider_hole_offset, box_y/2-soil_r-slider_hole_offset, soil_z])
    cylinder(h=1.1*plate_thickness, r=ten_32_tap);
    
    // Hole for slider feet screws (10-32)
    translate([box_x/2-soil_r-slider_hole_offset, box_y/2-soil_r-slider_hole_offset, soil_z])
    cylinder(h=1.1*plate_thickness, r=ten_32_tap);
    
    // Hole for slider feet screws (10-32)
    translate([box_x/2+soil_r+slider_hole_offset, box_y/2+soil_r+slider_hole_offset, soil_z])
    cylinder(h=1.1*plate_thickness, r=ten_32_tap);
    
    // Hole for slider feet screws (10-32)
    translate([box_x/2-soil_r-slider_hole_offset, box_y/2+soil_r+slider_hole_offset, soil_z])
    cylinder(h=1.1*plate_thickness, r=ten_32_tap);
    
    // Fillet
    translate([0, 0, soil_z+plate_thickness/2])
    fillet(fillet_r, plate_thickness*1.1);
    
    // Fillet
    translate([box_x, 0, soil_z+plate_thickness/2])
    rotate([0, 0, 90])
    fillet(fillet_r, plate_thickness*1.1);
    
    // Fillet
    translate([box_x, box_y, soil_z+plate_thickness/2])
    rotate([0, 0, -180])
    fillet(fillet_r, plate_thickness*1.1);
    
    // Fillet
    translate([0, box_y, soil_z+plate_thickness/2])
    rotate([0, 0, -90])
    fillet(fillet_r, plate_thickness*1.1);
}

//
// Cylinder to hold soil sample
//
translate([box_x/2, box_y/2, 0])
difference()
{
    // Outer cylinder
    cylinder(h=soil_z, r=soil_r + sample_wall_thickness);
    
    // Hole for soil material
    cylinder(h=soil_z, r=soil_r);
}

//
// Drive side nub for clamp scres
//
difference()
{
    // Nub of material
    translate([box_x/2-soil_r-clamp_to_edge,box_y/2, soil_z+plate_thickness/2])
    cube([quarter_20_tap*4, quarter_20_tap*4, plate_thickness], center=true);
    
    // Clamp Screw Hole
    translate([box_x/2-soil_r-clamp_to_edge,box_y/2, box_z-clamp_screw_depth])
    cylinder(r=ten_32_free_fit, h=clamp_screw_depth);
    
    // Fillet
    translate([quarter_20_tap*-4, box_y/2+quarter_20_tap*2, soil_z+plate_thickness/2])
    rotate([0,0,-90])
    fillet(fillet_r, plate_thickness*1.1);
    
    // Fillet
    translate([quarter_20_tap*-4, box_y/2-quarter_20_tap*2, soil_z+plate_thickness/2])
    fillet(fillet_r, plate_thickness*1.1);
}

// Fillet
translate([0, box_y/2+quarter_20_tap*2, soil_z+plate_thickness/2])
rotate([0,0,90])
fillet(fillet_r, plate_thickness);

// Fillet
translate([0, box_y/2-quarter_20_tap*2, soil_z+plate_thickness/2])
rotate([0,0,180])
fillet(fillet_r, plate_thickness);

//
// Load Cell End Plate
//
end_plate_thickness = 0.5 * in_to_mm;

// Main block on outside of existing sample ring
difference()
{
    // Block to mount things to
    translate([box_x, box_y/2 - 0.75*box_y/2, 0])
    cube([end_plate_thickness, 0.75*box_y, soil_z+plate_thickness]);
    
    // Hole for clamp screw
    translate([box_x/2+soil_r+clamp_to_edge,box_y/2, 0])
    cylinder(r=ten_32_free_fit, h=box_z);
    
    // Mounting Screw for Push Retainer
    retainer_screw_depth = 0.5*in_to_mm;
    screw_z_offset = 0.25*in_to_mm;
    screw_y_offset = 0.625*in_to_mm;
    
    translate([box_x+end_plate_thickness, box_y/2 + screw_y_offset, box_z/2 + screw_z_offset])
    rotate([0, -90, 0])
    cylinder(r=ten_32_tap, h=retainer_screw_depth);

    translate([box_x+end_plate_thickness, box_y/2 + screw_y_offset, box_z/2 - screw_z_offset])
    rotate([0, -90, 0])
    cylinder(r=ten_32_tap, h=retainer_screw_depth);
    
    translate([box_x+end_plate_thickness, box_y/2 - screw_y_offset, box_z/2 + screw_z_offset])
    rotate([0, -90, 0])
    cylinder(r=ten_32_tap, h=retainer_screw_depth);
    
    translate([box_x+end_plate_thickness, box_y/2 - screw_y_offset, box_z/2 - screw_z_offset])
    rotate([0, -90, 0])
    cylinder(r=ten_32_tap, h=retainer_screw_depth);
}

// Block to smootly tranfer stress to sample ring
difference()
{
    translate([box_x-end_plate_thickness, box_y/2 - 0.75*box_y/2, 0])
    cube([end_plate_thickness, 0.75*box_y, soil_z]);
    
    translate([box_x/2, box_y/2, 0])
    cylinder(h=soil_z, r=soil_r + sample_wall_thickness);
}

