// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actors_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$actorsHash() => r'086a4953036397c804140d6b78bf65095683d503';

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

/// See also [actors].
@ProviderFor(actors)
const actorsProvider = ActorsFamily();

/// See also [actors].
class ActorsFamily extends Family<AsyncValue<List<Actor>>> {
  /// See also [actors].
  const ActorsFamily();

  /// See also [actors].
  ActorsProvider call({
    required int movieId,
  }) {
    return ActorsProvider(
      movieId: movieId,
    );
  }

  @override
  ActorsProvider getProviderOverride(
    covariant ActorsProvider provider,
  ) {
    return call(
      movieId: provider.movieId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'actorsProvider';
}

/// See also [actors].
class ActorsProvider extends AutoDisposeFutureProvider<List<Actor>> {
  /// See also [actors].
  ActorsProvider({
    required int movieId,
  }) : this._internal(
          (ref) => actors(
            ref as ActorsRef,
            movieId: movieId,
          ),
          from: actorsProvider,
          name: r'actorsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$actorsHash,
          dependencies: ActorsFamily._dependencies,
          allTransitiveDependencies: ActorsFamily._allTransitiveDependencies,
          movieId: movieId,
        );

  ActorsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.movieId,
  }) : super.internal();

  final int movieId;

  @override
  Override overrideWith(
    FutureOr<List<Actor>> Function(ActorsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActorsProvider._internal(
        (ref) => create(ref as ActorsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        movieId: movieId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Actor>> createElement() {
    return _ActorsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActorsProvider && other.movieId == movieId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ActorsRef on AutoDisposeFutureProviderRef<List<Actor>> {
  /// The parameter `movieId` of this provider.
  int get movieId;
}

class _ActorsProviderElement
    extends AutoDisposeFutureProviderElement<List<Actor>> with ActorsRef {
  _ActorsProviderElement(super.provider);

  @override
  int get movieId => (origin as ActorsProvider).movieId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
