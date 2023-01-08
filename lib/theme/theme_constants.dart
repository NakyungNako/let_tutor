import 'package:flutter/material.dart';

const COLOR_PRIMARY = Colors.deepOrangeAccent;
const COLOR_ACCENT = Colors.orange;

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.orange[800],
    ),
    dividerColor: Colors.black54,
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all<Color>(COLOR_ACCENT)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.black54,
      unselectedItemColor: Colors.grey.withOpacity(0.5),
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(COLOR_ACCENT)
      )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0)
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))
            ),
            backgroundColor: MaterialStateProperty.all<Color>(COLOR_ACCENT)
        )
    ),
    inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),borderSide: BorderSide.none
        ),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1)
    ),
);

ThemeData darkTheme = ThemeData(

  brightness: Brightness.dark,
  secondaryHeaderColor: Colors.white,
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(COLOR_ACCENT)
      )
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.orange[800],
  ),
  dividerColor: Colors.white70,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Colors.white70,
    unselectedItemColor: Colors.grey.withOpacity(0.5),
    elevation: 0,
  ),
  chipTheme: ChipThemeData(
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.white70, width: 1),
      borderRadius: BorderRadius.circular(30.0),

    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),borderSide: BorderSide.none
      ),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.1)
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0)
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
              )
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.grey;
                  }
                  return Colors.white;
                  },
          ),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          overlayColor: MaterialStateProperty.all<Color>(Colors.black26)
      )
  ),
);