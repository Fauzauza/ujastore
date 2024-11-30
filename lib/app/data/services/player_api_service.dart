// lib/services/player_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class PlayerApiService {
  final String _apiKey = 'fea30142eemshe21ce27a5f46b04p1eaae8jsn56ee61547f2'; // Ganti dengan RapidAPI key Anda
  final String _baseUrl = 'https://id-game-checker.p.rapidapi.com/ff-player-info/1662626173/SG '; // Ganti dengan base URL API yang Anda gunakan

  // Mengecek ketersediaan ID player
  Future<Map<String, dynamic>> checkPlayerId(String playerId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/check_player?id=$playerId'), // Ganti dengan endpoint yang sesuai
      headers: {
        'x-rapidapi-host': 'id-game-checker.p.rapidapi.com', // Ganti dengan host yang sesuai
        'x-rapidapi-key': _apiKey,
        'useQueryString': 'true'
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']; // Mengembalikan data pemain
    } else {
      throw Exception('Failed to check player ID: ${response.body}');
    }
  }
}
