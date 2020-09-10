import Flutter
import UIKit

public class SwiftServiceManagerPlugin: NSObject, FlutterPlugin {
    
    var serviceManager = ServiceManager();
    var bluetoothStateStreamHandler = BluetoothStateStreamHandler();
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let instance = SwiftServiceManagerPlugin()
        
        let methodChannel = FlutterMethodChannel(name: "flutter.baseflow.com/service_manager/methods", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
        
        let bluetoothStateChannel = FlutterEventChannel(name: "flutter.baseflow.com/service_manager/state/bluetooth", binaryMessenger: registrar.messenger())
        bluetoothStateChannel.setStreamHandler(instance.bluetoothStateStreamHandler);
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "isBluetoothEnabled":
            result(self.serviceManager.isBluetoothEnabled());
        default:
            result(FlutterMethodNotImplemented)
        }
    }

}
