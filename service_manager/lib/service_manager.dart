import 'package:service_manager_platform_interface/service_manager_platform_interface.dart';
export 'package:service_manager_platform_interface/src/enums/enums.dart';

class ServiceManager {
  static Future<bool> isBluetoothEnabled() =>
      ServiceManagerPlatform.instance.isBluetoothEnabled();

  static Future<bool> askForBluetoothPermission() =>
      ServiceManagerPlatform.instance.askForBluetoothPermission();

  static Stream<BluetoothState> get state => ServiceManagerPlatform.instance.state;
}
