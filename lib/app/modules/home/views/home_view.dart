import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/profile_controller.dart';
import 'home_content.dart'; // Menampilkan konten produk
import 'all_games_page.dart';
import 'profile_view.dart';
import 'article_view.dart'; // Impor ArticleView

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
    HomeContent(), // Menampilkan produk
    AllGamesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('ujastore.id',
                style: TextStyle(
                    color: Theme.of(context).appBarTheme.foregroundColor)),
            GestureDetector(
              onTap: () {
                Get.to(() => ProfilePage()); // Navigasi ke halaman profil
              },
              child: Obx(() => CircleAvatar(
                    backgroundImage: profileController.profileImage != null
                        ? FileImage(profileController.profileImage!)
                        : null,
                    child: profileController.profileImage == null
                        ? Icon(Icons.person,
                            size: 30, color: Colors.grey) // Placeholder
                        : null,
                    radius: 20,
                  )),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
              ),
              child: Column(
                children: [
                  Obx(() => CircleAvatar(
                        radius: 40,
                        backgroundImage: profileController.profileImage != null
                            ? FileImage(profileController.profileImage!)
                            : null,
                        child: profileController.profileImage == null
                            ? Icon(Icons.person,
                                size: 40, color: Colors.grey) // Placeholder
                            : null,
                        backgroundColor: Colors.grey,
                      )),
                  SizedBox(height: 8),
                  Obx(() => Text(
                        profileController.userName.value,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.games),
              title: Text('Semua Game'),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.article), // Ikon untuk Artikel
              title: Text('Artikel Berita'), // Nama untuk Artikel
              onTap: () {
                Get.to(() => ArticleView()); // Navigasi ke ArticleView
              },
            ),
            ListTile(
              leading: Icon(Icons.track_changes),
              title: Text('Lacak Pesanan'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            
          ],
        ),
      ),
      body: _selectedIndex < _pages.length
          ? _pages[_selectedIndex]
          : Container(), // Menampilkan halaman lain (HomeContent, AllGamesPage, ProfilePage)
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
        backgroundColor: Theme.of(context).bottomAppBarColor,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}

extension on ThemeData {
  get bottomAppBarColor => null;
}
