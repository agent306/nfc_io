# Flutter NFC Reader

<img src="http://pluspng.com/img-png/nfc-png-g-technology-2269.png" alt="NFC" width="250"/>

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

and then run the shell command

```shell
flutter packages get
```

import the plugin to your project:

```dart
import 'package:nfc_io/nfc_io.dart';
```

## How to use

### Android setup

Add these two lines to your `AndroidManifest.xml` on the top

```xml
<uses-permission android:name="android.permission.NFC" />
<uses-feature android:name="android.hardware.nfc"/>
```

### iOS setup

Coming soon...

### Read NFC

This function will return a stream, the read session will be kept open until otherwise closed.
The stream will return a `NfcData` model whenever an NFC tag/card is detected. This model contains:

```json
{
    "id": "Id of the tag",
    "content": "Content of the tag (Blank if not an NDEF)",
    "error": "If any error occurs, null otherwise",
    "status": "Either none, reading, read, stopped or error"
}
```

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
