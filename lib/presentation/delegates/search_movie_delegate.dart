import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/config/helpers/helpers.dart';
import 'package:cinemapedia_app/domain/domain.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;
  Timer? _debounceTimer;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();

  SearchMovieDelegate({required this.searchMovies});

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      final term = query.trim();
      if (term.isEmpty) {
        debounceMovies.add([]);
        return;
      }

      searchMovies(term).then((movies) {
        debounceMovies.add(movies);
      });
    });
  }

  void clearStreams() {
    debounceMovies.close();
  }

  @override
  String? get searchFieldLabel => 'Buscar películas';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        FadeIn(
            animate: query.isNotEmpty,
            duration: const Duration(milliseconds: 300),
            child: IconButton(
                onPressed: () {
                  query = '';
                },
                icon: const Icon(Icons.clear_rounded)))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          clearStreams();
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return StreamBuilder(
        stream: debounceMovies.stream,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];
          if (query.isEmpty) {
            return const Center(
              child: Text('Busca una película'),
            );
          }

          if (movies.isEmpty &&
              snapshot.connectionState == ConnectionState.done) {
            return const Center(
              child: Text('No se encontraron resultados'),
            );
          }

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) => _MovieItem(
                  movie: movies[index],
                  onMovieSelected: (context, movie) {
                    clearStreams();
                    close(context, movie);
                  }));
        });
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            SizedBox(
              width: size.width * 0.25,
              height: size.height * 0.15,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 10),

            // Title
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textTheme.titleMedium?.copyWith(
                      color: themeColors.primary,
                    ),
                  ),
                  (movie.overview.isEmpty)
                      ? const Text('No hay descripción')
                      : (movie.overview.length > 100)
                          ? Text(
                              '${movie.overview.substring(0, 100)}...',
                            )
                          : Text(
                              movie.overview,
                            ),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded,
                          color: Colors.yellow.shade800),
                      const SizedBox(width: 5),
                      Text(
                        HumanFormats.formatNumber(movie.voteAverage, 1),
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.yellow.shade900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
