import 'package:flutter/material.dart';

class PlayerScreen extends StatelessWidget {
  final String videoUrl;
  const PlayerScreen({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Text(
              'Video Player: $videoUrl',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 50,
            right: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.replay_10, color: Colors.white, size: 40), onPressed: () {}),
                IconButton(icon: const Icon(Icons.pause, color: Colors.white, size: 60), onPressed: () {}),
                IconButton(icon: const Icon(Icons.forward_10, color: Colors.white, size: 40), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
