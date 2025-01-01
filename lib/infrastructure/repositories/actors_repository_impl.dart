import 'package:cinemapedia_app/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/domain/repositories/actors_repository.dart';

class ActorsRepositoryImpl implements ActorsRepository {
  final ActorsDataSource _actorsDataSource;

  ActorsRepositoryImpl(this._actorsDataSource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return _actorsDataSource.getActorsByMovie(movieId);
  }
}
