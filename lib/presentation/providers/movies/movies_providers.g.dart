// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$moviesNotifierHash() => r'c14b76c9324b7c06c40152814409d559a8e705c0';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package