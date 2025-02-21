import 'package:flutter_test/flutter_test.dart';
import 'package:esmaulhusna/esmaulhusna.dart';
import 'package:esmaulhusna/esmaulhusna_platform_interface.dart';
import 'package:esmaulhusna/esmaulhusna_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEsmaulhusnaPlatform
    with MockPlatformInterfaceMixin
    implements EsmaulhusnaPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final EsmaulhusnaPlatform initialPlatform = EsmaulhusnaPlatform.instance;

  test('$MethodChannelEsmaulhusna is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEsmaulhusna>());
  });

  test('getPlatformVersion', () async {
    Esmaulhusna esmaulhusnaPlugin = Esmaulhusna();
    MockEsmaulhusnaPlatform fakePlatform = MockEsmaulhusnaPlatform();
    EsmaulhusnaPlatform.instance = fakePlatform;

    expect(await esmaulhusnaPlugin.getPlatformVersion(), '42');
  });
}
