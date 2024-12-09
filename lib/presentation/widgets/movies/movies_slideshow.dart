import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia_app/domain/domain.dart';
import 'package:flutter/material.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideshow({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 210,
      width: double.infinity,
      child: Swiper(
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 5),
            builder: DotSwiperPaginationBuilder(
              activeColor: themeColors.primary,
              color: themeColors.secondary.withOpacity(0.5),
            )),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          offset: Offset(0, 5),
          blurRadius: 10,
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              FadeInImage(
                placeholder: const AssetImage('assets/images/jar-loading.gif'),
                image: NetworkImage(movie.backdropPath),
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}