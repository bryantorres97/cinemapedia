import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(),
);

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
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
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesNotifierProvider);
    final popularMovies = ref.watch(popularMoviesNotifierProvider);
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
                  subtitle: 'Lunes, 12',
                  loadNextPage: () {
                    ref
                        .read(nowPlayingMoviesNotifierProvider.notifier)
                        .loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Próximamente',
                  subtitle: 'Este mes',
                  loadNextPage: () {
                    ref
                        .read(upcomingMoviesNotifierProvider.notifier)
                        .loadNextPage();
                  },
                ),
                MovieHorizontalListview(
                  movies: popularMovies,
                  title: 'Populares',
                  loadNextPage: () {
                    ref
                        .read(popularMoviesNotifierProvider.notifier)
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
}
