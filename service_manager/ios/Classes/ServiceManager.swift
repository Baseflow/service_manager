import Foundation
import CoreBluetooth

class ServiceManager {
    
    var centralManager = CBCentralManager();
    
    func isBluetoothEnabled() -> Bool {
        let bluetoothState = centralManager.state.rawValue;
        if (bluetoothState == 5) {
            return true;
        } else {
            return false;
        }
    }
}
