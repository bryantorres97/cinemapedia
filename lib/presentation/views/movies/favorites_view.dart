import 'package:cinemapedia_app/presentation/providers/movies/favorite_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadFavoriteMovies();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoriteMoviesProvider);

    return Center(
        child: Scaffold(
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final movie = favorites[index];
          return ListTile(
            title: Text('Movie ${index + 1} ${movie.title}'),
            subtitle: Text(
              movie.overview,
              maxLines: 3,
            ),
          );
        },
      ),
    ));
  }
}
