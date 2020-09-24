import 'dart:io';

import 'package:flutter/material.dart';
import 'package:service_manager/service_manager.dart';
import 'package:service_manager_example/template/globals.dart';

class ServiceManagerWidget extends StatefulWidget {
  @override
  _ServiceManagerWidgetState createState() => _ServiceManagerWidgetState();
}

class _ServiceManagerWidgetState extends State<ServiceManagerWidget> {
  bool _bluetoothEnabled = false;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    bool bluetoothEnabled = await ServiceManager.isBluetoothEnabled();

    setState(() {
      _bluetoothEnabled = bluetoothEnabled;
    });

    ServiceManager.state.listen((state) {
      switch (state) {
        case BluetoothState.OFF:
          setState(() {
            _bluetoothEnabled = false;
          });
          break;
        case BluetoothState.ON:
          setState(() {
            _bluetoothEnabled = true;
          });
          break;
        default:
          break;
      }
    });
  }

  Future<void> _askForBluetoothPermission() async {
    bool wasBluetoothEnabled = await ServiceManager.askForBluetoothPermission();

    if (!_bluetoothEnabled && wasBluetoothEnabled) {
      setState(() {
        _bluetoothEnabled = true;
      });
    }
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
            Text(
              'Bluetooth enabled: $_bluetoothEnabled',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Padding(
              padding: EdgeInsets.only(top: 32),
            ),
            Center(
              child: RaisedButton(
                child: Text('Enable bluetooth'),
                onPressed:
                    !_bluetoothEnabled && Platform.isAndroid ? _askForBluetoothPermission : null,
              ),
            ),
          ],
        ));
  }
}
