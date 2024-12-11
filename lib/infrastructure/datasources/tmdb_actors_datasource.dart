import 'package:cinemapedia_app/config/config.dart';
import 'package:cinemapedia_app/domain/domain.dart';
import 'package:cinemapedia_app/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/models.dart';
import 'package:dio/dio.dart';

class TmdbActorsDatasource implements ActorsDataSource {
  final _dio =
      Dio(BaseOptions(baseUrl: 'https://api.themoviedb.org/3', headers: {
    'Authorization': 'Bearer ${Environment.tmdbToken}',
  }, queryParameters: {
    'language': 'es-MX',
  }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await _dio.get('/movie/$movieId/credits');

    final creditsResponse = TmdbCreditsResponse.fromJson(response.data);

    final List<Actor> actors = creditsResponse.cast
        .map((actor) => ActorMapper.tmdbCastToEntity(actor))
        .toList();

    return actors;
  }
}
