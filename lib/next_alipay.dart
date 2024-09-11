
import 'next_alipay_platform_interface.dart';

class NextAlipay {
  Future<String?> getPlatformVersion() {
    return NextAlipayPlatform.instance.getPlatformVersion();
  }
}
