import 'package:cinemapedia_app/presentation/providers/movies/favorite_movies_provider.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    _loadNextPage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies = await ref
        .read(favoriteMoviesProvider.notifier)
        .loadFavoriteMovies(limit: 12);
    await Future.delayed(const Duration(milliseconds: 1500));
    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final favorites = ref.watch(favoriteMoviesProvider);

    return Center(
        child: Scaffold(
      body: MovieMasonry(loadNextPage: _loadNextPage, movies: favorites),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
