import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darktheme = ThemeData(
  fontFamily: 'Janna',
  primarySwatch: defaultColor,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: defaultColor),
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleSpacing: 20,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: HexColor('333739'),
      ),
      backgroundColor: HexColor('333739'),
      elevation: 0,
      titleTextStyle: TextStyle(
          fontFamily: 'Janna',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 30,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
    subtitle1: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 4, color: Colors.white,height: 1.3),
  ),
);
ThemeData lighttheme = ThemeData(
  fontFamily: 'Janna',
  primarySwatch: defaultColor,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: defaultColor),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
      titleSpacing: 20,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: TextStyle(
          fontFamily: 'Janna',
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold)),
  textTheme: TextTheme(
    bodyText1: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 18, color: Colors.black),
    subtitle1: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black,height: 1.3),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 30,
    backgroundColor: Colors.white,
  ),
);
