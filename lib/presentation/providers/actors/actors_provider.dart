import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'actors_provider.g.dart';

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

@Riverpod(keepAlive: true)
class Actors extends _$Actors {
  late GetActorsCallback _getActors;

  @override
  Map<String, List<Actor>> build() {
    _getActors = ref.read(actorsRepositoryProvider).getActorsByMovie;
    return {};
  }

  Future<void> loadActors(String movieId) async {
    if (state.containsKey(movieId)) return;
    final actors = await _getActors(movieId);
    state = {...state, movieId: actors};
  }
}
