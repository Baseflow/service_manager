import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'enums/enums.dart';
import 'implementations/method_channel_service_manager.dart';

abstract class ServiceManagerPlatform extends PlatformInterface {
  ServiceManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static ServiceManagerPlatform _instance = MethodChannelServiceManager();

  static ServiceManagerPlatform get instance => _instance;

  static set instance(ServiceManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isBluetoothEnabled() {
    throw UnimplementedError(
        'isBluetoothEnabled() has not yet been implemented');
  }

  Future<bool> askForBluetoothPermission() {
    throw UnimplementedError(
        'askForBluetoothPermission() has not yet been implemented');
  }

  Stream<BluetoothState> get state {
    throw UnimplementedError(
        'state() has not yet been implemented');
  }
}
