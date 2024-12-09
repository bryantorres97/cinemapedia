import 'package:cinemapedia_app/config/helpers/helpers.dart';
import 'package:cinemapedia_app/domain/domain.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatelessWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview(
      {super.key,
      required this.movies,
      this.title,
      this.subtitle,
      this.loadNextPage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (title != null || subtitle != null)
            _Titles(
              title: title,
              subtitle: subtitle,
            ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return _MovieSlide(movie: movie);
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Titles extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const _Titles({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          color: themeColors.primary,
        );

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              onPressed: () {},
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              child: Text(
                subtitle!,
                style: TextStyle(color: themeColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}

class _MovieSlide extends StatelessWidget {
  final Movie movie;

  const _MovieSlide({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PosterImage(movie: movie),
          const SizedBox(
            height: 5,
          ),
          _MovieTitle(movie: movie),
          const SizedBox(
            height: 5,
          ),
          _RatingSection(movie: movie)
        ],
      ),
    );
  }
}

class _MovieTitle extends StatelessWidget {
  const _MovieTitle({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return SizedBox(
      width: 150,
      height: 35,
      child: Text(
        movie.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: textStyles.bodyMedium,
      ),
    );
  }
}

class _RatingSection extends StatelessWidget {
  const _RatingSection({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Icon(
            Icons.star_half,
            size: 16,
            color: Colors.yellow.shade800,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '${movie.voteAverage}',
            style: textStyles.bodyMedium?.copyWith(
              color: Colors.yellow.shade800,
            ),
          ),
          const Spacer(),
          Text(
            HumanFormats.formatNumber(movie.popularity),
            style: textStyles.bodySmall?.copyWith(
              color: themeColors.secondary,
            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 5)),
        ],
      ),
    );
  }
}

class _PosterImage extends StatelessWidget {
  const _PosterImage({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          placeholder: const AssetImage('assets/images/jar-loading.gif'),
          image: NetworkImage(movie.posterPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
