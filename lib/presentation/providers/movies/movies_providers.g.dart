// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$moviesNotifierHash() => r'892aafdb266f706d7c14a8c76718e2153dea96a2';

/// See also [MoviesNotifier].
@ProviderFor(MoviesNotifier)
final moviesNotifierProvider =
    AutoDisposeNotifierProvider<MoviesNotifier, List<Movie>>.internal(
  MoviesNotifier.new,
  name: r'moviesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$moviesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MoviesNotifier = AutoDisposeNotifier<List<Movie>>;
String _$popularMoviesNotifierHash() =>
    r'bb9b5004e32b29519d04c4ec910b825f28ea8327';

/// See also [PopularMoviesNotifier].
@ProviderFor(PopularMoviesNotifier)
final popularMoviesNotifierProvider =
    AutoDisposeNotifierProvider<PopularMoviesNotifier, List<Movie>>.internal(
  PopularMoviesNotifier.new,
  name: r'popularMoviesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$popularMoviesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PopularMoviesNotifier = AutoDisposeNotifier<List<Movie>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
