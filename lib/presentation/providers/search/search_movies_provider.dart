import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_movies_provider.g.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

@Riverpod(keepAlive: true)
class SearchQuery extends _$SearchQuery {
  @override
  String build() {
    return '';
  }

  update(String query) {
    state = query;
  }
}

@Riverpod(keepAlive: true)
class SearchedMovies extends _$SearchedMovies {
  late SearchMoviesCallback _searchMovies;
  @override
  List<Movie> build() {
    _searchMovies = ref.watch(moviesRepositoryProvider).searchMovies;
    return [];
  }

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> newMovies = await _searchMovies(query);
    state = newMovies;
    return newMovies;
  }
}
