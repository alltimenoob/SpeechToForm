
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_form/repository/groq_repository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final GroqRepository groqRepository;

  final TextEditingController
      firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      usernameController = TextEditingController();

  RegistrationBloc(this.groqRepository) : super(RegistrationInitial()) {
    on<RegistrationEvent>((event, emit) {});
    on<RegistrationQuerySpeechToText>(processSpeechToText);
  }

  void processSpeechToText(RegistrationQuerySpeechToText event,Emitter<RegistrationState> emit) async{
    final json = await groqRepository.queryJSON(event.message);

    if(json.containsKey('username')){
      usernameController.text = json['username'];
    }

    if(json.containsKey('lastname')){
      lastNameController.text = json['lastname'];
    }

    if(json.containsKey('firstname')){
      firstNameController.text = json['firstname'];
    }
  }
}
