import Foundation
import CoreBluetooth

public class BluetoothStateStreamHandler: NSObject, CBCentralManagerDelegate, FlutterStreamHandler {
    
    var centralManager: CBCentralManager!
    var bluetoothStateSink: FlutterEventSink?
    
    override init() {
        super.init();
        self.centralManager = CBCentralManager(delegate: self, queue: nil);
    }
    
    public func centralManagerDidUpdateState(_ central: CBCentralManager) {
           switch central.state {
             case .unknown:
                self.bluetoothStateSink?(BluetoothState.UNKNOWN.rawValue);
             case .poweredOff:
               print("central.state is .poweredOff")
                self.bluetoothStateSink?(BluetoothState.OFF.rawValue);
             case .poweredOn:
                print("central.state is .poweredOn")
                self.bluetoothStateSink?(BluetoothState.ON.rawValue);
           @unknown default:
            self.bluetoothStateSink?(BluetoothState.UNKNOWN.rawValue);
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.bluetoothStateSink = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.bluetoothStateSink = nil
        return nil
    }
}

