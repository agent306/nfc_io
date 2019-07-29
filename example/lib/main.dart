import 'dart:async';
import 'package:flutter/material.dart';

import 'package:nfc_io/nfc_io.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isReading = false;
  NfcData data;
  StreamSubscription _subscription;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('NFC IO example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Status: ${data?.status ?? "Not ready yet"}'),
              Text('Card ID: ${data?.id ?? "Unavailable"}'),
              Text('Card Content: ${data?.content ?? "Unavailable"}'),
              SizedBox(
                height: 40,
              ),
              RawMaterialButton(
                child: Row(
                  children: <Widget>[
                    Icon(isReading ? Icons.stop : Icons.play_arrow),
                    SizedBox(width: 16,),
                    Text(isReading ? "Stop Scanning" : "Start Scanning"),
                  ],
                ),
                onPressed: () async {
                  if (!isReading) {
                    _subscription = NfcIo.startReading.listen((data) {
                      setState(() {
                        this.data = data;
                      });
                    });
                  } else {
                    if (_subscription != null) {
                      _subscription.cancel();
                      var result = await NfcIo.stopReading;
                      setState(() {
                        this.data = result;
                      });
                    }
                  }
                  setState(() {
                    isReading = !isReading;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
