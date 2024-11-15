import 'package:get/get.dart';
import '../../../data/services/api_service.dart';

class ArticleController extends GetxController {
  var newsArticles = [].obs;  // Menyimpan daftar artikel
  var isLoading = true.obs;   // Status loading

  final NewsApiService _newsApiService = NewsApiService();

  @override
  void onInit() {
    super.onInit();
    fetchEsportsArticles();  // Mengambil artikel saat controller diinisialisasi
  }

  // Fungsi untuk mengambil artikel terkait esports di Indonesia
  void fetchEsportsArticles() async {
    try {
      isLoading(true);  // Menandakan bahwa data sedang dimuat
      newsArticles.value = await _newsApiService.fetchNewsByQuery(query: 'esports Indonesia');
    } catch (error) {
      print('Error fetching news: $error');
    } finally {
      isLoading(false);  // Menandakan bahwa data telah dimuat
    }
  }
}
