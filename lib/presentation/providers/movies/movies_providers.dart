import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movies_providers.g.dart';

typedef MovieCallback = Future<List<Movie>> Function({int page});

@riverpod
class MoviesNotifier extends _$MoviesNotifier {
  int currentPage = 0;
  late MovieCallback fetchMoreMovies;

  @override
  List<Movie> build() {
    fetchMoreMovies = ref.watch(moviesRepositoryProvider).getNowPlayingMovies;
    return [];
  }

  Future<void> loadNextPage() async {
    currentPage++;
    final List<Movie> newMovies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...newMovies];
  }
}
