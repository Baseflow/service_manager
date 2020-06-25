import 'package:service_manager_platform_interface/service_manager_platform_interface.dart';

Future<bool> isBluetoothEnabled() => ServiceManagerPlatform.instance.isBluetoothEnabled();

Future<bool> askForBluetoothPermission() => ServiceManagerPlatform.instance.askForBluetoothPermission();