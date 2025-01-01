import 'package:cinemapedia_app/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/local_storage_repository.dart';

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final LocalStorageDataSource _dataSource;

  LocalStorageRepositoryImpl(this._dataSource);

  @override
  Future<List<Movie>> getFavoriteMovies({int limit = 10, int offset = 0}) {
    return _dataSource.getFavoriteMovies(limit: limit, offset: offset);
  }

  @override
  Future<bool> isFavoriteMovie(int movieId) {
    return _dataSource.isFavoriteMovie(movieId);
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movie) {
    return _dataSource.toggleFavoriteMovie(movie);
  }

  @override
  Future<int> countFavorites() {
    return _dataSource.countFavorites();
  }
}
