import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final light_theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromRGBO(67, 194, 89, 1), // Primary color for app
      onPrimary: Colors.white, // Text color on primary
      secondary: Color.fromRGBO(227, 165, 127, 100), // Secondary color
      onSecondary: Colors.white, // Text color on secondary
      error: Colors.red, // Error color
      onInverseSurface: Color.fromRGBO(67, 194, 89, 1),
      tertiary: Color.fromRGBO(250, 250, 250, 0.93),
      onError: Colors.white,
      surface: Color(0xFFEEEEEE),
      surfaceContainer: const Color.fromARGB(85, 57, 52, 52),
      onSurface: Colors.black,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),

      headlineMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),

      headlineSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),

      bodySmall: TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.w300,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: const Color.fromARGB(43, 47, 47, 47),
        overflow: TextOverflow.ellipsis,
      ),
      // Medium, bold, black text (used for body text)
      bodyMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),

      // Small, bold, black text (used for display elements)
      displayMedium: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),

      labelLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(111, 0, 0, 0),
        overflow: TextOverflow.ellipsis,
      ),

      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: const Color.fromARGB(184, 0, 0, 0),
        overflow: TextOverflow.ellipsis,
      ),

      // Large, bold, white text (used for primary body elements)
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromRGBO(67, 194, 89, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(10)), // Rounded corners
        ),
      ),
    ),
    fontFamily: GoogleFonts.poppins().fontFamily);

final dark_theme = ThemeData(
    useMaterial3: true,

    // Define the color scheme for the light theme
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromRGBO(80, 93, 104, 1.0), // Primary color for app
      onPrimary: Colors.white, // Text color on primary
      onInverseSurface: Color.fromRGBO(67, 194, 89, 1),
      secondary: Color.fromRGBO(67, 194, 89, 1),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Color.fromRGBO(31, 41, 55, 1),
      tertiary: Color.fromRGBO(80, 93, 104, 1.0),
      surfaceContainer: const Color.fromARGB(86, 145, 143, 143),
      onSurface: Colors.white,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
      ),
      headlineMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
      ),
      headlineSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 8,
        fontWeight: FontWeight.w300,
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
      ),
      bodyMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: const Color.fromARGB(218, 255, 255, 255),
        overflow: TextOverflow.ellipsis,
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: const Color.fromARGB(43, 255, 255, 255),
        overflow: TextOverflow.ellipsis,
      ),
      displayMedium: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
      ),
      labelLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        overflow: TextOverflow.ellipsis,
      ),
      labelMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: const Color.fromARGB(184, 0, 0, 0),
        overflow: TextOverflow.ellipsis,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),

    // Elevated button theme (primary button style)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            Color.fromRGBO(67, 194, 89, 1), // Button background color
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(10)), // Rounded corners
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(10)), // Rounded corners
        ),
      ),
    ),
    fontFamily: GoogleFonts.poppins().fontFamily);
