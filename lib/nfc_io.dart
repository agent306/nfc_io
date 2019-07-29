import 'dart:async';

import 'package:flutter/services.dart';

enum NFCStatus {
  none,
  reading,
  read,
  stopped,
  error,
}

class NfcData {
  final String id;
  final String content;
  final String error;
  final String statusMapper;

  NFCStatus status;

  NfcData({
    this.id,
    this.content,
    this.error,
    this.statusMapper,
  });

  @override
  String toString() {
    return "{id: $id, content: $content, error: $error, status: $status}";
  }

  factory NfcData.fromMap(Map data) {
    NfcData result = NfcData(
      id: data['nfcId'],
      content: data['nfcContent'],
      error: data['nfcError'],
      statusMapper: data['nfcStatus'],
    );
    switch (result.statusMapper) {
      case 'none':
        result.status = NFCStatus.none;
        break;
      case 'read':
        result.status = NFCStatus.read;
        break;
      case 'reading':
        result.status = NFCStatus.reading;
        break;
      case 'stopped':
        result.status = NFCStatus.stopped;
        break;
      case 'error':
        result.status = NFCStatus.error;
        break;
      default:
        result.status = NFCStatus.none;
    }
    return result;
  }
}

class NfcIo {
  static const MethodChannel _channel = const MethodChannel('nfc_io');
  static const stream = const EventChannel('mv.fr.nfc_io.nfc_io');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Stream<NfcData> get startReading {
    final resultStream = _channel
        .invokeMethod('startReading')
        .asStream()
        .asyncExpand((_) => stream
            .receiveBroadcastStream()
            .map((result) => NfcData.fromMap(result)));

    return resultStream;
  }

  static Future<NfcData> get stopReading async {
    final Map data = await _channel.invokeMethod('stopReading');
    return NfcData.fromMap(data);
  }
}
