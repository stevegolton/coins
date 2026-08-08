// Slices an object into two halves along the x/y plane and places them side by side.
// The bottom slice is flipped.
// Useful for printing.
module SliceIntoTwoHalves(offset) {
    // Top half of the coin
    difference() {
        children();

        union() {
            translate([-50, -50, -100]) {
                cube([100, 100, 100]);
            }
        }
    }
    
    // Bottom half of the coin
    translate([offset, 0, 0]) {
        difference() {
            rotate([0, 180, 0]) {
                children();
            }

            union() {
                translate([-50, -50, -100]) {
                    cube([100, 100, 100]);
                }
            }
        }
    }
}

module RoundedCylinder(r, h, cornerRad) {
    translate([0, 0, cornerRad]) {
        hull() {
            rotate_extrude(angle = 360) {
                translate([r - cornerRad, 0, 0]) {
                    circle(r = cornerRad);
                }
            }
            
            translate([0, 0, h-cornerRad*2]) {
                rotate_extrude(angle = 360) {
                    translate([r - cornerRad, 0, 0]) {
                        circle(r = cornerRad);
                    }
                }
            }
        }
    }
}

PIN_HEIGHT = 3;
PIN_HEIGHT_HALF = PIN_HEIGHT / 2;
PIN_HEIGHT_MARGIN = 0.5;
PIN_RAD = 3;
PIN_RAD_MARGIN = 0.1;

module Pin() {
    translate([0, 0, 0]) {
        cylinder(h=PIN_HEIGHT-PIN_HEIGHT_MARGIN, r=PIN_RAD-PIN_RAD_MARGIN);
    }
}

module TwoPins() {
    translate([0, 0, 0]) {
        Pin();
    }

    translate([20, 0, 0]) {
        Pin();
    }
}

/**
 * Creates a coin.
 */
module Coin(radius, height, rimw, fronttext, backtext, centeredVertically=false) {
    DEPTH=4;
    
    offset = centeredVertically? -height/2 : 0;
    
    translate([0, 0, offset]) {
        difference() {
            RoundedCylinder(h=height, r=radius, cornerRad=.7);
            
            // Top indent
            translate([0, 0, height-DEPTH]) {
                cylinder(h=100, r=radius - rimw);
            }
            
            // Bottom indent
            translate([0, 0, DEPTH]) {
                rotate([180, 0, 0]) {
                    cylinder(h=100, r=radius - rimw);
                }
            }
            
            // Pin holes
            translate([0, 7, (height/2) - PIN_HEIGHT_HALF]) {
                cylinder(h=PIN_HEIGHT, r=PIN_RAD);
            }
            
            translate([0, -7, (height/2) - PIN_HEIGHT_HALF]) {
                cylinder(h=PIN_HEIGHT, r=PIN_RAD);
            }
        }
        
        // Top text
        translate([0, 0, height-DEPTH]) {
            linear_extrude(height=1.5) {
                text(
                    halign="center",
                    valign="center",
                    size=radius-2,
                    font="Noto Sans Black:style=Bold",
                    fronttext);
            }
        }
        
        BOTTOM_TEXT_HEIGHT=1;
        feature_size = radius - rimw;
        
        // Bottom text
        // TODO needs some work
        translate([0, 0, DEPTH]) {
            
            backtext_font_size = 4 * feature_size / 15.65;
            
            rotate([180, 0, 180]) {
                linear_extrude(height=BOTTOM_TEXT_HEIGHT) {
                    revolve_text(radius-rimw-4.6, backtext, backtext_font_size, 18);
                }
            }
            
            disk_diameter = 10.4 * feature_size / 15.65;
            disk_offset = 6 * feature_size / 15.65;
            disk_font_size = 7 * feature_size / 15.65;
            echo(disk_diameter);
            
            rotate([0, 180, 0]) {
                translate([-disk_offset, -disk_offset, 0]) {
                    rotate([0, 0, -15]) {
                        cylinder(h=BOTTOM_TEXT_HEIGHT, r=disk_diameter/2);
                        linear_extrude(BOTTOM_TEXT_HEIGHT + BOTTOM_TEXT_HEIGHT) {
                            text(
                                "s",
                                valign="center",
                                halign="center",
                                size=disk_font_size,
                                font="Noto Serif ExtraBold");
                        }
                    }
                }
                
                translate([disk_offset, -disk_offset, 0]) {
                    rotate([0, 0, 15]) {
                        cylinder(h=BOTTOM_TEXT_HEIGHT, r=disk_diameter/2);
                        linear_extrude(BOTTOM_TEXT_HEIGHT + BOTTOM_TEXT_HEIGHT) {
                            text(
                                "g",
                                valign="center",
                                halign="center",
                                size=disk_font_size,
                                font="Noto Serif ExtraBold");
                        }
                    }
                }
            }
        }
    }
}

/**
 * Creates text on a circle.
 * See https://openhome.cc/eGossip/OpenSCAD/TextCircle.html
 */
module revolve_text(radius, chars, font_size, step_angle) {
//    PI = 3.14159;
//    circumference = 2 * PI * radius;
//    chars_len = len(chars);
//    font_size = coverage * circumference / chars_len;
//    step_angle = coverage * 360 / chars_len;
//    step_angle = 15;
//    font_size = 10;
    total_coverage = step_angle * (len(chars)-1);
    offset = total_coverage / 2;
    for(i = [0 : len(chars) - 1]) {
        rotate(offset - (i * step_angle)) 
            translate([0, radius + font_size / 2, 0]) 
                text(
                    chars[i], 
                    font="Noto Sans Black:style=Bold",
                    size = font_size, 
                    valign = "center", halign = "center"
                );
    }
}

