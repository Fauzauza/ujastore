import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujastore/app/modules/home/views/about_view.dart';
import 'package:ujastore/app/modules/home/views/all_games_page.dart';
import 'package:ujastore/app/modules/home/views/image_picker_view.dart';
import 'package:ujastore/app/modules/home/views/login_view.dart';
import '../controllers/profile_controller.dart';
import 'home_content.dart';
import 'article_view.dart';
import 'cart_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ProfileController profileController = Get.put(ProfileController());

  void _onItemTapped(int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 40, 36, 52),
        appBar: AppBar(
          toolbarHeight: 70,
          title: Image(
            image: AssetImage(
              'assets/logo.png',
            ),
            width: 70,
            height: 70,
          ),
          centerTitle: false,
          backgroundColor: const Color.fromARGB(255, 53, 53, 68),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 53, 53, 68),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.zero,
                decoration:
                    BoxDecoration(color: const Color.fromARGB(255, 53, 53, 68)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/logo.png',
                      ),
                      width: 135,
                      height: 135,
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(Icons.home, 'Beranda', 0, onTap: (){Get.to(ImagePickerView());}),
              _buildDrawerItem(Icons.games, 'Semua Game', 1, onTap: (){
                Get.to(AllGamesPage());
              }),
              _buildDrawerItem(Icons.shopping_cart, 'Keranjang', -1, onTap: () {
                Get.to(() => CartView());
              }),
              _buildDrawerItem(Icons.article, 'Artikel Berita', -1, onTap: () {
                Get.to(() => ArticleView());
              }),
              _buildDrawerItem(Icons.person, 'Login', -1, onTap: () {
                Get.to(() => LoginView()); // Navigasi ke ImagePickerView
              }),
              _buildDrawerItem(Icons.info, 'Tentang Kami', -1, onTap: () {
  Get.to(() => AboutView()); // Navigasi ke halaman AboutView
}),

            ],
          ),
        ),
        body: HomeContent());
  }

  Widget _buildDrawerItem(IconData icon, String title, int index,
      {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
      title: Text(
        title,
        style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      onTap: onTap ??
          () {
            setState(() {});
            Navigator.pop(context);
          },
    );
  }
}
