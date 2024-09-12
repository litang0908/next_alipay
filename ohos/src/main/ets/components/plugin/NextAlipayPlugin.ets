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
    if (call.method == "startPay") {
      // orderInfo 由服务端生成
      // 第二个参数 控制是否展示支付宝loading
      let orderInfo: string = call.argument("orderInfo");
      let withLoading: boolean = call.argument("withLoading");
      console.log(`startPay： 发起支付宝支付`);
      new Pay().pay(orderInfo, withLoading).then((payResult) => {
        let message =
          `resultStatus: ${payResult.get('resultStatus')} memo: ${payResult.get('memo')} result:${payResult.get('result')}`;
        console.log(message);

        //maybe null or not a json
        let resultJson: Record<string, string | undefined> | string | null = null;
        try {
          resultJson = JSON.parse(payResult.get('result') || '');
        } catch (error) {
          console.error("Invalid JSON", error);
        }
        let jsonData: AlipayResult = {
          resultStatus: payResult.get('resultStatus') || '',
          memo: payResult.get('memo') || '',
          result: resultJson,
        };
        result.success(JSON.stringify(jsonData))
      }).catch((error: BusinessError) => {
        console.log(`支付宝支付 error:${error.message}`);
        console.log(error.message);
        //出现异常则告诉 flutter 端
        let jsonData: AlipayResult = {
          resultStatus: '-1',
          memo: null,
          result: null,
        };
        result.success(JSON.stringify(jsonData))
      });
    } else {
      result.notImplemented()
    }
  }
}