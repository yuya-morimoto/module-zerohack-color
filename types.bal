# Rgb Color code
#
# + red - red color code(0-255)
# + green - green color code(0-255)
# + blue - blue color code(0-255)
public type RgbColorCode record {|
    int:Unsigned8 red;
    int:Unsigned8 green;
    int:Unsigned8 blue;
|};

# Hex Color code type #RGB|RGB
public type HexColorCodeSixDigits string;

# Hex Color code type HexColorCodeSixDigits
public type HexColorCode HexColorCodeSixDigits;

