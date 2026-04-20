import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _baseUrl;
  ApiService? _apiService;

  String? get token => _token;
  String? get baseUrl => _baseUrl;
  ApiService? get apiService => _apiService;

  bool get isAuthenticated => _token != null;

  Future<void> loadAuth() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    _baseUrl = prefs.getString('server_url') ?? 'http://192.168.178.1:8080';
    
    if (_token != null) {
      _apiService = ApiService(baseUrl: _baseUrl!, authToken: _token);
    }
    notifyListeners();
  }

  Future<bool> login(String ip, String username, String password) async {
    final formattedIp = ip.startsWith('http') ? ip : 'http://$ip';
    _baseUrl = formattedIp;
    
    final api = ApiService(baseUrl: _baseUrl!);
    try {
      final success = await api.login(username, password);
      if (success) {
        // In a real scenario, the token would come from the api.login response
        // For now, we'll simulate getting a token.
        _token = 'simulated_token_from_backend'; 
        _apiService = ApiService(baseUrl: _baseUrl!, authToken: _token);
        
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);
        await prefs.setString('server_url', _baseUrl!);
        
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Login error: $e');
    }
    return false;
  }

  Future<void> logout() async {
    _token = null;
    _apiService = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    notifyListeners();
  }
}
