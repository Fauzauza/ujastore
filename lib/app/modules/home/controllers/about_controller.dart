// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutController extends GetxController {
  final Rxn<Position> _currentPosition = Rxn<Position>();
  final RxString locationMessage = "Mencari Lat dan Long...".obs;
  final RxBool loading = false.obs;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    loading.value = true; 

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        throw Exception('Location service not enabled');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied forever');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      _currentPosition.value = position; // Update reactive variable
      locationMessage.value =
          "Latitude: ${position.latitude}, Longitude:${position.longitude}";
    } catch (e) {
      locationMessage.value = 'Gagal mendapatkan lokasi';
    } finally {
      loading.value = false; // Reset loading state
    }
  }

  void openGoogleMaps() {
    if (_currentPosition.value != null) {
      final url =
          'https://www.google.com/maps?q=${_currentPosition.value!.latitude},${_currentPosition.value!.longitude}';
      launchURL(url);
    }
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
