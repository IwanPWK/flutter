// lib/widgets/edit_medicine_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pharmacy_providers.dart';
import '../models/pharmacy_models.dart';

class EditMedicineDialog extends ConsumerStatefulWidget {
  final MedicineModel medicine;
  
  const EditMedicineDialog({
    super.key,
    required this.medicine,
  });

  @override
  ConsumerState<EditMedicineDialog> createState() => _EditMedicineDialogState();
}

class _EditMedicineDialogState extends ConsumerState<EditMedicineDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _unitController;
  late DateTime _expiredAt;
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing medicine data
    _nameController = TextEditingController(text: widget.medicine.name);
    _descriptionController = TextEditingController(text: widget.medicine.description);
    _priceController = TextEditingController(text: widget.medicine.price.toString());
    _unitController = TextEditingController(text: widget.medicine.unit);
    _expiredAt = widget.medicine.expiredAt;
    _selectedCategory = widget.medicine.category;
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoryNotifierProvider);

    return AlertDialog(
      title: const Text('**Edit Medicine**'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Medicine Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                  prefixText: '\$ ',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _unitController,
                decoration: const InputDecoration(
                  labelText: 'Unit (e.g., tablet, ml, mg)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              
              // Category Dropdown
              categoriesAsync.when(
                data: (categories) => DropdownButtonFormField<CategoryModel>(
                  value: categories.where((cat) => cat.id == _selectedCategory?.id).firstOrNull,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
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
                loading: () => const SizedBox(
                  height: 56,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, _) => Container(
                  height: 56,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Error loading categories: $error',
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Expiry Date Picker
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ListTile(
                  title: const Text('Expiry Date'),
                  subtitle: Text(
                    _expiredAt.toString().split(' ')[0],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
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
        TextButton(
          onPressed: _selectedCategory == null ? null : () => _updateMedicine(),
          child: const Text('**Update**'),
        ),
      ],
    );
  }

  void _updateMedicine() {
    if (_nameController.text.isEmpty || 
        _descriptionController.text.isEmpty ||
        _unitController.text.isEmpty ||
        _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final price = double.tryParse(_priceController.text);
    if (price == null || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid price'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Update medicine using the notifier
    ref.read(medicineNotifierProvider.notifier).updateMedicine(
      widget.medicine.id,
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim(),
      categoryId: _selectedCategory!.id,
      price: price,
      unit: _unitController.text.trim(),
      expiredAt: _expiredAt,
    );

    Navigator.pop(context);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Medicine updated successfully!'),
        backgroundColor: Colors.green,
      ),
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
