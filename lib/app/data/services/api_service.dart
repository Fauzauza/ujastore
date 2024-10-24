import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService {
  final String _apiKey = '90032008d11542d0b405507f96b41472';
  final String _baseUrl = 'https://newsapi.org/v2/';

  // Mengambil berita dengan kata kunci tertentu
  Future<List<dynamic>> fetchNewsByQuery({String query = 'game'}) async {
    final response = await http
        .get(Uri.parse('${_baseUrl}everything?q=$query&apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Response Data: $data'); // Debugging untuk melihat respon API
      return data['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
