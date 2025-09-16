import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_models.freezed.dart';
part 'book_models.g.dart';

@freezed
abstract class AuthorModel with _$AuthorModel {
  const factory AuthorModel({
    int? id,
    required String name,
    String? email,
    DateTime? createdAt,
  }) = _AuthorModel;

  factory AuthorModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorModelFromJson(json);
}

@freezed
abstract class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    int? id,
    required String name,
    String? description,
    DateTime? createdAt,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}

@freezed
abstract class BookModel with _$BookModel {
  const factory BookModel({
    int? id,
    required String title,
    required String isbn,
    required int categoryId,
    required int publishedYear,
    DateTime? createdAt,
    CategoryModel? category,
    List<AuthorModel>? authors,
  }) = _BookModel;

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}

@freezed
abstract class BookAuthorModel with _$BookAuthorModel {
  const factory BookAuthorModel({
    int? id,
    required int bookId,
    required int authorId,
    DateTime? createdAt,
  }) = _BookAuthorModel;

  factory BookAuthorModel.fromJson(Map<String, dynamic> json) =>
      _$BookAuthorModelFromJson(json);
}
