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
  File? _image; // To store selected image
  File? _video; // To store selected video
  VideoPlayerController?
      _videoController; // To control video playback (optional)

  // Function to pick an image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile =
        await _picker.pickImage(source: source); // Camera or gallery option
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _video = null; // Clear the selected video if an image is chosen
        _videoController
            ?.dispose(); // Dispose the video controller if video was chosen previously
        _videoController = null;
      });
    }
  }

  // Function to pick a video from camera or gallery
  Future<void> _pickVideo(ImageSource source) async {
    final XFile? pickedFile =
        await _picker.pickVideo(source: source); // Camera or gallery option
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
        _image = null; // Clear the selected image if a video is chosen
        _videoController = VideoPlayerController.file(_video!)
          ..initialize().then((_) {
            setState(() {});
            _videoController!.play();
          });
      });
    }
  }

  // Function to submit the complaint with image/video
  void _submitComplaint() {
    if (_image != null || _video != null) {
      // You can add API call here to submit the complaint

      // Show confirmation snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Complaint Submitted!")));

      // Clear the selected image or video after submission
      setState(() {
        _image = null;
        _video = null;
        _videoController
            ?.dispose(); // Dispose video controller if video was selected
        _videoController = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please add an image or video")));
    }
  }

  @override
  void dispose() {
    _videoController
        ?.dispose(); // Clean up video controller when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Page'),
      ),
      body: SingleChildScrollView(
        // Wrap the content in a SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Image or video display area
              if (_image != null) Image.file(_image!),
              if (_video != null)
                _videoController != null &&
                        _videoController!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: VideoPlayer(_videoController!),
                      )
                    : Container(),

              // Buttons to pick an image or video
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Ubah nilai sesuai keinginan
                      ),
                    ),
                    onPressed: _image == null
                        ? () => _showImagePickerOptions()
                        : null, // Disable if image is selected
                    child: Text(
                      'Pick Image',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Ubah nilai sesuai keinginan
                      ),
                    ),
                    onPressed: _video == null
                        ? () => _showVideoPickerOptions()
                        : null, // Disable if video is selected
                    child: Text(
                      'Pick Video',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              // Submit button
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Ubah nilai sesuai keinginan
                  ),
                ),
                onPressed: _submitComplaint,
                child: Text(
                  'Submit Complaint',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show options for picking an image (Camera or Gallery)
  void _showImagePickerOptions() async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick Image Source'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(ImageSource.camera);
            },
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(ImageSource.gallery);
            },
            child: Text('Gallery'),
          ),
        ],
      ),
    );
    if (source != null) {
      _pickImage(source);
    }
  }

  // Function to show options for picking a video (Camera or Gallery)
  void _showVideoPickerOptions() async {
    final ImageSource? source = await showDialog<ImageSource>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick Video Source'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(ImageSource.camera);
            },
            child: Text('Camera'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(ImageSource.gallery);
            },
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
