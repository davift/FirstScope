module stepper_28byj48(segments=32) {
    $fn = segments;
    module mount_tabs() {
        difference() {
            hull() {
                translate([35/2,0,0])
                    cylinder(d=7, 0.8);

                translate([-35/2,0,0])
                    cylinder(d=7, 0.8);
            }
            translate([35/2,0,-0.1])
                cylinder(d=3.5, 0.8+0.2);

            translate([-35/2,0,-0.1])
                cylinder(d=3.5, 0.8+0.2);
        }
    }

    // main body
    color("Silver")
        cylinder(d=28, h =19, $fn=$fn*2);

    // wire cover
    color("DeepSkyBlue")
        translate([-14.6/2,-17,0])
            cube([14.6,5.8, 16.5]);

    color("Silver")
        mount_tabs();

    // shaft and flange
    translate([0,0,-1.5]) {
        // flange
        translate([0,8,0])
            color("Silver")
                cylinder(d=9,h =1.5);

        color("Goldenrod") {
            // shaft
            translate([0,8,-5]) {
                difference() {
                    cylinder(d=5, h=10);

                    // shaft cutouts
                    translate([1.5,-2.5,-0.1])
                        cube([2,5,4.5+0.1]);

                    translate([-2-1.5,-2.5,-0.1])
                        cube([2,5,4.5+0.1]);
                }
            }
        }
    }
}

module controller(){
    // PCB
    %translate([10,0,0]) cube([10,35,33], center=true);
    translate([-1.5,-14.5,13.5]) color("white") rotate([0,90,0]) difference(){
        cylinder(d=6, h=7, center=true, $fn=30);
        cylinder(d=3, h=7, center=true, $fn=30);
    }
    translate([-1.5,14.5,13.5]) color("cyan") rotate([0,90,0]) difference(){
        cylinder(d=6, h=7, center=true, $fn=30);
        cylinder(d=3, h=7, center=true, $fn=30);
    }
    translate([-1.5,14.5,-13.5]) color("orange") rotate([0,90,0]) difference(){
        cylinder(d=6, h=7, center=true, $fn=30);
        cylinder(d=3, h=7, center=true, $fn=30);
    }
    translate([-1.5,-14.5,-13.5]) color("pink") rotate([0,90,0]) difference(){
        cylinder(d=6, h=7, center=true, $fn=30);
        cylinder(d=3, h=7, center=true, $fn=30);
    }
}

module arduino(){
    // PCB
    %translate([10,0,0]) cube([10,53.3,68.6], center=true);
    translate([-1.5,-21.15,17.6]) color("white") rotate([0,90,0]) difference(){
        cylinder(d=6, h=7, center=true, $fn=30);
        cylinder(d=3, h=7, center=true, $fn=30);
    }
    translate([-1.5,21.15,16.3]) color("cyan") rotate([0,90,0]) difference(){
        cylinder(d=6, h=7, center=true, $fn=30);
        cylinder(d=3, h=7, center=true, $fn=30);
    }
    translate([-1.5,5.95,-28.8]) color("orange") rotate([0,90,0]) difference(){
        cylinder(d=6, h=7, center=true, $fn=30);
        cylinder(d=3, h=7, center=true, $fn=30);
    }
    translate([-1.5,-16.05,-28.8]) color("pink") rotate([0,90,0]) difference(){
        cylinder(d=6, h=7, center=true, $fn=30);
        cylinder(d=3, h=7, center=true, $fn=30);
    }
}

// BASE
//union(){
//    translate([0,0,-5]) cylinder(d=195, h=10, center=true, $fn=90);
//    translate([74.5,0,50]) cube([33,13,100], center=true);
//    difference(){
//        translate([51.5,0,50]) cube([13,140,100], center=true);
//        translate([51.5,49.6,30.5]) rotate([90,0,90]) linear_extrude(height = 15, center = true) polygon(points=[[20.5,0],[20.5,70],[0,70]]);
//    }
//}

// BODY
difference(){
    translate([0,0,1]) color("red") cylinder(d=189, h=2, center=true, $fn=90);
    translate([-57.5,0,0.75]) cube([200,200,3], center=true);
    translate([74.5,0,50]) cube([33,13,100], center=true);
    translate([51.5,0,50]) cube([13,140,100], center=true);
}
difference(){
    translate([75.5,0,47.5]) cube([35,18,95], center=true);
    translate([74.5,0,50]) cube([33,13,100], center=true);
}
// Controller 1
translate([65,30,40]) controller();
// Controller 2
translate([65,30,75]) controller();
// Arduino
translate([65,-38,45]) arduino();


// TILT
difference(){
    difference(){
        union(){
            translate([51.5,70,47.5]) color("blue") cube([18,45,95], center=true);
            translate([51.5,-12.5,47.5]) color("green") cube([18,120,95], center=true);
        }
        translate([51.5,-63,50.1]) rotate([90,0,270]) linear_extrude(height = 20, center = true) polygon(points=[[10,0],[10,45],[0,45]]);
        translate([41.6,70,91]) rotate([90,0,90]) stepper_28byj48();
        translate([44.5,78,90]) cube([1,60,10], center=true);
        translate([31.2,71.5,0]) rotate([90,20,90]) cube([20,70,40]);
        translate([41.5,70,79]) rotate([90,0,90]) resize([25,15]) cylinder(d=25, h=20);
    }

    difference(){
        translate([51.5,0,50]) cube([13,140,100], center=true);
        translate([51.5,49.6,30.5]) rotate([90,0,90]) linear_extrude(height = 15, center = true) polygon(points=[[20.5,0],[20.5,70],[0,70]]);
    }
    
    translate([74.5,0,50]) cube([33,13,100], center=true);
}
//Tilt Motor
//translate([44.1,70,91]) rotate([90,0,90]) stepper_28byj48();




// PAN
translate([4,99,-40.5]) rotate([90,270,90]) union(){
    difference(){
        translate([51.5,70,75.5]) color("blue") cube([18,45,43], center=true);
        translate([41.6,70,91]) rotate([90,0,90]) stepper_28byj48();
        translate([45,70,90]) cube([1,60,15], center=true);
        //translate([42.5,64,92]) rotate([18.5,0,0]) cube([1,60,20], center=true);
        translate([41.5,70,79]) rotate([90,0,90]) resize([25,15]) cylinder(d=25, h=20);
    }
    // Pan Motor
    //translate([44.6,70,91]) rotate([90,0,90]) stepper_28byj48();
}











