use <coin.scad>;

$fn=128;

SliceIntoTwoHalves(offset=40) {
    Coin(
        radius=32/2,
        height=16.5,
        rimw=3.7,
        fronttext="10",
        backtext="TEN",
        centeredVertically=true);
}

translate([0, 40, 0]) {
    TwoPins();
}