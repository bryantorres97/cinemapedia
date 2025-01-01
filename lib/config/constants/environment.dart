import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String tmdbToken = dotenv.get('THE_MOVIEDB_TOKEN', fallback: '');
  static String tmdbApiKey = dotenv.get('THE_MOVIEDB_KEY', fallback: '');
}
