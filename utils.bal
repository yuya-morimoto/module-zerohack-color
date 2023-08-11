import ballerina/regex;

// ----- String to HEX|DEC -----
public isolated function formatStringToHex(string colorCode) returns HexColorCode|error {
    final HexColorCodeSixDigits checkedColorCode = check checkStringToHexColorCodeType(colorCode);

    return <HexColorCode>checkedColorCode;
}

public isolated function formatStringToRgb(string colorCode) returns RgbColorCode|error {
    final HexColorCodeSixDigits checkedColorCode = check checkStringToHexColorCodeType(colorCode);
    final RgbColorCode rgbColorCode = check formatHexToRgb(checkedColorCode);

    return rgbColorCode;
}

// ----- Formatted HEX|DEC to HEX|DEC -----
public isolated function formatRgbToHex(RgbColorCode colorCode) returns HexColorCode|error {
    final string hexString = string `#${colorCode.red.toHexString()}${colorCode.green.toHexString()}${colorCode.blue.toHexString()}`;

    return formatStringToHex(hexString);
}

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
