$fn=256; 

Coin(38.70/2, 11.18, 3.7, "25", "TWENTY FIVE");
//Coin(32/2, 16.5, 3.7, "10");
//Coin(36/2, 13.5, 3.7, "5");

module Coin(radius, height, rimw, text, backtext) {
    DEPTH=4;
    
    difference() {
        cylinder(h=height, r=radius);
        
        translate([0, 0, height-DEPTH]) {
            cylinder(h=100, r=radius - rimw);
        }
    }
    
    translate([0, 0, height-4]) {
        linear_extrude(height=1.5) {
            text(halign="center", valign="center", size=radius-2, font="Noto Sans Black:style=Bold", text);
        }
    }
    
//    revolve_text(radius, backtext, 0.5);
}

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

