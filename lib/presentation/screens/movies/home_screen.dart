import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    ref.read(moviesNotifierProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(moviesNotifierProvider);
    final slideshowMovies = ref.watch(moviesSlideshowProvider);
    return Column(
      children: [
        const CustomAppbar(),
        MoviesSlideshow(movies: slideshowMovies),
        MovieHorizontalListview(
          movies: movies,
          title: 'En cines',
          subtitle: 'Lunes, 12',
        )
        // Expanded(
        //     child: ListView.builder(
        //         itemCount: movies.length + 1,
        //         itemBuilder: (context, index) {
        //           if (index >= movies.length) {
        //             ref.read(moviesNotifierProvider.notifier).loadNextPage();
        //             return const Center(child: CircularProgressIndicator());
        //           }

        //           final movie = movies[index];
        //           return ListTile(
        //             title: Text(movie.title),
        //             subtitle: Text(movie.overview),
        //           );
        //         }))
      ],
    );
  }
}
