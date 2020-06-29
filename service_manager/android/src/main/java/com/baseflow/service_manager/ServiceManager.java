package com.baseflow.service_manager;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.content.BroadcastReceiver;
import android.content.Intent;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;

class ServiceManager {

    private static final int REQUEST_CODE_BLUETOOTH = 1;

    void isBluetoothEnabled(SuccessCallback successCallback) {
        final BluetoothAdapter bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        final boolean isBluetoothEnabled = bluetoothAdapter.isEnabled();
        successCallback.onSuccess(isBluetoothEnabled);
    }

    void askForBluetoothPermission(Activity activity, ActivityRegistry activityRegistry, SuccessCallback successCallback) {
        activityRegistry.addListener(new BluetoothResultListener(successCallback));

        Intent enableBtIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
        activity.startActivityForResult(enableBtIntent, REQUEST_CODE_BLUETOOTH);
    }

    class BluetoothResultListener implements PluginRegistry.ActivityResultListener {

        boolean alreadyCalled = false;

        private final SuccessCallback successCallback;

        BluetoothResultListener(SuccessCallback successCallback) {
            this.successCallback = successCallback;
        }

        @Override
        public boolean onActivityResult(int requestCode, int resultCode, Intent intent) {

            if (alreadyCalled) return false;
            alreadyCalled = true;

            if (requestCode != REQUEST_CODE_BLUETOOTH) return false;

            boolean wasBluetoothEnabled = resultCode == Activity.RESULT_OK;
            successCallback.onSuccess(wasBluetoothEnabled);
            return wasBluetoothEnabled;
        }
    }
}