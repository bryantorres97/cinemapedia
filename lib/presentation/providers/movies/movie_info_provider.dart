import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'movie_info_provider.g.dart';

typedef GetMovieCallback = Future<Movie> Function(String movieId);

Logger _logger = Logger(
  printer: PrettyPrinter(),
);

@Riverpod(keepAlive: true)
class MovieInfo extends _$MovieInfo {
  late GetMovieCallback _getMovie;

  @override
  Map<String, Movie> build() {
    _getMovie = ref.read(moviesRepositoryProvider).getMovieDetail;
    return {};
  }

  Future<void> loadMovie(String movieId) async {
    if (state.containsKey(movieId)) return;
    _logger.i('Loading movie $movieId');
    final movie = await _getMovie(movieId);
    movie.similarMovies =
        await ref.read(moviesRepositoryProvider).getSimilarMovies(movieId);
    state = {...state, movieId: movie};
  }
}
