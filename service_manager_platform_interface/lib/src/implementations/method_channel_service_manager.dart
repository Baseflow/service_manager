import 'package:flutter/services.dart';

import '../../service_manager_platform_interface.dart';

class MethodChannelServiceManager extends ServiceManagerPlatform {

  MethodChannel methodChannel = MethodChannel('flutter.baseflow.com/service_manager');

}