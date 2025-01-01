// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_movies_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchQueryHash() => r'357d70823cc1298961d301b29a4d65c253b5e3c1';

/// See also [SearchQuery].
@ProviderFor(SearchQuery)
final searchQueryProvider = NotifierProvider<SearchQuery, String>.internal(
  SearchQuery.new,
  name: r'searchQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$searchQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchQuery = Notifier<String>;
String _$searchedMoviesHash() => r'64a28bff143cc0b6f4017d4b1fa9116b712a0e13';

/// See also [SearchedMovies].
@ProviderFor(SearchedMovies)
final searchedMoviesProvider =
    NotifierProvider<SearchedMovies, List<Movie>>.internal(
  SearchedMovies.new,
  name: r'searchedMoviesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchedMoviesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchedMovies = Notifier<List<Movie>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
