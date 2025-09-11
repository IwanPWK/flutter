import 'package:drift/drift.dart';

// Tabel Buku
class Buku extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get judul => text()();
  TextColumn get deskripsi => text().nullable()();
}

// Tabel Penulis
class Penulis extends Table {
  IntColumn get id => integer().autoIncrement()(); // PK
  IntColumn get bukuId => integer().customConstraint(
    'REFERENCES buku(id) ON DELETE CASCADE',
  )(); // FK
  TextColumn get nama => text()();
}

// Tabel Kategori
class Kategori extends Table {
  IntColumn get id => integer().autoIncrement()(); // PK
  IntColumn get bukuId => integer().customConstraint(
    'REFERENCES buku(id) ON DELETE CASCADE',
  )(); // FK
  TextColumn get nama => text()();
}

// Tabel BukuDetail (penghubung + atribut tambahan)
class BukuDetail extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idBuku =>
      integer().customConstraint('REFERENCES buku(id) ON DELETE CASCADE')();
  IntColumn get idPenulis =>
      integer().customConstraint('REFERENCES penulis(id) ON DELETE CASCADE')();
  IntColumn get idKategori =>
      integer().customConstraint('REFERENCES kategori(id) ON DELETE CASCADE')();
  IntColumn get harga => integer()();
  IntColumn get stok => integer()();
}
