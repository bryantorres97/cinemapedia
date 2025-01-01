import 'package:cinemapedia_app/config/config.dart';
import 'package:cinemapedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/entities/youtube_video.dart';
import 'package:cinemapedia_app/infrastructure/mappers/mappers.dart';
import 'package:cinemapedia_app/infrastructure/models/models.dart';
import 'package:cinemapedia_app/infrastructure/models/tmdb/tmdb_movie_videos_response.dart';
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

  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    if (query.isEmpty) return [];

    final response = await _dio.get('/search/movie', queryParameters: {
      'query': query,
      'page': page,
    });

    final moviesResponse = TmdbResponse.fromJson(response.data);
    return _jsonToMoviesList(moviesResponse);
  }

  @override
  Future<YoutubeVideo?> getMovieTrailer(String movieId) async {
    final response = await _dio.get('/movie/$movieId/videos');
    final videosResponse = TmdbMovieVideosResponse.fromJson(response.data);
    final hasYoutubeTrailer = videosResponse.results
        .any((video) => video.site == 'YouTube' && video.type == 'Trailer');

    if (!hasYoutubeTrailer) return null;

    final youtubeTrailer = videosResponse.results.firstWhere(
        (video) => video.site == 'YouTube' && video.type == 'Trailer');

    return YoutubeVideo(
      id: youtubeTrailer.id,
      name: youtubeTrailer.name,
      type: youtubeTrailer.type,
      key: youtubeTrailer.key,
    );
  }

  @override
  Future<List<Movie>> getSimilarMovies(String movieId, {int page = 1}) async {
    final response =
        await _dio.get('/movie/$movieId/recommendations', queryParameters: {
      'page': page,
    });

    final moviesResponse = TmdbResponse.fromJson(response.data);
    return _jsonToMoviesList(moviesResponse);
  }
}
