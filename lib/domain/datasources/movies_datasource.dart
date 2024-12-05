import 'package:cinemapedia_app/domain/entities/movie.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlayingMovies({int page = 1});
}
