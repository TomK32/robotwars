use <obiscad/obiscad/bcube.scad>;

module podest() {
    minkowski(cube_size = [1, 1, 1]) {
     cube(cube_size, true);
     cylinder(r=0.2,h=0.01);
    }
}


module lid(w, h, d) {
    translate([-w/2, 0, -2*d])
    cube([w, h, d], center=true);
}
module lid_bracket(size) {
  translate([0, 0, -size/2]) cube([size, size/2, size/2]);
}
module lid_brackets(size) {
    translate([-4,0,0]) lid_bracket(size);
    translate([-2.5,0,0]) lid_bracket(size);
    translate([-1,0,0]) lid_bracket(size);
}

module bot_name(height = 0.02) {
    font = "Liberation Sans";
    linear_extrude(height = height) {
        text("ANTidote 01", font = font, size = 0.5, halign="right");
    }
}
    
scale(10) translate([0,0,1]) {

    wall = 0.5;
    bot_l = 8;
    bot_w = 7;
    bot_h = 1.8+wall*2;
    motor_w = 2;
    motor_h = 1.6;
    union() {
        difference(){
            // body
            cube([bot_l, bot_w, bot_h], center = true);
            // main cavety
            translate([0,0,wall/2]) {
                cube([bot_l - 2*wall, (bot_w - 2*wall) / 2, bot_h-wall/2], center = true);
                translate([motor_w/2 + wall/2, 0, 0])
                    cube([bot_l - 2*wall - motor_w, bot_w - 2*wall, bot_h-wall/2], center = true);
            }
            
            // turrent mounts
            translate([-bot_l/2 + 2*wall, 0, bot_h/2 ]) {
                for(y = [bot_w/2  - 2*wall, -bot_w/2  + 2*wall]) {
                translate([0, y, 0])
                    bcube([1, 1, wall*3], cr = 0.3, cres=4);
                }
                    
            }

            // motor holes
            translate([-bot_l/2 + motor_w/2 + wall, 0, -bot_h/2 + motor_h/2 + wall*2/3])
            translate([0,0,0]) {
                rotate([90, 0, 0]) bcube([motor_w,motor_h,bot_w+wall], cr=0.5, cres=10);
            }
            // back side holes
            translate([-bot_l/2+wall/2,0,wall]) {
                translate([0,-1,0]) cube([wall, 0.5, 0.25], center = true);
                translate([0,1,0]) cube([wall, 0.5, 0.25], center = true);
            }
            
            // slope cut at front 
            translate([bot_l/2+wall,0,0.25]) rotate([0, 20, 0]) {
                cube([bot_l *2,bot_w + 1, 2], center = true);
                
                // brackets for push-in cover#
                translate([-wall, 0, -wall*2]) {
                    translate([0, bot_w/2 - wall, 0]) lid_brackets(wall);
                    translate([0, -bot_w/2 + wall/2, 0]) lid_brackets(wall);
                }
            }
            // bot name on the side of the case
            translate([bot_l/3,-bot_w/2+0.01,-bot_h/2+wall/2]) rotate([90,0,0]) bot_name();

        }
        
        // main controller
        controller_l = 3.3;
        controller_w = 1.8;
        translate([controller_w/5, 0, -bot_h/2+wall]) rotate([0,0,90]) {
            podest(cube_size = [3.3,1.8,wall/2]);
            translate([controller_l/2, -controller_w/2, 0.125 + 0.1])
                rotate([0, 0, 90]) resize(newsize=[1.8, 3.3, 0.08]) {
                import("/Users/tomk32/Arbeit/DevLoL/openscad/Sparkfun_Pro_Mini/ProMini.stl");
            }
        }
        // lid
        %translate([bot_l/2,0,0.025]) rotate([0, 20, 0]) {
            translate([2,0,0]) difference() {
                lid(bot_l, bot_w, wall/2);
                translate([0,0,-wall]) rotate([0, -20, 0])
                    cube([bot_l, bot_w*2, wall/2], center=true);
                translate([-bot_l+wall/4-0.1,0,-wall]) rotate([0, -20, 0])
                    cube([bot_l, bot_w*2, wall], center=true);
                
                // bot name
                translate([-bot_l+wall*3,bot_w/2-0.1,-wall+0.1]) rotate([0,0,180]) bot_name(height = 0.13);
            }
            // lid pins
            translate([-wall/5, 0, -wall*1.25+0.01]) color([0, 1, 0]) {
                translate([0, bot_w/2 - wall, 0]) lid_brackets(wall);
                translate([0, -bot_w/2 + wall/2, 0]) lid_brackets(wall);
            }

        }
    }
};
translate([0, 0, 5]) {
    linear_extrude(
    
    );}
    $fn=50;

