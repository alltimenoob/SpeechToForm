
import 'dart:convert';

import 'package:groq/groq.dart';

class GroqRepository {
  final Groq groq;

  GroqRepository({required this.groq});

  Future<Map> queryJSON(String message) async {
    groq.startChat();
    final String modifiedMessage = 'Make a json of one parameter, where $message. Provide only json and no other comments.';
    final GroqResponse groqResponse = await groq.sendMessage(modifiedMessage);
    groq.clearChat();

    final Map jsonResponse = jsonDecode(groqResponse.choices.first.message.content);

    return jsonResponse.map((key, value) => MapEntry(key.toString().split(' ').join('').toLowerCase(), value));
  }

}