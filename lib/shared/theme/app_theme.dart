import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // AppTheme._internal();

  // static final AppTheme instance = AppTheme._internal();

  // factory AppTheme() {
  //   return instance;
  // }

  static ThemeData get defaultTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 131, 31, 24),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.latoTextTheme(),
      );
}
