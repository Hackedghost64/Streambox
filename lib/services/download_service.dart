import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/movie.dart';
import '../utils/constants.dart';
import 'database_helper.dart';

final downloadServiceProvider = Provider((ref) => DownloadService());

class DownloadService {
  final Dio _dio = Dio();

  Future<bool> downloadMovie(Movie movie, Function(double) onProgress) async {
    try {
      if (movie.posterPath.isEmpty) return false;

      // In a real app, we would download a video file.
      // For this clone, we'll download the high-res poster as a demonstration.
      final url = '${Constants.imageOriginalBaseUrl}${movie.posterPath}';

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/movie_${movie.id}.jpg';

      await _dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            onProgress(received / total);
          }
        },
      );

      // Save to database
      await DatabaseHelper.instance.insertDownload(movie, filePath);

      return true;
    } catch (e) {
      print('Download error: $e');
      return false;
    }
  }

  Future<bool> deleteDownloadedMovie(int id, String localPath) async {
    try {
      final file = File(localPath);
      if (await file.exists()) {
        await file.delete();
      }
      await DatabaseHelper.instance.deleteDownload(id);
      return true;
    } catch (e) {
      print('Delete error: $e');
      return false;
    }
  }
}
