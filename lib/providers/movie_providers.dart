import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../services/api_service.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final trendingMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  return ref.read(apiServiceProvider).getTrendingMovies();
});

final popularMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  return ref.read(apiServiceProvider).getPopularMovies();
});

final topRatedMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  return ref.read(apiServiceProvider).getTopRatedMovies();
});

final upcomingMoviesProvider = FutureProvider<List<Movie>>((ref) async {
  return ref.read(apiServiceProvider).getUpcomingMovies();
});
