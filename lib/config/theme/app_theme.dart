import 'package:flutter/material.dart';

// Colores UFC
// Blanco F7F7F7
// rojo claro D91D28
// Rojo fuerte CE090A


class AppTheme{

  ThemeData getTheme()=>ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: Color(0xFFD91D28), // Rojo claro UFC
      secondary: Color(0xFFCE090A), // Rojo fuerte UFC
      onPrimary: Color(0xFFF7F7F7), // Texto sobre `primary`
    ),
    brightness: Brightness.dark,

  );
}