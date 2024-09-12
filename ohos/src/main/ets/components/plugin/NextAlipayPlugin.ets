import { Pay } from '@cashier_alipay/cashiersdk'
import { BusinessError } from '@kit.BasicServicesKit'
import { AlipayResult } from './AlipayResult'

import {
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';

/** NextAlipayPlugin **/
export default class NextAlipayPlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;

  constructor() {
  }

  getUniqueClassName(): string {
    return "NextAlipayPlugin"
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), "next_alipay");
    this.channel.setMethodCallHandler(this)
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null)
    }
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (call.method == "getPlatformVersion") {
      result.success("OpenHarmony ^ ^ ")
    } else if (call.method == "startPayByAlipay") {
      // orderInfo 由服务端生成
      // 第二个参数 控制是否展示支付宝loading
      let orderInfo: string = call.argument("orderInfo");
      let withLoading: boolean = call.argument("withLoading");
      // console.log(`startPayByAlipay： 发起支付宝支付 ${orderInfo}`);
      new Pay().pay(orderInfo, withLoading).then((payResult) => {
        // let message =
        //   `resultStatus: ${payResult.get('resultStatus')} memo: ${payResult.get('memo')} result:${payResult.get('result')}`;
        // console.log(message);

        let jsonData: AlipayResult = {
          resultStatus: payResult.get('resultStatus') || '',
          memo: payResult.get('memo') || '',
          result: JSON.parse(payResult.get('result') || ''),
        };
        result.success(JSON.stringify(jsonData))
      }).catch((error: BusinessError) => {
        console.log(error.message);
      });
    } else {
      result.notImplemented()
    }
  }
}