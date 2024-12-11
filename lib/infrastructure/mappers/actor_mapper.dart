import 'package:cinemapedia_app/domain/domain.dart';
import 'package:cinemapedia_app/infrastructure/models/models.dart';

class ActorMapper {
  static Actor tmdbCastToEntity(Cast tmdbCast) => Actor(
        id: tmdbCast.id,
        name: tmdbCast.name,
        character: tmdbCast.character,
        profilePath: tmdbCast.profilePath != null
            ? 'https://image.tmdb.org/t/p/w500${tmdbCast.profilePath}'
            : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      );
}
