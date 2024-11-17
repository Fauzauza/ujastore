// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/article_controller.dart';
import 'webview_page.dart'; // Pastikan untuk mengimpor WebViewPage untuk membuka artikel

class ArticleView extends StatelessWidget {
  final ArticleController articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artikel Berita eSports'),
      ),
      body: Obx(() {
        // Jika artikel sedang dimuat
        if (articleController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Jika tidak ada artikel
        if (articleController.newsArticles.isEmpty) {
          return Center(child: Text('Tidak ada artikel ditemukan.'));
        }

        // Menampilkan artikel dalam ListView
        return ListView.builder(
          itemCount: articleController.newsArticles.length,
          itemBuilder: (context, index) {
            var news = articleController.newsArticles[index];

            return GestureDetector(
              onTap: () {
                // Jika URL artikel tersedia, buka di WebView
                if (news['url'] != null) {
                  Get.to(() => WebViewPage(news['url'])); // Buka artikel di WebViewPage
                } else {
                  Get.snackbar('Error', 'URL tidak tersedia untuk artikel ini.');
                }
              },
              child: Card(
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Menampilkan gambar artikel jika tersedia
                    news['image'] != null
                        ? Image.network(
                            news['image'],
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                              return Container(
                                height: 200,
                                color: Colors.grey[200],
                                child: Center(child: Text('Gambar gagal dimuat')),
                              );
                            },
                          )
                        : Container(
                            height: 200,
                            color: Colors.grey[200],
                            child: Center(child: Text('No image available')),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        news['title'] ?? 'No Title',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        news['description'] ?? 'Tidak ada deskripsi',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
