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
        text("ANTidote 01", font = font, size = 0.5);
    }
}
    
scale(10) translate([0,0,1]) {

    bot_l = 7;
    bot_w = 4;
    wall = 0.5;
    union() {
        difference(){
            cube([bot_l,bot_w,2], center = true);
            translate([0,0,wall/2]) cube([bot_l - 2*wall, bot_w - 2*wall, 2], center = true);
            // motor holes
            motor_w = 0.5; motor_h = 0.3;
            translate([-bot_w+3*wall+0.01,0,-wall+ motor_h/2]) {
                cube([motor_w, bot_w+motor_h, 0.75], center = true);
                rotate([90, 0, 0]) podest(cube_size = [motor_w,motor_h,bot_w]);
            }
            // back side holes
            translate([-bot_l/2+wall/2,0,wall]) {
                translate([0,-1,0]) cube([wall, 0.5, 0.25], center = true);
                translate([0,1,0]) cube([wall, 0.5, 0.25], center = true);
            }
            
            // slope cut at front 
            translate([4,0,0.25]) rotate([0, 20, 0]) {
                cube([bot_l *2,bot_w + 1, 2], center = true);
                
                // brackets for push-in cover#
                translate([-wall, 0, -wall*2]) {
                    translate([0, bot_w/2 - wall, 0]) lid_brackets(wall);
                    translate([0, -bot_w/2 + wall/2, 0]) lid_brackets(wall);
                }
            }
            translate([-bot_l/3+wall,-bot_w/2+0.01,-0.75]) rotate([90,0,0]) bot_name();

        }
        
        translate([0.25, 0, -wall*3/2]) {
            podest(cube_size = [bot_l-2,bot_w-2,wall/2]);
            translate([3.3/2, -1.8/2, 0.125 + 0.1])
                rotate([0, 0, 90]) resize(newsize=[1.8, 3.3, 0.08]) {
                import("/Users/tomk32/Arbeit/DevLoL/openscad/Sparkfun_Pro_Mini/ProMini.stl");
            }
        }
        // lid
        translate([bot_l/2,0,0.025]) rotate([0, 20, 0]) {
            translate([2,0,0]) difference() {
                lid(bot_l, bot_w, wall/2);
                translate([0,0,-wall]) rotate([0, -20, 0])
                    cube([bot_l, bot_w*2, wall/2], center=true);
                translate([-bot_l+wall/4-0.1,0,-wall]) rotate([0, -20, 0])
                    cube([bot_l, bot_w*2, wall], center=true);
                
                translate([-2,bot_w/2-0.1,-wall+0.1]) rotate([0,0,180]) bot_name(height = 0.13);
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

