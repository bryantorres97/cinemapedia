import 'package:cinemapedia_app/domain/databases/database.dart';
import 'package:cinemapedia_app/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/mappers/mappers.dart';

class DriftDatasource implements LocalStorageDataSource {
  final database = AppDatabase();

  @override
  Future<List<Movie>> getFavoriteMovies(
      {int limit = 10, int offset = 0}) async {
    final moviesDb = await database.getAllMovies(limit, offset: offset);
    final movies = moviesDb
        .map((movieDb) => MovieMapper.movieDbDataToEntity(movieDb))
        .toList();
    return movies;
  }

  @override
  Future<bool> isFavoriteMovie(int movieId) async {
    final movieDb = await database.getMovieById(movieId);
    return movieDb != null;
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movie) async {
    final isFavoriteMovie = await this.isFavoriteMovie(movie.id);

    if (isFavoriteMovie) {
      await database.deleteMovie(movie.id);
      return;
    }

    await database.insertMovie(movie);
  }
}
