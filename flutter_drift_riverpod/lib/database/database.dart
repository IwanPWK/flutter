import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Buku, Penulis, Kategori, BukuDetail])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    });
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await customStatement('PRAGMA foreign_keys = ON');
      print('✅ Foreign keys enabled');
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      print('✅ Foreign keys enabled');
    },
  );
}

// ========== DAO ==========
@DriftAccessor(tables: [Buku, Penulis, Kategori, BukuDetail])
class BukuDao extends DatabaseAccessor<AppDatabase> with _$BukuDaoMixin {
  final AppDatabase db;
  BukuDao(this.db) : super(db);

  // ========== CREATE ==========

  Future<int> insertBuku(String judul, String? deskripsi) =>
      into(db.buku).insert(
        BukuCompanion.insert(
          judul: judul,
          deskripsi: Value(deskripsi), // ✅ Ini cara baru di Drift v2+
        ),
      );
  Future<int> insertPenulis(String nama, int bukuId) => into(
    db.penulis,
  ).insert(PenulisCompanion.insert(nama: nama, bukuId: bukuId));

  Future<int> insertKategori(String nama, int bukuId) => into(
    db.kategori,
  ).insert(KategoriCompanion.insert(nama: nama, bukuId: bukuId));

  Future<int> insertBukuDetail(
    int idBuku,
    int idPenulis,
    int idKategori,
    int harga,
    int stok,
  ) => into(db.bukuDetail).insert(
    BukuDetailCompanion.insert(
      idBuku: idBuku,
      idPenulis: idPenulis,
      idKategori: idKategori,
      harga: harga,
      stok: stok,
    ),
  );

  // ========== READ JOINED DATA ==========

  Stream<List<BukuGabungan>> watchAllBukuGabungan() {
    final query = select(db.bukuDetail).join([
      innerJoin(db.buku, db.buku.id.equalsExp(db.bukuDetail.idBuku)),
      innerJoin(db.penulis, db.penulis.id.equalsExp(db.bukuDetail.idPenulis)),
      innerJoin(
        db.kategori,
        db.kategori.id.equalsExp(db.bukuDetail.idKategori),
      ),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        final bukuDetail = row.readTable(db.bukuDetail);
        final buku = row.readTable(db.buku);
        final penulis = row.readTable(db.penulis);
        final kategori = row.readTable(db.kategori);

        return BukuGabungan(
          idBuku: buku.id,
          idBukuDetail: bukuDetail.id,
          judul: buku.judul,
          deskripsi: buku.deskripsi,
          namaPenulis: penulis.nama,
          namaKategori: kategori.nama,
          harga: bukuDetail.harga,
          stok: bukuDetail.stok,
        );
      }).toList();
    });
  }

  // ========== UPDATE ==========

  /// Update Buku berdasarkan ID
  Future<int> updateBuku(int id, {String? judul, String? deskripsi}) {
    return (update(db.buku)..where((t) => t.id.equals(id))).write(
      BukuCompanion(
        judul: judul != null ? Value(judul) : Value.absent(),
        deskripsi: deskripsi != null ? Value(deskripsi) : Value.absent(),
      ),
    );
  }

  /// Update Penulis berdasarkan ID
  Future<int> updatePenulis(int id, {required String nama}) {
    return (update(db.penulis)..where((t) => t.id.equals(id))).write(
      PenulisCompanion(nama: Value(nama)),
    );
  }

  /// Update Kategori berdasarkan ID
  Future<int> updateKategori(int id, {required String nama}) {
    return (update(db.kategori)..where((t) => t.id.equals(id))).write(
      KategoriCompanion(nama: Value(nama)),
    );
  }

  /// Update BukuDetail berdasarkan ID
  Future<int> updateBukuDetail(
    int id, {
    int? idBuku,
    int? idPenulis,
    int? idKategori,
    int? harga,
    int? stok,
  }) {
    return (update(db.bukuDetail)..where((t) => t.id.equals(id))).write(
      BukuDetailCompanion(
        idBuku: idBuku != null ? Value(idBuku) : Value.absent(),
        idPenulis: idPenulis != null ? Value(idPenulis) : Value.absent(),
        idKategori: idKategori != null ? Value(idKategori) : Value.absent(),
        harga: harga != null ? Value(harga) : Value.absent(),
        stok: stok != null ? Value(stok) : Value.absent(),
      ),
    );
  }

  // ========== DELETE ==========

  /// Hapus buku beserta semua data terkait (BukuDetail, Penulis, Kategori)
  /// Cukup panggil method ini
  Future<void> deleteBukuCascade(int idBuku) async {
    // Jika foreign key ON DELETE CASCADE aktif:
    // - Semua BukuDetail yang terkait akan otomatis terhapus
    // - Penulis dan Kategori akan ikut terhapus jika tidak digunakan oleh BukuDetail lain
    await (delete(db.buku)..where((t) => t.id.equals(idBuku))).go();
    print(
      'periksa nilai tabel ${await getAllBuku()} | ${await getAllPenulis()} | ${await getAllKategori()} | ${await getAllBukuDetail()}',
    );
  }

  // Future<void> deleteBukuDetail(int id) =>
  //     (delete(db.bukuDetail)..where((t) => t.id.equals(id))).go();

  // // Hapus cascade manual (bisa dikembangkan)
  // Future<void> deleteBukuCascade(int idBuku) async {
  //   final detail = await (select(
  //     db.bukuDetail,
  //   )..where((t) => t.idBuku.equals(idBuku))).getSingleOrNull();
  //   if (detail != null) {
  //     await deleteBukuDetail(detail.id);
  //   }
  //   await (delete(db.buku)..where((t) => t.id.equals(idBuku))).go();
  // }

  // ========== GET ALL (for debug) ==========
  Future<List<BukuData>> getAllBuku() => select(db.buku).get();
  Future<List<Penuli>> getAllPenulis() => select(db.penulis).get();
  Future<List<KategoriData>> getAllKategori() => select(db.kategori).get();
  Future<List<BukuDetailData>> getAllBukuDetail() =>
      select(db.bukuDetail).get();
}

// ========== MODEL GABUNGAN ==========
class BukuGabungan {
  final int idBuku;
  final int idBukuDetail;
  final String judul;
  final String? deskripsi;
  final String namaPenulis;
  final String namaKategori;
  final int harga;
  final int stok;

  BukuGabungan({
    required this.idBuku,
    required this.idBukuDetail,
    required this.judul,
    this.deskripsi,
    required this.namaPenulis,
    required this.namaKategori,
    required this.harga,
    required this.stok,
  });
}
