import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:next_alipay/next_alipay_method_channel.dart';

void main() {
  MethodChannelNextAlipay platform = MethodChannelNextAlipay();
  const MethodChannel channel = MethodChannel('next_alipay');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
