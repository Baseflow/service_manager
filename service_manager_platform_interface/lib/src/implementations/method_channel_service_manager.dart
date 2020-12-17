import 'package:flutter/services.dart';
import '../../service_manager_platform_interface.dart';
import '../enums/enums.dart';

class MethodChannelServiceManager extends ServiceManagerPlatform {
  MethodChannel methodChannel =
      MethodChannel('flutter.baseflow.com/service_manager/methods');
  EventChannel bluetoothStateEventChannel =
      EventChannel('flutter.baseflow.com/service_manager/state/bluetooth');

  @override
  Future<bool> isBluetoothEnabled() async {
    final bool isBluetoothEnabled =
        await methodChannel.invokeMethod('isBluetoothEnabled');
    return isBluetoothEnabled;
  }

  @override
  Future<bool> askForBluetoothPermission() async {
    final bool wasBluetoothEnabled =
        await methodChannel.invokeMethod('askForBluetoothPermission');
    return wasBluetoothEnabled;
  }

  @override
  Stream<BluetoothState> get state {
    return bluetoothStateEventChannel
        .receiveBroadcastStream()
        .cast<int>()
        .map((state) {
      switch (state) {
        case 0:
          return BluetoothState.UNKNOWN;
        case 1:
          return BluetoothState.OFF;
        case 2:
          return BluetoothState.ON;
        default:
          return BluetoothState.UNKNOWN;
      }
    });
  }
}
