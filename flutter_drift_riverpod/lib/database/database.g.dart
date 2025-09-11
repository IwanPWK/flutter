// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BukuTable extends Buku with TableInfo<$BukuTable, BukuData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BukuTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _judulMeta = const VerificationMeta('judul');
  @override
  late final GeneratedColumn<String> judul = GeneratedColumn<String>(
    'judul',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deskripsiMeta = const VerificationMeta(
    'deskripsi',
  );
  @override
  late final GeneratedColumn<String> deskripsi = GeneratedColumn<String>(
    'deskripsi',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, judul, deskripsi];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'buku';
  @override
  VerificationContext validateIntegrity(
    Insertable<BukuData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('judul')) {
      context.handle(
        _judulMeta,
        judul.isAcceptableOrUnknown(data['judul']!, _judulMeta),
      );
    } else if (isInserting) {
      context.missing(_judulMeta);
    }
    if (data.containsKey('deskripsi')) {
      context.handle(
        _deskripsiMeta,
        deskripsi.isAcceptableOrUnknown(data['deskripsi']!, _deskripsiMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BukuData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BukuData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      judul: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}judul'],
      )!,
      deskripsi: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deskripsi'],
      ),
    );
  }

  @override
  $BukuTable createAlias(String alias) {
    return $BukuTable(attachedDatabase, alias);
  }
}

class BukuData extends DataClass implements Insertable<BukuData> {
  final int id;
  final String judul;
  final String? deskripsi;
  const BukuData({required this.id, required this.judul, this.deskripsi});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['judul'] = Variable<String>(judul);
    if (!nullToAbsent || deskripsi != null) {
      map['deskripsi'] = Variable<String>(deskripsi);
    }
    return map;
  }

  BukuCompanion toCompanion(bool nullToAbsent) {
    return BukuCompanion(
      id: Value(id),
      judul: Value(judul),
      deskripsi: deskripsi == null && nullToAbsent
          ? const Value.absent()
          : Value(deskripsi),
    );
  }

  factory BukuData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BukuData(
      id: serializer.fromJson<int>(json['id']),
      judul: serializer.fromJson<String>(json['judul']),
      deskripsi: serializer.fromJson<String?>(json['deskripsi']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'judul': serializer.toJson<String>(judul),
      'deskripsi': serializer.toJson<String?>(deskripsi),
    };
  }

  BukuData copyWith({
    int? id,
    String? judul,
    Value<String?> deskripsi = const Value.absent(),
  }) => BukuData(
    id: id ?? this.id,
    judul: judul ?? this.judul,
    deskripsi: deskripsi.present ? deskripsi.value : this.deskripsi,
  );
  BukuData copyWithCompanion(BukuCompanion data) {
    return BukuData(
      id: data.id.present ? data.id.value : this.id,
      judul: data.judul.present ? data.judul.value : this.judul,
      deskripsi: data.deskripsi.present ? data.deskripsi.value : this.deskripsi,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BukuData(')
          ..write('id: $id, ')
          ..write('judul: $judul, ')
          ..write('deskripsi: $deskripsi')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, judul, deskripsi);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BukuData &&
          other.id == this.id &&
          other.judul == this.judul &&
          other.deskripsi == this.deskripsi);
}

class BukuCompanion extends UpdateCompanion<BukuData> {
  final Value<int> id;
  final Value<String> judul;
  final Value<String?> deskripsi;
  const BukuCompanion({
    this.id = const Value.absent(),
    this.judul = const Value.absent(),
    this.deskripsi = const Value.absent(),
  });
  BukuCompanion.insert({
    this.id = const Value.absent(),
    required String judul,
    this.deskripsi = const Value.absent(),
  }) : judul = Value(judul);
  static Insertable<BukuData> custom({
    Expression<int>? id,
    Expression<String>? judul,
    Expression<String>? deskripsi,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (judul != null) 'judul': judul,
      if (deskripsi != null) 'deskripsi': deskripsi,
    });
  }

  BukuCompanion copyWith({
    Value<int>? id,
    Value<String>? judul,
    Value<String?>? deskripsi,
  }) {
    return BukuCompanion(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      deskripsi: deskripsi ?? this.deskripsi,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (judul.present) {
      map['judul'] = Variable<String>(judul.value);
    }
    if (deskripsi.present) {
      map['deskripsi'] = Variable<String>(deskripsi.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BukuCompanion(')
          ..write('id: $id, ')
          ..write('judul: $judul, ')
          ..write('deskripsi: $deskripsi')
          ..write(')'))
        .toString();
  }
}

class $PenulisTable extends Penulis with TableInfo<$PenulisTable, Penuli> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PenulisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bukuIdMeta = const VerificationMeta('bukuId');
  @override
  late final GeneratedColumn<int> bukuId = GeneratedColumn<int>(
    'buku_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES buku(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, bukuId, nama];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'penulis';
  @override
  VerificationContext validateIntegrity(
    Insertable<Penuli> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buku_id')) {
      context.handle(
        _bukuIdMeta,
        bukuId.isAcceptableOrUnknown(data['buku_id']!, _bukuIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bukuIdMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Penuli map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Penuli(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bukuId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}buku_id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
    );
  }

  @override
  $PenulisTable createAlias(String alias) {
    return $PenulisTable(attachedDatabase, alias);
  }
}

class Penuli extends DataClass implements Insertable<Penuli> {
  final int id;
  final int bukuId;
  final String nama;
  const Penuli({required this.id, required this.bukuId, required this.nama});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['buku_id'] = Variable<int>(bukuId);
    map['nama'] = Variable<String>(nama);
    return map;
  }

  PenulisCompanion toCompanion(bool nullToAbsent) {
    return PenulisCompanion(
      id: Value(id),
      bukuId: Value(bukuId),
      nama: Value(nama),
    );
  }

  factory Penuli.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Penuli(
      id: serializer.fromJson<int>(json['id']),
      bukuId: serializer.fromJson<int>(json['bukuId']),
      nama: serializer.fromJson<String>(json['nama']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bukuId': serializer.toJson<int>(bukuId),
      'nama': serializer.toJson<String>(nama),
    };
  }

  Penuli copyWith({int? id, int? bukuId, String? nama}) => Penuli(
    id: id ?? this.id,
    bukuId: bukuId ?? this.bukuId,
    nama: nama ?? this.nama,
  );
  Penuli copyWithCompanion(PenulisCompanion data) {
    return Penuli(
      id: data.id.present ? data.id.value : this.id,
      bukuId: data.bukuId.present ? data.bukuId.value : this.bukuId,
      nama: data.nama.present ? data.nama.value : this.nama,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Penuli(')
          ..write('id: $id, ')
          ..write('bukuId: $bukuId, ')
          ..write('nama: $nama')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bukuId, nama);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Penuli &&
          other.id == this.id &&
          other.bukuId == this.bukuId &&
          other.nama == this.nama);
}

class PenulisCompanion extends UpdateCompanion<Penuli> {
  final Value<int> id;
  final Value<int> bukuId;
  final Value<String> nama;
  const PenulisCompanion({
    this.id = const Value.absent(),
    this.bukuId = const Value.absent(),
    this.nama = const Value.absent(),
  });
  PenulisCompanion.insert({
    this.id = const Value.absent(),
    required int bukuId,
    required String nama,
  }) : bukuId = Value(bukuId),
       nama = Value(nama);
  static Insertable<Penuli> custom({
    Expression<int>? id,
    Expression<int>? bukuId,
    Expression<String>? nama,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bukuId != null) 'buku_id': bukuId,
      if (nama != null) 'nama': nama,
    });
  }

  PenulisCompanion copyWith({
    Value<int>? id,
    Value<int>? bukuId,
    Value<String>? nama,
  }) {
    return PenulisCompanion(
      id: id ?? this.id,
      bukuId: bukuId ?? this.bukuId,
      nama: nama ?? this.nama,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bukuId.present) {
      map['buku_id'] = Variable<int>(bukuId.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PenulisCompanion(')
          ..write('id: $id, ')
          ..write('bukuId: $bukuId, ')
          ..write('nama: $nama')
          ..write(')'))
        .toString();
  }
}

class $KategoriTable extends Kategori
    with TableInfo<$KategoriTable, KategoriData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KategoriTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bukuIdMeta = const VerificationMeta('bukuId');
  @override
  late final GeneratedColumn<int> bukuId = GeneratedColumn<int>(
    'buku_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES buku(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, bukuId, nama];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kategori';
  @override
  VerificationContext validateIntegrity(
    Insertable<KategoriData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('buku_id')) {
      context.handle(
        _bukuIdMeta,
        bukuId.isAcceptableOrUnknown(data['buku_id']!, _bukuIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bukuIdMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KategoriData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KategoriData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bukuId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}buku_id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
    );
  }

  @override
  $KategoriTable createAlias(String alias) {
    return $KategoriTable(attachedDatabase, alias);
  }
}

class KategoriData extends DataClass implements Insertable<KategoriData> {
  final int id;
  final int bukuId;
  final String nama;
  const KategoriData({
    required this.id,
    required this.bukuId,
    required this.nama,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['buku_id'] = Variable<int>(bukuId);
    map['nama'] = Variable<String>(nama);
    return map;
  }

  KategoriCompanion toCompanion(bool nullToAbsent) {
    return KategoriCompanion(
      id: Value(id),
      bukuId: Value(bukuId),
      nama: Value(nama),
    );
  }

  factory KategoriData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KategoriData(
      id: serializer.fromJson<int>(json['id']),
      bukuId: serializer.fromJson<int>(json['bukuId']),
      nama: serializer.fromJson<String>(json['nama']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bukuId': serializer.toJson<int>(bukuId),
      'nama': serializer.toJson<String>(nama),
    };
  }

  KategoriData copyWith({int? id, int? bukuId, String? nama}) => KategoriData(
    id: id ?? this.id,
    bukuId: bukuId ?? this.bukuId,
    nama: nama ?? this.nama,
  );
  KategoriData copyWithCompanion(KategoriCompanion data) {
    return KategoriData(
      id: data.id.present ? data.id.value : this.id,
      bukuId: data.bukuId.present ? data.bukuId.value : this.bukuId,
      nama: data.nama.present ? data.nama.value : this.nama,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KategoriData(')
          ..write('id: $id, ')
          ..write('bukuId: $bukuId, ')
          ..write('nama: $nama')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bukuId, nama);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KategoriData &&
          other.id == this.id &&
          other.bukuId == this.bukuId &&
          other.nama == this.nama);
}

class KategoriCompanion extends UpdateCompanion<KategoriData> {
  final Value<int> id;
  final Value<int> bukuId;
  final Value<String> nama;
  const KategoriCompanion({
    this.id = const Value.absent(),
    this.bukuId = const Value.absent(),
    this.nama = const Value.absent(),
  });
  KategoriCompanion.insert({
    this.id = const Value.absent(),
    required int bukuId,
    required String nama,
  }) : bukuId = Value(bukuId),
       nama = Value(nama);
  static Insertable<KategoriData> custom({
    Expression<int>? id,
    Expression<int>? bukuId,
    Expression<String>? nama,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bukuId != null) 'buku_id': bukuId,
      if (nama != null) 'nama': nama,
    });
  }

  KategoriCompanion copyWith({
    Value<int>? id,
    Value<int>? bukuId,
    Value<String>? nama,
  }) {
    return KategoriCompanion(
      id: id ?? this.id,
      bukuId: bukuId ?? this.bukuId,
      nama: nama ?? this.nama,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bukuId.present) {
      map['buku_id'] = Variable<int>(bukuId.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KategoriCompanion(')
          ..write('id: $id, ')
          ..write('bukuId: $bukuId, ')
          ..write('nama: $nama')
          ..write(')'))
        .toString();
  }
}

class $BukuDetailTable extends BukuDetail
    with TableInfo<$BukuDetailTable, BukuDetailData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BukuDetailTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _idBukuMeta = const VerificationMeta('idBuku');
  @override
  late final GeneratedColumn<int> idBuku = GeneratedColumn<int>(
    'id_buku',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES buku(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _idPenulisMeta = const VerificationMeta(
    'idPenulis',
  );
  @override
  late final GeneratedColumn<int> idPenulis = GeneratedColumn<int>(
    'id_penulis',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES penulis(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _idKategoriMeta = const VerificationMeta(
    'idKategori',
  );
  @override
  late final GeneratedColumn<int> idKategori = GeneratedColumn<int>(
    'id_kategori',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'REFERENCES kategori(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _hargaMeta = const VerificationMeta('harga');
  @override
  late final GeneratedColumn<int> harga = GeneratedColumn<int>(
    'harga',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stokMeta = const VerificationMeta('stok');
  @override
  late final GeneratedColumn<int> stok = GeneratedColumn<int>(
    'stok',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    idBuku,
    idPenulis,
    idKategori,
    harga,
    stok,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'buku_detail';
  @override
  VerificationContext validateIntegrity(
    Insertable<BukuDetailData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_buku')) {
      context.handle(
        _idBukuMeta,
        idBuku.isAcceptableOrUnknown(data['id_buku']!, _idBukuMeta),
      );
    } else if (isInserting) {
      context.missing(_idBukuMeta);
    }
    if (data.containsKey('id_penulis')) {
      context.handle(
        _idPenulisMeta,
        idPenulis.isAcceptableOrUnknown(data['id_penulis']!, _idPenulisMeta),
      );
    } else if (isInserting) {
      context.missing(_idPenulisMeta);
    }
    if (data.containsKey('id_kategori')) {
      context.handle(
        _idKategoriMeta,
        idKategori.isAcceptableOrUnknown(data['id_kategori']!, _idKategoriMeta),
      );
    } else if (isInserting) {
      context.missing(_idKategoriMeta);
    }
    if (data.containsKey('harga')) {
      context.handle(
        _hargaMeta,
        harga.isAcceptableOrUnknown(data['harga']!, _hargaMeta),
      );
    } else if (isInserting) {
      context.missing(_hargaMeta);
    }
    if (data.containsKey('stok')) {
      context.handle(
        _stokMeta,
        stok.isAcceptableOrUnknown(data['stok']!, _stokMeta),
      );
    } else if (isInserting) {
      context.missing(_stokMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BukuDetailData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BukuDetailData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      idBuku: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_buku'],
      )!,
      idPenulis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_penulis'],
      )!,
      idKategori: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id_kategori'],
      )!,
      harga: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga'],
      )!,
      stok: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stok'],
      )!,
    );
  }

  @override
  $BukuDetailTable createAlias(String alias) {
    return $BukuDetailTable(attachedDatabase, alias);
  }
}

class BukuDetailData extends DataClass implements Insertable<BukuDetailData> {
  final int id;
  final int idBuku;
  final int idPenulis;
  final int idKategori;
  final int harga;
  final int stok;
  const BukuDetailData({
    required this.id,
    required this.idBuku,
    required this.idPenulis,
    required this.idKategori,
    required this.harga,
    required this.stok,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_buku'] = Variable<int>(idBuku);
    map['id_penulis'] = Variable<int>(idPenulis);
    map['id_kategori'] = Variable<int>(idKategori);
    map['harga'] = Variable<int>(harga);
    map['stok'] = Variable<int>(stok);
    return map;
  }

  BukuDetailCompanion toCompanion(bool nullToAbsent) {
    return BukuDetailCompanion(
      id: Value(id),
      idBuku: Value(idBuku),
      idPenulis: Value(idPenulis),
      idKategori: Value(idKategori),
      harga: Value(harga),
      stok: Value(stok),
    );
  }

  factory BukuDetailData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BukuDetailData(
      id: serializer.fromJson<int>(json['id']),
      idBuku: serializer.fromJson<int>(json['idBuku']),
      idPenulis: serializer.fromJson<int>(json['idPenulis']),
      idKategori: serializer.fromJson<int>(json['idKategori']),
      harga: serializer.fromJson<int>(json['harga']),
      stok: serializer.fromJson<int>(json['stok']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idBuku': serializer.toJson<int>(idBuku),
      'idPenulis': serializer.toJson<int>(idPenulis),
      'idKategori': serializer.toJson<int>(idKategori),
      'harga': serializer.toJson<int>(harga),
      'stok': serializer.toJson<int>(stok),
    };
  }

  BukuDetailData copyWith({
    int? id,
    int? idBuku,
    int? idPenulis,
    int? idKategori,
    int? harga,
    int? stok,
  }) => BukuDetailData(
    id: id ?? this.id,
    idBuku: idBuku ?? this.idBuku,
    idPenulis: idPenulis ?? this.idPenulis,
    idKategori: idKategori ?? this.idKategori,
    harga: harga ?? this.harga,
    stok: stok ?? this.stok,
  );
  BukuDetailData copyWithCompanion(BukuDetailCompanion data) {
    return BukuDetailData(
      id: data.id.present ? data.id.value : this.id,
      idBuku: data.idBuku.present ? data.idBuku.value : this.idBuku,
      idPenulis: data.idPenulis.present ? data.idPenulis.value : this.idPenulis,
      idKategori: data.idKategori.present
          ? data.idKategori.value
          : this.idKategori,
      harga: data.harga.present ? data.harga.value : this.harga,
      stok: data.stok.present ? data.stok.value : this.stok,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BukuDetailData(')
          ..write('id: $id, ')
          ..write('idBuku: $idBuku, ')
          ..write('idPenulis: $idPenulis, ')
          ..write('idKategori: $idKategori, ')
          ..write('harga: $harga, ')
          ..write('stok: $stok')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, idBuku, idPenulis, idKategori, harga, stok);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BukuDetailData &&
          other.id == this.id &&
          other.idBuku == this.idBuku &&
          other.idPenulis == this.idPenulis &&
          other.idKategori == this.idKategori &&
          other.harga == this.harga &&
          other.stok == this.stok);
}

class BukuDetailCompanion extends UpdateCompanion<BukuDetailData> {
  final Value<int> id;
  final Value<int> idBuku;
  final Value<int> idPenulis;
  final Value<int> idKategori;
  final Value<int> harga;
  final Value<int> stok;
  const BukuDetailCompanion({
    this.id = const Value.absent(),
    this.idBuku = const Value.absent(),
    this.idPenulis = const Value.absent(),
    this.idKategori = const Value.absent(),
    this.harga = const Value.absent(),
    this.stok = const Value.absent(),
  });
  BukuDetailCompanion.insert({
    this.id = const Value.absent(),
    required int idBuku,
    required int idPenulis,
    required int idKategori,
    required int harga,
    required int stok,
  }) : idBuku = Value(idBuku),
       idPenulis = Value(idPenulis),
       idKategori = Value(idKategori),
       harga = Value(harga),
       stok = Value(stok);
  static Insertable<BukuDetailData> custom({
    Expression<int>? id,
    Expression<int>? idBuku,
    Expression<int>? idPenulis,
    Expression<int>? idKategori,
    Expression<int>? harga,
    Expression<int>? stok,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idBuku != null) 'id_buku': idBuku,
      if (idPenulis != null) 'id_penulis': idPenulis,
      if (idKategori != null) 'id_kategori': idKategori,
      if (harga != null) 'harga': harga,
      if (stok != null) 'stok': stok,
    });
  }

  BukuDetailCompanion copyWith({
    Value<int>? id,
    Value<int>? idBuku,
    Value<int>? idPenulis,
    Value<int>? idKategori,
    Value<int>? harga,
    Value<int>? stok,
  }) {
    return BukuDetailCompanion(
      id: id ?? this.id,
      idBuku: idBuku ?? this.idBuku,
      idPenulis: idPenulis ?? this.idPenulis,
      idKategori: idKategori ?? this.idKategori,
      harga: harga ?? this.harga,
      stok: stok ?? this.stok,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idBuku.present) {
      map['id_buku'] = Variable<int>(idBuku.value);
    }
    if (idPenulis.present) {
      map['id_penulis'] = Variable<int>(idPenulis.value);
    }
    if (idKategori.present) {
      map['id_kategori'] = Variable<int>(idKategori.value);
    }
    if (harga.present) {
      map['harga'] = Variable<int>(harga.value);
    }
    if (stok.present) {
      map['stok'] = Variable<int>(stok.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BukuDetailCompanion(')
          ..write('id: $id, ')
          ..write('idBuku: $idBuku, ')
          ..write('idPenulis: $idPenulis, ')
          ..write('idKategori: $idKategori, ')
          ..write('harga: $harga, ')
          ..write('stok: $stok')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BukuTable buku = $BukuTable(this);
  late final $PenulisTable penulis = $PenulisTable(this);
  late final $KategoriTable kategori = $KategoriTable(this);
  late final $BukuDetailTable bukuDetail = $BukuDetailTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    buku,
    penulis,
    kategori,
    bukuDetail,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'buku',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('penulis', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'buku',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('kategori', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'buku',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('buku_detail', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'penulis',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('buku_detail', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'kategori',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('buku_detail', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$BukuTableCreateCompanionBuilder =
    BukuCompanion Function({
      Value<int> id,
      required String judul,
      Value<String?> deskripsi,
    });
typedef $$BukuTableUpdateCompanionBuilder =
    BukuCompanion Function({
      Value<int> id,
      Value<String> judul,
      Value<String?> deskripsi,
    });

final class $$BukuTableReferences
    extends BaseReferences<_$AppDatabase, $BukuTable, BukuData> {
  $$BukuTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PenulisTable, List<Penuli>> _penulisRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.penulis,
    aliasName: $_aliasNameGenerator(db.buku.id, db.penulis.bukuId),
  );

  $$PenulisTableProcessedTableManager get penulisRefs {
    final manager = $$PenulisTableTableManager(
      $_db,
      $_db.penulis,
    ).filter((f) => f.bukuId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_penulisRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$KategoriTable, List<KategoriData>>
  _kategoriRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.kategori,
    aliasName: $_aliasNameGenerator(db.buku.id, db.kategori.bukuId),
  );

  $$KategoriTableProcessedTableManager get kategoriRefs {
    final manager = $$KategoriTableTableManager(
      $_db,
      $_db.kategori,
    ).filter((f) => f.bukuId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_kategoriRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BukuDetailTable, List<BukuDetailData>>
  _bukuDetailRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bukuDetail,
    aliasName: $_aliasNameGenerator(db.buku.id, db.bukuDetail.idBuku),
  );

  $$BukuDetailTableProcessedTableManager get bukuDetailRefs {
    final manager = $$BukuDetailTableTableManager(
      $_db,
      $_db.bukuDetail,
    ).filter((f) => f.idBuku.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bukuDetailRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BukuTableFilterComposer extends Composer<_$AppDatabase, $BukuTable> {
  $$BukuTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deskripsi => $composableBuilder(
    column: $table.deskripsi,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> penulisRefs(
    Expression<bool> Function($$PenulisTableFilterComposer f) f,
  ) {
    final $$PenulisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.penulis,
      getReferencedColumn: (t) => t.bukuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PenulisTableFilterComposer(
            $db: $db,
            $table: $db.penulis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> kategoriRefs(
    Expression<bool> Function($$KategoriTableFilterComposer f) f,
  ) {
    final $$KategoriTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kategori,
      getReferencedColumn: (t) => t.bukuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KategoriTableFilterComposer(
            $db: $db,
            $table: $db.kategori,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> bukuDetailRefs(
    Expression<bool> Function($$BukuDetailTableFilterComposer f) f,
  ) {
    final $$BukuDetailTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bukuDetail,
      getReferencedColumn: (t) => t.idBuku,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuDetailTableFilterComposer(
            $db: $db,
            $table: $db.bukuDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BukuTableOrderingComposer extends Composer<_$AppDatabase, $BukuTable> {
  $$BukuTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deskripsi => $composableBuilder(
    column: $table.deskripsi,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BukuTableAnnotationComposer
    extends Composer<_$AppDatabase, $BukuTable> {
  $$BukuTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get judul =>
      $composableBuilder(column: $table.judul, builder: (column) => column);

  GeneratedColumn<String> get deskripsi =>
      $composableBuilder(column: $table.deskripsi, builder: (column) => column);

  Expression<T> penulisRefs<T extends Object>(
    Expression<T> Function($$PenulisTableAnnotationComposer a) f,
  ) {
    final $$PenulisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.penulis,
      getReferencedColumn: (t) => t.bukuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PenulisTableAnnotationComposer(
            $db: $db,
            $table: $db.penulis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> kategoriRefs<T extends Object>(
    Expression<T> Function($$KategoriTableAnnotationComposer a) f,
  ) {
    final $$KategoriTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.kategori,
      getReferencedColumn: (t) => t.bukuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KategoriTableAnnotationComposer(
            $db: $db,
            $table: $db.kategori,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> bukuDetailRefs<T extends Object>(
    Expression<T> Function($$BukuDetailTableAnnotationComposer a) f,
  ) {
    final $$BukuDetailTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bukuDetail,
      getReferencedColumn: (t) => t.idBuku,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuDetailTableAnnotationComposer(
            $db: $db,
            $table: $db.bukuDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BukuTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BukuTable,
          BukuData,
          $$BukuTableFilterComposer,
          $$BukuTableOrderingComposer,
          $$BukuTableAnnotationComposer,
          $$BukuTableCreateCompanionBuilder,
          $$BukuTableUpdateCompanionBuilder,
          (BukuData, $$BukuTableReferences),
          BukuData,
          PrefetchHooks Function({
            bool penulisRefs,
            bool kategoriRefs,
            bool bukuDetailRefs,
          })
        > {
  $$BukuTableTableManager(_$AppDatabase db, $BukuTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BukuTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BukuTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BukuTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> judul = const Value.absent(),
                Value<String?> deskripsi = const Value.absent(),
              }) => BukuCompanion(id: id, judul: judul, deskripsi: deskripsi),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String judul,
                Value<String?> deskripsi = const Value.absent(),
              }) => BukuCompanion.insert(
                id: id,
                judul: judul,
                deskripsi: deskripsi,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$BukuTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                penulisRefs = false,
                kategoriRefs = false,
                bukuDetailRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (penulisRefs) db.penulis,
                    if (kategoriRefs) db.kategori,
                    if (bukuDetailRefs) db.bukuDetail,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (penulisRefs)
                        await $_getPrefetchedData<BukuData, $BukuTable, Penuli>(
                          currentTable: table,
                          referencedTable: $$BukuTableReferences
                              ._penulisRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BukuTableReferences(db, table, p0).penulisRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bukuId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (kategoriRefs)
                        await $_getPrefetchedData<
                          BukuData,
                          $BukuTable,
                          KategoriData
                        >(
                          currentTable: table,
                          referencedTable: $$BukuTableReferences
                              ._kategoriRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BukuTableReferences(db, table, p0).kategoriRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bukuId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (bukuDetailRefs)
                        await $_getPrefetchedData<
                          BukuData,
                          $BukuTable,
                          BukuDetailData
                        >(
                          currentTable: table,
                          referencedTable: $$BukuTableReferences
                              ._bukuDetailRefsTable(db),
                          managerFromTypedResult: (p0) => $$BukuTableReferences(
                            db,
                            table,
                            p0,
                          ).bukuDetailRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.idBuku == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BukuTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BukuTable,
      BukuData,
      $$BukuTableFilterComposer,
      $$BukuTableOrderingComposer,
      $$BukuTableAnnotationComposer,
      $$BukuTableCreateCompanionBuilder,
      $$BukuTableUpdateCompanionBuilder,
      (BukuData, $$BukuTableReferences),
      BukuData,
      PrefetchHooks Function({
        bool penulisRefs,
        bool kategoriRefs,
        bool bukuDetailRefs,
      })
    >;
typedef $$PenulisTableCreateCompanionBuilder =
    PenulisCompanion Function({
      Value<int> id,
      required int bukuId,
      required String nama,
    });
typedef $$PenulisTableUpdateCompanionBuilder =
    PenulisCompanion Function({
      Value<int> id,
      Value<int> bukuId,
      Value<String> nama,
    });

final class $$PenulisTableReferences
    extends BaseReferences<_$AppDatabase, $PenulisTable, Penuli> {
  $$PenulisTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BukuTable _bukuIdTable(_$AppDatabase db) =>
      db.buku.createAlias($_aliasNameGenerator(db.penulis.bukuId, db.buku.id));

  $$BukuTableProcessedTableManager get bukuId {
    final $_column = $_itemColumn<int>('buku_id')!;

    final manager = $$BukuTableTableManager(
      $_db,
      $_db.buku,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bukuIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BukuDetailTable, List<BukuDetailData>>
  _bukuDetailRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bukuDetail,
    aliasName: $_aliasNameGenerator(db.penulis.id, db.bukuDetail.idPenulis),
  );

  $$BukuDetailTableProcessedTableManager get bukuDetailRefs {
    final manager = $$BukuDetailTableTableManager(
      $_db,
      $_db.bukuDetail,
    ).filter((f) => f.idPenulis.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bukuDetailRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PenulisTableFilterComposer
    extends Composer<_$AppDatabase, $PenulisTable> {
  $$PenulisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  $$BukuTableFilterComposer get bukuId {
    final $$BukuTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bukuId,
      referencedTable: $db.buku,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuTableFilterComposer(
            $db: $db,
            $table: $db.buku,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> bukuDetailRefs(
    Expression<bool> Function($$BukuDetailTableFilterComposer f) f,
  ) {
    final $$BukuDetailTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bukuDetail,
      getReferencedColumn: (t) => t.idPenulis,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuDetailTableFilterComposer(
            $db: $db,
            $table: $db.bukuDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PenulisTableOrderingComposer
    extends Composer<_$AppDatabase, $PenulisTable> {
  $$PenulisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  $$BukuTableOrderingComposer get bukuId {
    final $$BukuTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bukuId,
      referencedTable: $db.buku,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuTableOrderingComposer(
            $db: $db,
            $table: $db.buku,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PenulisTableAnnotationComposer
    extends Composer<_$AppDatabase, $PenulisTable> {
  $$PenulisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  $$BukuTableAnnotationComposer get bukuId {
    final $$BukuTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bukuId,
      referencedTable: $db.buku,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuTableAnnotationComposer(
            $db: $db,
            $table: $db.buku,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> bukuDetailRefs<T extends Object>(
    Expression<T> Function($$BukuDetailTableAnnotationComposer a) f,
  ) {
    final $$BukuDetailTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bukuDetail,
      getReferencedColumn: (t) => t.idPenulis,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuDetailTableAnnotationComposer(
            $db: $db,
            $table: $db.bukuDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PenulisTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PenulisTable,
          Penuli,
          $$PenulisTableFilterComposer,
          $$PenulisTableOrderingComposer,
          $$PenulisTableAnnotationComposer,
          $$PenulisTableCreateCompanionBuilder,
          $$PenulisTableUpdateCompanionBuilder,
          (Penuli, $$PenulisTableReferences),
          Penuli,
          PrefetchHooks Function({bool bukuId, bool bukuDetailRefs})
        > {
  $$PenulisTableTableManager(_$AppDatabase db, $PenulisTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PenulisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PenulisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PenulisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bukuId = const Value.absent(),
                Value<String> nama = const Value.absent(),
              }) => PenulisCompanion(id: id, bukuId: bukuId, nama: nama),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bukuId,
                required String nama,
              }) => PenulisCompanion.insert(id: id, bukuId: bukuId, nama: nama),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PenulisTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bukuId = false, bukuDetailRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (bukuDetailRefs) db.bukuDetail],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bukuId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bukuId,
                                referencedTable: $$PenulisTableReferences
                                    ._bukuIdTable(db),
                                referencedColumn: $$PenulisTableReferences
                                    ._bukuIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bukuDetailRefs)
                    await $_getPrefetchedData<
                      Penuli,
                      $PenulisTable,
                      BukuDetailData
                    >(
                      currentTable: table,
                      referencedTable: $$PenulisTableReferences
                          ._bukuDetailRefsTable(db),
                      managerFromTypedResult: (p0) => $$PenulisTableReferences(
                        db,
                        table,
                        p0,
                      ).bukuDetailRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.idPenulis == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PenulisTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PenulisTable,
      Penuli,
      $$PenulisTableFilterComposer,
      $$PenulisTableOrderingComposer,
      $$PenulisTableAnnotationComposer,
      $$PenulisTableCreateCompanionBuilder,
      $$PenulisTableUpdateCompanionBuilder,
      (Penuli, $$PenulisTableReferences),
      Penuli,
      PrefetchHooks Function({bool bukuId, bool bukuDetailRefs})
    >;
typedef $$KategoriTableCreateCompanionBuilder =
    KategoriCompanion Function({
      Value<int> id,
      required int bukuId,
      required String nama,
    });
typedef $$KategoriTableUpdateCompanionBuilder =
    KategoriCompanion Function({
      Value<int> id,
      Value<int> bukuId,
      Value<String> nama,
    });

final class $$KategoriTableReferences
    extends BaseReferences<_$AppDatabase, $KategoriTable, KategoriData> {
  $$KategoriTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BukuTable _bukuIdTable(_$AppDatabase db) =>
      db.buku.createAlias($_aliasNameGenerator(db.kategori.bukuId, db.buku.id));

  $$BukuTableProcessedTableManager get bukuId {
    final $_column = $_itemColumn<int>('buku_id')!;

    final manager = $$BukuTableTableManager(
      $_db,
      $_db.buku,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bukuIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$BukuDetailTable, List<BukuDetailData>>
  _bukuDetailRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bukuDetail,
    aliasName: $_aliasNameGenerator(db.kategori.id, db.bukuDetail.idKategori),
  );

  $$BukuDetailTableProcessedTableManager get bukuDetailRefs {
    final manager = $$BukuDetailTableTableManager(
      $_db,
      $_db.bukuDetail,
    ).filter((f) => f.idKategori.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bukuDetailRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$KategoriTableFilterComposer
    extends Composer<_$AppDatabase, $KategoriTable> {
  $$KategoriTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  $$BukuTableFilterComposer get bukuId {
    final $$BukuTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bukuId,
      referencedTable: $db.buku,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuTableFilterComposer(
            $db: $db,
            $table: $db.buku,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> bukuDetailRefs(
    Expression<bool> Function($$BukuDetailTableFilterComposer f) f,
  ) {
    final $$BukuDetailTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bukuDetail,
      getReferencedColumn: (t) => t.idKategori,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuDetailTableFilterComposer(
            $db: $db,
            $table: $db.bukuDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$KategoriTableOrderingComposer
    extends Composer<_$AppDatabase, $KategoriTable> {
  $$KategoriTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  $$BukuTableOrderingComposer get bukuId {
    final $$BukuTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bukuId,
      referencedTable: $db.buku,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuTableOrderingComposer(
            $db: $db,
            $table: $db.buku,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$KategoriTableAnnotationComposer
    extends Composer<_$AppDatabase, $KategoriTable> {
  $$KategoriTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  $$BukuTableAnnotationComposer get bukuId {
    final $$BukuTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bukuId,
      referencedTable: $db.buku,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuTableAnnotationComposer(
            $db: $db,
            $table: $db.buku,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> bukuDetailRefs<T extends Object>(
    Expression<T> Function($$BukuDetailTableAnnotationComposer a) f,
  ) {
    final $$BukuDetailTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bukuDetail,
      getReferencedColumn: (t) => t.idKategori,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuDetailTableAnnotationComposer(
            $db: $db,
            $table: $db.bukuDetail,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$KategoriTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KategoriTable,
          KategoriData,
          $$KategoriTableFilterComposer,
          $$KategoriTableOrderingComposer,
          $$KategoriTableAnnotationComposer,
          $$KategoriTableCreateCompanionBuilder,
          $$KategoriTableUpdateCompanionBuilder,
          (KategoriData, $$KategoriTableReferences),
          KategoriData,
          PrefetchHooks Function({bool bukuId, bool bukuDetailRefs})
        > {
  $$KategoriTableTableManager(_$AppDatabase db, $KategoriTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KategoriTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KategoriTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KategoriTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bukuId = const Value.absent(),
                Value<String> nama = const Value.absent(),
              }) => KategoriCompanion(id: id, bukuId: bukuId, nama: nama),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bukuId,
                required String nama,
              }) =>
                  KategoriCompanion.insert(id: id, bukuId: bukuId, nama: nama),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$KategoriTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bukuId = false, bukuDetailRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (bukuDetailRefs) db.bukuDetail],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bukuId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bukuId,
                                referencedTable: $$KategoriTableReferences
                                    ._bukuIdTable(db),
                                referencedColumn: $$KategoriTableReferences
                                    ._bukuIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bukuDetailRefs)
                    await $_getPrefetchedData<
                      KategoriData,
                      $KategoriTable,
                      BukuDetailData
                    >(
                      currentTable: table,
                      referencedTable: $$KategoriTableReferences
                          ._bukuDetailRefsTable(db),
                      managerFromTypedResult: (p0) => $$KategoriTableReferences(
                        db,
                        table,
                        p0,
                      ).bukuDetailRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.idKategori == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$KategoriTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KategoriTable,
      KategoriData,
      $$KategoriTableFilterComposer,
      $$KategoriTableOrderingComposer,
      $$KategoriTableAnnotationComposer,
      $$KategoriTableCreateCompanionBuilder,
      $$KategoriTableUpdateCompanionBuilder,
      (KategoriData, $$KategoriTableReferences),
      KategoriData,
      PrefetchHooks Function({bool bukuId, bool bukuDetailRefs})
    >;
typedef $$BukuDetailTableCreateCompanionBuilder =
    BukuDetailCompanion Function({
      Value<int> id,
      required int idBuku,
      required int idPenulis,
      required int idKategori,
      required int harga,
      required int stok,
    });
typedef $$BukuDetailTableUpdateCompanionBuilder =
    BukuDetailCompanion Function({
      Value<int> id,
      Value<int> idBuku,
      Value<int> idPenulis,
      Value<int> idKategori,
      Value<int> harga,
      Value<int> stok,
    });

final class $$BukuDetailTableReferences
    extends BaseReferences<_$AppDatabase, $BukuDetailTable, BukuDetailData> {
  $$BukuDetailTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BukuTable _idBukuTable(_$AppDatabase db) => db.buku.createAlias(
    $_aliasNameGenerator(db.bukuDetail.idBuku, db.buku.id),
  );

  $$BukuTableProcessedTableManager get idBuku {
    final $_column = $_itemColumn<int>('id_buku')!;

    final manager = $$BukuTableTableManager(
      $_db,
      $_db.buku,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idBukuTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PenulisTable _idPenulisTable(_$AppDatabase db) =>
      db.penulis.createAlias(
        $_aliasNameGenerator(db.bukuDetail.idPenulis, db.penulis.id),
      );

  $$PenulisTableProcessedTableManager get idPenulis {
    final $_column = $_itemColumn<int>('id_penulis')!;

    final manager = $$PenulisTableTableManager(
      $_db,
      $_db.penulis,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idPenulisTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $KategoriTable _idKategoriTable(_$AppDatabase db) =>
      db.kategori.createAlias(
        $_aliasNameGenerator(db.bukuDetail.idKategori, db.kategori.id),
      );

  $$KategoriTableProcessedTableManager get idKategori {
    final $_column = $_itemColumn<int>('id_kategori')!;

    final manager = $$KategoriTableTableManager(
      $_db,
      $_db.kategori,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_idKategoriTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BukuDetailTableFilterComposer
    extends Composer<_$AppDatabase, $BukuDetailTable> {
  $$BukuDetailTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get harga => $composableBuilder(
    column: $table.harga,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stok => $composableBuilder(
    column: $table.stok,
    builder: (column) => ColumnFilters(column),
  );

  $$BukuTableFilterComposer get idBuku {
    final $$BukuTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idBuku,
      referencedTable: $db.buku,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuTableFilterComposer(
            $db: $db,
            $table: $db.buku,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PenulisTableFilterComposer get idPenulis {
    final $$PenulisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idPenulis,
      referencedTable: $db.penulis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PenulisTableFilterComposer(
            $db: $db,
            $table: $db.penulis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KategoriTableFilterComposer get idKategori {
    final $$KategoriTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idKategori,
      referencedTable: $db.kategori,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KategoriTableFilterComposer(
            $db: $db,
            $table: $db.kategori,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BukuDetailTableOrderingComposer
    extends Composer<_$AppDatabase, $BukuDetailTable> {
  $$BukuDetailTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get harga => $composableBuilder(
    column: $table.harga,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stok => $composableBuilder(
    column: $table.stok,
    builder: (column) => ColumnOrderings(column),
  );

  $$BukuTableOrderingComposer get idBuku {
    final $$BukuTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idBuku,
      referencedTable: $db.buku,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuTableOrderingComposer(
            $db: $db,
            $table: $db.buku,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PenulisTableOrderingComposer get idPenulis {
    final $$PenulisTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idPenulis,
      referencedTable: $db.penulis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PenulisTableOrderingComposer(
            $db: $db,
            $table: $db.penulis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KategoriTableOrderingComposer get idKategori {
    final $$KategoriTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idKategori,
      referencedTable: $db.kategori,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KategoriTableOrderingComposer(
            $db: $db,
            $table: $db.kategori,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BukuDetailTableAnnotationComposer
    extends Composer<_$AppDatabase, $BukuDetailTable> {
  $$BukuDetailTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get harga =>
      $composableBuilder(column: $table.harga, builder: (column) => column);

  GeneratedColumn<int> get stok =>
      $composableBuilder(column: $table.stok, builder: (column) => column);

  $$BukuTableAnnotationComposer get idBuku {
    final $$BukuTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idBuku,
      referencedTable: $db.buku,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BukuTableAnnotationComposer(
            $db: $db,
            $table: $db.buku,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PenulisTableAnnotationComposer get idPenulis {
    final $$PenulisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idPenulis,
      referencedTable: $db.penulis,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PenulisTableAnnotationComposer(
            $db: $db,
            $table: $db.penulis,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$KategoriTableAnnotationComposer get idKategori {
    final $$KategoriTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idKategori,
      referencedTable: $db.kategori,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$KategoriTableAnnotationComposer(
            $db: $db,
            $table: $db.kategori,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BukuDetailTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BukuDetailTable,
          BukuDetailData,
          $$BukuDetailTableFilterComposer,
          $$BukuDetailTableOrderingComposer,
          $$BukuDetailTableAnnotationComposer,
          $$BukuDetailTableCreateCompanionBuilder,
          $$BukuDetailTableUpdateCompanionBuilder,
          (BukuDetailData, $$BukuDetailTableReferences),
          BukuDetailData,
          PrefetchHooks Function({bool idBuku, bool idPenulis, bool idKategori})
        > {
  $$BukuDetailTableTableManager(_$AppDatabase db, $BukuDetailTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BukuDetailTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BukuDetailTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BukuDetailTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> idBuku = const Value.absent(),
                Value<int> idPenulis = const Value.absent(),
                Value<int> idKategori = const Value.absent(),
                Value<int> harga = const Value.absent(),
                Value<int> stok = const Value.absent(),
              }) => BukuDetailCompanion(
                id: id,
                idBuku: idBuku,
                idPenulis: idPenulis,
                idKategori: idKategori,
                harga: harga,
                stok: stok,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int idBuku,
                required int idPenulis,
                required int idKategori,
                required int harga,
                required int stok,
              }) => BukuDetailCompanion.insert(
                id: id,
                idBuku: idBuku,
                idPenulis: idPenulis,
                idKategori: idKategori,
                harga: harga,
                stok: stok,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BukuDetailTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({idBuku = false, idPenulis = false, idKategori = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (idBuku) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.idBuku,
                                    referencedTable: $$BukuDetailTableReferences
                                        ._idBukuTable(db),
                                    referencedColumn:
                                        $$BukuDetailTableReferences
                                            ._idBukuTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (idPenulis) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.idPenulis,
                                    referencedTable: $$BukuDetailTableReferences
                                        ._idPenulisTable(db),
                                    referencedColumn:
                                        $$BukuDetailTableReferences
                                            ._idPenulisTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (idKategori) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.idKategori,
                                    referencedTable: $$BukuDetailTableReferences
                                        ._idKategoriTable(db),
                                    referencedColumn:
                                        $$BukuDetailTableReferences
                                            ._idKategoriTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$BukuDetailTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BukuDetailTable,
      BukuDetailData,
      $$BukuDetailTableFilterComposer,
      $$BukuDetailTableOrderingComposer,
      $$BukuDetailTableAnnotationComposer,
      $$BukuDetailTableCreateCompanionBuilder,
      $$BukuDetailTableUpdateCompanionBuilder,
      (BukuDetailData, $$BukuDetailTableReferences),
      BukuDetailData,
      PrefetchHooks Function({bool idBuku, bool idPenulis, bool idKategori})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BukuTableTableManager get buku => $$BukuTableTableManager(_db, _db.buku);
  $$PenulisTableTableManager get penulis =>
      $$PenulisTableTableManager(_db, _db.penulis);
  $$KategoriTableTableManager get kategori =>
      $$KategoriTableTableManager(_db, _db.kategori);
  $$BukuDetailTableTableManager get bukuDetail =>
      $$BukuDetailTableTableManager(_db, _db.bukuDetail);
}

mixin _$BukuDaoMixin on DatabaseAccessor<AppDatabase> {
  $BukuTable get buku => attachedDatabase.buku;
  $PenulisTable get penulis => attachedDatabase.penulis;
  $KategoriTable get kategori => attachedDatabase.kategori;
  $BukuDetailTable get bukuDetail => attachedDatabase.bukuDetail;
}
