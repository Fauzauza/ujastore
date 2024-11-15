import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeAudioController extends GetxController {
  late YoutubePlayerController playerController;
  RxBool isPlaying = false.obs;
  RxString videoTitle = ''.obs;

  void initializePlayer({String initialVideoId = 'dQw4w9WgXcQ'}) {
    playerController = YoutubePlayerController(
      initialVideoId: initialVideoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    playerController.addListener(() {
      isPlaying.value = playerController.value.isPlaying;
    });
  }

  void loadVideo(String videoUrl) {
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null) {
      playerController.load(videoId);
      updateVideoTitle(videoId);
    } else {
      Get.snackbar(
        'Error',
        'Invalid YouTube URL',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateVideoTitle(String videoId) async {
    videoTitle.value = "Playing Video ID: $videoId";
  }

  void stopAudio() {
    print("Player status: ${playerController.value.isPlaying}");
    if (playerController.value.isPlaying) {
      playerController.pause();
      isPlaying.value = false;
      print("Audio stopped.");
    } else {
      print("Audio was not playing.");
    }
  }

  @override
  void onClose() {
    playerController.dispose();
    super.onClose();
  }
}
