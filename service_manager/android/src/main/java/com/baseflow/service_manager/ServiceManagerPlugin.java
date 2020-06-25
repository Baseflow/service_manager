package com.baseflow.service_manager;

import android.app.Activity;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

@FunctionalInterface
interface ActivityRegistry {
    void addListener(PluginRegistry.ActivityResultListener handler);
}

@FunctionalInterface
interface SuccessCallback {
    void onSuccess(boolean result);
}

public class ServiceManagerPlugin implements FlutterPlugin, ActivityAware {

    private MethodChannel methodChannel;
    @Nullable
    private MethodCallHandlerImpl methodCallHandler;

    public static void registerWith(Registrar registrar) {
        final ServiceManagerPlugin plugin = new ServiceManagerPlugin();
        plugin.startListening(registrar.messenger());

        if (registrar.activeContext() instanceof Activity) {
            plugin.startListeningToActivity(
                    registrar.activity(),
                    registrar::addActivityResultListener
            );
        }
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        startListening(
                binding.getBinaryMessenger()
        );
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        stopListening();
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        startListeningToActivity(
                binding.getActivity(),
                binding::addActivityResultListener
        );
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        stopListeningToActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    private void startListening(BinaryMessenger messenger) {
        methodChannel = new MethodChannel(messenger, "flutter.baseflow.com/service_manager");
        methodCallHandler = new MethodCallHandlerImpl(new ServiceManager());
        methodChannel.setMethodCallHandler(methodCallHandler);
    }

    private void stopListening() {
        methodChannel.setMethodCallHandler(null);
        methodChannel = null;
        methodCallHandler = null;
    }

    private void startListeningToActivity(
            Activity activity,
            ActivityRegistry activityRegistry
    ) {
        if (methodCallHandler != null) {
            methodCallHandler.setActivity(activity);
            methodCallHandler.setActivityRegistry(activityRegistry);
        }
    }

    private void stopListeningToActivity() {
        if (methodCallHandler != null) {
            methodCallHandler.setActivity(null);
            methodCallHandler.setActivityRegistry(null);
        }
    }
}
