import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:esmaulhusna/esmaulhusna_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelEsmaulhusna platform = MethodChannelEsmaulhusna();
  const MethodChannel channel = MethodChannel('esmaulhusna');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
