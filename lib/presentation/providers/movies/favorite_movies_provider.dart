import 'package:cinemapedia_app/domain/domain.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_movies_provider.g.dart';

typedef FavoriteMovieCallback = Future<List<Movie>> Function(
    {int limit, int offset});

@Riverpod(keepAlive: true)
class FavoriteMovies extends _$FavoriteMovies {
  late FavoriteMovieCallback fetchFavoriteMovies;
  int _page = 0;

  @override
  List<Movie> build() {
    fetchFavoriteMovies =
        ref.watch(localStorageRepositoryProvider).getFavoriteMovies;
    return [];
  }

  Future<void> loadFavoriteMovies({int limit = 10}) async {
    final List<Movie> newMovies =
        await fetchFavoriteMovies(limit: limit, offset: _page * limit);
    state = [...state, ...newMovies];
    _page++;
  }

  Future<void> toggleFavoriteMovie(Movie movie) async {
    await ref.watch(localStorageRepositoryProvider).toggleFavoriteMovie(movie);
    final existsMovie = await ref
        .watch(localStorageRepositoryProvider)
        .isFavoriteMovie(movie.id);

    if (existsMovie) {
      state = [...state, movie];
      return;
    }

    state = state.where((element) => element.id != movie.id).toList();
  }

  Future<bool> isFavoriteMovie(int movieId) async {
    return await ref
        .watch(localStorageRepositoryProvider)
        .isFavoriteMovie(movieId);
  }
}
