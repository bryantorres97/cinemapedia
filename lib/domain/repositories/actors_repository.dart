import 'package:cinemapedia_app/domain/domain.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
