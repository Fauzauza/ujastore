import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/audio_controller.dart'; // Pastikan controller diimpor

class AudioView extends StatelessWidget {
  final AudioController audioController = Get.put(AudioController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Audio Player"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Audio to Play',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            
            // Pilihan tombol untuk audio "Mobile Legend"
            ElevatedButton(
              onPressed: () {
                String audioUrl = 'https://drive.google.com/uc?export=download&id=1qTv2q3d0_np1-P5IZQQBqeovmVlxFn90';
                audioController.playAudio(audioUrl);
              },
              child: Text('Play Mobile Legend Audio'),
            ),
            SizedBox(height: 20),

            // Tambahkan tombol pilihan lainnya jika perlu
            ElevatedButton(
              onPressed: () {
                // Ganti URL dengan link audio lainnya jika perlu
                String audioUrl = 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
                audioController.playAudio(audioUrl);
              },
              child: Text('Play SoundHelix Song'),
            ),
            SizedBox(height: 20),
            
            // Tombol Stop
            ElevatedButton(
              onPressed: () {
                audioController.stopAudio();
              },
              child: Text('Stop Audio'),
            ),
            SizedBox(height: 20),
            
            // Indikator status audio
            Obx(() {
              return Text(
                audioController.isPlaying.value ? 'Audio is Playing' : 'Audio Stopped',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              );
            }),
          ],
        ),
      ),
    );
  }
}
