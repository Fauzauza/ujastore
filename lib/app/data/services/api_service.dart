// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsApiService {
  final String _apiKey = '209bbee11dc8265933e3e3365f1390b7';
  final String _baseUrl = 'https://gnews.io/api/v4/';

  Future<List<dynamic>> fetchNewsByQuery(
      {String query = 'esports Indonesia'}) async {
    try {
      final response = await http.get(
        Uri.parse(
          '${_baseUrl}search?q=$query&lang=id&country=id&token=$_apiKey', // Menambahkan parameter country=id
        ),
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
