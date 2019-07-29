#import "NfcIoPlugin.h"
#import <nfc_io/nfc_io-Swift.h>

@implementation NfcIoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNfcIoPlugin registerWithRegistrar:registrar];
}
@end
