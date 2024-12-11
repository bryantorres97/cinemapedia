import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/models/models.dart';

const String notFoundImage =
    'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg';

class MovieMapper {
  static Movie tmdbMovieToEntity(TmdbMovie tmdbMovie) => Movie(
      adult: tmdbMovie.adult,
      backdropPath: tmdbMovie.backdropPath != ''
          ? 'https://image.tmdb.org/t/p/w500${tmdbMovie.backdropPath}'
          : notFoundImage,
      genreIds: tmdbMovie.genreIds.map((e) => e.toString()).toList(),
      id: tmdbMovie.id,
      originalLanguage: tmdbMovie.originalLanguage,
      originalTitle: tmdbMovie.originalTitle,
      overview: tmdbMovie.overview,
      popularity: tmdbMovie.popularity,
      posterPath: tmdbMovie.posterPath != ''
          ? 'https://image.tmdb.org/t/p/w500${tmdbMovie.posterPath}'
          : 'no-poster',
      releaseDate: tmdbMovie.releaseDate,
      title: tmdbMovie.title,
      video: tmdbMovie.video,
      voteAverage: tmdbMovie.voteAverage,
      voteCount: tmdbMovie.voteCount);

  static Movie tmdbMovieDetailsToEntity(TmdbMovieDetailsResponse tmdbMovie) =>
      Movie(
          adult: tmdbMovie.adult,
          backdropPath: tmdbMovie.backdropPath != ''
              ? 'https://image.tmdb.org/t/p/w500${tmdbMovie.backdropPath}'
              : notFoundImage,
          genreIds: tmdbMovie.genres.map((e) => e.name).toList(),
          id: tmdbMovie.id,
          originalLanguage: tmdbMovie.originalLanguage,
          originalTitle: tmdbMovie.originalTitle,
          overview: tmdbMovie.overview,
          popularity: tmdbMovie.popularity,
          posterPath: tmdbMovie.posterPath != ''
              ? 'https://image.tmdb.org/t/p/w500${tmdbMovie.posterPath}'
              : notFoundImage,
          releaseDate: tmdbMovie.releaseDate,
          title: tmdbMovie.title,
          video: tmdbMovie.video,
          voteAverage: tmdbMovie.voteAverage,
          voteCount: tmdbMovie.voteCount);
}
