# Flutter NFC Reader Example

### Read NFC

This function will return a stream, the read session will be kept open until otherwise closed.
The stream will return a `NfcData` model whenever an NFC tag/card is detected. This model contains:

|  Field  |                  Description                 |
|:-------:|:--------------------------------------------:|
| id      | Id of the tag                                |
| content | Content of the tag (Blank if not an NDEF)    |
| error   | If any error occurs, null otherwise          |
| status  | Either none, reading, read, stopped or error |

```dart
Future<void> startNFC() async {
    StreamSubscription _subscription = NfcIo.startReading.listen((NfcData data) {
        print(data);
    });
}
```

### Stop NFC

```dart
Future<void> stopNFC() async {
    if (_subscription != null) {
        _subscription.cancel();
        NfcData result = await NfcIo.stopReading;
        print(result);
    }
}
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
