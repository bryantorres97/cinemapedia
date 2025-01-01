import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/entities/youtube_video.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlayingMovies({int page = 1});

  Future<List<Movie>> getPopularMovies({int page = 1});

  Future<List<Movie>> getUpcomingMovies({int page = 1});

  Future<List<Movie>> getTopRatedMovies({int page = 1});

  Future<Movie> getMovieDetail(String movieId);

  Future<List<Movie>> searchMovies(String query, {int page = 1});

  Future<List<Movie>> getSimilarMovies(String movieId, {int page = 1});

  Future<YoutubeVideo?> getMovieTrailer(String movieId);
}
