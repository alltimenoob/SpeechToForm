import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_form/bloc/registration_bloc.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  SpeechToText speechToText = SpeechToText();
  String lastWords = '';

  @override
  void initState() {
    super.initState();
    speechToText.initialize(onStatus: statusListener).then((value) => setState(() {}));
  }

  void statusListener(String status) {

    if(status == 'done'){
      context.read<RegistrationBloc>().add(RegistrationQuerySpeechToText(message: lastWords));
    }

  }
  void startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  void stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {

    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
                child: Column(
                  children: [
                    Text("Registration Form",style: Theme.of(context).textTheme.titleLarge,),
                    const SizedBox(height: 30,),
                    TextFormField(
                      controller: context.read<RegistrationBloc>().firstNameController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "First Name"
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: context.read<RegistrationBloc>().lastNameController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "Last Name"
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      controller: context.read<RegistrationBloc>().usernameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: "Username"
                      ),
                    ),
                    const SizedBox(height: 10,),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: "Password"
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.primary),
                              foregroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.secondary)
                          ),
                          onPressed: (){},
                          child: const Text("Submit")),
                    )
                  ],
                )
            ),
          )
        ],
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: FloatingActionButton(
          onPressed: speechToText.isNotListening ? startListening : stopListening,
          tooltip: 'Listen',
          child: Icon(speechToText.isNotListening ? Icons.mic_off : Icons.mic),
        ),
      ),
    );
  }
}
