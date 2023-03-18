#import "BInternalSensorsPlugin.h"
#if __has_include(<b_internal_sensors/b_internal_sensors-Swift.h>)
#import <b_internal_sensors/b_internal_sensors-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "b_internal_sensors-Swift.h"
#endif

@implementation BInternalSensorsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBInternalSensorsPlugin registerWithRegistrar:registrar];
}
@end
