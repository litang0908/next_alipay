import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'next_alipay_method_channel.dart';

abstract class NextAlipayPlatform extends PlatformInterface {
  /// Constructs a NextAlipayPlatform.
  NextAlipayPlatform() : super(token: _token);

  static final Object _token = Object();

  static NextAlipayPlatform _instance = MethodChannelNextAlipay();

  /// The default instance of [NextAlipayPlatform] to use.
  ///
  /// Defaults to [MethodChannelNextAlipay].
  static NextAlipayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [NextAlipayPlatform] when
  /// they register themselves.
  static set instance(NextAlipayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
