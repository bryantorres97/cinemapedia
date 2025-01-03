import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/entities/youtube_video.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final _logger = Logger(
  printer: PrettyPrinter(),
);

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsProvider.notifier).loadActors(widget.movieId);
    ref.read(movieTrailerProvider.notifier).loadMovieTrailer(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }
    _logger.d('Movie: ${movie.toString()}');

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => _MovieDetails(movie: movie),
                  childCount: 1)),
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends ConsumerWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final favoriteMovies = ref.watch(favoriteMoviesProvider);
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return SliverAppBar(
      backgroundColor: Colors.black87,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          iconSize: 30,
          isSelected: favoriteMovies.indexWhere((m) => m.id == movie.id) != -1,
          selectedIcon: const Icon(
            Icons.favorite,
            color: Colors.redAccent,
          ),
          onPressed: () async {
            await ref
                .read(favoriteMoviesProvider.notifier)
                .toggleFavoriteMovie(movie);
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.only(bottom: 0),
        title: _CustomGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.7, 1.0],
            colors: [Colors.transparent, scaffoldBackgroundColor]),
        background: Stack(
          children: [
            SizedBox.expand(
              child: FadeIn(
                  child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              )),
            ),
            const _CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.7, 1.0],
                colors: [Colors.transparent, Colors.black87]),
            const _CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.center,
                stops: [0.0, 0.5],
                colors: [Colors.black87, Colors.transparent]),
          ],
        ),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _MovieDescription(movie: movie),
        _MovieCategories(movie: movie),
        _MovieTrailer(
          movieId: movie.id.toString(),
        ),
        _ActorsByMovie(movieId: movie.id.toString()),
        _SuggestedMovies(
          movie: movie,
        )
      ],
    );
  }
}

class _SuggestedMovies extends StatelessWidget {
  final Movie movie;
  const _SuggestedMovies({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Películas similares', style: TextStyle(fontSize: 20)),
          MovieHorizontalListview(movies: movie.similarMovies ?? []),
        ],
      ),
    );
  }
}

class _MovieTrailer extends ConsumerWidget {
  final String movieId;

  const _MovieTrailer({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final YoutubeVideo? trailer = ref.watch(movieTrailerProvider)[movieId];

    if (trailer == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: YoutubeVideoPlayer(videoKey: trailer.key)),
    );
  }
}

class _MovieDescription extends StatelessWidget {
  const _MovieDescription({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeIn(
              child: Image.network(
                movie.posterPath,
                width: size.width * 0.30,
              ),
            ),
          ),
          const SizedBox(width: 15),
          SizedBox(
            width: (size.width - 60) * 0.70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textStyles.titleLarge,
                ),
                const SizedBox(height: 5),
                Text(
                  movie.overview,
                  textAlign: TextAlign.start,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _MovieCategories extends StatelessWidget {
  const _MovieCategories({
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Wrap(
          children: [
            ...movie.genreIds.map((genre) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(
                    genre,
                    style: TextStyle(color: themeColors.onPrimary),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: themeColors.primary,
                ))),
          ],
        ),
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actors = ref.watch(actorsProvider)[movieId];

    if (actors == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Reparto', style: TextStyle(fontSize: 20)),
          SizedBox(
            height: 320,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: actors.length,
                itemBuilder: (context, index) {
                  final actor = actors[index];

                  return _ActorCard(actor: actor);
                }),
          )
        ],
      ),
    );
  }
}

class _ActorCard extends StatelessWidget {
  const _ActorCard({
    required this.actor,
  });

  final Actor actor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 135,
      child: Column(
        children: [
          FadeInRight(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                actor.profilePath,
                width: 145,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            actor.name,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            actor.character ?? '',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {required this.begin,
      required this.end,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            stops: stops,
            colors: colors,
          ),
        ),
      ),
    );
  }
}
