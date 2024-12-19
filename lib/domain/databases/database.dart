import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class MovieDb extends Table {
  IntColumn get driftId => integer().autoIncrement()(); // ID como primary key
  BoolColumn get adult => boolean().withDefault(const Constant(false))();
  TextColumn get backdropPath => text().nullable()();
  TextColumn get genreIds =>
      text().map(const ListConverter()).nullable()(); // Map para listas
  IntColumn get id => integer()();
  TextColumn get originalLanguage => text()();
  TextColumn get originalTitle => text()();
  TextColumn get overview => text().nullable()();
  RealColumn get popularity => real().withDefault(const Constant(0.0))();
  TextColumn get posterPath => text().nullable()();
  DateTimeColumn get releaseDate => dateTime().nullable()();
  TextColumn get title => text()();
  BoolColumn get video => boolean().withDefault(const Constant(false))();
  RealColumn get voteAverage => real().withDefault(const Constant(0.0))();
  IntColumn get voteCount => integer().withDefault(const Constant(0))();
}

class ListConverter extends TypeConverter<List<String>, String> {
  const ListConverter();

  @override
  List<String> fromSql(String fromDb) {
    return fromDb.split(','); // Convierte cadena a lista
  }

  @override
  String toSql(List<String> value) {
    return value.join(','); // Convierte lista a cadena
  }
}

@DriftDatabase(tables: [MovieDb])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    // `driftDatabase` from `package:drift_flutter` stores the database in
    // `getApplicationDocumentsDirectory()`.
    return driftDatabase(name: 'cinemapedia');
  }

  Future<List<MovieDbData>> getAllMovies(int limit, {int offset = 0}) {
    return (select(movieDb)..limit(limit, offset: offset)).get();
  }

  Stream<List<MovieDbData>> watchAllMovies() {
    return select(movieDb).watch();
  }

  Future<MovieDbData?> getMovieById(int id) {
    return (select(movieDb)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> insertMovie(Movie movie) {
    final movieData = MovieDbCompanion.insert(
      adult: Value(movie.adult),
      backdropPath: Value(movie.backdropPath),
      genreIds: Value(movie.genreIds),
      id: movie.id,
      originalLanguage: movie.originalLanguage,
      originalTitle: movie.originalTitle,
      overview: Value(movie.overview),
      popularity: Value(movie.popularity),
      posterPath: Value(movie.posterPath),
      releaseDate: Value(movie.releaseDate),
      title: movie.title,
      video: Value(movie.video),
      voteAverage: Value(movie.voteAverage),
      voteCount: Value(movie.voteCount),
    );
    return into(movieDb).insert(movieData);
  }

  Future updateMovie(MovieDbData movie) {
    return update(movieDb).replace(movie);
  }

  Future deleteMovie(int movieId) {
    return (delete(movieDb)..where((tbl) => tbl.id.equals(movieId))).go();
  }

  Future deleteAllMovies() {
    return delete(movieDb).go();
  }

  Future<int> countMovies() async {
    final countExp = movieDb.id.count();
    final query = selectOnly(movieDb)..addColumns([countExp]);

    final result = await query.getSingle();
    return result.read(countExp) ?? 0;
  }
}
