import 'package:flutter_tts/flutter_tts.dart';

final FlutterTts flutterTts = FlutterTts();

Future<void> speak(String audio) async {
  flutterTts.setLanguage('en');
  flutterTts.setPitch(1);
  flutterTts.speak(audio);
}
