import 'package:drift/drift.dart';
import '../database.dart';
import '../../models/book_models.dart';

part 'book_dao.g.dart';

@DriftAccessor(tables: [Books, Categories, Authors, BookAuthors])
class BookDao extends DatabaseAccessor<AppDatabase> with _$BookDaoMixin {
  BookDao(AppDatabase db) : super(db);

  Future<List<BookModel>> getAllBooks() async {
    final query = select(books).join([
      leftOuterJoin(categories, categories.id.equalsExp(books.categoryId)),
    ]);

    final results = await query.get();
    
    List<BookModel> bookModels = [];
    
    for (final result in results) {
      final book = result.readTable(books);
      final category = result.readTableOrNull(categories);
      
      // Get authors for this book
      final bookAuthorsQuery = select(bookAuthors).join([
        innerJoin(authors, authors.id.equalsExp(bookAuthors.authorId)),
      ])..where(bookAuthors.bookId.equals(book.id));
      
      final authorResults = await bookAuthorsQuery.get();
      final bookAuthorsList = authorResults.map((ar) {
        final author = ar.readTable(authors);
        return AuthorModel(
          id: author.id,
          name: author.name,
          email: author.email,
          createdAt: author.createdAt,
        );
      }).toList();

      bookModels.add(BookModel(
        id: book.id,
        title: book.title,
        isbn: book.isbn,
        categoryId: book.categoryId,
        publishedYear: book.publishedYear,
        createdAt: book.createdAt,
        category: category != null ? CategoryModel(
          id: category.id,
          name: category.name,
          description: category.description,
          createdAt: category.createdAt,
        ) : null,
        authors: bookAuthorsList,
      ));
    }
    
    return bookModels;
  }

  Future<BookModel?> getBookById(int id) async {
    final query = select(books).join([
      leftOuterJoin(categories, categories.id.equalsExp(books.categoryId)),
    ])..where(books.id.equals(id));

    final result = await query.getSingleOrNull();
    if (result == null) return null;

    final book = result.readTable(books);
    final category = result.readTableOrNull(categories);
    
    // Get authors for this book
    final bookAuthorsQuery = select(bookAuthors).join([
      innerJoin(authors, authors.id.equalsExp(bookAuthors.authorId)),
    ])..where(bookAuthors.bookId.equals(book.id));
    
    final authorResults = await bookAuthorsQuery.get();
    final bookAuthorsList = authorResults.map((ar) {
      final author = ar.readTable(authors);
      return AuthorModel(
        id: author.id,
        name: author.name,
        email: author.email,
        createdAt: author.createdAt,
      );
    }).toList();

    return BookModel(
      id: book.id,
      title: book.title,
      isbn: book.isbn,
      categoryId: book.categoryId,
      publishedYear: book.publishedYear,
      createdAt: book.createdAt,
      category: category != null ? CategoryModel(
        id: category.id,
        name: category.name,
        description: category.description,
        createdAt: category.createdAt,
      ) : null,
      authors: bookAuthorsList,
    );
  }

  Future<BookModel> createBook(BookModel book, List<int> authorIds) async {
    return await transaction(() async {
      // Insert book
      final bookId = await into(books).insert(BooksCompanion(
        title: Value(book.title),
        isbn: Value(book.isbn),
        categoryId: Value(book.categoryId),
        publishedYear: Value(book.publishedYear),
      ));

      // Insert book-author relationships
      for (final authorId in authorIds) {
        await into(bookAuthors).insert(BookAuthorsCompanion(
          bookId: Value(bookId),
          authorId: Value(authorId),
        ));
      }

      return book.copyWith(id: bookId);
    });
  }

  Future<bool> updateBook(BookModel book, List<int> authorIds) async {
    return await transaction(() async {
      // Update book
      final updated = await (update(books)..where((b) => b.id.equals(book.id!)))
          .write(BooksCompanion(
            title: Value(book.title),
            isbn: Value(book.isbn),
            categoryId: Value(book.categoryId),
            publishedYear: Value(book.publishedYear),
          ));

      if (updated > 0) {
        // Delete existing author relationships
        await (delete(bookAuthors)..where((ba) => ba.bookId.equals(book.id!))).go();

        // Insert new author relationships
        for (final authorId in authorIds) {
          await into(bookAuthors).insert(BookAuthorsCompanion(
            bookId: Value(book.id!),
            authorId: Value(authorId),
          ));
        }
        return true;
      }
      return false;
    });
  }

  Future<int> deleteBook(int id) async {
    return await transaction(() async {
      // Delete book-author relationships first
      await (delete(bookAuthors)..where((ba) => ba.bookId.equals(id))).go();
      
      // Delete book
      return await (delete(books)..where((b) => b.id.equals(id))).go();
    });
  }
}
