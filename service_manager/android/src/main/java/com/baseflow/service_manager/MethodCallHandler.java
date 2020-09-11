package com.baseflow.service_manager;

import android.app.Activity;

import androidx.annotation.Nullable;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;

final class MethodCallHandlerImpl implements MethodChannel.MethodCallHandler {

    private final ServiceManager serviceManager;

    MethodCallHandlerImpl(ServiceManager serviceManager) {
        this.serviceManager = serviceManager;
    }

    @Nullable
    private Activity activity;

    @Nullable
    private ActivityRegistry activityRegistry;

    public void setActivity(@Nullable Activity activity) {
        this.activity = activity;
    }

    public void setActivityRegistry(@Nullable ActivityRegistry activityRegistry) {
        this.activityRegistry = activityRegistry;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {

        switch (call.method) {
            case "isBluetoothEnabled":
                serviceManager.isBluetoothEnabled(result::success);
                break;
            case "askForBluetoothPermission":
                serviceManager.askForBluetoothPermission(activity, activityRegistry, result::success);
                break;
            default:
                result.notImplemented();
                break;
        }
    }
}