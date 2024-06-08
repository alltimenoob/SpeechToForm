part of 'registration_bloc.dart';

class RegistrationEvent {}

class RegistrationQuerySpeechToText extends RegistrationEvent{
  final String message;

  RegistrationQuerySpeechToText({required this.message});
}
