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
    _isBluetoothEnabled();
  }

  Future<void> _isBluetoothEnabled() async {
    bool bluetoothEnabled = await isBluetoothEnabled();

    setState(() {
      _bluetoothEnabled = bluetoothEnabled;
    });
  }

  Future<void> _askForBluetoothPermission() async {
    bool wasBluetoothEnabled = await askForBluetoothPermission();

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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 32),
            ),
            Center(
              child: RaisedButton(
                child: Text(
                  _bluetoothEnabled ? 'Bluetooth enabled' : 'Enable bluetooth',
                ),
                onPressed:
                    _bluetoothEnabled ? null : _askForBluetoothPermission,
              ),
            ),
          ],
        ));
  }
}
