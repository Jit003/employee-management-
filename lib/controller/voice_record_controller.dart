import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class VoiceRecorderController extends GetxController {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final RxBool isRecording = false.obs;
  String? recordedFilePath;
  bool _isRecorderInitialized = false;

  @override
  void onInit() {
    super.onInit();
    initRecorder();
  }

  Future<void> initRecorder() async {
    var micStatus = await Permission.microphone.request();
    if (micStatus.isGranted) {
      await recorder.openRecorder();
      _isRecorderInitialized = true;
    } else {
      Get.snackbar("Permission Denied", "Microphone access is required.");
    }
  }

  Future<void> startRecording() async {
    if (!_isRecorderInitialized) {
      await initRecorder();
    }

    if (!recorder.isRecording) {
      final dir = await getTemporaryDirectory();
      recordedFilePath = "${dir.path}/recorded_voice.wav"; // ✅ correct extension

      await recorder.startRecorder(
        toFile: recordedFilePath,
        codec: Codec.pcm16WAV, // ✅ matches extension
      );
      isRecording.value = true;
    }
  }

  Future<void> stopRecording() async {
    if (recorder.isRecording) {
      await recorder.stopRecorder();
      isRecording.value = false;
      final file = File(recordedFilePath!);
      print("File exists: ${await file.exists()}");
      print("File size: ${await file.length()} bytes");

      print("Recording  saved to: $recordedFilePath");
    }
  }

  @override
  void onClose() {
    recorder.closeRecorder();
    super.onClose();
  }
}