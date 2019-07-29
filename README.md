# Flutter NFC Reader

![](http://pluspng.com/img-png/nfc-png-g-technology-2269.png)

A new flutter plugin to help developers looking to use internal hardware inside Android devices (For now, iOS coming soon) for reading NFC tags.

The system activate a pooling reading session that keeps scanning tags until it is manually turned off.
You can trigger the stop event manually using a dedicated function.

## Installation

Add to pubspec.yaml:

```yaml
dependencies:
  flutter_nfc_reader:
    git:
      url: git@github.com:agent306/nfc_io.git
      ref: master
```

and then run the shell

```shell
flutter packages get
```

last step import to the project:

```dart
import 'package:nfc_io/nfc_io.dart';
```

## How to use

### Android setup

Add those two lines to your `AndroidManifest.xml` on the top

```xml
<uses-permission android:name="android.permission.NFC" />
<uses-feature android:name="android.hardware.nfc"/>
```

### iOS setup

Coming soon...

### Read NFC

This function will return a promise when a read occurs, till that very moment the reading session is open.
The promise will return a `NfcData` model, this model contains:

- id > id of the tag
- content > content of the tag (Blank if not an NDEF)
- error > if any error occurs, null otherwise
- status > either none, reading, read, stopped or error

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

For better details look at the demo app.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
