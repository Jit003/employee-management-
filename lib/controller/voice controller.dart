import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceController extends GetxController {
  late stt.SpeechToText speech;
  final FlutterTts tts = FlutterTts();
  var isListening = false.obs;

  @override
  void onInit() {
    super.onInit();
    speech = stt.SpeechToText();
  }

  Future<void> startListening() async {
    bool available = await speech.initialize(
      onStatus: (status) {
        if (status == "done" || status == "notListening") {
          isListening.value = false;
        }
      },
      onError: (error) {
        print("Speech error: $error");
      },
    );

    if (available) {
      isListening.value = true;
      speech.listen(
        onResult: (val) {
          final words = val.recognizedWords.toLowerCase();
          print("Heard: $words");

          if (words.contains("check in")) {
            _speak("Check in successful");
            Get.snackbar("Voice", "Check-In Triggered");
            // Call your check-in logic here
          } else if (words.contains("check out")) {
            _speak("Check out successful");
            Get.snackbar("Voice", "Check-Out Triggered");
            // Call your check-out logic here
          }
        },
      );
    } else {
      Get.snackbar("Voice", "Speech not available");
      _speak("not recognized");
    }
  }

  Future<void> stopListening() async {
    await speech.stop();
    isListening.value = false;
  }

  Future<void> _speak(String message) async {
    await tts.setLanguage("en-US");
    await tts.setPitch(1);
    await tts.speak(message);
  }
}
