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


in_to_mm = 25.4;

box_x = 4 * in_to_mm;
box_y = 3 * in_to_mm; 
box_z = 1 * in_to_mm; 
box_thickness = (3/16) * in_to_mm;

soil_z = 0.75 * in_to_mm;
soil_r = 1.0075 * in_to_mm;

quarter_20_tap = 0.2010/2 * in_to_mm;

push_cutout_depth = 0.5 * in_to_mm;
push_cutout_width = 1.5 * in_to_mm;

fillet_r = (1/8) * in_to_mm;

corner_cut = 0.25 * in_to_mm;

difference()
{
        
    // Main block of material
    cube([box_x, box_y, box_z]);
        
    // Material hole
    sample_x_inset = 1.75 * in_to_mm;
    translate([sample_x_inset ,box_y/2, box_z-soil_z])
    cylinder(soil_z, soil_r, soil_r);
    
    // Cut off corners to help insertion    
    rotate([0,0,45])
    translate([0,0, box_z/2])
    cube([corner_cut, corner_cut, box_z*1.5], center=true);
    
    
    translate([box_x,0, box_z/2])
    rotate([0,0,45])
    cube([corner_cut, corner_cut, box_z*1.5], center=true);
    
    translate([box_x, box_y, box_z/2])
    rotate([0,0,45])
    cube([corner_cut, corner_cut, box_z*1.5], center=true);
    
    translate([0, box_y, box_z/2])
    rotate([0,0,45])
    cube([corner_cut, corner_cut, box_z*1.5], center=true);

    // Box clamp screws
    clamp_screw_depth = 0.5 * in_to_mm;
    clamp_to_edge = 0.5 * in_to_mm;
    
    translate([sample_x_inset-soil_r-clamp_to_edge,box_y/2, box_z-clamp_screw_depth])
    cylinder(clamp_screw_depth, quarter_20_tap, quarter_20_tap);
    
    translate([sample_x_inset+soil_r+clamp_to_edge,box_y/2, box_z-clamp_screw_depth])
    cylinder(clamp_screw_depth, quarter_20_tap, quarter_20_tap);
    
    // Cutout for inserting push rod    
    translate([box_x-push_cutout_depth, (box_y-push_cutout_width)/2, 0])
    cube([push_cutout_depth, push_cutout_width, box_z]);
    
    // Remove fillets on corners of push out area
    // Factor of 1.5 on height is just to ensure full cut on the design
    translate([box_x, box_y-push_cutout_width*1.5, box_z/2])
    rotate([0,0,180])
    fillet(fillet_r, box_z*1.5);
    
    translate([box_x, box_y-push_cutout_width*0.5, box_z/2])
    rotate([0,0,90])
    fillet(fillet_r, box_z*1.5);
}

// Add fillets for push rod area to reduce stress concentrations

translate([box_x-push_cutout_depth, box_y-push_cutout_width*1.5, box_z/2])
fillet(fillet_r, box_z);

translate([box_x-push_cutout_depth, box_y-push_cutout_width*0.5, box_z/2])
rotate([0,0,-90])
fillet(fillet_r, box_z);
