import 'package:cinemapedia_app/domain/entities/youtube_video.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_trailer_provider.g.dart';

typedef GetMovieTrailerCallback = Future<YoutubeVideo?> Function(
    String movieId);

@Riverpod(keepAlive: true)
class MovieTrailer extends _$MovieTrailer {
  late GetMovieTrailerCallback _getMovieTrailer;

  @override
  Map<String, YoutubeVideo?> build() {
    _getMovieTrailer = ref.read(moviesRepositoryProvider).getMovieTrailer;
    return {};
  }

  Future<void> loadMovieTrailer(String movieId) async {
    if (state.containsKey(movieId)) return;
    final trailer = await _getMovieTrailer(movieId);
    state = {...state, movieId: trailer};
  }
}
