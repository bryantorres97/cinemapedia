import 'package:cinemapedia_app/domain/domain.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDataSource _moviesDataSource;

  MoviesRepositoryImpl(this._moviesDataSource);

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) {
    return _moviesDataSource.getNowPlayingMovies(page: page);
  }
}
