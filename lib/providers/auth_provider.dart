import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  ApiService? _apiService;
  final String baseUrl = 'http://192.168.178.1:8080'; // Standard-IP, kann in settings verschoben werden

  String? get token => _token;
  ApiService? get apiService => _apiService;

  bool get isAuthenticated => _token != null;

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    if (_token != null) {
      _apiService = ApiService(baseUrl: baseUrl, authToken: _token!);
    }
    notifyListeners();
  }

  Future<void> login(String newToken) async {
    _token = newToken;
    _apiService = ApiService(baseUrl: baseUrl, authToken: _token!);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', newToken);
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _apiService = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    notifyListeners();
  }
}
