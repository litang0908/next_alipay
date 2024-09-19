# next_alipay

实现在 Harmony NEXT 运行的 Flutter 项目实现支付宝购买逻辑。

## 参考文档

- [支付宝开发文档](https://opendocs.alipay.com/open/204/105051?pathHash=b91b9616&ref=api)
- [支付宝 NEXT 版 SDK 地址](https://ohpm.openharmony.cn/#/cn/detail/@cashier_alipay%2Fcashiersdk)

##注意

- 目前仅实现了 `new Pay().pay(orderInfo, withLoading)` 方法的桥接，其他方法暂未实现。
- 此插件仅仅是实现了在 NEXT 原生端调用支付宝完成支付，所需的 orderInfo 需要从 Flutter 层传递过来。
- 支付宝服务端逻辑请参考支付宝官方文档。
- 目前对接**支付宝 NEXT 版 SDK**版本为 **V15.8.26**

## 实现流程

1. Flutter 代码中从服务器获取 orderInfo
2. Flutter 项目引入 next_alipay 插件
   ```yaml
    dependencies:
      next_alipay:
         git:
            url: https://github.com/litang0908/next_alipay.git
   ```
3. 调用下面方法发起原生支付请求

```dart
import 'package:next_alipay/next_alipay.dart';

Future<void> _startAlipay() async {
  //请自行实现生成 orderInfo 的逻辑，建议通过服务器来生成
  var orderInfo = ''; //await getOrderInfo();
  final nextAlipayPlugin = NextAlipay();
  var payResult = await nextAlipayPlugin.startPay(orderInfo, true);
  if (payResult?.isNotEmpty ?? false) {
    var payResultJson = jsonDecode(payResult!);
    var resultCode = payResultJson['resultStatus'] ?? '';
    if (resultCode == '9000') {
      //支付成功
      // 刷新用户信息
    } else if (resultCode == '6001') {
      //支付取消
    } else {
      //支付失败
    }
  }
}
```

4. 支付完成后，支付宝会回调到原生层，原生层再通过 EventChannel 传递给 Flutter 层，Flutter 层再处理支付结果。
5. 如果 `payResultJson['resultStatus'] == '9000'`代表支付成功。
6. 如果支付不成功，请从 `payResultJson['resultStatus']` 中获取错误码，具体错误码请参考支付宝官方文档 [常见API错误码大全](https://opendocs.alipay.com/support/01rb2q) 


