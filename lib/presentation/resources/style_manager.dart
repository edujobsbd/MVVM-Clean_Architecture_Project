import 'package:flutter/material.dart';
import 'package:mvvmproject/presentation/resources/phone_manager.dart';
import 'package:mvvmproject/presentation/resources/phone_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, Color color, FontWeight fontWeight) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}
// regular text style

TextStyle getRegular({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontContents.fontFamily, color, FontWeightManager.regular);
}


// light text style

TextStyle getLightStyle ({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontContents.fontFamily, color, FontWeightManager.light);
}

// bold text style

TextStyle getBoldStyle ({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontContents.fontFamily, color, FontWeightManager.bold);
}

// semiBold text style

TextStyle getSemiBold({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontContents.fontFamily, color, FontWeightManager.semiBold);
}

// medium  text style

TextStyle getMedium  ({double fontSize = FontSize.s12, required Color color}) {
  return _getTextStyle(
      fontSize, FontContents.fontFamily, color, FontWeightManager.medium);
}