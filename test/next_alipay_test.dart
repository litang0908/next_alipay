import 'package:flutter_test/flutter_test.dart';
import 'package:next_alipay/next_alipay.dart';
import 'package:next_alipay/next_alipay_platform_interface.dart';
import 'package:next_alipay/next_alipay_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockNextAlipayPlatform
    with MockPlatformInterfaceMixin
    implements NextAlipayPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final NextAlipayPlatform initialPlatform = NextAlipayPlatform.instance;

  test('$MethodChannelNextAlipay is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelNextAlipay>());
  });

  test('getPlatformVersion', () async {
    NextAlipay nextAlipayPlugin = NextAlipay();
    MockNextAlipayPlatform fakePlatform = MockNextAlipayPlatform();
    NextAlipayPlatform.instance = fakePlatform;

    expect(await nextAlipayPlugin.getPlatformVersion(), '42');
  });
}
