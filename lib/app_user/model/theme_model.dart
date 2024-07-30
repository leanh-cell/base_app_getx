import 'package:flutter/material.dart';
import 'package:com.ikitech.store/app_user/const/constant.dart';
import 'package:com.ikitech.store/app_user/utils/color.dart';

ThemeData SahaUserPrimaryTheme(BuildContext context) {
  return ThemeData(
      primarySwatch: MaterialColor(
        HexColor.getColorFromHex(hexPrimary),
        {
          50: HexColor(hexPrimary).withOpacity(0.1),
          100: HexColor(hexPrimary).withOpacity(0.2),
          200: HexColor(hexPrimary).withOpacity(0.3),
          300: HexColor(hexPrimary).withOpacity(0.4),
          400: HexColor(hexPrimary).withOpacity(0.5),
          500: HexColor(hexPrimary).withOpacity(0.6),
          600: HexColor(hexPrimary).withOpacity(0.7),
          700: HexColor(hexPrimary).withOpacity(0.8),
          800: HexColor(hexPrimary).withOpacity(0.9),
          900: HexColor(hexPrimary).withOpacity(1),
        },
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'baloo2',
      textTheme: TextTheme(
        bodyMedium: TextStyle(
            fontFamily: 'baloo2',
            height: 1.1,
            textBaseline: TextBaseline.alphabetic),
        bodyLarge:
            TextStyle(height: 1.1, textBaseline: TextBaseline.alphabetic),
        bodySmall:
            TextStyle(height: 1.1, textBaseline: TextBaseline.alphabetic),
      ));
}
