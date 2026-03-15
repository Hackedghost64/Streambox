import 'package:dio/dio.dart';
import '../models/movie.dart';
import '../utils/constants.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: Constants.baseUrl,
    queryParameters: {
      'api_key': Constants.tmdbApiKey,
    },
  ));

  Future<List<Movie>> getTrendingMovies() async {
    try {
      final response = await _dio.get(Constants.trendingMovies);
      final List results = response.data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load trending movies: $e');
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await _dio.get(Constants.popularMovies);
      final List results = response.data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load popular movies: $e');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    try {
      final response = await _dio.get(Constants.topRatedMovies);
      final List results = response.data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load top rated movies: $e');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    try {
      final response = await _dio.get(Constants.upcomingMovies);
      final List results = response.data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load upcoming movies: $e');
    }
  }
}
