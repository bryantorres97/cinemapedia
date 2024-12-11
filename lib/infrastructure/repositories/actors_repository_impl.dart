import 'package:cinemapedia_app/domain/domain.dart';

class ActorsRepositoryImpl implements ActorsRepository {
  final ActorsDataSource _actorsDataSource;

  ActorsRepositoryImpl(this._actorsDataSource);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return _actorsDataSource.getActorsByMovie(movieId);
  }
}
