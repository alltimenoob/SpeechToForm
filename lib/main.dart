import 'package:flutter/material.dart';
import 'package:speech_to_form/screens/splash_screen.dart';
import 'package:speech_to_form/theme/project_theme.dart';

void main() {
  runApp(MaterialApp(
    title: 'Speech To Form',
    theme: ProjectTheme().lightTheme,
    home: const SplashScreen(), //(title: 'Flutter Demo Home Page'),
  ));
}