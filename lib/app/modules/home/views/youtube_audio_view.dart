import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../controllers/youtube_audio_controller.dart';

class YouTubeAudioView extends StatelessWidget {
  final YouTubeAudioController audioController =
      Get.put(YouTubeAudioController());

  YouTubeAudioView({Key? key}) : super(key: key) {
    // Inisialisasi controller saat view dibuat
    audioController.initializePlayer();
  }

  final TextEditingController urlController = TextEditingController();

  // Fungsi validasi URL YouTube
  bool isValidYouTubeUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null &&
        (uri.host.contains("youtube.com") || uri.host.contains("youtu.be"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YouTube Audio Player"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Masukkan URL Video YouTube",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: urlController,
              decoration: InputDecoration(
                labelText: "YouTube URL",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String url = urlController.text.trim();
                if (url.isNotEmpty && isValidYouTubeUrl(url)) {
                  audioController.loadVideo(url);
                } else {
                  Get.snackbar(
                    "Error",
                    "URL tidak valid atau kosong",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              child: Text("Play Audio"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                audioController.stopAudio();
              },
              child: Text("Stop Audio"),
            ),
            SizedBox(height: 20),
            Obx(() {
              return Text(
                audioController.videoTitle.value.isNotEmpty
                    ? audioController.videoTitle.value
                    : "No Video Loaded",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              );
            }),
            SizedBox(height: 20),
            YoutubePlayer(
              controller: audioController.playerController,
              showVideoProgressIndicator: true,
            ),
          ],
        ),
      ),
    );
  }
}
