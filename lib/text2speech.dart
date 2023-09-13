import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static FlutterTts tts = FlutterTts();

  static initTTS() {
    tts.setLanguage("en-US"); //en-UK & ms-MY & cmn-CN
  }

  static speak(String output) {
    tts.speak(output);
  }

  static setLanguage(String language) {
    tts.setLanguage(language);
  }

  static setRate(double rate) {
    tts.setSpeechRate(rate);
  }
}
