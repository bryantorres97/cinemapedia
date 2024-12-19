import 'package:cinemapedia_app/domain/domain.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:logger/logger.dart';

final logger = Logger(printer: PrettyPrinter());

class MovieMasonry extends StatefulWidget {
  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  const MovieMasonry({super.key, required this.movies, this.loadNextPage});

  @override
  State<MovieMasonry> createState() => _MovieMasonryState();
}

class _MovieMasonryState extends State<MovieMasonry> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      final currentPixels = scrollController.position.pixels;
      final maxScrollExtent = scrollController.position.maxScrollExtent;

      if (currentPixels - 100 <= maxScrollExtent) {
        logger.d("Cargando siguiente página");
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return widget.movies.isNotEmpty
        ? _MasonryContainer(scrollController: scrollController, widget: widget)
        : _EmptyFavorites(themeColors: themeColors, textStyle: textStyle);
  }
}

class _MasonryContainer extends StatelessWidget {
  const _MasonryContainer({
    required this.scrollController,
    required this.widget,
  });

  final ScrollController scrollController;
  final MovieMasonry widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MasonryGridView.count(
          controller: scrollController,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          itemCount: widget.movies.length,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 3,
          itemBuilder: (context, index) {
            if (index == 1) {
              return Column(
                children: [
                  const SizedBox(height: 30),
                  MoviePosterLink(movie: widget.movies[index]),
                ],
              );
            }
            return MoviePosterLink(movie: widget.movies[index]);
          }),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites({
    required this.themeColors,
    required this.textStyle,
  });

  final ColorScheme themeColors;
  final TextTheme textStyle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star_border_outlined,
              size: 200, color: themeColors.primary),
          const SizedBox(height: 20),
          Text('No tienes favoritos',
              style:
                  textStyle.titleLarge?.copyWith(color: themeColors.primary)),
        ],
      ),
    );
  }
}
