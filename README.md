# Flutter NFC Reader

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/NFC_logo.svg/2000px-NFC_logo.svg.png" alt="NFC" width="250"/>

A new flutter plugin to help developers looking to use internal hardware inside Android devices (For now, iOS coming soon) for reading NFC tags.

It starts a reading session that keeps scanning tags until it is manually turned off.
You can trigger the stop event manually using a dedicated function.

## Supported NFC Format

|      Platform     |          Supported Tags/Cards         |
|:-----------------:|:-------------------------------------:|
| Android           | **NDEF:**,A, B, F, V, BARCODE, MIFARE |
| iOS (Coming Soon) | **NDEF:** NFC TYPE 1, 2, 3, 4, 5      |

## Installation

Add to pubspec.yaml:

```yaml
dependencies:
  nfc_io:
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

For better details look at the demo app.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
