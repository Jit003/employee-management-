import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class VoiceRecorderController extends GetxController {
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer player = FlutterSoundPlayer();

  final RxBool isRecording = false.obs;
  final RxBool isPlaying = false.obs;

  String? recordedFilePath;
  bool _isRecorderInitialized = false;
  bool _isPlayerInitialized = false;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> init() async {
    await _requestPermissions();
    await _initRecorder();
    await _initPlayer();
  }

  Future<void> _requestPermissions() async {
    var mic = await Permission.microphone.request();
    var storage = await Permission.storage.request();
    var media = await Permission.mediaLibrary.request();

    if (!mic.isGranted || !storage.isGranted) {
      Get.snackbar("Permission Denied", "Microphone and storage permission required");
    }
  }

  Future<void> _initRecorder() async {
    await recorder.openRecorder();
    _isRecorderInitialized = true;
  }

  Future<void> _initPlayer() async {
    await player.openPlayer();
    _isPlayerInitialized = true;
  }

  Future<void> startRecording() async {
    if (!_isRecorderInitialized) {
      await _initRecorder();
    }

    final dir = await getTemporaryDirectory();
    recordedFilePath = "${dir.path}/recorded_voice.aac";

    await recorder.startRecorder(
      toFile: recordedFilePath,
      codec: Codec.aacADTS,
    );
    isRecording.value = true;
  }

  Future<void> stopRecording() async {
    await recorder.stopRecorder();
    isRecording.value = false;
    print("Recording saved: $recordedFilePath");
  }

  Future<void> playRecording() async {
    if (recordedFilePath == null || !File(recordedFilePath!).existsSync()) {
      Get.snackbar("Error", "No recording found");
      return;
    }

    if (!_isPlayerInitialized) {
      await _initPlayer();
    }

    await player.startPlayer(
      fromURI: recordedFilePath!,
      codec: Codec.aacADTS,
      whenFinished: () {
        isPlaying.value = false;
      },
    );
    isPlaying.value = true;
  }

  Future<void> stopPlaying() async {
    await player.stopPlayer();
    isPlaying.value = false;
  }

  @override
  void onClose() {
    recorder.closeRecorder();
    player.closePlayer();
    super.onClose();
  }
}
