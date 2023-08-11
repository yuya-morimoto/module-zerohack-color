
public class Rgb {
    private final int:Unsigned8 red;
    private final int:Unsigned8 green;
    private final int:Unsigned8 blue;
    private final string hex;

    public function init([int:Unsigned8, int:Unsigned8, int:Unsigned8]|string colorCode) returns error? {
        if colorCode is [int:Unsigned8, int:Unsigned8, int:Unsigned8] {
            self.red = colorCode[0];
            self.green = colorCode[1];
            self.blue = colorCode[2];
            self.hex = check formatRgbToHex({
                red: self.red,
                green: self.green,
                blue: self.blue
            });

        } else {
            final HexColorCode hex = check formatStringToHex(colorCode);
            final RgbColorCode rgbColorCode = check formatHexToRgb(hex);

            self.red = rgbColorCode.red;
            self.green = rgbColorCode.green;
            self.blue = rgbColorCode.blue;
            self.hex = hex;
        }
    }
}
