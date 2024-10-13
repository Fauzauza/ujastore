// lib/service/github_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

class GitHubService {
  final String _baseUrl =
      'https://api.github.com/repos/bagussyahrijal/ujastore';
  final String _token =
      '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'; // Ganti dengan token Anda

  Future<Map<String, dynamic>> fetchRepoInfo() async {
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'token $_token',
        'Accept': 'application/vnd.github.v3+json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Kembalikan data sebagai Map
    } else {
      throw Exception('Request failed with status: ${response.statusCode}.');
    }
  }
}
