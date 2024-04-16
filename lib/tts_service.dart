import 'package:flutter_tts/flutter_tts.dart';

// set up the text to speech dependency

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();

  TtsService() {
    _flutterTts.setLanguage("en-UK");
    _flutterTts.setSpeechRate(0.5);
  }

  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }
}
