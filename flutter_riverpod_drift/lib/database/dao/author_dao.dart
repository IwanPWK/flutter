import 'package:drift/drift.dart';
import '../database.dart';
import '../../models/book_models.dart';

part 'author_dao.g.dart';

@DriftAccessor(tables: [Authors])
class AuthorDao extends DatabaseAccessor<AppDatabase> with _$AuthorDaoMixin {
  AuthorDao(AppDatabase db) : super(db);

  Future<List<AuthorModel>> getAllAuthors() async {
    final authorsList = await select(authors).get(); // renamed from authors to authorsList
    return authorsList.map((author) => AuthorModel(
      id: author.id,
      name: author.name,
      email: author.email,
      createdAt: author.createdAt,
    )).toList();
  }

  Future<AuthorModel?> getAuthorById(int id) async {
    final author = await (select(authors)..where((a) => a.id.equals(id))).getSingleOrNull();
    if (author == null) return null;
    
    return AuthorModel(
      id: author.id,
      name: author.name,
      email: author.email,
      createdAt: author.createdAt,
    );
  }

  Future<AuthorModel> createAuthor(AuthorModel author) async {
    final id = await into(authors).insert(AuthorsCompanion(
      name: Value(author.name),
      email: Value(author.email),
    ));
    
    return author.copyWith(id: id);
  }

  Future<bool> updateAuthor(AuthorModel author) async {
    final result = await (update(authors)..where((a) => a.id.equals(author.id!)))
        .write(AuthorsCompanion(
          name: Value(author.name),
          email: Value(author.email),
        ));
    return result > 0; // Convert int to bool
  }

  Future<int> deleteAuthor(int id) async {
    return await (delete(authors)..where((a) => a.id.equals(id))).go();
  }
}
