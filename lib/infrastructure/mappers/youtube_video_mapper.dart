import 'package:cinemapedia_app/domain/entities/youtube_video.dart';
import 'package:cinemapedia_app/infrastructure/models/tmdb/tmdb_movie_videos_response.dart';

class YoutubeVideoMapper {
  static YoutubeVideo tmdbVideoToEntity(TmdbVideo video) {
    return YoutubeVideo(
      id: video.id,
      key: video.key,
      name: video.name,
      type: video.type,
    );
  }
}
