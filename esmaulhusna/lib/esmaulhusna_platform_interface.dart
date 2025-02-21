import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'esmaulhusna_method_channel.dart';

abstract class EsmaulhusnaPlatform extends PlatformInterface {
  /// Constructs a EsmaulhusnaPlatform.
  EsmaulhusnaPlatform() : super(token: _token);

  static final Object _token = Object();

  static EsmaulhusnaPlatform _instance = MethodChannelEsmaulhusna();

  /// The default instance of [EsmaulhusnaPlatform] to use.
  ///
  /// Defaults to [MethodChannelEsmaulhusna].
  static EsmaulhusnaPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EsmaulhusnaPlatform] when
  /// they register themselves.
  static set instance(EsmaulhusnaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
