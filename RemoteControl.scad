$fn=90;

pcb_l = 71.5;
pcb_w = 51.5;
pcb_h = 1;

pcb_offset_top = 6;
pcb_offset_botton = 3;

wall = 2;

button_h = 5;
button_d = 9.5;
button_bd = button_d+4;
button_bh = 2;

// PCB
//translate([wall, wall, pcb_offset_botton+wall]) color("red") cube([pcb_l, pcb_w, pcb_h]);

// Housing
difference(){
    cube([pcb_l+wall*2, pcb_w+wall*2, pcb_h+pcb_offset_botton+pcb_offset_top+wall*2]);
    translate([wall, wall, wall]) cube([pcb_l, pcb_w, pcb_h+pcb_offset_botton+pcb_offset_top+wall]);
    translate([0, pcb_w+wall-22, wall+pcb_offset_botton+4]) cube([wall, 20, pcb_h+pcb_offset_top+wall-4]);
}

translate([wall+3, wall+5.5, wall]) difference(){
    cylinder(h=pcb_offset_botton, d=5);
    cylinder(h=pcb_offset_botton, d=2);
}

translate([wall+67.5, wall+5.5, wall]) union(){
    cylinder(h=pcb_offset_botton, d=5);
    cylinder(h=pcb_offset_botton+2, d=2.5);
}

translate([wall+67.5, wall+46.5, wall]) difference(){
    cylinder(h=pcb_offset_botton, d=5);
    cylinder(h=pcb_offset_botton, d=2);
}

translate([wall+3, wall+46.5, wall]) union(){
    cylinder(h=pcb_offset_botton, d=5);
    cylinder(h=pcb_offset_botton+2, d=2.5);
}

// Lid
difference(){
    translate([0, 0, wall+pcb_offset_botton+pcb_h+pcb_offset_top-3.5]) difference(){
        union(){
            translate([wall, wall, wall-2.5]) cube([pcb_l, pcb_w, wall+5]);
            translate([0, 0, wall+3.5]) cube([pcb_l+wall*2, pcb_w+wall*2, 1]);
        }
        translate([wall*1.5, wall*1.5, wall-2.5]) cube([pcb_l-wall, pcb_w-wall, wall+3]);
        translate([wall+7, wall+pcb_w/2, wall]) cylinder(h=button_h, d=3);
        translate([wall+pcb_l/2-2.5, wall+pcb_w/2+10, wall]) cylinder(h=button_h, d=button_d+0.5);
        translate([wall+pcb_l/2-12.5, wall+pcb_w/2, wall]) cylinder(h=button_h, d=button_d+0.5);
        translate([wall+pcb_l/2-2.5, wall+pcb_w/2-10, wall]) cylinder(h=button_h, d=button_d+0.5);
        translate([wall+pcb_l/2+7.5, wall+pcb_w/2, wall]) cylinder(h=button_h, d=button_d+0.5);
    }
    translate([1.5, pcb_w+wall-22, wall+pcb_offset_botton+3]) cube([wall+8, 20, pcb_h+pcb_offset_top+wall-3]);
}

// Light Guide
translate([wall+7, wall+pcb_w/2, wall+pcb_offset_botton+pcb_h+pcb_offset_top-1.5]) color("red") cylinder(h=0.5, d=3);

// Button 1
translate([wall+pcb_l/2-12.5, wall+pcb_w/2, wall+pcb_offset_botton+pcb_h+pcb_offset_top-1.5]) color("yellow") union(){
    cylinder(h=button_h, d=button_d);
    cylinder(h=button_bh, d=button_bd);
}

// Button 2
translate([wall+pcb_l/2-2.5, wall+pcb_w/2-10, wall+pcb_offset_botton+pcb_h+pcb_offset_top-1.5]) color("grey") union(){
    cylinder(h=button_h, d=button_d);
    cylinder(h=button_bh, d=button_bd);
}

// Button 3
translate([wall+pcb_l/2-2.5, wall+pcb_w/2+10, wall+pcb_offset_botton+pcb_h+pcb_offset_top-1.5]) color("blue") union(){
    cylinder(h=button_h, d=button_d);
    cylinder(h=button_bh, d=button_bd);
}

// Button 4
translate([wall+pcb_l/2+7.5, wall+pcb_w/2, wall+pcb_offset_botton+pcb_h+pcb_offset_top-1.5]) color("green") union(){
    cylinder(h=button_h, d=button_d);
    cylinder(h=button_bh, d=button_bd);
}
