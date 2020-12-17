import Foundation
import CoreBluetooth

class ServiceManager {
    
    var centralManager = CBCentralManager();
    
    func isBluetoothEnabled() -> Bool {
        return (self.centralManager.state == .poweredOn) ? true : false
    }
}
