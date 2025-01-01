import 'package:flutter/material.dart';
import 'package:mvvmproject/presentation/resources/color_manager.dart';
import 'package:mvvmproject/presentation/resources/phone_manager.dart';
import 'package:mvvmproject/presentation/resources/style_manager.dart';
import 'package:mvvmproject/presentation/resources/value_manager.dart';

ThemeData getAppTheme() {
  return ThemeData(
    //main color of this app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor:
        ColorManager.grey1, //will be used incase of disabled for example.....
    //ripple color ...
    splashColor: ColorManager.primaryOpacity70,
    hintColor: ColorManager.grey,

    //card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.as4,
    ),
    // app bar theme
    appBarTheme: AppBarTheme(
      elevation: AppSize.as4,
      shadowColor: ColorManager.primaryOpacity70,
      color: ColorManager.primary,
      centerTitle: true,
      titleTextStyle:
          getRegular(color: ColorManager.white, fontSize: FontSize.s16),
    ),

    //button theme
    buttonTheme: ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: ColorManager.grey1,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.primaryOpacity70),

    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            textStyle: getRegular(
              color: ColorManager.white,
            ), backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.as12)))),

    //text theme
    textTheme: TextTheme(
      displayLarge:
          getSemiBold(color: ColorManager.darkGrey, fontSize: FontSize.s16),
      titleMedium:
          getMedium(color: ColorManager.lightGray, fontSize: FontSize.s14),
      titleSmall:
          getMedium(color: ColorManager.primary, fontSize: FontSize.s14),
      bodySmall: getRegular(
        color: ColorManager.grey1,
      ),
      bodyLarge: getRegular(
        color: ColorManager.grey,
      ),
    ),

    //input decoration theme (text form field )

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(AppPadding.p8),
      //hintstyle
      hintStyle: getRegular(color: ColorManager.grey1),
      //labelStyle
      labelStyle: getMedium(color: ColorManager.darkGrey),
      //errorStyle
      errorStyle: getRegular(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.grey,
          width: AppSize.as1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.as8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.as1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.as8),
      ),
      //errorBorder
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.error,
          width: AppSize.as1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.as8),
      ),

      //focusedErrorBorder
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.as1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.as8),
      ),
    ),
  );
}
