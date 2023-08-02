battery_lengh = 110;
bettery_width = 65+2;
battery_hight = 6+1;

offset_connectors = 10;
offset_circuits = 8;

wall_thickness = 1;

// Body
difference(){
    // Shell
    cube([battery_lengh+offset_connectors+(wall_thickness*2), bettery_width+(wall_thickness*2), battery_hight+offset_circuits+(wall_thickness*2)]);

    // Hollow
    translate([wall_thickness, wall_thickness, wall_thickness]) cube([battery_lengh+offset_connectors, bettery_width, battery_hight+offset_circuits+wall_thickness+1]);

    // Battery
    translate([offset_connectors+wall_thickness,wall_thickness,wall_thickness]) color("red") cube([battery_lengh, bettery_width, battery_hight]);

    // USB
    translate([0, wall_thickness+1, battery_hight+wall_thickness]) cube([26, 15.5, 7.6]);

    // MicroUSB
    translate([0, wall_thickness+46, battery_hight+wall_thickness]) cube([31, 10, 5]);
    
    // Lock Holles
    translate([battery_lengh+offset_connectors, wall_thickness+(bettery_width/2)+15, battery_hight+offset_circuits-2]) cube([5, 5, 2]);
    translate([battery_lengh+offset_connectors, wall_thickness+(bettery_width/2)-20, battery_hight+offset_circuits-2]) cube([5, 5, 2]);
}
difference(){
    translate([wall_thickness+4, wall_thickness+(bettery_width/2), 0]) cylinder(d=6, h=battery_hight+offset_circuits, $fn=90);
    translate([wall_thickness+4, wall_thickness+(bettery_width/2), 0]) cylinder(d=2, h=battery_hight+offset_circuits, $fn=90);
}


// Lid
difference(){
    union(){
        difference(){
            translate([0, 0, battery_hight+offset_circuits+wall_thickness]) cube([battery_lengh+offset_connectors+(wall_thickness*2), bettery_width+(wall_thickness*2), wall_thickness]);
            translate([wall_thickness+4, wall_thickness+(bettery_width/2), 0]) cylinder(d=6, h=25, $fn=90);
        }
        
        difference(){
            translate([wall_thickness, wall_thickness, battery_hight+offset_circuits]) cube([battery_lengh+offset_connectors, bettery_width, wall_thickness]);
            translate([wall_thickness+4, wall_thickness+(bettery_width/2), 0]) cylinder(d=2, h=25, $fn=90);
            
        }
    }
    
    // USB
    translate([0, wall_thickness+1, battery_hight+wall_thickness]) cube([26, 15.5, 7.6]);

    // Button
    translate([21+5, wall_thickness+46+5, battery_hight+wall_thickness]) cylinder(d=8, h=10, $fn=90);
    
    // Light Guide Holle
    translate([21+10+2, wall_thickness+46-12.5+5, battery_hight+wall_thickness]) cube([2, 25, 12]);
}
// Locks
translate([battery_lengh+offset_connectors-3, wall_thickness+(bettery_width/2)+15, battery_hight+offset_circuits-2]) cube([5, 5, 2]);
translate([battery_lengh+offset_connectors-3, wall_thickness+(bettery_width/2)+15, battery_hight+offset_circuits-1]) cube([4, 5, 1]);
translate([battery_lengh+offset_connectors-3, wall_thickness+(bettery_width/2)-20, battery_hight+offset_circuits-2]) cube([5, 5, 2]);
translate([battery_lengh+offset_connectors-3, wall_thickness+(bettery_width/2)-20, battery_hight+offset_circuits-1]) cube([4, 5, 1]);
// Reinforcement
difference(){
    translate([45, wall_thickness, battery_hight+offset_circuits-wall_thickness-2]) cube([72, bettery_width, 4]);
    translate([50, wall_thickness+5, battery_hight+offset_circuits-wall_thickness-2]) cube([62, bettery_width-10, 5]);
}
translate([8, 29, battery_hight+offset_circuits-wall_thickness-2]) cube([72, 10, 4]);

// Light Guide
translate([21+10+2, wall_thickness+46-12.5+5, battery_hight+offset_circuits]) color("blue") cube([2, 25, 2]);

// Button
translate([21+5, wall_thickness+46+5, battery_hight+offset_circuits]) color("black") cylinder(d=7.5, h=3, $fn=90);
translate([21+5, wall_thickness+46+5, battery_hight+offset_circuits]) cylinder(d=9.5, h=2, $fn=90);

