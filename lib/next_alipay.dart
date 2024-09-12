import 'next_alipay_platform_interface.dart';

class NextAlipay {
  Future<String?> startPay(String orderInfo, bool withLoading) async =>
      NextAlipayPlatform.instance.startPay(orderInfo, withLoading);
}
