#import "CustomKeyboardPlugin.h"
#if __has_include(<custom_keyboard/custom_keyboard-Swift.h>)
#import <custom_keyboard/custom_keyboard-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "custom_keyboard-Swift.h"
#endif

@implementation CustomKeyboardPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCustomKeyboardPlugin registerWithRegistrar:registrar];
}
@end
