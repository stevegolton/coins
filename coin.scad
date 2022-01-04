$fn=128;

Coin25(0);

translate([-50, 0, 0]) {
    Coin25(180);
}

module Coin25(rotation) {
    difference() {
        rotate([0, rotation, 0]) {
            CenteredCoin(38.70/2, 11.18, 3.7, "25", "TWENTY FIVE");
        }

        union() {
            translate([-50, -50, -100]) {
                cube([100, 100, 100]);
            }
            
            // A little notch, to make it easier to align the two halves when glueing
            translate([-.5, 15, -1]) {
                cube([1, 10, 1.5]);
            }
        }
    }
}

//Coin(32/2, 16.5, 3.7, "10", "TEN");
//Coin(36/2, 13.5, 3.7, "5", "FIVE");
    
module CenteredCoin(radius, height, rimw, text, backtext) {
    translate([0, 0, -height/2]) {
        Coin(radius, height, rimw, text, backtext);
    }
}

/**
 * Creates a coin.
 */
module Coin(radius, height, rimw, text, backtext) {
    DEPTH=4;
    
    difference() {
        cylinder(h=height, r=radius);
        
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
    }
    
    // Top text
    translate([0, 0, height-DEPTH]) {
        linear_extrude(height=1.5) {
            text(
                halign="center",
                valign="center",
                size=radius-2,
                font="Noto Sans Black:style=Bold",
                text);
        }
    }
    
    BOTTOM_TEXT_HEIGHT=1;
    
    // Bottom text
    // TODO needs some work
    translate([0, 0, DEPTH]) {
        rotate([180, 0, 98]) {
            linear_extrude(height=BOTTOM_TEXT_HEIGHT) {
                revolve_text(radius-rimw-4.5, backtext, 0.5);
            }
        }
        
        rotate([0, 180, 0]) {
            translate([-6, -6, 0]) {
                rotate([0, 0, -15]) {
                    cylinder(h=BOTTOM_TEXT_HEIGHT, r=10.4/2);
                    linear_extrude(BOTTOM_TEXT_HEIGHT + BOTTOM_TEXT_HEIGHT) {
                        text(
                            "s",
                            valign="center",
                            halign="center",
                            size=7,
                            font="Noto Serif ExtraBold");
                    }
                }
            }
            
            translate([6, -6, 0]) {
                rotate([0, 0, 15]) {
                    cylinder(h=BOTTOM_TEXT_HEIGHT, r=10.4/2);
                    linear_extrude(BOTTOM_TEXT_HEIGHT + BOTTOM_TEXT_HEIGHT) {
                        text(
                            "g",
                            valign="center",
                            halign="center",
                            size=7,
                            font="Noto Serif ExtraBold");
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
module revolve_text(radius, chars, coverage) {
    PI = 3.14159;
    circumference = 2 * PI * radius;
    chars_len = len(chars);
    font_size = coverage * circumference / chars_len;
    step_angle = coverage * 360 / chars_len;
    for(i = [0 : chars_len - 1]) {
        rotate(-i * step_angle) 
            translate([0, radius + font_size / 2, 0]) 
                text(
                    chars[i], 
                    font="Noto Sans Black:style=Bold",
                    size = font_size, 
                    valign = "center", halign = "center"
                );
    }
}

