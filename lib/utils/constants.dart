class Constants {
  // Replace with your own TMDB API key or use the one from original app for testing
  static const String tmdbApiKey = String.fromEnvironment('TMDB_API_KEY', defaultValue: '');
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
  static const String imageOriginalBaseUrl = "https://image.tmdb.org/t/p/original";

  // Endpoints
  static const String trendingMovies = "/trending/movie/day";
  static const String popularMovies = "/movie/popular";
  static const String topRatedMovies = "/movie/top_rated";
  static const String upcomingMovies = "/movie/upcoming";
  static const String nowPlayingMovies = "/movie/now_playing";
}
