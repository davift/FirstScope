// Back Cover
difference() {
    translate([71.5,-9,66]) color("white") cube([59,127,128], center=true);
    translate([0,0,-5]) cylinder(d=195, h=10, center=true, $fn=90);
    translate([65.5,-3,66]) cube([41,13,132], center=true);
    difference(){
        translate([51.5,0,66]) cube([13,140,132], center=true);
        translate([51.5,49.6,62]) rotate([90,0,90]) color("blue") linear_extrude(height = 15, center = true) polygon(points=[[20.5,-30],[20.5,140],[-30,140]]);
        translate([51.5,-63,63.1]) rotate([90,0,270]) color("red") linear_extrude(height = 20, center = true) polygon(points=[[10,-13],[10,90],[-13,90]]);
    }
    translate([51.5,-12.5,47.5]) color("green") cube([22,140,95], center=true);
    translate([79.5,-9,47.5]) color("pink") cube([39,123,160], center=true);
    translate([4,99,-40.5]) rotate([90,270,90]) translate([50.5,70,75.5]) color("blue") cube([28,47,43], center=true);
    translate([29.5,-7.3,102.5]) color("black") cube([69,95,50], center=true);
    translate([23.5,-7.3,112.5]) color("black") cube([69,95,50], center=true);
}
