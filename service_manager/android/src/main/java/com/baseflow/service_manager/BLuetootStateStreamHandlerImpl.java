package com.baseflow.service_manager;

import android.bluetooth.BluetoothAdapter;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;

import io.flutter.plugin.common.EventChannel;

public class BLuetootStateStreamHandlerImpl implements EventChannel.StreamHandler {

    private final ServiceManager serviceManager;
    private final Context applicationContext;

    private BroadcastReceiver stateReceiver;
    private EventChannel.EventSink eventSink;

    public BLuetootStateStreamHandlerImpl(ServiceManager serviceManager, Context applicationContext) {

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
                    case BluetoothAdapter.STATE_OFF:
                        eventSink.success(BluetoothAdapter.STATE_OFF);
                        break;
                    case BluetoothAdapter.STATE_ON:
                        eventSink.success(BluetoothAdapter.STATE_ON);
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
