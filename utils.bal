import ballerina/regex;

type HexColorCodeThreeDigits string;

type HexColorCodeSixDigits string;

# Format hex color code
#
# + colorCode - hex color code
# + return - HexColorCode|error
public function formatHexColorCode(string colorCode) returns HexColorCode|error {
    HexColorCodeSixDigits|HexColorCodeThreeDigits checkedColorCode = check checkHexColorCodeType(colorCode);

    return <HexColorCode>checkedColorCode;
}

# Check hex color code type (3digids or 6digits)
#
# + colorCode - Hex color code
# + return - ColorCode(3digids|6digids)|error
function checkHexColorCodeType(string colorCode) returns HexColorCodeSixDigits|HexColorCodeThreeDigits|error {
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
    final boolean validRGB = regex:matches(hexColorCode, "/^#[0-9A-Fa-f]{3}$/");

    if validRRGGBB {
        return <HexColorCodeSixDigits>hexColorCode;
    }

    if validRGB {
        return <HexColorCodeThreeDigits>hexColorCode;
    }

    return error HexColorCodeFormatError(string `Color code format error: ${hexColorCode}`);
}
