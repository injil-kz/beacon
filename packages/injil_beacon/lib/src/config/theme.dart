import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _primaryColor = Color(0xFFFF8A0E);
const _secondaryColor = Color(0xFFCAC6C2);
const _backgroundColor = Color(0xFF181818);

const _inputTextStyle = TextStyle(
  color: _primaryColor,
  fontSize: 21,
  fontWeight: FontWeight.w400,
);

CupertinoThemeData get injilCupertinoTheme => const CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: _primaryColor,
      scaffoldBackgroundColor: _backgroundColor,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w400,
        ),
      ),
    );

ThemeData get injilTheme => ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: _primaryColor,
        secondary: _secondaryColor,
        surface: _backgroundColor,
      ),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: _backgroundColor,
        foregroundColor: _secondaryColor,
        titleTextStyle: TextStyle(
          color: _secondaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
      ),
      chipTheme: const ChipThemeData(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
      cardTheme: CardTheme(
        color: _backgroundColor,
        shadowColor: Colors.white.withOpacity(0.8),
        elevation: 2,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: _secondaryColor,
            width: 1.5,
          ),
        ),
        labelStyle: _inputTextStyle,
        prefixStyle: _inputTextStyle,
        hintStyle: TextStyle(
          color: _primaryColor.withOpacity(0.5),
          fontSize: 16,
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 16,
        ),
        iconColor: Colors.grey,
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
