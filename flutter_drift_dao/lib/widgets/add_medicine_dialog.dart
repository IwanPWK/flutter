// lib/widgets/add_medicine_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pharmacy_providers.dart';
import '../models/pharmacy_models.dart';

class AddMedicineDialog extends ConsumerStatefulWidget {
  const AddMedicineDialog({super.key});

  @override
  ConsumerState<AddMedicineDialog> createState() => _AddMedicineDialogState();
}

class _AddMedicineDialogState extends ConsumerState<AddMedicineDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _unitController = TextEditingController();
  DateTime _expiredAt = DateTime.now().add(const Duration(days: 365));
  CategoryModel? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    // DI SINI categories benar-benar digunakan!
    final categoriesAsync = ref.watch(categoryNotifierProvider);

    return AlertDialog(
      title: const Text('Add Medicine'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Medicine Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _unitController,
              decoration: const InputDecoration(labelText: 'Unit'),
            ),
            const SizedBox(height: 16),
            // Category Dropdown - INI yang menggunakan categoriesAsync!
            categoriesAsync.when(
              data: (categories) => DropdownButtonFormField<CategoryModel>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category'),
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, _) => Text('Error loading categories: $error'),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Expiry Date'),
              subtitle: Text(_expiredAt.toString().split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _expiredAt,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 3650)),
                );
                if (date != null) {
                  setState(() {
                    _expiredAt = date;
                  });
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _selectedCategory == null ? null : () {
            ref.read(medicineNotifierProvider.notifier).addMedicine(
              name: _nameController.text,
              description: _descriptionController.text,
              categoryId: _selectedCategory!.id,
              price: double.tryParse(_priceController.text) ?? 0.0,
              unit: _unitController.text,
              expiredAt: _expiredAt,
            );
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _unitController.dispose();
    super.dispose();
  }
}
