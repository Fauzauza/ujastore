import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/profile_controller.dart';
import 'home_content.dart';
import 'all_games_page.dart';
import 'profile_view.dart';
import 'article_view.dart';
import 'cart_view.dart'; // Import CartView
import 'audio_view.dart'; // Import AudioView
import 'youtube_audio_view.dart'; // Import YouTubeAudioView

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeController homeController = Get.put(HomeController());
  final ProfileController profileController = Get.put(ProfileController());

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    HomeContent(),
    AllGamesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100]!,
      appBar: AppBar(
        title: Text(
          'ujastore.id',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => ProfilePage());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Obx(() => CircleAvatar(
                    backgroundImage: profileController.profileImage != null
                        ? FileImage(profileController.profileImage!)
                        : null,
                    child: profileController.profileImage == null
                        ? Icon(Icons.person, size: 30, color: Colors.grey)
                        : null,
                    radius: 20,
                  )),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent,
                    Colors.blue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() => CircleAvatar(
                        radius: 40,
                        backgroundImage: profileController.profileImage != null
                            ? FileImage(profileController.profileImage!)
                            : null,
                        child: profileController.profileImage == null
                            ? Icon(Icons.person, size: 40, color: Colors.white)
                            : null,
                        backgroundColor: Colors.grey[300],
                      )),
                  SizedBox(height: 8),
                  Obx(() => Text(
                        profileController.userName.value.isNotEmpty
                            ? profileController.userName.value
                            : 'Nama Pengguna',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            _buildDrawerItem(Icons.home, 'Beranda', 0),
            _buildDrawerItem(Icons.games, 'Semua Game', 1),
            _buildDrawerItem(Icons.shopping_cart, 'Keranjang', -1, onTap: () {
              Get.to(() => CartView());
            }),
            _buildDrawerItem(Icons.article, 'Artikel Berita', -1, onTap: () {
              Get.to(() => ArticleView());
            }),
            _buildDrawerItem(Icons.music_note, 'Audio', -1, onTap: () {
              Get.to(() => AudioView()); // Navigasi ke AudioView
            }),
            _buildDrawerItem(Icons.music_video, 'YouTube Audio', -1, onTap: () {
              Get.to(() => YouTubeAudioView()); // Navigasi ke YouTubeAudioView
            }),
            _buildDrawerItem(Icons.track_changes, 'Lacak Pesanan', -1),
          ],
        ),
      ),
      body:
          _selectedIndex < _pages.length ? _pages[_selectedIndex] : Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Cari Game',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, int index,
      {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      onTap: onTap ??
          () {
            setState(() {
              _selectedIndex = index;
            });
            Navigator.pop(context);
          },
    );
  }
}
