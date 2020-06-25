import 'dart:core';

import 'package:flutter/material.dart';
import 'package:service_manager_example/plugin_example/service_manager_page.dart';

import 'info_page.dart';

class Globals {
  static const String pluginName = 'Service Manager';
  static const String githubURL =
      'https://https://github.com/Baseflow/service_manager';
  static const String baseflowURL = 'https://baseflow.com';
  static const String pubDevURL = 'https://pub.dev/packages/service_manager';

  static const EdgeInsets defaultHorizontalPadding =
      EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets defaultVerticalPadding =
      EdgeInsets.symmetric(vertical: 24);

  static final icons = [
    Icons.bluetooth,
    Icons.info_outline,
  ];

  static final pages = [
    ServiceManagerWidget(),
    InfoPage(),
  ];
}
