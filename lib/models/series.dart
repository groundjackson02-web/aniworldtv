class Series {
  final String url;
  final String title;
  final String? posterUrl;
  final int totalEpisodes;

  Series({
    required this.url,
    required this.title,
    this.posterUrl,
    this.totalEpisodes = 0,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      url: json['series_url'] ?? json['url'] ?? '',
      title: json['title'] ?? json['folder'] ?? 'Unknown',
      posterUrl: json['poster_url'],
      totalEpisodes: json['total_episodes'] ?? 0,
    );
  }
}
