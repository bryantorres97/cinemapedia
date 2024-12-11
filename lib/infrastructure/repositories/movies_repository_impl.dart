import 'package:cinemapedia_app/domain/domain.dart';

class MoviesRepositoryImpl extends MoviesRepository {
  final MoviesDataSource _moviesDataSource;

  MoviesRepositoryImpl(this._moviesDataSource);

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) {
    return _moviesDataSource.getNowPlayingMovies(page: page);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) {
    return _moviesDataSource.getPopularMovies(page: page);
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) {
    return _moviesDataSource.getTopRatedMovies(page: page);
  }

  @override
  Future<List<Movie>> getUpcomingMovies({int page = 1}) {
    return _moviesDataSource.getUpcomingMovies(page: page);
  }

  @override
  Future<Movie> getMovieDetail(String movieId) {
    return _moviesDataSource.getMovieDetail(movieId);
  }
}
