import 'package:cinemapedia_app/presentation/providers/movies/movies_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'initial_loading_provider.g.dart';

@riverpod
bool initialLoading(Ref ref) {
  final step1 = ref.watch(nowPlayingMoviesNotifierProvider).isEmpty;
  final step2 = ref.watch(popularMoviesNotifierProvider).isEmpty;
  final step3 = ref.watch(topRatedMoviesNotifierProvider).isEmpty;
  final step4 = ref.watch(upcomingMoviesNotifierProvider).isEmpty;

  if (step1 || step2 || step3 || step4) return true;

  return false;
}
