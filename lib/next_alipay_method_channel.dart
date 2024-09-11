import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'next_alipay_platform_interface.dart';

/// An implementation of [NextAlipayPlatform] that uses method channels.
class MethodChannelNextAlipay extends NextAlipayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('next_alipay');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}