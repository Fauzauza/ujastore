import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/article_controller.dart';
import 'webview_page.dart'; // Pastikan untuk mengimpor WebViewPage

class ArticleView extends StatelessWidget {
  final ArticleController articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artikel Berita'),
      ),
      body: Obx(() {
        if (articleController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (articleController.newsArticles.isEmpty) {
          return Center(child: Text('No articles found.'));
        }

        return ListView.builder(
          itemCount: articleController.newsArticles.length,
          itemBuilder: (context, index) {
            var news = articleController.newsArticles[index];
            return GestureDetector(
              onTap: () {
                if (news['url'] != null) {
                  Get.to(() => WebViewPage(news['url']));
                } else {
                  Get.snackbar(
                      'Error', 'URL tidak tersedia untuk artikel ini.');
                }
              },
              child: Card(
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    news['urlToImage'] != null
                        ? Image.network(
                            news['urlToImage'],
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                            errorBuilder: (BuildContext context, Object error,
                                StackTrace? stackTrace) {
                              return Container(
                                height: 200,
                                color: Colors.grey[200],
                                child:
                                    Center(child: Text('Failed to load image')),
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
                        news['description'] ?? 'No Description',
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
