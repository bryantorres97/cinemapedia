import 'package:cinemapedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDataSource _moviesDataSource;

  MoviesRepositoryImpl(this._moviesDataSource);

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) {
    return _moviesDataSource.getNowPlayingMovies(page: page);
  }
}
