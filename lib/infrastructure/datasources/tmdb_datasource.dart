import 'package:cinemapedia_app/config/config.dart';
import 'package:cinemapedia_app/domain/domain.dart';
import 'package:cinemapedia_app/infrastructure/infrastructure.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final logger = Logger(printer: PrettyPrinter());

class TmdbDataSource implements MoviesDataSource {
  final _dio =
      Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3', headers: {
    'Authorization': 'Bearer ${Environment.tmdbToken}',
  }, queryParameters: {
    'language': 'es-MX',
  }));

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final response = await _dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });

    final moviesResponse = TmdbResponse.fromJson(response.data);

    final List<Movie> movies = moviesResponse.results
        .where((movie) => movie.posterPath != 'no-poster')
        .map((movie) => MovieMapper.tmdbMovieToEntity(movie))
        .toList();

    return movies;
  }
}
