import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/movie_providers.dart';
import '../widgets/movie_widgets.dart';
import '../screens/download_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingMoviesAsync = ref.watch(trendingMoviesProvider);
    final popularMoviesAsync = ref.watch(popularMoviesProvider);
    final topRatedMoviesAsync = ref.watch(topRatedMoviesProvider);
    final upcomingMoviesAsync = ref.watch(upcomingMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MovieBox',
          style: TextStyle(
            color: Color(0xFFE50914),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Implement search functionality later
            },
          ),
          IconButton(
            icon: const Icon(Icons.file_download, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DownloadScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            trendingMoviesAsync.when(
              data: (movies) => MovieCarousel(title: 'Trending', movies: movies),
              loading: () => const _LoadingCarousel(),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
            popularMoviesAsync.when(
              data: (movies) => MovieCarousel(title: 'Popular', movies: movies),
              loading: () => const _LoadingCarousel(),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
            topRatedMoviesAsync.when(
              data: (movies) => MovieCarousel(title: 'Top Rated', movies: movies),
              loading: () => const _LoadingCarousel(),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
            upcomingMoviesAsync.when(
              data: (movies) => MovieCarousel(title: 'Upcoming', movies: movies),
              loading: () => const _LoadingCarousel(),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingCarousel extends StatelessWidget {
  const _LoadingCarousel();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 250,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
