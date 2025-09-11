import 'package:flutter/material.dart';
// import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'database/database.dart';
import 'database/database.dart';
import 'providers/database_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: BukuListPage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class BukuListPage extends ConsumerWidget {
  const BukuListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bukuListAsync = ref.watch(bukuListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Buku")),
      body: bukuListAsync.when(
        data: (bukuList) {
          return ListView.builder(
            itemCount: bukuList.length,
            itemBuilder: (context, index) {
              final buku = bukuList[index];
              return ListTile(
                onTap: () {
                  _showInsertDialog(context, ref);
                },
                title: Text(buku.judul),
                subtitle: Text(
                  "${buku.namaPenulis} | ${buku.namaKategori} | Rp${buku.harga} | Stok: ${buku.stok}",
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final dao = ref.read(bukuDaoProvider);
                    await dao.deleteBukuCascade(buku.idBuku);
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showInsertDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showInsertDialog(
    BuildContext context,
    WidgetRef ref,
    // BukuGabungan? buku,
  ) {
    final judulController = TextEditingController();
    final deskripsiController = TextEditingController();
    final penulisController = TextEditingController();
    final kategoriController = TextEditingController();

    final hargaController = TextEditingController();
    final stokController = TextEditingController();
    // if (buku != null) {
    //   judulController.text = buku.judul;
    //   deskripsiController.text = buku.deskripsi ?? '';
    //   penulisController.text = buku.namaPenulis;
    //   kategoriController.text = buku.namaKategori;
    //   hargaController.text = buku.harga.toString();
    //   stokController.text = buku.stok.toString();
    // }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Tambah Buku"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: judulController,
                decoration: const InputDecoration(labelText: "Judul"),
              ),
              TextField(
                controller: deskripsiController,
                decoration: const InputDecoration(labelText: "Deskripsi"),
              ),
              TextField(
                controller: penulisController,
                decoration: const InputDecoration(labelText: "Penulis"),
              ),
              TextField(
                controller: kategoriController,
                decoration: const InputDecoration(labelText: "Kategori"),
              ),
              TextField(
                controller: hargaController,
                decoration: const InputDecoration(labelText: "Harga"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: stokController,
                decoration: const InputDecoration(labelText: "Stok"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              final dao = ref.read(bukuDaoProvider);

              // if (buku != null) {
              //   await dao.updateBuku(
              //     buku.idBuku,
              //     judul: judulController.text,
              //     deskripsi: deskripsiController.text,
              //   );
              //   await dao.updatePenulis(
              //     buku.idPenulis,
              //     nama: penulisController.text,
              //   );
              //   await dao.updateKategori(
              //     buku.idKategori,
              //     nama: kategoriController.text,
              //   );
              //   await dao.updateBukuDetail(
              //     buku.idBukuDetail,
              //     harga: int.parse(hargaController.text),
              //     stok: int.parse(stokController.text),
              //   );
              // }

              // Insert ke masing-masing tabel
              final idBuku = await dao.insertBuku(
                judulController.text,
                deskripsiController.text,
              );
              print('id Buku $idBuku');
              final idPenulis = await dao.insertPenulis(
                penulisController.text,
                idBuku,
              );
              final idKategori = await dao.insertKategori(
                kategoriController.text,
                idBuku,
              );
              print('id Penulis $idPenulis');
              print('id Kategori $idKategori');
              try {
                final idBukuDetail = await dao.insertBukuDetail(
                  idBuku,
                  idPenulis,
                  idKategori,
                  int.parse(hargaController.text),
                  int.parse(stokController.text),
                );
                print('id bukuDetail $idBukuDetail');
              } catch (e) {
                print('Error inserting BukuDetail: $e');
              }

              print(
                'cek get all ${await dao.getAllBuku()} | ${await dao.getAllPenulis()} | ${await dao.getAllKategori()} | ${await dao.getAllBukuDetail()}',
              );

              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}
