$fn=100;

in_to_mm = 25.4;

load_plate_r = 1 * in_to_mm;
straight_depth = 0.5 * in_to_mm;
taper_depth = 0.25 * in_to_mm;
top_r = 0.5 * in_to_mm;

ball_percent_submerged = 0.75;
ball_bearing_diameter = 0.5 * in_to_mm;

// Plug for bottom
cylinder(straight_depth, load_plate_r, load_plate_r);

difference()
{
// Tapered Top
translate([0, 0, straight_depth])
cylinder(taper_depth, load_plate_r, top_r);

// Hole for ball
translate([0, 0, straight_depth+taper_depth+(1-ball_percent_submerged)*ball_bearing_diameter/2])
sphere(r=ball_bearing_diameter/2);
}