import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/book_models.dart';
import 'database_provider.dart';

// Authors AsyncNotifierProvider
class AuthorsNotifier extends AsyncNotifier<List<AuthorModel>> {
  @override
  Future<List<AuthorModel>> build() async {
    final dao = ref.read(authorDaoProvider);
    return await dao.getAllAuthors();
  }

  Future<void> createAuthor(AuthorModel author) async {
    state = const AsyncValue.loading();
    try {
      final dao = ref.read(authorDaoProvider);
      await dao.createAuthor(author);
      state = AsyncValue.data(await dao.getAllAuthors());
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateAuthor(AuthorModel author) async {
    state = const AsyncValue.loading();
    try {
      final dao = ref.read(authorDaoProvider);
      await dao.updateAuthor(author);
      state = AsyncValue.data(await dao.getAllAuthors());
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteAuthor(int id) async {
    state = const AsyncValue.loading();
    try {
      final dao = ref.read(authorDaoProvider);
      await dao.deleteAuthor(id);
      state = AsyncValue.data(await dao.getAllAuthors());
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final authorsProvider = AsyncNotifierProvider<AuthorsNotifier, List<AuthorModel>>(() {
  return AuthorsNotifier();
});

// Categories AsyncNotifierProvider
class CategoriesNotifier extends AsyncNotifier<List<CategoryModel>> {
  @override
  Future<List<CategoryModel>> build() async {
    final dao = ref.read(categoryDaoProvider);
    return await dao.getAllCategories();
  }

  Future<void> createCategory(CategoryModel category) async {
    state = const AsyncValue.loading();
    try {
      final dao = ref.read(categoryDaoProvider);
      await dao.createCategory(category);
      state = AsyncValue.data(await dao.getAllCategories());
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateCategory(CategoryModel category) async {
    state = const AsyncValue.loading();
    try {
      final dao = ref.read(categoryDaoProvider);
      await dao.updateCategory(category);
      state = AsyncValue.data(await dao.getAllCategories());
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteCategory(int id) async {
    state = const AsyncValue.loading();
    try {
      final dao = ref.read(categoryDaoProvider);
      await dao.deleteCategory(id);
      state = AsyncValue.data(await dao.getAllCategories());
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final categoriesProvider = AsyncNotifierProvider<CategoriesNotifier, List<CategoryModel>>(() {
  return CategoriesNotifier();
});

// Books AsyncNotifierProvider
class BooksNotifier extends AsyncNotifier<List<BookModel>> {
  @override
  Future<List<BookModel>> build() async {
    final dao = ref.read(bookDaoProvider);
    return await dao.getAllBooks();
  }

  Future<void> createBook(BookModel book, List<int> authorIds) async {
    state = const AsyncValue.loading();
    try {
      final dao = ref.read(bookDaoProvider);
      await dao.createBook(book, authorIds);
      state = AsyncValue.data(await dao.getAllBooks());
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> updateBook(BookModel book, List<int> authorIds) async {
    state = const AsyncValue.loading();
    try {
      final dao = ref.read(bookDaoProvider);
      await dao.updateBook(book, authorIds);
      state = AsyncValue.data(await dao.getAllBooks());
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> deleteBook(int id) async {
    state = const AsyncValue.loading();
    try {
      final dao = ref.read(bookDaoProvider);
      await dao.deleteBook(id);
      state = AsyncValue.data(await dao.getAllBooks());
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final booksProvider = AsyncNotifierProvider<BooksNotifier, List<BookModel>>(() {
  return BooksNotifier();
});
