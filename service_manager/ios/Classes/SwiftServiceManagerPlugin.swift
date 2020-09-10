import Flutter
import UIKit

public class SwiftServiceManagerPlugin: NSObject, FlutterPlugin {
    
    var bluetoothStateStreamHandler: BluetoothStateStreamHandler?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        
        let methodChannel = FlutterMethodChannel(name: "flutter.baseflow.com/service_manager/methods", binaryMessenger: registrar.messenger())
        
        let instance = SwiftServiceManagerPlugin()
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
        
        instance.bluetoothStateStreamHandler = BluetoothStateStreamHandler();
        
        let eventChannel = FlutterEventChannel(name: "flutter.baseflow.com/service_manager/events/bluetooth", binaryMessenger: registrar.messenger())
        eventChannel.setStreamHandler(instance.bluetoothStateStreamHandler);
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }

}


