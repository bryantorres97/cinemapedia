import 'package:cinemapedia_app/infrastructure/datasources/drift_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_storage_repository_provider.g.dart';

@riverpod
LocalStorageRepositoryImpl localStorageRepository(Ref ref) {
  return LocalStorageRepositoryImpl(DriftDatasource());
}
