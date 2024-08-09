import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:core_plugin/core_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _corePlugin = CorePlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _corePlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _getVersion();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _getDeviceId();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async{
                await _corePlugin.complianceInit();
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blue,
                child: const Text('同意'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async{
                await _corePlugin.activeInit();
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.pink,
                child: const Text('主动'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async{
                await _corePlugin.setProtocol(false);
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blueGrey,
                child: const Text('设置'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 获取version，给_version赋值
  void _getVersion() async {
    String? version = await _corePlugin.getAppVersionName();
    debugPrint("版本号+——+——+——+——+——+——+——+——+——${version!}");
  }

  /// 获取version，给_version赋值
  void _getDeviceId() async {
    String? version = await _corePlugin.getDeviceId();
    debugPrint("设备标识+——+——+——+——+——+——+——+——+——${version!}");
  }
}
