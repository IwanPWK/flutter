import 'package:drift/drift.dart';
import '../database.dart';
import '../../models/book_models.dart';

part 'book_author_dao.g.dart';

@DriftAccessor(tables: [BookAuthors])
class BookAuthorDao extends DatabaseAccessor<AppDatabase> with _$BookAuthorDaoMixin {
  BookAuthorDao(AppDatabase db) : super(db);

  Future<List<BookAuthorModel>> getAllBookAuthors() async {
    final bookAuthorsList = await select(bookAuthors).get(); // renamed
    return bookAuthorsList.map((ba) => BookAuthorModel(
      id: ba.id,
      bookId: ba.bookId,
      authorId: ba.authorId,
      createdAt: ba.createdAt,
    )).toList();
  }

  Future<List<BookAuthorModel>> getBookAuthorsByBookId(int bookId) async {
    final bookAuthorsList = await (select(bookAuthors)
        ..where((ba) => ba.bookId.equals(bookId))).get();
    return bookAuthorsList.map((ba) => BookAuthorModel(
      id: ba.id,
      bookId: ba.bookId,
      authorId: ba.authorId,
      createdAt: ba.createdAt,
    )).toList();
  }

  Future<List<BookAuthorModel>> getBookAuthorsByAuthorId(int authorId) async {
    final bookAuthorsList = await (select(bookAuthors)
        ..where((ba) => ba.authorId.equals(authorId))).get();
    return bookAuthorsList.map((ba) => BookAuthorModel(
      id: ba.id,
      bookId: ba.bookId,
      authorId: ba.authorId,
      createdAt: ba.createdAt,
    )).toList();
  }

  Future<BookAuthorModel> createBookAuthor(BookAuthorModel bookAuthor) async {
    final id = await into(bookAuthors).insert(BookAuthorsCompanion(
      bookId: Value(bookAuthor.bookId),
      authorId: Value(bookAuthor.authorId),
    ));
    
    return bookAuthor.copyWith(id: id);
  }

  Future<int> deleteBookAuthor(int id) async {
    return await (delete(bookAuthors)..where((ba) => ba.id.equals(id))).go();
  }

  Future<int> deleteBookAuthorsByBookId(int bookId) async {
    return await (delete(bookAuthors)..where((ba) => ba.bookId.equals(bookId))).go();
  }

  Future<int> deleteBookAuthorsByAuthorId(int authorId) async {
    return await (delete(bookAuthors)..where((ba) => ba.authorId.equals(authorId))).go();
  }
}
