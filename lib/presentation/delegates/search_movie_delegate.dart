import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/config/helpers/helpers.dart';
import 'package:cinemapedia_app/domain/domain.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {
  final SearchMoviesCallback searchMovies;

  List<Movie> initialMovies = [];
  Timer? _debounceTimer;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  StreamController<bool> isLoading = StreamController.broadcast();

  SearchMovieDelegate(
      {required this.searchMovies, required this.initialMovies});

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }
    isLoading.add(true);

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      final term = query.trim();
      searchMovies(term).then((movies) {
        initialMovies = movies;
        isLoading.add(false);
        debounceMovies.add(movies);
      });
    });
  }

  void clearStreams() {
    debounceMovies.close();
    isLoading.close();
  }

  @override
  String? get searchFieldLabel => 'Buscar películas';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      StreamBuilder(
          initialData: false,
          stream: isLoading.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data == true) {
              return SpinPerfect(
                  infinite: true,
                  spins: 10,
                  duration: const Duration(seconds: 1),
                  child: IconButton(
                      onPressed: () {
                        query = '';
                      },
                      icon: const Icon(Icons.refresh_rounded)));
            }

            return FadeIn(
                animate: query.isNotEmpty,
                duration: const Duration(milliseconds: 300),
                child: IconButton(
                    onPressed: () {
                      query = '';
                    },
                    icon: const Icon(Icons.clear_rounded)));
          }),
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
    return buildResultsAndSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildResultsAndSuggestions(context);
  }

  StreamBuilder<List<Movie>> buildResultsAndSuggestions(BuildContext context) {
    return StreamBuilder(
        initialData: initialMovies,
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
