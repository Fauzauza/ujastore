import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ComplaintPage extends StatefulWidget {
  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _complaintTextController = TextEditingController(); // Controller untuk teks keluhan
  File? _image; // Untuk menyimpan gambar yang dipilih
  File? _video; // Untuk menyimpan video yang dipilih
  VideoPlayerController? _videoController; // Untuk mengontrol pemutaran video

  // Fungsi untuk memilih gambar dari kamera atau galeri
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _video = null; // Hapus video jika gambar dipilih
        _videoController?.dispose();
        _videoController = null;
      });
    }
  }

  // Fungsi untuk memilih video dari kamera atau galeri
  Future<void> _pickVideo(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickVideo(source: source);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
        _image = null; // Hapus gambar jika video dipilih
        _videoController = VideoPlayerController.file(_video!)
          ..initialize().then((_) {
            setState(() {});
            _videoController!.play();
          });
      });
    }
  }

  // Fungsi untuk mengirimkan keluhan dengan gambar/video dan teks
  void _submitComplaint() {
    final complaintText = _complaintTextController.text; // Ambil teks keluhan
    if ((complaintText.isNotEmpty && (_image != null || _video != null))) {
      // Tambahkan logika API atau pengolahan data di sini

      // Tampilkan notifikasi konfirmasi
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Complaint Submitted: $complaintText")));

      // Reset data setelah keluhan dikirim
      setState(() {
        _image = null;
        _video = null;
        _videoController?.dispose();
        _videoController = null;
        _complaintTextController.clear(); // Hapus teks keluhan
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please add an image/video and complaint text")));
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _complaintTextController.dispose(); // Hapus controller teks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Tampilkan gambar atau video yang dipilih
              if (_image != null) Image.file(_image!),
              if (_video != null)
                _videoController != null && _videoController!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      )
                    : Container(),

              // Input teks keluhan
              SizedBox(height: 20),
              TextField(
                controller: _complaintTextController,
                maxLines: 4,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your complaint',
                  hintText: 'Describe your issue here...',
                ),
              ),

              // Tombol untuk memilih gambar atau video
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _image == null
                        ? () => _showImagePickerOptions()
                        : null, // Nonaktifkan jika gambar telah dipilih
                    child: Text('Pick Image'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _video == null
                        ? () => _showVideoPickerOptions()
                        : null, // Nonaktifkan jika video telah dipilih
                    child: Text('Pick Video'),
                  ),
                ],
              ),

              // Tombol kirim keluhan
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitComplaint,
                child: Text('Submit Complaint'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan dialog pilihan sumber gambar
  void _showImagePickerOptions() async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick Image Source'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.camera),
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
            child: Text('Gallery'),
          ),
        ],
      ),
    );
    if (source != null) {
      _pickImage(source);
    }
  }

  // Fungsi untuk menampilkan dialog pilihan sumber video
  void _showVideoPickerOptions() async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick Video Source'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.camera),
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
            child: Text('Gallery'),
          ),
        ],
      ),
    );
    if (source != null) {
      _pickVideo(source);
    }
  }
}
