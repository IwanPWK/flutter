import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database/dao.dart';
import 'providers/database_provider.dart';
import 'database/app_database.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory Distributor',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const StockListPage(),
    );
  }
}

class StockListPage extends ConsumerWidget {
  const StockListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stockDao = ref.watch(stockDaoProvider);
    final stockAsync = ref.watch(stockListProvider);
    // print('insert stockDao: $stockDao');

    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Stok")),
      body: stockAsync.when(
        data: (stocks) {
          return ListView.builder(
            itemCount: stocks.length,
            itemBuilder: (context, index) {
              final stock = stocks[index];
              return ListTile(
                title: Text(stock.product.name),
                subtitle: Text("Supplier: ${stock.supplier.name}"),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text("Error: $error")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // contoh insert dummy data
          final catDao = ref.read(categoryDaoProvider);
          final supDao = ref.read(supplierDaoProvider);
          final prodDao = ref.read(productDaoProvider);

          final catId = await catDao.insertCategory(
            CategoriesCompanion(name: Value("Obat")),
          );
          final supId = await supDao.insertSupplier(
            SuppliersCompanion(name: Value("PT Sehat Selalu")),
          );
          final prodId = await prodDao.insertProduct(
            ProductsCompanion(
              name: Value("Paracetamol"),
              categoryId: Value(catId),
            ),
          );

          final insertValue = await stockDao.insertStock(
            StocksCompanion(
              productId: Value(prodId),
              supplierId: Value(supId),
              quantity: const Value(100),
              price: const Value(5000),
            ),
          );
          ref.invalidate(stockListProvider); // refresh data
          // setState(() {}); // refresh UI
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
