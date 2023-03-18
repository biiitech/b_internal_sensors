#import "FlutterSensorControllerPlugin.h"
#if __has_include(<flutter_sensor_controller/flutter_sensor_controller-Swift.h>)
#import <flutter_sensor_controller/flutter_sensor_controller-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_sensor_controller-Swift.h"
#endif

@implementation FlutterSensorControllerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterSensorControllerPlugin registerWithRegistrar:registrar];
}
@end
