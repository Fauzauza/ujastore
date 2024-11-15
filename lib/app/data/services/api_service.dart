import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService {
  final String _apiKey = '90032008d11542d0b405507f96b41472';
  final String _baseUrl = 'https://newsapi.org/v2/';

  // Mengambil berita seputar game di Indonesia
  // Mengambil berita seputar game di Indonesia
  Future<List<dynamic>> fetchNewsByQuery(
      {String query = 'esports Indonesia'}) async {
    try {
      final response = await http.get(
        Uri.parse(
            '${_baseUrl}everything?q=$query&language=id&sortBy=relevancy&apiKey=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Debugging untuk memastikan hasil respons API
        print('Response Data: $data');

        // Periksa apakah key 'articles' ada dan tidak kosong
        if (data['articles'] != null && data['articles'].isNotEmpty) {
          return data['articles'];
        } else {
          throw Exception('Tidak ada artikel ditemukan.');
        }
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error fetching news: $error');
    }
  }
}
