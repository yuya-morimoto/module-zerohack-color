import ballerina/regex;

public class Color {
    private final int red;
    private final int green;
    private final int blue;
    private final string hex;

    public function init([int, int, int]|string colorCode) {
        if colorCode is [int, int, int] {
            self.red = colorCode[0];
            self.green = colorCode[1];
            self.blue = colorCode[2];
            self.hex = string `#${self.red.toHexString()}${self.green.toHexString()}${self.blue.toHexString()}`;
        } else {
            // adjust sharp
            final string hexColorCode;
            if colorCode.startsWith("#") {
                hexColorCode = colorCode;
            } else {
                hexColorCode = "#" + colorCode;
            }
            self.red = 1;
            self.green = 2;
            self.blue = 3;
            self.hex = string `#${self.red.toHexString()}${self.green.toHexString()}${self.blue.toHexString()}`;
        }
    }

    private function validRgbColorCode(RgbColorCode colorCode) returns error? {
        // validation
        check self.validDecColorCode(colorCode.red);
        check self.validDecColorCode(colorCode.green);
        check self.validDecColorCode(colorCode.blue);
    }

    private function validDecColorCode(int colorCode) returns error? {
        // validation
        if colorCode < 0 {
            return error DecColorCodeOutOfRangeError(string `Color code is under out of range: ${colorCode}`);
        }
        if colorCode > 255 {
            return error DecColorCodeOutOfRangeError(string `Color code is over out of range: ${colorCode}`);
        }
    }

}

public function rgbToRgbColor(int red, int green, int blue) {
}

public function hexToRgbColor() {

}
