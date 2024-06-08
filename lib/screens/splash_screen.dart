import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groq/groq.dart';
import 'package:speech_to_form/bloc/registration_bloc.dart';
import 'package:speech_to_form/repository/groq_repository.dart';

import 'registration_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(duration: const Duration(seconds: 3), vsync: this,)..repeat(reverse: true);

  late final Animation<Color?> _animation = ColorTween(begin: Colors.blue.shade300,end: Colors.red.shade300).animate(_controller);

  @override
  void initState() {
    super.initState();

    final Groq groq = Groq( const String.fromEnvironment('groq_api_key'),model: GroqModel.llama370b8192);
    GroqRepository groqRepository = GroqRepository(groq: groq);

    Future.delayed(const Duration(seconds: 5))
        .then((_) => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) =>  BlocProvider.value(value : RegistrationBloc(groqRepository),child: RegistrationScreen())),
            (route) => false)
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(children: [Spacer()]),
          AnimatedBuilder(
            animation: _animation,
            builder: (context,child) {
              return Text("S2F",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  shadows: [
                    Shadow(color: _animation.value ?? Colors.white,blurRadius: 100),
                    ...List.generate(4, (_) => Shadow(color: ( Colors.white).withOpacity(1.0),blurRadius: 100) ),
                  ])
              );}
          )],
      ),
    );
  }
}
