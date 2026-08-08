use <coin.scad>;

$fn=128;

SliceIntoTwoHalves(offset=45) {
    Coin(
        radius=38.70/2,
        height=11.18,
        rimw=3.7,
        fronttext="25",
        backtext="TWENTY FIVE",
        centeredVertically=true);
}

translate([0, 40, 0]) {
    TwoPins();
}