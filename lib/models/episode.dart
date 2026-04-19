class Episode {
  final String url;
  final int number;
  final String title;
  final double timestamp;

  Episode({
    required this.url,
    required this.number,
    required this.title,
    this.timestamp = 0.0,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      url: json['url'] ?? '',
      number: json['episode_number'] ?? 0,
      title: json['title'] ?? 'Episode ${json['episode_number']}',
      timestamp: (json['timestamp'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
