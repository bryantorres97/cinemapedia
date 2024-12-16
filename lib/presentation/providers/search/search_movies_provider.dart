import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_movies_provider.g.dart';

@Riverpod(keepAlive: true)
class SearchQuery extends _$SearchQuery {
  @override
  String build() {
    return '';
  }

  update(String query) {
    state = query;
  }
}
