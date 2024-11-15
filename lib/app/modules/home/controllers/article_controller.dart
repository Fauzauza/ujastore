import 'package:get/get.dart';
import '../../../data/services/api_service.dart';

class ArticleController extends GetxController {
  // Untuk artikel berita
  var newsArticles = [].obs;
  var isLoading = true.obs;

  final NewsApiService _newsApiService = NewsApiService();

  @override
  void onInit() {
    // Fetch berita pada saat controller diinisialisasi
    fetchEsportsArticles();
    super.onInit();
  }

  // Memuat artikel berita tentang esports di Indonesia dari NewsAPI
  void fetchEsportsArticles() async {
    try {
      isLoading(true);
      // Mengambil berita dengan kata kunci yang lebih spesifik
      newsArticles.value =
          await _newsApiService.fetchNewsByQuery(query: 'esports Indonesia');
    } catch (error) {
      print('Error fetching news: $error');
    } finally {
      isLoading(false);
    }
  }
}
