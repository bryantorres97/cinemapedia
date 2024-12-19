import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'movies_providers.g.dart';

typedef MovieCallback = Future<List<Movie>> Function({int page});

final logger = Logger(
  printer: PrettyPrinter(),
);

@riverpod
class NowPlayingMoviesNotifier extends _$NowPlayingMoviesNotifier {
  bool isLoading = false;
  int currentPage = 0;
  late MovieCallback fetchMoreMovies;

  @override
  List<Movie> build() {
    fetchMoreMovies = ref.watch(moviesRepositoryProvider).getNowPlayingMovies;
    return [];
  }

  Future<void> loadNextPage() async {
    if (isLoading) return;
    logger.d('Loading next page');
    isLoading = true;
    currentPage++;
    final List<Movie> newMovies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...newMovies];
    await Future.delayed(const Duration(milliseconds: 1500));
    isLoading = false;
  }
}

@riverpod
class PopularMoviesNotifier extends _$PopularMoviesNotifier {
  bool isLoading = false;
  int currentPage = 0;
  late MovieCallback fetchMoreMovies;

  @override
  List<Movie> build() {
    fetchMoreMovies = ref.watch(moviesRepositoryProvider).getPopularMovies;
    return [];
  }

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final List<Movie> newMovies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...newMovies];
    await Future.delayed(const Duration(milliseconds: 1500));
    isLoading = false;
  }
}

@riverpod
class TopRatedMoviesNotifier extends _$TopRatedMoviesNotifier {
  bool isLoading = false;
  int currentPage = 0;
  late MovieCallback fetchMoreMovies;

  @override
  List<Movie> build() {
    fetchMoreMovies = ref.watch(moviesRepositoryProvider).getTopRatedMovies;
    return [];
  }

  Future<void> loadNextPage() async {
    if (isLoading) return;
    logger.d('Loading next page');
    isLoading = true;
    currentPage++;
    final List<Movie> newMovies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...newMovies];
    await Future.delayed(const Duration(milliseconds: 1500));
    isLoading = false;
  }
}

@riverpod
class UpcomingMoviesNotifier extends _$UpcomingMoviesNotifier {
  bool isLoading = false;
  int currentPage = 0;
  late MovieCallback fetchMoreMovies;

  @override
  List<Movie> build() {
    fetchMoreMovies = ref.watch(moviesRepositoryProvider).getUpcomingMovies;
    return [];
  }

  Future<void> loadNextPage() async {
    if (isLoading) return;
    logger.d('Loading next page');
    isLoading = true;
    currentPage++;
    final List<Movie> newMovies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...newMovies];
    await Future.delayed(const Duration(milliseconds: 1500));
    isLoading = false;
  }
}
