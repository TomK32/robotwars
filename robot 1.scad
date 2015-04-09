module podest() {
    minkowski(cube_size = [1, 1, 1]) {
     cube(cube_size, true);
     cylinder(r=0.2,h=.01);
    }
}

translate([0,0,1]) {

    bot_l = 7;
    bot_w = 4;
    wall = 0.5;
    union() {
        difference(){
            cube([bot_l,bot_w,2], center = true);
            translate([0,0,wall/2]) cube([bot_l - wall, bot_w - wall, 2], center = true);
            translate([-bot_w*2/3,0,-0.24]) {
                cube([1, bot_w+1, 0.75], center = true);
                rotate([90, 0, 0]) podest(cube_size = [0.5,0.5,bot_w]);
            }
            // back side holes
            translate([0,-1,0.5]) cube([bot_l + 1, 0.5, 0.25], center = true);
            translate([0,1,0.5]) cube([bot_l + 1, 0.5, 0.25], center = true);
            
            // slope cut at front 
            translate([4,0,0.25]) rotate([0, 20, 0]) {
                cube([bot_l *2,bot_w + 1,2], center = true);
            }
        font = "Liberation Sans";
        translate([-bot_l/3+0.3,-bot_w/2+0.01,-0.75], center=true) {
           rotate([90,0,0]) linear_extrude(height = 0.02) {
               text("ANTidote 01", font = font, size = 0.5);
             }
        }
        }
        
        translate([0.25, 0, -wall*3/2]) {
            podest(cube_size = [bot_l-2,bot_w-2,wall/2]);
            %translate([3.3/2, -1.8/2, 0.125 + 0.1])
                rotate([0, 0, 90]) resize(newsize=[1.8, 3.3, 0.08]) {
                import("/Users/tomk32/Arbeit/DevLoL/openscad/Sparkfun_Pro_Mini/ProMini.stl");
            }
        }
    }
};
translate([0, 0, 5]) {
    linear_extrude(
    
    );}
    $fn=50;

