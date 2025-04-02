import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFA30808), // Rojo elegante, menos saturado
          onPrimary: Color(0xFFF7F7F7), // Texto sobre `primary`
          secondary: Color(0xFF242529), // Fondo de componentes
          surface: Color(0xFF121217), // Fondo principal oscuro y profundo
          onSurface: Color(0xFFC4C4C4), // Texto sobre el fondo, gris claro
          outline: Color(0xFF79747E), 
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Sternbach', // Solo para temporizadores
            letterSpacing: 1.5, 
            fontSize: 32, 
            fontWeight: FontWeight.bold,
            color: Colors.white, 
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Bebas Neue',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Bebas Neue',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Bebas Neue',
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFFC4C4C4), 
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Bebas Neue', // Fuente principal
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xFFC4C4C4), 
          ),
          bodySmall: TextStyle(
            fontFamily: 'Bebas Neue',
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: Color(0xFFC4C4C4),
          ),
          titleLarge: TextStyle(
            fontFamily: 'Bebas Neue',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Bebas Neue',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFFC4C4C4),
          ),
          titleSmall: TextStyle(
            fontFamily: 'Bebas Neue',
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xFFC4C4C4),
          ),
        ),
        cardColor: Color(0xFF19191E),
        scaffoldBackgroundColor: Color(0xFF121217),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF19191E),
          titleTextStyle: TextStyle(
            fontFamily: 'Bebas Neue', // Fuente de títulos
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color(0xFFA30808),
          textTheme: ButtonTextTheme.primary,
        ),
      );
}
