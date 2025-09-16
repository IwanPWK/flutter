// lib/screens/inventory_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pharmacy_providers.dart';
import '../models/pharmacy_models.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryAsync = ref.watch(inventoryNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('**Inventory**'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddInventoryDialog(context, ref),
          ),
          IconButton(
            icon: const Icon(Icons.warning),
            onPressed: () => _showLowStockDialog(context, ref),
            tooltip: 'Low Stock Alert',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.refresh(inventoryNotifierProvider),
          ),
        ],
      ),
      body: inventoryAsync.when(
        data: (inventoryItems) {
          if (inventoryItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No inventory items available',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the + button to add inventory',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: inventoryItems.length,
            itemBuilder: (context, index) {
              final inventory = inventoryItems[index];
              final isLowStock = inventory.quantity <= inventory.minimumStock;
              final stockPercentage = inventory.minimumStock > 0 
                  ? (inventory.quantity / inventory.minimumStock)
                  : 1.0;

              return Card(
                margin: const EdgeInsets.only(bottom: 8.0),
                elevation: 2,
                color: isLowStock ? Colors.red.shade50 : null,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12.0),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isLowStock ? Colors.red : Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${inventory.quantity}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          inventory.medicine?.unit ?? 'pcs',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    '**${inventory.medicine?.name ?? "Unknown Medicine"}**',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isLowStock ? Colors.red.shade700 : null,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.business, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('Supplier: ${inventory.supplier?.name ?? "Unknown"}'),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.inventory, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('Min Stock: ${inventory.minimumStock}'),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.trending_up,
                            size: 16,
                            color: isLowStock ? Colors.red : Colors.green,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${(stockPercentage * 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                              color: isLowStock ? Colors.red : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text('Last Restock: ${inventory.lastRestocked.toString().split(' ')[0]}'),
                        ],
                      ),
                      if (isLowStock) ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'LOW STOCK',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.green),
                        onPressed: () => _showAddStockDialog(context, ref, inventory),
                        tooltip: 'Add Stock',
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.orange),
                        onPressed: () => _showReduceStockDialog(context, ref, inventory),
                        tooltip: 'Reduce Stock',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteConfirmation(context, ref, inventory),
                        tooltip: 'Delete Inventory',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error: $error',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(inventoryNotifierProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddInventoryDialog(BuildContext context, WidgetRef ref) {
    final quantityController = TextEditingController();
    final minStockController = TextEditingController();
    MedicineModel? selectedMedicine;
    SupplierModel? selectedSupplier;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add Inventory'),
            content: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Medicine Dropdown
                    Consumer(
                      builder: (context, ref, _) {
                        final medicinesAsync = ref.watch(medicineNotifierProvider);
                        return medicinesAsync.when(
                          data: (medicines) => DropdownButtonFormField<MedicineModel>(
                            value: selectedMedicine,
                            decoration: const InputDecoration(
                              labelText: 'Select Medicine',
                              border: OutlineInputBorder(),
                            ),
                            items: medicines.map((medicine) {
                              return DropdownMenuItem(
                                value: medicine,
                                child: Text('${medicine.name} (${medicine.unit})'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedMedicine = value;
                              });
                            },
                          ),
                          loading: () => const CircularProgressIndicator(),
                          error: (error, _) => Text('Error loading medicines: $error'),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    // Supplier Dropdown
                    Consumer(
                      builder: (context, ref, _) {
                        final suppliersAsync = ref.watch(supplierNotifierProvider);
                        return suppliersAsync.when(
                          data: (suppliers) => DropdownButtonFormField<SupplierModel>(
                            value: selectedSupplier,
                            decoration: const InputDecoration(
                              labelText: 'Select Supplier',
                              border: OutlineInputBorder(),
                            ),
                            items: suppliers.map((supplier) {
                              return DropdownMenuItem(
                                value: supplier,
                                child: Text(supplier.name),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedSupplier = value;
                              });
                            },
                          ),
                          loading: () => const CircularProgressIndicator(),
                          error: (error, _) => Text('Error loading suppliers: $error'),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    TextField(
                      controller: quantityController,
                      decoration: const InputDecoration(
                        labelText: 'Initial Quantity',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: minStockController,
                      decoration: const InputDecoration(
                        labelText: 'Minimum Stock Level',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
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
                onPressed: selectedMedicine == null || selectedSupplier == null 
                    ? null 
                    : () {
                        final quantity = int.tryParse(quantityController.text) ?? 0;
                        final minStock = int.tryParse(minStockController.text) ?? 0;
                        
                        if (quantity > 0 && minStock >= 0) {
                          ref.read(inventoryNotifierProvider.notifier).addInventory(
                            medicineId: selectedMedicine!.id,
                            supplierId: selectedSupplier!.id,
                            quantity: quantity,
                            minimumStock: minStock,
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Inventory added successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                child: const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAddStockDialog(BuildContext context, WidgetRef ref, InventoryModel inventory) {
    final quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Stock - ${inventory.medicine?.name ?? ""}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Current Stock: **${inventory.quantity}** ${inventory.medicine?.unit ?? ""}'),
            const SizedBox(height: 12),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity to Add',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final addQuantity = int.tryParse(quantityController.text) ?? 0;
              if (addQuantity > 0) {
                final newQuantity = inventory.quantity + addQuantity;
                ref.read(inventoryNotifierProvider.notifier).updateInventoryStock(
                  inventory.id,
                  newQuantity,
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added $addQuantity ${inventory.medicine?.unit ?? ""} to stock'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Add Stock'),
          ),
        ],
      ),
    );
  }

  void _showReduceStockDialog(BuildContext context, WidgetRef ref, InventoryModel inventory) {
    final quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reduce Stock - ${inventory.medicine?.name ?? ""}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Current Stock: **${inventory.quantity}** ${inventory.medicine?.unit ?? ""}'),
            const SizedBox(height: 12),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity to Reduce',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final reduceQuantity = int.tryParse(quantityController.text) ?? 0;
              if (reduceQuantity > 0 && reduceQuantity < inventory.quantity) {
                final newQuantity = inventory.quantity - reduceQuantity;
                ref.read(inventoryNotifierProvider.notifier).updateInventoryStock(
                  inventory.id,
                  newQuantity,
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Reduced $reduceQuantity ${inventory.medicine?.unit ?? ""} from stock'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            },
            child: const Text('Reduce Stock'),
          ),
        ],
      ),
    );
  }

  void _showLowStockDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('**Low Stock Alert**'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: Consumer(
            builder: (context, ref, _) {
              final inventoryAsync = ref.watch(inventoryNotifierProvider);
              
              return inventoryAsync.when(
                data: (inventoryItems) {
                  final lowStockItems = inventoryItems
                      .where((item) => item.quantity <= item.minimumStock)
                      .toList();

                  if (lowStockItems.isEmpty) {
                    return const Center(
                      child: Text('No low stock items found!'),
                    );
                  }

                  return ListView.builder(
                    itemCount: lowStockItems.length,
                    itemBuilder: (context, index) {
                      final item = lowStockItems[index];
                      return ListTile(
                        leading: const Icon(Icons.warning, color: Colors.red),
                        title: Text(item.medicine?.name ?? "Unknown"),
                        subtitle: Text(
                          'Stock: ${item.quantity} / Min: ${item.minimumStock}',
                        ),
                        trailing: Text(
                          '${item.medicine?.unit ?? ""}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(child: Text('Error: $error')),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref, InventoryModel inventory) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Inventory'),
        content: Text(
          'Are you sure you want to delete the inventory for "${inventory.medicine?.name ?? "Unknown"}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(inventoryNotifierProvider.notifier).deleteInventory(inventory.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Inventory for ${inventory.medicine?.name ?? ""} deleted'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
