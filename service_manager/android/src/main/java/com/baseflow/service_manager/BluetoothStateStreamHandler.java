package com.baseflow.service_manager;

import android.bluetooth.BluetoothAdapter;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;

import io.flutter.plugin.common.EventChannel;

class BluetoothStateStreamHandler implements EventChannel.StreamHandler {

    private final ServiceManager serviceManager;
    private final Context applicationContext;

    private BroadcastReceiver stateReceiver;
    private EventChannel.EventSink eventSink;

    public BluetoothStateStreamHandler(ServiceManager serviceManager, Context applicationContext) {

        this.serviceManager = serviceManager;
        this.applicationContext = applicationContext;

        stateReceiver = new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                if (eventSink == null) {
                    return;
                }

                final int state = intent.getIntExtra(BluetoothAdapter.EXTRA_STATE, -1);
                switch (state) {
                    case BluetoothAdapter.STATE_CONNECTED:
                        //eventSink.success(BluetoothAdapter.STATE_CONNECTED);
                        break;
                    case BluetoothAdapter.STATE_CONNECTING:
                        //eventSink.success(BluetoothAdapter.STATE_CONNECTING);
                        break;
                    case BluetoothAdapter.STATE_DISCONNECTED:
                        //eventSink.success(BluetoothAdapter.STATE_DISCONNECTED);
                        break;
                    case BluetoothAdapter.STATE_DISCONNECTING:
                        //eventSink.success(BluetoothAdapter.STATE_DISCONNECTING);
                        break;
                    case BluetoothAdapter.STATE_OFF:
                        Log.d("STATE OFF", BluetoothState.OFF.toString());
                        eventSink.success(BluetoothState.OFF.ordinal());
                        break;
                    case BluetoothAdapter.STATE_ON:
                        Log.d("STATE OFF", BluetoothState.ON.toString());
                        eventSink.success(BluetoothState.ON.ordinal());
                        break;
                    case BluetoothAdapter.STATE_TURNING_OFF:
                        //eventSink.success(BluetoothAdapter.STATE_TURNING_OFF);
                        break;
                    case BluetoothAdapter.STATE_TURNING_ON:
                        //eventSink.success(BluetoothAdapter.STATE_TURNING_ON);
                        break;
                    default:
                        break;
                }
            }
        };
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink = events;
        applicationContext.registerReceiver(stateReceiver, new IntentFilter(BluetoothAdapter.ACTION_STATE_CHANGED));
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
        applicationContext.unregisterReceiver(stateReceiver);
    }
}
