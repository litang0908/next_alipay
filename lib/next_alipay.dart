import 'next_alipay_platform_interface.dart';

class NextAlipay {
  Future<String?> getPlatformVersion() {
    return NextAlipayPlatform.instance.getPlatformVersion();
  }

  Future<String?> startPayByAlipay(String orderInfo, bool withLoading) async =>
      NextAlipayPlatform.instance.startPayByAlipay(orderInfo, withLoading);
}
