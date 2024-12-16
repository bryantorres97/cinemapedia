import 'package:cinemapedia_app/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          color: themeColors.primary,
        );
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
                      showSearch(
                          context: context,
                          delegate: SearchMovieDelegate(
                              searchMovies: ref
                                  .read(moviesRepositoryProvider)
                                  .searchMovies));
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
