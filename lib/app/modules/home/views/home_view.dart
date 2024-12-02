// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujastore/app/modules/home/views/about_view.dart';
import 'package:ujastore/app/modules/home/views/all_games_page.dart';
import 'package:ujastore/app/modules/home/views/complain_view.dart';
import 'package:ujastore/app/modules/home/views/image_picker_view.dart';
import 'package:ujastore/app/modules/home/views/login_view.dart';
import 'package:ujastore/app/modules/home/views/profile_view.dart';
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage(
                  'assets/logo.png',
                ),
                width: 70,
                height: 70,
              ),
              Obx(
                () => profileController.isLoggedIn.value
                    ? GestureDetector(
                        onTap: () => Get.to(ProfilePage()),
                        child: Obx(
                          () => Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            child: CircleAvatar(
                              backgroundImage:
                                  profileController.imagePath.value.isNotEmpty
                                      ? NetworkImage(
                                          profileController.imagePath.value)
                                      : null,
                              child: profileController.profileImage == null
                                  ? Text(
                                      profileController
                                              .userName.value.isNotEmpty
                                          ? profileController.userName.value[0]
                                              .toUpperCase()
                                          : 'U',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : null,
                              radius: 20,
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              )
            ],
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
              _buildDrawerItem(Icons.home, 'Beranda', onTap: () {
                Get.to(ImagePickerView());
              }),
              _buildDrawerItem(Icons.games, 'Semua Game', onTap: () {
                Get.to(AllGamesPage());
              }),
              _buildDrawerItem(Icons.article, 'Artikel Berita', onTap: () {
                Get.to(() => ArticleView());
              }),
              _buildDrawerItem(Icons.info, 'Tentang Kami', onTap: () {
                Get.to(() => AboutView()); // Navigasi ke halaman AboutView
              }),
              Obx(() => profileController.isLoggedIn.value
                  ? SizedBox.shrink()
                  : _buildDrawerItem(Icons.person, 'Login', onTap: () {
                      Get.to(() => LoginView());
                    })),
              Obx(() => profileController.isLoggedIn.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text(
                            "USER PANEL AREA",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        _buildDrawerItem(Icons.person, 'Profile', onTap: () {
                          Get.to(ProfilePage());
                        }),
                        _buildDrawerItem(Icons.shopping_cart, 'Keranjang',
                            onTap: () {
                          Get.to(() => CartView());
                        }),
                        _buildDrawerItem(Icons.report, 'Pengajuan Komplain',
                            onTap: () {
                          Get.to(() => ComplaintPage());
                        }),
                        _buildDrawerItem(
                            Icons.logout,
                            iconColor: Colors.red,
                            'Logout', onTap: () async {
                          await profileController.logout();
                        }),
                      ],
                    )
                  : SizedBox.shrink()),
            ],
          ),
        ),
        body: HomeContent());
  }

  Widget _buildDrawerItem(IconData icon, String title,
      {VoidCallback? onTap, Color? iconColor}) {
    return ListTile(
      leading: Icon(icon,
          color: iconColor ?? const Color.fromARGB(255, 255, 255, 255)),
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
