// OpenSCAD Herringbone Wade's Gears Script
// (c) 2011, Christopher "ScribbleJ" Jansen
//
// Thanks to Greg Frost for his great "Involute Gears" script.
//
// Licensed under the BSD license.
include <MCAD/involute_gears.scad> 

// Max resolution for printing
$fn=90;

// WHAT TO GENERATE?
generate = 2;    // GENERATE BOTH GEARS FOR VIEWING
// generate = 1;    // GENERATE STEPPER GEAR FOR PRINTING
// generate = 2;    // GENERATE DRIVE GEAR FOR PRINTING

// OPTIONS COMMON TO BOTH GEARS:
distance_between_axels = 110;
gear_h = 10;
gear_shaft_h = 0;


// GEAR1 (SMALLER GEAR, STEPPER GEAR) OPTIONS:
// It's helpful to choose prime numbers for the gear teeth.
gear1_teeth = 13;
gear1_shaft_d = 5;  			// diameter of motor shaft
gear1_shaft_r  = gear1_shaft_d/2;	
// gear1 shaft assumed to fill entire gear.
// gear1 attaches by means of a captive nut and bolt (or actual setscrew)
gear1_setscrew_offset = 5;			// Distance from motor on motor shaft.
gear1_setscrew_d = 3.5;		
gear1_setscrew_r = gear1_setscrew_d/2;
gear1_captive_nut_d = 6.2;
gear1_captive_nut_r  = gear1_captive_nut_d/2;
gear1_captive_nut_h = 3;


// GEAR2 (LARGER GEAR, DRIVE SHAFT GEAR) OPTIONS:
gear2_teeth = 200;
gear2_shaft_d = 58;
gear2_shaft_r  = gear2_shaft_d/2;
// gear2 has settable outer shaft diameter.
gear2_shaft_outer_d = 21;
gear2_shaft_outer_r  = gear2_shaft_outer_d/2;

// gear2 has a hex bolt set in it, is either a hobbed bolt or has the nifty hobbed gear from MBI on it.
gear2_bolt_hex_d       = 15;
gear2_bolt_hex_r        = gear2_bolt_hex_d/2;
// gear2_bolt_sink: How far down the gear shaft the bolt head sits; measured as distance from drive end of gear.
gear2_bolt_sink          = 15;		
// gear2's shaft is a bridge above the hex bolt shaft; this creates 1/3bridge_helper_h sized steps at top of shaft to help bridging.  (so bridge_helper_h/3 should be > layer height to have any effect)
bridge_helper_h=3;

gear2_rim_margin = 0;
gear2_cut_circles = 0;

// gear2 setscrew option; not likely needed.
gear2_setscrew_offset = 0;
gear2_setscrew_d = 0;
gear2_setscrew_r = gear2_setscrew_d / 2;
// captive nut for the setscrew
gear2_captive_nut_d = 0;
gear2_captive_nut_r  = gear2_captive_nut_d / 2;
gear2_captive_nut_h = 0;


// Tolerances for geometry connections.
AT=0.02;
ST=AT*2;
TT=AT/2;


module bridge_helper()
{
	//difference()
	//{
	//	translate([0,0,-bridge_helper_h/2])
	//	cylinder(r=gear2_bolt_hex_r+TT, h=bridge_helper_h+TT,$fn=6,center=true);
	//	translate([0,0,-bridge_helper_h/2])
	//	cube([gear2_bolt_hex_d+ST, gear2_shaft_d, bridge_helper_h+AT], center=true);
	//}
}



module gearsbyteethanddistance(t1=13, t2=51, d=60, teethtwist=1, which=1)
{
	cp = 360*d/(t1+t2);

	g1twist = 360 * teethtwist / t1;
	g2twist = 360 * teethtwist / t2;

	g1p_d  =  t1 * cp / 180;
	g2p_d  =  t2 * cp / 180;
	g1p_r   = g1p_d/2;
	g2p_r   = g2p_d/2;

	echo(str("Your small ", t1, "-toothed gear will be ", g1p_d, "mm across (plus 1 gear tooth size) (PR=", g1p_r,")"));
	echo(str("Your large ", t2, "-toothed gear will be ", g2p_d, "mm across (plus 1 gear tooth size) (PR=", g2p_r,")"));
	echo(str("Your minimum drive bolt length (to end of gear) is: ", gear2_bolt_sink+bridge_helper_h, "mm and your max is: ", gear_h+gear_shaft_h, "mm."));
	echo(str("Your gear mount axles should be ", d,"mm (", g1p_r+g2p_r,"mm calculated) from each other."));
	if(which == 1)
	{
		// GEAR 1
        union(){
            difference()
            {
                union()
                {
                    translate([0,0,(gear_h/2) - TT])
                        gear(	twist = g1twist, 
                            number_of_teeth=t1, 
                            circular_pitch=cp, 
                            gear_thickness = gear_shaft_h + (gear_h/2)+AT, 
                            rim_thickness = (gear_h/2)+AT, 
                            rim_width = 0,
                            hub_thickness = (gear_h/2)+AT, 
                            hub_width = 0,
                            bore_diameter=0); 
            
                    translate([0,0,(gear_h/2) + AT])
                    rotate([180,0,0]) 
                        gear(	twist = -g1twist, 
                            number_of_teeth=t1, 
                            circular_pitch=cp, 
                            gear_thickness = (gear_h/2)+AT, 
                            rim_thickness = (gear_h/2)+AT, 
                            hub_thickness = (gear_h/2)+AT, 
                            bore_diameter=0); 
                }
                //DIFFERENCE:
                //shafthole
                translate([0,0,-TT]) cylinder(r=gear1_shaft_r, h=gear_h+gear_shaft_h+ST, $fn=90);
            }
        }
        translate([2.5,0,(gear_shaft_h+gear_h)/2]) cube([2,5,gear_shaft_h+gear_h], center=true);
        translate([-2.5,0,(gear_shaft_h+gear_h)/2]) cube([2,5,gear_shaft_h+gear_h], center=true);
    }
	else
	{
		// GEAR 2
		difference()
		{
            union()
            {
                translate([0,0,(gear_h/2) - TT]) gear(	twist = -g2twist, 
                        number_of_teeth=t2, 
                        circular_pitch=cp, 
                        gear_thickness = gear_shaft_h + (gear_h/2)+AT, 
                        rim_thickness = (gear_h/2)+AT, 
                        rim_width = gear2_rim_margin,
                        hub_diameter = gear2_shaft_outer_d,
                        hub_thickness = (gear_h/2)+AT, 
                        bore_diameter=0,
                        circles = gear2_cut_circles); 
        
                translate([0,0,(gear_h/2) + AT]) rotate([180,0,0]) gear(twist = g2twist, 
                        number_of_teeth=t2, 
                        circular_pitch=cp, 
                        gear_thickness = (gear_h/2)+AT, 
                        rim_thickness = (gear_h/2)+AT, 
                        rim_width = gear2_rim_margin,
                        hub_diameter = gear2_shaft_outer_d,
                        hub_thickness = (gear_h/2)+AT, 
                        bore_diameter=0,
                        circles = gear2_cut_circles); 
            }
            
            //DIFFERENCE:
            //shafthole
			translate([0,0,-TT]) cylinder(r=gear2_shaft_r, h=gear_h+gear_shaft_h+ST, $fn=90);

            difference(){
                translate([0,0,3.5]) cylinder(d=200, d2=190, h=9, center=true, $fn=90);
                translate([0,0,3.5]) cylinder(d=gear2_shaft_d+6, h=9, center=true, $fn=90);
            }
            
            translate([0,0,3]) rotate([90,0,0+22.5]) cylinder(d=2, h=100, center=true, $fn=90);
            translate([0,0,3]) rotate([90,0,45+22.5]) cylinder(d=2, h=100, center=true, $fn=90);
            translate([0,0,3]) rotate([90,0,90+22.5]) cylinder(d=2, h=100, center=true, $fn=90);
            translate([0,0,3]) rotate([90,0,135+22.5]) cylinder(d=2, h=100, center=true, $fn=90);
		}
        difference(){
            union(){
                translate([0,0,6.5]) rotate([90,90,0]) cylinder(d=7, h=200, center=true, $fn=3);
                translate([0,0,6.5]) rotate([90,90,45]) cylinder(d=7, h=200, center=true, $fn=3);
                translate([0,0,6.5]) rotate([90,90,90]) cylinder(d=7, h=200, center=true, $fn=3);
                translate([0,0,6.5]) rotate([90,90,135]) cylinder(d=7, h=200, center=true, $fn=3);
            }
            translate([0,0,-TT]) cylinder(r=gear2_shaft_r, h=gear_h+gear_shaft_h+ST, $fn=90);
        }
	}
}


t1 = gear1_teeth;
t2 = gear2_teeth;
cp = 360*distance_between_axels / (t1 + t2);
g1p_d = t1 * cp / 180;
g2p_d = t2 * cp / 180;
g1p_r = g1p_d / 2;
g2p_r = g2p_d / 2;

if(generate == 1)
{
	mirror([0,0,1]) gearsbyteethanddistance(t1 = gear1_teeth, t2=gear2_teeth, d=distance_between_axels, which=1);
}
else if(generate == 2)
{
	gearsbyteethanddistance(t1 = gear1_teeth, t2=gear2_teeth, d=distance_between_axels, which=2);
}
else
{
	translate([-g1p_r,0,0]) rotate([0,0,($t * 360 / gear1_teeth)]) gearsbyteethanddistance(t1 = gear1_teeth, t2=gear2_teeth, d=distance_between_axels, which=1);
	translate([g2p_r,0,0])  rotate([0,0,($t * 360 / gear2_teeth)*-1]) gearsbyteethanddistance(t1 = gear1_teeth, t2=gear2_teeth, d=distance_between_axels, which=2);
}
