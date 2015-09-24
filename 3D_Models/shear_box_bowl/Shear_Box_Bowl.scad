
$fn=50;
in_to_mm = 25.4;

module fillet(r, h) {
    translate([r / 2, r / 2, 0])

        difference() {
            cube([r + 0.01, r + 0.01, h], center = true);

            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true);

        }
}


box_x = 6 * in_to_mm;
box_y = 4 * in_to_mm; 
box_z = 2.25 * in_to_mm; 
box_thickness = (3/16) * in_to_mm;

difference()
{
        
    // Main block of material
    cube([box_x, box_y, box_z]);
        
    // Internal Cutout
    translate([box_thickness, box_thickness, box_thickness])
    cube([box_x-2*box_thickness, box_y-2*box_thickness, box_z]);
    

 
//    minkowski()
//    {
//        translate([case_x/-2, case_y/-2,0])
//        cube(size=[case_x,case_y,case_z]);
//        cylinder(r=case_radius);
//    }
}

// Add fillets
rounding_radius = (1/8) * in_to_mm;
translate([box_thickness, box_thickness, (box_z-box_thickness)/2 + box_thickness])
fillet(rounding_radius, box_z-box_thickness);


translate([box_x-box_thickness, box_thickness, (box_z-box_thickness)/2 + box_thickness])
rotate([0,0,90])
fillet(rounding_radius, box_z-box_thickness);

translate([box_thickness, box_y-box_thickness, (box_z-box_thickness)/2 + box_thickness])
rotate([0,0,-90])
fillet(rounding_radius, box_z-box_thickness);

translate([box_x-box_thickness, box_y-box_thickness, (box_z-box_thickness)/2 + box_thickness])
rotate([0,0,180])
fillet(rounding_radius, box_z-box_thickness);
