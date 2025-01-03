import 'package:cinemapedia_app/domain/entities/movie.dart';

abstract class LocalStorageDataSource {
  Future<void> toggleFavoriteMovie(Movie movie);

  Future<List<Movie>> getFavoriteMovies({int limit = 10, int offset = 0});

  Future<bool> isFavoriteMovie(int movieId);

  Future<int> countFavorites();
}
