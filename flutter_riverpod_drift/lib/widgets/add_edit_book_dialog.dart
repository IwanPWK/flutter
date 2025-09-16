import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/book_providers.dart';
import '../models/book_models.dart';

class AddEditBookDialog extends ConsumerStatefulWidget {
  final WidgetRef ref;
  final BookModel? bookToEdit;

  const AddEditBookDialog({
    Key? key,
    required this.ref,
    this.bookToEdit,
  }) : super(key: key);

  @override
  ConsumerState<AddEditBookDialog> createState() => _AddEditBookDialogState();
}

class _AddEditBookDialogState extends ConsumerState<AddEditBookDialog> {
  final _titleController = TextEditingController();
  final _isbnController = TextEditingController();
  final _yearController = TextEditingController();
  
  int? _selectedCategoryId;
  List<int> _selectedAuthorIds = [];
  
  @override
  void initState() {
    super.initState();
    
    if (widget.bookToEdit != null) {
      _titleController.text = widget.bookToEdit!.title;
      _isbnController.text = widget.bookToEdit!.isbn;
      _yearController.text = widget.bookToEdit!.publishedYear.toString();
      _selectedCategoryId = widget.bookToEdit!.categoryId;
      _selectedAuthorIds = widget.bookToEdit!.authors?.map((a) => a.id!).toList() ?? [];
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _isbnController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DI SINI baru kita watch authors dan categories
    final authorsAsync = ref.watch(authorsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return AlertDialog(
      title: Text(widget.bookToEdit == null ? 'Add Book' : 'Edit Book'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title *',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _isbnController,
                decoration: const InputDecoration(
                  labelText: 'ISBN *',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _yearController,
                decoration: const InputDecoration(
                  labelText: 'Published Year *',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              
              // Category Dropdown
              categoriesAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error loading categories: $error'),
                data: (categories) => DropdownButtonFormField<int>(
                  value: _selectedCategoryId,
                  decoration: const InputDecoration(
                    labelText: 'Category *',
                    border: OutlineInputBorder(),
                  ),
                  items: categories.map((category) => DropdownMenuItem<int>(
                    value: category.id,
                    child: Text(category.name),
                  )).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategoryId = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              
              // Authors Multi-Select
              authorsAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error loading authors: $error'),
                data: (authors) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Authors *', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ListView.builder(
                        itemCount: authors.length,
                        itemBuilder: (context, index) {
                          final author = authors[index];
                          return CheckboxListTile(
                            title: Text(author.name),
                            subtitle: author.email != null ? Text(author.email!) : null,
                            value: _selectedAuthorIds.contains(author.id),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  _selectedAuthorIds.add(author.id!);
                                } else {
                                  _selectedAuthorIds.remove(author.id);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isFormValid() ? _saveBook : null,
          child: Text(widget.bookToEdit == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }

  bool _isFormValid() {
    return _titleController.text.trim().isNotEmpty &&
           _isbnController.text.trim().isNotEmpty &&
           _yearController.text.trim().isNotEmpty &&
           _selectedCategoryId != null &&
           _selectedAuthorIds.isNotEmpty;
  }

  void _saveBook() {
    final book = BookModel(
      id: widget.bookToEdit?.id,
      title: _titleController.text.trim(),
      isbn: _isbnController.text.trim(),
      categoryId: _selectedCategoryId!,
      publishedYear: int.parse(_yearController.text.trim()),
    );

    if (widget.bookToEdit == null) {
      // Create new book
      ref.read(booksProvider.notifier).createBook(book, _selectedAuthorIds);
    } else {
      // Update existing book
      ref.read(booksProvider.notifier).updateBook(book, _selectedAuthorIds);
    }

    Navigator.pop(context);
  }
}
