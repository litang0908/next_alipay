import 'dart:async';

import 'package:flutter/material.dart';
import 'package:next_alipay/next_alipay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _nextAlipayPlugin = NextAlipay();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: startPayByAlipay,
              child: const Text("startPayByAlipay"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startPayByAlipay() async {
    await _nextAlipayPlugin.startPayByAlipay("orderInfo", true);
  }
}
