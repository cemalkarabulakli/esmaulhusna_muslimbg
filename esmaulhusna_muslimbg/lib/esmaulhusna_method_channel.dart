import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'esmaulhusna_platform_interface.dart';

/// An implementation of [EsmaulhusnaPlatform] that uses method channels.
class MethodChannelEsmaulhusna extends EsmaulhusnaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('esmaulhusna_muslimbg');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
