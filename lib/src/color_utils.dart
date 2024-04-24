import 'dart:ui';

/// 颜色字符串转换色值
Color hexString2Color(String hexString, {double opacity = 1}) {
  var str = hexString.replaceAll(" ", "");
  str = str.toUpperCase();
  if(str.contains("#")) {
    str = str.replaceAll("#", "");
  }
  if(str.contains("0X")) {
    str = str.replaceAll("0X", "");
  }
  if(str.length == 6) {
    if (opacity < 0){
      opacity = 0;
    } else if (opacity > 1){
      opacity = 1;
    }
    return Color(int.parse(str, radix: 16)).withOpacity(opacity);
  } else if (str.length == 8) {
    return Color(int.parse(str, radix: 16));
  } else {
    throw ArgumentError('Can not parse provided hex $hexString');
  }
}

/// 透明度色值转换
Color hexOpacity2Color(int hex, {double opacity = 1}) {
  if (opacity < 0) {
    opacity = 0;
  } else if (opacity > 1) {
    opacity = 1;
  }
  return Color.fromRGBO((hex & 0xFF0000) >> 16 ,
      (hex & 0x00FF00) >> 8,
      (hex & 0x0000FF) >> 0,
      opacity);
}