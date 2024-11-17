import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ujastore/app/modules/home/controllers/all_games_controller.dart';
import 'product_detail_view.dart';

class AllGamesPage extends GetView<AllGamesController> {
  const AllGamesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semua Game'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(controller.isListening ? Icons.mic : Icons.mic_none),
            onPressed: controller.isListening
                ? controller.stopListening
                : controller.startListening,
          ),
        ],
      ),
      body: Container(
        color: Colors.lightBlue[50],
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
              Obx(() => Expanded(
                    child: ListView.builder(
                      itemCount: controller.filteredGames.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          color: Colors.white,
                          shadowColor: Colors.black.withOpacity(0.2),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: ClipOval(
                              child: Image.network(
                                controller.filteredGames[index].imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              controller.filteredGames[index].name,
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Get.to(() => ProductDetailView(
                                  product: controller.filteredGames[index]));
                            },
                          ),
                        );
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
