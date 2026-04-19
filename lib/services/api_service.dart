import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/series.dart';
import '../models/episode.dart';

class ApiService {
  final String baseUrl;
  final String authToken;

  ApiService({required this.baseUrl, required this.authToken});

  Map<String, String> get _headers => {
    'Authorization': 'Bearer $authToken',
    'Content-Type': 'application/json',
  };

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
