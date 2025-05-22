import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final purpleTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(103, 80, 164, 1),
    onPrimary: Colors.white,
    secondary: Color.fromRGBO(156, 204, 101, 1),
    onSecondary: Colors.black,
    error: Color.fromRGBO(255, 105, 97, 1),
    onError: Colors.white,
    surface: Color(0xFFF3F0FF),
    onSurface: Color.fromRGBO(30, 30, 30, 1),
    tertiary: Color.fromRGBO(230, 222, 255, 1),
    surfaceContainer: Color.fromRGBO(224, 224, 224, 0.8),
    onInverseSurface: Color.fromRGBO(103, 80, 164, 1),
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(30, 30, 30, 1),
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(30, 30, 30, 1),
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(30, 30, 30, 1),
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Color.fromRGBO(30, 30, 30, 1),
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Color.fromRGBO(60, 60, 60, 1),
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: Color.fromRGBO(100, 100, 100, 1),
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(103, 80, 164, 1),
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(103, 80, 164, 1),
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(156, 204, 101, 1),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromRGBO(103, 80, 164, 1),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color.fromRGBO(103, 80, 164, 1),
      side: BorderSide(color: Color.fromRGBO(103, 80, 164, 1)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    ),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    color: Colors.white,
  ),
  fontFamily: GoogleFonts.openSans().fontFamily,
);

final purpleDarkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromRGBO(179, 157, 219, 1),
    onPrimary: Colors.black,
    secondary: Color.fromRGBO(156, 204, 101, 1),
    onSecondary: Colors.black,
    error: Color.fromRGBO(255, 138, 128, 1),
    onError: Colors.black,
    surface: Color.fromRGBO(30, 30, 46, 1),
    onSurface: Colors.white,
    tertiary: Color.fromRGBO(56, 42, 93, 1),
    surfaceContainer: Color.fromRGBO(56, 42, 93, 0.8),
    onInverseSurface: Color.fromRGBO(179, 157, 219, 1),
  ),
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Color.fromRGBO(220, 220, 220, 1),
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: Color.fromRGBO(200, 200, 200, 1),
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(179, 157, 219, 1),
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(179, 157, 219, 1),
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Color.fromRGBO(156, 204, 101, 1),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromRGBO(179, 157, 219, 1),
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Color.fromRGBO(179, 157, 219, 1),
      side: BorderSide(color: Color.fromRGBO(179, 157, 219, 1)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    ),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    color: Color.fromRGBO(40, 40, 56, 1),
  ),
  fontFamily: GoogleFonts.openSans().fontFamily,
);
