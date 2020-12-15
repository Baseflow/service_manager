import 'dart:io';

import 'package:flutter/material.dart';
import 'package:service_manager/service_manager.dart';
import 'package:service_manager_example/template/globals.dart';

class ServiceManagerWidget extends StatefulWidget {
  @override
  _ServiceManagerWidgetState createState() => _ServiceManagerWidgetState();
}

class _ServiceManagerWidgetState extends State<ServiceManagerWidget> {
  //bool _bluetoothEnabled = false;
  var _bluetoothState;

  @override
  void initState() {
    super.initState();
    _initBluetoothState();
  }

  Future<void> _initBluetoothState() async {
    ServiceManager.state.listen((state) {
      setState(() {
         _bluetoothState = state;
      });
    });
  }

  Future<void> _askForBluetoothPermission() async {
    bool wasBluetoothEnabled = await ServiceManager.askForBluetoothPermission();

    // if (!_bluetoothEnabled && wasBluetoothEnabled) {
    //   setState(() {
    //     _bluetoothEnabled = true;
    //   });
    // }
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
              'Bluetooth state: ' + _bluetoothState.toString(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Padding(
              padding: EdgeInsets.only(top: 32),
            ),
            Center(
              child: RaisedButton(
                child: Text('Enable bluetooth'),
                onPressed:
                    Platform.isAndroid ? _askForBluetoothPermission : null,
              ),
            ),
          ],
        ));
  }
}
