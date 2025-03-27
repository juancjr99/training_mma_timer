import 'package:flutter/material.dart';

// Colores UFC
// Blanco F7F7F7
// rojo claro D91D28
// Rojo fuerte CE090A


class AppTheme{

  ThemeData getTheme()=>ThemeData(
    useMaterial3: true,
    
    colorScheme: ColorScheme.dark(

      primary:Color(0xFF242529),
      // primary:Color(0xFF242529), // Rojo claro UFC
      secondary: Color(0xFFCE090A), // Rojo fuerte UFC
      onPrimary: Color(0xFFF7F7F7), // Texto sobre `primary`
      // surface: Color(0xFFF7F7F7), // Fondo de la app
      surface: Color(0xFF19191E), // Fondo de la app
    ),
    // brightness: Brightness.dark,
    textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Sternbach',
            letterSpacing: 2.0, // Espaciado entre letras
            fontSize: 32, // Tamaño de fuente
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          
    )

  );
}