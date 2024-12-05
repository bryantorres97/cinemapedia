import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String tmdbToken = dotenv.get('THE_MOVIEDB_TOKEN', fallback: '');
}
