import 'dart:convert';

import 'package:http/http.dart' as http;

class Transcript {
  final String transcriptURL;

  Transcript({required this.transcriptURL,});

  Future<void> transcriptSymptomDetect(String transcript) async {

  }

  Future<String> getPurifiedTranscript(String transcriptURL) async {
    final response = await http.get(Uri.parse(transcriptURL));
    print("transcript response check: ${response.body}");
    return jsonDecode(response.body)["combinedRecognizedPhrases"][0]["display"];
  }

}