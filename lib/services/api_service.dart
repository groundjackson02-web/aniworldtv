import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/series.dart';
import '../models/episode.dart';

class ApiService {
  final String baseUrl;
  final String? authToken;

  ApiService({required this.baseUrl, this.authToken});

  Map<String, String> get _headers => {
    if (authToken != null) 'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json',
  };

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Backend returns a token or session cookie. 
      // For this implementation, we'll assume the backend returns a token in JSON.
      final data = json.decode(response.body);
      return data['token'] != null; 
    }
    return false;
  }

  Future<List<Series>> getContinueWatching() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/playback/recent'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Series.fromJson(json)).toList();
    }
    throw Exception('Failed to load continue watching');
  }

  Future<List<Series>> getLibraryGrid() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/library?view=grid'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List seriesList = data['series'] ?? [];
      return seriesList.map((json) => Series.fromJson(json)).toList();
    }
    throw Exception('Failed to load library');
  }

  Future<Map<String, dynamic>> getPlaybackInfo(String episodeUrl) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/playback/get?episode_url=${Uri.encodeComponent(episodeUrl)}'),
      headers: _headers,
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    throw Exception('Failed to load playback info');
  }
}
