import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = Color(0xFF5D9CEC);
  static Color backgroundColor = Color(0xFFDFECDB);
  static Color greyColor = Color(0xFF838386);
  static Color whiteColor = Color(0xFFFFFFFF);
  static Color blackColor = Color(0xFF363636);
  static Color greenColor = Color(0xFF61E757);
  static Color redColor = Color(0xFFEC4B4B);
  static Color primaryDarkColor = Color(0xFF060E1E);
  static Color darkBlackColor = Color(0xFF141922);

  static ThemeData LightMode = ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(color: primaryColor),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: greyColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          shape: StadiumBorder(
              side: BorderSide(
        color: whiteColor,
        width: 4,
      ))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        shape: StadiumBorder(),
      )),
      textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: whiteColor,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: blackColor,
          ),
          titleSmall: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: blackColor,
          )));
}
