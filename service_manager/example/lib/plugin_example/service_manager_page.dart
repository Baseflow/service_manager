import 'dart:io';

import 'package:flutter/material.dart';
import 'package:service_manager/service_manager.dart';
import 'package:service_manager_example/template/globals.dart';

class ServiceManagerWidget extends StatefulWidget {
  @override
  _ServiceManagerWidgetState createState() => _ServiceManagerWidgetState();
}

class _ServiceManagerWidgetState extends State<ServiceManagerWidget> {
  var _bluetoothState = BluetoothState.UNKNOWN;

  @override
  void initState() {
    super.initState();
    _initBluetoothState();
  }

  Future<void> _initBluetoothState() async {
    bool bluetoothEnabled = await ServiceManager.isBluetoothEnabled();

    setState(() {
      _bluetoothState =
          bluetoothEnabled ? BluetoothState.ON : BluetoothState.OFF;
    });

    ServiceManager.state.listen((state) {
      setState(() {
        _bluetoothState = state;
      });
    });
  }

  Future<void> _askForBluetoothPermission() async {
    bool wasBluetoothEnabled = await ServiceManager.askForBluetoothPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            Globals.defaultHorizontalPadding + Globals.defaultVerticalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_bluetoothState.toString(),
                style: Theme.of(context).textTheme.bodyText1),
            Padding(
              padding: EdgeInsets.only(top: 32),
            ),
            Center(
              child: ElevatedButton(
                child: Text('Enable bluetooth'),
                onPressed:
                    Platform.isAndroid && _bluetoothState != BluetoothState.ON
                        ? _askForBluetoothPermission
                        : null,
              ),
            ),
          ],
        ));
  }
}
