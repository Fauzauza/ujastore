import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujastore/app/modules/home/controllers/all_games_controller.dart';
import 'package:ujastore/app/routes/app_routes.dart';

class AllGamesPage extends GetView<AllGamesController> {
  const AllGamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 36, 52),
      appBar: AppBar(
        title: Text('Semua Game'),
        backgroundColor: const Color.fromARGB(255, 53, 53, 68),
        actions: [
          IconButton(
            icon: Icon(controller.isListening ? Icons.mic : Icons.mic_none),
            onPressed: controller.isListening
                ? controller.stopListening
                : controller.startListening,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: (query) {
                    controller.searchQuery = query;
                    controller.filterGames();
                  },
                  decoration: InputDecoration(
                    labelText: 'Cari game...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Obx(
                () => GridView.builder(
                  shrinkWrap: true, // Tambahkan ini
                  physics:
                      NeverScrollableScrollPhysics(), // Nonaktifkan scrolling GridView
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: controller.filteredGames.length,
                  itemBuilder: (context, index) {
                    final product = controller.filteredGames[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.PRODUCT_DETAIL, arguments: product);
                      },
                      child: Container(
                        width: (Get.width / 3) - 15,
                        height: ((Get.width / 3) - 15) * 1.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.cover,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
