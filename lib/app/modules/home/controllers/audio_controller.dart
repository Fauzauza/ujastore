
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  RxBool isPlaying = false.obs;

  // Fungsi untuk memutar audio dari URL
  void playAudio(String audioUrl) async {
    try {
      // Jika audio sedang diputar, hentikan
      if (isPlaying.value) {
        await _audioPlayer.stop();
        isPlaying.value = false;
      }

      // Memutar audio dari URL
      await _audioPlayer.play(UrlSource(audioUrl));
      isPlaying.value = true;
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  // Fungsi untuk menghentikan audio
  void stopAudio() async {
    await _audioPlayer.stop();
    isPlaying.value = false;
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
