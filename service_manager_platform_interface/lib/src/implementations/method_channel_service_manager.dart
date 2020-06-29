import 'package:flutter/services.dart';

import '../../service_manager_platform_interface.dart';

class MethodChannelServiceManager extends ServiceManagerPlatform {

  MethodChannel methodChannel = MethodChannel('flutter.baseflow.com/service_manager/methods');
  EventChannel eventChannel = EventChannel('flutter.baseflow.com/service_manager/events');

  @override
  Future<bool> isBluetoothEnabled() async {
    final bool isBluetoothEnabled = await methodChannel.invokeMethod('isBluetoothEnabled');
    return isBluetoothEnabled;
  }

  @override
  Future<bool> askForBluetoothPermission() async {
    final bool wasBluetoothEnabled = await methodChannel.invokeMethod('askForBluetoothPermission');
    return wasBluetoothEnabled;
  }

  @override
  Stream<dynamic> get state {
    return eventChannel.receiveBroadcastStream();
  }

}