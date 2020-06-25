#import "ServiceManagerPlugin.h"
#if __has_include(<service_manager/service_manager-Swift.h>)
#import <service_manager/service_manager-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "service_manager-Swift.h"
#endif

@implementation ServiceManagerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftServiceManagerPlugin registerWithRegistrar:registrar];
}
@end
