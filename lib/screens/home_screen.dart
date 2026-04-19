import 'package:flutter/material.dart';
import '../widgets/content_row.dart';
import '../widgets/movie_card.dart';
import '../models/series.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _api = ApiService(baseUrl: 'http://your-backend-ip:5000', authToken: 'your_token');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar Navigation
          Container(
            width: 80,
            color: Colors.black,
            child: Column(
              children: [
                const SizedBox(height: 40),
                _buildSidebarItem(Icons.home, true),
                _buildSidebarItem(Icons.search, false),
                _buildSidebarItem(Icons.library_books, false),
                _buildSidebarItem(Icons.settings, false),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome Back', style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(height: 30),
                  ContentRow(
                    title: 'Continue Watching',
                    future: _api.getContinueWatching(),
                    builder: (series) => MovieCard(series: series),
                  ),
                  const SizedBox(height: 40),
                  ContentRow(
                    title: 'Your Library',
                    future: _api.getLibraryGrid(),
                    builder: (series) => MovieCard(series: series),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: InkWell(
        onTap: () {},
        child: Icon(
          icon,
          color: isActive ? Theme.of(context).primaryColor : Colors.grey,
          size: 30,
        ),
      ),
    );
  }
}
