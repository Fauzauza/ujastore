import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart'; // Untuk geocoding alamat
import 'package:url_launcher/url_launcher.dart'; // Untuk meluncurkan URL

class AboutView extends StatefulWidget {
  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  late GoogleMapController mapController;
  CameraPosition? _initialCameraPosition;
  Position? _currentPosition;
  String _address = ''; // Untuk menyimpan alamat hasil geocoding

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  // Fungsi untuk memeriksa izin lokasi
  Future<void> _checkLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      print('Izin lokasi ditolak');
    }
  }

  // Fungsi untuk mendapatkan lokasi pengguna
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
        _initialCameraPosition = CameraPosition(
          target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          zoom: 15.0,
        );
      });

      // Mengonversi koordinat menjadi alamat menggunakan geocoding
      _getAddressFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude);
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  // Fungsi untuk mengonversi koordinat menjadi alamat
  Future<void> _getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          // Menggabungkan informasi untuk mendapatkan alamat lengkap
          _address = '${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, '
                      '${place.administrativeArea}, ${place.country}, ${place.postalCode}';
        });
      }
    } catch (e) {
      print('Error getting address: $e');
      setState(() {
        _address = 'Alamat tidak ditemukan';
      });
    }
  }

  // Fungsi untuk membuka Google Maps dengan URL
  Future<void> _openGoogleMaps() async {
    final url = 'https://www.google.com/maps?q=${_currentPosition!.latitude},${_currentPosition!.longitude}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tentang Kami'),
      ),
      body: _initialCameraPosition == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Sejarah UjaStore
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Sejarah UjaStore',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '''Seorang pengusaha muda memiliki passion dalam dunia gaming dan melihat banyak pemain game kesulitan dalam melakukan top up atau pembelian item game. Oleh karena itu, ia memutuskan untuk memulai bisnis baru yang dikenal sebagai UjaStore pada tahun 2024. 

UjaStore adalah sebuah website yang menyediakan layanan top up game bagi pemain game dengan fitur unik seperti sistem pembayaran yang aman, proses top up yang cepat, dan layanan pelanggan yang responsif.

UjaStore memiliki jaringan kerja sama dengan berbagai publisher game, memudahkan pemain game untuk melakukan top up untuk game-game tersebut. Bisnis ini terus berkembang dan memperluas jangkauannya, dan pada tahun 2021 menjadi salah satu website top up game terkemuka di Indonesia. Pelanggan dapat melakukan top up game dengan mudah dan aman. Bisnis ini terus berupaya untuk meningkatkan layanannya dengan menambah fitur baru seperti top up melalui aplikasi mobile dan integrasi dengan beberapa publisher game terkemuka.
''',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ),

                  // Visi dan Misi
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Visi dan Misi',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Icon(Icons.visibility, size: 30), // Ikon untuk Visi
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Visi: Menjadi layanan top up game terkemuka dan terpercaya bagi pemain game di seluruh dunia.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Icon(Icons.assignment, size: 30), // Ikon untuk Misi
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Misi: Memberikan layanan top up game yang cepat, mudah, dan aman bagi pemain game dengan layanan pelanggan yang responsif dan memuaskan.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Menampilkan Lokasi Pengguna
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Koordinat Lokasi Pengguna:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      _currentPosition == null
                          ? 'Menunggu lokasi...'
                          : 'Latitude: ${_currentPosition!.latitude}, Longitude: ${_currentPosition!.longitude}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Menampilkan Alamat Pengguna
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      _address.isEmpty ? 'Menunggu alamat...' : 'Alamat: $_address',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Tombol untuk membuka Google Maps
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: _openGoogleMaps,
                      child: Text('Buka di Google Maps', style: TextStyle(fontSize: 16)),
                    ),
                  ),

                  // Deskripsi Kantor Pusat UjaStore
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Kantor Pusat UjaStore',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Alamat: Gg. 12 No.3, Dusun Bend., Landungsari, Kec. Dau, Kabupaten Malang, Jawa Timur 65151',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                ],
              ),
            ),
    );
  }
}
