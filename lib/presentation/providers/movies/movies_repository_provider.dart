import 'package:cinemapedia_app/infrastructure/infrastructure.dart';
import 'package:cinemapedia_app/infrastructure/repositories/repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movies_repository_provider.g.dart';

@riverpod
MoviesRepositoryImpl moviesRepository(Ref ref) {
  return MoviesRepositoryImpl(TmdbMoviesDataSource());
}
