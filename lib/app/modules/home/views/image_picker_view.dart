import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:ujastore/app/modules/home/controllers/image_picker_controller.dart';

class ImagePickerView extends GetView<ImagePickerController> {
  const ImagePickerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Gambar dan Video'),
        elevation: 6,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // UI untuk menampilkan gambar yang dipilih
                Container(
                  height: Get.height / 3,
                  width: Get.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.deepPurple.shade300, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Obx(() {
                    return controller.isImageLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : controller.selectedImagePath.value.isEmpty
                            ? Center(child: Text('No image selected', style: TextStyle(color: Colors.grey)))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  File(controller.selectedImagePath.value),
                                  fit: BoxFit.cover,
                                ),
                              );
                  }),
                ),
                const SizedBox(height: 20),
                // Tombol untuk memilih gambar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildImagePickerButton('Pick Image from Camera', ImageSource.camera),
                    const SizedBox(width: 10),
                    _buildImagePickerButton('Pick Image from Gallery', ImageSource.gallery),
                  ],
                ),
                const SizedBox(height: 20),
                // Tombol untuk menghapus gambar
                Obx(() {
                  return controller.selectedImagePath.value.isNotEmpty
                      ? ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: controller.removeImage,
                          icon: const Icon(Icons.delete, color: Colors.white),
                          label: const Text('Hapus Gambar', style: TextStyle(color: Colors.white)),
                        )
                      : const SizedBox.shrink(); // Tidak menampilkan tombol jika tidak ada gambar yang dipilih
                }),
                const SizedBox(height: 30),
                const Divider(color: Colors.grey),
                const SizedBox(height: 30),

                // UI untuk menampilkan video yang dipilih
                Container(
                  height: Get.height / 3,
                  width: Get.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.deepPurple.shade300, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Obx(() {
                    if (controller.selectedVideoPath.value.isNotEmpty) {
                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: VideoPlayer(controller.videoPlayerController!),
                            ),
                            VideoProgressIndicator(
                              controller.videoPlayerController!,
                              allowScrubbing: true,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    controller.isVideoPlaying.isTrue
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.deepPurple,
                                  ),
                                  onPressed: controller.togglePlayPause,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: Text('No video selected', style: TextStyle(color: Colors.grey)));
                    }
                  }),
                ),
                const SizedBox(height: 20),
                // Tombol untuk memilih video
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildVideoPickerButton('Pick Video from Camera', ImageSource.camera),
                    const SizedBox(width: 10),
                    _buildVideoPickerButton('Pick Video from Gallery', ImageSource.gallery),
                  ],
                ),
                const SizedBox(height: 20),
                // Tombol untuk menghapus video
                Obx(() {
                  return controller.selectedVideoPath.value.isNotEmpty
                      ? ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: controller.removeVideo,
                          icon: const Icon(Icons.delete, color: Colors.white),
                          label: const Text('Hapus Video', style: TextStyle(color: Colors.white)),
                        )
                      : const SizedBox.shrink(); // Tidak menampilkan tombol jika tidak ada video yang dipilih
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Fungsi untuk tombol pemilih gambar
  Widget _buildImagePickerButton(String label, ImageSource source) {
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () => controller.pickImage(source),
        icon: Icon(Icons.camera_alt, color: Colors.white),
        label: Text(label, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  // Fungsi untuk tombol pemilih video
  Widget _buildVideoPickerButton(String label, ImageSource source) {
    return Expanded(
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () => controller.pickVideo(source),
        icon: Icon(Icons.videocam, color: Colors.white),
        label: Text(label, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
