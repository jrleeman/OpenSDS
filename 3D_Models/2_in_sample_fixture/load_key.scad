$fn=100;

//
// Dimension Definitions
//
in_to_mm = 25.4;
ten_32_tap = 0.159/2 * in_to_mm;
ten_32_close_fit = 0.196/2 * in_to_mm;

plate_thickness = 0.25 * in_to_mm;
plate_width = 0.875 * in_to_mm;
plate_height = 0.5 * in_to_mm;

difference()
{
union()
{
rotate([0,-90,0])
cylinder(r=plate_width/2, h=plate_thickness);

translate([-plate_thickness, -plate_width/2, -plate_width/2])
cube([plate_thickness,plate_width,plate_width/2]);
}

rotate([0,-90,0])
cylinder(r=ten_32_close_fit, h=plate_thickness);

}