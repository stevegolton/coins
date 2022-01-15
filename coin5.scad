use <coin.scad>;

$fn=128;

SliceIntoTwoHalves(offset=42) {
    Coin(
        radius=36/2,
        height=13.5,
        rimw=3.7,
        fronttext="5",
        backtext="FIVE",
        centeredVertically=true);
}
