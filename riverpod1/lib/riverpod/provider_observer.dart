import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  /// Provider 변경시 호출
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print(
      '[Provider Updated] provider: $provider / pv: $previousValue / nv: $newValue',
    );
  }

  /// Provider 추가시 호출
  @override
  void didAddProvider(
    ProviderBase provider,
    Object? value,
    ProviderContainer container,
  ) {
    print(
      '[Provider Added] provider: $provider / value: $value',
    );
  }

  /// Provider 삭제시 호출
  @override
  void didDisposeProvider(
    ProviderBase provider,
    ProviderContainer containers,
  ) {
    print(
      '[Provider Disposed] provider: $provider',
    );
  }
}
