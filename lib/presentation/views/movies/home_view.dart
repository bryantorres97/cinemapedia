import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia_app/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinemapedia_app/presentation/widgets/shared/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesNotifierProvider.notifier).loadNextPage();
    ref.read(popularMoviesNotifierProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesNotifierProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesNotifierProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesNotifierProvider);
    final topRatedMovies = ref.watch(topRatedMoviesNotifierProvider);
    final upcomingMovies = ref.watch(upcomingMoviesNotifierProvider);
    final slideshowMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              expandedTitleScale: double.infinity,
              title: CustomAppbar()),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: slideshowMovies),
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  loadNextPage: () {
                    ref
                        .read(nowPlayingMoviesNotifierProvider.notifier)
                        .loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Próximamente',
                  loadNextPage: () {
                    ref
                        .read(upcomingMoviesNotifierProvider.notifier)
                        .loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Mejores valoradas',
                  loadNextPage: () {
                    ref
                        .read(topRatedMoviesNotifierProvider.notifier)
                        .loadNextPage();
                  },
                ),
                const SizedBox(height: 30),
              ],
            );
          }, childCount: 1),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
