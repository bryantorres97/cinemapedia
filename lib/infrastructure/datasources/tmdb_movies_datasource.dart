import 'package:cinemapedia_app/config/config.dart';
import 'package:cinemapedia_app/domain/domain.dart';
import 'package:cinemapedia_app/infrastructure/mappers/mappers.dart';
import 'package:cinemapedia_app/infrastructure/models/models.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

final logger = Logger(printer: PrettyPrinter());

class TmdbMoviesDataSource implements MoviesDataSource {
  final _dio =
      Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3', headers: {
    'Authorization': 'Bearer ${Environment.tmdbToken}',
  }, queryParameters: {
    'language': 'es-MX',
  }));

  List<Movie> _jsonToMoviesList(TmdbResponse moviesResponse) {
    final List<Movie> movies = moviesResponse.results
        .where((movie) => movie.posterPath != 'no-poster')
        .map((movie) => MovieMapper.tmdbMovieToEntity(movie))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    final response = await _dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });

    final moviesResponse = TmdbResponse.fromJson(response.data);
    return _jsonToMoviesList(moviesResponse);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final response = await _dio.get('/movie/popular', queryParameters: {
      'page': page,
    });

    final moviesResponse = TmdbResponse.fromJson(response.data);
    return _jsonToMoviesList(moviesResponse);
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    final response = await _dio.get('/movie/top_rated', queryParameters: {
      'page': page,
    });

    final moviesResponse = TmdbResponse.fromJson(response.data);
    return _jsonToMoviesList(moviesResponse);
  }

  @override
  Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
    final response = await _dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });

    final moviesResponse = TmdbResponse.fromJson(response.data);

    return _jsonToMoviesList(moviesResponse);
  }

  @override
  Future<Movie> getMovieDetail(String movieId) async {
    final response = await _dio.get('/movie/$movieId');

    if (response.statusCode != 200) {
      throw Exception('No se pudo obtener la información de la película');
    }

    final movie = TmdbMovieDetailsResponse.fromJson(response.data);

    return MovieMapper.tmdbMovieDetailsToEntity(movie);
  }
}
