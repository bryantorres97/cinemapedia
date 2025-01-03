import 'package:cinemapedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/entities/youtube_video.dart';
import 'package:cinemapedia_app/domain/repositories/movies_repository.dart';

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

  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) {
    return _moviesDataSource.searchMovies(query, page: page);
  }

  @override
  Future<YoutubeVideo?> getMovieTrailer(String movieId) {
    return _moviesDataSource.getMovieTrailer(movieId);
  }

  @override
  Future<List<Movie>> getSimilarMovies(String movieId, {int page = 1}) {
    return _moviesDataSource.getSimilarMovies(movieId, page: page);
  }
}
