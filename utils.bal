import ballerina/regex;

# Format String to Hex color code
#
# If the color code does not start with "#", prefix with "#"
#
# ```ballerina
# formatStringToHex("#FE9639") ⇒ <HexColorCode> #Fe9639
#
# formatStringToHex("0768E6") ⇒ <HexColorCode> #0768E6
#
# formatStringToHex("#F93") ⇒ HexColorCodeFormatError
#
# formatStringToHex("COLOR") ⇒ HexColorCodeFormatError
# ```
#
# + colorCode - color code("#RRGGBB")
# + return - HexColorCode|error
public isolated function formatStringToHex(string colorCode) returns HexColorCode|error {
    final HexColorCodeSixDigits checkedColorCode = check checkStringToHexColorCodeType(colorCode);

    return <HexColorCode>checkedColorCode;
}

# Format String to Rgb color code
#
# If the color code does not start with "#", prefix with "#"
#
# ```ballerina
# formatStringToRgb("#FE9639") ⇒ <RgbColorCode> {red: 254, green: 150, blue: 57}
#
# formatStringToRgb("0768E6") ⇒ <RgbColorCode> {red: 7, green: 104, blue: 230}
#
# formatStringToRgb("#F93") ⇒ HexColorCodeFormatError
#
# formatStringToRgb("COLOR") ⇒ HexColorCodeFormatError
# ```
#
# + colorCode - color code("#RRGGBB")
# + return - RgbColorCode|error
public isolated function formatStringToRgb(string colorCode) returns RgbColorCode|error {
    final HexColorCodeSixDigits checkedColorCode = check checkStringToHexColorCodeType(colorCode);
    final RgbColorCode rgbColorCode = check formatHexToRgb(checkedColorCode);

    return rgbColorCode;
}

# Format Rgb to Hex
#
# If use formatted rgb color code, basically no error
#
# ```ballerina
# formatRgbToHex(<RgbColorCode> {red: 254, green: 150, blue: 57}) ⇒ <HexColorCode> "#FE9639"
# ```
#
# + colorCode - formatted rgb color code
# + return - HexColorCode|error
public isolated function formatRgbToHex(RgbColorCode colorCode) returns HexColorCode|error {
    final string hexString = string `#${colorCode.red.toHexString()}${colorCode.green.toHexString()}${colorCode.blue.toHexString()}`;

    return formatStringToHex(hexString);
}

# Format Hex to Rgb
#
# If use formatted hex color code, basically no error
#
# ```ballerina
# formatHexToRgb("#FE9639") ⇒ <RgbColorCode> {red: 254, green: 150, blue: 57}
# ```
#
# + colorCode - formatted hex color code, six digits(#RRGGBB)
# + return - RgbColorCode|error
public isolated function formatHexToRgb(HexColorCodeSixDigits colorCode) returns RgbColorCode|error {
    final int:Unsigned8 red = <int:Unsigned8>check int:fromHexString(colorCode.substring(1, 3));
    final int:Unsigned8 green = <int:Unsigned8>check int:fromHexString(colorCode.substring(3, 5));
    final int:Unsigned8 blue = <int:Unsigned8>check int:fromHexString(colorCode.substring(5, 7));

    return {
        red: red,
        green: green,
        blue: blue
    };
}

# Checkn hex color code type
#
# Currently only HexColorCodeSixDigits is supported
#
# ```ballerina
# checkStringToHexColorCodeType("#FE9639") ⇒ <HexColorCodeSixDigits> {red: 254, green: 150, blue: 57}
#
# checkStringToHexColorCodeType("#F93") ⇒ HexColorCodeFormatError
# ```
#
# + colorCode - color code("#RRGGBB")
# + return - HexColorCodeSixDigits|error
isolated function checkStringToHexColorCodeType(string colorCode) returns HexColorCodeSixDigits|error {
    // adjust sharp
    final string prefix = "#";
    final string hexColorCode;
    if colorCode.startsWith(prefix) {
        hexColorCode = colorCode;
    } else {
        hexColorCode = prefix + colorCode;
    }

    // format validation
    final boolean validRRGGBB = regex:matches(hexColorCode, "/^#[0-9A-Fa-f]{6}$/");
    if validRRGGBB {
        return <HexColorCodeSixDigits>hexColorCode;
    }

    return error HexColorCodeFormatError(string `Color code format error: ${hexColorCode}`);
}
