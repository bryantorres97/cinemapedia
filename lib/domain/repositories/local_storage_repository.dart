import 'package:cinemapedia_app/domain/domain.dart';

abstract class LocalStorageRepository {
  Future<void> toggleFavoriteMovie(Movie movie);

  Future<List<Movie>> getFavoriteMovies({int limit = 10, int offset = 0});

  Future<bool> isFavoriteMovie(int movieId);
}
