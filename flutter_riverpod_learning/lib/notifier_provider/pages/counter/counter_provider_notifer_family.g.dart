// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_provider_notifer_family.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$counterFamilyGenHash() => r'499cca0c8939116bf8363df3cd72d0d6d3b1a925';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CounterFamilyGen extends BuildlessAutoDisposeNotifier<int> {
  late final int initialValue;

  int build(int initialValue);
}

/// See also [CounterFamilyGen].
@ProviderFor(CounterFamilyGen)
const counterFamilyGenProvider = CounterFamilyGenFamily();

/// See also [CounterFamilyGen].
class CounterFamilyGenFamily extends Family<int> {
  /// See also [CounterFamilyGen].
  const CounterFamilyGenFamily();

  /// See also [CounterFamilyGen].
  CounterFamilyGenProvider call(int initialValue) {
    return CounterFamilyGenProvider(initialValue);
  }

  @override
  CounterFamilyGenProvider getProviderOverride(
    covariant CounterFamilyGenProvider provider,
  ) {
    return call(provider.initialValue);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'counterFamilyGenProvider';
}

/// See also [CounterFamilyGen].
class CounterFamilyGenProvider
    extends AutoDisposeNotifierProviderImpl<CounterFamilyGen, int> {
  /// See also [CounterFamilyGen].
  CounterFamilyGenProvider(int initialValue)
    : this._internal(
        () => CounterFamilyGen()..initialValue = initialValue,
        from: counterFamilyGenProvider,
        name: r'counterFamilyGenProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$counterFamilyGenHash,
        dependencies: CounterFamilyGenFamily._dependencies,
        allTransitiveDependencies:
            CounterFamilyGenFamily._allTransitiveDependencies,
        initialValue: initialValue,
      );

  CounterFamilyGenProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.initialValue,
  }) : super.internal();

  final int initialValue;

  @override
  int runNotifierBuild(covariant CounterFamilyGen notifier) {
    return notifier.build(initialValue);
  }

  @override
  Override overrideWith(CounterFamilyGen Function() create) {
    return ProviderOverride(
      origin: this,
      override: CounterFamilyGenProvider._internal(
        () => create()..initialValue = initialValue,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        initialValue: initialValue,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CounterFamilyGen, int> createElement() {
    return _CounterFamilyGenProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CounterFamilyGenProvider &&
        other.initialValue == initialValue;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initialValue.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CounterFamilyGenRef on AutoDisposeNotifierProviderRef<int> {
  /// The parameter `initialValue` of this provider.
  int get initialValue;
}

class _CounterFamilyGenProviderElement
    extends AutoDisposeNotifierProviderElement<CounterFamilyGen, int>
    with CounterFamilyGenRef {
  _CounterFamilyGenProviderElement(super.provider);

  @override
  int get initialValue => (origin as CounterFamilyGenProvider).initialValue;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
