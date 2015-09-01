$fn=100;

in_to_mm = 25.4;

frit_z = 0.25 * in_to_mm;
frit_r = 1.0075 * in_to_mm;

groove_depth = (1/32) * in_to_mm;
groove_width = (3/32) * in_to_mm;

difference()
{
    cylinder(r=frit_r, h=frit_z);
    
    num_grooves = floor(frit_r/groove_width);
    
    for (i=[0:num_grooves])
    {
        offset = 2 * i * groove_width;
        translate([-frit_r, offset-frit_r-groove_width/2, frit_z-groove_depth])
        cube([2*frit_r, groove_width, groove_depth]);
    }
}