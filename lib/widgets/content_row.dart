import 'package:flutter/material.dart';
import '../models/series.dart';

class ContentRow extends StatelessWidget {
  final String title;
  final Future<List<Series>> future;
  final Widget Function(Series) builder;

  const ContentRow({
    super.key, 
    required this.title, 
    required this.future, 
    required this.builder
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
        ),
        SizedBox(
          height: 320,
          child: FutureBuilder<List<Series>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No content available'));
              }

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                itemBuilder: (context, index) {
                  return builder(snapshot.data![index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
