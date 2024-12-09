import 'package:cinemapedia_app/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlayingMovies({int page = 1});

  Future<List<Movie>> getPopularMovies({int page = 1});
}
