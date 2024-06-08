

import 'package:flutter/material.dart';

class ProjectTheme{

  static final ProjectTheme _instance = ProjectTheme._();

  ProjectTheme._();

  factory ProjectTheme(){
    return _instance;
  }

  final ThemeData _themeData = ThemeData(
    fontFamily: 'PlayfairDisplay',
    useMaterial3: true,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: Colors.white,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
  );


  ThemeData get lightTheme => _themeData.copyWith(

  );


}