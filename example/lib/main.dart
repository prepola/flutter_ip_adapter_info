import 'package:flutter/material.dart';

import 'package:flutter_ip_adapter_info/flutter_ip_adapter_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<IpAdapterInfo> adapterInfoList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_ip_adapter_info example app'),
        ),
        body: ListView.builder(
          itemBuilder: (context, i) {
            return Card(
              child: Text(adapterInfoList[i].toString()),
            );
          },
          itemCount: adapterInfoList.length,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () async {
            final List<IpAdapterInfo> newAdapterInfoList =
                await FlutterIpAdapterInfo.getIpAdapterInfo();
            setState(
              () {
                adapterInfoList = newAdapterInfoList;
              },
            );
          },
        ),
      ),
    );
  }
}
