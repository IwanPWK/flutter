// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'category_screen.dart';
import 'supplier_screen.dart';
import 'medicine_screen.dart';
import 'inventory_screen.dart';
import '../providers/pharmacy_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('**Pharmacy Management**'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            
            // Stats Cards
            Row(
              children: [
                Expanded(child: _buildStatsCard('Categories', Icons.category, Colors.orange, ref)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatsCard('Medicines', Icons.medical_services, Colors.green, ref)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildStatsCard('Suppliers', Icons.business, Colors.purple, ref)),
                const SizedBox(width: 12),
                Expanded(child: _buildStatsCard('Inventory', Icons.inventory, Colors.red, ref)),
              ],
            ),
            const SizedBox(height: 24),
            
            const Text(
              'Management',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            
            // Navigation Grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: [
                  _buildNavigationCard(
                    context,
                    'Categories',
                    Icons.category,
                    Colors.orange,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CategoryScreen()),
                    ),
                  ),
                  _buildNavigationCard(
                    context,
                    'Medicines',
                    Icons.medical_services,
                    Colors.green,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MedicineScreen()),
                    ),
                  ),
                  _buildNavigationCard(
                    context,
                    'Suppliers',
                    Icons.business,
                    Colors.purple,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SupplierScreen()),
                    ),
                  ),
                  _buildNavigationCard(
                    context,
                    'Inventory',
                    Icons.inventory,
                    Colors.red,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const InventoryScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard(String title, IconData icon, Color color, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            _buildCountText(title, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildCountText(String title, WidgetRef ref) {
    switch (title) {
      case 'Categories':
        final categoriesAsync = ref.watch(categoryNotifierProvider);
        return categoriesAsync.when(
          data: (categories) => Text(
            '${categories.length}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          loading: () => const Text('...'),
          error: (_, __) => const Text('Error'),
        );
      case 'Medicines':
        final medicinesAsync = ref.watch(medicineNotifierProvider);
        return medicinesAsync.when(
          data: (medicines) => Text(
            '${medicines.length}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          loading: () => const Text('...'),
          error: (_, __) => const Text('Error'),
        );
      case 'Suppliers':
        final suppliersAsync = ref.watch(supplierNotifierProvider);
        return suppliersAsync.when(
          data: (suppliers) => Text(
            '${suppliers.length}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          loading: () => const Text('...'),
          error: (_, __) => const Text('Error'),
        );
      case 'Inventory':
        final inventoryAsync = ref.watch(inventoryNotifierProvider);
        return inventoryAsync.when(
          data: (inventory) => Text(
            '${inventory.length}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          loading: () => const Text('...'),
          error: (_, __) => const Text('Error'),
        );
      default:
        return const Text('0');
    }
  }

  Widget _buildNavigationCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 48),
              const SizedBox(height: 12),
              Text(
                '**$title**',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
