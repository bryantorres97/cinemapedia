import 'package:cinemapedia_app/domain/domain.dart';
import 'package:cinemapedia_app/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: themeColors.primary,
        );
    final searchQuery = ref.watch(searchQueryProvider);
    final searchedMovies = ref.watch(searchedMoviesProvider);
    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.local_movies_outlined,
                  color: themeColors.primary,
                ),
                const SizedBox(width: 10),
                Text(
                  'Cinemapedia',
                  style: titleStyle,
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      showSearch<Movie?>(
                              query: searchQuery,
                              context: context,
                              delegate: SearchMovieDelegate(
                                  searchMovies: (query) {
                                    ref
                                        .read(searchQueryProvider.notifier)
                                        .update(query);
                                    return ref
                                        .read(searchedMoviesProvider.notifier)
                                        .searchMoviesByQuery(query);
                                  },
                                  initialMovies: searchedMovies))
                          .then((movie) {
                        if (movie == null || !context.mounted) return;
                        context.push('/home/0/movie/${movie.id}');
                      });
                    },
                    icon: Icon(
                      Icons.search,
                      color: themeColors.primary,
                    )),
              ],
            ),
          ),
        ));
  }
}
