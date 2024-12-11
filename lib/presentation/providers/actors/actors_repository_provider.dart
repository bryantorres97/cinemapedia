import 'package:cinemapedia_app/infrastructure/datasources/tmdb_actors_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/actors_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_repository_provider.g.dart';

@riverpod
ActorsRepositoryImpl actorsRepository(Ref ref) {
  return ActorsRepositoryImpl(TmdbActorsDataSource());
}
